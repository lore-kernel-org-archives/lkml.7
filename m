Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7912C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2DC2184D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 15:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="koaQCYI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbfIPPqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 11:46:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38465 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389439AbfIPPqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 11:46:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id h195so136135pfe.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 08:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nH4eH2+AdUUr/ixPubTt3rBpS2s2N2X/tbfYHc3R6f8=;
        b=koaQCYI/sf25OYQBe6JaYlxFU6qwSJ6+tixnBZk1pjOixcbOlAxK7u4fn4kIT6+6hI
         88SnbXzYYqNKQHlHSm4Ft6hrDz6/OetP2zU+wLoEMdxnZXyVjv8ivHmSnrvDaZCJA9B8
         e7KAjxcmSFiDkte8Vk3dmfv5n5UPxHmfUmddq1hiRWXXXZhgILD+pHM8NW2ZO1PpD84N
         8a/WgV1TsGUXohhn0e+5t96CIzyLTTqukq5noEpz7tWs9uzTxGZwWrmw+QyPj8JthLup
         kxpkHUb35LLJMj1mqf40/xzu4gxj0Qg2RgMOdaIxQbOomnK1xQyEomnf2arLyPE9SHqK
         yCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nH4eH2+AdUUr/ixPubTt3rBpS2s2N2X/tbfYHc3R6f8=;
        b=rK9LcdUeOVKsBe9lBp10hsaRfzwRpYPsGlm8NKqQP/mrYgglnwK7fEAs4i2JLRh0p9
         SoNjJOkBOszEuVGG3Igu30owJaNA7Geq/kv9I7EZWvWOFPN7087VGZ9qOT5gr744ujXC
         mO1w77Xu0N462olLnvaQ+y8/PBfb/GzqKpurdrAKBSnbT5Ftle5fyCoxxM4Yj6NEBMmK
         gxC2HVR8lB71omYnbZ+CpUVCd8bzptw15a1FWs1UzPhc4/PenekO3h3AoMkgO1F3zJaG
         9L0ibwEOM/uR0wBkvR3rjyzmnxmcPuJbR329bK5UclMM33jzgy0RCezSLD9oJI1atSrS
         dn1w==
X-Gm-Message-State: APjAAAVf/F0bb0r6AiDn/RUvbXhetkla6GqBUCUjCdqPBernIQkVRMtd
        /EgnL0wFLwYn3wYmCqViT75c
X-Google-Smtp-Source: APXvYqwKsIFOyVxPhtB9/lB5tMMNYxPewwQo1OQ0Cb2lCA89/PcUjm4K5MHqTG+d8DctO+IY68pL0A==
X-Received: by 2002:a63:31c6:: with SMTP id x189mr19821528pgx.240.1568648798287;
        Mon, 16 Sep 2019 08:46:38 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:90b:91ce:94c2:ef93:5bd:cfe8])
        by smtp.gmail.com with ESMTPSA id s5sm36227670pfe.52.2019.09.16.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 08:46:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 4/7] arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
Date:   Mon, 16 Sep 2019 21:15:43 +0530
Message-Id: <20190916154546.24982-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uSD and eMMC support for Bubblegum96 board based on Actions Semi
S900 SoC. SD0 is connected to uSD slot and SD2 is connected to eMMC.
Since there is no PMIC support added yet, fixed regulator has been
used as a regulator node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/actions/s900-bubblegum-96.dts    | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index 732daaa6e9d3..59291e0ea1ee 100644
--- a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
+++ b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
@@ -12,6 +12,9 @@
 	model = "Bubblegum-96";
 
 	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &mmc2;
 		serial5 = &uart5;
 	};
 
@@ -23,6 +26,24 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	/* Fixed regulator used in the absence of PMIC */
+	vcc_3v1: vcc-3v1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+		regulator-always-on;
+	};
+
+	/* Fixed regulator used in the absence of PMIC */
+	sd_vcc: sd-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+		regulator-always-on;
+	};
 };
 
 &i2c0 {
@@ -241,6 +262,47 @@
 			bias-pull-up;
 		};
 	};
+
+	mmc0_default: mmc0_default {
+		pinmux {
+			groups = "sd0_d0_mfp", "sd0_d1_mfp", "sd0_d2_d3_mfp",
+				 "sd0_cmd_mfp", "sd0_clk_mfp";
+			function = "sd0";
+		};
+	};
+
+	mmc2_default: mmc2_default {
+		pinmux {
+			groups = "nand0_d0_ceb3_mfp";
+			function = "sd2";
+		};
+	};
+};
+
+/* uSD */
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_default>;
+	no-sdio;
+	no-mmc;
+	no-1-8-v;
+	cd-gpios = <&pinctrl 120 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	vmmc-supply = <&sd_vcc>;
+	vqmmc-supply = <&sd_vcc>;
+};
+
+/* eMMC */
+&mmc2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_default>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	bus-width = <8>;
+	vmmc-supply = <&vcc_3v1>;
 };
 
 &timer {
-- 
2.17.1

