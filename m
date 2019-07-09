Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C7EC73C41
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6425F214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGIMeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:34:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfGIMeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:34:04 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hkpJq-0006GW-63; Tue, 09 Jul 2019 14:34:02 +0200
Date:   Tue, 09 Jul 2019 12:33:14 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/boot for 5.3-rc1
Message-ID: <156267559466.6547.5675975755906539836.tglx@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-boot-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-for-linus

up to:  8ff80fbe7e98: x86/kdump/64: Restrict kdump kernel reservation to <64TB

Assorted updates to kexec/kdump:

  - Proper kexec support for 4/5-level paging and jumping from a 5-level to
    a 4-level paging kernel.
 
  - Make the EFI support for kexec/kdump more robust

  - Enforce that the GDT is properly aligned instead of getting the
    alignment by chance.

Thanks,

	tglx

------------------>
Baoquan He (3):
      x86/boot: Add xloadflags bits to check for 5-level paging support
      x86/kexec/64: Prevent kexec from 5-level paging to a 4-level only kernel
      x86/kdump/64: Restrict kdump kernel reservation to <64TB

Borislav Petkov (2):
      Revert "x86/boot: Disable RSDP parsing temporarily"
      x86/boot: Call get_rsdp_addr() after console_init()

Junichi Nomura (1):
      x86/boot: Use efi_setup_data for searching RSDP on kexec-ed kernels

Kairui Song (2):
      x86/kexec: Add the EFI system tables and ACPI tables to the ident map
      x86/kexec: Add the ACPI NVS region to the ident map

Xiaoyao Li (1):
      x86/boot: Make the GDT 8-byte aligned


 arch/x86/boot/compressed/acpi.c       | 143 +++++++++++++++++++++++++---------
 arch/x86/boot/compressed/head_64.S    |   1 +
 arch/x86/boot/compressed/misc.c       |  11 ++-
 arch/x86/boot/header.S                |  12 ++-
 arch/x86/include/uapi/asm/bootparam.h |   2 +
 arch/x86/kernel/kexec-bzimage64.c     |   5 ++
 arch/x86/kernel/machine_kexec_64.c    |  87 +++++++++++++++++++++
 arch/x86/kernel/setup.c               |  15 +++-
 include/linux/sizes.h                 |   1 +
 9 files changed, 234 insertions(+), 43 deletions(-)

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
 
diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index fafb75c6c592..6233ae35d0d9 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -659,6 +659,7 @@ no_longmode:
 gdt64:
 	.word	gdt_end - gdt
 	.quad   0
+	.balign	8
 gdt:
 	.word	gdt_end - gdt
 	.long	gdt
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 5a237e8dbf8d..24e65a0f756d 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -351,9 +351,6 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	/* Clear flags intended for solely in-kernel use. */
 	boot_params->hdr.loadflags &= ~KASLR_FLAG;
 
-	/* Save RSDP address for later use. */
-	/* boot_params->acpi_rsdp_addr = get_rsdp_addr(); */
-
 	sanitize_boot_params(boot_params);
 
 	if (boot_params->screen_info.orig_video_mode == 7) {
@@ -368,6 +365,14 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	cols = boot_params->screen_info.orig_video_cols;
 
 	console_init();
+
+	/*
+	 * Save RSDP address for later use. Have this after console_init()
+	 * so that early debugging output from the RSDP parsing code can be
+	 * collected.
+	 */
+	boot_params->acpi_rsdp_addr = get_rsdp_addr();
+
 	debug_putstr("early console in extract_kernel\n");
 
 	free_mem_ptr     = heap;	/* Heap */
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 850b8762e889..be19f4199727 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -419,7 +419,17 @@ xloadflags:
 # define XLF4 0
 #endif
 
-			.word XLF0 | XLF1 | XLF23 | XLF4
+#ifdef CONFIG_X86_64
+#ifdef CONFIG_X86_5LEVEL
+#define XLF56 (XLF_5LEVEL|XLF_5LEVEL_ENABLED)
+#else
+#define XLF56 XLF_5LEVEL
+#endif
+#else
+#define XLF56 0
+#endif
+
+			.word XLF0 | XLF1 | XLF23 | XLF4 | XLF56
 
 cmdline_size:   .long   COMMAND_LINE_SIZE-1     #length of the command line,
                                                 #added with boot protocol
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 60733f137e9a..c895df5482c5 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -29,6 +29,8 @@
 #define XLF_EFI_HANDOVER_32		(1<<2)
 #define XLF_EFI_HANDOVER_64		(1<<3)
 #define XLF_EFI_KEXEC			(1<<4)
+#define XLF_5LEVEL			(1<<5)
+#define XLF_5LEVEL_ENABLED		(1<<6)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 22f60dd26460..7f439739ea3d 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -321,6 +321,11 @@ static int bzImage64_probe(const char *buf, unsigned long len)
 		return ret;
 	}
 
+	if (!(header->xloadflags & XLF_5LEVEL) && pgtable_l5_enabled()) {
+		pr_err("bzImage cannot handle 5-level paging mode.\n");
+		return ret;
+	}
+
 	/* I've got a bzImage */
 	pr_debug("It's a relocatable bzImage64\n");
 	ret = 0;
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..b2b88dcaaf88 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
+#include <linux/efi.h>
 
 #include <asm/init.h>
 #include <asm/pgtable.h>
@@ -29,6 +30,55 @@
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
+	struct init_pgtable_data data;
+	unsigned long flags;
+	int ret;
+
+	data.info = info;
+	data.level4p = level4p;
+	flags = IORESOURCE_MEM | IORESOURCE_BUSY;
+
+	ret = walk_iomem_res_desc(IORES_DESC_ACPI_TABLES, flags, 0, -1,
+				  &data, mem_region_callback);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	/* ACPI tables could be located in ACPI Non-volatile Storage region */
+	ret = walk_iomem_res_desc(IORES_DESC_ACPI_NV_STORAGE, flags, 0, -1,
+				  &data, mem_region_callback);
+	if (ret && ret != -EINVAL)
+		return ret;
+
+	return 0;
+}
+#else
+static int map_acpi_tables(struct x86_mapping_info *info, pgd_t *level4p) { return 0; }
+#endif
+
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
@@ -36,6 +86,31 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
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
@@ -159,6 +234,18 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
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
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 08a5f4a131f5..dcbdf54fb5c1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -453,15 +453,24 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 #define CRASH_ALIGN		SZ_16M
 
 /*
- * Keep the crash kernel below this limit.  On 32 bits earlier kernels
- * would limit the kernel to the low 512 MiB due to mapping restrictions.
+ * Keep the crash kernel below this limit.
+ *
+ * On 32 bits earlier kernels would limit the kernel to the low 512 MiB
+ * due to mapping restrictions.
+ *
+ * On 64bit, kdump kernel need be restricted to be under 64TB, which is
+ * the upper limit of system RAM in 4-level paing mode. Since the kdump
+ * jumping could be from 5-level to 4-level, the jumping will fail if
+ * kernel is put above 64TB, and there's no way to detect the paging mode
+ * of the kernel which will be loaded for dumping during the 1st kernel
+ * bootup.
  */
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX	SZ_512M
 # define CRASH_ADDR_HIGH_MAX	SZ_512M
 #else
 # define CRASH_ADDR_LOW_MAX	SZ_4G
-# define CRASH_ADDR_HIGH_MAX	MAXMEM
+# define CRASH_ADDR_HIGH_MAX	SZ_64T
 #endif
 
 static int __init reserve_crashkernel_low(void)
diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index fbde0bc7e882..8651269cb46c 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -47,5 +47,6 @@
 #define SZ_2G				0x80000000
 
 #define SZ_4G				_AC(0x100000000, ULL)
+#define SZ_64T				_AC(0x400000000000, ULL)
 
 #endif /* __LINUX_SIZES_H__ */

