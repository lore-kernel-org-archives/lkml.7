Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9ABC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC4DE20637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="iFutjBtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfLJOmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:42:20 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:50064 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfLJOmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:42:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575988921; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oQu5Z2SlkF9q3Br2z6T8KM+2jF4TY4KCeVIgXcUDL6Q=;
        b=iFutjBtn9TKDjer0AbMJbWixueQYB/Ct/FdSeDbvMmmNe7vzs8Jbi8Loy14o/DQ6GQG9g7
        cWr3cvXjv8WGPW1SYXO/4RGU355S0hE3tdfRXyf2bEziC7ue1f3lxhc8WqzRt5huzwO9k9
        /5FH0yDViG5wd04c7h3uEX4cSSd+qTU=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 4/6] gpu/drm: ingenic: Set max FB height to 4095
Date:   Tue, 10 Dec 2019 15:41:40 +0100
Message-Id: <20191210144142.33143-4-paul@crapouillou.net>
In-Reply-To: <20191210144142.33143-1-paul@crapouillou.net>
References: <20191210144142.33143-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the LCD controller can effectively only support a maximum
resolution of 800x600, the framebuffer's height can be much higher,
since we can change the Y start offset.

v2: No change

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm.c b/drivers/gpu/drm/ingenic/ingenic-drm.c
index 8713f09df448..cef2f29a9d7a 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm.c
@@ -636,7 +636,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 	drm->mode_config.min_width = 0;
 	drm->mode_config.min_height = 0;
 	drm->mode_config.max_width = 800;
-	drm->mode_config.max_height = 600;
+	drm->mode_config.max_height = 4095;
 	drm->mode_config.funcs = &ingenic_drm_mode_config_funcs;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-- 
2.24.0

