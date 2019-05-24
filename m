Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DCAC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AA520868
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 13:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="owRAgPfG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403847AbfEXNI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 09:08:27 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44855 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391272AbfEXNI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 09:08:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so1602849wru.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 06:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OgQG33xuk/EhzH06wld3kb9oAEYUVKAKXc70PtpZrC8=;
        b=owRAgPfGikxZtUG1BQRct8nWEQoZ+vHOSKdD7iOhXd8OMGFf32ex0MPT6DfeY3lxuy
         bhWjO3JH8oYEAla3+xVUmPAW7EyA7Bh+ag6nXRT7NIlhZ13NHoZgF2L1mcLF2kiS7m0N
         kTKmcvO2AzJUcwMHMThCxt2n7Hf7/NvxDM7hBBzxrD4kdtYP/CKwvGyIF/eFdbNaJJ7q
         2pKwUSQGwHrbYFfPTImyiZ/JAFlLnntm6NCYFJ6bUruR5T+zUWT8ukMR66zJ4fwTwLrW
         8Dbv4MEKoW2GXHd++IyIwDxs0gxoDLL4zOG1bRfeArEaZSgmJ/Gaih3eBfnmGmrcEYXK
         K29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OgQG33xuk/EhzH06wld3kb9oAEYUVKAKXc70PtpZrC8=;
        b=oaK01IOahvKd1iRcbnPwVUwwPoD/IkNJOgdAEC3XlANqNHNW2ABGoJ492+aEClzbPL
         6GbyvaD24veej4Rr1zqhBD1FW3VGdq/uyy9shAYIfITur0rzlmcP5E3ZGe9swGfhGQDN
         HI82IFQo4v/xQdPKNsGrsmLB4L1lZreHrZHhVS92ah9TgHSrtUsIi47B3jtvSJdrF+JE
         xU1FqmIvMOgNfuaqlMoAd9PkEyb7tnOnqVmGaIw/SEUIqmQGEDJLWMgFdgQi97zL61C9
         T3v54xGDJBmsVZe76S6cYRGO4R1MwK9uXTVxmOWNHNIVz/1jSlBVyrgnpEIArsRlBeZf
         SThg==
X-Gm-Message-State: APjAAAWBmsp0VcOjZr5HodnCCW6ClX3u4KqYaFHM3oN+6R3CinQYpeH6
        tXh7NMjhd/3q+ecCh1DaF8dwrA==
X-Google-Smtp-Source: APXvYqzR+reL4mcAcIjGdB6vyMDbG1N7JQb5wDwT7uZCcD0jOl7OaN2viGm0Xl/fbGghcGMUsqIY/w==
X-Received: by 2002:adf:e408:: with SMTP id g8mr30766656wrm.143.1558703304789;
        Fri, 24 May 2019 06:08:24 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f65sm3557698wmg.45.2019.05.24.06.08.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 06:08:24 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: add dwmac-3.70a to ethmac compatible list
Date:   Fri, 24 May 2019 15:08:17 +0200
Message-Id: <20190524130817.18920-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After discussing with Amlogic, the Synopsys GMAC version used by
the gx and axg family is the 3.70a. Set this is in DT

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 Hi,

 The same should be true for the meson8 families but I did not test
 it which is why only the patch only address the 64bits SoC families

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 +++-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 38169c85e91f..6219337033a0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -171,7 +171,9 @@
 		ranges;
 
 		ethmac: ethernet@ff3f0000 {
-			compatible = "amlogic,meson-axg-dwmac", "snps,dwmac";
+			compatible = "amlogic,meson-axg-dwmac",
+				     "snps,dwmac-3.70a",
+				     "snps,dwmac";
 			reg = <0x0 0xff3f0000 0x0 0x10000
 			       0x0 0xff634540 0x0 0x8>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 6772709b9e19..74d03fc706be 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -486,7 +486,9 @@
 		};
 
 		ethmac: ethernet@c9410000 {
-			compatible = "amlogic,meson-gx-dwmac", "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+			compatible = "amlogic,meson-gxbb-dwmac",
+				     "snps,dwmac-3.70a",
+				     "snps,dwmac";
 			reg = <0x0 0xc9410000 0x0 0x10000
 			       0x0 0xc8834540 0x0 0x4>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.20.1

