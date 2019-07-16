Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D868C7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1026E205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="idL/2gxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbfGPQ4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 12:56:49 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34016 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388125AbfGPQ4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 12:56:47 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so20354583qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 09:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EifO61K65QbWAJ6xpvhOah9bA7Qm2CvZMBmlIJekn+0=;
        b=idL/2gxy1CAm62HCYqxM5BClPT9M4sH4sKI6TrJoDPJCf2MiSdvmWabARetWUf3w1e
         iLVb6WIYwP5AjN2cIxv4h5a/dXC1HSfIq/EowkRDV/VcrwVXFilBnt+w4BX/wJSeNTac
         VyO4uTItzt3qHiEZV1+Cipw1CKfeXeHp4CuapXhbkQG5CU5UI6UQiqrQmRW6A4HfkYH5
         kB+ZyqB3ioM+rxuyRjt7E0sXi1Gw71iKFcmO1Vy4zAAGlf2PsetNRiLVlfApLPbn9+g0
         yelseVL4ypdMFaIAuiYKSa557KSo3N7gKd7xeCmlxODv06M1IU+zX/u6dMsGi8SfWUcu
         Qqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EifO61K65QbWAJ6xpvhOah9bA7Qm2CvZMBmlIJekn+0=;
        b=f8DAgzpZ5SZ48qkb26qZh1uj7FM5nEpR2LO0OhvYyS35C7ok0h7Es39IG6Bsx/c6ZN
         OjKo3CJ/Wqyz5NyS3HWxw+1+Nb12qOSFJgMoz9GDRBl5brDYA7aQkNArdJUgvUpeeyO9
         PYFD+Ljyfymv/RRPcUrUsV37jGLZOXvj4xbjvQthHEk/CvEBVG4e9oFPvxjzR6Ll+vV5
         LPAQqrvFhbIBiesW3kpnj5qHQmtsMvzTYxxjBQuIvSyVtUJ/mMmIek5HDZj6fViEx9ZO
         HLFwujalH5+WDa4eKy9KwXigG6BVkONfQhwrENC1bYjmoZMLFFJZBjUvambO8CFafZWP
         FZhw==
X-Gm-Message-State: APjAAAW7Gm3UD20xonEv/XZoPFQte9oHoFBPwhBVPKzhh5lgOeo8zXRu
        sKyktOWnmBwKgT7r0mXlgj0=
X-Google-Smtp-Source: APXvYqzHhhYiAKJdjA+sOKDaBPu/cH7wsljYIAcV0+pVKa8zDrnxHDQQygDK1MnOobsI2gFvewAVfA==
X-Received: by 2002:aed:24d9:: with SMTP id u25mr24126760qtc.111.1563296205591;
        Tue, 16 Jul 2019 09:56:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id f20sm8519538qkh.15.2019.07.16.09.56.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 09:56:44 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC v1 2/4] arm64, kexec: interface preparation for mmu enabled kexec
Date:   Tue, 16 Jul 2019 12:56:39 -0400
Message-Id: <20190716165641.6990-3-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716165641.6990-1-pasha.tatashin@soleen.com>
References: <20190716165641.6990-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently cpu_install_idmap() is used to install page table during kexec
switch over to purgatory. We soon will be using our own page table, that
maps the whole physical range (and might be even more, i.e if new DTB
describes a bigger physical range or mem= parameter limited physical
range in the current kernel).

Make kimage_arch to be always part of arm64.
Add relocate_kern and kexec_pgtable verctors to this struct, as we won't
be able to rely on a single control page anymore.

Copy relocation function in machine_kexec_prepare(), and setup page
table there as well (for now idmap_pg_dir).

Cleanup call to cpu_soft_restart by removing ugly ifdefs. When
kimage->arch.dtb_mem is not set, it is 0 anyway.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    |  5 +--
 arch/arm64/kernel/cpu-reset.h     |  7 ++++-
 arch/arm64/kernel/machine_kexec.c | 52 ++++++++++++++-----------------
 3 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 12a561a54128..ef2d2442b890 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -90,14 +90,15 @@ static inline void crash_prepare_suspend(void) {}
 static inline void crash_post_resume(void) {}
 #endif
 
-#ifdef CONFIG_KEXEC_FILE
 #define ARCH_HAS_KIMAGE_ARCH
-
 struct kimage_arch {
 	void *dtb;
 	unsigned long dtb_mem;
+	void  *relocate_kern;
+	pgd_t *kexec_pgtable;
 };
 
+#ifdef CONFIG_KEXEC_FILE
 extern const struct kexec_file_ops kexec_image_ops;
 
 struct kimage;
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index ed50e9587ad8..c795811587f0 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -14,6 +14,7 @@ void __cpu_soft_restart(unsigned long el2_switch, unsigned long entry,
 	unsigned long arg0, unsigned long arg1, unsigned long arg2);
 
 static inline void __noreturn cpu_soft_restart(unsigned long entry,
+					       pgd_t *kexec_pgtable,
 					       unsigned long arg0,
 					       unsigned long arg1,
 					       unsigned long arg2)
@@ -24,7 +25,11 @@ static inline void __noreturn cpu_soft_restart(unsigned long entry,
 		is_hyp_mode_available();
 	restart = (void *)__pa_symbol(__cpu_soft_restart);
 
-	cpu_install_idmap();
+	cpu_set_reserved_ttbr0();
+	local_flush_tlb_all();
+	write_sysreg(phys_to_ttbr(virt_to_phys(kexec_pgtable)), ttbr0_el1);
+	isb();
+
 	restart(el2_switch, entry, arg0, arg1, arg2);
 	unreachable();
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 0df8493624e0..f4565eb01d09 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -42,6 +42,8 @@ static void _kexec_image_info(const char *func, int line,
 	pr_debug("    start:       %lx\n", kimage->start);
 	pr_debug("    head:        %lx\n", kimage->head);
 	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+	pr_debug("    arch.kexec_pgtable: %p\n", kimage->arch.kexec_pgtable);
+	pr_debug("    arch.relocate_kern: %p\n", kimage->arch.relocate_kern);
 
 	for (i = 0; i < kimage->nr_segments; i++) {
 		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
@@ -67,13 +69,24 @@ void machine_kexec_cleanup(struct kimage *kimage)
  */
 int machine_kexec_prepare(struct kimage *kimage)
 {
-	kexec_image_info(kimage);
+	void *reloc_buf = page_address(kimage->control_code_page);
 
 	if (kimage->type != KEXEC_TYPE_CRASH && cpus_are_stuck_in_kernel()) {
 		pr_err("Can't kexec: CPUs are stuck in the kernel.\n");
 		return -EBUSY;
 	}
 
+	/*
+	 * Copy arm64_relocate_new_kernel to the buffer for use after the kernel
+	 * is shut down.
+	 */
+	memcpy(reloc_buf, arm64_relocate_new_kernel,
+	       arm64_relocate_new_kernel_size);
+
+	kimage->arch.relocate_kern = reloc_buf;
+	kimage->arch.kexec_pgtable = lm_alias(idmap_pg_dir);
+	kexec_image_info(kimage);
+
 	return 0;
 }
 
@@ -143,8 +156,6 @@ static void kexec_segment_flush(const struct kimage *kimage)
  */
 void machine_kexec(struct kimage *kimage)
 {
-	phys_addr_t reboot_code_buffer_phys;
-	void *reboot_code_buffer;
 	bool in_kexec_crash = (kimage == kexec_crash_image);
 	bool stuck_cpus = cpus_are_stuck_in_kernel();
 
@@ -155,32 +166,17 @@ void machine_kexec(struct kimage *kimage)
 	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
-	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
-	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
-
 	kexec_image_info(kimage);
-
-	pr_debug("%s:%d: control_code_page:        %p\n", __func__, __LINE__,
-		kimage->control_code_page);
-	pr_debug("%s:%d: reboot_code_buffer_phys:  %pa\n", __func__, __LINE__,
-		&reboot_code_buffer_phys);
-	pr_debug("%s:%d: reboot_code_buffer:       %p\n", __func__, __LINE__,
-		reboot_code_buffer);
 	pr_debug("%s:%d: relocate_new_kernel:      %p\n", __func__, __LINE__,
 		arm64_relocate_new_kernel);
 	pr_debug("%s:%d: relocate_new_kernel_size: 0x%lx(%lu) bytes\n",
 		__func__, __LINE__, arm64_relocate_new_kernel_size,
 		arm64_relocate_new_kernel_size);
 
-	/*
-	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
-	 * after the kernel is shut down.
-	 */
-	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
-		arm64_relocate_new_kernel_size);
 
-	/* Flush the reboot_code_buffer in preparation for its execution. */
-	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
+	/* Flush the relocate_kern in preparation for its execution. */
+	__flush_dcache_area(kimage->arch.relocate_kern,
+			    arm64_relocate_new_kernel_size);
 
 	/*
 	 * Although we've killed off the secondary CPUs, we don't update
@@ -188,7 +184,7 @@ void machine_kexec(struct kimage *kimage)
 	 * need to avoid flush_icache_range(), which will attempt to IPI
 	 * the offline CPUs. Therefore, we must use the __* variant here.
 	 */
-	__flush_icache_range((uintptr_t)reboot_code_buffer,
+	__flush_icache_range((uintptr_t)kimage->arch.relocate_kern,
 			     arm64_relocate_new_kernel_size);
 
 	/* Flush the kimage list and its buffers. */
@@ -204,7 +200,7 @@ void machine_kexec(struct kimage *kimage)
 
 	/*
 	 * cpu_soft_restart will shutdown the MMU, disable data caches, then
-	 * transfer control to the reboot_code_buffer which contains a copy of
+	 * transfer control to the relocate_kern which contains a copy of
 	 * the arm64_relocate_new_kernel routine.  arm64_relocate_new_kernel
 	 * uses physical addressing to relocate the new image to its final
 	 * position and transfers control to the image entry point when the
@@ -214,12 +210,10 @@ void machine_kexec(struct kimage *kimage)
 	 * userspace (kexec-tools).
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
-	cpu_soft_restart(reboot_code_buffer_phys, kimage->head, kimage->start,
-#ifdef CONFIG_KEXEC_FILE
-						kimage->arch.dtb_mem);
-#else
-						0);
-#endif
+	cpu_soft_restart(__pa(kimage->arch.relocate_kern),
+			 kimage->arch.kexec_pgtable,
+			 kimage->head, kimage->start,
+			 kimage->arch.dtb_mem);
 
 	BUG(); /* Should never get here. */
 }
-- 
2.22.0

