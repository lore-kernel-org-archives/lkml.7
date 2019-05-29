Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B072C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE97E21721
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 10:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KrJR7S9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfE2K0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 06:26:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45350 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2K0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 06:26:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so1326776pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zkf9FoxdryyDt1X+5P+GJSoX1FiD3J3GXj2LP0N8rdU=;
        b=KrJR7S9O4TEFHPeGH3rkqlofANGLf5xPlPIkRdAwYAC4yHaXwn/r/L5YxrLyP6L7K5
         qaAvmgB0+oizqOfAJqwCXO6Bb570+HJHpI4ecYCXN0wEWCx0ClL1x6NMDWXAVOfvHBRR
         rfpWfc3r/oA8m007TQhh7sV5qE4QAleSuWEsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkf9FoxdryyDt1X+5P+GJSoX1FiD3J3GXj2LP0N8rdU=;
        b=LkPCpz7mU+F2gtsW1p7dFd2EhRW5uYfHNgnwR7+XTPCBIj6HmKimSIpSL3KnzB32lB
         opS7A5F7jkC24U83ltovZXjk39XewNS0NgvMcGcyhTmRN9zMIZQPOH1+4ziSKTG5uoMB
         JJHamO9N8+DHHmcWImxxJTWsGnse0BxVwx0wgnK4z2v22twWFi5VnB3/5rCkXzmFzKNc
         LInYXVp7cqdSOYLNiv/FS/X1QduA51rRCbWAg8+8DPGANAyXUNH93JlHX4Gov6vvFjTl
         ryQMMh8Oimcg7+6RcGUPoIiWE1v9Tsk2D4kESJnowiYcV7CxThjOZEopUb9F88WikC0V
         Jdvw==
X-Gm-Message-State: APjAAAUMSzTFOA0N4yA8+PPLRsSMCZqZqXxTG+JgBDuZYZNQa78Wxr8r
        JGnRRj+Xc9YGPDPn5mIJmae82g==
X-Google-Smtp-Source: APXvYqwnrc9pdx47YY9TRS/DoiPhrNWvI1W5hjidPKQ2diP8prk0BV504pPU4kJBaFleNW4weG407w==
X-Received: by 2002:a62:d244:: with SMTP id c65mr111971351pfg.173.1559125608082;
        Wed, 29 May 2019 03:26:48 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b852:bd51:9305:4261])
        by smtp.gmail.com with ESMTPSA id e12sm18992183pfl.122.2019.05.29.03.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 May 2019 03:26:47 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] drm: mediatek: call drm_atomic_helper_shutdown() when unbinding driver
Date:   Wed, 29 May 2019 18:25:54 +0800
Message-Id: <20190529102555.251579-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529102555.251579-1-hsinyi@chromium.org>
References: <20190529102555.251579-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shutdown all CRTC when unbinding drm driver.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index e7362bdafa82..8718d123ccaa 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -311,6 +311,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 static void mtk_drm_kms_deinit(struct drm_device *drm)
 {
 	drm_kms_helper_poll_fini(drm);
+	drm_atomic_helper_shutdown(drm);
 
 	component_unbind_all(drm->dev, drm);
 	drm_mode_config_cleanup(drm);
-- 
2.20.1

