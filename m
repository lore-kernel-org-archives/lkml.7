Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1805BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5342339D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A5rdT4HD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfHUClD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:41:03 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36200 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfHUClC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:41:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id w2so394275pfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 19:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FU66GPVfZN8JgKU8kNjxX9IZj5LqUswOfS/8LbvL0Pw=;
        b=A5rdT4HD9QdBv87+nLJGRh4qoZfwExZ7d7ZztQcf2ZKRaiRdyqXHHJXaSccAcAD+No
         CComHfHMT4HUQv3AcJiqrQ85WV3rGXu+3Ll8/R1S3TyF3IHeQu/zrqRwo9W8Gr492bY7
         my/BBiH61RBO6atxwkyMWJsmPK4VPRFnsF9M0sgF2b4XQgtu/XM4WU8VJai4OB2Bf9a/
         +Yczmd/6rqB9uqyUL4wh+JjVLlBtC6Z/5OI/QccUC2ifooLXO61fQAutVeEYCrG48F4B
         BpQb6cwj2XKw8C4FJloGFrENz9O4cTOCxD0hImHOh0vSeFHX81pxlVwRY5KaF7dBfk+8
         VKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FU66GPVfZN8JgKU8kNjxX9IZj5LqUswOfS/8LbvL0Pw=;
        b=O1mBPX4WN6u03Tu9os7+a8F6tA5gncqAWTuzi/MXV+EcVSBajyEEmLVKiAjY4EUuqv
         gGpZBNdCn7A2HCvbMf/vlKzI88q13DMccgoWQcjWRR1sIc9KrovnCEdnvh3OX7lF7Rlq
         pxSZyWewZfKL1RHMbo1eZTO7Z6fsDCkmXgPHtq0+fI+hghvu3dvGrHsK5JP4FzKu66iZ
         0u4VGSui0+WrFj+esZkzit/26wH2i/6yD9MfXjPFdX4jChobmJYICdDC04dJQ9+dpF7F
         2KjLnKwYmQn5415kb3pLNL0o+18Y/TuUK3umQ2c98faweUAoTVJuHHO5FuNLkHbyMxB0
         CvVQ==
X-Gm-Message-State: APjAAAU7GBJc9gI50t4UF5c5mspRVOUNYIiUQfxi5npBWl0Iv2CPUsA/
        w1KMcMWgA2Al6BO1XLBcXAwY
X-Google-Smtp-Source: APXvYqxVzXlQu5kw0on7UvilHuuHCQPl50gHFxAu4BtsJa39ikcJ3wjnIh+noEXMSnVIabT3uW6Caw==
X-Received: by 2002:a63:10a:: with SMTP id 10mr27537012pgb.281.1566355261613;
        Tue, 20 Aug 2019 19:41:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7101:175:ddd7:6c31:ebc7:37e8])
        by smtp.gmail.com with ESMTPSA id b126sm26091608pfa.177.2019.08.20.19.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 19:41:01 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     ulf.hansson@linaro.org, afaerber@suse.de, robh+dt@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        thomas.liau@actions-semi.com, linux-actions@lists.infradead.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 4/7] arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
Date:   Wed, 21 Aug 2019 08:10:11 +0530
Message-Id: <20190821024014.14070-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
References: <20190821024014.14070-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add uSD and eMMC support for Bubblegum96 board based on Actions Semi
Owl SoC. SD0 is connected to uSD slot and SD2 is connected to eMMC.
Since there is no PMIC support added yet, fixed regulator has been
used as a regulator node.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../boot/dts/actions/s900-bubblegum-96.dts    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts b/arch/arm64/boot/dts/actions/s900-bubblegum-96.dts
index 732daaa6e9d3..92376b71cb8f 100644
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
 
@@ -23,6 +26,22 @@
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
+
+	vcc_3v1: vcc-3v1 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+		regulator-always-on;
+	};
+
+	sd_vcc: sd-vcc {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.1V";
+		regulator-min-microvolt = <3100000>;
+		regulator-max-microvolt = <3100000>;
+		regulator-always-on;
+	};
 };
 
 &i2c0 {
@@ -241,6 +260,47 @@
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

