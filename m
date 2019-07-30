Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46292C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C419208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 09:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Go7N6bLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbfG3JfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 05:35:13 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51456 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731420AbfG3JfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 05:35:11 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6U9YsIZ046197;
        Tue, 30 Jul 2019 04:34:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564479294;
        bh=DfFRpw7GPtmxTaDqZ1grWeRPjfw/85ryCRcZj2Zxl7w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Go7N6bLtYY+YDzs5scHQWdw8PfuFKC6TeEsWoGDmbGNS8fTzh6PEjUmbslShtap5I
         NoFUsNq+Y/vGei1ApipDHDTdAQT7Jta9XZl8atu3JgNSJUk3ncHCW0RUSoCVFDl++E
         9xaNEhI0/u0URTAJZXhkoMsm+CMS8DnCVURgMxbU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6U9Ysht053564
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jul 2019 04:34:54 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Jul 2019 04:34:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Jul 2019 04:34:53 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6U9YkTw027547;
        Tue, 30 Jul 2019 04:34:50 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v2 01/14] bindings: soc: ti: add documentation for k3 ringacc
Date:   Tue, 30 Jul 2019 12:34:37 +0300
Message-ID: <20190730093450.12664-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190730093450.12664-1-peter.ujfalusi@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
enable straightforward passing of work between a producer and a consumer.
There is one RINGACC module per NAVSS on TI AM65x and j721e.

This patch introduces RINGACC device tree bindings.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/soc/ti/k3-ringacc.txt | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt

diff --git a/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
new file mode 100644
index 000000000000..86954cf4fa99
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/k3-ringacc.txt
@@ -0,0 +1,59 @@
+* Texas Instruments K3 NavigatorSS Ring Accelerator
+
+The Ring Accelerator (RA) is a machine which converts read/write accesses
+from/to a constant address into corresponding read/write accesses from/to a
+circular data structure in memory. The RA eliminates the need for each DMA
+controller which needs to access ring elements from having to know the current
+state of the ring (base address, current offset). The DMA controller
+performs a read or write access to a specific address range (which maps to the
+source interface on the RA) and the RA replaces the address for the transaction
+with a new address which corresponds to the head or tail element of the ring
+(head for reads, tail for writes).
+
+The Ring Accelerator is a hardware module that is responsible for accelerating
+management of the packet queues. The K3 SoCs can have more than one RA instances
+
+Required properties:
+- compatible	: Must be "ti,am654-navss-ringacc";
+- reg		: Should contain register location and length of the following
+		  named register regions.
+- reg-names	: should be
+		  "rt" - The RA Ring Real-time Control/Status Registers
+		  "fifos" - The RA Queues Registers
+		  "proxy_gcfg" - The RA Proxy Global Config Registers
+		  "proxy_target" - The RA Proxy Datapath Registers
+- ti,num-rings	: Number of rings supported by RA
+- ti,sci-rm-range-gp-rings : TI-SCI RM subtype for GP ring range
+- ti,sci	: phandle on TI-SCI compatible System controller node
+- ti,sci-dev-id	: TI-SCI device id
+- msi-parent	: phandle for "ti,sci-inta" interrupt controller
+
+Optional properties:
+ -- ti,dma-ring-reset-quirk : enable ringacc / udma ring state interoperability
+		  issue software w/a
+
+Example:
+
+ringacc: ringacc@3c000000 {
+	compatible = "ti,am654-navss-ringacc";
+	reg =	<0x0 0x3c000000 0x0 0x400000>,
+		<0x0 0x38000000 0x0 0x400000>,
+		<0x0 0x31120000 0x0 0x100>,
+		<0x0 0x33000000 0x0 0x40000>;
+	reg-names = "rt", "fifos",
+		    "proxy_gcfg", "proxy_target";
+	ti,num-rings = <818>;
+	ti,sci-rm-range-gp-rings = <0x2>; /* GP ring range */
+	ti,dma-ring-reset-quirk;
+	ti,sci = <&dmsc>;
+	ti,sci-dev-id = <187>;
+	msi-parent = <&inta_main_udmass>;
+};
+
+client:
+
+dma_ipx: dma_ipx@<addr> {
+	...
+	ti,ringacc = <&ringacc>;
+	...
+}
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

