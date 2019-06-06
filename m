Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A6EC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32A520868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TuvpXNtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbfFFTXc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:23:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50801 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729053AbfFFTXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:23:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x56JMDPp2102928
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 6 Jun 2019 12:22:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x56JMDPp2102928
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559848934;
        bh=B9H4CNnwxmfVdYMXYG4y49g0B29mcFnXNGsdvhYtCvA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TuvpXNtL/hgp3bfk7h1qNIBbqYctJ2aEmY/KydNewBwwmHsc/7lp7Ofqf1A83rBOY
         kKr5MiK01i/77FH4c6pTj9fH/PkQ/6Qokh7fGOSOKY0oqcgL2ISzvda9AcPjdE684I
         iTVZ7qlpVcMgUz7jVfRdPL+dlDbj6RZCpQUiiGAlcynlp3CUffKWgGuzQqWhUqRPVj
         272Dslgc8YCADDUkqPGCb0yJFN+6g19eybwNVhAhwhTQvEMGP/Re7SdFw5e3G8fdGu
         QdyRig2jPIIwsjr5K5QlJWqT/e/A6pMA2snqbJdTR6qzzblliJ5hQ0l++SJhhNIoNF
         1YgfSPG9Cm5Pw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x56JMCWL2102925;
        Thu, 6 Jun 2019 12:22:12 -0700
Date:   Thu, 6 Jun 2019 12:22:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kairui Song <tipbot@zytor.com>
Message-ID: <tip-6bbeb276b71f06c5267bfd154629b1bec82e7136@git.kernel.org>
Cc:     mingo@redhat.com, lijiang@redhat.com,
        penguin-kernel@I-love.SAKURA.ne.jp, dirk.vandermerwe@netronome.com,
        x86@kernel.org, bhe@redhat.com, bp@suse.de, hpa@zytor.com,
        tglx@linutronix.de, kasong@redhat.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mingo@kernel.org
Reply-To: kirill.shutemov@linux.intel.com, lijiang@redhat.com,
          mingo@redhat.com, linux-kernel@vger.kernel.org,
          kasong@redhat.com, bp@suse.de, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, bhe@redhat.com, dirk.vandermerwe@netronome.com,
          x86@kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
In-Reply-To: <20190429002318.GA25400@MiWiFi-R3L-srv>
References: <20190429002318.GA25400@MiWiFi-R3L-srv>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/kexec: Add the EFI system tables and ACPI tables
 to the ident map
Git-Commit-ID: 6bbeb276b71f06c5267bfd154629b1bec82e7136
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

Commit-ID:  6bbeb276b71f06c5267bfd154629b1bec82e7136
Gitweb:     https://git.kernel.org/tip/6bbeb276b71f06c5267bfd154629b1bec82e7136
Author:     Kairui Song <kasong@redhat.com>
AuthorDate: Mon, 29 Apr 2019 08:23:18 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 6 Jun 2019 20:13:48 +0200

x86/kexec: Add the EFI system tables and ACPI tables to the ident map

Currently, only the whole physical memory is identity-mapped for the
kexec kernel and the regions reserved by firmware are ignored.

However, the recent addition of RSDP parsing in the decompression stage
and especially:

  33f0df8d843d ("x86/boot: Search for RSDP in the EFI tables")

which tries to access EFI system tables and to dig out the RDSP address
from there, becomes a problem because in certain configurations, they
might not be mapped in the kexec'ed kernel's address space.

What is more, this problem doesn't appear on all systems because the
kexec kernel uses gigabyte pages to build the identity mapping. And
the EFI system tables and ACPI tables can, depending on the system
configuration, end up being mapped as part of all physical memory, if
they share the same 1 GB area with the physical memory.

Therefore, make sure they're always mapped.

 [ bp: productize half-baked patch:
   - rewrite commit message.
   - correct the map_acpi_tables() function name in the !ACPI case. ]

Signed-off-by: Kairui Song <kasong@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Dirk van der Merwe <dirk.vandermerwe@netronome.com>
Cc: dyoung@redhat.com
Cc: fanc.fnst@cn.fujitsu.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: j-nomura@ce.jp.nec.com
Cc: kexec@lists.infradead.org
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Lianbo Jiang <lijiang@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190429002318.GA25400@MiWiFi-R3L-srv
---
 arch/x86/kernel/machine_kexec_64.c | 75 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..3c77bdf7b32a 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
+#include <linux/efi.h>
 
 #include <asm/init.h>
 #include <asm/pgtable.h>
@@ -29,6 +30,43 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 
+#ifdef CONFIG_ACPI
+/*
+ * Used while adding mapping for ACPI tables.
+ * Can be reused when other iomem regions need be mapped
+ */
+struct init_pgtable_data {
+	struct x86_mapping_info *info;
+	pgd_t *level4p;
+};
+
+static int mem_region_callback(struct resource *res, void *arg)
+{
+	struct init_pgtable_data *data = arg;
+	unsigned long mstart, mend;
+
+	mstart = res->start;
+	mend = mstart + resource_size(res) - 1;
+
+	return kernel_ident_mapping_init(data->info, data->level4p, mstart, mend);
+}
+
+static int
+map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p)
+{
+	unsigned long flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	struct init_pgtable_data data;
+
+	data.info = info;
+	data.level4p = level4p;
+	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+	return walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
+				   &data, mem_region_callback);
+}
+#else
+static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
+#endif
+
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
@@ -36,6 +74,31 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 };
 #endif
 
+static int
+map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
+{
+#ifdef CONFIG_EFI
+	unsigned long mstart, mend;
+
+	if (!efi_enabled(EFI_BOOT))
+		return 0;
+
+	mstart = (boot_params.efi_info.efi_systab |
+			((u64)boot_params.efi_info.efi_systab_hi<<32));
+
+	if (efi_enabled(EFI_64BIT))
+		mend = mstart + sizeof(efi_system_table_64_t);
+	else
+		mend = mstart + sizeof(efi_system_table_32_t);
+
+	if (!mstart)
+		return 0;
+
+	return kernel_ident_mapping_init(info, level4p, mstart, mend);
+#endif
+	return 0;
+}
+
 static void free_transition_pgtable(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.p4d);
@@ -159,6 +222,18 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 			return result;
 	}
 
+	/*
+	 * Prepare EFI systab and ACPI tables for kexec kernel since they are
+	 * not covered by pfn_mapped.
+	 */
+	result = map_efi_systab(&info, level4p);
+	if (result)
+		return result;
+
+	result = map_acpi_tables(&info, level4p);
+	if (result)
+		return result;
+
 	return init_transition_pgtable(image, level4p);
 }
 
