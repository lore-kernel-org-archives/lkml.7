Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E67AC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BE0217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561610741;
	bh=2LjnG9cl659T/Mb4Oo5zO5E1oC3kTmLxQ0BrquDnfMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cmHSd1xwqqlir1U0KdF0zEtUkdln/D9ukRqAB4Kl0EEenhLPI+jUEDhzFLvQdDF8c
	 y9BLfEfv6s5if4Gsl2vwE53nbD3gzwy1qxLa5z3gBnD+RQ0SrcqTaAlvLyHxMOihC9
	 IySOTp78Xolak90xc34Y/F+q9SEoszMRLDLcONh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfF0Epk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 00:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0EpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:45:14 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C08B621871;
        Thu, 27 Jun 2019 04:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561610713;
        bh=2LjnG9cl659T/Mb4Oo5zO5E1oC3kTmLxQ0BrquDnfMM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnRY3wzR8noX7uPCGnCyNytXU5ya5jr2DBT9tVXecewhcca7PLSVFwYODeL0V9dH6
         s4mRkV7loR8QTm3F/xrLYpGQyx/cYZHfpU/zV6jEdhViGSBzZ6dFi0bQkBi87rJN3w
         u9q6RSM8XBsEaFbK+3RCsrQ9oXo8He0WhKKgtnBU=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 3/8] x86/vsyscall: Show something useful on a read fault
Date:   Wed, 26 Jun 2019 21:45:04 -0700
Message-Id: <8016afffe0eab497be32017ad7f6f7030dc3ba66.1561610354.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561610354.git.luto@kernel.org>
References: <cover.1561610354.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Andy Lutomirski <luto@kernel.org>
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
-- 
2.21.0

