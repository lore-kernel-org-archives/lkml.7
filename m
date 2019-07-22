Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A2CC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615FD21E70
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="4flJojG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfGVIRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:17:07 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35747 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbfGVIRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:17:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8GuDa3737047
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:16:56 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8GuDa3737047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563783416;
        bh=hXRHs9Z77OQX7vQzzQmFqwMUsOVy+Scu6X57KVPyJdY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=4flJojG51JXdao85uio/HAs3cZ4BZNNRadBQIdoKrR53iuPFgU1FZnHHcm1wrrr1m
         kaQef/F1a9+SbPRkX5uSrRyiASstzBJYzWB9OPWrDEl0FQqcH58NCvm6xi8LSdH/mx
         J/Mx2UnTj39qH1sGlIC31VhOYIaWZAqCUx/qRAF3EeRa+6KmlY3SmwNiWnrOGdSzw9
         gfAI3kHo2O5/v5WefvRZPWce2ZLpvINEOzYJlgIhXTAXyKbS/vXp5o6ojbfOi0WFNQ
         WX6ROatM8LYQWMnwF+4eq5O1QgxbatQ7hdm6R4ZiekJR2hOAS0z9+aAOYzBx4sLfIR
         YiEyxPK0SRhLw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8GtPN3737044;
        Mon, 22 Jul 2019 01:16:55 -0700
Date:   Mon, 22 Jul 2019 01:16:55 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andrew Cooper <tipbot@zytor.com>
Message-ID: <tip-83b584d9c6a1494170abd3a8b24f41939b23d625@git.kernel.org>
Cc:     andrew.cooper3@citrix.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, jgross@suse.com, linux-kernel@vger.kernel.org
Reply-To: hpa@zytor.com, mingo@kernel.org, andrew.cooper3@citrix.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, jgross@suse.com
In-Reply-To: <20190715151641.29210-1-andrew.cooper3@citrix.com>
References: <20190715151641.29210-1-andrew.cooper3@citrix.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/paravirt: Drop {read,write}_cr8() hooks
Git-Commit-ID: 83b584d9c6a1494170abd3a8b24f41939b23d625
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

Commit-ID:  83b584d9c6a1494170abd3a8b24f41939b23d625
Gitweb:     https://git.kernel.org/tip/83b584d9c6a1494170abd3a8b24f41939b23d625
Author:     Andrew Cooper <andrew.cooper3@citrix.com>
AuthorDate: Mon, 15 Jul 2019 16:16:41 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:12:33 +0200

x86/paravirt: Drop {read,write}_cr8() hooks

There is a lot of infrastructure for functionality which is used
exclusively in __{save,restore}_processor_state() on the suspend/resume
path.

cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored by
lapic_{suspend,resume}().  Saving and restoring cr8 independently of the
rest of the Local APIC state isn't a clever thing to be doing.

Delete the suspend/resume cr8 handling, which shrinks the size of struct
saved_context, and allows for the removal of both PVOPS.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lkml.kernel.org/r/20190715151641.29210-1-andrew.cooper3@citrix.com

---
 arch/x86/include/asm/paravirt.h       | 12 ------------
 arch/x86/include/asm/paravirt_types.h |  5 -----
 arch/x86/include/asm/special_insns.h  | 24 ------------------------
 arch/x86/include/asm/suspend_64.h     |  2 +-
 arch/x86/kernel/asm-offsets_64.c      |  1 -
 arch/x86/kernel/paravirt.c            |  4 ----
 arch/x86/power/cpu.c                  |  4 ----
 arch/x86/xen/enlighten_pv.c           | 15 ---------------
 8 files changed, 1 insertion(+), 66 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index dce26f1d13e1..69089d46f128 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -139,18 +139,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-#ifdef CONFIG_X86_64
-static inline unsigned long read_cr8(void)
-{
-	return PVOP_CALL0(unsigned long, cpu.read_cr8);
-}
-
-static inline void write_cr8(unsigned long x)
-{
-	PVOP_VCALL1(cpu.write_cr8, x);
-}
-#endif
-
 static inline void arch_safe_halt(void)
 {
 	PVOP_VCALL0(irq.safe_halt);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 639b2df445ee..70b654f3ffe5 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -119,11 +119,6 @@ struct pv_cpu_ops {
 
 	void (*write_cr4)(unsigned long);
 
-#ifdef CONFIG_X86_64
-	unsigned long (*read_cr8)(void);
-	void (*write_cr8)(unsigned long);
-#endif
-
 	/* Segment descriptor handling */
 	void (*load_tr_desc)(void);
 	void (*load_gdt)(const struct desc_ptr *);
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 219be88a59d2..6d37b8fcfc77 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -73,20 +73,6 @@ static inline unsigned long native_read_cr4(void)
 
 void native_write_cr4(unsigned long val);
 
-#ifdef CONFIG_X86_64
-static inline unsigned long native_read_cr8(void)
-{
-	unsigned long cr8;
-	asm volatile("movq %%cr8,%0" : "=r" (cr8));
-	return cr8;
-}
-
-static inline void native_write_cr8(unsigned long val)
-{
-	asm volatile("movq %0,%%cr8" :: "r" (val) : "memory");
-}
-#endif
-
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 static inline u32 rdpkru(void)
 {
@@ -200,16 +186,6 @@ static inline void wbinvd(void)
 
 #ifdef CONFIG_X86_64
 
-static inline unsigned long read_cr8(void)
-{
-	return native_read_cr8();
-}
-
-static inline void write_cr8(unsigned long x)
-{
-	native_write_cr8(x);
-}
-
 static inline void load_gs_index(unsigned selector)
 {
 	native_load_gs_index(selector);
diff --git a/arch/x86/include/asm/suspend_64.h b/arch/x86/include/asm/suspend_64.h
index a7af9f53c0cb..35bb35d28733 100644
--- a/arch/x86/include/asm/suspend_64.h
+++ b/arch/x86/include/asm/suspend_64.h
@@ -34,7 +34,7 @@ struct saved_context {
 	 */
 	unsigned long kernelmode_gs_base, usermode_gs_base, fs_base;
 
-	unsigned long cr0, cr2, cr3, cr4, cr8;
+	unsigned long cr0, cr2, cr3, cr4;
 	u64 misc_enable;
 	bool misc_enable_saved;
 	struct saved_msrs saved_msrs;
diff --git a/arch/x86/kernel/asm-offsets_64.c b/arch/x86/kernel/asm-offsets_64.c
index d3d075226c0a..8b54d8e3a561 100644
--- a/arch/x86/kernel/asm-offsets_64.c
+++ b/arch/x86/kernel/asm-offsets_64.c
@@ -62,7 +62,6 @@ int main(void)
 	ENTRY(cr2);
 	ENTRY(cr3);
 	ENTRY(cr4);
-	ENTRY(cr8);
 	ENTRY(gdt_desc);
 	BLANK();
 #undef ENTRY
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 0aa6256eedd8..59d3d2763a9e 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -311,10 +311,6 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
-#ifdef CONFIG_X86_64
-	.cpu.read_cr8		= native_read_cr8,
-	.cpu.write_cr8		= native_write_cr8,
-#endif
 	.cpu.wbinvd		= native_wbinvd,
 	.cpu.read_msr		= native_read_msr,
 	.cpu.write_msr		= native_write_msr,
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 24b079e94bc2..1c58d8982728 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -122,9 +122,6 @@ static void __save_processor_state(struct saved_context *ctxt)
 	ctxt->cr2 = read_cr2();
 	ctxt->cr3 = __read_cr3();
 	ctxt->cr4 = __read_cr4();
-#ifdef CONFIG_X86_64
-	ctxt->cr8 = read_cr8();
-#endif
 	ctxt->misc_enable_saved = !rdmsrl_safe(MSR_IA32_MISC_ENABLE,
 					       &ctxt->misc_enable);
 	msr_save_context(ctxt);
@@ -207,7 +204,6 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 #else
 /* CONFIG X86_64 */
 	wrmsrl(MSR_EFER, ctxt->efer);
-	write_cr8(ctxt->cr8);
 	__write_cr4(ctxt->cr4);
 #endif
 	write_cr3(ctxt->cr3);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 7ceb32821093..58f79ab32358 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -877,16 +877,6 @@ static void xen_write_cr4(unsigned long cr4)
 
 	native_write_cr4(cr4);
 }
-#ifdef CONFIG_X86_64
-static inline unsigned long xen_read_cr8(void)
-{
-	return 0;
-}
-static inline void xen_write_cr8(unsigned long val)
-{
-	BUG_ON(val);
-}
-#endif
 
 static u64 xen_read_msr_safe(unsigned int msr, int *err)
 {
@@ -1023,11 +1013,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 
 	.write_cr4 = xen_write_cr4,
 
-#ifdef CONFIG_X86_64
-	.read_cr8 = xen_read_cr8,
-	.write_cr8 = xen_write_cr8,
-#endif
-
 	.wbinvd = native_wbinvd,
 
 	.read_msr = xen_read_msr,
