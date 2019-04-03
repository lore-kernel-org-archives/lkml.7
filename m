Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328E4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB532082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfDCQoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:44:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41931 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfDCQmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:42:22 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hBixs-0004GO-LR; Wed, 03 Apr 2019 18:42:16 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH 12/27] x86/pkru: Provide .*_pkru_ins() functions
Date:   Wed,  3 Apr 2019 18:41:41 +0200
Message-Id: <20190403164156.19645-13-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403164156.19645-1-bigeasy@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen has asked for __read_pkru() and __write_pkru() to be symmetrical.
As part of the series __write_pkru() will read back the value and only write it
if it is different.
In order to make both functions symmetrical move the function containing only
the opcode into a function with _isn() suffix. __write_pkru() will just invoke
__write_pkru_isn() but in a flowup patch will also read back the value.

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/pgtable.h       |  2 +-
 arch/x86/include/asm/special_insns.h | 12 +++++++++---
 arch/x86/kvm/vmx/vmx.c               |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2779ace16d23f..64333e5222cd9 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -127,7 +127,7 @@ static inline int pte_dirty(pte_t pte)
 static inline u32 read_pkru(void)
 {
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		return __read_pkru();
+		return __read_pkru_ins();
 	return 0;
 }
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe8..27328606ff687 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -92,7 +92,7 @@ static inline void native_write_cr8(unsigned long val)
 #endif
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-static inline u32 __read_pkru(void)
+static inline u32 __read_pkru_ins(void)
 {
 	u32 ecx = 0;
 	u32 edx, pkru;
@@ -107,7 +107,7 @@ static inline u32 __read_pkru(void)
 	return pkru;
 }
 
-static inline void __write_pkru(u32 pkru)
+static inline void __write_pkru_ins(u32 pkru)
 {
 	u32 ecx = 0, edx = 0;
 
@@ -118,8 +118,14 @@ static inline void __write_pkru(u32 pkru)
 	asm volatile(".byte 0x0f,0x01,0xef\n\t"
 		     : : "a" (pkru), "c"(ecx), "d"(edx));
 }
+
+static inline void __write_pkru(u32 pkru)
+{
+	__write_pkru_ins(pkru);
+}
+
 #else
-static inline u32 __read_pkru(void)
+static inline u32 __read_pkru_ins(void)
 {
 	return 0;
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ab432a930ae86..96dec81430970 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6501,7 +6501,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	if (static_cpu_has(X86_FEATURE_PKU) &&
 	    kvm_read_cr4_bits(vcpu, X86_CR4_PKE)) {
-		vcpu->arch.pkru = __read_pkru();
+		vcpu->arch.pkru = __read_pkru_ins();
 		if (vcpu->arch.pkru != vmx->host_pkru)
 			__write_pkru(vmx->host_pkru);
 	}
-- 
2.20.1

