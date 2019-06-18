Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F61AC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3951D206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560884119;
	bh=jnHY4wAAX194MRXM1kpGV2/DxUzOkoaBjDrIsGD8q4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HWh302ia2jwHBGceLkWibzeDIuePQIIxtaillvnwa3hoavyEL3VhbZ6EeMsVWBchs
	 SdO2uxlrIkn6YamQ3mFgQtzLTetMI5eZsM2W2jsrs5jNE5kVsu+enXGfSB/oHSRWmr
	 Lw6eHhu1XrQOwSBf7cnPhMhEBkmSHwwA+owI8V5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbfFRSzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:55:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:36616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbfFRSzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:55:16 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFADE206BA;
        Tue, 18 Jun 2019 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560884115;
        bh=jnHY4wAAX194MRXM1kpGV2/DxUzOkoaBjDrIsGD8q4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zoHDJ6gP2eOG45PXp/OGjeFUI5zule1UfgoqVnGBP4SNG0NJG1YRQzkh7V7HWI9/o
         fD5OSQxucoddbTITn0wzfGC5SozsIHbqGxutWjNdqhCBoq0V20U4pPui6askLr2p0j
         k0IoIHUyRBOhPMwgR+UPyRw+YR4JV5XHqrtmrMNY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] drm/panfrost: Reduce the amount of logs on deferred probe
Date:   Tue, 18 Jun 2019 20:55:02 +0200
Message-Id: <20190618185502.3839-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618185502.3839-1-krzk@kernel.org>
References: <20190618185502.3839-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to print deferred probe (and its failures to get
resources) as an error.

In case of multiple probe tries this would pollute the dmesg.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/panfrost/panfrost_device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index ccb8eb2a518c..858582a60090 100644
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
 
-- 
2.17.1

