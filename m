Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FE0C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261982075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="nWoqbLTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfDDNMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:12:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38500 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfDDNL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:11:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so3759340wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W34/cfcT6NSknRmwI1jY9uNwLfZHBK33QyXRjlFTgPM=;
        b=nWoqbLTFHP0Hbvks+1VbStS8n6ieZIS3NcTMMJ6zh1JNh+jy8OPOkkCEkhqIgCwuRc
         WiVLdCukT2E0aUqL7LRInMoDNs/MfDicoT89ZtuDuGpmIp2u4CBR36EU0u1s5ZCCwX2C
         z4Y3sGzm4nHJDjllJngjY3DijgoPft4lnsxHEV4Ych7nQLIxEHl1sAz35qyehHLeXsWz
         1kG4OapmBUCRl8sCztE2ab9Sr2kH13det5do8lsZ/ItYdzec+Mm3qLyz1M52yf32Za6I
         dAjuFfoih3r0H/YqG6Y0ksIHixXyRX2iK0TTJxJVYFLyJIBLVlos5NUnSWh604nNMfWB
         GMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W34/cfcT6NSknRmwI1jY9uNwLfZHBK33QyXRjlFTgPM=;
        b=qW7wVYB1+Kx+/tHxw2lgWNKEg0wmPX8k+rrE50+esyrpYopDU3mA5lX+J44a1qCbbq
         IUxN2qtH8i/evblL6+6Hk8H2vaAi5pZiAVER9Htn1G3ZFTzFSc0knPn6OlwkAM8jZ7ec
         A6A3yqrk5VRfKUtbErGvd9kk7LTv1nAl9/p7tuIjnVJ4FHsLmfX4T/iiSTMu/ExeP/6f
         9sa7mrEx/AiN0TVGKWAHRwXXSWL+USglV9CAhdofzI42IgDTjXE9H3H1cGAB97UaLiwb
         kgPyrHWH/s7jxGY6Y5yEtto6HBiI6blX/XMLOnEO6OrnRJsLGSMXrKbEwUj/TWtFY09C
         IfAQ==
X-Gm-Message-State: APjAAAVANvJHaRV2tSoBJE+11g98cZLV6q6E+GFhe6cNze20RzoFcA4w
        uaTcvvvknNcpy0ezoVm0H0NSQQ==
X-Google-Smtp-Source: APXvYqwC07qOfvheUKwy+EPsGt1K8mvjN63PoY7Fs/+CwkaKeEEcVIPMtHBoKvX3o+q3Y9GpQkvfEQ==
X-Received: by 2002:adf:fe4d:: with SMTP id m13mr4236000wrs.267.1554383517539;
        Thu, 04 Apr 2019 06:11:57 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y133sm21984923wmd.2.2019.04.04.06.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 06:11:56 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH net-next v3 1/4] dt-bindings: net: phy: add g12a mdio mux documentation
Date:   Thu,  4 Apr 2019 15:11:44 +0200
Message-Id: <20190404131147.31156-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190404131147.31156-1-jbrunet@baylibre.com>
References: <20190404131147.31156-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the device tree bindings of the MDIO mux of Amlogic
g12a SoC family

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/net/mdio-mux-meson-g12a.txt      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt

diff --git a/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt b/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
new file mode 100644
index 000000000000..3a96cbed9294
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
@@ -0,0 +1,48 @@
+Properties for the MDIO bus multiplexer/glue of Amlogic G12a SoC family.
+
+This is a special case of a MDIO bus multiplexer. It allows to choose between
+the internal mdio bus leading to the embedded 10/100 PHY or the external
+MDIO bus.
+
+Required properties in addition to the generic multiplexer properties:
+- compatible : amlogic,g12a-mdio-mux
+- reg: physical address and length of the multiplexer/glue registers
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "pclk"   : peripheral clock.
+  * "clkin0" : platform crytal
+  * "clkin1" : SoC 50MHz MPLL
+
+Example :
+
+mdio_mux: mdio-multiplexer@4c000 {
+	compatible = "amlogic,g12a-mdio-mux";
+	reg = <0x0 0x4c000 0x0 0xa4>;
+	clocks = <&clkc CLKID_ETH_PHY>,
+		 <&xtal>,
+		 <&clkc CLKID_MPLL_5OM>;
+	clock-names = "pclk", "clkin0", "clkin1";
+	mdio-parent-bus = <&mdio0>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ext_mdio: mdio@0 {
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+
+	int_mdio: mdio@1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		internal_ephy: ethernet-phy@8 {
+			compatible = "ethernet-phy-id0180.3301",
+				     "ethernet-phy-ieee802.3-c22";
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			reg = <8>;
+			max-speed = <100>;
+		};
+	};
+};
-- 
2.20.1

