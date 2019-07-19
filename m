Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B7DC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EA921849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsYFYhi5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfGSKco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:32:44 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43095 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfGSKco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:32:44 -0400
Received: by mail-pl1-f196.google.com with SMTP id 4so8454141pld.10;
        Fri, 19 Jul 2019 03:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8qhnRgEZihilSgw7kKeGvUMgkb5ifMf+Eyiz0heXJs=;
        b=EsYFYhi5YLM2CYVaQbmamBSUnTVMml8zoraowbCu2noJpLEblOs1149Bnhj/0mSj8y
         w09uJ6DNfzL0wFZSLSVFs0iSvBiWKDNu2eEXXkduSOl06NoD/3q1AdVYp4BkidNYjLq+
         wlD7597+u9ukQKpU5FNxD2x5ZjMjABkfcvza2gDWFf7k7jfvjfg0AZerDQttBrGw7oZp
         o9clkP9OtbBSx6igyic2vp3vDwqcF9uipciVX+pe6ORBE61JAgU4KuPkeLOVhsivLCsn
         l4HaF+Us1nVeL2l2kMMkox7OE965ZfqEpk2sSaSLH4iWMzFwKPRe11oU9eR+zrLywQLa
         OFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h8qhnRgEZihilSgw7kKeGvUMgkb5ifMf+Eyiz0heXJs=;
        b=DMd2JixK2z1Zqqja2rSfJZvK4FcOQiBznJE3miV0yQE/HKzWcmsNwm/tH7zYi2I/pa
         W/mQgLhSuEQmU1BF75rYJrarYVR2T0+qbLdZjI1O3B+oY8y4cb+Hx0IpA8lwJOG4QRa6
         QHwpmz30zdPWR39OGKUyTuavltJxeUa9NY76TeDFm9lwVoKF5KN/7yqiloH7aDqJ++86
         qVqhccX1bvgj36J1d6dTErZzyoFQPCoqcACFlJwLgE6X09mgHsjCUIkHIs4yckHnRa9B
         JtmhCyWw5/i3h7amzQS6XGnPx2aCGQZYqcIqtEv+KHs5MLPYtmPIdQP5N7ABIHVelH0O
         wDAw==
X-Gm-Message-State: APjAAAXLMnmlH7saggPyv5xCr4fOIOFh6l5ylMWajkj2z8/iKdfLgpv+
        cU/2UmQMb31iB+tWgu5noEY=
X-Google-Smtp-Source: APXvYqwM5uX2Z3lxpUb1PgpPaYg4UrhdWy602Z/sInoOWoP2qM3MQBWuz62fdEs69wpXsM/tmvWoqQ==
X-Received: by 2002:a17:902:20c8:: with SMTP id v8mr56385548plg.284.1563532363495;
        Fri, 19 Jul 2019 03:32:43 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id i15sm34029444pfd.160.2019.07.19.03.32.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 19 Jul 2019 03:32:42 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/exynos: Use dev_get_drv_data
Date:   Fri, 19 Jul 2019 18:31:09 +0800
Message-Id: <20190719103108.19998-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_get_drvdata is a simpler implementation comparing
to to_platform_device + platform_get_drvdata.
This makes the code simpler.


Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimc.c | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index a594ab7be2c0..164d914cbe9a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -44,7 +44,7 @@ static unsigned int fimc_mask = 0xc;
 module_param_named(fimc_devs, fimc_mask, uint, 0644);
 MODULE_PARM_DESC(fimc_devs, "Alias mask for assigning FIMC devices to Exynos DRM");
 
-#define get_fimc_context(dev)	platform_get_drvdata(to_platform_device(dev))
+#define get_fimc_context(dev)	dev_get_drvdata(dev)
 
 enum {
 	FIMC_CLK_LCLK,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 1e4b21c49a06..1c524db9570f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -58,7 +58,7 @@
 #define GSC_COEF_DEPTH	3
 #define GSC_AUTOSUSPEND_DELAY		2000
 
-#define get_gsc_context(dev)	platform_get_drvdata(to_platform_device(dev))
+#define get_gsc_context(dev)	dev_get_drvdata(dev)
 #define gsc_read(offset)		readl(ctx->regs + (offset))
 #define gsc_write(cfg, offset)	writel(cfg, ctx->regs + (offset))
 
-- 
2.20.1

