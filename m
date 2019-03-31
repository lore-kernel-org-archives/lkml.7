Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F5C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFADD20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwPLI3RD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbfCaRnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:43:15 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36953 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731607AbfCaRnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:43:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so8874436wrm.4;
        Sun, 31 Mar 2019 10:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pKtrBZX69/1OJOKzLUubHnbFfxXix0grSstIe4V9+Pg=;
        b=nwPLI3RDtLUuL2JhdS370ifjdpfo2shrRocMyjhGM1xWUU/K0IOMl5oVcoUpBZ1jVt
         0h51J6JJu61NHFYYfKJLWrVJMLVGoIJsou10aVidyPO3Zu28GMHjIoZagbjUOrFou8n9
         56Dk5ozhRf39Jh07NTGtAQfUfw5Af46ooohZPD2roT7eUA6ENnk1pXrsYtfexHFUm7JH
         vyHZhJlEiSGq8dNwbYed1EC8A4NPxe9ayT1mlZgZt4ANRQ0uIKhrXkoaMovbvjzoF+SB
         43C3g66NnSueANwfpweeUGtdo3Kr2i0zwS3JSPsaI4Es30Go+1vRON8+cx1vsEDhLAh5
         OAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pKtrBZX69/1OJOKzLUubHnbFfxXix0grSstIe4V9+Pg=;
        b=oLx20EQ8BeQovfIZM2b0DBbjnNCqa3FzfUVyNn+UFvlh0hqlLe96QZnoq2gsVuHFcs
         DrT2Dr5HKFjt86KAZKf6rjTetF4zHHCj9OgQXrYKNEAF0kKdab+0OXMBMV3wjkZ/SLHQ
         IQjEZ//s87UeFh7gARJboNcpFkrR9odIiGdP6SglC7dQ9/SIpBd/63P1tZoXCKSJLomq
         GLl8SZkFyWBNeHlu0Mq0VtM1m2mE2TdqtGB0dkO3Sp7vsrDPmVOFCnXBXuXBtGCKDjse
         hfAdDOuk43zNZa7CeddQfHWKRkd6ju/jtgUnaSzCfVdcf5z4mqQeLHaZFW3WqfZ27SA0
         ru3A==
X-Gm-Message-State: APjAAAX2ttpAP1QRqhh/L2sxLbp5A4vkldFtp+KaG7qhySEj9tAv9SND
        +K2q7ZVo6aXhDdlm8k3xaKQ=
X-Google-Smtp-Source: APXvYqzfm+bI9d4WeK0RblbuSaWxS6MF8F64gvTn97y4hEFatVKYiQoSOKLOkhujAUS/wm+ZZ48Rdw==
X-Received: by 2002:a5d:4446:: with SMTP id x6mr17297331wrr.147.1554054192640;
        Sun, 31 Mar 2019 10:43:12 -0700 (PDT)
Received: from localhost.localdomain (5-12-225-227.residential.rdsnet.ro. [5.12.225.227])
        by smtp.gmail.com with ESMTPSA id v192sm10892354wme.24.2019.03.31.10.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 10:43:12 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, georg.waibel@sensor-technik.de,
        Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 17/17] dt-bindings: net: dsa: Add documentation for NXP SJA1105 driver
Date:   Sun, 31 Mar 2019 20:42:32 +0300
Message-Id: <20190331174232.22060-18-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190331174232.22060-1-olteanv@gmail.com>
References: <20190331174232.22060-1-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../devicetree/bindings/net/dsa/sja1105.txt   | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/sja1105.txt

diff --git a/Documentation/devicetree/bindings/net/dsa/sja1105.txt b/Documentation/devicetree/bindings/net/dsa/sja1105.txt
new file mode 100644
index 000000000000..2c82b6fc37e3
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/sja1105.txt
@@ -0,0 +1,123 @@
+NXP SJA1105 switch driver
+=========================
+
+Required properties:
+
+- compatible: Must be "nxp,sja1105". Device ID identification (one of
+  E/T/P/Q/R/S) is performed by driver at probe time. Swapping pin-compatible
+  parts is possible with no DTS change.
+
+Optional properties:
+
+- sja1105,mac-mode, sja1105,phy-mode: Boolean properties that can be assigned
+  under each port node that is MII or RMII (has no effect for RGMII).  By
+  default (unless otherwise specified) a port is configured as MAC if it is
+  driving a PHY (phy-handle is present) or as PHY if it is PHY-less (fixed-link
+  specified, presumably because it is connected to a MAC).  These properties
+  are required in the case where SJA1105 ports are at both ends of an MII/RMII
+  PHY-less setup. One end would need to have sja1105,mac-mode, while the other
+  sja1105,phy-mode.
+
+See Documentation/devicetree/bindings/net/dsa/dsa.txt for the list of standard
+DSA required and optional properties.
+
+Other observations:
+
+The SJA1105 SPI interface requires a CS-to-CLK time (t2 in UM10944) of at least
+one half of t_CLK. At an SPI frequency of 1MHz, this means a minimum
+cs_sck_delay of 500ns. Ensuring that this SPI timing requirement is observed
+depends on the SPI bus master driver.
+
+Example:
+
+Ethernet switch connected via SPI to the host, CPU port wired to eth0:
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
+				/* Implicit "sja1105,mac-mode;" */
+			};
+			port@1 {
+				/* ETH2 written on chassis */
+				label = "swp2";
+				phy-handle = <&rgmii_phy3>;
+				phy-mode = "rgmii";
+				reg = <1>;
+				/* Implicit "sja1105,mac-mode;" */
+			};
+			port@2 {
+				/* ETH3 written on chassis */
+				label = "swp3";
+				phy-handle = <&rgmii_phy4>;
+				phy-mode = "rgmii";
+				reg = <2>;
+				/* Implicit "sja1105,mac-mode;" */
+			};
+			port@3 {
+				/* ETH4 written on chassis */
+				phy-handle = <&rgmii_phy5>;
+				label = "swp4";
+				phy-mode = "rgmii";
+				reg = <3>;
+				/* Implicit "sja1105,mac-mode;" */
+			};
+			port@4 {
+				/* Internal port connected to eth2 */
+				ethernet = <&enet2>;
+				phy-mode = "rgmii";
+				reg = <4>;
+				/* Implicit "sja1105,phy-mode;" */
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

