Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC07C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9542082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbfDCQmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:42:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42035 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbfDCQml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:42:41 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hBiyA-0004GO-Ou; Wed, 03 Apr 2019 18:42:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 27/27] x86/pkeys: add PKRU value to init_fpstate
Date:   Wed,  3 Apr 2019 18:41:56 +0200
Message-Id: <20190403164156.19645-28-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403164156.19645-1-bigeasy@linutronix.de>
References: <20190403164156.19645-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task's initiall PKRU value is set part for fpu__clear()/
copy_init_pkru_to_fpregs(). It is not part of init_fpstate.xsave and
instead it is set explictly.
If the user removes the PKRU state from XSAVE in the signal handler then
__fpu__restore_sig() will restore the missing bits from `init_fpstate'
and initialize the PKRU value to 0.

Add the `init_pkru_value' to `init_fpstate' so it is set to the init
value in such a case.

In theory we could drop copy_init_pkru_to_fpregs() because restoring the
PKRU at return-to-userland should be enough.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/kernel/cpu/common.c | 5 +++++
 arch/x86/mm/pkeys.c          | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index cb28e98a0659a..352fa19e63110 100644
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
index 2ecbf4155f98f..1dcfc91c8f0c3 100644
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
 
-- 
2.20.1

