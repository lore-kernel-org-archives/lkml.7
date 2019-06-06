Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB86BC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 997EC20868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="GSrzvhVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbfFFTXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:23:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbfFFTXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:23:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x56JMvjR2102984
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 6 Jun 2019 12:22:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x56JMvjR2102984
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559848978;
        bh=2A4oP0eOHallQcu7bSK+9usjQOKuyt6NxmX8y2LrP3g=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=GSrzvhVXSxQMStTJYSNWOxiIYPjsL8ZfVXNp5Vb30P3hR9GzKypU2iHN1fZw+P9/c
         X2NXupmkRD2XBfDAuHPIQVFJ3qH9C6h4q8P4CLuREtx+gk9p4916baU+LbdxVwos4a
         xS8Lkix/nMGYHEhA+jePdtZNW9Dtoob1W17dzxmCEj09PJw8nMdUg1mp68oWfB4kNj
         164kabulNHSnKkXTPp3pn2FfXrZOJYyoX658qb+EPQtHr0vfC19RMOiOf07/D4aI+s
         VpRQi4GZ/PEMJHinb8986VudjdNITTRMU4AWs39o686ioKc6/Vrygn7K+SdpKDu77o
         KKJTV0mw7R11g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x56JMvI82102981;
        Thu, 6 Jun 2019 12:22:57 -0700
Date:   Thu, 6 Jun 2019 12:22:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Junichi Nomura <tipbot@zytor.com>
Message-ID: <tip-0a23ebc66a46786769dd68bfdaa3102345819b9c@git.kernel.org>
Cc:     fanc.fnst@cn.fujitsu.com, dirk.vandermerwe@netronome.com,
        mingo@kernel.org, bp@suse.de, dyoung@redhat.com,
        j-nomura@ce.jp.nec.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mingo@kernel.org, dirk.vandermerwe@netronome.com,
          fanc.fnst@cn.fujitsu.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, j-nomura@ce.jp.nec.com,
          tglx@linutronix.de, bp@suse.de, dyoung@redhat.com
In-Reply-To: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
References: <20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/boot: Use efi_setup_data for searching RSDP on
 kexec-ed kernels
Git-Commit-ID: 0a23ebc66a46786769dd68bfdaa3102345819b9c
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  0a23ebc66a46786769dd68bfdaa3102345819b9c
Gitweb:     https://git.kernel.org/tip/0a23ebc66a46786769dd68bfdaa3102345819b9c
Author:     Junichi Nomura <j-nomura@ce.jp.nec.com>
AuthorDate: Thu, 11 Apr 2019 15:49:32 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 6 Jun 2019 20:28:37 +0200

x86/boot: Use efi_setup_data for searching RSDP on kexec-ed kernels

Commit

  3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")

broke kexec boot on EFI systems. efi_get_rsdp_addr() in the early
parsing code tries to search RSDP from the EFI tables but that will
crash because the table address is virtual when the kernel was booted by
kexec (set_virtual_address_map() has run in the first kernel and cannot
be run again in the second kernel).

In the case of kexec, the physical address of EFI tables is provided via
efi_setup_data in boot_params, which is set up by kexec(1).

Factor out the table parsing code and use different pointers depending
on whether the kernel is booted by kexec or not.

 [ bp: Massage. ]

Fixes: 3a63f70bf4c3a ("x86/boot: Early parse RSDP and save it in boot_params")
Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: Dave Young <dyoung@redhat.com>
Link: https://lkml.kernel.org/r/20190408231011.GA5402@jeru.linux.bs1.fc.nec.co.jp
---
 arch/x86/boot/compressed/acpi.c | 143 ++++++++++++++++++++++++++++++----------
 1 file changed, 107 insertions(+), 36 deletions(-)

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index ad84239e595e..15255f388a85 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -44,17 +44,109 @@ static acpi_physical_address get_acpi_rsdp(void)
 	return addr;
 }
 
-/* Search EFI system tables for RSDP. */
-static acpi_physical_address efi_get_rsdp_addr(void)
+/*
+ * Search EFI system tables for RSDP.  If both ACPI_20_TABLE_GUID and
+ * ACPI_TABLE_GUID are found, take the former, which has more features.
+ */
+static acpi_physical_address
+__efi_get_rsdp_addr(unsigned long config_tables, unsigned int nr_tables,
+		    bool efi_64)
 {
 	acpi_physical_address rsdp_addr = 0;
 
 #ifdef CONFIG_EFI
-	unsigned long systab, systab_tables, config_tables;
+	int i;
+
+	/* Get EFI tables from systab. */
+	for (i = 0; i < nr_tables; i++) {
+		acpi_physical_address table;
+		efi_guid_t guid;
+
+		if (efi_64) {
+			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables + i;
+
+			guid  = tbl->guid;
+			table = tbl->table;
+
+			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
+				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
+				return 0;
+			}
+		} else {
+			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables + i;
+
+			guid  = tbl->guid;
+			table = tbl->table;
+		}
+
+		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
+			rsdp_addr = table;
+		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
+			return table;
+	}
+#endif
+	return rsdp_addr;
+}
+
+/* EFI/kexec support is 64-bit only. */
+#ifdef CONFIG_X86_64
+static struct efi_setup_data *get_kexec_setup_data_addr(void)
+{
+	struct setup_data *data;
+	u64 pa_data;
+
+	pa_data = boot_params->hdr.setup_data;
+	while (pa_data) {
+		data = (struct setup_data *)pa_data;
+		if (data->type == SETUP_EFI)
+			return (struct efi_setup_data *)(pa_data + sizeof(struct setup_data));
+
+		pa_data = data->next;
+	}
+	return NULL;
+}
+
+static acpi_physical_address kexec_get_rsdp_addr(void)
+{
+	efi_system_table_64_t *systab;
+	struct efi_setup_data *esd;
+	struct efi_info *ei;
+	char *sig;
+
+	esd = (struct efi_setup_data *)get_kexec_setup_data_addr();
+	if (!esd)
+		return 0;
+
+	if (!esd->tables) {
+		debug_putstr("Wrong kexec SETUP_EFI data.\n");
+		return 0;
+	}
+
+	ei = &boot_params->efi_info;
+	sig = (char *)&ei->efi_loader_signature;
+	if (strncmp(sig, EFI64_LOADER_SIGNATURE, 4)) {
+		debug_putstr("Wrong kexec EFI loader signature.\n");
+		return 0;
+	}
+
+	/* Get systab from boot params. */
+	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
+	if (!systab)
+		error("EFI system table not found in kexec boot_params.");
+
+	return __efi_get_rsdp_addr((unsigned long)esd->tables, systab->nr_tables, true);
+}
+#else
+static acpi_physical_address kexec_get_rsdp_addr(void) { return 0; }
+#endif /* CONFIG_X86_64 */
+
+static acpi_physical_address efi_get_rsdp_addr(void)
+{
+#ifdef CONFIG_EFI
+	unsigned long systab, config_tables;
 	unsigned int nr_tables;
 	struct efi_info *ei;
 	bool efi_64;
-	int size, i;
 	char *sig;
 
 	ei = &boot_params->efi_info;
@@ -88,49 +180,20 @@ static acpi_physical_address efi_get_rsdp_addr(void)
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
-		size		= sizeof(efi_config_table_64_t);
 	} else {
 		efi_system_table_32_t *stbl = (efi_system_table_32_t *)systab;
 
 		config_tables	= stbl->tables;
 		nr_tables	= stbl->nr_tables;
-		size		= sizeof(efi_config_table_32_t);
 	}
 
 	if (!config_tables)
 		error("EFI config tables not found.");
 
-	/* Get EFI tables from systab. */
-	for (i = 0; i < nr_tables; i++) {
-		acpi_physical_address table;
-		efi_guid_t guid;
-
-		config_tables += size;
-
-		if (efi_64) {
-			efi_config_table_64_t *tbl = (efi_config_table_64_t *)config_tables;
-
-			guid  = tbl->guid;
-			table = tbl->table;
-
-			if (!IS_ENABLED(CONFIG_X86_64) && table >> 32) {
-				debug_putstr("Error getting RSDP address: EFI config table located above 4GB.\n");
-				return 0;
-			}
-		} else {
-			efi_config_table_32_t *tbl = (efi_config_table_32_t *)config_tables;
-
-			guid  = tbl->guid;
-			table = tbl->table;
-		}
-
-		if (!(efi_guidcmp(guid, ACPI_TABLE_GUID)))
-			rsdp_addr = table;
-		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
-			return table;
-	}
+	return __efi_get_rsdp_addr(config_tables, nr_tables, efi_64);
+#else
+	return 0;
 #endif
-	return rsdp_addr;
 }
 
 static u8 compute_checksum(u8 *buffer, u32 length)
@@ -220,6 +283,14 @@ acpi_physical_address get_rsdp_addr(void)
 	if (!pa)
 		pa = boot_params->acpi_rsdp_addr;
 
+	/*
+	 * Try to get EFI data from setup_data. This can happen when we're a
+	 * kexec'ed kernel and kexec(1) has passed all the required EFI info to
+	 * us.
+	 */
+	if (!pa)
+		pa = kexec_get_rsdp_addr();
+
 	if (!pa)
 		pa = efi_get_rsdp_addr();
 
