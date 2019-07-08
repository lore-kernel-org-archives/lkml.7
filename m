Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90954C606D1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAFF2173E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 20:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405212AbfGHU5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 16:57:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfGHU5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 16:57:06 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B7B730C1320;
        Mon,  8 Jul 2019 20:56:57 +0000 (UTC)
Received: from treble.redhat.com (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D22565C25D;
        Mon,  8 Jul 2019 20:56:53 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <rong.a.chen@intel.com>
Subject: [PATCH] x86/alternatives: Fix int3_emulate_call() selftest stack corruption
Date:   Mon,  8 Jul 2019 15:55:30 -0500
Message-Id: <1a859cba4db356852b20222ebe056b38c6a6e963.1562619299.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 08 Jul 2019 20:57:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN shows the following splat during boot:

  BUG: KASAN: unknown-crash in unwind_next_frame+0x3f6/0x490
  Read of size 8 at addr ffffffff84007db0 by task swapper/0

  CPU: 0 PID: 0 Comm: swapper Tainted: G                T 5.2.0-rc6-00013-g7457c0d #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
  Call Trace:
   dump_stack+0x19/0x1b
   print_address_description+0x1b0/0x2b2
   ? unwind_next_frame+0x3f6/0x490
   __kasan_report+0x10f/0x171
   ? unwind_next_frame+0x3f6/0x490
   kasan_report+0x12/0x1c
   __asan_load8+0x54/0x81
   unwind_next_frame+0x3f6/0x490
   ? unwind_dump+0x24e/0x24e
   unwind_next_frame+0x1b/0x23
   ? create_prof_cpu_mask+0x20/0x20
   arch_stack_walk+0x68/0xa5
   ? set_memory_4k+0x2a/0x2c
   stack_trace_save+0x7b/0xa0
   ? stack_trace_consume_entry+0x89/0x89
   save_trace+0x3c/0x93
   mark_lock+0x1ef/0x9b1
   ? sched_clock_local+0x86/0xa6
   __lock_acquire+0x3ba/0x1bea
   ? __asan_loadN+0xf/0x11
   ? mark_held_locks+0x8e/0x8e
   ? mark_lock+0xb4/0x9b1
   ? sched_clock_local+0x86/0xa6
   lock_acquire+0x122/0x221
   ? _vm_unmap_aliases+0x141/0x183
   __mutex_lock+0xb6/0x731
   ? _vm_unmap_aliases+0x141/0x183
   ? sched_clock_cpu+0xac/0xb1
   ? __mutex_add_waiter+0xae/0xae
   ? lock_downgrade+0x368/0x368
   ? _vm_unmap_aliases+0x40/0x183
   mutex_lock_nested+0x16/0x18
   _vm_unmap_aliases+0x141/0x183
   ? _vm_unmap_aliases+0x40/0x183
   vm_unmap_aliases+0x14/0x16
   change_page_attr_set_clr+0x15e/0x2f2
   ? __set_pages_p+0x111/0x111
   ? alternative_instructions+0xd8/0x118
   ? arch_init_ideal_nops+0x181/0x181
   set_memory_4k+0x2a/0x2c
   check_bugs+0x11fd/0x1298
   ? l1tf_cmdline+0x1dc/0x1dc
   ? proc_create_single_data+0x5f/0x6e
   ? cgroup_init+0x2b1/0x2f6
   start_kernel+0x793/0x7eb
   ? thread_stack_cache_init+0x2e/0x2e
   ? idt_setup_early_handler+0x70/0xb1
   x86_64_start_reservations+0x55/0x76
   x86_64_start_kernel+0x87/0xaa
   secondary_startup_64+0xa4/0xb0

  Memory state around the buggy address:
   ffffffff84007c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
   ffffffff84007d00: f1 00 00 00 00 00 00 00 00 00 f2 f2 f2 f3 f3 f3
  >ffffffff84007d80: f3 79 be 52 49 79 be 00 00 00 00 00 00 00 00 f1

It turns out that int3_selftest() is corrupting the stack.  The problem
is that the KASAN-ified version of int3_magic() is much less trivial
than the C code appears.  It clobbers several unexpected registers.  So
when the selftest's INT3 is converted to an emulated call to
int3_magic(), the registers are clobbered and Bad Things happen when the
function returns.

Fix it by adding all the caller-saved registers to the inline asm
clobbers list.

Reported-by: kernel test robot <rong.a.chen@intel.com>
Fixes: 7457c0da024b ("x86/alternatives: Add int3_emulate_call() selftest")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/alternative.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 99ef8b6f9a1a..2644a7b82f96 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -651,6 +651,13 @@ int3_exception_notify(struct notifier_block *self, unsigned long val, void *data
 	return NOTIFY_STOP;
 }
 
+#ifdef CONFIG_X86_32
+# define INT3_TEST_CLOBBERS "memory", "cc", "ecx", "edx"
+#else
+# define INT3_TEST_CLOBBERS "memory", "cc", "rax", "rcx", "rdx", "rsi", "r8", \
+			    "r9", "r10", "r11"
+#endif
+
 static void __init int3_selftest(void)
 {
 	static __initdata struct notifier_block int3_exception_nb = {
@@ -676,7 +683,7 @@ static void __init int3_selftest(void)
 		      "int3_selftest_ip:\n\t"
 		      __ASM_SEL(.long, .quad) " 1b\n\t"
 		      ".popsection\n\t"
-		      : : __ASM_SEL_RAW(a, D) (&val) : "memory");
+		      : : __ASM_SEL_RAW(a, D) (&val) : INT3_TEST_CLOBBERS);
 
 	BUG_ON(val != 1);
 
-- 
2.20.1

