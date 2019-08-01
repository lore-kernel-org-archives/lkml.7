Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3AAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA37214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 03:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OGB11FXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfHADo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 23:44:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43585 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbfHADov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 23:44:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id i189so33156936pfg.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 20:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uNdkweGhIzbmbLSCXzyijf1WMLgtz0ZE8h2SpBy/OLo=;
        b=OGB11FXENEPh4SmCX7T3rKxhiL7ZrFfQKMccbHnaw+keOQERXnl3rUByFY0rxtcueb
         0gdBDp+kCsm2S46pdTzAUICilsvpQQGV6ye2oC5RONILIawaN//cDfc03LgJgGMhUWMe
         V+KS3Mgx3imySjEAjQXBFLa3TkfagcjTDMPhiUekfuwKIqg7FSXYRljXiI0RoNZsHziK
         sPJmToqUHV0pCU5f/YNVRIwuowSyESH0WKkJl+gQKOvtltdhQLTBQmQiTxYEaofcRPvv
         WzH7U4dT8+o9PR62Dv3+X6eK4loTM75es89zSiCneXGMPJUqwlyOz0Ef/PZhme7Lnk00
         SR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uNdkweGhIzbmbLSCXzyijf1WMLgtz0ZE8h2SpBy/OLo=;
        b=jVVcrEoZ19OJAiI2A2KZblx9/L5tJAxTktH2/QxFozag3QHHLTAUlKe9pu5dTNPhur
         XSAXsK5FWRAjl21iuHl77tDPk16N1fHeAsRVp5+M3oGwZCvrvEzA8Fs6aCQyBPFfHZHj
         CSXDzmlrb02lVN1Xl8iAyGbgma6VEZI3J+d4086BEu6swXrE1Sk5M3MMgDEnWdUYtqDG
         rpvbyZ94oVbdlXCZqACxbX+z0EIVJAtURMxEwNQ4B1H3b0KssBXTcOrKWhAVT4AtC3JU
         PdU08lHnoWupH/d+xfqxBLmxZ3dX0g2XhJY4XZtFCT4nS68L+bgpvvp6qZ1m65s89laS
         jWyA==
X-Gm-Message-State: APjAAAU/O/nOyHqqcbZkoM++jQ//fh14X7V3hxHngGj5soMd676q5+TN
        YPj1BLumT/c5xGXBUUzlZUB6jwcugUk=
X-Google-Smtp-Source: APXvYqwfB0iIhvHh7a7X5V8dzwGo5czS7fwWeWmrOVxTrJtTjuJRuF+OuaL2VM1n+uRJALrGYlIXlg==
X-Received: by 2002:a63:5c7:: with SMTP id 190mr114581537pgf.67.1564631090362;
        Wed, 31 Jul 2019 20:44:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id h70sm64775674pgc.36.2019.07.31.20.44.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 20:44:49 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rongrong Zou <zourongrong@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 03/26] drm: kirin: Remove HISI_KIRIN_DW_DSI config option
Date:   Thu,  1 Aug 2019 03:44:16 +0000
Message-Id: <20190801034439.98227-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801034439.98227-1-john.stultz@linaro.org>
References: <20190801034439.98227-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_HISI_KIRIN_DW_DSI option is only used w/ kirin
driver, so cut out the middleman and condense the config
logic down.

Cc: Rongrong Zou <zourongrong@gmail.com>
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

