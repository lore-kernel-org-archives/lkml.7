Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79552C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5551520693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfDVNOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:14:02 -0400
Received: from [110.188.70.11] ([110.188.70.11]:5243 "EHLO spam2.hygon.cn"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726057AbfDVNOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:14:01 -0400
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id x3MDBMM1020867;
        Mon, 22 Apr 2019 21:11:22 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id x3MDB4Ct016123;
        Mon, 22 Apr 2019 21:11:04 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from pw-vbox.hygon.cn (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 22 Apr
 2019 21:11:18 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <jdelvare@suse.com>, <bp@alien8.de>
CC:     <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Pu Wen <puwen@hygon.cn>
Subject: [RFC PATCH RESEND] i2c-piix4: Add Hygon Dhyana SMBus support
Date:   Mon, 22 Apr 2019 21:10:07 +0800
Message-ID: <1555938607-2865-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn x3MDBMM1020867
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Hygon Dhyana CPU has the SMBus device with PCI device ID 0x790b,
which is the same as AMD CZ SMBus device. So add Hygon Dhyana support
to the i2c-piix4 driver by using the code path of AMD.

Cc: <stable@vger.kernel.org> # v5.0+
Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 drivers/i2c/busses/i2c-piix4.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
index 90946a8..9db9d9d 100644
--- a/drivers/i2c/busses/i2c-piix4.c
+++ b/drivers/i2c/busses/i2c-piix4.c
@@ -289,6 +289,9 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 	     PIIX4_dev->revision >= 0x41) ||
 	    (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
 	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
+	     PIIX4_dev->revision >= 0x49) ||
+	    (PIIX4_dev->vendor == PCI_VENDOR_ID_HYGON &&
+	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
 	     PIIX4_dev->revision >= 0x49))
 		smb_en = 0x00;
 	else
@@ -361,7 +364,8 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
 		 piix4_smba, i2ccfg >> 4);
 
 	/* Find which register is used for port selection */
-	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD) {
+	if (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD ||
+	    PIIX4_dev->vendor == PCI_VENDOR_ID_HYGON) {
 		switch (PIIX4_dev->device) {
 		case PCI_DEVICE_ID_AMD_KERNCZ_SMBUS:
 			piix4_port_sel_sb800 = SB800_PIIX4_PORT_IDX_KERNCZ;
@@ -794,6 +798,7 @@ static const struct pci_device_id piix4_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_HYGON, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
 		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
@@ -904,11 +909,13 @@ static int piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if ((dev->vendor == PCI_VENDOR_ID_ATI &&
 	     dev->device == PCI_DEVICE_ID_ATI_SBX00_SMBUS &&
 	     dev->revision >= 0x40) ||
-	    dev->vendor == PCI_VENDOR_ID_AMD) {
+	    dev->vendor == PCI_VENDOR_ID_AMD ||
+	    dev->vendor == PCI_VENDOR_ID_HYGON) {
 		bool notify_imc = false;
 		is_sb800 = true;
 
-		if (dev->vendor == PCI_VENDOR_ID_AMD &&
+		if ((dev->vendor == PCI_VENDOR_ID_AMD ||
+		     dev->vendor == PCI_VENDOR_ID_HYGON) &&
 		    dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) {
 			u8 imc;
 
-- 
2.7.4

