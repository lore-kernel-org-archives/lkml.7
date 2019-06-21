Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148C5C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF036208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561134099;
	bh=VQ1gK6vkj14oTbza27TvV5pVzRXxHavJndzesvK8YsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZI0CpvIKEZzLqwzb3oOObwTcHrdjRlO8auEcjFyRhw7vJOC0zLYv3q8/asLNaUWs/
	 R8tBySO/DDHS76HzACUEFj9N4LyATqKXkL/CpUAxyd3CZu56VwdSrU+st/wfyBegRi
	 ZaNLA/QCwKQLZ78uqWMUVZCqJL7IC5EZMBuojb/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfFUQVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:53444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfFUQVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:21:35 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85693208C3;
        Fri, 21 Jun 2019 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561134095;
        bh=VQ1gK6vkj14oTbza27TvV5pVzRXxHavJndzesvK8YsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8ShRieLALbliX4bD80CpehWcw480E8W9D7C+4nhiShZAIKKUYk9bPeiQnxjXoMdt
         +RBcA9bZ408CDP4RRZoOnzU+OhZNbYECMpnLOIzC7FFzynBmo4S8zMQcsbAVG4bq0n
         dKe6RCru5rgJ4vNRQJoK+/YEh1U4TnPhpDtn7dWk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 4/4] drm/lima: Reduce the amount of logs on deferred probe of clocks and reset controller
Date:   Fri, 21 Jun 2019 18:21:17 +0200
Message-Id: <20190621162117.22533-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190621162117.22533-1-krzk@kernel.org>
References: <20190621162117.22533-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to print deferred probe messages as errors.  Adjust
the printks for error paths of obtaining clocks and reset controller.
This removes the error message of lima_clk_init() call in favor or
specific failure messages inside.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. New patch
---
 drivers/gpu/drm/lima/lima_device.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
index 9a6cd879bcb1..d86b8d81a483 100644
--- a/drivers/gpu/drm/lima/lima_device.c
+++ b/drivers/gpu/drm/lima/lima_device.c
@@ -84,14 +84,16 @@ static int lima_clk_init(struct lima_device *dev)
 	dev->clk_bus = devm_clk_get(dev->dev, "bus");
 	if (IS_ERR(dev->clk_bus)) {
 		err = PTR_ERR(dev->clk_bus);
-		dev_err(dev->dev, "get bus clk failed %d\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev->dev, "get bus clk failed %d\n", err);
 		return err;
 	}
 
 	dev->clk_gpu = devm_clk_get(dev->dev, "core");
 	if (IS_ERR(dev->clk_gpu)) {
 		err = PTR_ERR(dev->clk_gpu);
-		dev_err(dev->dev, "get core clk failed %d\n", err);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev->dev, "get core clk failed %d\n", err);
 		return err;
 	}
 
@@ -106,11 +108,17 @@ static int lima_clk_init(struct lima_device *dev)
 	dev->reset = devm_reset_control_get_optional(dev->dev, NULL);
 	if (IS_ERR(dev->reset)) {
 		err = PTR_ERR(dev->reset);
+		if (err != -EPROBE_DEFER)
+			dev_err(dev->dev, "get reset controller failed %d\n",
+				err);
 		goto error_out1;
 	} else if (dev->reset != NULL) {
 		err = reset_control_deassert(dev->reset);
-		if (err)
+		if (err) {
+			dev_err(dev->dev,
+				"reset controller deassert failed %d\n", err);
 			goto error_out1;
+		}
 	}
 
 	return 0;
@@ -287,10 +295,8 @@ int lima_device_init(struct lima_device *ldev)
 	dma_set_coherent_mask(ldev->dev, DMA_BIT_MASK(32));
 
 	err = lima_clk_init(ldev);
-	if (err) {
-		dev_err(ldev->dev, "clk init fail %d\n", err);
+	if (err)
 		return err;
-	}
 
 	err = lima_regulator_init(ldev);
 	if (err)
-- 
2.17.1

