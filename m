Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7870EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4416820656
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="IBJkS7mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389863AbfDRRrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:47:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43708 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389836AbfDRRrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:47:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id c8so1429955pfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vTSnpVfPDJjqTfZA3qDasHHVtLoc8OViA7pV96ip3mc=;
        b=IBJkS7mOpM2Iky0JQFjKJtsoACjqRC5DA1R4hqiPepieccdELfNJiwSriQnZwE2pJg
         32+37RU1bbeWVtqorOtjfIqKaHHTwmmnnvfub899bQhg3iZ/upeevdpS5dJ4FMl/W2dV
         UkEb1pVrAeiy4Z1wwQIf9DXc8fdVREl+JPMuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vTSnpVfPDJjqTfZA3qDasHHVtLoc8OViA7pV96ip3mc=;
        b=MqlHdvPaMqvqoKrFOfmYBLm66hKhCl/Xeiks7h6LUwsw3jKgEdUTS/WdwUP/s83yuD
         obA2mLsoEVOglpQbQmu/NbPEB+NlmdAxJzSSWarcm4E8gKWYFbAPfMyVpm0q/948/Ht8
         s+RyXxf36YAymRtrj2b+2TEgfK+Mj29p7AykJLDxd7FgY0IEsnBRq/eDJxD3X69eeztw
         iGziK1V17YcV5Y8tN+jYP53cmhOaXyhJlZz64vRG7nC+Po0CplgX2cinlGXUR0OFdRVz
         +tiybpwwwBieLYqVqMnDBcQIGgmz2yf0ITnkE/I1tHuGBrkmSMhG4EKIDYgs++5soWx+
         g1Sw==
X-Gm-Message-State: APjAAAV0rMb1OdiNY8wcGU7CySiZX+2m1/aje318byNzNJ9cY+pkt7i7
        NNZ+XwS0uDZDLMuDtMFQMiB69w==
X-Google-Smtp-Source: APXvYqwYl0dGq2ihoOHLZDrrVyT/Nf1VKGwfvOxDvrZ0FV3kGa9J3WzHg3hdnkJYiaNjT2R4HxSu8w==
X-Received: by 2002:a63:ed48:: with SMTP id m8mr76181642pgk.104.1555609658841;
        Thu, 18 Apr 2019 10:47:38 -0700 (PDT)
Received: from localhost.localdomain ([115.97.185.144])
        by smtp.gmail.com with ESMTPSA id j4sm5223547pgi.71.2019.04.18.10.47.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 10:47:38 -0700 (PDT)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        linux-sunxi@googlegroups.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 3/3] arm64: dts: allwinner: a64-oceanic-5205-5inmfd: Enable GT911 CTP
Date:   Thu, 18 Apr 2019 23:17:20 +0530
Message-Id: <20190418174720.17230-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190418174720.17230-1-jagan@amarulasolutions.com>
References: <20190418174720.17230-1-jagan@amarulasolutions.com>
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
Changes for v4:
- drop i2c0 pinctrl
Changes for v3:
- Use 2.8v for reg_ldo_io0
Changes for v2:
- drop i2c1, bias-pull-up

 .../sun50i-a64-oceanic-5205-5inmfd.dts        | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
index 6a2154525d1e..787ebd805a3b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-oceanic-5205-5inmfd.dts
@@ -37,6 +37,22 @@
 	status = "okay";
 };
 
+&i2c0 {
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
@@ -52,6 +68,13 @@
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

