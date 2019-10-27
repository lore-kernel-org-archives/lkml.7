Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC651CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 17:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8279F20679
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 17:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWPKYvPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfJ0Rcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 13:32:47 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43963 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfJ0Rcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 13:32:47 -0400
Received: by mail-il1-f193.google.com with SMTP id t5so5967345ilh.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2019 10:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/THBluCK4a0IYFuUyIU3vJcJ1O4y+B87o6Voa+J9XIQ=;
        b=ZWPKYvPbYBDdIJSfu5YyppHyQaRlcSw5idapnoCgxEOcGwePqoJIPQEjHI62ck0cQ7
         e6IZKSNWPOe1wpvhHn9g0acn1jmeBv7qkS+wjLYJnbDR5CBBE95OcSls/a7+OEcV5sKd
         Y+PeesFwmQ7OSN0aKD3rvW26UYbxu880wJBxhcnt1UCBazacbA6fbGSkKIx7o4YMogfV
         ivkQiuq1unCJtup2LtPFercUpPGAoLbTb3PXloOoiEJN2jT3HBP3fViCgj+q7fPBy9Fs
         nKs3ButM9wGbtLY0aKalybRBUBGRi/5cBngEuJOV9xWqTDGihPJtkmDCWVDMkljmgQRy
         E7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/THBluCK4a0IYFuUyIU3vJcJ1O4y+B87o6Voa+J9XIQ=;
        b=PRKOLROAzn0KiVCVlSWPl6TM/Hdmpi2hyEfli6sO8z8Pl7v1U7bz/m7XyUpbyy43x3
         8TUuinl52155LrmZPF6GbWZQMhhLaxFrPeLQcJtVTy8HE3JIV7U9D5AnfQ+xIf/4PjSK
         gLri1qULKFlA765jaUbFvixRAp85NrIP6FEMdDqkQlFzXXXEGW3lrp+CDq06MKs0xul+
         KG3tECa3xW/mnF9XrfWDw1eTs77r/SGUX77RquWkxabTjw29O1MNhbZ4469o8PERqn2p
         iDyrdeQsUupsGfvg1lZB5e4TW1bePxI/2vWiTdlbdVek8uXRTbXRWKnkmfKyKJ6GIIaS
         DyOQ==
X-Gm-Message-State: APjAAAW2q8UlszqnqhOVv8M56ElKBcLKevvUMToAIHC4gqYUNclTMhO9
        KmWgoRg6ekmvrI8Xt0+6PfQ=
X-Google-Smtp-Source: APXvYqw+eu2LqivL3BGcAfUb+Q0Ese3CVcbVz82roiTlWwTrVlRRUIQP7KRcO2KqF3jIial50+tN/g==
X-Received: by 2002:a92:190b:: with SMTP id 11mr16909100ilz.39.1572197565994;
        Sun, 27 Oct 2019 10:32:45 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id y5sm1196784ill.86.2019.10.27.10.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 10:32:45 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tinydrm: Fix memroy leak in hx8357d_probe
Date:   Sun, 27 Oct 2019 12:32:33 -0500
Message-Id: <20191027173234.6449-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of hx8357d_probe() the allocated memory for dbidev
is leaked when an error happens. Release dbidev if any of the  following
calls fail: devm_gpiod_get(), devm_of_find_backlight(),
mipi_dbi_spi_init(), mipi_dbi_init(), drm_dev_register().

Fixes: f300c86e33a6 ("drm: Add an hx8367d tinydrm driver.")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/tiny/hx8357d.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
index 9af8ff84974f..da5ec944f47e 100644
--- a/drivers/gpu/drm/tiny/hx8357d.c
+++ b/drivers/gpu/drm/tiny/hx8357d.c
@@ -232,44 +232,49 @@ static int hx8357d_probe(struct spi_device *spi)
 
 	drm = &dbidev->drm;
 	ret = devm_drm_dev_init(dev, drm, &hx8357d_driver);
-	if (ret) {
-		kfree(dbidev);
-		return ret;
-	}
+	if (ret)
+		goto free_dbidev;
 
 	drm_mode_config_init(drm);
 
 	dc = devm_gpiod_get(dev, "dc", GPIOD_OUT_LOW);
 	if (IS_ERR(dc)) {
 		DRM_DEV_ERROR(dev, "Failed to get gpio 'dc'\n");
-		return PTR_ERR(dc);
+		ret = PTR_ERR(dc);
+		goto free_dbidev;
 	}
 
 	dbidev->backlight = devm_of_find_backlight(dev);
-	if (IS_ERR(dbidev->backlight))
-		return PTR_ERR(dbidev->backlight);
+	if (IS_ERR(dbidev->backlight)) {
+		ret = PTR_ERR(dbidev->backlight);
+		goto free_dbidev;
+	}
 
 	device_property_read_u32(dev, "rotation", &rotation);
 
 	ret = mipi_dbi_spi_init(spi, &dbidev->dbi, dc);
 	if (ret)
-		return ret;
+		goto free_dbidev;
 
 	ret = mipi_dbi_dev_init(dbidev, &hx8357d_pipe_funcs, &yx350hv15_mode, rotation);
 	if (ret)
-		return ret;
+		goto free_dbidev;
 
 	drm_mode_config_reset(drm);
 
 	ret = drm_dev_register(drm, 0);
 	if (ret)
-		return ret;
+		goto free_dbidev;
 
 	spi_set_drvdata(spi, drm);
 
 	drm_fbdev_generic_setup(drm, 0);
 
 	return 0;
+
+free_dbidev:
+	kfree(dbidev);
+	return ret;
 }
 
 static int hx8357d_remove(struct spi_device *spi)
-- 
2.17.1

