Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6542DC5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA082187F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:35:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnIDVSNy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfGDCfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:35:47 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38906 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfGDCfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:35:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id z75so2154931pgz.5;
        Wed, 03 Jul 2019 19:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nXTmk+pxDZGbrpmbWYwCZvMXWZKHwPkgM46QtmxM/i8=;
        b=WnIDVSNyFN+GFsu8DtLMgP1OsUuRcgcaIdWOIZtK3QToQE396D3VbYxv2O9LJU8wrx
         wsa95FllqQ0c4hUs2NKqBQob5D+7UbsUtGWtxeizU8MaQAT5cSJHwbyeQ5tIS5RKljXH
         O4v1+nazHVba494UkGKurdi5JV1XV/scsmsw3C+Jim0B5gfAvFXtRn6wJuIKP+w+7+iq
         XsA02FqL7QfjMtgWch+KcYCakNjHnX6wdIj30NGyhh9/zl6WAmVBu4funKKKMeDDrGXF
         KJHPV9X+tbBKUb/1EoXCWK292IEU41XbsDiTjH8TUIWIrNxz1VZI7G8N0WP/GIsK/r6Z
         T31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nXTmk+pxDZGbrpmbWYwCZvMXWZKHwPkgM46QtmxM/i8=;
        b=HMYIacpELpWSXRiw1IvLUnOBU+jVglCQn62cHFrUum218otMmRPEbuOMz4/rdmwhpy
         sJn62pAjR2KPWFihgzvrXin6rbz/jBAidmNYu2GhaTUXZiMuiMlbIgMTHvGWwDbbQFN0
         au8HQXZtgLKPhNjCBVYi3l32GZH+G1G3MYSLQDEVTzSncmJLZAuEMVHN9OgQSZcsMKXN
         2/EbUYZcnZjhqV9OTmPEK/RbqXE6m0AfmGwIBLZm/svkwALkg+DZgoJAmkgIZuxN2/xf
         eu/F8de+3WPjiWc0MheYLMbGZyq/oVBicHx1raIM1bprDJmif8l1LZ5Jh2ubD7LdHoZX
         sJUA==
X-Gm-Message-State: APjAAAV6y5VQiIvuWmrVcV214tBKaiZdmJ4Dtd/nrYXjilzTf64DHc2A
        am8OfIDYa+/ZAtNuSIhBON8=
X-Google-Smtp-Source: APXvYqwhSeJvwMwPkanmGKWfOj1GnT7T88Rpk3rP16X1l5uBpm5SOtUz1DniCqkcur/49sEn0+h7Tw==
X-Received: by 2002:a17:90a:a09:: with SMTP id o9mr16504796pjo.95.1562207745651;
        Wed, 03 Jul 2019 19:35:45 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id y68sm3715500pfy.164.2019.07.03.19.35.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 19:35:45 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
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
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [Patch v2 01/10] drm/exynos: using dev_get_drvdata directly
Date:   Thu,  4 Jul 2019 10:34:36 +0800
Message-Id: <20190704023436.4456-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several drivers cast a struct device pointer to a struct
platform_device pointer only to then call platform_get_drvdata().
To improve readability, these constructs can be simplified
by using dev_get_drvdata() directly.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Make the commit message more clearly.

 drivers/gpu/drm/exynos/exynos_drm_fimc.c | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index 0db29690ede3..c79eafc9457e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -43,7 +43,7 @@ static unsigned int fimc_mask = 0xc;
 module_param_named(fimc_devs, fimc_mask, uint, 0644);
 MODULE_PARM_DESC(fimc_devs, "Alias mask for assigning FIMC devices to Exynos DRM");
 
-#define get_fimc_context(dev)	platform_get_drvdata(to_platform_device(dev))
+#define get_fimc_context(dev)	dev_get_drvdata(dev)
 
 enum {
 	FIMC_CLK_LCLK,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 05b0fe21b81e..6399d89c3f9f 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -57,7 +57,7 @@
 #define GSC_COEF_DEPTH	3
 #define GSC_AUTOSUSPEND_DELAY		2000
 
-#define get_gsc_context(dev)	platform_get_drvdata(to_platform_device(dev))
+#define get_gsc_context(dev)	dev_get_drvdata(dev)
 #define gsc_read(offset)		readl(ctx->regs + (offset))
 #define gsc_write(cfg, offset)	writel(cfg, ctx->regs + (offset))
 
-- 
2.11.0

