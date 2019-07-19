Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607B3C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401B221849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfGSK1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:27:10 -0400
Received: from inva021.nxp.com ([92.121.34.21]:50354 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSK1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:27:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0334E2000C9;
        Fri, 19 Jul 2019 12:27:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8658A20000A;
        Fri, 19 Jul 2019 12:27:05 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EB33A402B5;
        Fri, 19 Jul 2019 18:27:00 +0800 (SGT)
From:   Wen He <wen.he_1@nxp.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        p.zabel@pengutronix.de
Cc:     leoyang.li@nxp.com, linux-imx@nxp.com, Wen He <wen.he_1@nxp.com>
Subject: [v2] gpu: ipu-v3: allow to build with ARCH_LAYERSCAPE
Date:   Fri, 19 Jul 2019 18:17:51 +0800
Message-Id: <20190719101751.12315-1-wen.he_1@nxp.com>
X-Mailer: git-send-email 2.9.5
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new LS1028A DP driver code causes a link failure when DRM_IMX built-in,
but platform is ARCH_LAYERSCAPE:

drivers/gpu/drm/imx/ipuv3-crtc.c:51: undefined reference to `ipu_prg_enable'
drivers/gpu/drm/imx/ipuv3-crtc.c:52: undefined reference to `ipu_dc_enable'
drivers/gpu/drm/imx/ipuv3-crtc.c:53: undefined reference to `ipu_dc_enable_channel'
drivers/gpu/drm/imx/ipuv3-crtc.c:54: undefined reference to `ipu_di_enable'
drivers/gpu/drm/imx/ipuv3-crtc.o: In function `ipu_crtc_mode_set_nofb

Adding a Kconfig dependency allow to build if ARCH_LAYERSCAPE is enable.

Signed-off-by: Wen He <wen.he_1@nxp.com>
---
change in v2:
        - fix Kconfig conflit issue after rebased to kernel 5.2

 drivers/gpu/ipu-v3/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/ipu-v3/Kconfig b/drivers/gpu/ipu-v3/Kconfig
index 061fb990c120..be515dd95c2c 100644
--- a/drivers/gpu/ipu-v3/Kconfig
+++ b/drivers/gpu/ipu-v3/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config IMX_IPUV3_CORE
 	tristate "IPUv3 core support"
-	depends on SOC_IMX5 || SOC_IMX6Q || ARCH_MULTIPLATFORM || COMPILE_TEST
+	depends on SOC_IMX5 || SOC_IMX6Q || ARCH_MULTIPLATFORM || COMPILE_TEST || ARCH_LAYERSCAPE
 	depends on DRM || !DRM # if DRM=m, this can't be 'y'
 	select BITREVERSE
 	select GENERIC_ALLOCATOR if DRM
-- 
2.17.1

