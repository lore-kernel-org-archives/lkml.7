Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EADCC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5FD2080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574762298;
	bh=VQ6DHtDuaMkWXBtNGCYuAWsTdiEVCg3E+bilhqJObyI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=flZ/istugsFZ78hLPSc0oKqLg3Os355S9kbi15o2Ynd7lWbWNSgXlWGhtHbfWAFj/
	 V7ibbdc5PlfMFCPZdArGcEDxd9Z+GR8F5sXgfK3oVzZUrU1UYQ256+apFig/Nn64I6
	 twvPtJU7Q569fs2j+ZoiGj8JOdlgWVJRFxJDCIPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfKZJ6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:58:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:57102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727397AbfKZJ6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:58:16 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2799F2075C;
        Tue, 26 Nov 2019 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574762295;
        bh=VQ6DHtDuaMkWXBtNGCYuAWsTdiEVCg3E+bilhqJObyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yOsI1BvQkjTb6Ogq+eBWkRRNgMOMJL10IuHF9/SO6lhfqPuXDvd8uo1GwQbAJsDw1
         k6UORNiYYHS1johBlxD1fnf3/cuvTfyFI3jCYoWN04cDMttEr9ox3FdXljc45v2eG8
         gC9mhTJx3Mgq1tuE0IGxdfHRVWT0z6sUM5u9L4ro=
Date:   Tue, 26 Nov 2019 18:58:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and
 more)
Message-Id: <20191126185809.91574fb8eb02f3b2dd3af863@kernel.org>
In-Reply-To: <20191126175812.c6e0cd1249422989007c91fe@kernel.org>
References: <20191111131252.921588318@infradead.org>
        <20191125125534.2aaaccf00c38a9a25dee623a@kernel.org>
        <20191125123245.5ae9cb60@gandalf.local.home>
        <20191126091104.5e0cdc61e3b143fae4ed4cfd@kernel.org>
        <20191126175812.c6e0cd1249422989007c91fe@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2019 17:58:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:
> Oops, I've tested a bit older kernel (with above change it seems to be fixed).
> I'll check the latest -tip.

Oops, it is reproduced.

+ wc -l
+ L=256
+ [ 256 -ne 256 ]
+ echo 1
[   75.852865] BUG: kernel NULL pointer dereference, address: 0000000000000000
[   75.855004] #PF: supervisor read access in kernel mode
[   75.856579] #PF: error_code(0x0000) - not-present page
[   75.858541] PGD 800000007bf60067 P4D 800000007bf60067 PUD 7bf5f067 PMD 0 
[   75.861420] Oops: 0000 [#1] PREEMPT SMP PTI
[   75.863008] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.4.0-rc8+ #23
[   75.864881] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
[   75.870225] RIP: 0010:poke_int3_handler+0x39/0x100
[   75.871672] Code: 5b 5d c3 f6 87 88 00 00 00 03 75 f2 48 8b 87 80 00 00 00 48 89 fb 48 8d 68 ff 48 8b 05 80 98 72 01 83 fa 01 0f 8f 93 00 00 00 <48> 63 10 48 81 c2 00 00 00 81 48 39 d5 75 c5 0f b6 50 08 8d 4a 34
[   75.877927] RSP: 0018:ffffc900001a8eb8 EFLAGS: 00010046
[   75.879794] RAX: 0000000000000000 RBX: ffffc900001a8ee8 RCX: ffffffff81a00b57
[   75.881717] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffc900001a8ee8
[   75.883632] RBP: ffffffff81027635 R08: 0000000000000000 R09: 0000000000000000
[   75.885494] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   75.887360] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   75.889299] FS:  0000000000000000(0000) GS:ffff88807d980000(0000) knlGS:0000000000000000
[   75.891668] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   75.893657] CR2: 0000000000000000 CR3: 000000007a970000 CR4: 00000000000006a0
[   75.895307] Call Trace:
[   75.896126]  <IRQ>
[   75.897191]  do_int3+0xd/0xf0
[   75.898710]  int3+0x42/0x50
[   75.900306] RIP: 0010:sched_clock+0x6/0x10
[   75.901410] Code: d3 ea f6 c1 40 48 0f 45 c2 4c 01 c0 65 ff 0d 29 07 ff 7e 74 02 5d c3 e8 f0 a7 fd ff 5d c3 66 0f 1f 44 00 00 e8 ab f6 01 00 cc <90> c3 0f 1f 84 00 00 00 00 00 48 81 3d dd e5 21 01 c0 6f 02 81 0f
[   75.905389] RSP: 0018:ffffc900001a8fc8 EFLAGS: 00000016
[   75.906591] RAX: 00000011b208c72d RBX: 0000000000000000 RCX: 0000000000000000
[   75.908690] RDX: 0000000000000004 RSI: 0000000000000004 RDI: ffffffff8275d180
[   75.911009] RBP: 0000000000000000 R08: 0000002354a2e063 R09: 0000000000000001
[   75.912981] R10: 0000000000000000 R11: ffff88807d1a9f18 R12: 0000000000000000
[   75.914629] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   75.916351]  ? sched_clock+0x6/0x10
[   75.917475]  ? sched_clock+0x5/0x10
[   75.918742]  sched_clock_cpu+0xe/0xd0
[   75.920304]  irq_exit+0xb3/0xc0
[   75.921634]  call_function_interrupt+0xf/0x20
[   75.922918]  </IRQ>
[   75.923987] RIP: 0010:default_idle+0x23/0x180
[   75.925386] Code: ff cc cc cc cc cc cc 41 55 41 54 55 53 e8 45 e8 c6 ff 0f 1f 44 00 00 e8 3b 25 95 ff e9 07 00 00 00 0f 00 2d 41 fd 5f 00 fb f4 <e8> 28 e8 c6 ff 89 c5 0f 1f 44 00 00 5b 5d 41 5c 41 5d c3 65 8b 05
[   75.931117] RSP: 0018:ffffc9000008feb8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff03
[   75.933490] RAX: ffff88807d1a9680 RBX: 0000000000000006 RCX: 0000000000000000
[   75.935047] RDX: 0000000000000046 RSI: 0000000000000006 RDI: ffff88807d1a9680
[   75.936602] RBP: ffffffff8233dbc0 R08: 0000000000000001 R09: 0000000000000000
[   75.938136] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   75.939726] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   75.941784]  ? default_idle+0x15/0x180
[   75.943147]  default_idle_call+0x26/0x30
[   75.944539]  do_idle+0x1fe/0x220
[   75.945618]  ? trace_hardirqs_on+0x2c/0xf0
[   75.946699]  cpu_startup_entry+0x14/0x20
[   75.948054]  start_secondary+0x152/0x180
[   75.949257]  secondary_startup_64+0xb6/0xc0
[   75.950287] Modules linked in: [last unloaded: trace_printk]
[   75.951927] CR2: 0000000000000000
[   75.953002] ---[ end trace f347ec44ad8fffbb ]---
[   75.954322] RIP: 0010:poke_int3_handler+0x39/0x100
[   75.956041] Code: 5b 5d c3 f6 87 88 00 00 00 03 75 f2 48 8b 87 80 00 00 00 48 89 fb 48 8d 68 ff 48 8b 05 80 98 72 01 83 fa 01 0f 8f 93 00 00 00 <48> 63 10 48 81 c2 00 00 00 81 48 39 d5 75 c5 0f b6 50 08 8d 4a 34
[   75.960386] RSP: 0018:ffffc900001a8eb8 EFLAGS: 00010046
[   75.961904] RAX: 0000000000000000 RBX: ffffc900001a8ee8 RCX: ffffffff81a00b57
[   75.964994] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffc900001a8ee8
[   75.966836] RBP: ffffffff81027635 R08: 0000000000000000 R09: 0000000000000000
[   75.968460] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   75.972194] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[   75.973849] FS:  0000000000000000(0000) GS:ffff88807d980000(0000) knlGS:0000000000000000
[   75.976592] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   75.978447] CR2: 0000000000000000 CR3: 000000007a970000 CR4: 00000000000006a0
[   75.980548] Kernel panic - not syncing: Fatal exception
[   75.982294] Kernel Offset: disabled
[   75.983427] ---[ end Kernel panic - not syncing: Fatal exception ]---
QEMU: Terminated
mhiramat@devnote2:~/ksrc/mincs$ cd work/linux/build-x86_64/
mhiramat@devnote2:~/ksrc/mincs/work/linux/build-x86_64$ eu-addr2line -e ./vmlinux poke_int3_handler+0x39
/home/mhiramat/ksrc/mincs/work/linux/linux/arch/x86/kernel/alternative.c:958:20

static inline void *text_poke_addr(struct text_poke_loc *tp)
{
        return _stext + tp->rel_addr; <------ Here is line #958
}

I applied following patch, but it seems not enough. While disabling 256 kprobes,
system was frozen (no BUG message).

Thank you,

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 4552795a8df4..9505096e2cd1 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1134,8 +1134,14 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
 	 * sync_core() implies an smp_mb() and orders this store against
 	 * the writing of the new instruction.
 	 */
-	bp_patching.vec = NULL;
 	bp_patching.nr_entries = 0;
+	/*
+	 * This sync_core () ensures that all int3 handlers in progress
+	 * have finished. This allows poke_int3_handler () after this to
+	 * avoid touching bp_paching.vec by checking nr_entries == 0.
+	 */
+	text_poke_sync();
+	bp_patching.vec = NULL;
 }
 
 void text_poke_loc_init(struct text_poke_loc *tp, void *addr,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
