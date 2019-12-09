Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646C3C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333242071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLIVbM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:31:12 -0500
Received: from mail-oln040092253011.outbound.protection.outlook.com ([40.92.253.11]:56128
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726354AbfLIVbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:31:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOyVdon4aUv9NUlvuCFxwDvDh6mIj+d/gcSEQjz5FTqeDQL1rJNb+tP/GHRRQQYR70eCYohrOe3TOAWYIjlqBEzHoXWQwFqlHCTDiVJUvgThWy6qynaipYnVNusHvUHp5+GwCZreDdS21J+QkED9dTvKWv5m6V+fiKC1rSEYHMUHO9MrL/0Ivnud8iSa/Vd5syv83fUzw/DzPLUTcK3wopGKeQzbV1OG1NauVKl9yWUcSM8FB/rMWdtwzkBpKXpq52+7LaOaZZDxA9i+Iys2v6aLmaYIfy84zzov47VUrzksGHgzrnWy2pOsXI05F0LOJHGMpclsKfMji3PBBim1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wz9S715yrIld5P7lNH/d4XADhNT+0JWIAPuHfp87Do=;
 b=WuELJopshfKOH6b56rYU5Hp02wUvSHWB76nk6tubf/JyxxHBbbHtvValbMUk7XK6ZsMmzi90PgcJ6o6GgTzPH9UcEF91rxnwH3r5dCLucPaQWeHjNwHopASRW7Nwf+Mt8bo0hmuM31fVXtYxetFKuWwI3FffOYuV+hUGinE9xDvnPNDZeUk9vEqc1m7dz3F9zw81T99bph0kisiIYV+tD0zQq7kpA4iy2AEkpF6pVJUjX5jgH5RBdwV8J063cSilhUFfSIkhr2lbHxyMDqsBt2dLCt2lmBHe7TrswVFK3zObSq5keFnQqItMg7+/E0RbE8aalJyfZQgwvGh0ik+xRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT017.eop-APC01.prod.protection.outlook.com
 (10.152.250.56) by SG2APC01HT117.eop-APC01.prod.protection.outlook.com
 (10.152.251.51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Mon, 9 Dec
 2019 21:30:23 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
 SG2APC01FT017.mail.protection.outlook.com (10.152.250.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Mon, 9 Dec 2019 21:30:23 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 21:30:23 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [[RFC PATCH v1] 1/1] PCI: Add pci=nobbn to ignore ACPI _BBN method to
 override host bridge bus window
Thread-Topic: [[RFC PATCH v1] 1/1] PCI: Add pci=nobbn to ignore ACPI _BBN
 method to override host bridge bus window
Thread-Index: AQHVrtfd0zl4YBZzg0+ke2KUWaAOxg==
Date:   Mon, 9 Dec 2019 21:30:23 +0000
Message-ID: <PSXP216MB0438F3D8C09957C6A45BC43D80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0140.ausprd01.prod.outlook.com
 (2603:10c6:0:1b::25) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:B2C5CC0693B0A5CE4C6178505B5B4D098C564580279750B2335B3B0463C9C78F;UpperCasedChecksum:2A66B1F23B2FCD0B687D7940BF7C9D76DEF75222677E24E27204AEA9EC91AC6B;SizeAsReceived:7529;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [vozPjDOkg8PuoF67WWaFysIZ93inMQwH6ZgYjwT5ZeWrF3VwZMp9qerYn3+9zpMo]
x-microsoft-original-message-id: <20191209213008.GA15361@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: d131290a-3715-4fa8-9b4a-08d77ceeffce
x-ms-exchange-slblob-mailprops: zswcL9HXbeWFySZoc/1CdWpwdPrvG2Yo5WgwNUjBSC3T7fpjPwUKNLjf8JIjkrndDHd8EGf4n43avf7Ru08fmrL7rZ++soK8W+mLOHbQGTDXt/WquzShJqoItFutbRnEujb9OL4k5amGoLzHrt4yqx99rjwyo1qie5nftB+aW5cGDcbgrd+UrMXEihyWRBdW41VWSvMxSM/2wKeLCuEQleRFyNxyPI+bPfbWqhg1KYKNqAcyGxACGbp3H5drsMh1h+IJihjZ6Kj/rGs155Mby7ThRL4nmU7iR5JHz3nUNxDnrLeeKfJS0eyOZpuA/804X4me/DYs3Kx19NWMs/Ir/7rsHMjuIAT/LVF55ZS4RCqZzuPCiUojy+JEBe+JX297RKCJF0Q3sDB6Xun4uYNEIFIqRqSCqMGE/tIt2cLCXPOI24Z62hFfHJPJvBYjcAWlGEbZ6WRJygJPk1TNlE56G4cRg5tx5TWlsFk6aIqBN2GQ+iXfbjxXX1AOHEKv5W6+szPHNTWEG7Gexoegcr8NKJn4w2Gdo07AlYdGcAUUBIqZDwinhvFmB9k2DWj4Kig12MGaOSEI9YoKIU0mDCV6/Nayv5ZWDh3Sth+0dwSWL9/iRKynnUtvgcAmQE2IDBqONIRC1huMVHHHg3gRdbXPZqmV1no20hySsLzjb8Wlib9RqJrqmMuvPobK6gf4OH2fee1Jj5UnuKVGw5k8INZdZByutyIfA4XLgvF9IEiJ+0scgcf3x5Q7Y6IFd8L8OgTf
x-ms-traffictypediagnostic: SG2APC01HT117:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /GsmMdOAOIkj/rbV9nICqhzm7gYpSWGoj+SOn7k+NBp3KQQuH2QN+64WI0xj3LL4ClfrMhewNd8MDbIOpEjlvSO01PbcjwqTeNdHdETkUY+VsObz7+0JcvlNaKjLGXQIZPpSIL2p/TWPwfqG8fWb8lQ7XUIpWZu7XstBRMbTGhxvZd9t3rCaDTqgFTfR14/S
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B1E51E8909E684EAE869BAD97B743C5@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d131290a-3715-4fa8-9b4a-08d77ceeffce
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 21:30:23.6313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pci=nobbn kernel parameter.

Override the host bridge bus resource to [bus 00-ff] when specified.

Update documentation to reflect the above.

Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 arch/x86/include/asm/pci_x86.h                  |  1 +
 arch/x86/pci/acpi.c                             | 11 +++++++++++
 arch/x86/pci/common.c                           |  3 +++
 4 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cfe8c2b67..0333d9d63 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3432,6 +3432,8 @@
 				please report a bug.
 		nocrs		[X86] Ignore PCI host bridge windows from ACPI.
 				If you need to use this, please report a bug.
+		nobbn		[X86] Ignore PCI BIOS Bus Number from ACPI.
+				If you need to use this, please report a bug.
 		routeirq	Do IRQ routing for all PCI devices.
 				This is normally done in pci_enable_device(),
 				so this option is a temporary workaround
diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 73bb404f4..179cdd5d1 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -39,6 +39,7 @@ do {						\
 #define PCI_ROOT_NO_CRS		0x100000
 #define PCI_NOASSIGN_BARS	0x200000
 #define PCI_BIG_ROOT_WINDOW	0x400000
+#define PCI_ROOT_NO_BBN		0x800000
 
 extern unsigned int pci_probe;
 extern unsigned long pirq_table_addr;
diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 948656069..fc54a1f3c 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -20,6 +20,7 @@ struct pci_root_info {
 };
 
 static bool pci_use_crs = true;
+static bool pci_use_bbn = true;
 static bool pci_ignore_seg = false;
 
 static int __init set_use_crs(const struct dmi_system_id *id)
@@ -156,6 +157,8 @@ void __init pci_acpi_crs_quirks(void)
 	else if (pci_probe & PCI_USE__CRS)
 		pci_use_crs = true;
 
+	pci_use_bbn = !(pci_probe & PCI_ROOT_NO_BBN);
+
 	printk(KERN_INFO "PCI: %s host bridge windows from ACPI; "
 	       "if necessary, use \"pci=%s\" and report a bug\n",
 	       pci_use_crs ? "Using" : "Ignoring",
@@ -298,6 +301,14 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
 	struct resource_entry *entry, *tmp;
 	int status;
 
+	if (!pci_use_bbn){
+		dev_printk(KERN_DEBUG, &device->dev,
+			   "host bridge window %pR (ignored)\n",
+			   &ci->root->secondary);
+		ci->root->secondary.start = 0x00;
+		ci->root->secondary.end = 0xff;
+	}
+
 	status = acpi_pci_probe_root_resources(ci);
 	if (pci_use_crs) {
 		resource_list_for_each_entry_safe(entry, tmp, &ci->resources)
diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
index 9acab6ac2..9183a999f 100644
--- a/arch/x86/pci/common.c
+++ b/arch/x86/pci/common.c
@@ -594,6 +594,9 @@ char *__init pcibios_setup(char *str)
 	} else if (!strcmp(str, "nocrs")) {
 		pci_probe |= PCI_ROOT_NO_CRS;
 		return NULL;
+	} else if (!strcmp(str, "nobbn")) {
+		pci_probe |= PCI_ROOT_NO_BBN;
+		return NULL;
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
 	} else if (!strcmp(str, "big_root_window")) {
 		pci_probe |= PCI_BIG_ROOT_WINDOW;
-- 
2.24.0

