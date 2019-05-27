Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF78FC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E192075E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Sj/HPZdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfE0NWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:22:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42006 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE0NWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:22:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so16927371wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xq9gvQaTQshE54UN9urwGrJ/PW8MDhPcWZeqXmPnPkI=;
        b=Sj/HPZdj48Z931rhJgvmsSPg9x9RDBV6Vit7NVMr2+2LmFrs6YkavcRnQIACyyEKBC
         JB0eMOnlCkYUukcQew4/e5m9adRogWJzukVijek3voT9e65KbjkKgWGfz+8Ik/PYiH+S
         7gEPfLx8YV7Z/5btip0Pt42tqUfMg9mlMcwEJGd0dm7jX+Ty4EuFLj3C6w+bn7xQ64df
         hp5fOf44UKaxglgAZT+ff0QGs5Pb+5dqow2cPeOcf8NM/PKBzk5R+gjRsH68gIZt/c40
         FmoT3ky2FPe7kyltE3xMM/M7hovEjwNe9oFjSZ6Lfa22Xqha4QFpok8rJ0LbIv9n9RWf
         BLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xq9gvQaTQshE54UN9urwGrJ/PW8MDhPcWZeqXmPnPkI=;
        b=jL3bLepxKodgeYtAgmlR5H/4zkN+dN7CzTDeh92VBU2FNqR/l9ZWyUNwgQNgeV3m3Z
         uZUbIdTUX1L+dPhd12zM4TpivGhmOYlOsCUM+WA60GPMlzCKIuZDaRdgC5LSQJt8uD6l
         VSqMS3zk5yEQCEIMr1AuH+koMqrFEhGpzZv0IpQFDnQV6V34yn6+yNOU3Gp97meeHjNz
         ynjb1J97xNDRDbyr+S1ZFST+rza8soSJkHHrgVw6wqM7ka40WH7l5JzIsmdY6SRnutED
         4O3sz66+jDy4xLWYvv85iBl1Z/GH1+/uzaZ8DEfhsttWoR+j+tPIrCIQy/UsWiImbCMW
         9WOw==
X-Gm-Message-State: APjAAAXNmq1YYLiNU2pxrflxdcMlWEJWI/p98ae8BLm21JV8JondBTmz
        UWy54TOQ7GGGMccS6qeKlA/Gzg==
X-Google-Smtp-Source: APXvYqyMfifY65haasTe+0rgvLhCeYDfEiW9wVbHqKfZPRH8VMKJlHQZKtU/12FI2Cwvig9Y8yUxLg==
X-Received: by 2002:adf:b446:: with SMTP id v6mr75583998wrd.30.1558963330491;
        Mon, 27 May 2019 06:22:10 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l12sm7019836wmj.22.2019.05.27.06.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:22:09 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christianshewitt@gmail.com
Subject: [PATCH 09/10] arm64: dts: meson-gxbb-vega-s95: fix WiFi/BT module support
Date:   Mon, 27 May 2019 15:21:59 +0200
Message-Id: <20190527132200.17377-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527132200.17377-1-narmstrong@baylibre.com>
References: <20190527132200.17377-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the SDIO WiFi support and add proper Bluetooth support on the
Vega S95 board.

Suggested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi  | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 4d2aa4dc59e7..9b52f3dcdd49 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -93,8 +93,7 @@
 
 	sdio_pwrseq: sdio-pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>,
-				<&gpio GPIOX_20 GPIO_ACTIVE_LOW>;
+		reset-gpios = <&gpio GPIOX_6 GPIO_ACTIVE_LOW>;
 		clocks = <&wifi32k>;
 		clock-names = "ext_clock";
 	};
@@ -167,7 +166,7 @@
 /* Wireless SDIO Module */
 &sd_emmc_a {
 	status = "okay";
-	pinctrl-0 = <&sdio_pins &sdio_irq_pins>;
+	pinctrl-0 = <&sdio_pins>;
 	pinctrl-1 = <&sdio_clk_gate_pins>;
 	pinctrl-names = "default", "clk-gate";
 	#address-cells = <1>;
@@ -229,6 +228,19 @@
 	vqmmc-supply = <&vddio_boot>;
 };
 
+/* This is connected to the Bluetooth module: */
+&uart_A {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		shutdown-gpios = <&gpio GPIOX_20 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+/* This UART is brought out to the DB9 connector */
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.21.0

