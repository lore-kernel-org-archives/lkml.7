Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF08C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE46205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:56:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VxsqpYci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388225AbfGPQ4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:56:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34755 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388157AbfGPQ4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:56:48 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so15163871qkt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5D8mlvVawCjEgddelLAduhKCIQh0CPiyGgQp446bGsE=;
        b=VxsqpYcitDOLAtpg1Jls5stspr2tgCl0PGz2J1Z817sVMFGcuo/roOKCaavlnYeATr
         jU6YTyCAGZdlqYJ/jAs5NtTWvKRhJMmjirZcQE+Iucd/gw8X+OddfHUsoLTZ8sMYS/3c
         ve/dJt/iFA5AYuQOfT8c21qt+EjJ268NVoprOSpHjzlTm8z+pnUOXbMTcz0Wg8M1xsbA
         VBgDOJX8ALLB3Bwq5D6MxZszG6wXjnwReOXDz93IVfYtFF6y2ddjcZH7FZb1wO7Km03h
         cbJW0XLKEZ9fLZEWNShJLv0RqMAIYlex+//VRDwPg40RaMG+UAF8sT158AGKpfuS8DXz
         p6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5D8mlvVawCjEgddelLAduhKCIQh0CPiyGgQp446bGsE=;
        b=V+5CkRylb+e9T0Wm1479YCB/W8JPTI/LvRWr9L0Qj53ANEhmKMqaQ1SeaPJpvxe6BE
         boOQYno21aCBL+o2jDKmBLOSqeiGkhJcccMaZLdm09nKKPPBGple517tuQKE5on8QuxI
         ozAPbAPpAxahSgEO+u7BE2XegroE8/Gc3zqaofEWHhn3GHXqL1O+XNfG7/ur5zM/dCSw
         sevg/Xq5nWwz8L82vuXvTYf/SnHUvzMMelF30825L0fG0yIUstQrekIgteFb5w5bVnV0
         21cy8xb/aRlTM5u4EQLteykt6A9RGdoyG66v91zAvXQePTGcf6SHUW9uwN7aE0Y1wkyd
         s2tA==
X-Gm-Message-State: APjAAAV4UDGmmEQZ/+6F6/3qpq4I/jzxV2KX/gyNVr4LDIdw0bmbTjEl
        WMUAE/5YNPCF57DuWyydMg2xznq4
X-Google-Smtp-Source: APXvYqzvQ0JQLAGkRNhRdaqxRVuO7Hvjn0EZosyRHwPjvqeoogbj3QaW6JZ3XDhFK6dpEIze4WbX/w==
X-Received: by 2002:a05:620a:69c:: with SMTP id f28mr22093343qkh.274.1563296206729;
        Tue, 16 Jul 2019 09:56:46 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f20sm8519538qkh.15.2019.07.16.09.56.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 09:56:46 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC v1 3/4] arm64, kexec: add kexec's own identity page table
Date:   Tue, 16 Jul 2019 12:56:40 -0400
Message-Id: <20190716165641.6990-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716165641.6990-1-pasha.tatashin@soleen.com>
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate and configure identity page table to be used for kexec reboot.
Note, for now we still have MMU disabled during kernel relocation phase,
so this table is still used the same as idmap_pg_dir was used.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/machine_kexec.c | 78 ++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f4565eb01d09..60433c264178 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -12,6 +12,7 @@
 #include <linux/kexec.h>
 #include <linux/page-flags.h>
 #include <linux/smp.h>
+#include <linux/memblock.h>
 
 #include <asm/cacheflush.h>
 #include <asm/cpu_ops.h>
@@ -20,6 +21,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/ident_map.h>
 
 #include "cpu-reset.h"
 
@@ -55,6 +57,77 @@ static void _kexec_image_info(const char *func, int line,
 	}
 }
 
+/* Allocates pages for kexec page table */
+static void *kexec_pgtable_alloc(void *arg)
+{
+	struct kimage *kimage = (struct kimage *)arg;
+	struct page *page = kimage_alloc_control_pages(kimage, 0);
+
+	if (!page)
+		return NULL;
+
+	return page_address(page);
+}
+
+/*
+ * Create identity mapped page table for kexec purposes. The flags that are used
+ * in this page table are the same as what is set in __create_page_tables. The
+ * page table is needed for performance reasons. Without it, kernel relocation
+ * is rather slow, because when MMU is off, d-caching is disabled as well.
+ */
+static int
+kexec_create_pgtable(struct kimage *kimage)
+{
+	void *pgd_page = kexec_pgtable_alloc(kimage);
+	phys_addr_t kexec_pgtable;
+	int rv, i;
+	struct memblock_region *reg;
+	struct ident_map_info info = {
+		.alloc_pgt_page	= kexec_pgtable_alloc,
+		.alloc_arg	= kimage,
+		.page_flags	= PMD_SECT_VALID | PMD_SECT_AF | PMD_SECT_S |
+				  PMD_ATTRINDX(MT_NORMAL),
+		.offset		= 0,
+		.pud_pages	= false,
+	};
+
+	if (!pgd_page)
+		return -ENOMEM;
+
+	clear_page(pgd_page);
+	kexec_pgtable = __pa(pgd_page);
+
+	for_each_memblock(memory, reg) {
+		phys_addr_t mstart = reg->base;
+		phys_addr_t mend   = reg->base + reg->size;
+
+		rv = ident_map_pgd_populate(&info, kexec_pgtable, mstart, mend);
+		if (rv)
+			return rv;
+	}
+
+	/*
+	 * It is possible new kernel knows of some physical addresses that this
+	 * kernel does not know: for example a different device tree might
+	 * provide information of a memory region, or memory could have been
+	 * reduced via mem= kernel parameter.
+	 * This is why also unconditionally map new kernel segments, even though
+	 * most likely this is redundant.
+	 */
+	for (i = 0; i < kimage->nr_segments; i++) {
+		phys_addr_t mstart = kimage->segment[i].mem;
+		phys_addr_t mend   = mstart + kimage->segment[i].memsz;
+
+		rv = ident_map_pgd_populate(&info, kexec_pgtable, mstart, mend);
+		if (rv)
+			return rv;
+	}
+
+	kimage->arch.kexec_pgtable = pgd_page;
+
+	return 0;
+}
+
 void machine_kexec_cleanup(struct kimage *kimage)
 {
 	/* Empty routine needed to avoid build errors. */
@@ -70,6 +143,7 @@ void machine_kexec_cleanup(struct kimage *kimage)
 int machine_kexec_prepare(struct kimage *kimage)
 {
 	void *reloc_buf = page_address(kimage->control_code_page);
+	int rv;
 
 	if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
 		pr_err("Can't kexec: CPUs are stuck in the kernel.\n");
@@ -84,10 +158,10 @@ int machine_kexec_prepare(struct kimage *kimage)
 	       arm64_relocate_new_kernel_size);
 
 	kimage->arch.relocate_kern = reloc_buf;
-	kimage->arch.kexec_pgtable = lm_alias(idmap_pg_dir);
+	rv = kexec_create_pgtable(kimage);
 	kexec_image_info(kimage);
 
-	return 0;
+	return rv;
 }
 
 /**
-- 
2.22.0

