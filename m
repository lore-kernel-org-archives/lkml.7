Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D631AC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9913214DE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141699;
	bh=82lJAAxP/eZNSrg3BjEPvcX/JauuazJcBNZc/mKlh5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l3xev3pYXqWNCRH5ygW8PtkBdfMoYn0Y/RNlFWi+B+6f7UV17+UyXIu2fIiWKjdSr
	 IR8nzRPxGK/jXO0ojpf1nHr8BeKMV3ndYLoZj4z5sHyFUd80xr4qpLOLKHMVnxVQih
	 XXiZZQatQEVHKag3UAs2/mAKc90ytyP6IF2Xs+6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfKSFe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:34:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729746AbfKSFex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:34:53 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0CEC214DE;
        Tue, 19 Nov 2019 05:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141692;
        bh=82lJAAxP/eZNSrg3BjEPvcX/JauuazJcBNZc/mKlh5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ciixoxfpBGzUY/CiA5Xxdcpsx3qEPqiR2hA7cgrogevdmKzR4Hg6v6/IsIgJM8KSj
         K5rI8jxKaBlSepUtW6/IxIoBl72Nojop51584cUgSTRuPQm3x5FWPuw5iTfkh0SrWh
         w24d2s2q/+ZRr2Dt1mu6tDw5Z3672Cp8+BZFqO9o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 248/422] arm64: dts: ti: k3-am65: Change #address-cells and #size-cells of interconnect to 2
Date:   Tue, 19 Nov 2019 06:17:25 +0100
Message-Id: <20191119051415.062654734@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 3bc1572068e3896b60d86f9c0fb56d1cef28201c ]

AM65 has two PCIe controllers and each PCIe controller has '2' address
spaces one within the 4GB address space of the SoC and the other above
the 4GB address space of the SoC (cbass_main) in addition to the
register space. The size of the address space above the 4GB SoC address
space is 4GB. These address ranges will be used by CPU/DMA to access
the PCIe address space. In order to represent the address space above
the 4GB SoC address space and to represent the size of this address
space as 4GB, change address-cells and size-cells of interconnect to 2.

Since OSPI has similar need in MCU Domain Memory Map, change
address-cells and size-cells of cbass_mcu interconnect also to 2.

Fixes: ea47eed33a3fe3d919 ("arm64: dts: ti: Add Support for AM654 SoC")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Vignesh R <vigneshr@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi | 10 +++---
 arch/arm64/boot/dts/ti/k3-am65.dtsi      | 44 ++++++++++++------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index e23c5762355d0..2e3917171b17f 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -8,13 +8,13 @@
 &cbass_main {
 	gic500: interrupt-controller@1800000 {
 		compatible = "arm,gic-v3";
-		#address-cells = <1>;
-		#size-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		ranges;
 		#interrupt-cells = <3>;
 		interrupt-controller;
-		reg = <0x01800000 0x10000>,	/* GICD */
-		      <0x01880000 0x90000>;	/* GICR */
+		reg = <0x00 0x01800000 0x00 0x10000>,	/* GICD */
+		      <0x00 0x01880000 0x00 0x90000>;	/* GICR */
 		/*
 		 * vcpumntirq:
 		 * virtual CPU interface maintenance interrupt
@@ -23,7 +23,7 @@
 
 		gic_its: gic-its@1820000 {
 			compatible = "arm,gic-v3-its";
-			reg = <0x01820000 0x10000>;
+			reg = <0x00 0x01820000 0x00 0x10000>;
 			msi-controller;
 			#msi-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
index cede1fa0983c9..ded364d208351 100644
--- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
@@ -46,38 +46,38 @@
 
 	cbass_main: interconnect@100000 {
 		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0x00100000 0x00 0x00100000 0x00020000>, /* ctrl mmr */
-			 <0x00600000 0x00 0x00600000 0x00001100>, /* GPIO */
-			 <0x00900000 0x00 0x00900000 0x00012000>, /* serdes */
-			 <0x01000000 0x00 0x01000000 0x0af02400>, /* Most peripherals */
-			 <0x30800000 0x00 0x30800000 0x0bc00000>, /* MAIN NAVSS */
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
+			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00001100>, /* GPIO */
+			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
+			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
+			 <0x00 0x30800000 0x00 0x30800000 0x00 0x0bc00000>, /* MAIN NAVSS */
 			 /* MCUSS Range */
-			 <0x28380000 0x00 0x28380000 0x03880000>,
-			 <0x40200000 0x00 0x40200000 0x00900100>,
-			 <0x42040000 0x00 0x42040000 0x03ac2400>,
-			 <0x45100000 0x00 0x45100000 0x00c24000>,
-			 <0x46000000 0x00 0x46000000 0x00200000>,
-			 <0x47000000 0x00 0x47000000 0x00068400>;
+			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
+			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00900100>,
+			 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>,
+			 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>,
+			 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>,
+			 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>;
 
 		cbass_mcu: interconnect@28380000 {
 			compatible = "simple-bus";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x28380000 0x28380000 0x03880000>, /* MCU NAVSS*/
-				 <0x40200000 0x40200000 0x00900100>, /* First peripheral window */
-				 <0x42040000 0x42040000 0x03ac2400>, /* WKUP */
-				 <0x45100000 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
-				 <0x46000000 0x46000000 0x00200000>, /* CPSW */
-				 <0x47000000 0x47000000 0x00068400>; /* OSPI space 1 */
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
+				 <0x00 0x40200000 0x00 0x40200000 0x00 0x00900100>, /* First peripheral window */
+				 <0x00 0x42040000 0x00 0x42040000 0x00 0x03ac2400>, /* WKUP */
+				 <0x00 0x45100000 0x00 0x45100000 0x00 0x00c24000>, /* MMRs, remaining NAVSS */
+				 <0x00 0x46000000 0x00 0x46000000 0x00 0x00200000>, /* CPSW */
+				 <0x00 0x47000000 0x00 0x47000000 0x00 0x00068400>; /* OSPI space 1 */
 
 			cbass_wakeup: interconnect@42040000 {
 				compatible = "simple-bus";
 				#address-cells = <1>;
 				#size-cells = <1>;
 				/* WKUP  Basic peripherals */
-				ranges = <0x42040000 0x42040000 0x03ac2400>;
+				ranges = <0x42040000 0x00 0x42040000 0x03ac2400>;
 			};
 		};
 	};
-- 
2.20.1



