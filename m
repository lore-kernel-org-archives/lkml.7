Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103E0ECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC23A218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 18:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570819723;
	bh=m+vq97srCtSAkMQJp5pj1AGqRJNlXFC1HTKheGMdwMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kYJjVRnKEtuJCTIl0kXZaWSjzqa3qs1S2dbgLDoDbkR7n8FiaB/pociNY9dmz8Z4D
	 sn9CKjEeQ0SbbgbxTtgcaSkM1w/FRw+Q80l4+yuwjXX08Z5pPo+M8cLaKcDShYYBsm
	 GjqlkQyK1COBXOtBrashEg1eDJ+aCprjH6PNd7YQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfJKSsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 14:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbfJKSsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 14:48:39 -0400
Received: from ziggy.de (unknown [37.223.145.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEBEF2190F;
        Fri, 11 Oct 2019 18:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570819718;
        bh=m+vq97srCtSAkMQJp5pj1AGqRJNlXFC1HTKheGMdwMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ofrxxdcFTleX+rEmnybr+Wk0kFjoyRBSwGegV1iuF09a25k2yfXoc5pbf1bQIZ13c
         ChWvNAKUYUcR2u3ObdEcRq+Eup0U4zyDQ2W75C4CdpPYZ970ouTaUxRHs0qePr3L4V
         2DhSaDBf9wRXVW1llOyPf9iIGVX5Emq1/oDFnh4c=
From:   matthias.bgg@kernel.org
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Matthias Brugger <matthias.bgg@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Eric Anholt <eric@anholt.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] ARM: dts: bcm2711: Enable GENET support for the RPi4
Date:   Fri, 11 Oct 2019 20:48:21 +0200
Message-Id: <20191011184822.866-4-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011184822.866-1-matthias.bgg@kernel.org>
References: <20191011184822.866-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

Enable Gigabit Ethernet support on the Raspberry Pi 4
Model B.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>

---

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/bcm2711.dtsi        | 18 ++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index cccc1ccd19be..958553d62670 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -97,6 +97,28 @@
 	status = "okay";
 };
 
+&genet {
+	phy-handle = <&phy1>;
+	phy-mode = "rgmii";
+	status = "okay";
+	dma-burst-sz = <0x08>;
+
+	mdio@e14 {
+		compatible = "brcm,genet-mdio-v5";
+		reg = <0xe14 0x8>;
+		reg-names = "mdio";
+		#address-cells = <0x0>;
+		#size-cells = <0x1>;
+
+		phy1: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			/* No PHY interrupt */
+			max-speed = <1000>;
+			reg = <0x1>;
+		};
+	};
+};
+
 /* uart0 communicates with the BT module */
 &uart0 {
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index ac83dac2e6ba..e2e837fcad59 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -305,6 +305,24 @@
 			cpu-release-addr = <0x0 0x000000f0>;
 		};
 	};
+
+	scb {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		ranges = <0x0 0x7c000000  0x0 0xfc000000  0x03800000>;
+
+		genet: ethernet@7d580000 {
+			compatible = "brcm,genet-v5";
+			reg = <0x0 0x7d580000 0x10000>;
+			#address-cells = <0x1>;
+			#size-cells = <0x1>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+	};
 };
 
 &clk_osc {
-- 
2.23.0

