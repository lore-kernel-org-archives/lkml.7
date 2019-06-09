Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C28AC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A462080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 10:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gbt3jixQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfFIKca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 06:32:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37056 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728168AbfFIKc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 06:32:27 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x59AW4Pe056780;
        Sun, 9 Jun 2019 05:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1560076324;
        bh=ie7DaeNcCAecELQoSsCy4egwk0wIoDKbgOlLaGlCp/s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=gbt3jixQVvWRO9DmL8ShQlTHEbO3Wgl5xVp/OBMDCS1/q2Jg8KAJjDfF6AdtUgtIH
         SQK+Bq61iWHDc+Rnzzj2n7ybI0vzLgrHzB4upw0C8JH3pOkqU5Ivpudod2lV7M/VPO
         nKYOU165WTdC5eWngyowVABPGXmR74bRe+MgXpHk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x59AW4vb093359
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 9 Jun 2019 05:32:04 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sun, 9 Jun
 2019 05:32:03 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sun, 9 Jun 2019 05:32:03 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x59AVe1h049269;
        Sun, 9 Jun 2019 05:31:59 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
        <devicetree@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/5] dt-bindings: mtd: Add bindings for TI's AM654 HyperBus memory controller
Date:   Sun, 9 Jun 2019 16:02:26 +0530
Message-ID: <20190609103227.24875-5-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609103227.24875-1-vigneshr@ti.com>
References: <20190609103227.24875-1-vigneshr@ti.com>
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
v5:
Update binding example to show MMIO mux
Fix reg property for flash slave.

 .../devicetree/bindings/mtd/ti,am654-hbmc.txt | 51 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt

diff --git a/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
new file mode 100644
index 000000000000..c2a2c2b42a92
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
@@ -0,0 +1,51 @@
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
+		 HBMC vs OSPI inside Flash SubSystem. Default is OSPI,
+		 if property is absent.
+		 See Documentation/devicetree/bindings/mux/reg-mux.txt
+		 for mmio-mux binding details
+
+Example:
+
+	fss: fss@47000000 {
+		compatible = "syscon", "simple-mfd";
+		reg = <0x0 0x47000000 0x0 0x100>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		hbmc_mux: hbmc-mux {
+			compatible = "mmio-mux";
+			#mux-control-cells = <1>;
+			mux-reg-masks = <0x4 0x2>; /* 0: reg 0x4, bit 1 */
+		};
+
+		hbmc: hbmc@47034000 {
+			compatible = "ti,am654-hbmc";
+			reg = <0x0 0x47034000 0x0 0x100>,
+				<0x5 0x00000000 0x1 0x0000000>;
+			power-domains = <&k3_pds 55>;
+			#address-cells = <2>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x5 0x00000000 0x4000000>, /* CS0 - 64MB */
+				 <0x1 0x0 0x5 0x04000000 0x4000000>; /* CS1 - 64MB */
+			mux-controls = <&hbmc_mux 0>;
+
+			/* Slave flash node */
+			flash@0,0 {
+				compatible = "cypress,hyperflash", "cfi-flash";
+				reg = <0x0 0x0 0x4000000>;
+			};
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 258cf0d9eb8f..d6773a8e3ba2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7344,6 +7344,7 @@ S:	Supported
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 F:	Documentation/devicetree/bindings/mtd/cypress,hyperflash.txt
+F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
 
 HYPERVISOR VIRTUAL CONSOLE DRIVER
 L:	linuxppc-dev@lists.ozlabs.org
-- 
2.21.0

