Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1004BC76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A67205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbfGOPQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 11:16:51 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:9642 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730221AbfGOPQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 11:16:50 -0400
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: l9OPAd6qskqt/fZMa6dv8Hp73Rl5OlOh7AzJZZ687tl7VWm+xCIWBW+xMMGDPUaxtR2EHfIwMj
 S9B8lKNjnBPgzm/CNYSRASVK49D1v0vczwBHy2YW7EUVrUevHGwhL69UC1EXaPqbcS+Lzk0tsa
 cN4KDMSIOerfROzuw60w1iIxo0Y5hPmmZh9GcTrNgjgzH+lCkCfS59YUjideuTAFLYYxPXoAwf
 lAZFtg64XbaJPocGk2yXFZ2W0bRqNu1OqV5WKQ6ztHIMBZT03C8AFlAajQ3TwXi44OxyUtDG5x
 fY8=
X-SBRS: 2.7
X-MesageID: 2967596
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,493,1557201600"; 
   d="scan'208";a="2967596"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>, <x86@kernel.org>,
        <virtualization@lists.linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Stephane Eranian <eranian@google.com>,
        "Feng Tang" <feng.tang@intel.com>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pavel Machek" <pavel@ucw.cz>
Subject: [PATCH v2] x86/paravirt: Drop {read,write}_cr8() hooks
Date:   Mon, 15 Jul 2019 16:16:41 +0100
Message-ID: <20190715151641.29210-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lot of infrastructure for functionality which is used
exclusively in __{save,restore}_processor_state() on the suspend/resume
path.

cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored by
lapic_{suspend,resume}().  Saving and restoring cr8 independently of the
rest of the Local APIC state isn't a clever thing to be doing.

Delete the suspend/resume cr8 handling, which shrinks the size of struct
saved_context, and allows for the removal of both PVOPS.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: x86@kernel.org
CC: virtualization@lists.linux-foundation.org
CC: Borislav Petkov <bp@alien8.de>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Andy Lutomirski <luto@kernel.org>
CC: Nadav Amit <namit@vmware.com>
CC: Stephane Eranian <eranian@google.com>
CC: Feng Tang <feng.tang@intel.com>
CC: Juergen Gross <jgross@suse.com>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Pavel Machek <pavel@ucw.cz>

Spotted while reviewing "x86/apic: Initialize TPR to block interrupts 16-31"

https://lore.kernel.org/lkml/dc04a9f8b234d7b0956a8d2560b8945bcd9c4bf7.1563117760.git.luto@kernel.org/

v2:
 * Drop saved_context.cr8 as well (Juergen)
 * Remove akataria@vmware.com from the CC list due to bounces
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
index c25c38a05c1c..0e4a0539c353 100644
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
index 946f8f1f1efc..3c775fb5524b 100644
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
index 98039d7fb998..de4d4e8a54c1 100644
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
index 4722ba2966ac..27aba18f30e8 100644
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
@@ -1022,11 +1012,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 
 	.write_cr4 = xen_write_cr4,
 
-#ifdef CONFIG_X86_64
-	.read_cr8 = xen_read_cr8,
-	.write_cr8 = xen_write_cr8,
-#endif
-
 	.wbinvd = native_wbinvd,
 
 	.read_msr = xen_read_msr,
-- 
2.11.0

