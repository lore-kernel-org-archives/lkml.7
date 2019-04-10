Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B9EC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10310217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 00:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX/rCSPm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfDJA55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 20:57:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40199 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfDJA5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 20:57:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so650166wmi.5;
        Tue, 09 Apr 2019 17:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E//VdZKilzQL6n2wexZY4a/h0DP2YFKtTZZSXDrFjpo=;
        b=FX/rCSPmmckwU4jPQPgcniNhEpgppdqb67fI1IkTtLKIjfrqOnIfSTHam3aR9eAJPq
         JXL/k71Y2V+x2cF6jvC5yPuT1VeOprotT3gKJlj7PtCDFUiwhbj1JtjF028ZH6eLlhmk
         7j0lUd0x1C4a8YZSChTMy/0eloqibCdnjTsomxu+z5odSfhQGzFyJq4G2EkFrS80PdbE
         jHH3/lSbBUjLllK0oGWMmzPXOYgi+19j82D8cKXUHkhVnfbr9OgSe/iTKorTVjw3ZzPT
         KLs03oHWrpkML7KakOMveaPU1KZfkghL8gJ9Xg8k3Pg6tByoJ4KOi5Icpmsn9t+25qh5
         ZipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E//VdZKilzQL6n2wexZY4a/h0DP2YFKtTZZSXDrFjpo=;
        b=Mo+mu6c2QhAyhvNuk4hYnqFgyDjBPazFACHPQDJ6+MRnGfMDRRLSC5L05ajnIx5Qg2
         B8dNcyY4QtcF3NgRY6CLWLnVL3Krkj2hhDRnEv6BNT5eLE0vWOMwyqJJGSvNt3eyIZac
         fMOxwdsJU5GutJm8IIG3XDrEsbIonQiVjUtr+5CRfPo+She4YIE0fjf39nvcqiHHJ5im
         ikWWBiOni9K7VcgTJdrQZprT2y8xv3O12DhbXP3RkarkWp8lGpiyTLg1Hjfyp+MWPx02
         4Af7rlvSfwgtAx6ljZVJuIfNGVpkuyAZ0NtMsxT9sHk6TYNSbNtX8U4lPZ9AZDnYe6HY
         wKfQ==
X-Gm-Message-State: APjAAAUUxcYICB39QlKqVGFLUZ4pXSDzoZZmlvXp0YDHqykIhezsjW3I
        V4+dWbwAIeBHYcirwAL08oCvOOBbMWM=
X-Google-Smtp-Source: APXvYqxQqt80oTbgp+51VJLXeKwTk8Ah99k2+Xlzkwy/xy7R9SIZk6CrXWVOh39CtPlyiF2152xypg==
X-Received: by 2002:a1c:cfcb:: with SMTP id f194mr664180wmg.51.1554857866577;
        Tue, 09 Apr 2019 17:57:46 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id s16sm27448683wrw.58.2019.04.09.17.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 17:57:46 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        georg.waibel@sensor-technik.de, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH v2 net-next 22/22] dt-bindings: net: dsa: Add documentation for NXP SJA1105 driver
Date:   Wed, 10 Apr 2019 03:57:00 +0300
Message-Id: <20190410005700.31582-23-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410005700.31582-1-olteanv@gmail.com>
References: <20190410005700.31582-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:
Renamed sja1105,phy-mode to sja1105,role-phy and similarly for mac.
Clarified the switch situation with RGMII delays.

 .../devicetree/bindings/net/dsa/sja1105.txt   | 157 ++++++++++++++++++
 1 file changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/sja1105.txt

diff --git a/Documentation/devicetree/bindings/net/dsa/sja1105.txt b/Documentation/devicetree/bindings/net/dsa/sja1105.txt
new file mode 100644
index 000000000000..529401cf01ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/sja1105.txt
@@ -0,0 +1,157 @@
+NXP SJA1105 switch driver
+=========================
+
+Required properties:
+
+- compatible:
+	Must be one of:
+	- "nxp,sja1105e"
+	- "nxp,sja1105t"
+	- "nxp,sja1105p"
+	- "nxp,sja1105q"
+	- "nxp,sja1105r"
+	- "nxp,sja1105s"
+
+	Although the device ID could be detected at runtime, explicit bindings
+	are required in order to be able to statically check their validity.
+	For example, SGMII can only be specified on port 4 of R and S devices,
+	and the non-SGMII devices, while pin-compatible, are not equal in terms
+	of support for RGMII internal delays (supported on P/Q/R/S, but not on
+	E/T).
+
+Optional properties:
+
+- sja1105,role-mac:
+- sja1105,role-phy:
+	Boolean properties that can be assigned under each port node. By
+	default (unless otherwise specified) a port is configured as MAC if it
+	is driving a PHY (phy-handle is present) or as PHY if it is PHY-less
+	(fixed-link specified, presumably because it is connected to a MAC).
+	The effect of this property (in either its implicit or explicit form)
+	is:
+	- In the case of MII or RMII it specifies whether the SJA1105 port is a
+	  clock source or sink for this interface (not applicable for RGMII
+	  where there is a Tx and an Rx clock).
+	- In the case of RGMII it affects the behavior regarding internal
+	  delays:
+	  1. If sja1105,role-mac is specified, and the phy-mode property is one
+	     of "rgmii-id", "rgmii-txid" or "rgmii-rxid", then the entity
+	     designated to apply the delay/clock skew necessary for RGMII
+	     is the PHY. The SJA1105 MAC does not apply any internal delays.
+	  2. If sja1105,role-phy is specified, and the phy-mode property is one
+	     of the above, the designated entity to apply the internal delays
+	     is the SJA1105 MAC (if hardware-supported). This is only supported
+	     by the second-generation (P/Q/R/S) hardware. On a first-generation
+	     E or T device, it is an error to specify an RGMII phy-mode other
+	     than "rgmii" for a port that is in fixed-link mode. In that case,
+	     the clock skew must either be added by the MAC at the other end of
+	     the fixed-link, or by PCB serpentine traces on the board.
+	These properties are required, for example, in the case where SJA1105
+	ports are at both ends of a MII/RMII PHY-less setup. One end would need
+	to have sja1105,role-mac, while the other sja1105,role-phy.
+
+See Documentation/devicetree/bindings/net/dsa/dsa.txt for the list of standard
+DSA required and optional properties.
+
+Other observations
+------------------
+
+The SJA1105 SPI interface requires a CS-to-CLK time (t2 in UM10944) of at least
+one half of t_CLK. At an SPI frequency of 1MHz, this means a minimum
+cs_sck_delay of 500ns. Ensuring that this SPI timing requirement is observed
+depends on the SPI bus master driver.
+
+Example
+-------
+
+Ethernet switch connected via SPI to the host, CPU port wired to enet2:
+
+arch/arm/boot/dts/ls1021a-tsn.dts:
+
+/* SPI controller of the LS1021 */
+&dspi0 {
+	sja1105@1 {
+		reg = <0x1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "nxp,sja1105";
+		spi-max-frequency = <4000000>;
+		fsl,spi-cs-sck-delay = <1000>;
+		fsl,spi-sck-cs-delay = <1000>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				/* ETH5 written on chassis */
+				label = "swp5";
+				phy-handle = <&rgmii_phy6>;
+				phy-mode = "rgmii";
+				reg = <0>;
+				/* Implicit "sja1105,role-mac;" */
+			};
+			port@1 {
+				/* ETH2 written on chassis */
+				label = "swp2";
+				phy-handle = <&rgmii_phy3>;
+				phy-mode = "rgmii";
+				reg = <1>;
+				/* Implicit "sja1105,role-mac;" */
+			};
+			port@2 {
+				/* ETH3 written on chassis */
+				label = "swp3";
+				phy-handle = <&rgmii_phy4>;
+				phy-mode = "rgmii";
+				reg = <2>;
+				/* Implicit "sja1105,role-mac;" */
+			};
+			port@3 {
+				/* ETH4 written on chassis */
+				phy-handle = <&rgmii_phy5>;
+				label = "swp4";
+				phy-mode = "rgmii";
+				reg = <3>;
+				/* Implicit "sja1105,role-mac;" */
+			};
+			port@4 {
+				/* Internal port connected to eth2 */
+				ethernet = <&enet2>;
+				phy-mode = "rgmii";
+				reg = <4>;
+				/* Implicit "sja1105,role-phy;" */
+				fixed-link {
+					speed = <1000>;
+					full-duplex;
+				};
+			};
+		};
+	};
+};
+
+/* MDIO controller of the LS1021 */
+&mdio0 {
+	/* BCM5464 */
+	rgmii_phy3: ethernet-phy@3 {
+		reg = <0x3>;
+	};
+	rgmii_phy4: ethernet-phy@4 {
+		reg = <0x4>;
+	};
+	rgmii_phy5: ethernet-phy@5 {
+		reg = <0x5>;
+	};
+	rgmii_phy6: ethernet-phy@6 {
+		reg = <0x6>;
+	};
+};
+
+/* Ethernet master port of the LS1021 */
+&enet2 {
+	phy-connection-type = "rgmii";
+	status = "ok";
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+	};
+};
+
-- 
2.17.1

