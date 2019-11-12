Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF2FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA4B2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 01:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ind+u79V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfKLB3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 20:29:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37663 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfKLB2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 20:28:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so1213231wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 17:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KqvDwSwqa8op8oW/KhqwGjK7tqYDHVQ1mbSvLW1zwYM=;
        b=Ind+u79VvY22lBb3OGJbj4e497ctK8AuMYjmI2P4Tn7mBjmoi9p6xcxasS6miOlkM2
         wS+U+zPxXCE0wFP2XQjSESxJHW3UrgyYBzRo7X5GRMxRsyCTiAtkjvLNmyTPTjzEmlUR
         lRC+EPgwKmBq3fBqrDDZRgzUOnadQP0+ZW8dQzOKL7jhQtJqnyZvN8fs8HfxWLDGfRPS
         9I90/IpFBOLVCJLtC457JjuXfLxJFAYjecr4NG3klwPz0H+HEIAFb3jwdlmXmh/ELnv/
         YJ9S92RpyanBxKlkncpL8P7zss6ABftNfU4GhP1XYdBEhJhSQocVVBnucS2qAJt2lQrI
         BDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KqvDwSwqa8op8oW/KhqwGjK7tqYDHVQ1mbSvLW1zwYM=;
        b=SYU5/uVLzaL6yZR15ndvpJbzK1tyDnETxWDyf3u64XrnpA8RiOTKk095oJ+n9Z8iQT
         FXCTHimpUZXXhUOdf7njQNauBkcMZODBYGoOySo+e6gTUek20cr53W1khhQY+R6M1/FW
         RTymEwsq/AjNnpuBe6QuZ3NQBveU+4/3BrOeCFSqAtmVnHztPc52yN1rilhRgiUcIsMZ
         08bcpLra8w20x12H2lPt847sjDL3z9W+bUYlh7SA/5v44CEvHizZ9RFRmSSYAPx2m59V
         c0MqusM+15TwcYZkn44424diRfKM2h1IraMvTsn2fLSwtQ8jVbN38EMVwq/oE2mOZy0i
         y4gw==
X-Gm-Message-State: APjAAAWEjUT8qqmF1Jw3mTpyyLVSZqfxrWiUJv7RShvKh6DdQYZ4/lyL
        QC+uYD/1+UKZgPUYMmQTXQ0RHiKgv0U=
X-Google-Smtp-Source: APXvYqxCmFOAeErn5ty/29sSVgXVliTd15jkWKzvhVYImZaMih/kH/3D73MiE4Pp+jIMzah63kAR3g==
X-Received: by 2002:a1c:610b:: with SMTP id v11mr1497318wmb.156.1573522083981;
        Mon, 11 Nov 2019 17:28:03 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id u187sm1508096wme.15.2019.11.11.17.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 17:28:03 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv8 24/34] x86/vdso: Handle faults on timens page
Date:   Tue, 12 Nov 2019 01:27:13 +0000
Message-Id: <20191112012724.250792-25-dima@arista.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112012724.250792-1-dima@arista.com>
References: <20191112012724.250792-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a task belongs to a time namespace then the VVAR page which contains
the system wide VDSO data is replaced with a namespace specific page
which has the same layout as the VVAR page.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 53 +++++++++++++++++++++++++++++++++++++--
 mm/mmap.c                 |  2 ++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5dab706aca2e..f6e13ab29d94 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -14,11 +14,13 @@
 #include <linux/elf.h>
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
+#include <linux/time_namespace.h>
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 #include <asm/proto.h>
 #include <asm/vdso.h>
 #include <asm/vvar.h>
+#include <asm/tlb.h>
 #include <asm/page.h>
 #include <asm/desc.h>
 #include <asm/cpufeature.h>
@@ -107,10 +109,36 @@ static int vvar_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+#ifdef CONFIG_TIME_NS
+static struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	if (likely(vma->vm_mm == current->mm))
+		return current->nsproxy->time_ns->vvar_page;
+
+	/*
+	 * VM_PFNMAP | VM_IO protect .fault() handler from being called
+	 * through interfaces like /proc/$pid/mem or
+	 * process_vm_{readv,writev}() as long as there's no .access()
+	 * in special_mapping_vmops().
+	 * For more details check_vma_flags() and __access_remote_vm()
+	 */
+
+	WARN(1, "vvar_page accessed remotely");
+
+	return NULL;
+}
+#else
+static inline struct page *find_timens_vvar_page(struct vm_area_struct *vma)
+{
+	return NULL;
+}
+#endif
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	const struct vdso_image *image = vma->vm_mm->context.vdso_image;
+	unsigned long pfn;
 	long sym_offset;
 
 	if (!image)
@@ -130,8 +158,21 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		return VM_FAULT_SIGBUS;
 
 	if (sym_offset == image->sym_vvar_page) {
-		return vmf_insert_pfn(vma, vmf->address,
-				__pa_symbol(&__vvar_page) >> PAGE_SHIFT);
+		struct page *timens_page = find_timens_vvar_page(vma);
+
+		pfn = __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
+
+		/*
+		 * If a task belongs to a time namespace then a namespace
+		 * specific VVAR is mapped with the sym_vvar_page offset and
+		 * the real VVAR page is mapped with the sym_timens_page
+		 * offset.
+		 * See also the comment near timens_setup_vdso_data().
+		 */
+		if (timens_page)
+			pfn = page_to_pfn(timens_page);
+
+		return vmf_insert_pfn(vma, vmf->address, pfn);
 	} else if (sym_offset == image->sym_pvclock_page) {
 		struct pvclock_vsyscall_time_info *pvti =
 			pvclock_get_pvti_cpu0_va();
@@ -146,6 +187,14 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		if (tsc_pg && vclock_was_used(VCLOCK_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address,
 					virt_to_phys(tsc_pg) >> PAGE_SHIFT);
+	} else if (sym_offset == image->sym_timens_page) {
+		struct page *timens_page = find_timens_vvar_page(vma);
+
+		if (!timens_page)
+			return VM_FAULT_SIGBUS;
+
+		pfn = __pa_symbol(&__vvar_page) >> PAGE_SHIFT;
+		return vmf_insert_pfn(vma, vmf->address, pfn);
 	}
 
 	return VM_FAULT_SIGBUS;
diff --git a/mm/mmap.c b/mm/mmap.c
index 4d4db76a07da..73ec982f8b82 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3357,6 +3357,8 @@ static const struct vm_operations_struct special_mapping_vmops = {
 	.fault = special_mapping_fault,
 	.mremap = special_mapping_mremap,
 	.name = special_mapping_name,
+	/* vDSO code relies that VVAR can't be accessed remotely */
+	.access = NULL,
 };
 
 static const struct vm_operations_struct legacy_special_mapping_vmops = {
-- 
2.24.0

