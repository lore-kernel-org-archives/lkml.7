Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E35C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FED9218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354913;
	bh=Vxn6kEK8V6CTO6SqayJzf9iM2FuaFlfub7/w9Wd5qqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zTMWlnVzfV8CmIGdJJkc3XKSqVqERDFU+a1Z4WOf13wbrL7g7drJDfSkkksRLdqAL
	 7iUu7izbWrC50H1edXdW2Mr0/mk6n/n+KG1Hwhowa4Mf9ZzzJraKNBBlH4C5BONlhH
	 Sozqki4fjUt6Iv46cNVpjRZNvXMK09J4jxBXWatA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfDOTBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728126AbfDOTBt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:01:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 965DC20880;
        Mon, 15 Apr 2019 19:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354909;
        bh=Vxn6kEK8V6CTO6SqayJzf9iM2FuaFlfub7/w9Wd5qqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v533fLOoB3sJxBlV//i+7QK05PuuAXauQy+2OHygPscjFCZDA5iMgPlJ49SSXZ8Ns
         Xyp2ln7nMQu1AEBFiXb4aaAJJca1mqfvIoG9a/jPemebnbq7t9iL8zPMzj5k9p+KLA
         zxWfLnNzJfv2QCBSSYL5MshWVYrbnjmUaRhmZzFc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 02/69] x86/power: Fix some ordering bugs in __restore_processor_context()
Date:   Mon, 15 Apr 2019 20:58:20 +0200
Message-Id: <20190415183726.624072882@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5b06bbcfc2c621da3009da8decb7511500c293ed ]

__restore_processor_context() had a couple of ordering bugs.  It
restored GSBASE after calling load_gs_index(), and the latter can
call into tracing code.  It also tried to restore segment registers
before restoring the LDT, which is straight-up wrong.

Reorder the code so that we restore GSBASE, then the descriptor
tables, then the segments.

This fixes two bugs.  First, it fixes a regression that broke resume
under certain configurations due to irqflag tracing in
native_load_gs_index().  Second, it fixes resume when the userspace
process that initiated suspect had funny segments.  The latter can be
reproduced by compiling this:

// SPDX-License-Identifier: GPL-2.0
/*
 * ldt_echo.c - Echo argv[1] while using an LDT segment
 */

int main(int argc, char **argv)
{
	int ret;
	size_t len;
	char *buf;

	const struct user_desc desc = {
                .entry_number    = 0,
                .base_addr       = 0,
                .limit           = 0xfffff,
                .seg_32bit       = 1,
                .contents        = 0, /* Data, grow-up */
                .read_exec_only  = 0,
                .limit_in_pages  = 1,
                .seg_not_present = 0,
                .useable         = 0
        };

	if (argc != 2)
		errx(1, "Usage: %s STRING", argv[0]);

	len = asprintf(&buf, "%s\n", argv[1]);
	if (len < 0)
		errx(1, "Out of memory");

	ret = syscall(SYS_modify_ldt, 1, &desc, sizeof(desc));
	if (ret < -1)
		errno = -ret;
	if (ret)
		err(1, "modify_ldt");

	asm volatile ("movw %0, %%es" :: "rm" ((unsigned short)7));
	write(1, buf, len);
	return 0;
}

and running ldt_echo >/sys/power/mem

Without the fix, the latter causes a triple fault on resume.

Fixes: ca37e57bbe0c ("x86/entry/64: Add missing irqflags tracing to native_load_gs_index()")
Reported-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lkml.kernel.org/r/6b31721ea92f51ea839e79bd97ade4a75b1eeea2.1512057304.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/power/cpu.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index 04d5157fe7f8..a51d2dfb57d1 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -228,8 +228,20 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	load_idt((const struct desc_ptr *)&ctxt->idt_limit);
 #endif
 
+#ifdef CONFIG_X86_64
 	/*
-	 * segment registers
+	 * We need GSBASE restored before percpu access can work.
+	 * percpu access can happen in exception handlers or in complicated
+	 * helpers like load_gs_index().
+	 */
+	wrmsrl(MSR_GS_BASE, ctxt->gs_base);
+#endif
+
+	fix_processor_context();
+
+	/*
+	 * Restore segment registers.  This happens after restoring the GDT
+	 * and LDT, which happen in fix_processor_context().
 	 */
 #ifdef CONFIG_X86_32
 	loadsegment(es, ctxt->es);
@@ -250,13 +262,14 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	load_gs_index(ctxt->gs);
 	asm volatile ("movw %0, %%ss" :: "r" (ctxt->ss));
 
+	/*
+	 * Restore FSBASE and user GSBASE after reloading the respective
+	 * segment selectors.
+	 */
 	wrmsrl(MSR_FS_BASE, ctxt->fs_base);
-	wrmsrl(MSR_GS_BASE, ctxt->gs_base);
 	wrmsrl(MSR_KERNEL_GS_BASE, ctxt->gs_kernel_base);
 #endif
 
-	fix_processor_context();
-
 	do_fpu_end();
 	tsc_verify_tsc_adjust(true);
 	x86_platform.restore_sched_clock_state();
-- 
2.19.1



