Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4040C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8C520859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560198356;
	bh=LM7HCsspgClDyFFU9bfxU7yzdejIvcxPP+NiHgQckcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s0Db+lcO3/sLtk5b3bbgd07vYcbsstrm74s0TmvJwtgQ5GOTvxarfNLSukqn8mPAA
	 bwRpM7BhC/KZChBj+uG1ETXu8zaIMEclMII/Pb4C+bbwZAlYd09T/2bHc90zGYh+K2
	 ktuD+tmQ2VwwOv5gxNeHvnfOM4U9PcDXLAduSvIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389681AbfFJUZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:25:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389337AbfFJUZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:25:39 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D1C320870;
        Mon, 10 Jun 2019 20:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560198338;
        bh=LM7HCsspgClDyFFU9bfxU7yzdejIvcxPP+NiHgQckcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I8Qst0XkJgfUaO8LzI2g6QMlQK40vtFmOk9iX8piYgY3znc2GBX5zapAxY8+VSby1
         er8N0zjs4qZiJ1iXJjl+z/70r1/g5ufTQlgWFPMtpJuAcDX8LUIZqlPcAtjiYn0FQ9
         SAwge416WEwQLarrpZEoFvxWOqk9s4uNE8Lmh9yo=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/5] x86/vsyscall: Document odd #PF's error code for vsyscalls
Date:   Mon, 10 Jun 2019 13:25:29 -0700
Message-Id: <d28856fff74a385f88c493dafb9d96d2c38d91a2.1560198181.git.luto@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560198181.git.luto@kernel.org>
References: <cover.1560198181.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if vsyscall=none, we report uer page faults on the vsyscall
page as though the PROT bit in the error code was set.  Add a
comment explaining why this is probably okay and display the value
in the test case.

While we're at it, explain why our behavior is correct with respect
to PKRU.

If anyone really cares about more accurate emulation, we could
change the behavior.

Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c                         | 7 +++++++
 tools/testing/selftests/x86/test_vsyscall.c | 9 ++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 46df4c6aae46..1b18819e8e11 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -710,6 +710,10 @@ static void set_signal_archinfo(unsigned long address,
 	 * To avoid leaking information about the kernel page
 	 * table layout, pretend that user-mode accesses to
 	 * kernel addresses are always protection faults.
+	 *
+	 * NB: This means that failed vsyscalls with vsyscall=none
+	 * will have the PROT bit.  This doesn't leak any
+	 * information and does not appear to cause any problems.
 	 */
 	if (address >= TASK_SIZE_MAX)
 		error_code |= X86_PF_PROT;
@@ -1376,6 +1380,9 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 *
 	 * The vsyscall page does not have a "real" VMA, so do this
 	 * emulation before we go searching for VMAs.
+	 *
+	 * PKRU never rejects instruction fetches, so we don't need
+	 * to consider the PF_PK bit.
 	 */
 	if ((hw_error_code & X86_PF_INSTR) && is_vsyscall_vaddr(address)) {
 		if (emulate_vsyscall(regs, address))
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 0b4f1cc2291c..4c9a8d76dba0 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -183,9 +183,13 @@ static inline long sys_getcpu(unsigned * cpu, unsigned * node,
 }
 
 static jmp_buf jmpbuf;
+static volatile unsigned long segv_err;
 
 static void sigsegv(int sig, siginfo_t *info, void *ctx_void)
 {
+	ucontext_t *ctx = (ucontext_t *)ctx_void;
+
+	segv_err =  ctx->uc_mcontext.gregs[REG_ERR];
 	siglongjmp(jmpbuf, 1);
 }
 
@@ -416,8 +420,11 @@ static int test_vsys_r(void)
 	} else if (!can_read && should_read_vsyscall) {
 		printf("[FAIL]\tWe don't have read access, but we should\n");
 		return 1;
+	} else if (can_read) {
+		printf("[OK]\tWe have read access\n");
 	} else {
-		printf("[OK]\tgot expected result\n");
+		printf("[OK]\tWe do not have read access: #PF(0x%lx)\n",
+		       segv_err);
 	}
 #endif
 
-- 
2.21.0

