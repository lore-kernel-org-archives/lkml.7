Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30CBEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3282190A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 17:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="toFWAxWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfCURpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 13:45:40 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38666 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfCURpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 13:45:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2LHj3Wo058169;
        Thu, 21 Mar 2019 12:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553190303;
        bh=l0To2RoHdy/93psR9yDkH4oZEU+/Y/g7HtDgZov8eoc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=toFWAxWpW3FZaRwD4cjYo5t+LjUU2uin8MJUFIVdzYg/kyWMFD+f4DN10Y3OrLd05
         XdwmX7QjHqQjMaONBSoTcrfORg8JOhfXdoQBh8LeMPWQ+vxmVovKQuF+Iodh2uoqzg
         Tgb/5fmG6IdkAMYP7SqpxFoKLMxjqjpVYokkUDbg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2LHj2ZQ016325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Mar 2019 12:45:03 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 21
 Mar 2019 12:45:01 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Thu, 21 Mar 2019 12:45:02 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2LHiq2V018392;
        Thu, 21 Mar 2019 12:44:57 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Vignesh R <vigneshr@ti.com>, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <tudor.ambarus@microchip.com>, <nsekhar@ti.com>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [RFC PATCH v2 1/5] mtd: cfi_cmdset_0002: Add support for polling status register
Date:   Thu, 21 Mar 2019 23:15:44 +0530
Message-ID: <20190321174548.9288-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321174548.9288-1-vigneshr@ti.com>
References: <20190321174548.9288-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HyperFlash devices are compliant with CFI AMD/Fujitsu Extended Command
Set(0x0002) for flash operations, therefore drivers/mtd/chips/cfi_cmdset_0002.c
can be use as is. But these devices do not support DQ polling method of
determining chip ready/good status. These flashes provide Status
Register whose bits can be polled to know status of flash operation.

Cypress HyperFlash datasheet here[1], talks about CFI Amd/Fujitsu
Extended Query version 1.5. Bit 0 of "Software Features supported" field
of CFI Primary Vendor-Specific Extended Query table indicates
presence/absence of status register and Bit 1 indicates whether or not
DQ polling is supported. Using these bits, its possible to determine
whether flash supports DQ polling or need to use Status Register.

Add support for polling status register to know device ready/status of
erase/write operations when DQ polling is not supported.

[1] https://www.cypress.com/file/213346/download

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/chips/cfi_cmdset_0002.c | 50 +++++++++++++++++++++++++++++
 include/linux/mtd/cfi.h             |  5 +++
 2 files changed, 55 insertions(+)

diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 72428b6bfc47..29987d8e6c6e 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -49,6 +49,14 @@
 #define SST49LF008A		0x005a
 #define AT49BV6416		0x00d6
 
+/*
+ * Bits of Status Register definition for flash devices that don't
+ * support DQ polling (Eg.: Hyperflash)
+ */
+#define CFI_SR_DRB		BIT(7)
+#define CFI_SR_ESB		BIT(5)
+#define CFI_SR_PSB		BIT(4)
+
 static int cfi_amdstd_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int cfi_amdstd_write_words(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
 static int cfi_amdstd_write_buffers(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
@@ -97,6 +105,18 @@ static struct mtd_chip_driver cfi_amdstd_chipdrv = {
 	.module		= THIS_MODULE
 };
 
+/*
+ * Use status register to poll for Erase/write completion when DQ is not
+ * supported. This is indicated by Bit[1:0] of SoftwareFeatures field in
+ * CFI Primary Vendor-Specific Extended Query table 1.5
+ */
+static int cfi_use_status_reg(struct cfi_private *cfi)
+{
+	struct cfi_pri_amdstd *extp = cfi->cmdset_priv;
+
+	return (extp->MinorVersion >= '5') &&
+		(extp->SoftwareFeatures & 0x11) == 1;
+}
 
 /* #define DEBUG_CFI_FEATURES */
 
@@ -744,8 +764,21 @@ static struct mtd_info *cfi_amdstd_setup(struct mtd_info *mtd)
  */
 static int __xipram chip_ready(struct map_info *map, unsigned long addr)
 {
+	struct cfi_private *cfi = map->fldrv_priv;
 	map_word d, t;
 
+	if (cfi_use_status_reg(cfi)) {
+		/*
+		 * For chips that support status register, check device
+		 * ready bit
+		 */
+		cfi_send_gen_cmd(0x70, cfi->addr_unlock1, 0, map, cfi,
+				 cfi->device_type, NULL);
+		d = map_read(map, addr);
+
+		return d.x[0] & CFI_SR_DRB;
+	}
+
 	d = map_read(map, addr);
 	t = map_read(map, addr);
 
@@ -769,8 +802,25 @@ static int __xipram chip_ready(struct map_info *map, unsigned long addr)
  */
 static int __xipram chip_good(struct map_info *map, unsigned long addr, map_word expected)
 {
+	struct cfi_private *cfi = map->fldrv_priv;
 	map_word oldd, curd;
 
+	if (cfi_use_status_reg(cfi)) {
+		/*
+		 * For chips that support status register, check device
+		 * ready bit and Erase/Program status bit to know if
+		 * operation succeeded.
+		 */
+		cfi_send_gen_cmd(0x70, cfi->addr_unlock1, 0, map, cfi,
+				 cfi->device_type, NULL);
+		curd = map_read(map, addr);
+
+		if (curd.x[0] & CFI_SR_DRB)
+			return !(curd.x[0] & (CFI_SR_PSB | CFI_SR_ESB));
+
+		return 0;
+	}
+
 	oldd = map_read(map, addr);
 	curd = map_read(map, addr);
 
diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h
index cbf77168658c..92ac82ac2329 100644
--- a/include/linux/mtd/cfi.h
+++ b/include/linux/mtd/cfi.h
@@ -233,6 +233,11 @@ struct cfi_pri_amdstd {
 	uint8_t  VppMin;
 	uint8_t  VppMax;
 	uint8_t  TopBottom;
+	/* Below field are added from version 1.5 */
+	uint8_t  ProgramSuspend;
+	uint8_t  UnlockBypass;
+	uint8_t  SecureSiliconSector;
+	uint8_t  SoftwareFeatures;
 } __packed;
 
 /* Vendor-Specific PRI for Atmel chips (command set 0x0002) */
-- 
2.21.0

