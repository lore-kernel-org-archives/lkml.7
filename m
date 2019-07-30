Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E367C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C68206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jaseg.net header.i=@jaseg.net header.b="Wjq77XUv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JZ99dsGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbfG3Nrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:47:40 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33543 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728195AbfG3Nrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:47:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 26A5021B74;
        Tue, 30 Jul 2019 09:47:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2019 09:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaseg.net; h=
        from:subject:to:cc:in-reply-to:message-id:date:mime-version
        :content-type:content-transfer-encoding; s=fm3; bh=uCERNq3R8GWVB
        iCt+rRgY2nM3IgsJiZuVTvKUacRcs4=; b=Wjq77XUvuTNsV8WNY9Sw+08BdXTYC
        nvLLfnwncUSjNNLSO8UhdHAnhLLgOCqO/5pX38RuLPSyWzvBive6qXESszBF+Cqb
        CWm+uaXRZ4lFEDdz2SL7aRGnXnfjfDCOwrOBPMFJMXkQ9bX7uqYgSu6zMPC69KAH
        WaA3qwBUhvlidbKb1gbdKoMGiSWpj06jSzcsmoMX2P3JrIOmd2xqjdZ04NBVIiC3
        emglnnHi1o6kaMzALOMNUX1PvSGJAfuS6sNDpYxjn3gzf6Y79qj9SqB2pKAB22Jd
        Pa/NdBmOvByIa5s/6vD5sGteS3SksXq62ISJoQIw+k0A7VgKwgBkDe4iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=uCERNq3R8GWVBiCt+rRgY2nM3IgsJiZuVTvKUacRcs4=; b=JZ99dsGF
        qMNfUSnOy7MLFVkn1k5k7pl3RtAom/7wUagEstu2ctxUnacuJ7qyhxCeLtek2yzf
        ddeEOL9MI7t4GjQ0TCjVVyVadKoqsB90RRSmJP6QsqgAXIbyxjRO8FoLNDH0oEoJ
        lyeuxGcpHFUv4ToHtz/Qn2u/CP8fl1iVNEZ0OTxfud9BRswq4eXr1S4dvbAyk5Uy
        C77C1qPb2mwfGnYs+lnyBubJ7Jv3uPtmjVk6PsOShKsCGvQh91/Fngze92L/ydeA
        r6qOe4L5Cw63c7XfYCROpiHVzmYGy6ErQpdoTgQ574l1evwJ8wVnjI6QRBQYSx4h
        5b+vNxfpA9yhAQ==
X-ME-Sender: <xms:eUpAXYuc_C2b661sgAmt2hNHqq4trdfXQtFqHRlE5VoxnD3GHOHfAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrleefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhuffvjgfkffgfgggtgfesthekredttdefjeenucfhrhhomheplfgrnhgpufgv
    sggrshhtihgrnhgpifpnthhtvgcuoehlihhnuhigsehjrghsvghgrdhnvghtqeenucfkph
    epiedtrdejuddrieefrdejheenucfrrghrrghmpehmrghilhhfrhhomheplhhinhhugies
    jhgrshgvghdrnhgvthenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:eUpAXa-o9q3SBouyW__OkTaIUhfbEG7Sa32D9Yomvl_MIFz3YBadIg>
    <xmx:eUpAXcGjAVNkbCJ20Yru4iN1bd-mi-eglpiEnvCahetnywZD2HC8Pw>
    <xmx:eUpAXZTedMDQu-vGsIuCPkix2no6hhrE2rSmr9kzIBhp1gocDOOgMQ>
    <xmx:e0pAXSIkTxK-kahb7LL8IFgImFCB7jDl-ivGz2-BMlaJnHto9MTcxA>
Received: from [10.137.0.16] (softbank060071063075.bbtec.net [60.71.63.75])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9508180065;
        Tue, 30 Jul 2019 09:47:36 -0400 (EDT)
From:   =?UTF-8?Q?Jan_Sebastian_G=c3=b6tte?= <linux@jaseg.net>
Subject: [PATCH 1/6] drm: tiny: gdepaper: add TINYDRM_GDEPAPER config option
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
In-Reply-To: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
Message-ID: <c802bc16-260a-d3d0-5f6a-a384ec4f47ed@jaseg.net>
Date:   Tue, 30 Jul 2019 22:47:34 +0900
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
 drivers/gpu/drm/tinydrm/Kconfig  | 10 ++++++++++
 drivers/gpu/drm/tinydrm/Makefile |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
index 87819c82bcce..427d1e62e63d 100644
--- a/drivers/gpu/drm/tinydrm/Kconfig
+++ b/drivers/gpu/drm/tinydrm/Kconfig
@@ -65,6 +65,16 @@ config TINYDRM_REPAPER
 
 	  If M is selected the module will be called repaper.
 
+config TINYDRM_GDEPAPER
+	tristate "DRM support for Good Display E-Paper Display"
+	depends on DRM_TINYDRM && SPI
+	select TINYDRM_MIPI_DBI
+	help
+	  DRM driver for the following Good Display E-Papar displays:
+	  * GDEW027C44 display (2.7 inch)
+
+	  If M is selected the module will be called gdepaper.
+
 config TINYDRM_ST7586
 	tristate "DRM support for Sitronix ST7586 display panels"
 	depends on DRM_TINYDRM && SPI
diff --git a/drivers/gpu/drm/tinydrm/Makefile b/drivers/gpu/drm/tinydrm/Makefile
index 48ec8ed9dc16..70f78c8ab26e 100644
--- a/drivers/gpu/drm/tinydrm/Makefile
+++ b/drivers/gpu/drm/tinydrm/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_TINYDRM_ILI9225)		+= ili9225.o
 obj-$(CONFIG_TINYDRM_ILI9341)		+= ili9341.o
 obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
 obj-$(CONFIG_TINYDRM_REPAPER)		+= repaper.o
+obj-$(CONFIG_TINYDRM_GDEPAPER)		+= gdepaper.o
 obj-$(CONFIG_TINYDRM_ST7586)		+= st7586.o
 obj-$(CONFIG_TINYDRM_ST7735R)		+= st7735r.o
-- 
2.21.0

