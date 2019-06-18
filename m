Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB266C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B812E21479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 18:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560884116;
	bh=8cLWYoNLq6kgCHovpl/8qKrK74KrIpzZRxYpEDQZSyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gTQUW7wQqi7MATZan/OJykeHRJ0tNdk5FJ4E9yvMOEspQso240C3nmkGCIDfZeFK3
	 L4CCzJi0q+XCarMDmELxHCoeMJLsKm2qMPKFFoj8oseE7cGAY1fy4g2cpM3LmHVKUl
	 LIBEWRHWmSF0BVDjx3xa2DL8oXCZ9oWCJ+37OwAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730473AbfFRSzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 14:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbfFRSzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 14:55:14 -0400
Received: from localhost.localdomain (unknown [194.230.155.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744E42147A;
        Tue, 18 Jun 2019 18:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560884113;
        bh=8cLWYoNLq6kgCHovpl/8qKrK74KrIpzZRxYpEDQZSyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uEU6mQQ5Yx2q+R8wLzNkID7Pf8cVpPCcB0w1bJ4UMN+ewK9pBjfLtHapbe6ByzEoZ
         7gzkgBP+svY8+UkG/HP37cBanmzAniyG4Rt1Zl1c+OAqSEBRpHSrBVn6nQgQCB1iLm
         jlPXgHQR75IG2AQXdCVz6AHPXeyfdvsp8ei//JNA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/3] drm/lima: Reduce the amount of logs on deferred probe
Date:   Tue, 18 Jun 2019 20:55:01 +0200
Message-Id: <20190618185502.3839-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190618185502.3839-1-krzk@kernel.org>
References: <20190618185502.3839-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point to print deferred probe (and its failures to get
resources) as an error.  For example getting a regulator causes three
unneeded error messages:

    lima 13000000.gpu: failed to get regulator: -517
    lima 13000000.gpu: regulator init fail -517
    lima 13000000.gpu: Fatal error during GPU init

Also do not print clock rates before the initialization finishes
because they will be duplicated after deferral.  Each probe step already
prints error so remove the final error message "Fatal error during GPU
init".

In case of multiple probe tries this would pollute the dmesg.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/lima/lima_device.c | 17 ++++++-----------
 drivers/gpu/drm/lima/lima_drv.c    |  4 +---
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_device.c b/drivers/gpu/drm/lima/lima_device.c
index 570d0e93f9a9..bb2eaa4f370e 100644
--- a/drivers/gpu/drm/lima/lima_device.c
+++ b/drivers/gpu/drm/lima/lima_device.c
@@ -80,7 +80,6 @@ const char *lima_ip_name(struct lima_ip *ip)
 static int lima_clk_init(struct lima_device *dev)
 {
 	int err;
-	unsigned long bus_rate, gpu_rate;
 
 	dev->clk_bus = devm_clk_get(dev->dev, "bus");
 	if (IS_ERR(dev->clk_bus)) {
@@ -94,12 +93,6 @@ static int lima_clk_init(struct lima_device *dev)
 		return PTR_ERR(dev->clk_gpu);
 	}
 
-	bus_rate = clk_get_rate(dev->clk_bus);
-	dev_info(dev->dev, "bus rate = %lu\n", bus_rate);
-
-	gpu_rate = clk_get_rate(dev->clk_gpu);
-	dev_info(dev->dev, "mod rate = %lu", gpu_rate);
-
 	err = clk_prepare_enable(dev->clk_bus);
 	if (err)
 		return err;
@@ -145,7 +138,8 @@ static int lima_regulator_init(struct lima_device *dev)
 		dev->regulator = NULL;
 		if (ret == -ENODEV)
 			return 0;
-		dev_err(dev->dev, "failed to get regulator: %d\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev->dev, "failed to get regulator: %d\n", ret);
 		return ret;
 	}
 
@@ -297,10 +291,8 @@ int lima_device_init(struct lima_device *ldev)
 	}
 
 	err = lima_regulator_init(ldev);
-	if (err) {
-		dev_err(ldev->dev, "regulator init fail %d\n", err);
+	if (err)
 		goto err_out0;
-	}
 
 	ldev->empty_vm = lima_vm_create(ldev);
 	if (!ldev->empty_vm) {
@@ -343,6 +335,9 @@ int lima_device_init(struct lima_device *ldev)
 	if (err)
 		goto err_out5;
 
+	dev_info(ldev->dev, "bus rate = %lu\n", clk_get_rate(ldev->clk_bus));
+	dev_info(ldev->dev, "mod rate = %lu", clk_get_rate(ldev->clk_gpu));
+
 	return 0;
 
 err_out5:
diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index b29c26cd13b2..cebc44592e47 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -307,10 +307,8 @@ static int lima_pdev_probe(struct platform_device *pdev)
 	ldev->ddev = ddev;
 
 	err = lima_device_init(ldev);
-	if (err) {
-		dev_err(&pdev->dev, "Fatal error during GPU init\n");
+	if (err)
 		goto err_out1;
-	}
 
 	/*
 	 * Register the DRM device with the core and the connectors with
-- 
2.17.1

