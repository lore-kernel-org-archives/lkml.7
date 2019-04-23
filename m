Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E908C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F00218EA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cjViXEEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbfDWXWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:22:37 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38177 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfDWXVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:21:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id f36so8248238plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QV6q4rIQIKonURhV5YI0Y2da8qAlozUPAhHD+uzvbZs=;
        b=cjViXEEth7iNuFYI0MTKtfltpV1DEW3RM2sP6kFUQRF1yZR+gHY7wnkxF3NQprorMh
         QZzV6oCUnje+bIBXL2+EU2opo6GijlLcAJlFZsX/91h9PBwEgQ6rR+QJVP/O0TDvse8n
         pQ/VJ6Qz9VTNyjO7XHtJiG+mFyQZKYwb70p6MYw1n0iIyJuoBhyyOBdNueeuYFDrrUm/
         oJvlcKblSvExCfIpIG6Ngvo1v3zwOfBaUogRlbYNEeLPs7baorv9X9m/lbXA1tqQE4vi
         grJpEZNhCwaSYGU/9srOxbi2No7gzI0KKYLH8uJHtHf4fjcB3woDCkn/k2jsCI6VTlhB
         wScw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QV6q4rIQIKonURhV5YI0Y2da8qAlozUPAhHD+uzvbZs=;
        b=lEZvpy/bpWbFV6BwxL8NVdSH9gIXu/TMBoiZPxTeq+Yc+JzPvgcyjqsycdWKl49Dhr
         3ZewycuOEhoro1lP16e8yGHJvn5HKN7Riif4BiWDsDaCbFDrPTgm7Om0/D7H6Tzyempf
         jz9z9dCByVtW1D/wRyzUXO7UlNEft2n5kd5BJRDeXOc62/GE56bSyJnjYraHSSVazlLB
         aBnE3Y0++iJ2Y3j+JqUNMsC/eUKuZM7BLxoookkGKo3WBf9Svwl6DHoBLxo1DCQRlMhH
         ATRCNRPhVMjH4pPYZGo6RGqclA8v9ZFlGB4nzVedWAfP4Tq+asH5rkKSmPunmrUpBTNI
         c7zg==
X-Gm-Message-State: APjAAAXLQdLZOdnr0RH7NNWryuElvlm2iOL5ITPE4gtWEjmS9/lDsP+x
        TAvmFHQC2Y8gGXZfToDq02F83L9JaDs=
X-Google-Smtp-Source: APXvYqxcrohcoxF7N0y3iDmLR1PiNAeIDv8NwK0xG5vjhqwI1ajGwj0jXu3C4/WphYQxCdjQhubPBA==
X-Received: by 2002:a17:902:a7:: with SMTP id a36mr28776329pla.111.1556061676303;
        Tue, 23 Apr 2019 16:21:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id c28sm6984235pgm.42.2019.04.23.16.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 16:21:15 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Xu YiPing <xuyiping@hisilicon.com>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 11/25] drm: kirin: Move kirin_crtc, kirin_plane, kirin_format to kirin_drm_drv.h
Date:   Tue, 23 Apr 2019 16:20:42 -0700
Message-Id: <1556061656-1733-12-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xu YiPing <xuyiping@hisilicon.com>

As part of refactoring the kirin driver to better support
different hardware revisions, this patch moves some shared
structures and helpers to the common kirin_drm_drv.h

These structures will later used by both kirin620 and
future kirin960 driver

Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
Cc: Rongrong Zou <zourongrong@gmail.com>
Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Chen Feng <puck.chen@hisilicon.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Signed-off-by: Xu YiPing <xuyiping@hisilicon.com>
[jstultz: reworded commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c | 27 ++-----------------------
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h | 24 ++++++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
index f54cf99..69604ad 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c
@@ -38,12 +38,6 @@
 #define OUT_OVLY	ADE_OVLY2 /* output overlay compositor */
 #define ADE_DEBUG	1
 
-#define to_kirin_crtc(crtc) \
-	container_of(crtc, struct kirin_crtc, base)
-
-#define to_kirin_plane(plane) \
-	container_of(plane, struct kirin_plane, base)
-
 
 struct ade_hw_ctx {
 	void __iomem  *base;
@@ -59,18 +53,6 @@ struct ade_hw_ctx {
 	struct drm_crtc *crtc;
 };
 
-struct kirin_crtc {
-	struct drm_crtc base;
-	void *hw_ctx;
-	bool enable;
-};
-
-struct kirin_plane {
-	struct drm_plane base;
-	void *hw_ctx;
-	u32 ch;
-};
-
 struct ade_data {
 	struct kirin_crtc crtc;
 	struct kirin_plane planes[ADE_CH_NUM];
@@ -78,12 +60,7 @@ struct ade_data {
 };
 
 /* ade-format info: */
-struct ade_format {
-	u32 pixel_format;
-	enum ade_fb_format ade_format;
-};
-
-static const struct ade_format ade_formats[] = {
+static const struct kirin_format ade_formats[] = {
 	/* 16bpp RGB: */
 	{ DRM_FORMAT_RGB565, ADE_RGB_565 },
 	{ DRM_FORMAT_BGR565, ADE_BGR_565 },
@@ -127,7 +104,7 @@ static u32 ade_get_format(u32 pixel_format)
 
 	for (i = 0; i < ARRAY_SIZE(ade_formats); i++)
 		if (ade_formats[i].pixel_format == pixel_format)
-			return ade_formats[i].ade_format;
+			return ade_formats[i].hw_format;
 
 	/* not found */
 	DRM_ERROR("Not found pixel format!!fourcc_format= %d\n",
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
index ad027d1..b6626f5 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.h
@@ -13,6 +13,30 @@
 
 #define MAX_CRTC	2
 
+#define to_kirin_crtc(crtc) \
+	container_of(crtc, struct kirin_crtc, base)
+
+#define to_kirin_plane(plane) \
+	container_of(plane, struct kirin_plane, base)
+
+/* kirin-format translate table */
+struct kirin_format {
+	u32 pixel_format;
+	u32 hw_format;
+};
+
+struct kirin_crtc {
+	struct drm_crtc base;
+	void *hw_ctx;
+	bool enable;
+};
+
+struct kirin_plane {
+	struct drm_plane base;
+	void *hw_ctx;
+	u32 ch;
+};
+
 /* display controller init/cleanup ops */
 struct kirin_dc_ops {
 	int (*init)(struct platform_device *pdev);
-- 
2.7.4

