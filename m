Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA5FCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6763721726
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 06:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbfJ0Grr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 02:47:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40946 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfJ0Grr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 02:47:47 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iOcL3-0002pm-HZ; Sun, 27 Oct 2019 07:47:45 +0100
Date:   Sun, 27 Oct 2019 06:46:26 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for 5.4-rc5
References: <157215878694.13117.16411564430107054752.tglx@nanos.tec.linutronix.de>
Message-ID: <157215878694.13117.10331983631021160763.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

up to:  6fee2a0be0ec: x86/cpu/vmware: Fix platform detection VMWARE_PORT macro

Two fixes for the VMWare guest support:

  - Unbreak VMWare platform detection which got wreckaged by converting
    an integer constant to a string constant.

  - Fix the clang build of the VMWAre hypercall by explicitely specifying
    the ouput register for INL instead of using the short form.

Thanks,

	tglx

------------------>
Thomas Hellstrom (2):
      x86/cpu/vmware: Use the full form of INL in VMWARE_HYPERCALL, for clang/llvm
      x86/cpu/vmware: Fix platform detection VMWARE_PORT macro


 arch/x86/include/asm/vmware.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/vmware.h b/arch/x86/include/asm/vmware.h
index e00c9e875933..ac9fc51e2b18 100644
--- a/arch/x86/include/asm/vmware.h
+++ b/arch/x86/include/asm/vmware.h
@@ -4,6 +4,7 @@
 
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
+#include <linux/stringify.h>
 
 /*
  * The hypercall definitions differ in the low word of the %edx argument
@@ -20,8 +21,8 @@
  */
 
 /* Old port-based version */
-#define VMWARE_HYPERVISOR_PORT    "0x5658"
-#define VMWARE_HYPERVISOR_PORT_HB "0x5659"
+#define VMWARE_HYPERVISOR_PORT    0x5658
+#define VMWARE_HYPERVISOR_PORT_HB 0x5659
 
 /* Current vmcall / vmmcall version */
 #define VMWARE_HYPERVISOR_HB   BIT(0)
@@ -29,7 +30,8 @@
 
 /* The low bandwidth call. The low word of edx is presumed clear. */
 #define VMWARE_HYPERCALL						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT ", %%dx; inl (%%dx)", \
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT) ", %%dx; " \
+		      "inl (%%dx), %%eax",				\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 
@@ -38,7 +40,8 @@
  * HB and OUT bits set.
  */
 #define VMWARE_HYPERCALL_HB_OUT						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep outsb", \
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
+		      "rep outsb",					\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 
@@ -47,7 +50,8 @@
  * HB bit set.
  */
 #define VMWARE_HYPERCALL_HB_IN						\
-	ALTERNATIVE_2("movw $" VMWARE_HYPERVISOR_PORT_HB ", %%dx; rep insb", \
+	ALTERNATIVE_2("movw $" __stringify(VMWARE_HYPERVISOR_PORT_HB) ", %%dx; " \
+		      "rep insb",					\
 		      "vmcall", X86_FEATURE_VMCALL,			\
 		      "vmmcall", X86_FEATURE_VMW_VMMCALL)
 #endif


