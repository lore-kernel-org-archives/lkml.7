Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C038AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA9C2189D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwTmL3UF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfH1U1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:27:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41557 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfH1U1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:27:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so310937pgg.8;
        Wed, 28 Aug 2019 13:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j1pl7hKHvoRN9rKZ44OFvuHqn1oOaD+2L3N6f/r4iwo=;
        b=bwTmL3UFS/3ZHo2sB29Zs6EIFhpyS4XPne89/9dyM+rewUVwIhbpFFHv+5Hzj96cGU
         kqsxKPvxSE6UXpg1xk6PQ3oGOoq2tf97SMwCDgzEMhffbyQEAfBUcDLvB+N5SJrCbtPX
         J3kX560Q9sEC5574UjhBr5agzBW6kkKkBXh8BkthKW2pLVkPDmHeeuigzN5l+xqbdtr4
         qVaivr0uFagenYzoSOtDE/Oz+G8qfvWDZeB78DpPerJMwwfEoSxPhcUXM4tDle8qDB0F
         juQ9tLSoPMo+ifHQzm1HRVvogmThCRswBu43ADIwufvbK7dR42euG5SXvf8UVAJPs6X3
         BehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j1pl7hKHvoRN9rKZ44OFvuHqn1oOaD+2L3N6f/r4iwo=;
        b=OdCv4rhk1Sb6vA8DSuW3sxiNZRd0UDXPNmoLEhlcNwgq+MLawOkOXpZKNkZ5RukFCa
         ov3PdkRZKI4HvFwBgGWgKP395hQrVRhiF59sLmUywD2hRm5zbnmGeWMAgJBluLW+Broq
         W+Mnc7hDFe7xIiqrHtTxpjRMEGLVUP7kl4cj9Lj5HLroioourehm2UXgj+EY6hft3ywD
         u1uz9BKVGi/FSpYBHcPJvO1uyEdlSipmdOi89iasKAptsDl9jJgkgeRYwplxvGgtCvSG
         XCj8IaC9gvHooGE31NGA9q1dEBmSYqeHwQIT38ZztGd7bSW7kxU2R2nUiv/Ru+z+fwmw
         6/9w==
X-Gm-Message-State: APjAAAUfuouMkmwoMNTQtaIj97paVTDJYFWQzEEuYZUOinW2SI//FpbM
        LlqJrkc0etTJW/to9o4elHU=
X-Google-Smtp-Source: APXvYqzMIFDEdoAuL1ig04OF0ieGs/x4bz10vDEIipXOU7KSUPo5K4JME5xcSl3J2TTzgdk/CXa/9g==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr5951116pja.135.1567024058007;
        Wed, 28 Aug 2019 13:27:38 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.111])
        by smtp.gmail.com with ESMTPSA id g2sm253373pfq.88.2019.08.28.13.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 13:27:37 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCHv1 1/3] arm64: dts: meson: odroid-c2: Add missing regulator linked to P5V0 regulator
Date:   Wed, 28 Aug 2019 20:27:21 +0000
Message-Id: <20190828202723.1145-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190828202723.1145-1-linux.amoon@gmail.com>
References: <20190828202723.1145-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per shematics VDDIO_AO18, VDDIO_AO3V3/VDD3V3 DDR3_1V5/DDR_VDDC:
fixed regulator output which is supplied by P5V0.

Rename vcc3v3 regulator node to vddio_ao3v3 as per shematics.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 29 +++++++++++++++++--
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 792698a60a12..98e742bf44c1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -104,11 +104,34 @@
 		regulator-max-microvolt = <1800000>;
 	};
 
-	vcc3v3: regulator-vcc3v3 {
+	vddio_ao1v8: regulator-vddio-ao1v8 {
 		compatible = "regulator-fixed";
-		regulator-name = "VCC3V3";
+		regulator-name = "VDDIO_AO1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+		/* U17 RT9179GB */
+		vin-supply = <&p5v0>;
+	};
+
+	vddio_ao3v3: regulator-vddio-ao3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		/* U11 MP2161GJ-C499 */
+		vin-supply = <&p5v0>;
+	};
+
+	vddc_ddr: regulator-vddc-ddr {
+		compatible = "regulator-fixed";
+		regulator-name = "DDR_VDDC";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+		/* U15 MP2161GJ-C499 */
+		vin-supply = <&p5v0>;
 	};
 
 	emmc_pwrseq: emmc-pwrseq {
@@ -301,7 +324,7 @@
 	mmc-hs200-1_8v;
 
 	mmc-pwrseq = <&emmc_pwrseq>;
-	vmmc-supply = <&vcc3v3>;
+	vmmc-supply = <&vddio_ao3v3>;
 	vqmmc-supply = <&vcc1v8>;
 };
 
-- 
2.23.0

