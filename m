Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2286EC2BD09
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA8020801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 16:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nazofESi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbfLEQFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 11:05:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37016 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfLEQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 11:05:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id bb5so1429990plb.4;
        Thu, 05 Dec 2019 08:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKlXFmsyCCcDDwPIPUpIzSPGgE4nu5epjuY/dy6jNM4=;
        b=nazofESih7AXvfwNZmyfhH0uQR3YVRvZN2HjlxMs6kzxGlLd7vjEgyDgq2QKlLD9qm
         HegcL1lC8G4DghBfGBWCM2AeXXNK+XSWTbIcJ+Vi+CQ4f+xakpNN9p/bSCYyRNUMvWDa
         tHrFvhdjoSmH7UhcqLfGN/0+9G/k18RkB7bmI3lxPtNtJozmq8fv9+Kl6S6b5My5Su5V
         O2yvei4BgLjTbtnOPUslo8F1w2Xj+ao5bVUEj78KNq6EG7niaoQgsRQmL75lAzW/+jcG
         phxjFgczueN+Pmwyd/tT7G1VYS1hyD7DufECR5GxWgmD4ODqTTZq57h4oPlmAN4RofC6
         d/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UKlXFmsyCCcDDwPIPUpIzSPGgE4nu5epjuY/dy6jNM4=;
        b=e6UA2DQtnRirFisNMHdliJhxBj5CfrJVf75vbpvbLRaJF/dKH76vKhLDCEJQ3r9FZS
         K2BkIre8QrNrCaZ294Yc44mSI9Wx+nnbLzTxJPEbElufIKYWPIXsoIRARdvIFfpZBbHA
         5Y3eftJ1leu8uB7YqGcz3g4HzgoSe7uoRET1tSQCYB/bWxVW4EqUoH4//hatxwPt8TnD
         gbIzHamJ4xGR67vvtCdlscPwMCW2oUeOj/MU7hjhiqNpgKxXPD/lT61IzhrPr0qgVD7j
         oyeYLF0+lFHN2vjAax2+lEhmL+DZSp50IuIgtzVoIIl9rN/75A01XeARodbRB9F8I96o
         ioBg==
X-Gm-Message-State: APjAAAXeCRLHLt41usKLzLmp+jZ1GukjQntUXHUFa5VhV98K/K6WD9aV
        zNfVmqdMku1bco9FXdOIFiI=
X-Google-Smtp-Source: APXvYqyg6jDDIuUjk0ppe+Py08NjE/qtzDD1oo0Tm7cVTE7k/KaRbCfv99/ONFToupOaJS3e3I5RMw==
X-Received: by 2002:a17:902:bb83:: with SMTP id m3mr9424484pls.94.1575561934927;
        Thu, 05 Dec 2019 08:05:34 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id b2sm13229869pff.6.2019.12.05.08.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 08:05:34 -0800 (PST)
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
Subject: [PATCH resend] drm/exynos: gsc: add missed component_del
Date:   Fri,  6 Dec 2019 00:05:20 +0800
Message-Id: <20191205160520.31955-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver forgets to call component_del in remove to match component_add
in probe.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_gsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 7ae087b0504d..88b6fcaa20be 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1313,6 +1313,7 @@ static int gsc_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 
+	component_del(dev, &gsc_component_ops);
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 
-- 
2.24.0

