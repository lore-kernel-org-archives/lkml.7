Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A377C3A5A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D6A233FE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pAj6gXZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfHUOU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:20:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45372 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfHUOU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:20:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id q12so2198859wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 07:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAP1onnqXTzP/lvNpHvvz2UdnrOcw8U+6337qerbDS8=;
        b=pAj6gXZSmQY63NCHL74oE4dUYzy2conZuGZKMrHcQ8dFBZk4xZKCcF569gE8DG8yX2
         41g1BLBzwPbS9/gq1k1rXEfFpX04K3JOt8Ic59XAGA6XSqgOAi427bH9818L35i+hiDY
         rprG0fXDwO2HM9fvCSULC6hX83fO++VOSseEP0toge8degLpXt/9xgqKbLIJVV++RhaC
         tp9bchzxyuk2oFL3AGjLImSfQbiMS5yEZlaOsvrsDJKwkDEK003mJg4Yh2MxiK6Xkm/r
         7SFlYlelfAoOFjoIQjD8g72WEpv7cH7djvSwkixH+TpDLGX41sFzFK1j4BPCZBT7OL8w
         FUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAP1onnqXTzP/lvNpHvvz2UdnrOcw8U+6337qerbDS8=;
        b=L5UgF3dBsHgkiwie/CeSvFdCfXQ6CfvV8EYZQpwjHNIffibjqD970endSj9KomOkwk
         CvOUiioo/fhs4+/eIgaO5zTVkli6xX+jIwq8OkoMKfj0dwkcmsAmWczml+TDQR6AcO1/
         znIMt+TafTmgugBh6oz6Cq/osjgmHWpsqmWHFDxHFVPlPNw21j4a8vWzhhUhXK9/FRn/
         NXZRyUaBcP3sbz0sJx+jLB34/CdGhsUesX6eBfsLe9OcUDXDWPq3fMg8sBOCrQdhz9w1
         K3mYVcw9zE0CXHGQB5ULHtdBJKN4VRIKsxr0jGYglclLrb6/Cnp/f0o+Qd05ibR+kzz3
         5iuw==
X-Gm-Message-State: APjAAAWErNc1nZa1e2IDv1G+La+KtTf/BCpJuJMAqk+G1Pz5b9oN+QY6
        7sKjxSzjRaK3ShslGRF6sDdYzl21sp594Q==
X-Google-Smtp-Source: APXvYqyao145aZphdebE9ne8Van69sub9EKRL8yfyjYDM6LtGh2JA3XPFvYbCsnwXYhL4YBE/YOoGQ==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr32619231wrs.108.1566397253939;
        Wed, 21 Aug 2019 07:20:53 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o9sm33418939wrm.88.2019.08.21.07.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:20:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 01/14] arm64: dts: meson: fix ethernet mac reg format
Date:   Wed, 21 Aug 2019 16:20:30 +0200
Message-Id: <20190821142043.14649-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190821142043.14649-1-narmstrong@baylibre.com>
References: <20190821142043.14649-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the following DT schemas check errors:
meson-axg-s400.dt.yaml: soc: ethernet@ff3f0000:reg:0: [0, 4282318848, 0, 65536, 0, 4284695872, 0, 8] is too long
meson-axg-s400.dt.yaml: ethernet@ff3f0000: reg: [[0, 4282318848, 0, 65536, 0, 4284695872, 0, 8]] is too short
meson-g12a-u200.dt.yaml: soc: ethernet@ff3f0000:reg:0: [0, 4282318848, 0, 65536, 0, 4284695872, 0, 8] is too long
meson-g12a-u200.dt.yaml: ethernet@ff3f0000: reg: [[0, 4282318848, 0, 65536, 0, 4284695872, 0, 8]] is too short
meson-gxbb-nanopi-k2.dt.yaml: soc: ethernet@c9410000:reg:0: [0, 3376480256, 0, 65536, 0, 3364046144, 0, 4] is too long
meson-gxl-s805x-libretech-ac.dt.yaml: soc: ethernet@c9410000:reg:0: [0, 3376480256, 0, 65536, 0, 3364046144, 0, 4] is too lon

while here, also drop the redundant reg property from meson-gxl.dtsi
because it had the same value as meson-gx.dtsi from which it inherits.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi  | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 3 ---
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 6219337033a0..4a134d29491d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -174,8 +174,8 @@
 			compatible = "amlogic,meson-axg-dwmac",
 				     "snps,dwmac-3.70a",
 				     "snps,dwmac";
-			reg = <0x0 0xff3f0000 0x0 0x10000
-			       0x0 0xff634540 0x0 0x8>;
+			reg = <0x0 0xff3f0000 0x0 0x10000>,
+			      <0x0 0xff634540 0x0 0x8>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			clocks = <&clkc CLKID_ETH>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index f8d43e3dcf20..465106d37289 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -141,8 +141,8 @@
 			compatible = "amlogic,meson-axg-dwmac",
 				     "snps,dwmac-3.70a",
 				     "snps,dwmac";
-			reg = <0x0 0xff3f0000 0x0 0x10000
-			       0x0 0xff634540 0x0 0x8>;
+			reg = <0x0 0xff3f0000 0x0 0x10000>,
+			      <0x0 0xff634540 0x0 0x8>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			clocks = <&clkc CLKID_ETH>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 74d03fc706be..faff77175486 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -489,8 +489,8 @@
 			compatible = "amlogic,meson-gxbb-dwmac",
 				     "snps,dwmac-3.70a",
 				     "snps,dwmac";
-			reg = <0x0 0xc9410000 0x0 0x10000
-			       0x0 0xc8834540 0x0 0x4>;
+			reg = <0x0 0xc9410000 0x0 0x10000>,
+			      <0x0 0xc8834540 0x0 0x4>;
 			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq";
 			status = "disabled";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index c959456bacc6..ee1ecdbcc958 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -80,9 +80,6 @@
 };
 
 &ethmac {
-	reg = <0x0 0xc9410000 0x0 0x10000
-	       0x0 0xc8834540 0x0 0x4>;
-
 	clocks = <&clkc CLKID_ETH>,
 		 <&clkc CLKID_FCLK_DIV2>,
 		 <&clkc CLKID_MPLL2>;
-- 
2.22.0

