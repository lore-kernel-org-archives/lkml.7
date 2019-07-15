Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B22C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F0D2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 13:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730161AbfGONBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:01:44 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:54745 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbfGONBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:01:44 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=andrew.cooper3@citrix.com; spf=Pass smtp.mailfrom=Andrew.Cooper3@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  andrew.cooper3@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="andrew.cooper3@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
  Andrew.Cooper3@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="Andrew.Cooper3@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
  envelope-from="Andrew.Cooper3@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: wOVwiIE1f3e0JRjRaPlwVpbY6IUieV3T62cSyxkNmbuMxY6TwmDMRf/zJChjWPc1sdcIrOgva/
 TjvzmhBzgXMZ47ISTsuSLjld0kalhhTWSvq9XsBwXsOK5dgVQ541k/ONtokWEdLVMI7TxzhaWm
 GpcYOIOlM62qejju9rwVIgUFliXAOdrXrXoJWgAe4jRL0CdKUlgudqC32pSz74WjFlzMoNdsBH
 XUGSDR9hChji2LgiaCI2SDU6/tuxwkv+5N8DOxYLb8pU6EBwH3BSGRonfHc0NnhJKBRERBT4pz
 W7I=
X-SBRS: 2.7
X-MesageID: 2979096
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,493,1557201600"; 
   d="scan'208";a="2979096"
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
        Alok Kataria <akataria@vmware.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] x86/paravirt: Drop {read,write}_cr8() hooks
Date:   Mon, 15 Jul 2019 14:00:56 +0100
Message-ID: <20190715130056.10627-1-andrew.cooper3@citrix.com>
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

cr8 is an alias of APIC_TASKPRI, and APIC_TASKPRI is saved/restored
independently by lapic_{suspend,resume}().

Delete the saving and restoration of cr8, which allows for the removal
of both PVOPS.

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
CC: Alok Kataria <akataria@vmware.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Pavel Machek <pavel@ucw.cz>

Spotted while reviewing "x86/apic: Initialize TPR to block interrupts 16-31"

https://lore.kernel.org/lkml/dc04a9f8b234d7b0956a8d2560b8945bcd9c4bf7.1563117760.git.luto@kernel.org/
---
 arch/x86/include/asm/paravirt.h       | 12 ------------
 arch/x86/include/asm/paravirt_types.h |  5 -----
 arch/x86/include/asm/special_insns.h  | 24 ------------------------
 arch/x86/kernel/paravirt.c            |  4 ----
 arch/x86/power/cpu.c                  |  4 ----
 arch/x86/xen/enlighten_pv.c           | 15 ---------------
 6 files changed, 64 deletions(-)

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

