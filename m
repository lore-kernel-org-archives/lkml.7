Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB72C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC44F2133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g7aG8zlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfDBNiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:38:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48548 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbfDBNiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:38:05 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x32Dc35u091865;
        Tue, 2 Apr 2019 08:38:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1554212283;
        bh=Za2kgWFbKuq5etVSa0oON5gBamI1FQB22QDbBAHljnY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=g7aG8zlNpGMQ0eHX0k6JlGNAvWKe3fYCHJqiwqbBUvsr0raJM6RnIv1ZOk5X4eKrS
         pLH+pwkmlvbp9W+l88ZX5zIwWpWyMOkWfyxSQCyRZP51mBsGWXejOjeXlXBXnyagRZ
         CZt7C2lOaqAwMih6Uxb+DMdaOY5cwlu+3t4LJOZQ=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x32Dc314072470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Apr 2019 08:38:03 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 2 Apr
 2019 08:38:01 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 2 Apr 2019 08:38:01 -0500
Received: from lta0400828d.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x32DbsU1051551;
        Tue, 2 Apr 2019 08:38:00 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>
CC:     <nsekhar@ti.com>, <s-anna@ti.com>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [RFC PATCH 3/4] bus: ti-sysc: Add support for PRU-ICSS type
Date:   Tue, 2 Apr 2019 16:37:51 +0300
Message-ID: <20190402133752.6912-4-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402133752.6912-1-rogerq@ti.com>
References: <20190402133752.6912-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PRU-ICSS moduels has a SYSCONFIG register that is
similar to omap4-simple but with 2 speacial register bits.

Let's add a new type for that so we can deal with any
PRU-ICSS specific details if required.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 .../devicetree/bindings/bus/ti-sysc.txt       |  1 +
 drivers/bus/ti-sysc.c                         | 21 +++++++++++++++++++
 include/linux/platform_data/ti-sysc.h         |  7 ++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
index f200f45572ae..f9716c841ecd 100644
--- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
+++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
@@ -38,6 +38,7 @@ Required standard properties:
 		"ti,sysc-dra7-mcasp"
 		"ti,sysc-usb-host-fs"
 		"ti,sysc-dra7-mcan"
+		"ti,sysc-pruss"
 
 - reg		shall have register areas implemented for the interconnect
 		target module in question such as revision, sysc and syss
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 1e63b6265764..e4ab4d422ea5 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -1993,6 +1993,26 @@ static const struct sysc_capabilities sysc_dra7_mcan = {
 	.regbits = &sysc_regbits_dra7_mcan,
 };
 
+/*
+ * PRU-ICSS, similar to omap4-simple but has special bits
+ */
+static const struct sysc_regbits sysc_regbits_pruss = {
+	.dmadisable_shift = -ENODEV,
+	.midle_shift = 2,
+	.sidle_shift = 0,
+	.clkact_shift = -ENODEV,
+	.enwkup_shift = -ENODEV,
+	.srst_shift = -ENODEV,
+	.emufree_shift = -ENODEV,
+	.autoidle_shift = -ENODEV,
+	.standby_init_shift = 4,
+	.sub_mwait_shift = 5,
+};
+
+static const struct sysc_capabilities sysc_pruss = {
+	.type = TI_SYSC_PRUSS,
+	.regbits = &sysc_regbits_pruss,
+};
 static int sysc_init_pdata(struct sysc *ddata)
 {
 	struct ti_sysc_platform_data *pdata = dev_get_platdata(ddata->dev);
@@ -2186,6 +2206,7 @@ static const struct of_device_id sysc_match[] = {
 	{ .compatible = "ti,sysc-usb-host-fs",
 	  .data = &sysc_omap4_usb_host_fs, },
 	{ .compatible = "ti,sysc-dra7-mcan", .data = &sysc_dra7_mcan, },
+	{ .compatible = "ti,sysc-pruss", .data = &sysc_pruss, },
 	{  },
 };
 MODULE_DEVICE_TABLE(of, sysc_match);
diff --git a/include/linux/platform_data/ti-sysc.h b/include/linux/platform_data/ti-sysc.h
index 9256c0305968..bb95ae7da56c 100644
--- a/include/linux/platform_data/ti-sysc.h
+++ b/include/linux/platform_data/ti-sysc.h
@@ -15,6 +15,7 @@ enum ti_sysc_module_type {
 	TI_SYSC_OMAP4_MCASP,
 	TI_SYSC_OMAP4_USB_HOST_FS,
 	TI_SYSC_DRA7_MCAN,
+	TI_SYSC_PRUSS,
 };
 
 struct ti_sysc_cookie {
@@ -30,7 +31,9 @@ struct ti_sysc_cookie {
  * @srst_shift: Offset of the softreset bit
  * @autoidle_shift: Offset of the autoidle bit
  * @dmadisable_shift: Offset of the dmadisable bit
- * @emufree_shift; Offset of the emufree bit
+ * @emufree_shift: Offset of the emufree bit
+ * @standby_init_shift: Offset to standby_init bit
+ * @sub_mwait_shift: Offset to sub_mwait bit
  *
  * Note that 0 is a valid shift, and for ti-sysc.c -ENODEV can be used if a
  * feature is not available.
@@ -44,6 +47,8 @@ struct sysc_regbits {
 	s8 autoidle_shift;
 	s8 dmadisable_shift;
 	s8 emufree_shift;
+	s8 standby_init_shift;
+	s8 sub_mwait_shift;
 };
 
 #define SYSC_QUIRK_SWSUP_MSTANDBY	BIT(13)
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

