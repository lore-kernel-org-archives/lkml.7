Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8423EC31E40
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55190206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:48:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.net header.i=@jaseg.net header.b="VfcLmm6m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itK2Dnzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfG3Nsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:48:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:50287 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbfG3Nsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:48:35 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id ACFF52151C;
        Tue, 30 Jul 2019 09:48:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2019 09:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.net; h=
        from:subject:to:cc:in-reply-to:message-id:date:mime-version
        :content-type:content-transfer-encoding; s=fm3; bh=KSj52GsTAdLdw
        I7UgYSPIJjgaA3C1W8AG1/f615DsBY=; b=VfcLmm6mogFWW28ej/AB7ZvjWpXjD
        wHlntHH2I6m9c7tp4r6dbvj1VSMp2uZU9Ko10i4GSuOr02PgsZy7HEXIscaKOYDi
        4Un214vMGE9ZV4Xyq9NOsyHQi4wmsdKuofB+7GkgYTFVMm3E8gC04lJgNSgRWSlY
        VDXXbKY6qNh1jDRZIKgP0CAzuL49ziJCMHmm32SL6LhTrYJ4kpEK7bjWDw5DX/Bl
        DDuCS3EJ6yMVAhghyBVL7Lw/sKWf+xGGGyBKdLwD+W2becUcoZ1jbUXhbTi9ADCO
        wmu0FZ8HCAVZD+VYE5eeovATXoKI38pKj8DEuLB2m8QDwbrEEwi6zSWAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=KSj52GsTAdLdwI7UgYSPIJjgaA3C1W8AG1/f615DsBY=; b=itK2Dnzu
        /i0aZX5YW3ubY2t86rDs10Wrt0Hz5Cz2dGsDT8v8ZvqlELFnktPcU1K3YuBBjTCY
        yLfi4MZrxoGoVUMRH/06hdkc++v5O3qk2RflwD8ywsL6LJkVa4C97YaYMF2Frsvd
        5BRTqiJUuZltCFb4x2nb2rVDoGX2cQ9gqyt1UwIhCp28E3mpqRlR1HPH2cpMskQr
        hayqKniismAxyMTKX+qbrnL/n179xWsJLi3+hp9RruE+yNac1hl5hpOOS/YS68va
        ODJ/LwP0hIlhbO3gwLmexNckNHayAeQcHqwCD7CzMU3PT+TDWm9Brb8+csizNBoY
        QvTwRYs6ahTRGg==
X-ME-Sender: <xms:skpAXaf-AzKlyhOHJPp3bTcdQKP-3eQ5y8wALKSMOwzsYDiro-XJBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhuffvjgfkffgfgggtgfesthekredttdefjeenucfhrhhomheplfgrnhgpufgv
    sggrshhtihgrnhgpifpnthhtvgcuoehlihhnuhigsehjrghsvghgrdhnvghtqeenucfkph
    epiedtrdejuddrieefrdejheenucfrrghrrghmpehmrghilhhfrhhomheplhhinhhugies
    jhgrshgvghdrnhgvthenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:skpAXSuhBgQtUmGXyEEa73S1GqEJ-f2h_osQhOZj9aGScQ9r79EAPw>
    <xmx:skpAXWVos4zvcSXZSdyaxPWsgThWtEqoQkqJWc5p9VbzyFMQKz99bg>
    <xmx:skpAXeK8wNCjTpnkvY149f886uYHBXhzSitZ_yB11GRn5MZVuD_Z8A>
    <xmx:skpAXZZ1XFQ1pm7WlodyWra1y5gRcs5Arc2gUKq5rrGsHu8ipBzPkA>
Received: from [10.137.0.16] (softbank060071063075.bbtec.net [60.71.63.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id F097480066;
        Tue, 30 Jul 2019 09:48:32 -0400 (EDT)
From:   =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Subject: [PATCH 5/6] drm: uapi: add gdepaper uapi header
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
In-Reply-To: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
Message-ID: <0e22c86a-3998-c2fd-cb14-203df547eb5c@jaseg.net>
Date:   Tue, 30 Jul 2019 22:48:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jan Sebastian Götte <linux@jaseg.net>
---
 include/uapi/drm/gdepaper_drm.h | 62 +++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 include/uapi/drm/gdepaper_drm.h

diff --git a/include/uapi/drm/gdepaper_drm.h b/include/uapi/drm/gdepaper_drm.h
new file mode 100644
index 000000000000..84ff6429bef5
--- /dev/null
+++ b/include/uapi/drm/gdepaper_drm.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/* gdepaper_drm.h
+ *
+ * Copyright (c) 2019 Jan Sebastian Götte
+ */
+
+#ifndef _UAPI_GDEPAPER_DRM_H_
+#define _UAPI_GDEPAPER_DRM_H_
+
+#include "drm.h"
+
+#if defined(__cplusplus)
+extern "C" {
+#endif
+
+enum drm_gdepaper_vghl_lv {
+	DRM_GDEP_PWR_VGHL_16V = 0,
+	DRM_GDEP_PWR_VGHL_15V = 1,
+	DRM_GDEP_PWR_VGHL_14V = 2,
+	DRM_GDEP_PWR_VGHL_13V = 3,
+};
+
+struct gdepaper_refresh_params {
+	enum drm_gdepaper_vghl_lv vg_lv; /* gate voltage level */
+	__u32 vcom_sel; /* VCOM select bit according to datasheet */
+	__s32 vdh_bw_mv; /* drive high level, b/w pixel (mV) */
+	__s32 vdh_col_mv; /* drive high level, red/yellow pixel (mV) */
+	__s32 vdl_mv; /* drive low level (mV) */
+	__s32 vcom_dc_mv;
+	__u32 vcom_data_ivl_hsync; /* data ivl len in hsync periods */
+	__u32 border_data_sel; /* "vbd" in datasheet */
+	__u32 data_polarity; /* "ddx" in datasheet */
+	__u32 use_otp_luts_flag; /* Use OTP LUTs */
+	__u8 lut_vcom_dc[44];
+	__u8 lut_ww[42];
+	__u8 lut_bw[42];
+	__u8 lut_bb[42];
+	__u8 lut_wb[42];
+};
+
+/* Force a full display refresh */
+#define DRM_GDEPAPER_FORCE_FULL_REFRESH		0x00
+#define DRM_GDEPAPER_GET_REFRESH_PARAMS		0x01
+#define DRM_GDEPAPER_SET_REFRESH_PARAMS		0x02
+#define DRM_GDEPAPER_SET_PARTIAL_UPDATE_EN	0x03
+
+#define DRM_IOCTL_GDEPAPER_FORCE_FULL_REFRESH \
+	DRM_IO(DRM_COMMAND_BASE + DRM_GDEPAPER_FORCE_FULL_REFRESH)
+#define DRM_IOCTL_GDEPAPER_GET_REFRESH_PARAMS \
+	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_GET_REFRESH_PARAMS, \
+	struct gdepaper_refresh_params)
+#define DRM_IOCTL_GDEPAPER_SET_REFRESH_PARAMS \
+	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_SET_REFRESH_PARAMS, \
+	struct gdepaper_refresh_params)
+#define DRM_IOCTL_GDEPAPER_SET_PARTIAL_UPDATE_EN \
+	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_SET_PARTIAL_UPDATE_EN, __u32)
+
+#if defined(__cplusplus)
+}
+#endif
+
+#endif /* _UAPI_GDEPAPER_DRM_H_ */
-- 
2.21.0

