Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044F7C10F11
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D5C2147A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 21:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDMVHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 17:07:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56213 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfDMVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 17:07:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3DL59JD2269537
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Apr 2019 14:05:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3DL581N2269532;
        Sat, 13 Apr 2019 14:05:08 -0700
Date:   Sat, 13 Apr 2019 14:05:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sebastian Andrzej Siewior <tipbot@zytor.com>
Message-ID: <tip-a5eff7259790d5314eff10563d6e59d358cce482@git.kernel.org>
Cc:     mingo@kernel.org, bp@suse.de, hpa@zytor.com, ak@linux.intel.com,
        x86@kernel.org, riel@surriel.com, rkrcmar@redhat.com,
        luto@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason@zx2c4.com, bigeasy@linutronix.de, linux@dominikbrodowski.net,
        tglx@linutronix.de, konrad.wilk@oracle.com, peterz@infradead.org,
        pbonzini@redhat.com, mingo@redhat.com, pasha.tatashin@oracle.com,
        chang.seok.bae@intel.com, dave.hansen@intel.com
Reply-To: luto@kernel.org, kvm@vger.kernel.org, rkrcmar@redhat.com,
          Jason@zx2c4.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
          bp@suse.de, mingo@kernel.org, riel@surriel.com, x86@kernel.org,
          ak@linux.intel.com, mingo@redhat.com, peterz@infradead.org,
          pbonzini@redhat.com, dave.hansen@intel.com,
          pasha.tatashin@oracle.com, chang.seok.bae@intel.com,
          bigeasy@linutronix.de, linux@dominikbrodowski.net,
          konrad.wilk@oracle.com, tglx@linutronix.de
In-Reply-To: <20190403164156.19645-28-bigeasy@linutronix.de>
References: <20190403164156.19645-28-bigeasy@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/fpu] x86/pkeys: Add PKRU value to init_fpstate
Git-Commit-ID: a5eff7259790d5314eff10563d6e59d358cce482
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

Commit-ID:  a5eff7259790d5314eff10563d6e59d358cce482
Gitweb:     https://git.kernel.org/tip/a5eff7259790d5314eff10563d6e59d358cce482
Author:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate: Wed, 3 Apr 2019 18:41:56 +0200
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 12 Apr 2019 20:21:10 +0200

x86/pkeys: Add PKRU value to init_fpstate

The task's initial PKRU value is set partly for fpu__clear()/
copy_init_pkru_to_fpregs(). It is not part of init_fpstate.xsave and
instead it is set explicitly.

If the user removes the PKRU state from XSAVE in the signal handler then
__fpu__restore_sig() will restore the missing bits from `init_fpstate'
and initialize the PKRU value to 0.

Add the `init_pkru_value' to `init_fpstate' so it is set to the init
value in such a case.

In theory copy_init_pkru_to_fpregs() could be removed because restoring
the PKRU at return-to-userland should be enough.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: kvm ML <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190403164156.19645-28-bigeasy@linutronix.de
---
 arch/x86/kernel/cpu/common.c | 5 +++++
 arch/x86/mm/pkeys.c          | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659..352fa19e6311 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -372,6 +372,8 @@ static bool pku_disabled;
 
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
+	struct pkru_state *pk;
+
 	/* check the boot processor, plus compile options for PKU: */
 	if (!cpu_feature_enabled(X86_FEATURE_PKU))
 		return;
@@ -382,6 +384,9 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 		return;
 
 	cr4_set_bits(X86_CR4_PKE);
+	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
+	if (pk)
+		pk->pkru = init_pkru_value;
 	/*
 	 * Seting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
 	 * cpuid bit to be set.  We need to ensure that we
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 2ecbf4155f98..1dcfc91c8f0c 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -18,6 +18,7 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
+#include <asm/fpu/internal.h>		/* init_fpstate			*/
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
@@ -161,6 +162,7 @@ static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 static ssize_t init_pkru_write_file(struct file *file,
 		 const char __user *user_buf, size_t count, loff_t *ppos)
 {
+	struct pkru_state *pk;
 	char buf[32];
 	ssize_t len;
 	u32 new_init_pkru;
@@ -183,6 +185,10 @@ static ssize_t init_pkru_write_file(struct file *file,
 		return -EINVAL;
 
 	WRITE_ONCE(init_pkru_value, new_init_pkru);
+	pk = get_xsave_addr(&init_fpstate.xsave, XFEATURE_PKRU);
+	if (!pk)
+		return -EINVAL;
+	pk->pkru = new_init_pkru;
 	return count;
 }
 
