Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6F3C73C53
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE472073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Y0zN9yHm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfGIUtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:49:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46027 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728967AbfGIUtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:49:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x69KnMFZ2095414
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 9 Jul 2019 13:49:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x69KnMFZ2095414
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562705362;
        bh=4ZFAtzVv67eL6ESakFjgoESffTd0dKZX43rSsrS2QdY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Y0zN9yHmOdjYmBYOvTR4IriWpkJu3kt0xOr48yWuQn5GELNUQ17i7TKMphf4vXoNI
         7Eb7DlRan+42foKUhwAhHvaYgKshmU4mACau9cZqqKaKqJChvd3m3CqNR79gfqzhhd
         0YJErX7jR7H/nmIhaxlKr7uoTq67O/LZirYT67bF0Nqq24iR3pPv/ha/51rNgPEoco
         sgNmQ4rdjVg+BAj+zGnTL+P9SI2J/S7FgHwmxmB+GKeth1Xco8FJ/NrnGW3UhDCJHz
         FYlPkk/zEfk3Jjm/ZGkumsjFuZF7gVO0fFKr7veEn7kT5FgSLT9YixlKjUOLPwo2l3
         VIL3H6soLHdAQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x69KnLkF2095411;
        Tue, 9 Jul 2019 13:49:21 -0700
Date:   Tue, 9 Jul 2019 13:49:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-ecc606103837b98a2b665e8f14e533a6c72bbdc0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, rong.a.chen@intel.com, luto@kernel.org,
        jpoimboe@redhat.com
Reply-To: peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          luto@kernel.org, jpoimboe@redhat.com, hpa@zytor.com,
          rong.a.chen@intel.com
In-Reply-To: <20190709125744.GB3402@hirez.programming.kicks-ass.net>
References: <20190709125744.GB3402@hirez.programming.kicks-ass.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/alternatives: Fix int3_emulate_call() selftest
 stack corruption
Git-Commit-ID: ecc606103837b98a2b665e8f14e533a6c72bbdc0
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

Commit-ID:  ecc606103837b98a2b665e8f14e533a6c72bbdc0
Gitweb:     https://git.kernel.org/tip/ecc606103837b98a2b665e8f14e533a6c72bbdc0
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 8 Jul 2019 15:55:30 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 9 Jul 2019 22:39:15 +0200

x86/alternatives: Fix int3_emulate_call() selftest stack corruption

KASAN shows the following splat during boot:

  BUG: KASAN: unknown-crash in unwind_next_frame+0x3f6/0x490
  Read of size 8 at addr ffffffff84007db0 by task swapper/0

  CPU: 0 PID: 0 Comm: swapper Tainted: G                T 5.2.0-rc6-00013-g7457c0d #1
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
  Call Trace:
   dump_stack+0x19/0x1b
   print_address_description+0x1b0/0x2b2
   __kasan_report+0x10f/0x171
   kasan_report+0x12/0x1c
   __asan_load8+0x54/0x81
   unwind_next_frame+0x3f6/0x490
   unwind_next_frame+0x1b/0x23
   arch_stack_walk+0x68/0xa5
   stack_trace_save+0x7b/0xa0
   save_trace+0x3c/0x93
   mark_lock+0x1ef/0x9b1
   lock_acquire+0x122/0x221
   __mutex_lock+0xb6/0x731
   mutex_lock_nested+0x16/0x18
   _vm_unmap_aliases+0x141/0x183
   vm_unmap_aliases+0x14/0x16
   change_page_attr_set_clr+0x15e/0x2f2
   set_memory_4k+0x2a/0x2c
   check_bugs+0x11fd/0x1298
   start_kernel+0x793/0x7eb
   x86_64_start_reservations+0x55/0x76
   x86_64_start_kernel+0x87/0xaa
   secondary_startup_64+0xa4/0xb0

  Memory state around the buggy address:
   ffffffff84007c80: 00 00 00 00 00 00 00 00 00 00 00 00 00 f1 f1 f1
   ffffffff84007d00: f1 00 00 00 00 00 00 00 00 00 f2 f2 f2 f3 f3 f3
  >ffffffff84007d80: f3 79 be 52 49 79 be 00 00 00 00 00 00 00 00 f1

It turns out that int3_selftest() is corrupting the stack.  The problem is
that the KASAN-ified version of int3_magic() is much less trivial than the
C code appears.  It clobbers several unexpected registers.  So when the
selftest's INT3 is converted to an emulated call to int3_magic(), the
registers are clobbered and Bad Things happen when the function returns.

Fix this by converting int3_magic() to the trivial ASM function it should
be, avoiding all calling convention issues. Also add ASM_CALL_CONSTRAINT to
the INT3 ASM, since it contains a 'CALL'.

[peterz: cribbed changelog from josh]

Fixes: 7457c0da024b ("x86/alternatives: Add int3_emulate_call() selftest")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Debugged-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20190709125744.GB3402@hirez.programming.kicks-ass.net
---
 arch/x86/kernel/alternative.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 99ef8b6f9a1a..ccd32013c47a 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -625,10 +625,23 @@ extern struct paravirt_patch_site __start_parainstructions[],
  *
  * See entry_{32,64}.S for more details.
  */
-static void __init int3_magic(unsigned int *ptr)
-{
-	*ptr = 1;
-}
+
+/*
+ * We define the int3_magic() function in assembly to control the calling
+ * convention such that we can 'call' it from assembly.
+ */
+
+extern void int3_magic(unsigned int *ptr); /* defined in asm */
+
+asm (
+"	.pushsection	.init.text, \"ax\", @progbits\n"
+"	.type		int3_magic, @function\n"
+"int3_magic:\n"
+"	movl	$1, (%" _ASM_ARG1 ")\n"
+"	ret\n"
+"	.size		int3_magic, .-int3_magic\n"
+"	.popsection\n"
+);
 
 extern __initdata unsigned long int3_selftest_ip; /* defined in asm below */
 
@@ -676,7 +689,9 @@ static void __init int3_selftest(void)
 		      "int3_selftest_ip:\n\t"
 		      __ASM_SEL(.long, .quad) " 1b\n\t"
 		      ".popsection\n\t"
-		      : : __ASM_SEL_RAW(a, D) (&val) : "memory");
+		      : ASM_CALL_CONSTRAINT
+		      : __ASM_SEL_RAW(a, D) (&val)
+		      : "memory");
 
 	BUG_ON(val != 1);
 
