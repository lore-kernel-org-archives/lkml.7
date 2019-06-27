Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8FEC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88E25208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B32g3G2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfF0WO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:14:57 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51731 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfF0WO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:14:56 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5RMEaDF472501
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 15:14:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5RMEaDF472501
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561673677;
        bh=TdcGloUbyqQ/luaBLnxjyqNVk1Xv5mfcOZdI2GjSl9k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=B32g3G2Yd+wiCKIQPHLOHe3hxw9UvMBN2Xaz87Sax9h4oTZlTEk92++PRfDKuqGvb
         kRgBVrqnCV8IpGGlKElKdXqc7Am75osIRQWCg2vE8b1mqzvOuujpUt4JpL9S1CIhzP
         b2IkCXyAtKKgvGZLZ/WaFyhxilfx6SgrSewbyAMJUCi7mGEyajrsiQaxow7E9loT/b
         zz6Gt3Eq0HfrcM/Sxs6wGVHmQP4hlY17mH+gZbhBjN52kV6Fd7Lagxi0vBUc8/jna1
         xNa7SOuOAXiD0YMx98/mUfLVAn0s2dCm3UuVZCgE+yvtE9SQvr/DPjun5JjI9W7A41
         Tf3AKIIWfej4Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5RMEakm472493;
        Thu, 27 Jun 2019 15:14:36 -0700
Date:   Thu, 27 Jun 2019 15:14:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-918ce325098a4eef99daad7b6796da33cebaf03a@git.kernel.org>
Cc:     keescook@chromium.org, tglx@linutronix.de, mingo@kernel.org,
        luto@kernel.org, fweimer@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, jannh@google.com
Reply-To: luto@kernel.org, mingo@kernel.org, fweimer@redhat.com,
          keescook@chromium.org, tglx@linutronix.de, jannh@google.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <8016afffe0eab497be32017ad7f6f7030dc3ba66.1561610354.git.luto@kernel.org>
References: <8016afffe0eab497be32017ad7f6f7030dc3ba66.1561610354.git.luto@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/entry] x86/vsyscall: Show something useful on a read fault
Git-Commit-ID: 918ce325098a4eef99daad7b6796da33cebaf03a
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

Commit-ID:  918ce325098a4eef99daad7b6796da33cebaf03a
Gitweb:     https://git.kernel.org/tip/918ce325098a4eef99daad7b6796da33cebaf03a
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 26 Jun 2019 21:45:04 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 00:04:39 +0200

x86/vsyscall: Show something useful on a read fault

Just segfaulting the application when it tries to read the vsyscall page in
xonly mode is not helpful for those who need to debug it.

Emit a hint.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jann Horn <jannh@google.com>
Link: https://lkml.kernel.org/r/8016afffe0eab497be32017ad7f6f7030dc3ba66.1561610354.git.luto@kernel.org

---
 arch/x86/entry/vsyscall/vsyscall_64.c | 19 ++++++++++++++++++-
 arch/x86/include/asm/vsyscall.h       |  6 ++++--
 arch/x86/mm/fault.c                   | 11 +++++------
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index fedd7628f3a6..9c58ab807aeb 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -117,7 +117,8 @@ static bool write_ok_or_segv(unsigned long ptr, size_t size)
 	}
 }
 
-bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
+bool emulate_vsyscall(unsigned long error_code,
+		      struct pt_regs *regs, unsigned long address)
 {
 	struct task_struct *tsk;
 	unsigned long caller;
@@ -126,6 +127,22 @@ bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	long ret;
 	unsigned long orig_dx;
 
+	/* Write faults or kernel-privilege faults never get fixed up. */
+	if ((error_code & (X86_PF_WRITE | X86_PF_USER)) != X86_PF_USER)
+		return false;
+
+	if (!(error_code & X86_PF_INSTR)) {
+		/* Failed vsyscall read */
+		if (vsyscall_mode == EMULATE)
+			return false;
+
+		/*
+		 * User code tried and failed to read the vsyscall page.
+		 */
+		warn_bad_vsyscall(KERN_INFO, regs, "vsyscall read attempt denied -- look up the vsyscall kernel parameter if you need a workaround");
+		return false;
+	}
+
 	/*
 	 * No point in checking CS -- the only way to get here is a user mode
 	 * trap to a high address, which means that we're in 64-bit user code.
diff --git a/arch/x86/include/asm/vsyscall.h b/arch/x86/include/asm/vsyscall.h
index b986b2ca688a..ab60a71a8dcb 100644
--- a/arch/x86/include/asm/vsyscall.h
+++ b/arch/x86/include/asm/vsyscall.h
@@ -13,10 +13,12 @@ extern void set_vsyscall_pgtable_user_bits(pgd_t *root);
  * Called on instruction fetch fault in vsyscall page.
  * Returns true if handled.
  */
-extern bool emulate_vsyscall(struct pt_regs *regs, unsigned long address);
+extern bool emulate_vsyscall(unsigned long error_code,
+			     struct pt_regs *regs, unsigned long address);
 #else
 static inline void map_vsyscall(void) {}
-static inline bool emulate_vsyscall(struct pt_regs *regs, unsigned long address)
+static inline bool emulate_vsyscall(unsigned long error_code,
+				    struct pt_regs *regs, unsigned long address)
 {
 	return false;
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 46df4c6aae46..288a5462076f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1369,16 +1369,15 @@ void do_user_addr_fault(struct pt_regs *regs,
 
 #ifdef CONFIG_X86_64
 	/*
-	 * Instruction fetch faults in the vsyscall page might need
-	 * emulation.  The vsyscall page is at a high address
-	 * (>PAGE_OFFSET), but is considered to be part of the user
-	 * address space.
+	 * Faults in the vsyscall page might need emulation.  The
+	 * vsyscall page is at a high address (>PAGE_OFFSET), but is
+	 * considered to be part of the user address space.
 	 *
 	 * The vsyscall page does not have a "real" VMA, so do this
 	 * emulation before we go searching for VMAs.
 	 */
-	if ((hw_error_code & X86_PF_INSTR) && is_vsyscall_vaddr(address)) {
-		if (emulate_vsyscall(regs, address))
+	if (is_vsyscall_vaddr(address)) {
+		if (emulate_vsyscall(hw_error_code, regs, address))
 			return;
 	}
 #endif
