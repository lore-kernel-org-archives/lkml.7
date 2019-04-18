Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B1AC10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DE220835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LSbJ75ez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388278AbfDRIgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:36:01 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46056 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRIgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:36:01 -0400
Received: by mail-pl1-f196.google.com with SMTP id bf11so815939plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6qV3KxK0aW64iJSBNcMR5tp9F6Bs2X4FIoa5U3lna/o=;
        b=LSbJ75ezZhJntTsLbqSopErPhnkuwUY2Gie/VmMcw4SA687fAmJDhVSbtn/jzQVmLy
         m+4cDNDrmm8XmEe+Kn7J3o9TyiZ6/hnhQgsoRRYqBS6KqhnpOyqm8XvXb5d9Y47dIwoY
         wHxuOtpNRVaGrBOArpnvailKWGiOXRs2zcbxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6qV3KxK0aW64iJSBNcMR5tp9F6Bs2X4FIoa5U3lna/o=;
        b=H2yBV0ZcRIJOoP7wTaLm3LbETnSjUz3zVTWlFajZLLk+t2oO2eqJsJrtLinVjKU7Hq
         RNTYPXgtEVbFeqqyKAojsE1NZWGFRgn9PoBlLn5vIvEvFAWmdcvHrkfzChBf36PXYUrf
         PU0k5xD2UFPfGzc6YD/g3OMPulctJV4hT0t8uVCZ98V4CcvcoQBE7zYw5Fi9BSqNfn4J
         wJtepB2cpDMXCA/38HLhn4XXvKq6OFfBntWckyN5Iwlfjt5d3jSX6zmgAPdo8yFGs3x0
         hxATumQcLHR9sr1J/HjAEmyBZQFUTftsjDvF25D0clz4Y+bSUOWn++qSG7qiR7X5TLNS
         sk6A==
X-Gm-Message-State: APjAAAXlDnEiPSrQ97hNDCugX8jdRsp/4WmRGjtFkaIMlM/J1TW79WXU
        M9YwnjknI600hOBFp6ziUNSfLA==
X-Google-Smtp-Source: APXvYqxzg1hSklUejgBT7dKI0al5VGUsn8SXsxS44ZTLnty5e1ex4exW31rWRuTXal4LYyjCAeTjvg==
X-Received: by 2002:a17:902:5c5:: with SMTP id f63mr4612220plf.327.1555576557680;
        Thu, 18 Apr 2019 01:35:57 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id s12sm3166255pgc.28.2019.04.18.01.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 01:35:56 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 1/2] arm64: dts: allwinner: a64-amarula-relic: Add GT5663 CTP node
Date:   Thu, 18 Apr 2019 14:05:42 +0530
Message-Id: <20190418083543.11695-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Goodix GT5663 capacitive touch controller node on
Amarula A64-Relic board.

The CTP connected to board with,
- SDA, SCK from i2c1
- GPIO-LD0 as AVDD28 supply
- PH4 gpio as interrupt pin
- PH8 gpio as reset pin
- X axis is inverted
- Y axis is inverted

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- drop i2c1, bias-pull-up 

 .../allwinner/sun50i-a64-amarula-relic.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 3575db216016..3819ce396073 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -49,6 +49,24 @@
 	bias-pull-up;
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt5663";
+		reg = <0x5d>;
+		AVDD28-supply = <&reg_ldo_io0>;			/* VCC-CTP: GPIO0-LDO */
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 8 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH8 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
@@ -212,6 +230,13 @@
 	regulator-name = "vdd-cpus";
 };
 
+&reg_ldo_io0 {
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-ctp";
+	status = "okay";
+};
+
 &reg_rtc_ldo {
 	regulator-name = "vcc-rtc";
 };
-- 
2.18.0.321.gffc6fa0e3

