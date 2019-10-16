Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176B5FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9BA21928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="cKz6BVqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfJPUBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:01:17 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37948 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436943AbfJPUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:01:10 -0400
Received: by mail-qk1-f193.google.com with SMTP id p4so3437904qkf.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EVnuRjBEMB2GYFnhnHmSU9YWi4CNDpDCmu5znzEhaTM=;
        b=cKz6BVqtVqyLsLqiVZ+IRAIay0Zsj5QRRmZNI3uNFH8oSpAIs9miw0sXT97/PAFzi3
         WcoUjj4Iwcdzet/A+dDbm67InY4mLmRstcgmzojy9vr67DLNsQcWkblnmBNjLhq+tQKs
         xsaCcR2rVmUqnPTdyADl5FsxQEdIhmWzQ236Q4182IFX1OCwa/OAvcZAae1NmZ2CDi4R
         ISq1I9+8+EF/235eUsFXB28hx3pG2JxKYGEZSYMInZi0zqmy9kLj2Tm+id+sPz1tn1bC
         CaE2M3vN4oM7Kwu4sT94OENYr6LHcPP6r6dxUgVSLJvsxXWQOOK90FgthXtWs+fzkXtG
         nlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EVnuRjBEMB2GYFnhnHmSU9YWi4CNDpDCmu5znzEhaTM=;
        b=sfd0QW8uPj+YWEz/JiMuAKsVv1/vg24oTmxpiPnFWTwr4h41/TrjpCX5TfGyUDM/SS
         LFPmVLL2bm6mRCTm6W969/e9I1u6Ue+a9Z/+SDf2OBJOPW4ZY4RvFKg5BjSFnHHlBkoK
         guwIWRhh8l0+UvQWk7osQFcyu/kXW7VsyLCdRoCaVkdJfDkKxGtAiFUNOHGHzlJQycU6
         rUU7d0KW5Ry5rjioeQOhtjTwL7/prAXn9q8P3xU129MNZJbxjUWNa6q56cb6p0YEYiYr
         dhvYYPl/rW0Hm0aA6QNMEl0quWpY7nxVBzThHTnAU9uwn0ddR0F6ymGvUB5f9/CDpJWi
         +urg==
X-Gm-Message-State: APjAAAU5A7U0dpnctxLLl1rkgOlYHduFxLGGZJqQCJh6it9lkuit1nbv
        p01pSgDMObQG/DqoIldEk0kphA==
X-Google-Smtp-Source: APXvYqwOux5Fm7pjZNAnI8wxY5A6gLVM3NnJ+bL1kMGiMIrYEW+5lVGxSLWw8BTGkKSpUSOd2OnyGg==
X-Received: by 2002:a37:648e:: with SMTP id y136mr43570610qkb.355.1571256068835;
        Wed, 16 Oct 2019 13:01:08 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:01:08 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v7 20/25] arm64: kexec: add expandable argument to relocation function
Date:   Wed, 16 Oct 2019 16:00:29 -0400
Message-Id: <20191016200034.1342308-21-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kexec relocation function (arm64_relocate_new_kernel) accepts
the following arguments:

head:		start of array that contains relocation information.
entry:		entry point for new kernel or purgatory.
dtb_mem:	first and only argument to entry.

The number of arguments cannot be easily expended, because this
function is also called from HVC_SOFT_RESTART, which preserves only
three arguments. And, also arm64_relocate_new_kernel is written in
assembly but called without stack, thus no place to move extra
arguments to free registers.

Soon, we will need to pass more arguments: once we enable MMU we
will need to pass information about page tables.

Another benefit of allowing this function to accept more arguments, is that
kernel can actually accept up to 4 arguments (x0-x3), however currently
only one is used, but if in the future we will need for more (for example,
pass information about when previous kernel exited to have a precise
measurement in time spent in purgatory), we won't be easilty do that
if arm64_relocate_new_kernel can't accept more arguments.

So, add a new struct: kern_reloc_arg, and place it in kexec safe page (i.e
memory that is not overwritten during relocation).
Thus, make arm64_relocate_new_kernel to only take one argument, that
contains all the needed information.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h      | 18 ++++++++++++++++++
 arch/arm64/kernel/asm-offsets.c     |  9 +++++++++
 arch/arm64/kernel/cpu-reset.S       |  8 ++------
 arch/arm64/kernel/cpu-reset.h       |  8 +++-----
 arch/arm64/kernel/machine_kexec.c   | 26 ++++++++++++++++++++++++--
 arch/arm64/kernel/relocate_kernel.S | 19 ++++++++-----------
 6 files changed, 64 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 00dbcc71aeb2..189dce24f4cb 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,12 +90,30 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
+/*
+ * kern_reloc_arg is passed to kernel relocation function as an argument.
+ * head		kimage->head, allows to traverse through relocation segments.
+ * entry_addr	kimage->start, where to jump from relocation function (new
+ *		kernel, or purgatory entry address).
+ * kern_arg0	first argument to kernel is its dtb address. The other
+ *		arguments are currently unused, and must be set to 0
+ */
+struct kern_reloc_arg {
+	phys_addr_t head;
+	phys_addr_t entry_addr;
+	phys_addr_t kern_arg0;
+	phys_addr_t kern_arg1;
+	phys_addr_t kern_arg2;
+	phys_addr_t kern_arg3;
+};
+
 #define ARCH_HAS_KIMAGE_ARCH
 
 struct kimage_arch {
 	void *dtb;
 	phys_addr_t dtb_mem;
 	phys_addr_t kern_reloc;
+	phys_addr_t kern_reloc_arg;
 };
 
 #ifdef CONFIG_KEXEC_FILE
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 214685760e1c..6fd21374abec 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -23,6 +23,7 @@
 #include <asm/suspend.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
+#include <linux/kexec.h>
 
 int main(void)
 {
@@ -126,6 +127,14 @@ int main(void)
 #ifdef CONFIG_ARM_SDE_INTERFACE
   DEFINE(SDEI_EVENT_INTREGS,	offsetof(struct sdei_registered_event, interrupted_regs));
   DEFINE(SDEI_EVENT_PRIORITY,	offsetof(struct sdei_registered_event, priority));
+#endif
+#ifdef CONFIG_KEXEC_CORE
+  DEFINE(KEXEC_KRELOC_HEAD,		offsetof(struct kern_reloc_arg, head));
+  DEFINE(KEXEC_KRELOC_ENTRY_ADDR,	offsetof(struct kern_reloc_arg, entry_addr));
+  DEFINE(KEXEC_KRELOC_KERN_ARG0,	offsetof(struct kern_reloc_arg, kern_arg0));
+  DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
+  DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
+  DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 6ea337d464c4..99a761bc5ee1 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -21,9 +21,7 @@
  *
  * @el2_switch: Flag to indicate a switch to EL2 is needed.
  * @entry: Location to jump to for soft reset.
- * arg0: First argument passed to @entry. (relocation list)
- * arg1: Second argument passed to @entry.(physical kernel entry)
- * arg2: Third argument passed to @entry. (physical dtb address)
+ * arg: Entry argument
  *
  * Put the CPU into the same state as it would be if it had been reset, and
  * branch to what would be the reset vector. It must be executed with the
@@ -43,9 +41,7 @@ ENTRY(__cpu_soft_restart)
 	hvc	#0				// no return
 
 1:	mov	x18, x1				// entry
-	mov	x0, x2				// arg0
-	mov	x1, x3				// arg1
-	mov	x2, x4				// arg2
+	mov	x0, x2				// arg
 	br	x18
 ENDPROC(__cpu_soft_restart)
 
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index 3a54c4d987f3..7649eec64f82 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -11,12 +11,10 @@
 #include <asm/virt.h>
 
 void __cpu_soft_restart(phys_addr_t el2_switch, phys_addr_t entry,
-	phys_addr_t arg0, phys_addr_t arg1, phys_addr_t arg2);
+			phys_addr_t arg);
 
 static inline void __noreturn cpu_soft_restart(phys_addr_t entry,
-					       phys_addr_t arg0,
-					       phys_addr_t arg1,
-					       phys_addr_t arg2)
+					       phys_addr_t arg)
 {
 	typeof(__cpu_soft_restart) *restart;
 
@@ -25,7 +23,7 @@ static inline void __noreturn cpu_soft_restart(phys_addr_t entry,
 	restart = (void *)__pa_symbol(__cpu_soft_restart);
 
 	cpu_install_idmap();
-	restart(el2_switch, entry, arg0, arg1, arg2);
+	restart(el2_switch, entry, arg);
 	unreachable();
 }
 
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index f94119b5cebc..5f1211f3aeef 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -43,6 +43,7 @@ static void _kexec_image_info(const char *func, int line,
 	pr_debug("    head:        %lx\n", kimage->head);
 	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
 	pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
+	pr_debug("    kern_reloc_arg: %pa\n", &kimage->arch.kern_reloc_arg);
 
 	for (i = 0; i < kimage->nr_segments; i++) {
 		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
@@ -59,13 +60,35 @@ void machine_kexec_cleanup(struct kimage *kimage)
 	/* Empty routine needed to avoid build errors. */
 }
 
+/* Allocates pages for kexec page table */
+static void *kexec_page_alloc(void *arg)
+{
+	struct kimage *kimage = (struct kimage *)arg;
+	struct page *page = kimage_alloc_control_pages(kimage, 0);
+
+	if (!page)
+		return NULL;
+
+	memset(page_address(page), 0, PAGE_SIZE);
+
+	return page_address(page);
+}
+
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
+	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
+
+	if (!kern_reloc_arg)
+		return -ENOMEM;
 
 	memcpy(reloc_code, arm64_relocate_new_kernel,
 	       arm64_relocate_new_kernel_size);
 	kimage->arch.kern_reloc = __pa(reloc_code);
+	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
+	kern_reloc_arg->head = kimage->head;
+	kern_reloc_arg->entry_addr = kimage->start;
+	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
 	kexec_image_info(kimage);
 
 	return 0;
@@ -201,8 +224,7 @@ void machine_kexec(struct kimage *kimage)
 	 * userspace (kexec-tools).
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
-	cpu_soft_restart(kimage->arch.kern_reloc, kimage->head, kimage->start,
-			 kimage->arch.dtb_mem);
+	cpu_soft_restart(kimage->arch.kern_reloc, kimage->arch.kern_reloc_arg);
 
 	BUG(); /* Should never get here. */
 }
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index 41f9c95fabe8..22ccdcb106d3 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -8,6 +8,7 @@
 
 #include <linux/kexec.h>
 #include <linux/linkage.h>
+#include <asm/asm-offsets.h>
 #include <asm/assembler.h>
 #include <asm/kexec.h>
 #include <asm/page.h>
@@ -25,12 +26,6 @@
  * safe memory that has been set up to be preserved during the copy operation.
  */
 ENTRY(arm64_relocate_new_kernel)
-	/* Setup the list loop variables. */
-	mov	x18, x2				/* x18 = dtb address */
-	mov	x17, x1				/* x17 = kimage_start */
-	mov	x16, x0				/* x16 = kimage_head */
-	mov	x14, xzr			/* x14 = entry ptr */
-	mov	x13, xzr			/* x13 = copy dest */
 	/* Clear the sctlr_el2 flags. */
 	mrs	x2, CurrentEL
 	cmp	x2, #CurrentEL_EL2
@@ -42,6 +37,7 @@ ENTRY(arm64_relocate_new_kernel)
 	msr	sctlr_el2, x2
 	isb
 1:	/* Check if the new image needs relocation. */
+	ldr	x16, [x0, #KEXEC_KRELOC_HEAD]	/* x16 = kimage_head */
 	tbnz	x16, IND_DONE_BIT, .Ldone
 	raw_dcache_line_size x15, x1		/* x15 = dcache line size */
 .Lloop:
@@ -81,11 +77,12 @@ ENTRY(arm64_relocate_new_kernel)
 	isb
 
 	/* Start new image. */
-	mov	x0, x18
-	mov	x1, xzr
-	mov	x2, xzr
-	mov	x3, xzr
-	br	x17
+	ldr	x4, [x0, #KEXEC_KRELOC_ENTRY_ADDR]	/* x4 = kimage_start */
+	ldr	x3, [x0, #KEXEC_KRELOC_KERN_ARG3]
+	ldr	x2, [x0, #KEXEC_KRELOC_KERN_ARG2]
+	ldr	x1, [x0, #KEXEC_KRELOC_KERN_ARG1]
+	ldr	x0, [x0, #KEXEC_KRELOC_KERN_ARG0]	/* x0 = dtb address */
+	br	x4
 .ltorg
 END(arm64_relocate_new_kernel)
 
-- 
2.23.0

