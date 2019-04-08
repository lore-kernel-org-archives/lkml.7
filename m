Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826E3C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8DC213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 23:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfDHXNA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 19:13:00 -0400
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:33059 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfDHXNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 19:13:00 -0400
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id x38NCatJ010085
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Apr 2019 08:12:36 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id x38NCaqN028531;
        Tue, 9 Apr 2019 08:12:36 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id x38NCZrT027073;
        Tue, 9 Apr 2019 08:12:36 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.138] [10.38.151.138]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-4084239; Tue, 9 Apr 2019 08:10:19 +0900
Received: from BPXM12GP.gisp.nec.co.jp ([10.38.151.204]) by
 BPXC10GP.gisp.nec.co.jp ([10.38.151.138]) with mapi id 14.03.0319.002; Tue, 9
 Apr 2019 08:10:18 +0900
From:   Junichi Nomura <j-nomura@ce.jp.nec.com>
To:     Borislav Petkov <bp@alien8.de>, Dave Young <dyoung@redhat.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>
CC:     Kairui Song <kasong@redhat.com>, "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Topic: [PATCH v4] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernel
Thread-Index: AQHU7mA7GgPc7QEBzUqqAM4y7TnATA==
Date:   Mon, 8 Apr 2019 23:10:17 +0000
Message-ID: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.85]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <0BB3151BDA572D4F935FEB1953FCEFFC@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in
boot_params") broke kexec boot on EFI systems.  efi_get_rsdp_addr()
in the early parsing code tries to search RSDP from EFI table but
that will crash because the table address is virtual when the kernel
was booted by kexec.

In the case of kexec, physical address of EFI tables is provided
via efi_setup_data in boot_params, which is set up by kexec(1).

Factor out the table parsing code and use different pointers depending
on whether the kernel is booted by kexec or not.

Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Acked-by: Baoquan He <bhe@redhat.com>
Tested-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Dave Young <dyoung@redhat.com>

--
Original post:
  https://lore.kernel.org/lkml/20190322110342.GA16202@jeru.linux.bs1.fc.nec.co.jp/

v2: Added comments above __efi_get_rsdp_addr() and kexec_get_rsdp_addr() 

v3: Properly ifdef out 64bit-only kexec code to avoid 32bit build warnings

v4:
 - Make sure to avoid efi_get_rsdp_addr() when kexec setup_data exists
   even if the data is invalid.
 - Return instead of hang if systab is 0 in kexec_get_rsdp_addr().
 - Check 32bit EFI loader signature in the case of kexec as well.
 - Factor out EFI-related boot_params handling into efi_read_boot_params() to
   avoid duplication between efi_get_rsdp_addr() and kexec_get_rsdp_addr().

The patch was tested on 3 different models of EFI-booted physical machines
for both normal kexec and panic kexec.

There is a report, that similar problem still happens even with this patch:
  https://lore.kernel.org/lkml/20190404140809.GA7789@dhcp-128-65.nay.redhat.com/

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 0ef4ad5..2bc8dca 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -44,71 +44,80 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return addr;
 }
 
-/* Search EFI system tables for RSDP. */
-static acpi_physical_address efi_get_rsdp_addr(void)
+#ifdef CONFIG_EFI
+static unsigned long kexec_efi_setup_data;
+static unsigned long efi_systab;
+static bool efi_booted;
+static bool efi_64;
+
+static unsigned long efi_get_kexec_setup_data_addr(void)
 {
-	acpi_physical_address rsdp_addr = 0;
+#if defined(CONFIG_X86_64)
+	struct setup_data *data;
+	u64 pa_data;
+
+	pa_data = boot_params->hdr.setup_data;
+	while (pa_data) {
+		data = (struct setup_data *) pa_data;
+		if (data->type == SETUP_EFI)
+			return pa_data + sizeof(struct setup_data);
+		pa_data = data->next;
+	}
+#endif
+	return 0;
+}
 
-#ifdef CONFIG_EFI
-	unsigned long systab, systab_tables, config_tables;
-	unsigned int nr_tables;
+static void efi_read_boot_params(void)
+{
+	struct efi_setup_data *esd;
 	struct efi_info *ei;
-	bool efi_64;
-	int size, i;
 	char *sig;
 
+	kexec_efi_setup_data = efi_get_kexec_setup_data_addr();
+
 	ei = &boot_params->efi_info;
 	sig = (char *)&ei->efi_loader_signature;
 
 	if (!strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
 		efi_64 = true;
+		efi_booted = true;
 	} else if (!strncmp(sig, EFI32_LOADER_SIGNATURE, 4)) {
 		efi_64 = false;
+		efi_booted = true;
 	} else {
 		debug_putstr("Wrong EFI loader signature.\n");
-		return 0;
+		return;
 	}
 
 	/* Get systab from boot params. */
 #ifdef CONFIG_X86_64
-	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
+	efi_systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
 #else
 	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
 		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
-		return 0;
+		return;
 	}
-	systab = ei->efi_systab;
+	efi_systab = ei->efi_systab;
 #endif
-	if (!systab)
-		error("EFI system table not found.");
-
-	/* Handle EFI bitness properly */
-	if (efi_64) {
-		efi_system_table_64_t *stbl = (efi_system_table_64_t *)systab;
-
-		config_tables	= stbl->tables;
-		nr_tables	= stbl->nr_tables;
-		size		= sizeof(efi_config_table_64_t);
-	} else {
-		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
-
-		config_tables	= stbl->tables;
-		nr_tables	= stbl->nr_tables;
-		size		= sizeof(efi_config_table_32_t);
-	}
+}
 
-	if (!config_tables)
-		error("EFI config tables not found.");
+/*
+ * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
+ * ACPI_TABLE_GUID are found, take the former, which has more features.
+ */
+static acpi_physical_address
+__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables)
+{
+	acpi_physical_address rsdp_addr = 0;
+	int i;
 
 	/* Get EFI tables from systab. */
 	for (i = 0; i < nr_tables; i++) {
 		acpi_physical_address table;
 		efi_guid_t guid;
 
-		config_tables += size;
-
 		if (efi_64) {
-			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables;
+			efi_config_table_64_t *tbl = (efi_config_table_64_t *) config_tables + i;
 
 			guid  = tbl->guid;
 			table = tbl->table;
@@ -118,7 +127,7 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 				return 0;
 			}
 		} else {
-			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables;
+			efi_config_table_32_t *tbl = (efi_config_table_32_t *) config_tables + i;
 
 			guid  = tbl->guid;
 			table = tbl->table;
@@ -129,9 +138,88 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
 			return table;
 	}
-#endif
+
 	return rsdp_addr;
 }
+#endif
+
+/*
+ * EFI/kexec support is only added for 64bit. So we don't have to
+ * care 32bit case.
+ */
+static acpi_physical_address kexec_get_rsdp_addr(void)
+{
+#if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
+	struct efi_setup_data *esd;
+	unsigned int nr_tables;
+
+	if (!efi_booted || !kexec_efi_setup_data)
+		return 0;
+
+	esd = (struct efi_setup_data *) kexec_efi_setup_data;
+
+	if (!esd->tables) {
+		debug_putstr("Wrong kexec SETUP_EFI data.\n");
+		return 0;
+	}
+
+	if (!efi_systab) {
+		debug_putstr("EFI system table not found in kexec boot_params.");
+		return 0;
+	}
+
+	/* Handle EFI bitness properly */
+	if (efi_64) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)efi_systab;
+
+		nr_tables	= stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)efi_systab;
+
+		nr_tables	= stbl->nr_tables;
+	}
+
+	return __efi_get_rsdp_addr((unsigned long) esd->tables, nr_tables);
+#else
+	return 0;
+#endif
+}
+
+static acpi_physical_address efi_get_rsdp_addr(void)
+{
+#ifdef CONFIG_EFI
+	unsigned long config_tables;
+	unsigned int nr_tables;
+
+	efi_read_boot_params();
+
+	if (!efi_booted || kexec_efi_setup_data)
+		return 0;
+
+	if (!efi_systab)
+		error("EFI system table not found.");
+
+	/* Handle EFI bitness properly */
+	if (efi_64) {
+		efi_system_table_64_t *stbl = (efi_system_table_64_t *)efi_systab;
+
+		config_tables	= stbl->tables;
+		nr_tables	= stbl->nr_tables;
+	} else {
+		efi_system_table_32_t *stbl = (efi_system_table_32_t *)efi_systab;
+
+		config_tables	= stbl->tables;
+		nr_tables	= stbl->nr_tables;
+	}
+
+	if (!config_tables)
+		error("EFI config tables not found.");
+
+	return __efi_get_rsdp_addr(config_tables, nr_tables);
+#else
+	return 0;
+#endif
+}
 
 static u8 compute_checksum(u8 *buffer, u32 length)
 {
@@ -224,6 +312,9 @@ acpi_physical_address get_rsdp_addr(void)
 		pa = efi_get_rsdp_addr();
 
 	if (!pa)
+		pa = kexec_get_rsdp_addr();
+
+	if (!pa)
 		pa = bios_get_rsdp_addr();
 
 	return pa;
