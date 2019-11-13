Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8C6C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9DA206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611119;
	bh=yK1zw7+ztDz/wY5Xfb41Gx3AS89+UUsmCgSojd7FXaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qd3IVbePeI0GwT7hYjdlvkFt7h7OOghTXmRAZAmAvtZP8cPU89Vhqmv1FEcc8jiM1
	 wgWEUzFFgpNZXFitOCvUa2YH2aPN2mbsoKUh5BptQrHRtEo25wotCuVEuw9zU2pwlk
	 Z2CyYsNUKqGz86szLQRz51+Ft4/c76Py+V6/ijgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbfKMCL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:11:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbfKMB6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:58:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD3982245A;
        Wed, 13 Nov 2019 01:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610314;
        bh=yK1zw7+ztDz/wY5Xfb41Gx3AS89+UUsmCgSojd7FXaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+rdSH8qyF4nS660MNtAMaT/JqBxVQvbqvqp0XpPlERdKiInMU67IsY8V+uOx+kYY
         vomvvFHr55YD+7ZuFDHlflt65NuPx0snfxasG7QS6dkMhQYbOXDWkPDdathCXAG1x6
         967XoD9ylldBEpAbjzM8F77e/90CKSJU4l2JUupg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 080/115] x86/fsgsbase/64: Fix ptrace() to read the FS/GS base accurately
Date:   Tue, 12 Nov 2019 20:55:47 -0500
Message-Id: <20191113015622.11592-80-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

[ Upstream commit 07e1d88adaaeab247b300926f78cc3f950dbeda3 ]

On 64-bit kernels ptrace can read the FS/GS base using the register access
APIs (PTRACE_PEEKUSER, etc.) or PTRACE_ARCH_PRCTL.

Make both of these mechanisms return the actual FS/GS base.

This will improve debuggability by providing the correct information
to ptracer such as GDB.

[ chang: Rebased and revised patch description. ]
[ mingo: Revised the changelog some more. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/1537312139-5580-2-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/ptrace.c | 62 +++++++++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 584cdd475bb31..734549492a18b 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -40,6 +40,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/traps.h>
 #include <asm/syscall.h>
+#include <asm/mmu_context.h>
 
 #include "tls.h"
 
@@ -343,6 +344,49 @@ static int set_segment_reg(struct task_struct *task,
 	return 0;
 }
 
+static unsigned long task_seg_base(struct task_struct *task,
+				   unsigned short selector)
+{
+	unsigned short idx = selector >> 3;
+	unsigned long base;
+
+	if (likely((selector & SEGMENT_TI_MASK) == 0)) {
+		if (unlikely(idx >= GDT_ENTRIES))
+			return 0;
+
+		/*
+		 * There are no user segments in the GDT with nonzero bases
+		 * other than the TLS segments.
+		 */
+		if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
+			return 0;
+
+		idx -= GDT_ENTRY_TLS_MIN;
+		base = get_desc_base(&task->thread.tls_array[idx]);
+	} else {
+#ifdef CONFIG_MODIFY_LDT_SYSCALL
+		struct ldt_struct *ldt;
+
+		/*
+		 * If performance here mattered, we could protect the LDT
+		 * with RCU.  This is a slow path, though, so we can just
+		 * take the mutex.
+		 */
+		mutex_lock(&task->mm->context.lock);
+		ldt = task->mm->context.ldt;
+		if (unlikely(idx >= ldt->nr_entries))
+			base = 0;
+		else
+			base = get_desc_base(ldt->entries + idx);
+		mutex_unlock(&task->mm->context.lock);
+#else
+		base = 0;
+#endif
+	}
+
+	return base;
+}
+
 #endif	/* CONFIG_X86_32 */
 
 static unsigned long get_flags(struct task_struct *task)
@@ -436,18 +480,16 @@ static unsigned long getreg(struct task_struct *task, unsigned long offset)
 
 #ifdef CONFIG_X86_64
 	case offsetof(struct user_regs_struct, fs_base): {
-		/*
-		 * XXX: This will not behave as expected if called on
-		 * current or if fsindex != 0.
-		 */
-		return task->thread.fsbase;
+		if (task->thread.fsindex == 0)
+			return task->thread.fsbase;
+		else
+			return task_seg_base(task, task->thread.fsindex);
 	}
 	case offsetof(struct user_regs_struct, gs_base): {
-		/*
-		 * XXX: This will not behave as expected if called on
-		 * current or if fsindex != 0.
-		 */
-		return task->thread.gsbase;
+		if (task->thread.gsindex == 0)
+			return task->thread.gsbase;
+		else
+			return task_seg_base(task, task->thread.gsindex);
 	}
 #endif
 	}
-- 
2.20.1

