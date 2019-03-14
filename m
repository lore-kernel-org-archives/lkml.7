Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E152C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAE42070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="h12UH4uN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfCNOB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:01:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56223 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbfCNOB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:01:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so3091494wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 07:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VrIM0LIaAeyRnbtzdYl720Pekr4qj64JGsc6swg1oRE=;
        b=h12UH4uN+TK+CWagvg7xGzLUqGLu4PZVoiVJpeT4y/1h7Iq1fV58Wm9UTL0VMB85J5
         xixzDy/ousy7RYw7epz+obveAK4Njoxz4uhAtAEMX5J1Frme5pEgrhukvX9JCfP0zLjm
         Ro4PQ+Kpq9SQW0EHZE7ATa9nwM17DgjsfpP6TG9UUWYE4DhO8S10eStLrOQn3I3JHgqb
         nFqYfJlA3dSJeDjxUN0ghhivQBL/77X2DZKVMSycDjTwa1usSaEH5xpBvwVoPc3mp9F0
         MUhi/RoBtC1oOrdxwrgVBGhn4N01ELMCVDFLhW6yK3XhnxeRrAscucOzTDdGmJtVaC4K
         tauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VrIM0LIaAeyRnbtzdYl720Pekr4qj64JGsc6swg1oRE=;
        b=J2u6/RVuj5FwOJmosbtdsCBkSEKwpRyzT3v1W72Vhwe4UaFTjZHMt7g5Mf7xU3chIc
         af8JhTqDTYnG74GfAoKMnNy4bJWzwKMBplX3be38AOlGsHlfQEQDPF71GW3F6GaDiYTy
         19/Bcm3WXMgWbiaxs4vxh/t2MjoxQKN4+GpM61cphUwhnNOqsVw+x+VuX5rxqh+E4sxO
         NKQvwLjyTNEXDpBtv/6XijxOdkiD3qkzjMt3pwn2MbqgBRWYV945RCtdCXYcGWgW5wns
         E89AfKcTHpCj2GEqqCcsE/yw/bHTnszhUPFv2KRfn44pMMvKUICbj0VDiqYIiFi4dszw
         l20Q==
X-Gm-Message-State: APjAAAUEfFtz6k0W2kYdfaK6MF12FL/joZMjeXFZZMmNAi6TYkQ/h2tp
        taslSQwhAu7uDoCXaa/BIZIwbg==
X-Google-Smtp-Source: APXvYqx30dID+exeDffHkGRxAS6tGiz1CiwGspdI2h6soSmi9WPVymySTu2maYUw9cnBmRw6gtuXBg==
X-Received: by 2002:a1c:9693:: with SMTP id y141mr2805320wmd.33.1552572114872;
        Thu, 14 Mar 2019 07:01:54 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y7sm2661051wmi.34.2019.03.14.07.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 07:01:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, netdev@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH net-next 1/3] dt-bindings: net: phy: add g12a mdio mux documentation
Date:   Thu, 14 Mar 2019 15:01:33 +0100
Message-Id: <20190314140135.19184-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190314140135.19184-1-jbrunet@baylibre.com>
References: <20190314140135.19184-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the device tree bindings of the MDIO mux of Amlogic
g12a SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/net/mdio-mux-meson-g12a.txt      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt

diff --git a/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt b/Documentation/devicetree/bindings/net/mdio-mux-meson-g12a.txt
new file mode 100644
index 000000000000..e738bba6a9de
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
+mdio-mux: mdio-multiplexer@4c000 {
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
+		internal_ephy: ethernet_phy@8 {
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

