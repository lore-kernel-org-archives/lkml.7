Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DDAC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AC92147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:50:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rZ0/h3WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfFQPuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:50:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44765 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfFQPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:50:35 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so5897731pfe.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zz2MERF3vMMa7M8ZtZ0+2jO5Nx0ESJTwlcECDNJk018=;
        b=rZ0/h3WPcaOINELXKCdM+10e1Qd0n0fNd8AKVHRGSWUF2coevwMbg2QRnLtYYU4uHO
         ZFf0Wz2rc3zBYLgwuT8jnOvEkJc4ZCdyp7Do1sY01x7Y7SZpnZP8xTVQBsHu1T6oBaqh
         0j5Z0YszZ0pfuDy6VAfi3AET7hS+2LOpURyyqurDcW3ETmkpiimtVHgGXc2F+7mfAMqa
         P9kLn8knOYSziTpVY8oX8lDiwjL5+T8WxZGJjhBEY/dr3ntcL3rKevs2EKMCOzWOQsr7
         05d6XpXKCGVkGPTe4FRKtmqRSwxycuaaH75e06YtydM5iWUJRDLXeZ0gqJd3O71+Q0Ql
         OIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zz2MERF3vMMa7M8ZtZ0+2jO5Nx0ESJTwlcECDNJk018=;
        b=kPubW+Ug3TqMXyUO3xA5LO8+R5Mm9PM4M4BexoE3CbSqXl5ZyGsWDPAFSKvUI2WjBK
         UYrBarWHx2hMsxSuDCfMM5T8nQo9A07HAV2xUYb1X26buQoCqyr1bvJ9TYfaR+HpycVh
         ZxwasKYzAAQp2fI1B7fHp+ZpqXVQ7TSTPDA1zl6Jgcgj+D2cZrnTxUXlCeDoAWmEnwGA
         djxdm6DhLL8zzSdJtZ7TTsVj5wNr4mDsqB1+IbI55dx4E8YllTGk9aHHOD8kd6QbRHqY
         H5i/L+oca6xok4GIq7reXWgSenv0C9oTscD59ezpbzjA6STpfgNOZjjxJRrohBQ/0d8P
         PqLA==
X-Gm-Message-State: APjAAAWineHi9F35zoOs2xdvkFnEoh91rCc1JzITS0KxBzsknstoXXGC
        ASOnN+AL/jFD4TKG8WLQvorMyrJqhg==
X-Google-Smtp-Source: APXvYqxw/4Q8hUnVWwTcJVFxM+HFeyv37RJDbHjt8u0ActxcgByyLdHCE8k4iIwSGJR+h/Rs+VK2vw==
X-Received: by 2002:a63:50a:: with SMTP id 10mr50886468pgf.213.1560786634300;
        Mon, 17 Jun 2019 08:50:34 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:629b:c246:9431:2a24:7932:6dba])
        by smtp.gmail.com with ESMTPSA id n2sm11023603pff.104.2019.06.17.08.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:50:33 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     afaerber@suse.de, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/4] dt-bindings: mfd: Add Actions Semi ATC260x PMIC binding
Date:   Mon, 17 Jun 2019 21:20:08 +0530
Message-Id: <20190617155011.15376-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree binding for Actions Semi ATC260x PMICs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/mfd/atc260x.txt       | 162 ++++++++++++++++++
 1 file changed, 162 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atc260x.txt

diff --git a/Documentation/devicetree/bindings/mfd/atc260x.txt b/Documentation/devicetree/bindings/mfd/atc260x.txt
new file mode 100644
index 000000000000..c72790132ed7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atc260x.txt
@@ -0,0 +1,162 @@
+Actions Semi ATC260X PMIC
+
+The atc260x family current members:
+atc2609a
+
+Required properties:
+- compatible: "actions,atc2609a"
+- reg: I2C slave address
+- interrupts: The interrupt line the IRQ signal for the device is connected to
+
+Optional ATC2609A properties:
+- vcc0-supply:  The input supply for DCDC_REG0
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc5-supply:  The input supply for LDO_REG0
+- vcc6-supply:  The input supply for LDO_REG1
+- vcc7-supply:  The input supply for LDO_REG2
+- vcc8-supply:  The input supply for LDO_REG3
+- vcc9-supply:  The input supply for LDO_REG4
+- vcc10-supply:  The input supply for LDO_REG5
+- vcc11-supply:  The input supply for LDO_REG6
+- vcc12-supply: The input supply for LDO_REG7
+- vcc13-supply: The input supply for LDO_REG8
+- vcc14-supply: The input supply for LDO_REG9
+
+Regulators: All the regulators of ATC260X to be instantiated shall be
+listed in a child node named 'regulators'. Each regulator is represented
+by a child node of the 'regulators' node.
+
+	regulator-name {
+		/* standard regulator bindings here */
+	};
+
+Following regulators of the ATC2609A PMIC regulators are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in ATC2609A datasheet.
+
+	- DCDC_REGn
+		- valid values for n are 0 to 4.
+	- LDO_REGn
+		- valid values for n are 0 to 9
+
+Standard regulator bindings are used inside regulator subnodes. Check
+  Documentation/devicetree/bindings/regulator/regulator.txt
+for more details
+
+Example:
+	atc260x: pmic@65 {
+		compatible = "actions,atc2609a";
+		reg = <0x65>;
+		interrupt-parent = <&sirq>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+
+		vcc0-supply = <&reg_5v0>;
+		vcc1-supply = <&reg_5v0>;
+		vcc2-supply = <&reg_5v0>;
+		vcc3-supply = <&reg_5v0>;
+		vcc4-supply = <&reg_5v0>;
+		vcc5-supply = <&reg_3v1>;
+		vcc6-supply = <&reg_5v0>;
+		vcc7-supply = <&reg_5v0>;
+		vcc9-supply = <&reg_5v0>;
+		vcc10-supply = <&reg_5v0>;
+		vcc11-supply = <&reg_3v1>;
+		vcc12-supply = <&reg_3v1>;
+		vcc13-supply = <&reg_5v0>;
+		vddio-supply = <&reg_3v1>;
+
+		regulators {
+			vdd_core: DCDC_REG0 {
+				regulator-name = "vdd_core";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vdd_cpu: DCDC_REG1 {
+				regulator-name = "vdd_cpu";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vddq_1v2: DCDC_REG2 {
+				regulator-name = "vddq_1v2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vcc_3v1: DCDC_REG3 {
+				regulator-name = "vcc_3v1";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <3500000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vdd_cpum: DCDC_REG4 {
+				regulator-name = "vdd_cpum";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			sd_vcc: LDO_REG0 {
+				regulator-name = "sd_vcc";
+				regulator-min-microvolt = <2300000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			wifi_3v3: LDO_REG1 {
+				regulator-name = "wifi_3v3";
+				regulator-min-microvolt = <2300000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			avcc_3v1: LDO_REG2 {
+				regulator-name = "avcc_3v1";
+				regulator-min-microvolt = <2300000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			avcc_1v8: LDO_REG4 {
+				regulator-name = "avcc_1v8";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			avcc_1v0: LDO_REG6 {
+				regulator-name = "avcc_1v0";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <2200000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vcc1v8_io: LDO_REG7 {
+				regulator-name = "vcc1v8_io";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <2200000>;
+			};
+
+			tpvcc_3v1: LDO_REG8 {
+				regulator-name = "tpvcc_3v1";
+				regulator-min-microvolt = <2100000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
-- 
2.17.1

