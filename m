Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82256C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505F42083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 13:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="a2bHRvt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389156AbfDRNs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 09:48:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38672 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389123AbfDRNs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 09:48:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so1234846pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 06:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9ohN5ybpadpOS01kjPnorYpbIIGcYKvbOgHH+YSoCk=;
        b=a2bHRvt1iVolmuo5O0BNyiECTwH6NnzZybj9gNoPBWNhuQcSkt2Cvl/spm5YEX/Rfh
         p5uUVz+RtrbV/iDfOgvlh/C6IvpFrgcalcPLy0ORNoLjeSOLHzUB13IElv2vfHahguMG
         pe88PmKzOIFD2b1bDZ0aRnY/aVmpKVMpFO6N4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9ohN5ybpadpOS01kjPnorYpbIIGcYKvbOgHH+YSoCk=;
        b=qmpeQEgYT9rAn4TRckVa9qCaC9GhTIMv129nm3nSBGjT/iHVPMrV4udeKWKymQBqTK
         v8NtN6NU8rlmaB1ouKEu4JrTwaF5BcE9d3TJhF69SCFEwJnvZhSwwBbX2Iaqb/HryMvM
         fK2hUBcZiUHWpCl3d8eXrDQ8lDwZ2023pkneZmkgDFc5WF4otfPHGv3fcnUjc3GNGIk2
         WpwuiLfL79Sd4GZ8upQzr6x95WgFDGO8Kgy21KDka8TyQ+ZnpV3bWM4XKpcYfnTmMnfr
         hCatzH12CNFocU55PCHqwy4oLLvP/dQXmJh9So+7BPPfb/wglIO7lEvblcDNS6RzfiXb
         Xh4A==
X-Gm-Message-State: APjAAAVGYkbpx62VWxbXZs8lVck8fv5CYYR+2ht4Rg6DZUx21PHDKkCz
        O+tzpqOtljOCmVBYdxPeZ4BsyA==
X-Google-Smtp-Source: APXvYqyA0ptZipWoRdYX1TSSnPx4grq/NpAOTUETMUFdLt6IsDwHZsgrKBW983t+4/NVeJw34yn7kA==
X-Received: by 2002:a65:4589:: with SMTP id o9mr72189786pgq.381.1555595337119;
        Thu, 18 Apr 2019 06:48:57 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id x8sm2348377pgp.48.2019.04.18.06.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 06:48:56 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 2/2] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable GT911 CTP
Date:   Thu, 18 Apr 2019 19:18:38 +0530
Message-Id: <20190418134838.8806-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190418134838.8806-1-jagan@amarulasolutions.com>
References: <20190418134838.8806-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Goodix GT911 CTP is bound with Oceanic 5205 5inMFD board.

The CTP connected to board with,
- SDA, SCK from i2c0
- GPIO-LD0 as AVDD28 supply
- PH4 gpio as interrupt pin
- PH11 gpio as reset pin
- X axis is inverted
- Y axis is inverted

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v3:
- Use 2.8v for reg_ldo_io0
Changes for v2:
- drop i2c1, bias-pull-up

 .../sun50i-a64-oceanic-5205-5inmfd.dts        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
index 6a2154525d1e..f0cd6587f619 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -37,6 +37,24 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	touchscreen@5d {
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+		AVDD28-supply = <&reg_ldo_io0>;			/* VDD_CTP: GPIO0-LDO */
+		interrupt-parent = <&pio>;
+		interrupts = <7 4 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&pio 7 4 GPIO_ACTIVE_HIGH>;	/* CTP-INT: PH4 */
+		reset-gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>;	/* CTP-RST: PH11 */
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+};
+
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
@@ -52,6 +70,13 @@
 	regulator-name = "vcc-phy";
 };
 
+&reg_ldo_io0 {
+	regulator-min-microvolt = <2800000>;
+	regulator-max-microvolt = <2800000>;
+	regulator-name = "vdd-ctp";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.18.0.321.gffc6fa0e3

