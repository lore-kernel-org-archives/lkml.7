Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5A6C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4614D214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 06:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dwCIZXYg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfDWGGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 02:06:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40272 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfDWGGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 02:06:35 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3N667Le077913;
        Tue, 23 Apr 2019 01:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555999567;
        bh=asnU647SbSxNVpYJJFri++AE/jmwSHAWc7UkxrDjmwY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dwCIZXYgbgGzxA0HjNKElClTv5ydfADsndnxJ70qEI3D7z/6mA0C81S7ExhMGHEda
         BxHv8/1xj8ykYqXyPR9wTmrvmstEcUjm6yFiL7ueSYRmWI9MBiTaSWmjkYsQAo6V2L
         bXRFyKn0WV7+O5zY8/ONy46zXumS7OzK1SFduZZo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3N667Cd119341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 01:06:07 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 01:06:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 01:06:07 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3N65gFE091279;
        Tue, 23 Apr 2019 01:06:02 -0500
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
        <linux-arm-kernel@lists.infradead.org>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 4/5] dt-bindings: mtd: Add bindings for TI's AM654 HyperBus memory controller
Date:   Tue, 23 Apr 2019 11:36:37 +0530
Message-ID: <20190423060638.18197-5-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423060638.18197-1-vigneshr@ti.com>
References: <20190423060638.18197-1-vigneshr@ti.com>
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
 .../devicetree/bindings/mtd/ti,am654-hbmc.txt | 31 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt

diff --git a/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
new file mode 100644
index 000000000000..00888482df25
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
@@ -0,0 +1,31 @@
+Bindings for HyperBus Memory Controller (HBMC) on TI's K3 family of SoCs
+
+Required properties:
+- compatible : "ti,am654-hbmc" for AM654 SoC
+- reg : Two entries:
+	First entry pointed to the register space of HBMC controller
+	Second entry pointing to the memory map region dedicated for
+	MMIO access to attached flash devices
+- ranges : Address range allocated for each chipselect in the MMIO space
+
+Optional properties:
+- mux-controls: phandle to the multiplexer that controls selection of
+		HBMC vs OSPI. Mux state of 1 indicates HBMC is selected.
+
+Example:
+	hbmc: hbmc@47034000 {
+		compatible = "ti,am654-hbmc";
+		reg = <0x0 0x47034000 0x0 0x100>,
+			<0x5 0x00000000 0x1 0x0000000>;
+		power-domains = <&k3_pds 55>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0x5 0x00000000 0x4000000>, /* CS0 - 64MB */
+			 <0x1 0x5 0x04000000 0x4000000>; /* CS1 - 64MB
+
+		/* Slave flash node */
+		flash@0{
+			compatible = "cypress,hyperflash";
+			reg = <0x0 0x4000000>;
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 7aa1b3454a89..07455035fca9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7249,6 +7249,7 @@ S:	Supported
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 F:	Documentation/devicetree/bindings/mtd/cypress,hyperbus.txt
+F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
 
 HYPERVISOR VIRTUAL CONSOLE DRIVER
 L:	linuxppc-dev@lists.ozlabs.org
-- 
2.21.0

