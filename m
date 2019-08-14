Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA712C32757
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A172173B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="new8xX0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfHNSrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:47:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45142 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729122AbfHNSrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:47:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id w26so8829958pfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 11:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZyAGMPNMpuVXR2jkt8gh8WUfYnDQXgrGIfOGthyfg8o=;
        b=new8xX0jxsoxrQMLLTjQzxCi9sEMmOw0y08XqrmCsvQjSiFIOUH2oFECZQOjzm47Ew
         cXFDtMTKt5ft82uI3BfQLWS/OucPSunD0m00lu6dNFtnM4Yfuj6jLpUqfTpGMp3RlxqZ
         g9GZTqDt3eOQchKPiQOtPjF78VjyeoPaP7K5itoS/AY+LMzle2ccLPW5i621gwojmzeQ
         Udq8vzMc/+yOPa5NVaijaIrBenAGLaCwPGUnOG2Equi+zkUn4KWtg9NK6iSdxz+xP+kt
         Rs5sSj4j5c6LTIoBzwooGqYLjO6iXDjfUVaEVudnMBD8BHVXYJcYoiO7/SScGSbtiXo9
         02zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZyAGMPNMpuVXR2jkt8gh8WUfYnDQXgrGIfOGthyfg8o=;
        b=FUgiHs7UieBIBDw6Uie0ZvSZ7vgBLHneZVJBXZkPUK5S0CcaTeq53AvMWBybPjwXR2
         dFRGLMcMePQ3GEjVIO9xGkdgH05sXO0szkvVQuUUDHD5+8Z7L5y6Th+/3ahLJkGn1g3l
         NgjTpxpGtqdOWOqxRdDhN5GtoYfR/9Xi6bjA0TVDoVwixLwdDkO9lTuGZbC8fITpLbhs
         1L00v6OfR+WFOMiRl34cy+mWnEoXtxUoWav+O3dEJLL7DvAV0ksK/TlY1MFVbTGRxEOL
         xF1W9hZpGS4zDj5whZZYPRNEc2NeS9CYUCTxWzdzRAxUnKGxhTVO9s1AiFZUgxYJ9LN3
         8aKQ==
X-Gm-Message-State: APjAAAWJTXHTAM6nA+d67EgoRmlQpbsT00svVg5+TTiBpU13w8pKY/3m
        2eEFM+4kJsGEqQHQ/ruM1gY042Z/KzA=
X-Google-Smtp-Source: APXvYqx2ATmZWXgkLdV3QzZflhCxpHcPXcxbWBN7V0nc/tthxryzI4TQboQLFuMmgL6bwajwF4MfTQ==
X-Received: by 2002:a17:90a:aa98:: with SMTP id l24mr1091282pjq.64.1565808432086;
        Wed, 14 Aug 2019 11:47:12 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y16sm610855pfc.36.2019.08.14.11.47.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 11:47:11 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [RESEND][PATCH v3 03/26] drm: kirin: Remove HISI_KIRIN_DW_DSI config option
Date:   Wed, 14 Aug 2019 18:46:39 +0000
Message-Id: <20190814184702.54275-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190814184702.54275-1-john.stultz@linaro.org>
References: <20190814184702.54275-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_HISI_KIRIN_DW_DSI option is only used w/ kirin
driver, so cut out the middleman and condense the config
logic down.

Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/Kconfig  | 10 +---------
 drivers/gpu/drm/hisilicon/kirin/Makefile |  4 ++--
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
index 0fa29af08ad0..290553e2f6b4 100644
--- a/drivers/gpu/drm/hisilicon/kirin/Kconfig
+++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
@@ -5,16 +5,8 @@ config DRM_HISI_KIRIN
 	select DRM_KMS_HELPER
 	select DRM_GEM_CMA_HELPER
 	select DRM_KMS_CMA_HELPER
-	select HISI_KIRIN_DW_DSI
+	select DRM_MIPI_DSI
 	help
 	  Choose this option if you have a hisilicon Kirin chipsets(hi6220).
 	  If M is selected the module will be called kirin-drm.
 
-config HISI_KIRIN_DW_DSI
-	tristate "HiSilicon Kirin specific extensions for Synopsys DW MIPI DSI"
-	depends on DRM_HISI_KIRIN
-	select DRM_MIPI_DSI
-	help
-	 This selects support for HiSilicon Kirin SoC specific extensions for
-	 the Synopsys DesignWare DSI driver. If you want to enable MIPI DSI on
-	 hi6220 based SoC, you should selet this option.
diff --git a/drivers/gpu/drm/hisilicon/kirin/Makefile b/drivers/gpu/drm/hisilicon/kirin/Makefile
index c0501fa3fe53..c50606cfbbdb 100644
--- a/drivers/gpu/drm/hisilicon/kirin/Makefile
+++ b/drivers/gpu/drm/hisilicon/kirin/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 kirin-drm-y := kirin_drm_drv.o \
-	       kirin_drm_ade.o
+	       kirin_drm_ade.o \
+	       dw_drm_dsi.o
 
 obj-$(CONFIG_DRM_HISI_KIRIN) += kirin-drm.o
 
-obj-$(CONFIG_HISI_KIRIN_DW_DSI) += dw_drm_dsi.o
-- 
2.17.1

