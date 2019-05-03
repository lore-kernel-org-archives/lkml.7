Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1745C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7278F206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 11:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="I7fOhnOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfECL7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 07:59:49 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37991 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfECL7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 07:59:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id j26so2639446pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 04:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJmfFw0q35lTjOMKi7JKfHPrHE1C5yCWa/soMCMhwUs=;
        b=I7fOhnOZJa+A0py26DsoUKzEdhCQ1Na8LcD3krdUX08liXV16VPm+vpVVvESTUGXqb
         raRABPxt/2QfdgUMAnAmMAZLdEoKSABgxP23+lYRierkNQgvlukHAOs1btvDIbNaZgzy
         dqWrouzbFseyrMB0cLM1C1o38DY6+iQEYa98Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJmfFw0q35lTjOMKi7JKfHPrHE1C5yCWa/soMCMhwUs=;
        b=h4EQJE/fkESsddWYWh4nYmvuNGVVo/hFrGaaJ6/zvro+VaRKT6QR8xAqcgvskSdqrd
         dH0smVy0CsEO81mjqujl8BuMgDe4R8uwxvFwBFmAh6F4H2JfRoEm7L2vlgERRKMJ4+Ps
         /kBLXK+Cf3zTUmshCmTIKUpGFEoEazxfrO8Uf6MIwFSDb4iY7V5dO4qKpWqXkzledLxA
         ++ncyrfVEaVPjyNrFzHOnpE2dC/At3BXUvff5+mnmhpXBtf9Fioh2w2VzE9mV1HF4F2/
         LIViMYmeo45x7s3en67h8XYs7IaAVXJHFzY8nu/8/s5rtUjoSegd5JQEibgDC8+nzO6R
         ZflA==
X-Gm-Message-State: APjAAAWjq47XrHTCWv4AqwxMasBHAlvAq2z7VrF5/psAqvs61P800Khs
        RtAYtHZ3sqrS//4lixM3vrbBGQ==
X-Google-Smtp-Source: APXvYqw45KysPDN37fptBttFYc0YSEKsnoAUh7GJerGfOPX/+DYNbUqT6l2ZfOY6T9cbIlI5Yeeltg==
X-Received: by 2002:a63:1604:: with SMTP id w4mr9850811pgl.148.1556884787760;
        Fri, 03 May 2019 04:59:47 -0700 (PDT)
Received: from localhost.localdomain ([49.206.203.165])
        by smtp.gmail.com with ESMTPSA id f5sm2235940pgo.75.2019.05.03.04.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 04:59:47 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2] arm64: allwinner: h6: orangepi-one-plus: Add Ethernet support
Date:   Fri,  3 May 2019 17:29:28 +0530
Message-Id: <20190503115928.27662-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ethernet support for orangepi-one-plus board,

- Ethernet port connected via RTL8211E PHY
- PHY suppiled with
  GMAC-2V5, fixed regulator with GMAC_EN pin via PD6
  GMAC-3V, which is supplied by VCC3V3-MAC via aldo2
- RGMII-RESET pin connected via PD14

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- emac changes on top of https://patchwork.kernel.org/cover/10899529/
  series

 .../allwinner/sun50i-h6-orangepi-one-plus.dts |  8 ++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     | 42 +++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
index 12e17567ab56..9e8ed1053715 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
@@ -9,4 +9,12 @@
 / {
 	model = "OrangePi One Plus";
 	compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
+
+	aliases {
+		ethernet0 = &emac;
+	};
+};
+
+&emac {
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 62e27948a3fa..c48e24acaf8a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -45,6 +45,48 @@
 		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
 	};
+
+	/*
+	 * The board uses 2.5V RGMII signalling. Power sequence to enable
+	 * the phy is to enable GMAC-2V5 and GMAC-3V (aldo2) power rails
+	 * at the same time and to wait 100ms.
+	 */
+	reg_gmac_2v5: gmac-2v5 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-2v5";
+		regulator-min-microvolt = <2500000>;
+		regulator-max-microvolt = <2500000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* GMAC_EN: PD6 */
+
+		/* The real parent of gmac-2v5 is reg_vcc5v, but we need to
+		 * enable two regulators to power the phy. This is one way
+		 * to achieve that.
+		 */
+		vin-supply = <&reg_aldo2>; /* VCC3V3-MAC: GMAC-3V */
+	};
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ext_rgmii_pins>;
+	phy-mode = "rgmii";
+	phy-handle = <&ext_rgmii_phy>;
+	phy-supply = <&reg_gmac_2v5>;
+	allwinner,rx-delay-ps = <1500>;
+	allwinner,tx-delay-ps = <700>;
+};
+
+&mdio {
+	ext_rgmii_phy: ethernet-phy@1 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <1>;
+
+		reset-gpios = <&pio 3 14 GPIO_ACTIVE_LOW>; /* RGMII-RESET: PD14 */
+		reset-assert-us = <15000>;
+		reset-deassert-us = <40000>;
+	};
 };
 
 &ehci0 {
-- 
2.18.0.321.gffc6fa0e3

