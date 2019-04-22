Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05C6C282E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F25D213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 09:29:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfDVJ3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:29:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfDVJ3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 05:29:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 436BE99DDC;
        Mon, 22 Apr 2019 09:29:12 +0000 (UTC)
Received: from kasong-rh-laptop.nay.redhat.com (unknown [10.66.128.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A87FA26FC3;
        Mon, 22 Apr 2019 09:29:06 +0000 (UTC)
From:   Kairui Song <kasong@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        Kairui Song <kasong@redhat.com>
Subject: [PATCH] x86/kexec: always ensure EFI systab region is mapped
Date:   Mon, 22 Apr 2019 17:28:04 +0800
Message-Id: <20190422092804.15534-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 22 Apr 2019 09:29:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a fix needed for: "x86/boot: Use efi_setup_data for searching
RSDP on kexec-ed kernels", that patch cause kexec to reset the system
on some machines.

The reason is the systab region is not mapped by the identity mapping
provided by kexec. Currently kexec only create identity mapping for
mem regions, wihch won't cover the systab. So second kernel will be
accessing a not mapped memory region and cause fault.
But as kexec tend to pad the map region up to PUD size, the
systab could be included in the map by accident, so it worked on
some machines, but that will be broken easily and unstable.

To fix it just treat systab specially, always map the systab region
unconditionally on EFI systems as long as there is a valid systab
address.

Signed-off-by: Kairui Song <kasong@redhat.com>
---
 arch/x86/kernel/machine_kexec_64.c | 40 ++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index ceba408ea982..d5da54893f97 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -18,6 +18,7 @@
 #include <linux/io.h>
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
+#include <linux/efi.h>
 
 #include <asm/init.h>
 #include <asm/pgtable.h>
@@ -113,6 +114,37 @@ static void *alloc_pgt_page(void *data)
 	return p;
 }
 
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
 static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 {
 	struct x86_mapping_info info = {
@@ -159,6 +191,14 @@ static int init_pgtable(struct kimage *image, unsigned long start_pgtable)
 			return result;
 	}
 
+	/*
+	 * Prepare EFI systab mapping for kexec kernel, systab is not
+	 * covered by pfn_mapped.
+	 */
+	result = init_efi_systab_pgtable(&info, level4p);
+	if (result)
+		return result;
+
 	return init_transition_pgtable(image, level4p);
 }
 
-- 
2.20.1

