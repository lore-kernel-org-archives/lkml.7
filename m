Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF9AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6427820878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbfDXJaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:30:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfDXJaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:30:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2426031688E3;
        Wed, 24 Apr 2019 09:30:02 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-131.pek2.redhat.com [10.72.12.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC22E60C78;
        Wed, 24 Apr 2019 09:29:58 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     bp@alien8.de, j-nomura@ce.jp.nec.com, kasong@redhat.com,
        dyoung@redhat.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        fanc.fnst@cn.fujitsu.com, x86@kernel.org,
        kexec@lists.infradead.org, hpa@zytor.com
Subject: [PATCH v5 1/2] x86/kexec: Build identity mapping for EFI systab and ACPI tables
Date:   Wed, 24 Apr 2019 17:29:43 +0800
Message-Id: <20190424092944.30481-2-bhe@redhat.com>
In-Reply-To: <20190424092944.30481-1-bhe@redhat.com>
References: <20190424092944.30481-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 24 Apr 2019 09:30:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kairui Song <kasong@redhat.com>

The current code only builds identity mapping for physical memory during
kexec-type loading. The regions reserved by firmware are not covered.
In the next patch, the boot decompressing code of kexec-ed kernel tries
to access EFI systab and ACPI tables, lacking identity mapping for them
will cause error and reset system to firmware.

This error doesn't happen on all systems. Because kexec enables gbpages
to build identity mapping, the EFI systab and ACPI tables could have been
covered if they share the same 1 GB area with physical memory. To make
sure, we should map them always.

So here add mapping for them.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 86 ++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..77b40c3e28d7 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
+#include <linux/efi.h>
 
 #include <asm/init.h>
 #include <asm/pgtable.h>
@@ -29,6 +30,48 @@
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 
+#ifdef CONFIG_ACPI
+/**
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
+	return kernel_ident_mapping_init(data->info,
+			data->level4p, mstart, mend);
+}
+
+static int init_acpi_pgtable(struct x86_mapping_info *info,
+				   pgd_t *level4p)
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
+static int init_acpi_pgtable(struct x86_mapping_info *info,
+				   pgd_t *level4p)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_KEXEC_FILE
 const struct kexec_file_ops * const kexec_file_loaders[] = {
 		&kexec_bzImage64_ops,
@@ -36,6 +79,37 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 };
 #endif
 
+#ifdef CONFIG_EFI
+static int init_efi_systab_pgtable(struct x86_mapping_info *info,
+				   pgd_t *level4p)
+{
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
+	if (mstart)
+		return kernel_ident_mapping_init(info,
+				level4p, mstart, mend);
+
+	return 0;
+}
+#else
+static inline int init_efi_systab_pgtable(struct x86_mapping_info *info,
+					  pgd_t *level4p)
+{
+	return 0;
+}
+#endif
+
 static void free_transition_pgtable(struct kimage *image)
 {
 	free_page((unsigned long)image->arch.p4d);
@@ -159,6 +233,18 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 			return result;
 	}
 
+	/**
+	 * Prepare EFI systab and ACPI table mapping for kexec kernel,
+	 * since they are not covered by pfn_mapped.
+	 */
+	result = init_efi_systab_pgtable(&info, level4p);
+	if (result)
+		return result;
+
+	result = init_acpi_pgtable(&info, level4p);
+	if (result)
+		return result;
+
 	return init_transition_pgtable(image, level4p);
 }
 
-- 
2.17.2

