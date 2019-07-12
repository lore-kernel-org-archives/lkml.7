Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6D5C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E1120863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfGLGvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 02:51:52 -0400
Received: from inva021.nxp.com ([92.121.34.21]:43216 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfGLGvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 02:51:49 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D00F2000A1;
        Fri, 12 Jul 2019 08:51:46 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E515E200099;
        Fri, 12 Jul 2019 08:51:41 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4A39540293;
        Fri, 12 Jul 2019 14:51:36 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH V2 2/2] usb: dwc3: Add cache type configuration support
Date:   Fri, 12 Jul 2019 14:42:06 +0800
Message-Id: <20190712064206.48249-2-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190712064206.48249-1-ran.wang_1@nxp.com>
References: <20190712064206.48249-1-ran.wang_1@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure cache type for 4 different transfer types: Data Read,
Desc Read, Data Write and Desc write. For each treasfer type, controller has a
4-bit register field to enable different cache type.

Some Layerscape platforms might need this to resolve USB detect problem
when DWC3 node apply dma-coherent.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v2:
	- Change most program logic to meet new DTS property define.
	- Rename related register address macros.
	- Rename function  dwc3_enable_snooping() to dwc3_set_cache_type().

 drivers/usb/dwc3/core.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc3/core.h | 12 ++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4aff1d8..43bdd73 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -284,6 +284,69 @@ static const struct clk_bulk_data dwc3_core_clks[] = {
 };
 
 /*
+ * dwc3_set_cache_type - Configure cache type
+ * @dwc3: Pointer to our controller context structure
+ */
+static void dwc3_set_cache_type(struct dwc3 *dwc)
+{
+	int ret;
+	u32 tmp, reg, cache_type;
+	struct fwnode_handle *fwnode;
+
+	reg = dwc3_readl(dwc->regs,  DWC3_GSBUSCFG0);
+	tmp = reg;
+
+	fwnode = device_get_named_child_node(dwc->dev, "cache_type");
+	if (!fwnode) {
+		dev_info(dwc->dev, "Cache_type node no found, skip.\n");
+		return;
+	}
+
+	ret = fwnode_property_read_u32(fwnode,
+				       "transfer_type_datard", &cache_type);
+	if (ret) {
+		dev_err(dwc->dev,
+			"Can't find property transfer_type_datard.\n");
+		return;
+	}
+	reg &= ~DWC3_GSBUSCFG0_DATARD(~0);
+	reg |= DWC3_GSBUSCFG0_DATARD(cache_type);
+
+	ret = fwnode_property_read_u32(fwnode,
+				       "transfer_type_descrd", &cache_type);
+	if (ret) {
+		dev_err(dwc->dev,
+			"Can't find property transfer_type_descrd.\n");
+		return;
+	}
+	reg &= ~DWC3_GSBUSCFG0_DESCRD(~0);
+	reg |= DWC3_GSBUSCFG0_DESCRD(cache_type);
+
+	ret = fwnode_property_read_u32(fwnode,
+				       "transfer_type_datawr", &cache_type);
+	if (ret) {
+		dev_err(dwc->dev,
+			"Can't find property transfer_type_datawr.\n");
+		return;
+	}
+	reg &= ~DWC3_GSBUSCFG0_DATAWR(~0);
+	reg |= DWC3_GSBUSCFG0_DATAWR(cache_type);
+
+	ret = fwnode_property_read_u32(fwnode,
+				       "transfer_type_descwr", &cache_type);
+	if (ret) {
+		dev_err(dwc->dev,
+			"Can't find property transfer_type_descwr.\n");
+		return;
+	}
+	reg &= ~DWC3_GSBUSCFG0_DESCWR(~0);
+	reg |= DWC3_GSBUSCFG0_DESCWR(cache_type);
+
+	if (tmp != reg)
+		dwc3_writel(dwc->regs, DWC3_GSBUSCFG0, reg);
+}
+
+/*
  * dwc3_frame_length_adjustment - Adjusts frame length if required
  * @dwc3: Pointer to our controller context structure
  */
@@ -942,6 +1005,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	dwc3_frame_length_adjustment(dwc);
 
 	dwc3_set_incr_burst_type(dwc);
+	dwc3_set_cache_type(dwc);
 
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index f19cbeb..24a613f 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -165,6 +165,18 @@
 /* Bit fields */
 
 /* Global SoC Bus Configuration INCRx Register 0 */
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
 #define DWC3_GSBUSCFG0_INCR256BRSTENA	(1 << 7) /* INCR256 burst */
 #define DWC3_GSBUSCFG0_INCR128BRSTENA	(1 << 6) /* INCR128 burst */
 #define DWC3_GSBUSCFG0_INCR64BRSTENA	(1 << 5) /* INCR64 burst */
-- 
2.7.4

