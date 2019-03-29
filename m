Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1753C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDD52183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:15:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="AfQ+NolI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbfC2OP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:15:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52276 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbfC2OPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:15:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id a184so2696087wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W34/cfcT6NSknRmwI1jY9uNwLfZHBK33QyXRjlFTgPM=;
        b=AfQ+NolIerqL3DyW8Ky54epR8kQB/ARQehPyqVFb6cz5oFaJUHgCQ/4iuQ1Rp1RCLj
         aR2V/9ojxxRgTSyqYEbxikcCccpMH+cdaPCQmjs1U+km4n9Qn/If0SFxKn5iQWJceaJm
         3dv9DBwk7khIzT31On2EoNWX7wMsoDbBGy5eRpUUZKtCuaCsZl31poiSLnzIODZEDb/c
         cPD175a9wrX1FO8+4BDtY3MfW76etcctf7dTDJIpeGpiUjt9IlmMAylxsd5G0hQqkWxt
         qFEST2R2xn2V34YicoTrgcf0o+c6nfWSbgXWGqUhlbFjSMds+sl4RBp6uZK4ajK6HIVK
         lx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W34/cfcT6NSknRmwI1jY9uNwLfZHBK33QyXRjlFTgPM=;
        b=UT082sHh2V4ti+Bmp0PW8e7moJA4li4TZZ6A8ewdaj7zCkmpIBW8ZNwbp/EnI92G4r
         Svm8PRjE/sQpCkNwJWHsUOiE3cS9ZoALR4LGEdBJwHkVSXF/8IW/4AstxExZLTq8wtYq
         GBTNL7ToCorDNxEVkxJ48fztI+YaM2MaDDI3KbE73m8XMqjBuqMU7e1tQPVKMawtQoCK
         508fCJuqaj0Oondcd4BWy3c30yE9gODmeORCPt3eRpstgkBkjYtVTyEjcqdA3rQupr0F
         pt912EmpOcpWXq68Zz59mPOMzY3ZHh7LNbokIVAD89e7TDdijpaJru71kYVtZ8nGI8aK
         mpYw==
X-Gm-Message-State: APjAAAUlU9ukvI2In8PROWbajZ9W7WAX90J3MCfuXdI3OuSIy+ST9JVN
        71ThlPzV0SFRyQpM//rXtc660w==
X-Google-Smtp-Source: APXvYqxidIYhN7iOAK96hGbHSZo4xLrQvYXEk/YijvZEoY+sVJLDbvd3ZEviNa2Dcq8wl98Szjaovw==
X-Received: by 2002:a1c:9cc1:: with SMTP id f184mr3916979wme.150.1553868920895;
        Fri, 29 Mar 2019 07:15:20 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id 67sm2464333wmz.41.2019.03.29.07.15.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 07:15:20 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH net-next v2 1/3] dt-bindings: net: phy: add g12a mdio mux documentation
Date:   Fri, 29 Mar 2019 15:15:10 +0100
Message-Id: <20190329141512.29867-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329141512.29867-1-jbrunet@baylibre.com>
References: <20190329141512.29867-1-jbrunet@baylibre.com>
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

