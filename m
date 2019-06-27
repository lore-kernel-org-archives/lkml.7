Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99933C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6517420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="kByL8G0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfF0SVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:21:24 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46260 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF0SVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1561659683; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:references; bh=hxYTvnQO/eZbO0T4ZUdUxSRmfpX1wgQggO720gFQx6M=;
        b=kByL8G0YFql9ZKH6WiEaGOaw+1sMNHBgy9YTjP+eh3g32qZmd7N2ySNirSap30FnNXuGfC
        qY4HCO4iEy9lG5cU1XYddxBfE3YA9O6rnp3KpiAtzjVWRhvX80TCaxAjhQ8cwllJp9OwnU
        cOAMztb2EctpEZVeLcqrSyOSIyKkHmw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, od@zcrc.me,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/3] DRM: ingenic: Use devm_platform_ioremap_resource
Date:   Thu, 27 Jun 2019 20:21:12 +0200
Message-Id: <20190627182114.27299-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify a bit the probe function by using the newly introduced
devm_platform_ioremap_resource(), instead of having to call
platform_get_resource() followed by devm_ioremap_resource().

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index a069579ca749..02c4788ef1c7 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -580,7 +580,6 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	struct drm_bridge *bridge;
 	struct drm_panel *panel;
 	struct drm_device *drm;
-	struct resource *mem;
 	void __iomem *base;
 	long parent_rate;
 	int ret, irq;
@@ -614,8 +613,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	drm->mode_config.max_height = 600;
 	drm->mode_config.funcs = &ingenic_drm_mode_config_funcs;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(dev, mem);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base)) {
 		dev_err(dev, "Failed to get memory resource");
 		return PTR_ERR(base);
-- 
2.21.0.593.g511ec345e18

