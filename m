Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E872CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFFD21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 14:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbedxVyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406378AbfJWOUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 10:20:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28468 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404578AbfJWOUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571840407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCVKqfwztGTiRyEqLSdR2jFjAP6lAV9l1MzK5eplW+k=;
        b=UbedxVyioE0ITqtm8hFm9tODuT1pELc2EJvZRYA9ewEsh84SXepmfKtj/SNHtwf36lcdAL
        U6I3SFz6LT6i4dRh5yv7ic1aYFRL5Tm+KpdkUNuizFh/ERpmB7hhRx14dXO+hYzinmfMv0
        09sSMCZzpNbw7ig31/zLFg66ADE6KC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-gtzmUWKDPYO0gr0zD-XRHQ-1; Wed, 23 Oct 2019 10:20:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30ECA80183D;
        Wed, 23 Oct 2019 14:20:02 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0D775C1D4;
        Wed, 23 Oct 2019 14:19:48 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, bhe@redhat.com, dyoung@redhat.com, jgross@suse.com,
        dhowells@redhat.com, Thomas.Lendacky@amd.com,
        ebiederm@xmission.com, vgoyal@redhat.com, kexec@lists.infradead.org
Subject: [PATCH 2/2 v5] x86/kdump: clean up all the code related to the backup region
Date:   Wed, 23 Oct 2019 22:19:12 +0800
Message-Id: <20191023141912.29110-3-lijiang@redhat.com>
In-Reply-To: <20191023141912.29110-1-lijiang@redhat.com>
References: <20191023141912.29110-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: gtzmUWKDPYO0gr0zD-XRHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
 arch/x86/kernel/crash.c            | 87 ++++--------------------------
 arch/x86/kernel/machine_kexec_64.c | 47 ----------------
 arch/x86/purgatory/purgatory.c     | 19 -------
 5 files changed, 11 insertions(+), 162 deletions(-)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5e7d6b46de97..6802c59e8252 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -66,10 +66,6 @@ struct kimage;
 # define KEXEC_ARCH KEXEC_ARCH_X86_64
 #endif
=20
-/* Memory to backup during crash kdump */
-#define KEXEC_BACKUP_SRC_START=09(0UL)
-#define KEXEC_BACKUP_SRC_END=09(640 * 1024UL - 1)=09/* 640K */
-
 /*
  * This function is responsible for capturing register states if coming
  * via panic otherwise just fix up the ss and sp if coming via kernel
@@ -154,12 +150,6 @@ struct kimage_arch {
 =09pud_t *pud;
 =09pmd_t *pmd;
 =09pte_t *pte;
-=09/* Details of backup region */
-=09unsigned long backup_src_start;
-=09unsigned long backup_src_sz;
-
-=09/* Physical address of backup segment */
-=09unsigned long backup_load_addr;
=20
 =09/* Core ELF header buffer */
 =09void *elf_headers;
diff --git a/arch/x86/include/asm/purgatory.h b/arch/x86/include/asm/purgat=
ory.h
index 92c34e517da1..5528e9325049 100644
--- a/arch/x86/include/asm/purgatory.h
+++ b/arch/x86/include/asm/purgatory.h
@@ -6,16 +6,6 @@
 #include <linux/purgatory.h>
=20
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
 #endif=09/* __ASSEMBLY__ */
=20
 #endif /* _ASM_PURGATORY_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index eb651fbde92a..ef54b3ffb0f6 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -173,8 +173,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs=
)
=20
 #ifdef CONFIG_KEXEC_FILE
=20
-static unsigned long crash_zero_bytes;
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 =09unsigned int *nr_ranges =3D arg;
@@ -217,6 +215,11 @@ static int elf_header_exclude_ranges(struct crash_mem =
*cmem)
 {
 =09int ret =3D 0;
=20
+=09/* Exclude the low 1MiB because it is always reserved */
+=09ret =3D crash_exclude_mem_range(cmem, 0, 1<<20);
+=09if (ret)
+=09=09return ret;
+
 =09/* Exclude crashkernel region */
 =09ret =3D crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end)=
;
 =09if (ret)
@@ -246,9 +249,7 @@ static int prepare_elf_headers(struct kimage *image, vo=
id **addr,
 =09=09=09=09=09unsigned long *sz)
 {
 =09struct crash_mem *cmem;
-=09Elf64_Ehdr *ehdr;
-=09Elf64_Phdr *phdr;
-=09int ret, i;
+=09int ret;
=20
 =09cmem =3D fill_up_crash_elf_data();
 =09if (!cmem)
@@ -267,22 +268,7 @@ static int prepare_elf_headers(struct kimage *image, v=
oid **addr,
 =09/* By default prepare 64bit headers */
 =09ret =3D  crash_prepare_elf64_headers(cmem,
 =09=09=09=09IS_ENABLED(CONFIG_X86_64), addr, sz);
-=09if (ret)
-=09=09goto out;
=20
-=09/*
-=09 * If a range matches backup region, adjust offset to backup
-=09 * segment.
-=09 */
-=09ehdr =3D (Elf64_Ehdr *)*addr;
-=09phdr =3D (Elf64_Phdr *)(ehdr + 1);
-=09for (i =3D 0; i < ehdr->e_phnum; phdr++, i++)
-=09=09if (phdr->p_type =3D=3D PT_LOAD &&
-=09=09=09=09phdr->p_paddr =3D=3D image->arch.backup_src_start &&
-=09=09=09=09phdr->p_memsz =3D=3D image->arch.backup_src_sz) {
-=09=09=09phdr->p_offset =3D image->arch.backup_load_addr;
-=09=09=09break;
-=09=09}
 out:
 =09vfree(cmem);
 =09return ret;
@@ -321,19 +307,11 @@ static int memmap_exclude_ranges(struct kimage *image=
, struct crash_mem *cmem,
 =09=09=09=09 unsigned long long mend)
 {
 =09unsigned long start, end;
-=09int ret =3D 0;
=20
 =09cmem->ranges[0].start =3D mstart;
 =09cmem->ranges[0].end =3D mend;
 =09cmem->nr_ranges =3D 1;
=20
-=09/* Exclude Backup region */
-=09start =3D image->arch.backup_load_addr;
-=09end =3D start + image->arch.backup_src_sz - 1;
-=09ret =3D crash_exclude_mem_range(cmem, start, end);
-=09if (ret)
-=09=09return ret;
-
 =09/* Exclude elf header region */
 =09start =3D image->arch.elf_load_addr;
 =09end =3D start + image->arch.elf_headers_sz - 1;
@@ -356,11 +334,11 @@ int crash_setup_memmap_entries(struct kimage *image, =
struct boot_params *params)
 =09memset(&cmd, 0, sizeof(struct crash_memmap_data));
 =09cmd.params =3D params;
=20
-=09/* Add first 640K segment */
-=09ei.addr =3D image->arch.backup_src_start;
-=09ei.size =3D image->arch.backup_src_sz;
-=09ei.type =3D E820_TYPE_RAM;
-=09add_e820_entry(params, &ei);
+=09/* Add the low 1MiB */
+=09cmd.type =3D E820_TYPE_RAM;
+=09flags =3D IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+=09walk_iomem_res_desc(IORES_DESC_NONE, flags, 0, (1<<20)-1, &cmd,
+=09=09=09memmap_entry_callback);
=20
 =09/* Add ACPI tables */
 =09cmd.type =3D E820_TYPE_ACPI;
@@ -409,55 +387,12 @@ int crash_setup_memmap_entries(struct kimage *image, =
struct boot_params *params)
 =09return ret;
 }
=20
-static int determine_backup_region(struct resource *res, void *arg)
-{
-=09struct kimage *image =3D arg;
-
-=09image->arch.backup_src_start =3D res->start;
-=09image->arch.backup_src_sz =3D resource_size(res);
-
-=09/* Expecting only one range for backup region */
-=09return 1;
-}
-
 int crash_load_segments(struct kimage *image)
 {
 =09int ret;
 =09struct kexec_buf kbuf =3D { .image =3D image, .buf_min =3D 0,
 =09=09=09=09  .buf_max =3D ULONG_MAX, .top_down =3D false };
=20
-=09/*
-=09 * Determine and load a segment for backup area. First 640K RAM
-=09 * region is backup source
-=09 */
-
-=09ret =3D walk_system_ram_res(KEXEC_BACKUP_SRC_START, KEXEC_BACKUP_SRC_EN=
D,
-=09=09=09=09image, determine_backup_region);
-
-=09/* Zero or postive return values are ok */
-=09if (ret < 0)
-=09=09return ret;
-
-=09/* Add backup segment. */
-=09if (image->arch.backup_src_sz) {
-=09=09kbuf.buffer =3D &crash_zero_bytes;
-=09=09kbuf.bufsz =3D sizeof(crash_zero_bytes);
-=09=09kbuf.memsz =3D image->arch.backup_src_sz;
-=09=09kbuf.buf_align =3D PAGE_SIZE;
-=09=09/*
-=09=09 * Ideally there is no source for backup segment. This is
-=09=09 * copied in purgatory after crash. Just add a zero filled
-=09=09 * segment for now to make sure checksum logic works fine.
-=09=09 */
-=09=09ret =3D kexec_add_buffer(&kbuf);
-=09=09if (ret)
-=09=09=09return ret;
-=09=09image->arch.backup_load_addr =3D kbuf.mem;
-=09=09pr_debug("Loaded backup region at 0x%lx backup_start=3D0x%lx memsz=
=3D0x%lx\n",
-=09=09=09 image->arch.backup_load_addr,
-=09=09=09 image->arch.backup_src_start, kbuf.memsz);
-=09}
-
 =09/* Prepare elf headers and add a segment */
 =09ret =3D prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
 =09if (ret)
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_k=
exec_64.c
index 5dcd438ad8f2..16e125a50b33 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -298,48 +298,6 @@ static void load_segments(void)
 =09=09);
 }
=20
-#ifdef CONFIG_KEXEC_FILE
-/* Update purgatory as needed after various image segments have been prepa=
red */
-static int arch_update_purgatory(struct kimage *image)
-{
-=09int ret =3D 0;
-
-=09if (!image->file_mode)
-=09=09return 0;
-
-=09/* Setup copying of backup region */
-=09if (image->type =3D=3D KEXEC_TYPE_CRASH) {
-=09=09ret =3D kexec_purgatory_get_set_symbol(image,
-=09=09=09=09"purgatory_backup_dest",
-=09=09=09=09&image->arch.backup_load_addr,
-=09=09=09=09sizeof(image->arch.backup_load_addr), 0);
-=09=09if (ret)
-=09=09=09return ret;
-
-=09=09ret =3D kexec_purgatory_get_set_symbol(image,
-=09=09=09=09"purgatory_backup_src",
-=09=09=09=09&image->arch.backup_src_start,
-=09=09=09=09sizeof(image->arch.backup_src_start), 0);
-=09=09if (ret)
-=09=09=09return ret;
-
-=09=09ret =3D kexec_purgatory_get_set_symbol(image,
-=09=09=09=09"purgatory_backup_sz",
-=09=09=09=09&image->arch.backup_src_sz,
-=09=09=09=09sizeof(image->arch.backup_src_sz), 0);
-=09=09if (ret)
-=09=09=09return ret;
-=09}
-
-=09return ret;
-}
-#else /* !CONFIG_KEXEC_FILE */
-static inline int arch_update_purgatory(struct kimage *image)
-{
-=09return 0;
-}
-#endif /* CONFIG_KEXEC_FILE */
-
 int machine_kexec_prepare(struct kimage *image)
 {
 =09unsigned long start_pgtable;
@@ -353,11 +311,6 @@ int machine_kexec_prepare(struct kimage *image)
 =09if (result)
 =09=09return result;
=20
-=09/* update purgatory as needed */
-=09result =3D arch_update_purgatory(image);
-=09if (result)
-=09=09return result;
-
 =09return 0;
 }
=20
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.=
c
index 3b95410ff0f8..2961234d0795 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -14,28 +14,10 @@
=20
 #include "../boot/string.h"
=20
-unsigned long purgatory_backup_dest __section(.kexec-purgatory);
-unsigned long purgatory_backup_src __section(.kexec-purgatory);
-unsigned long purgatory_backup_sz __section(.kexec-purgatory);
-
 u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE] __section(.kexec-purgatory)=
;
=20
 struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX] __section=
(.kexec-purgatory);
=20
-/*
- * On x86, second kernel requries first 640K of memory to boot. Copy
- * first 640K to a backup region in reserved memory range so that second
- * kernel can use first 640K.
- */
-static int copy_backup_region(void)
-{
-=09if (purgatory_backup_dest) {
-=09=09memcpy((void *)purgatory_backup_dest,
-=09=09       (void *)purgatory_backup_src, purgatory_backup_sz);
-=09}
-=09return 0;
-}
-
 static int verify_sha256_digest(void)
 {
 =09struct kexec_sha_region *ptr, *end;
@@ -66,7 +48,6 @@ void purgatory(void)
 =09=09for (;;)
 =09=09=09;
 =09}
-=09copy_backup_region();
 }
=20
 /*
--=20
2.17.1

