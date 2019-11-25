Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFB5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 03:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D610520815
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 03:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574654144;
	bh=513HjHQgO4ZinFCYqgbJc29Row103Q7nU6B7vvQYcjE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1TT7EqFvERdzR1TIKjB1AUOPr5R3UoCaETT3XKuZtqdxlJXZGrt3/zaKCq0PkBlLI
	 oFJcdy0W6namJDvs/8S9OInm5/nYix0X9ZWLm3wuRPlOEzTk0EENq3HVA+/1XZyUkz
	 4gYj3/kJAmKpcbqHy7vbd8CLPg64bICMsr6XYwno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfKYDzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 22:55:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbfKYDzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 22:55:42 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44A3F2071A;
        Mon, 25 Nov 2019 03:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574654140;
        bh=513HjHQgO4ZinFCYqgbJc29Row103Q7nU6B7vvQYcjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ibnWFTeRcAoMwg2qCFigKwa1BnVmKfKzrTjWuHsEjfh5ttaNXzvopy/WmZkmPhhMK
         AVFTc51m5X+AArlK7JDdY41MhURXq0B7S7WszYNTw4XNzS042SIAmrEwdmuUYk0IzR
         t9PrV+q2gYaGaHM+Gyo3erS5mVL4HYAsRDlP+bdg=
Date:   Mon, 25 Nov 2019 12:55:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 00/17] Rewrite x86/ftrace to use text_poke (and
 more)
Message-Id: <20191125125534.2aaaccf00c38a9a25dee623a@kernel.org>
In-Reply-To: <20191111131252.921588318@infradead.org>
References: <20191111131252.921588318@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I got a BUG in poke_int3_handler() on 8 threads qemu x86-64
while testing multi-probe testcase.
I couldn't reproduce it because maybe it is a timing bug.

(Sorry, since the terminal line-wrap is disabled, the last chars are overwritten)

BUG: kernel NULL pointer dereference, add8
[ 1475.147390] #PF: supervisor read access in kernel mode
[ 1475.148380] #PF: error_code(0x0000) - not-present page
[ 1475.149362] PGD 0 P4D 0 
[ 1475.149970] Oops: 0000 [#1] PREEMPT SMP PTI
[ 1475.150824] CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.4.0-rc6+ #19
[ 1475.151996] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a4
[ 1475.154078] RIP: 0010:poke_int3_handler+0x33/0x70
[ 1475.155008] Code: d2 75 04 31 c0 5b c3 f6 87 88 00 00 00 03 75 f3 48 8b 87 80 00 00 00 48 89 fb b
[ 1475.158308] RSP: 0018:ffffc900001a8c10 EFLAGS: 00010046
[ 1475.159345] RAX: 0000000000000000 RBX: ffffc900001a8c38 RCX: ffffffff81800b57
[ 1475.160653] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffff81026ec5
[ 1475.162032] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1475.163448] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 1475.164828] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1475.166180] FS:  0000000000000000(0000) GS:ffff88807d980000(0000) knlGS:0000000000000000
[ 1475.167876] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1475.169066] CR2: 0000000000000008 CR3: 000000000201e000 CR4: 00000000000006a0
[ 1475.170431] Call Trace:
[ 1475.171064]  <IRQ>
[ 1475.171609]  do_int3+0xd/0xf0
[ 1475.172302]  int3+0x42/0x50
[ 1475.173014] RIP: 0010:sched_clock+0x6/0x10
[ 1475.174061] Code: d3 ea f6 c1 40 48 0f 45 c2 4c 01 c0 65 ff 0d 99 ee fe 7e 74 02 5d c3 e8 f8 ad f
[ 1475.178461] RSP: 0018:ffffc900001a8d10 EFLAGS: 00000016
[ 1475.179475] RAX: 000001577e58ce4d RBX: ffff88807d261c00 RCX: 0000000000000000
[ 1475.180685] RDX: 0000000000000014 RSI: 0000000000000014 RDI: ffffffff82556180
[ 1475.181907] RBP: ffff88807d018600 R08: 000002ac502de60d R09: 0000000000000002
[ 1475.183213] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88807d261ce0
[ 1475.184365] R13: ffff88807d261d20 R14: 00000000000003e8 R15: 0000000000000002
[ 1475.185515]  ? sched_clock+0x6/0x10
[ 1475.186173]  trace_clock_local+0xc/0x20
[ 1475.186939]  ring_buffer_lock_reserve+0x10d/0x410
[ 1475.187797]  trace_event_buffer_lock_reserve+0x4a/0xf0
[ 1475.188740]  kprobe_trace_func+0x10e/0x370
[ 1475.189489]  ? sched_clock+0x6/0x10
[ 1475.190141]  kprobe_dispatcher+0x39/0x60
[ 1475.190911]  aggr_pre_handler+0x4c/0x90
[ 1475.191602]  ? sched_clock+0x5/0x10
[ 1475.192317]  kprobe_int3_handler+0x101/0x150
[ 1475.193133]  do_int3+0x36/0xf0
[ 1475.193697]  int3+0x42/0x50
[ 1475.194241] RIP: 0010:sched_clock+0x6/0x10
[ 1475.194947] Code: d3 ea f6 c1 40 48 0f 45 c2 4c 01 c0 65 ff 0d 99 ee fe 7e 74 02 5d c3 e8 f8 ad f
[ 1475.197612] RSP: 0018:ffffc900001a8fc8 EFLAGS: 00000012
[ 1475.198466] RAX: 000001577e58cc7f RBX: 0000000000000000 RCX: 0000000000000000
[ 1475.199511] RDX: 0000000000000014 RSI: 0000000000000014 RDI: ffffffff82556180
[ 1475.200552] RBP: 0000000000000000 R08: 000002ac502de274 R09: 0000000000000001
[ 1475.201641] R10: 0000000000000000 R11: ffff88807d1a9e58 R12: 0000000000000000
[ 1475.202804] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1475.203932]  ? sched_clock+0x6/0x10
[ 1475.204557]  ? sched_clock+0x5/0x10
[ 1475.205176]  sched_clock_cpu+0xe/0xd0
[ 1475.205830]  irq_exit+0xb3/0xc0
[ 1475.206512]  call_function_interrupt+0xf/0x20
[ 1475.207252]  </IRQ>
[ 1475.207714] RIP: 0010:default_idle+0x23/0x180
[ 1475.208449] Code: ff 90 90 90 90 90 90 41 55 41 54 55 53 e8 35 29 c7 ff 0f 1f 44 00 00 e8 8b af 5
[ 1475.211721] RSP: 0018:ffffc9000008feb8 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff03
[ 1475.213312] RAX: ffff88807d1a95c0 RBX: 0000000000000006 RCX: 0000000000000000
[ 1475.214687] RDX: 0000000000000046 RSI: 0000000000000006 RDI: ffff88807d1a95c0
[ 1475.216027] RBP: ffffffff8212da80 R08: 0000000000000001 R09: 0000000000000000
[ 1475.217399] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 1475.218867] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1475.220144]  ? default_idle+0x15/0x180
[ 1475.220929]  default_idle_call+0x26/0x30
[ 1475.221809]  do_idle+0x1fe/0x220
[ 1475.222695]  ? trace_hardirqs_on+0x2c/0xf0
[ 1475.223550]  cpu_startup_entry+0x14/0x20
[ 1475.224390]  start_secondary+0x152/0x180
[ 1475.225157]  secondary_startup_64+0xa4/0xb0
[ 1475.226011] Modules linked in: [last unloaded: trace_printk]
[ 1475.227028] CR2: 0000000000000008
[ 1475.227636] ---[ end trace 5d3d01238a02c9e8 ]---
[ 1475.228410] RIP: 0010:poke_int3_handler+0x33/0x70
[ 1475.229187] Code: d2 75 04 31 c0 5b c3 f6 87 88 00 00 00 03 75 f3 48 8b 87 80 00 00 00 48 89 fb b
[ 1475.232231] RSP: 0018:ffffc900001a8c10 EFLAGS: 00010046
[ 1475.233180] RAX: 0000000000000000 RBX: ffffc900001a8c38 RCX: ffffffff81800b57
[ 1475.234374] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffffff81026ec5
[ 1475.236003] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[ 1475.237818] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[ 1475.240007] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 1475.242493] FS:  0000000000000000(0000) GS:ffff88807d980000(0000) knlGS:0000000000000000
[ 1475.245272] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1475.247136] CR2: 0000000000000008 CR3: 000000000201e000 CR4: 00000000000006a0
[ 1475.249053] Kernel panic - not syncing: Fatal exception
[ 1475.250593] Kernel Offset: disabled
[ 1475.251459] ---[ end Kernel panic - not syncing: Fatal exception ]---

$ eu-addr2line -e ./vmlinux poke_int3_handler+0x33
arch/x86/kernel/alternative.c:996:6

-----
int poke_int3_handler(struct pt_regs *regs)
{
        struct text_poke_loc *tp;
        unsigned char int3 = 0xcc;
        void *ip;

        /*
         * Having observed our INT3 instruction, we now must observe
         * bp_patching.nr_entries.
         *
         *      nr_entries != 0                 INT3
         *      WMB                             RMB
         *      write INT3                      if (nr_entries)
         *
         * Idem for other elements in bp_patching.
         */
        smp_rmb();

        if (likely(!bp_patching.nr_entries))
                return 0;

        if (user_mode(regs))
                return 0;

        /*
         * Discount the sizeof(int3). See text_poke_bp_batch().
         */
        ip = (void *) regs->ip - sizeof(int3);

        /*
         * Skip the binary search if there is a single member in the vector.
         */
        if (unlikely(bp_patching.nr_entries > 1)) {
                tp = bsearch(ip, bp_patching.vec, bp_patching.nr_entries,
                             sizeof(struct text_poke_loc),
                             patch_cmp);
                if (!tp)
                        return 0;
        } else {
                tp = bp_patching.vec;
                if (tp->addr != ip)  /* !!!! <-- HERE !!!!! */
                        return 0;
        }

        /* set up the specified breakpoint detour */
        regs->ip = (unsigned long) tp->detour;

        return 1;
}
-----

This seems like caused by bp_patching.vec is NULL but 
bp_patching.nr_entries != 0. I think there is a small chance to do
this, because we have no smp_wmb after cleaning bp_patching.nr_entries.

-----
void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
...
        on_each_cpu(do_sync_core, NULL, 1);
        /*
         * sync_core() implies an smp_mb() and orders this store against
         * the writing of the new instruction.
         */
        bp_patching.vec = NULL;
        bp_patching.nr_entries = 0;
}
-----

I think the "on_each_cpu(do_sync_core, NULL, 1);" can sync the pipeline
but doesn't ensure all ongoing int3 handling is done. Thus, we may need a
bigger wait in between bp_patching.nr_entries = 0 and bp_patching.vec = NULL;
e.g.

	bp_patching.nr_entries = 0;
	synchronize_rcu();
	bp_patching.vec = NULL;

What would you think about ?

Thank you,

On Mon, 11 Nov 2019 14:12:52 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Ftrace is one of the last W^X violators (after this only KLP is left). These
> patches move it over to the generic text_poke() interface and thereby get rid
> of this oddity.
> 
> The first 14 patches are the same as in the -v4 posting. The last 3 patches are
> new.
> 
> Will, patch 13, arm/ftrace, is unchanged. This is because this way it preserves
> behaviour, but if you can provide me a tested-by for the simpler variant I can
> drop that in.
> 
> Patch 15 reworks ftrace's event_create_dir(), which ran module code before the
> module was finished loading (before we even applied jump_labels and all that).
> 
> Patch 16 and 17 address minor review feedback.
> 
> Ingo, Alexei wants patch #1 for some BPF stuff, can he get that in a topic branch?
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
