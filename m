Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2647AC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F322F217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 19:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deutnet.info header.i=@deutnet.info header.b="IXY3N1uV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfGQTTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 15:19:45 -0400
Received: from vps.deutnet.info ([92.222.219.9]:33340 "EHLO vps.deutnet.info"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfGQTTo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 15:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deutnet.info; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:
        To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JdQW5yef3/oLdjTuLUcYjPBC8Xuj3agNuqkg0iaCI/0=; b=IXY3N1uVXn3srXrAv5kYRi8FnR
        Hw+AHgOzzGntAckgmCaG1hFPjheKH2of7BxHzbPOl/go2Cxo16GZXRtjGIYFouyhJt9gM+9f/H1hw
        eAkq/70bCMtUnpqJqxofODO4fpNOede6peZeRYkK6aQkzKOL1n8uBBBY6kOfM6MOTqS4/vVOQUt4U
        NvbmdiWe7pMTHO0R910jVTg8j0mFmMz++w6D+9ket0wv2nxU4HSXXNLmZwuXWqH0/PV1Tgb4NxrC1
        /od9nZKBsTvmu3331SQ+FVLX05zx7zMBLcvoVCwtc8U3vb6Z/W8DHUNIXGWL+KL/b9QW2bMdRx71l
        p1ok8w/A==;
Received: from [2001:41d0:fe79:6700:cf3e:2f2c:b15:9bf9] (helo=sonata)
        by vps.deutnet.info with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <agriveaux@deutnet.info>)
        id 1hnpSj-0007J7-5L; Wed, 17 Jul 2019 21:19:38 +0200
Received: from agriveaux by sonata with local (Exim 4.92)
        (envelope-from <agriveaux@localhost.localdomain>)
        id 1hnpSY-0001DM-4j; Wed, 17 Jul 2019 21:19:26 +0200
Date:   Wed, 17 Jul 2019 21:19:26 +0200
From:   Alexandre GRIVEAUX <agriveaux@deutnet.info>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Alexandre GRIVEAUX <agriveaux@deutnet.info>
Cc:     linux-mips <linux-mips@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCHv3] MIPS: JZ4780: DTS: Add I2C nodes
Message-ID: <20190717191926.GA4571@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the devicetree nodes for the I2C core of the JZ4780 SoC, disabled
by default.
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 86 ++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index b03cdec56de9..a76ecd69bfd0 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -239,6 +239,92 @@
 		status = "disabled";
 	};
 
+	i2c0: i2c@10050000 {
+		compatible = "ingenic,jz4780-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg = <0x10050000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <60>;
+
+		clocks = <&cgu JZ4780_CLK_SMB0>;
+		clock-frequency = <100000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_i2c0_data>;
+
+		status = "disabled";
+	};
+
+	i2c1: i2c@10051000 {
+		compatible = "ingenic,jz4780-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x10051000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <59>;
+
+		clocks = <&cgu JZ4780_CLK_SMB1>;
+		clock-frequency = <100000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_i2c1_data>;
+
+		status = "disabled";
+	};
+
+	i2c2: i2c@10052000 {
+		compatible = "ingenic,jz4780-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x10052000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <58>;
+
+		clocks = <&cgu JZ4780_CLK_SMB2>;
+		clock-frequency = <100000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_i2c2_data>;
+
+		status = "disabled";
+	};
+
+	i2c3: i2c@10053000 {
+		compatible = "ingenic,jz4780-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x10053000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <57>;
+
+		clocks = <&cgu JZ4780_CLK_SMB3>;
+		clock-frequency = <100000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_i2c3_data>;
+
+		status = "disabled";
+	};
+
+	i2c4: i2c@10054000 {
+		compatible = "ingenic,jz4780-i2c";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x10054000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <56>;
+
+		clocks = <&cgu JZ4780_CLK_SMB4>;
+		clock-frequency = <100000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pins_i2c4_data>;
+
+		status = "disabled";
+	};
+
 	watchdog: watchdog@10002000 {
 		compatible = "ingenic,jz4780-watchdog";
 		reg = <0x10002000 0x10>;
-- 
2.20.1

