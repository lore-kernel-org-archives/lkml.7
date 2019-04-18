Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C24C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBA342183F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Vrs38dCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389122AbfDRNsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:48:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33411 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRNsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:48:53 -0400
Received: by mail-pl1-f193.google.com with SMTP id t16so1219611plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9JIj/FFqgEfC6z9nZwVGyT2L22JvM9xjpTRFOThEtFc=;
        b=Vrs38dCLyUXxathXpkT/flQtsQ2345qx7Nt6l7gmOet0Oinsav3KUzNfaJyYgPECzv
         XwcKxmNmOrFyu5v8pXVYTT3k4rYxqnmRfWDg3qLjhaW4GUed/v5j006rYK/0vEu3Sw5N
         ISlSCH5mLJD3dF0fCLAK1S3MDBakqk/95J3y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9JIj/FFqgEfC6z9nZwVGyT2L22JvM9xjpTRFOThEtFc=;
        b=HneYc/Th2Xdq5fan3fE5/0STb86e6qdXSJqIl2yYxDw5UtEtEhAV8hQsZZvQH+4OsW
         XUAydnLyU5KZ5wHMLl985fI2066DzVT0B2mg9eYKmRwPEv9a6nFkLSmAgPYsug7j383v
         EZwu9br+GZMfvFFmSBLHfqECn6DZOyT2oRwJWSBvu+mqT2Dd2tZ1GUMBSbarXEH020pW
         SGgcPAHTpDkSHUPOsHODnSdFuxgXbVNXu/Bd9yCG70rI1P2wkDS7SnsMUDuFzM0BAJyq
         p2uM0qtgR70kcHiIqilv1wayyqZWhBqM6FzJQIzgsh1Ob3hd5eVDaRmzHRV1oogLSLQv
         7AvQ==
X-Gm-Message-State: APjAAAVK+R/DJCHH8mKVMNXbfuLUiX1llr5AViVolnXH/kd0nTDmIhSN
        /HvBcUi0RzruVhqgqA9FH2JIHQ==
X-Google-Smtp-Source: APXvYqz2X0dg7ynuL6jJWAF1o3vNjKLj0K/cqS/UP7eMUKal73O+ma0bfspjja4rb6gGPhwSbeKzaA==
X-Received: by 2002:a17:902:a704:: with SMTP id w4mr92370617plq.51.1555595332489;
        Thu, 18 Apr 2019 06:48:52 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id x8sm2348377pgp.48.2019.04.18.06.48.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:48:51 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 1/2] arm64: dts: allwinner: a64-amarula-relic: Add GT5663 CTP node
Date:   Thu, 18 Apr 2019 19:18:37 +0530
Message-Id: <20190418134838.8806-1-jagan@amarulasolutions.com>
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
Changes for v3:
- Use 2.8v for reg_ldo_io0
Changes for v2:
- drop i2c1, bias-pull-up

 .../allwinner/sun50i-a64-amarula-relic.dts    | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index 3575db216016..bd31a4385bc1 100644
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
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vcc-ctp";
+	status = "okay";
+};
+
 &reg_rtc_ldo {
 	regulator-name = "vcc-rtc";
 };
-- 
2.18.0.321.gffc6fa0e3

