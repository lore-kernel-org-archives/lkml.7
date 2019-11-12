Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7B8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2126E20578
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 14:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LaiPT59I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfKLOcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 09:32:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41308 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfKLOcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 09:32:08 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xACEVx6q046180;
        Tue, 12 Nov 2019 08:31:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573569119;
        bh=rdDTMAol8BJ7BzBuc2QSkiXQFB4uWb3zPVmmVQndFWA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LaiPT59IKFwdQz5u0mM4+JJKD6FGSpu6GvHdw1mMWuSJ2eS5Jz3n59/K7WeZq5SRb
         UuioiMQyoJdEefPBkxcIExq8lkchmRZZkxGakzQQETwcJpaGBVIJauX1mmg1LkWV2q
         9w0KMNM3MFDgTLQ8pUpPHF/rzTMPyg02ZXm7hxcc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xACEVxbH031531
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Nov 2019 08:31:59 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 12
 Nov 2019 08:31:41 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 12 Nov 2019 08:31:41 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xACEVjUM050451;
        Tue, 12 Nov 2019 08:31:55 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/9] arm64: dts: ti: k3-am65: DMA support
Date:   Tue, 12 Nov 2019 16:32:55 +0200
Message-ID: <20191112143301.3168-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112143301.3168-1-peter.ujfalusi@ti.com>
References: <20191112143301.3168-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ringacc and udmap nodes for main and mcu NAVSS.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 39 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi  | 46 ++++++++++++++++++++++++
 2 files changed, 85 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index a125d66dd552..be841fc44b76 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -379,6 +379,10 @@ cbass_main_navss: navss@30800000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
+		dma-coherent;
+		dma-ranges;
+
+		ti,sci-dev-id = <118>;
 
 		intr_main_navss: interrupt-controller1 {
 			compatible = "ti,sci-intr";
@@ -527,6 +531,41 @@ mailbox0_cluster11: mailbox@31f8b000 {
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
 		};
+
+		ringacc: ringacc@3c000000 {
+			compatible = "ti,am654-navss-ringacc";
+			reg =	<0x0 0x3c000000 0x0 0x400000>,
+				<0x0 0x38000000 0x0 0x400000>,
+				<0x0 0x31120000 0x0 0x100>,
+				<0x0 0x33000000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			ti,num-rings = <818>;
+			ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
+			ti,dma-ring-reset-quirk;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <187>;
+			msi-parent = <&inta_main_udmass>;
+		};
+
+		main_udmap: dma-controller@31150000 {
+			compatible = "ti,am654-navss-main-udmap";
+			reg =	<0x0 0x31150000 0x0 0x100>,
+				<0x0 0x34000000 0x0 0x100000>,
+				<0x0 0x35000000 0x0 0x100000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt";
+			msi-parent = <&inta_main_udmass>;
+			#dma-cells = <1>;
+
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <188>;
+			ti,ringacc = <&ringacc>;
+
+			ti,sci-rm-range-tchan = <0x1>, /* TX_HCHAN */
+						<0x2>; /* TX_CHAN */
+			ti,sci-rm-range-rchan = <0x4>, /* RX_HCHAN */
+						<0x5>; /* RX_CHAN */
+			ti,sci-rm-range-rflow = <0x6>; /* GP RFLOW */
+		};
 	};
 
 	main_gpio0:  main_gpio0@600000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 7bdf5342f58f..27fc73f94cf9 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -95,4 +95,50 @@ adc {
 			compatible = "ti,am654-adc", "ti,am3359-adc";
 		};
 	};
+
+	cbass_mcu_navss: navss@28380000 {
+		compatible = "simple-mfd";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-coherent;
+		dma-ranges;
+
+		ti,sci-dev-id = <119>;
+
+		mcu_ringacc: ringacc@2b800000 {
+			compatible = "ti,am654-navss-ringacc";
+			reg =	<0x0 0x2b800000 0x0 0x400000>,
+				<0x0 0x2b000000 0x0 0x400000>,
+				<0x0 0x28590000 0x0 0x100>,
+				<0x0 0x2a500000 0x0 0x40000>;
+			reg-names = "rt", "fifos", "proxy_gcfg", "proxy_target";
+			ti,num-rings = <286>;
+			ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
+			ti,dma-ring-reset-quirk;
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <195>;
+			msi-parent = <&inta_main_udmass>;
+		};
+
+		mcu_udmap: dma-controller@285c0000 {
+			compatible = "ti,am654-navss-mcu-udmap";
+			reg =	<0x0 0x285c0000 0x0 0x100>,
+				<0x0 0x2a800000 0x0 0x40000>,
+				<0x0 0x2aa00000 0x0 0x40000>;
+			reg-names = "gcfg", "rchanrt", "tchanrt";
+			msi-parent = <&inta_main_udmass>;
+			#dma-cells = <1>;
+
+			ti,sci = <&dmsc>;
+			ti,sci-dev-id = <194>;
+			ti,ringacc = <&mcu_ringacc>;
+
+			ti,sci-rm-range-tchan = <0x1>, /* TX_HCHAN */
+						<0x2>; /* TX_CHAN */
+			ti,sci-rm-range-rchan = <0x3>, /* RX_HCHAN */
+						<0x4>; /* RX_CHAN */
+			ti,sci-rm-range-rflow = <0x5>; /* GP RFLOW */
+		};
+	};
 };
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

