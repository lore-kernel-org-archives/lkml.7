Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C3EC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B15220B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 17:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569258752;
	bh=JprDp85wLb3vRGCsbBm49LmYNZ/PX4LzV9qCMprV4UQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GB4IpmBfp+gUVoQlvyfUqJK64eqeDvqLqcmRnrAcRJnJd7/j5n9f1HMlz5my4ry3k
	 ldo4hhYwaHrLudlp349yMD7RKj5ancCWMBaMRfla44AeQrzkoGLMnmpoipY9w9NrnB
	 50K/w7ZVr6P0RoFW3olzJNq1JKaa0jMPqh0akqgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732932AbfIWRMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 13:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbfIWRMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 13:12:31 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2E020820;
        Mon, 23 Sep 2019 17:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569258750;
        bh=JprDp85wLb3vRGCsbBm49LmYNZ/PX4LzV9qCMprV4UQ=;
        h=From:To:Cc:Subject:Date:From;
        b=zYbGyJry8uCnv98oTYdprtmrdt3r5AWPNg6Qhh7wWlAViW9FwSKHFyFZ/7Napvjn5
         TjYtACSclcp4oAY9NvcCvQKuW/fMHaFPIWVyx/mQx0j0Wa73ZOY8tcBU6Ka9/BRIOq
         JPPEh0i+dG2LPA3JUQSQuAQ9Y7I0TMVrdCNkfIZU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Steven Price <steven.price@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] drm/panfrost: Reduce the amount of logs on deferred probe
Date:   Mon, 23 Sep 2019 19:12:22 +0200
Message-Id: <20190923171222.9256-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to print deferred probe (and its failures to get
resources) as an error.  Also there is no need to print regulator errors
twice.

In case of multiple probe tries this would pollute the dmesg.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Remove second error message from calling panfrost_regulator_init().
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index 46b0b02e4289..287c6ba314d9 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -95,7 +95,9 @@ static int panfrost_regulator_init(struct panfrost_device *pfdev)
 		pfdev->regulator = NULL;
 		if (ret == -ENODEV)
 			return 0;
-		dev_err(pfdev->dev, "failed to get regulator: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(pfdev->dev, "failed to get regulator: %d\n",
+				ret);
 		return ret;
 	}
 
@@ -133,10 +135,8 @@ int panfrost_device_init(struct panfrost_device *pfdev)
 	}
 
 	err = panfrost_regulator_init(pfdev);
-	if (err) {
-		dev_err(pfdev->dev, "regulator init failed %d\n", err);
+	if (err)
 		goto err_out0;
-	}
 
 	err = panfrost_reset_init(pfdev);
 	if (err) {
-- 
2.17.1

