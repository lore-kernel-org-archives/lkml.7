Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074A8C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CBE21850
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AWV1HIDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbfG2N0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:26:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51927 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbfG2N0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:26:31 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so53867902wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=psri534TGQYpMyCVplqyeofs1QfcYeU7WkgCVFj60dg=;
        b=AWV1HIDjgaPyw0nsmP5dhe+Ngz4Q0EcGIck4ApWyvgJ6Jfsao8uQogHunjDC5vPPIl
         6t+ZJIQ6U4NZcKHp8Cht/cpY3VCAu9InbjUDPejNj8gdqopzXI6O/jtWRMfV7S/XE4Uq
         B2kcf++11c8rE/XvLeYuAEeH9nTSlASQ2I0O2/pnvhizZWMaRe8XXHlVgwXeXQcAp04y
         SYVhu7zEPj6bDrtR4GdNsXoNc5KCRbuWJq+odgUJFNIgwPIT8Qj8WKgQLvgA1EdkmV51
         FoyY214lee5rtcF7086LpKzz43gbZct/nQL9wg9PtX08ydpTjfSC8y9FhKt5bw0n9mmz
         4KEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=psri534TGQYpMyCVplqyeofs1QfcYeU7WkgCVFj60dg=;
        b=VEQJo+Lcn3ayw/OFuTb0BbgGpK0eFlqWTdRlLO/YmQlzK8awFYP/6Ze+aJgnmDkcjF
         YoFwXAHWT8QEDwO1Ty6DilmuEogJeHQZCXhdDiYMlr8wexfk29bga42SV+C8eXGgYMuh
         hEZTkmLlx8i3oIUsfp7nV1Atcf4Kpiku8Byu1Ky7/RFjSJBhRh6rOyyB5DQO6rF2szwE
         h4GnAn9QssT+nD0vzVWVvmM2WGuEyhcx1QSrAWnucfTMMdo3nUdWFAXKjIOh5m1H5gAo
         oR67qj0PR9v0BpPBLNyCrCYePGGarxQSpGzBkiCNpdN6XMihOFyYo9jmF9QhvtyOwW44
         8P8w==
X-Gm-Message-State: APjAAAXLo24z++lo1HsqVKWDM2+Cz7yd3F8AmP5RnRxtPGjfzSnFLeps
        82T0klj/sdVPVtIk2pET3M7/Qak9F2U=
X-Google-Smtp-Source: APXvYqwFBdSaUVjBx+qD57HcQvEgonQ30assiZ63H4UmIyoLVl92zSebfZNK3fcAdq7+NaGDfpvj4w==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr101165457wmb.19.1564406789577;
        Mon, 29 Jul 2019 06:26:29 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y2sm50270053wrl.4.2019.07.29.06.26.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:26:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 6/6] arm64: dts: meson-g12b-odroid-n2: enable DVFS
Date:   Mon, 29 Jul 2019 15:26:22 +0200
Message-Id: <20190729132622.7566-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729132622.7566-1-narmstrong@baylibre.com>
References: <20190729132622.7566-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable DVFS for the Odroid-N2 by setting the clock, OPP and supply
for each cores of each CPU clusters.

The first cluster uses the "VDDCPU_B" power supply, and the second
cluster uses the "VDDCPU_A" power supply.

Each power supply can achieve 0.73V to 1.01V using 2 distinct PWM
outputs clocked at 800KHz with an inverse duty-cycle.

DVFS has been tested by running the arm64 cpuburn at [1] and cycling
between all the possible cpufreq translations of each cluster and
checking the final frequency using the clock-measurer, script at [2].

[1] https://github.com/ssvb/cpuburn-arm/blob/master/cpuburn-a53.S
[2] https://gist.github.com/superna9999/d4de964dbc0f84b7d527e1df2ddea25f

Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 4e916e1f71f7..777bfb938854 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -115,6 +115,44 @@
 		/* FIXME: actually controlled by VDDCPU_B_EN */
 	};
 
+	vddcpu_a: regulator-vddcpu-a {
+		/*
+		 * MP8756GD Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU_A";
+		regulator-min-microvolt = <721000>;
+		regulator-max-microvolt = <1022000>;
+
+		vin-supply = <&main_12v>;
+
+		pwms = <&pwm_ab 0 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vddcpu_b: regulator-vddcpu-b {
+		/*
+		 * Silergy SY8120B1ABC Regulator.
+		 */
+		compatible = "pwm-regulator";
+
+		regulator-name = "VDDCPU_B";
+		regulator-min-microvolt = <721000>;
+		regulator-max-microvolt = <1022000>;
+
+		vin-supply = <&main_12v>;
+
+		pwms = <&pwm_AO_cd 1 1250 0>;
+		pwm-dutycycle-range = <100 0>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	hub_5v: regulator-hub_5v {
 		compatible = "regulator-fixed";
 		regulator-name = "HUB_5V";
@@ -246,6 +284,48 @@
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&vddcpu_b>;
+	operating-points-v2 = <&cpu_opp_table_0>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu1 {
+	cpu-supply = <&vddcpu_b>;
+	operating-points-v2 = <&cpu_opp_table_0>;
+	clocks = <&clkc CLKID_CPU_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu100 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu101 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu102 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
+&cpu103 {
+	cpu-supply = <&vddcpu_a>;
+	operating-points-v2 = <&cpub_opp_table_1>;
+	clocks = <&clkc CLKID_CPUB_CLK>;
+	clock-latency = <50000>;
+};
+
 &ext_mdio {
 	external_phy: ethernet-phy@0 {
 		/* Realtek RTL8211F (0x001cc916) */	
@@ -317,6 +397,22 @@
 	pinctrl-names = "default";
 };
 
+&pwm_ab {
+	pinctrl-0 = <&pwm_a_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin0";
+	status = "okay";
+};
+
+&pwm_AO_cd {
+	pinctrl-0 = <&pwm_ao_d_e_pins>;
+	pinctrl-names = "default";
+	clocks = <&xtal>;
+	clock-names = "clkin1";
+	status = "okay";
+};
+
 /* SD card */
 &sd_emmc_b {
 	status = "okay";
-- 
2.22.0

