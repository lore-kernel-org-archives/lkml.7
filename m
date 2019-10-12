Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A31EC47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 02:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6653D214E0
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 02:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfJLCWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 22:22:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40432 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfJLCWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 22:22:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E3DD53086228;
        Sat, 12 Oct 2019 02:22:43 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A79F61001956;
        Sat, 12 Oct 2019 02:22:30 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, kexec@lists.infradead.org
Subject: [PATCH 3/3 v3] x86/kdump: clean up all the code related to the backup region
Date:   Sat, 12 Oct 2019 10:21:40 +0800
Message-Id: <20191012022140.19003-4-lijiang@redhat.com>
In-Reply-To: <20191012022140.19003-1-lijiang@redhat.com>
References: <20191012022140.19003-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 12 Oct 2019 02:22:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the crashkernel kernel command line option is specified, the
low 1MiB memory will always be reserved, which makes that the memory
allocated later won't fall into the low 1MiB area, thereby, it's not
necessary to create a backup region and also no need to copy the first
640k content to a backup region.

Currently, the code related to the backup region can be safely removed,
so lets clean up.

Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
---
 arch/x86/include/asm/kexec.h       | 10 ----
 arch/x86/include/asm/purgatory.h   | 10 ----
 arch/x86/kernel/crash.c            | 91 ++++++------------------------
 arch/x86/kernel/machine_kexec_64.c | 47 ---------------
 arch/x86/purgatory/purgatory.c     | 19 -------
 5 files changed, 16 insertions(+), 161 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5e7d6b46de97..6802c59e8252 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -66,10 +66,6 @@ struct kimage;
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
 #endif
 
-/* Memory to backup during crash kdump */
-#define KEXEC_BACKUP_SRC_START	(0UL)
-#define KEXEC_BACKUP_SRC_END	(640 * 1024UL - 1)	/* 640K */
-
 /*
  * This function is responsible for capturing register states if coming
  * via panic otherwise just fix up the ss and sp if coming via kernel
@@ -154,12 +150,6 @@ struct kimage_arch {
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	/* Details of backup region */
-	unsigned long backup_src_start;
-	unsigned long backup_src_sz;
-
-	/* Physical address of backup segment */
-	unsigned long backup_load_addr;
 
 	/* Core ELF header buffer */
 	void *elf_headers;
diff --git a/arch/x86/include/asm/purgatory.h b/arch/x86/include/asm/purgatory.h
index 92c34e517da1..5528e9325049 100644
--- a/arch/x86/include/asm/purgatory.h
+++ b/arch/x86/include/asm/purgatory.h
@@ -6,16 +6,6 @@
 #include <linux/purgatory.h>
 
 extern void purgatory(void);
-/*
- * These forward declarations serve two purposes:
- *
- * 1) Make sparse happy when checking arch/purgatory
- * 2) Document that these are required to be global so the symbol
- *    lookup in kexec works
- */
-extern unsigned long purgatory_backup_dest;
-extern unsigned long purgatory_backup_src;
-extern unsigned long purgatory_backup_sz;
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_PURGATORY_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index eb651fbde92a..cc5774fc84c0 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 
 #ifdef CONFIG_KEXEC_FILE
 
-static unsigned long crash_zero_bytes;
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -234,9 +232,15 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 {
 	struct crash_mem *cmem = arg;
 
-	cmem->ranges[cmem->nr_ranges].start = res->start;
-	cmem->ranges[cmem->nr_ranges].end = res->end;
-	cmem->nr_ranges++;
+	if (res->start >= SZ_1M) {
+		cmem->ranges[cmem->nr_ranges].start = res->start;
+		cmem->ranges[cmem->nr_ranges].end = res->end;
+		cmem->nr_ranges++;
+	} else if (res->end > SZ_1M) {
+		cmem->ranges[cmem->nr_ranges].start = SZ_1M;
+		cmem->ranges[cmem->nr_ranges].end = res->end;
+		cmem->nr_ranges++;
+	}
 
 	return 0;
 }
@@ -246,9 +250,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 					unsigned long *sz)
 {
 	struct crash_mem *cmem;
-	Elf64_Ehdr *ehdr;
-	Elf64_Phdr *phdr;
-	int ret, i;
+	int ret;
 
 	cmem = fill_up_crash_elf_data();
 	if (!cmem)
@@ -270,19 +272,6 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
-	/*
-	 * If a range matches backup region, adjust offset to backup
-	 * segment.
-	 */
-	ehdr = (Elf64_Ehdr *)*addr;
-	phdr = (Elf64_Phdr *)(ehdr + 1);
-	for (i = 0; i < ehdr->e_phnum; phdr++, i++)
-		if (phdr->p_type == PT_LOAD &&
-				phdr->p_paddr == image->arch.backup_src_start &&
-				phdr->p_memsz == image->arch.backup_src_sz) {
-			phdr->p_offset = image->arch.backup_load_addr;
-			break;
-		}
 out:
 	vfree(cmem);
 	return ret;
@@ -321,19 +310,11 @@ static int memmap_exclude_ranges(struct kimage *image, struct crash_mem *cmem,
 				 unsigned long long mend)
 {
 	unsigned long start, end;
-	int ret = 0;
 
 	cmem->ranges[0].start = mstart;
 	cmem->ranges[0].end = mend;
 	cmem->nr_ranges = 1;
 
-	/* Exclude Backup region */
-	start = image->arch.backup_load_addr;
-	end = start + image->arch.backup_src_sz - 1;
-	ret = crash_exclude_mem_range(cmem, start, end);
-	if (ret)
-		return ret;
-
 	/* Exclude elf header region */
 	start = image->arch.elf_load_addr;
 	end = start + image->arch.elf_headers_sz - 1;
@@ -356,9 +337,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	memset(&cmd, 0, sizeof(struct crash_memmap_data));
 	cmd.params = params;
 
-	/* Add first 640K segment */
-	ei.addr = image->arch.backup_src_start;
-	ei.size = image->arch.backup_src_sz;
+	/*
+	 * Add the low memory range[0x1000, SZ_1M], skip
+	 * the first zero page.
+	 */
+	ei.addr = PAGE_SIZE;
+	ei.size = SZ_1M - PAGE_SIZE;
 	ei.type = E820_TYPE_RAM;
 	add_e820_entry(params, &ei);
 
@@ -409,55 +393,12 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 	return ret;
 }
 
-static int determine_backup_region(struct resource *res, void *arg)
-{
-	struct kimage *image = arg;
-
-	image->arch.backup_src_start = res->start;
-	image->arch.backup_src_sz = resource_size(res);
-
-	/* Expecting only one range for backup region */
-	return 1;
-}
-
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
-	/*
-	 * Determine and load a segment for backup area. First 640K RAM
-	 * region is backup source
-	 */
-
-	ret = walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_END,
-				image, determine_backup_region);
-
-	/* Zero or postive return values are ok */
-	if (ret < 0)
-		return ret;
-
-	/* Add backup segment. */
-	if (image->arch.backup_src_sz) {
-		kbuf.buffer = &crash_zero_bytes;
-		kbuf.bufsz = sizeof(crash_zero_bytes);
-		kbuf.memsz = image->arch.backup_src_sz;
-		kbuf.buf_align = PAGE_SIZE;
-		/*
-		 * Ideally there is no source for backup segment. This is
-		 * copied in purgatory after crash. Just add a zero filled
-		 * segment for now to make sure checksum logic works fine.
-		 */
-		ret = kexec_add_buffer(&kbuf);
-		if (ret)
-			return ret;
-		image->arch.backup_load_addr = kbuf.mem;
-		pr_debug("Loaded backup region at 0x%lx backup_start=0x%lx memsz=0x%lx\n",
-			 image->arch.backup_load_addr,
-			 image->arch.backup_src_start, kbuf.memsz);
-	}
-
 	/* Prepare elf headers and add a segment */
 	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
 	if (ret)
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 5dcd438ad8f2..16e125a50b33 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -298,48 +298,6 @@ static void load_segments(void)
 		);
 }
 
-#ifdef CONFIG_KEXEC_FILE
-/* Update purgatory as needed after various image segments have been prepared */
-static int arch_update_purgatory(struct kimage *image)
-{
-	int ret = 0;
-
-	if (!image->file_mode)
-		return 0;
-
-	/* Setup copying of backup region */
-	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = kexec_purgatory_get_set_symbol(image,
-				"purgatory_backup_dest",
-				&image->arch.backup_load_addr,
-				sizeof(image->arch.backup_load_addr), 0);
-		if (ret)
-			return ret;
-
-		ret = kexec_purgatory_get_set_symbol(image,
-				"purgatory_backup_src",
-				&image->arch.backup_src_start,
-				sizeof(image->arch.backup_src_start), 0);
-		if (ret)
-			return ret;
-
-		ret = kexec_purgatory_get_set_symbol(image,
-				"purgatory_backup_sz",
-				&image->arch.backup_src_sz,
-				sizeof(image->arch.backup_src_sz), 0);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
-}
-#else /* !CONFIG_KEXEC_FILE */
-static inline int arch_update_purgatory(struct kimage *image)
-{
-	return 0;
-}
-#endif /* CONFIG_KEXEC_FILE */
-
 int machine_kexec_prepare(struct kimage *image)
 {
 	unsigned long start_pgtable;
@@ -353,11 +311,6 @@ int machine_kexec_prepare(struct kimage *image)
 	if (result)
 		return result;
 
-	/* update purgatory as needed */
-	result = arch_update_purgatory(image);
-	if (result)
-		return result;
-
 	return 0;
 }
 
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.c
index 3b95410ff0f8..2961234d0795 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -14,28 +14,10 @@
 
 #include "../boot/string.h"
 
-unsigned long purgatory_backup_dest __section(.kexec-purgatory);
-unsigned long purgatory_backup_src __section(.kexec-purgatory);
-unsigned long purgatory_backup_sz __section(.kexec-purgatory);
-
 u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(.kexec-purgatory);
 
 struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX] __section(.kexec-purgatory);
 
-/*
- * On x86, second kernel requries first 640K of memory to boot. Copy
- * first 640K to a backup region in reserved memory range so that second
- * kernel can use first 640K.
- */
-static int copy_backup_region(void)
-{
-	if (purgatory_backup_dest) {
-		memcpy((void *)purgatory_backup_dest,
-		       (void *)purgatory_backup_src, purgatory_backup_sz);
-	}
-	return 0;
-}
-
 static int verify_sha256_digest(void)
 {
 	struct kexec_sha_region *ptr, *end;
@@ -66,7 +48,6 @@ void purgatory(void)
 		for (;;)
 			;
 	}
-	copy_backup_region();
 }
 
 /*
-- 
2.17.1

