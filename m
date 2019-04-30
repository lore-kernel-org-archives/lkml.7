Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E17C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FCC21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yc7AHgJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfD3KNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:13:48 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:33096 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbfD3KNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:13:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3UADOT6038048;
        Tue, 30 Apr 2019 05:13:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556619204;
        bh=mLnzzKksfRjZM6aGZHSm2YrRfM1IEFAOPmdNzY48bug=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yc7AHgJny0VlzKkcH2/aNhiVIqS0qTLVJ2efCClF+OH3rYw/u5eO/n6SZDsWksLBk
         QY1n9ANlDcnooMiRVADyZiWDFhC8OPxV+4W9lHWBDGlp5eC6jjV2Vv98R8VukIub7f
         Vm1N/77n/zJR2zHxxtlGgQ3Eh1k+XpyJEMwbpkZU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3UADOHW021827
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Apr 2019 05:13:24 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Apr 2019 05:13:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Apr 2019 05:13:23 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3UAD0Y6085082;
        Tue, 30 Apr 2019 05:13:19 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 04/14] firmware: ti_sci: Add RM mapping table for am654
Date:   Tue, 30 Apr 2019 15:42:20 +0530
Message-ID: <20190430101230.21794-5-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430101230.21794-1-lokeshvutla@ti.com>
References: <20190430101230.21794-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

Add the resource mapping table for AM654 SoC as defined in
http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html
Introduce a new compatible for AM654 "ti,am654-sci" for using
this resource map table.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v7:
- None
 .../bindings/arm/keystone/ti,sci.txt          |  3 ++-
 drivers/firmware/ti_sci.c                     | 23 +++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
index b56a02c10ae6..6f0cd31c1520 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.txt
@@ -24,7 +24,8 @@ relationship between the TI-SCI parent node to the child node.
 
 Required properties:
 -------------------
-- compatible: should be "ti,k2g-sci"
+- compatible:	should be "ti,k2g-sci" for TI 66AK2G SoC
+		should be "ti,am654-sci" for for TI AM654 SoC
 - mbox-names:
 	"rx" - Mailbox corresponding to receive path
 	"tx" - Mailbox corresponding to transmit path
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 4ccdf9a53648..551895535767 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2282,10 +2282,33 @@ static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
 	.max_msgs = 20,
 	.max_msg_size = 64,
+	.rm_type_map = NULL,
+};
+
+static struct ti_sci_rm_type_map ti_sci_am654_rm_type_map[] = {
+	{.dev_id = 56, .type = 0x00b}, /* GIC_IRQ */
+	{.dev_id = 179, .type = 0x000}, /* MAIN_NAV_UDMASS_IA0 */
+	{.dev_id = 187, .type = 0x009}, /* MAIN_NAV_RA */
+	{.dev_id = 188, .type = 0x006}, /* MAIN_NAV_UDMAP */
+	{.dev_id = 194, .type = 0x007}, /* MCU_NAV_UDMAP */
+	{.dev_id = 195, .type = 0x00a}, /* MCU_NAV_RA */
+	{.dev_id = 0, .type = 0x000}, /* end of table */
+};
+
+/* Description for AM654 */
+static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
+	.default_host_id = 12,
+	/* Conservative duration */
+	.max_rx_timeout_ms = 10000,
+	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
+	.max_msgs = 20,
+	.max_msg_size = 60,
+	.rm_type_map = ti_sci_am654_rm_type_map,
 };
 
 static const struct of_device_id ti_sci_of_match[] = {
 	{.compatible = "ti,k2g-sci", .data = &ti_sci_pmmc_k2g_desc},
+	{.compatible = "ti,am654-sci", .data = &ti_sci_pmmc_am654_desc},
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, ti_sci_of_match);
-- 
2.21.0

