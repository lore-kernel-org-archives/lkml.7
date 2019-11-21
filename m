Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC48C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDB52075A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 02:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKUCmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 21:42:33 -0500
Received: from inva020.nxp.com ([92.121.34.13]:40178 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbfKUCmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 21:42:33 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DB52F1A0C47;
        Thu, 21 Nov 2019 03:42:30 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 428581A052B;
        Thu, 21 Nov 2019 03:42:25 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 647D8402A9;
        Thu, 21 Nov 2019 10:42:18 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        Leo Li <leoyang.li@nxp.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v3 2/2] usb: dwc3: Add cache type configuration support
Date:   Thu, 21 Nov 2019 10:42:06 +0800
Message-Id: <20191121024206.32933-2-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191121024206.32933-1-ran.wang_1@nxp.com>
References: <20191121024206.32933-1-ran.wang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature is telling how to configure cache type on 4 different
transfer types: Data Read, Desc Read, Data Write and Desc write. For each
treasfer type, controller has a 4-bit register field to enable different
cache type. Quoted from DWC3 data book Table 6-5 Cache Type Bit Assignments:
----------------------------------------------------------------
MBUS_TYPE| bit[3]       |bit[2]       |bit[1]     |bit[0]
----------------------------------------------------------------
AHB      |Cacheable     |Bufferable   |Privilegge |Data
AXI3     |Write Allocate|Read Allocate|Cacheable  |Bufferable
AXI4     |Allocate Other|Allocate     |Modifiable |Bufferable
AXI4     |Other Allocate|Allocate     |Modifiable |Bufferable
Native   |Same as AXI   |Same as AXI  |Same as AXI|Same as AXI
----------------------------------------------------------------
Note: The AHB, AXI3, AXI4, and PCIe busses use different names for certain
signals, which have the same meaning:
  Bufferable = Posted
  Cacheable = Modifiable = Snoop (negation of No Snoop)

In most cases, driver support is not required unless the default values of
registers are not correct *and* DWC3 node has enabled dma-coherent. So far we
have observed USB device detect failure on some Layerscape platforms if this
programming was not applied.

Related struct:
struct dwc3_cache_type {
	u8 transfer_type_datard;
	u8 transfer_type_descrd;
	u8 transfer_type_datawr;
	u8 transfer_type_descwr;
};

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v3:
	- Replace cache type sub-node parsing with chip-specifc data parsing.

Change in v2:
	- Change most program logic to meet new DTS property define.
	- Rename related register address macros.
	- Rename function  dwc3_enable_snooping() to dwc3_set_cache_type().

 drivers/usb/dwc3/core.c | 67 ++++++++++++++++++++++++++++++++++++++++++++-----
 drivers/usb/dwc3/core.h | 15 +++++++++++
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 97d6ae3..0baa972 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -894,6 +894,53 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, cfg);
 }
 
+#ifdef CONFIG_OF
+struct dwc3_cache_type {
+	u8 transfer_type_datard;
+	u8 transfer_type_descrd;
+	u8 transfer_type_datawr;
+	u8 transfer_type_descwr;
+};
+
+static const struct dwc3_cache_type ls1088a_dwc3_cache_type = {
+	.transfer_type_datard = 2,
+	.transfer_type_descrd = 2,
+	.transfer_type_datawr = 2,
+	.transfer_type_descwr = 2,
+};
+
+/**
+ * dwc3_set_cache_type - Configure cache type registers
+ * @dwc: Pointer to our controller context structure
+ */
+static void dwc3_set_cache_type(struct dwc3 *dwc)
+{
+	u32 tmp, reg;
+	const struct dwc3_cache_type *cache_type =
+		device_get_match_data(dwc->dev);
+
+	if (cache_type) {
+		reg = dwc3_readl(dwc->regs,  DWC3_GSBUSCFG0);
+		tmp = reg;
+
+		reg &= ~DWC3_GSBUSCFG0_DATARD(~0);
+		reg |= DWC3_GSBUSCFG0_DATARD(cache_type->transfer_type_datard);
+
+		reg &= ~DWC3_GSBUSCFG0_DESCRD(~0);
+		reg |= DWC3_GSBUSCFG0_DESCRD(cache_type->transfer_type_descrd);
+
+		reg &= ~DWC3_GSBUSCFG0_DATAWR(~0);
+		reg |= DWC3_GSBUSCFG0_DATAWR(cache_type->transfer_type_datawr);
+
+		reg &= ~DWC3_GSBUSCFG0_DESCWR(~0);
+		reg |= DWC3_GSBUSCFG0_DESCWR(cache_type->transfer_type_descwr);
+
+		if (tmp != reg)
+			dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
+	}
+}
+#endif
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -952,6 +999,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_set_incr_burst_type(dwc);
 
+#ifdef CONFIG_OF
+	dwc3_set_cache_type(dwc);
+#endif
+
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
@@ -1837,12 +1888,16 @@ static const struct dev_pm_ops dwc3_dev_pm_ops = {
 
 #ifdef CONFIG_OF
 static const struct of_device_id of_dwc3_match[] = {
-	{
-		.compatible = "snps,dwc3"
-	},
-	{
-		.compatible = "synopsys,dwc3"
-	},
+	{ .compatible = "fsl,ls1012a-dwc3", .data = &ls1088a_dwc3_cache_type, },
+	{ .compatible = "fsl,ls1021a-dwc3", .data = &ls1088a_dwc3_cache_type, },
+	{ .compatible = "fsl,ls1028a-dwc3", .data = &ls1088a_dwc3_cache_type, },
+	{ .compatible = "fsl,ls1043a-dwc3", .data = &ls1088a_dwc3_cache_type, },
+	{ .compatible = "fsl,ls1046a-dwc3", .data = &ls1088a_dwc3_cache_type, },
+	{ .compatible = "fsl,ls1088a-dwc3", .data = &ls1088a_dwc3_cache_type, },
+	{ .compatible = "fsl,ls2088a-dwc3", .data = &ls1088a_dwc3_cache_type, },
+	{ .compatible = "fsl,lx2160a-dwc3", .data = &ls1088a_dwc3_cache_type, },
+	{ .compatible = "snps,dwc3" },
+	{ .compatible = "synopsys,dwc3"	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, of_dwc3_match);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1c8b3493..ac51dfe 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -165,6 +165,21 @@
 /* Bit fields */
 
 /* Global SoC Bus Configuration INCRx Register 0 */
+#ifdef CONFIG_OF
+#define DWC3_GSBUSCFG0_DATARD_SHIFT	28
+#define DWC3_GSBUSCFG0_DATARD(n)	(((n) & 0xf)		\
+			<< DWC3_GSBUSCFG0_DATARD_SHIFT)
+#define DWC3_GSBUSCFG0_DESCRD_SHIFT	24
+#define DWC3_GSBUSCFG0_DESCRD(n)	(((n) & 0xf)		\
+			<< DWC3_GSBUSCFG0_DESCRD_SHIFT)
+#define DWC3_GSBUSCFG0_DATAWR_SHIFT	20
+#define DWC3_GSBUSCFG0_DATAWR(n)	(((n) & 0xf)		\
+			<< DWC3_GSBUSCFG0_DATAWR_SHIFT)
+#define DWC3_GSBUSCFG0_DESCWR_SHIFT	16
+#define DWC3_GSBUSCFG0_DESCWR(n)	(((n) & 0xf)		\
+			<< DWC3_GSBUSCFG0_DESCWR_SHIFT)
+#endif
+
 #define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
 #define DWC3_GSBUSCFG0_INCR128BRSTENA	(1 << 6) /* INCR128 burst */
 #define DWC3_GSBUSCFG0_INCR64BRSTENA	(1 << 5) /* INCR64 burst */
-- 
2.7.4

