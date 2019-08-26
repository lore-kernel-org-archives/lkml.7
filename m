Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C33C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EF7120874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 15:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbfHZPiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 11:38:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52768 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfHZPiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 11:38:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id o4so15927958wmh.2;
        Mon, 26 Aug 2019 08:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9NkYS7urVCiEtt0M3GAw4i3Cp3ycEW4gYRkzUzyQ4Xs=;
        b=rN2Jltm9pDL3ujLUw3q6xcpqyHImn/2qSpIYEfqZC0lqzaGuVHy/ZYp7PVnKQbPuO5
         KNZUlzxgRi/4NeX9N2vpW72u+z/LzKSfHD/FJkvAZPG/M7IirtXclcAIvEr6NsSFHd4P
         eAWvRP3H1lBIfzU+hs76iXRmZR12xkOCZwSh4fT3fdcgSznCgiQhi+AMWF62dmPjsVBr
         W5a+oAjMEO98v4+DTvpzsGk6fh78oVlu7LQ1/Y2diG7fpHSWdAuvmsdOYsetwRSlIZRL
         06mtaaDPDseLR5T6epEy4Cw0skQd5/A/qy3TuhaN8JNUVSMNlYQD4+3MY2DXY2M3twAF
         6TaA==
X-Gm-Message-State: APjAAAUgBfo+u+YcVolIvoQVFo2VHAlRT6gaiX2mq8eYL6Rv/FxlXVGR
        uNjl0ftYN86FtU/YZ/olQ03/jOxNiuo=
X-Google-Smtp-Source: APXvYqzrHfkBV0VZT/8b7GJDeH5p/8ZVnepaLjJKhgQaGgIBm+5y5g3FQZTpNlEAYwACbwrmIYxjRA==
X-Received: by 2002:a1c:a74b:: with SMTP id q72mr23123109wme.96.1566833924812;
        Mon, 26 Aug 2019 08:38:44 -0700 (PDT)
Received: from 1aq-andre.garage.tyco.com ([77.107.218.170])
        by smtp.gmail.com with ESMTPSA id z8sm11580798wru.13.2019.08.26.08.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 08:38:44 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>,
        Ilya Ledvich <ilya@compulab.co.il>,
        Igor Grinberg <grinberg@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/12] ARM: dts: imx7d: cl-som-imx7: add phy-reset-gpios
Date:   Mon, 26 Aug 2019 16:37:50 +0100
Message-Id: <20190826153800.35400-2-git@andred.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190826153800.35400-1-git@andred.net>
References: <20190826153800.35400-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the design team:
* reset input PHY0 is directly connected to the
  corresponding pin GPIO1_4 in the i.MX7
* reset for PHY1 is done using the gpio expander bit 4

While touching this area, also add a 'compatible'
to the phy to make it more clear what this is and
which driver handles this - an Ethernet phy attached
to mdio, handled by of_mdio.c

Signed-off-by: André Draszik <git@andred.net>
Cc: Ilya Ledvich <ilya@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 6f7e85cf0c28..e0432a3aa36f 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -30,13 +30,14 @@
 
 &fec1 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet1>;
+	pinctrl-0 = <&pinctrl_enet1 &pinctrl_enet1phy>;
 	assigned-clocks = <&clks IMX7D_ENET1_TIME_ROOT_SRC>,
 			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
 	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 	assigned-clock-rates = <0>, <100000000>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
+	phy-reset-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	fsl,magic-packet;
 	status = "okay";
 
@@ -45,10 +46,12 @@
 		#size-cells = <0>;
 
 		ethphy0: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
 		};
 
 		ethphy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
 			reg = <1>;
 		};
 	};
@@ -63,6 +66,7 @@
 	assigned-clock-rates = <0>, <100000000>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy1>;
+	phy-reset-gpios = <&pca9555 4 GPIO_ACTIVE_LOW>;
 	fsl,magic-packet;
 	status = "okay";
 };
@@ -262,3 +266,11 @@
 		>;
 	};
 };
+
+&iomuxc_lpsr {
+	pinctrl_enet1phy: enet1phygrp {
+		fsl,pins = <
+			MX7D_PAD_LPSR_GPIO1_IO04__GPIO1_IO4	0x34
+		>;
+	};
+};
-- 
2.23.0.rc1

