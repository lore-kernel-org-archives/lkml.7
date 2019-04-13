Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0A6C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C5D2084E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 20:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfDMUzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 16:55:24 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44843 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfDMUzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 16:55:23 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DKsLgD2266273
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 13:54:21 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DKsKPV2266270;
        Sat, 13 Apr 2019 13:54:20 -0700
Date:   Sat, 13 Apr 2019 13:54:20 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-c806e88734b9e9aea260bf2261c129aa23968fca@git.kernel.org>
Cc:     jroedel@suse.de, jgross@suse.com, mhocko@suse.cz, bp@suse.de,
        rkrcmar@redhat.com, Jason@zx2c4.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, hpa@zytor.com,
        bigeasy@linutronix.de, luto@kernel.org, dave.hansen@intel.com,
        ak@linux.intel.com, riel@surriel.com, x86@kernel.org,
        mingo@kernel.org, pbonzini@redhat.com, mingo@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: Jason@zx2c4.com, rkrcmar@redhat.com, bp@suse.de, mhocko@suse.cz,
          jgross@suse.com, jroedel@suse.de, riel@surriel.com,
          ak@linux.intel.com, dave.hansen@intel.com, bigeasy@linutronix.de,
          hpa@zytor.com, luto@kernel.org, tglx@linutronix.de,
          kirill.shutemov@linux.intel.com, pbonzini@redhat.com,
          x86@kernel.org, mingo@kernel.org, kvm@vger.kernel.org,
          linux-kernel@vger.kernel.org, mingo@redhat.com
In-Reply-To: <20190403164156.19645-13-bigeasy@linutronix.de>
References: <20190403164156.19645-13-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/pkeys: Provide *pkru() helpers
Git-Commit-ID: c806e88734b9e9aea260bf2261c129aa23968fca
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

Commit-ID:  c806e88734b9e9aea260bf2261c129aa23968fca
Gitweb:     https://git.kernel.org/tip/c806e88734b9e9aea260bf2261c129aa23968fca
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:41 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 11 Apr 2019 15:40:58 +0200

x86/pkeys: Provide *pkru() helpers

Dave Hansen asked for __read_pkru() and __write_pkru() to be
symmetrical.

As part of the series __write_pkru() will read back the value and only
write it if it is different.

In order to make both functions symmetrical, move the function
containing only the opcode asm into a function called like the
instruction itself.

__write_pkru() will just invoke wrpkru() but in a follow-up patch will
also read back the value.

 [ bp: Convert asm opcode wrapper names to rd/wrpkru(). ]

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-13-bigeasy@linutronix.de
---
 arch/x86/include/asm/pgtable.h       |  2 +-
 arch/x86/include/asm/special_insns.h | 12 +++++++++---
 arch/x86/kvm/vmx/vmx.c               |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 2779ace16d23..e8875ca75623 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -127,7 +127,7 @@ static inline int pte_dirty(pte_t pte)
 static inline u32 read_pkru(void)
 {
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		return __read_pkru();
+		return rdpkru();
 	return 0;
 }
 
diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index 43c029cdc3fe..34897e2b52c9 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -92,7 +92,7 @@ static inline void native_write_cr8(unsigned long val)
 #endif
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-static inline u32 __read_pkru(void)
+static inline u32 rdpkru(void)
 {
 	u32 ecx = 0;
 	u32 edx, pkru;
@@ -107,7 +107,7 @@ static inline u32 __read_pkru(void)
 	return pkru;
 }
 
-static inline void __write_pkru(u32 pkru)
+static inline void wrpkru(u32 pkru)
 {
 	u32 ecx = 0, edx = 0;
 
@@ -118,8 +118,14 @@ static inline void __write_pkru(u32 pkru)
 	asm volatile(".byte 0x0f,0x01,0xef\n\t"
 		     : : "a" (pkru), "c"(ecx), "d"(edx));
 }
+
+static inline void __write_pkru(u32 pkru)
+{
+	wrpkru(pkru);
+}
+
 #else
-static inline u32 __read_pkru(void)
+static inline u32 rdpkru(void)
 {
 	return 0;
 }
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ab432a930ae8..dd1e1eea4f0b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6501,7 +6501,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	if (static_cpu_has(X86_FEATURE_PKU) &&
 	    kvm_read_cr4_bits(vcpu, X86_CR4_PKE)) {
-		vcpu->arch.pkru = __read_pkru();
+		vcpu->arch.pkru = rdpkru();
 		if (vcpu->arch.pkru != vmx->host_pkru)
 			__write_pkru(vmx->host_pkru);
 	}
