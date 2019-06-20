Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A674C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3386D2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 17:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M/vUOBAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbfFTRY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 13:24:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34126 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbfFTRYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 13:24:22 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5KHOBKq088320;
        Thu, 20 Jun 2019 12:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561051451;
        bh=PRHPpah0vEAU6FnvYOlPlzpI1gv9StnvAXYvcPQYb+A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=M/vUOBAAE03yla8MblvfAC3NZ482+/6cSx/EFjqSeEVw1KOU0euMfwImfh4PAcvFH
         lwPOR/uupIVqkYPFPrOA2QAfR6wY2IYcsW8pEm0Unwa840esP/NRdmZfO1xl7GS1PB
         v/B4kC8KGjL/mYBjFU9S4viBF2B74wCsOK1P9nrc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5KHOBPB042502
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jun 2019 12:24:11 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 20
 Jun 2019 12:24:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 20 Jun 2019 12:24:11 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x5KHNrJY117342;
        Thu, 20 Jun 2019 12:24:08 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        <devicetree@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/5] dt-bindings: mtd: Add bindings for TI's AM654 HyperBus memory controller
Date:   Thu, 20 Jun 2019 22:52:49 +0530
Message-ID: <20190620172250.9102-5-vigneshr@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620172250.9102-1-vigneshr@ti.com>
References: <20190620172250.9102-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for TI's HyperBus memory controller present on
AM654 SoC.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---

v7: Fix example to move HyperBus node out of syscon
v6: Use generic names for bindings

 .../devicetree/bindings/mtd/ti,am654-hbmc.txt | 52 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt

diff --git a/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
new file mode 100644
index 000000000000..d424a0b88ab6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
@@ -0,0 +1,52 @@
+Bindings for HyperBus Memory Controller (HBMC) on TI's K3 family of SoCs
+
+Required properties:
+- compatible : "ti,am654-hbmc" for AM654 SoC
+- reg : Two entries:
+	First entry pointed to the register space of HBMC controller
+	Second entry pointing to the memory map region dedicated for
+	MMIO access to attached flash devices
+- ranges : Address translation from offset within CS to allocated MMIO
+	   space in SoC
+
+Optional properties:
+- mux-controls : phandle to the multiplexer that controls selection of
+		 HBMC vs OSPI inside Flash SubSystem (FSS). Default is OSPI,
+		 if property is absent.
+		 See Documentation/devicetree/bindings/mux/reg-mux.txt
+		 for mmio-mux binding details
+
+Example:
+
+	system-controller@47000000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x0 0x47000000 0x0 0x100>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hbmc_mux: multiplexer {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4 0x2>; /* 0: reg 0x4, bit 1 */
+		};
+
+	};
+
+	hbmc: hyperbus@47034000 {
+		compatible = "ti,am654-hbmc";
+		reg = <0x0 0x47034000 0x0 0x100>,
+			<0x5 0x00000000 0x1 0x0000000>;
+		power-domains = <&k3_pds 55>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0x0 0x0 0x5 0x00000000 0x4000000>, /* CS0 - 64MB */
+			 <0x1 0x0 0x5 0x04000000 0x4000000>; /* CS1 - 64MB */
+		mux-controls = <&hbmc_mux 0>;
+
+			/* Slave flash node */
+		flash@0,0 {
+			compatible = "cypress,hyperflash", "cfi-flash";
+			reg = <0x0 0x0 0x4000000>;
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 58c6ad3dae66..0d5a8c36682d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7359,6 +7359,7 @@ S:	Supported
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
+F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
 
 HYPERVISOR VIRTUAL CONSOLE DRIVER
 L:	linuxppc-dev@lists.ozlabs.org
-- 
2.22.0

