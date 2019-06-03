Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85535C28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B4FC28073
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 10:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="LaIe2IKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfFCKED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 06:04:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45061 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfFCKEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 06:04:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so11321577wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 03:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwPSWWGObMkHXMOeR+gIVa53r6KxHy0rClRR5SSOu0s=;
        b=LaIe2IKRve/90fzL0agIqUjbzlX+PnoIr8C4ZdXb6ufSpMEAPi3+sMsyto+a3Nmapr
         96FD0oG9ZgU9Io3EsEyulge8RBTorN7CTO+dip+1qKE8RdkLQvU2gZrmjC3dZOz5R4oU
         AA2w53Jlk20uuHZS3He4++2BeNtLS2cbykFarzF7DXYXVrOsvTUV3RZd56ey8COZU6Cj
         l7iMn0Mek6XykBR1AQp6D4++P8dNd1VaizxSc4KlQRiZ+pOJWQlOm6PhRO0f6W1n7YG2
         mTTlV4TQO+YIHBG6f0fn1oSYGZbqWjPSS8AW/gbrzLZ09Ui6yblFSk76wVX5t5lruqiO
         eHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwPSWWGObMkHXMOeR+gIVa53r6KxHy0rClRR5SSOu0s=;
        b=qDX3dtd/gdWRtcjFcI3oOkwpc/DJRXpw+9wXmowAdTzk2oK4SrdN1vQavivg7G2AP7
         wmssuY84dQt6n4+SkQceDsCLjjNIj57Lt8NAOfAtgX5q7k1lyPgZYf+f+W6IniQyoQcG
         /Avv6zuWjZ0caOsozC4s/02rBmhV3zFlr9PuoHgK5y5RrYC9DVs/RvrJ8s9U6Zp+gIoO
         pitC2PnKeNvSiatoJ2GGMIcWxdrb0E/1rz0ccQ1zDjDH8S+UpOLVhD5JHk8B1gS18iTx
         e6AlTxmXEI4q7nxfGDUXLiFcBO97CfCxV5cKOu0KXdc1sgTQRDDxvXbJYFJhQN0jVjfb
         k95w==
X-Gm-Message-State: APjAAAV27D/R0j7s4iQjpFZYfAKgjun5f4PQdveVFm/53yAlbz68CZI8
        EhAnkzo0MLQc8/9ncllXDY3V3Q==
X-Google-Smtp-Source: APXvYqxyGuUH/KVeKqqLhvxZgkmMQha/6dftUknznXW10S/gBILTtO4dIUOAhBdtBbaazM61NZR8Mg==
X-Received: by 2002:a5d:6745:: with SMTP id l5mr1726471wrw.160.1559556240219;
        Mon, 03 Jun 2019 03:04:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o3sm11282098wrv.94.2019.06.03.03.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Jun 2019 03:03:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/4] arm64: dts: meson: g12a: add SDIO controller
Date:   Mon,  3 Jun 2019 12:03:54 +0200
Message-Id: <20190603100357.16799-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603100357.16799-1-narmstrong@baylibre.com>
References: <20190603100357.16799-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

The Amlogic G12A SDIO Controller has a bug preventing direct DDR access,
add the port A (SDIO) pinctrl and controller nodes and mark this specific
controller with the amlogic,dram-access-quirk property.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 37 +++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 840dab606110..9139913387ab 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -1313,6 +1313,30 @@
 						};
 					};
 
+					sdio_pins: sdio {
+						mux {
+							groups = "sdio_d0",
+								 "sdio_d1",
+								 "sdio_d2",
+								 "sdio_d3",
+								 "sdio_cmd",
+								 "sdio_clk";
+							function = "sdio";
+							bias-disable;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+					sdio_clk_gate_pins: sdio_clk_gate {
+						mux {
+							groups = "GPIOX_4";
+							function = "gpio_periphs";
+							bias-pull-down;
+							drive-strength-microamp = <4000>;
+						};
+					};
+
+
 					uart_a_pins: uart-a {
 						mux {
 							groups = "uart_a_tx",
@@ -2303,6 +2327,19 @@
 			resets = <&reset RESET_SD_EMMC_C>;
 		};
 
+		sd_emmc_a: sd@ffe03000 {
+			compatible = "amlogic,meson-axg-mmc";
+			reg = <0x0 0xffe03000 0x0 0x800>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+			clocks = <&clkc CLKID_SD_EMMC_A>,
+				 <&clkc CLKID_SD_EMMC_A_CLK0>,
+				 <&clkc CLKID_FCLK_DIV2>;
+			clock-names = "core", "clkin0", "clkin1";
+			resets = <&reset RESET_SD_EMMC_A>;
+			amlogic,dram-access-quirk;
+		};
+
 		usb: usb@ffe09000 {
 			status = "disabled";
 			compatible = "amlogic,meson-g12a-usb-ctrl";
-- 
2.21.0

