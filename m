Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDE0C43215
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB2C217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 11:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575287421;
	bh=JCqRIvUHvskG+t8P+5JbP/x+BH9wFM/SMZhqSCgg/bU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uDpgc0Z0PQqkcIS9VnMOey3XeWQOvJTJY4GQkNOwjbWH+7hIx5pccWUywDmO0HLd9
	 oNoGWpgSLQHv1zxPIYxx5JHxIDNk2POEbt8CTBePEZXf/hWFz5rfzdZIspVhPH4DhR
	 Rm4N47Bj9P0QP3jhUSWYZ29ar6QtJ7qww/IN6iQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfLBLuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 06:50:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbfLBLuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 06:50:19 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C6E6217D7;
        Mon,  2 Dec 2019 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575287418;
        bh=JCqRIvUHvskG+t8P+5JbP/x+BH9wFM/SMZhqSCgg/bU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xf8ZElth+OaFX6+uqXMY6t+/fwPDf+W1sFs7Jj/g8FWorAyyc1PeukpBvNQ3qYyEb
         4j8zmwRMkxYrBgOJ8GWmPUk0D2dyz4KCN2FlWEBbdqG2DbT53BRqwDbhICjHgp0P7d
         qL5dkSWkP+gRdW/D2c5hXw8R7SW3Rz5giSqKn0Z0=
Date:   Mon, 2 Dec 2019 20:50:12 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, namit@vmware.com, hpa@zytor.com,
        luto@kernel.org, ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        jeyu@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH -tip 1/2] x86/alternative: Sync bp_patching update for
 avoiding NULL pointer exception
Message-Id: <20191202205012.8109bf98b649f38cdcd1e535@kernel.org>
In-Reply-To: <20191202091519.GA2827@hirez.programming.kicks-ass.net>
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
        <157483421229.25881.15314414408559963162.stgit@devnote2>
        <20191202091519.GA2827@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 10:15:19 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Nov 27, 2019 at 02:56:52PM +0900, Masami Hiramatsu wrote:
> > ftracetest multiple_kprobes.tc testcase hit a following NULL pointer
> > exception.
> > 
> > BUG: kernel NULL pointer dereference, address: 0000000000000000
> > #PF: supervisor read access in kernel mode
> > #PF: error_code(0x0000) - not-present page
> > PGD 800000007bf60067 P4D 800000007bf60067 PUD 7bf5f067 PMD 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 6 PID: 0 Comm: swapper/6 Not tainted 5.4.0-rc8+ #23
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:poke_int3_handler+0x39/0x100
> > Code: 5b 5d c3 f6 87 88 00 00 00 03 75 f2 48 8b 87 80 00 00 00 48 89 fb 48 8d 68 ff 48 8b 05 80 98 72 01 83 fa 01 0f 8f 93 00 00 00 <48> 63 10 48 81 c2 00 00 00 81 48 39 d5 75 c5 0f b6 50 08 8d 4a 34
> > RSP: 0018:ffffc900001a8eb8 EFLAGS: 00010046
> > RAX: 0000000000000000 RBX: ffffc900001a8ee8 RCX: ffffffff81a00b57
> > RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffffc900001a8ee8
> > RBP: ffffffff81027635 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> > FS:  0000000000000000(0000) GS:ffff88807d980000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000000000000 CR3: 000000007a970000 CR4: 00000000000006a0
> > Call Trace:
> >  <IRQ>
> >  do_int3+0xd/0xf0
> >  int3+0x42/0x50
> > RIP: 0010:sched_clock+0x6/0x10
> > 
> > eu-addr2line told that poke_int3_handler+0x39 was alternatives:958.
> > 
> > static inline void *text_poke_addr(struct text_poke_loc *tp)
> > {
> >         return _stext + tp->rel_addr; <------ Here is line #958
> > }
> > 
> > This seems like caused by the tp (bp_patching.vec) was NULL but
> > bp_patching.nr_entries != 0. There is a small chance to do
> > this, because we have no sync after zeroing bp_patching.nr_entries
> > before clearing bp_patching.vec.
> > 
> > Steve suggested we could fix this by adding sync_core, because int3
> > is done with interrupts disabled, and the on_each_cpu() requires
> > all CPUs to have had their interrupts enabled.
> > 
> > Fixes: c0213b0ac03c ("x86/alternative: Batch of patch operations")
> > Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  arch/x86/kernel/alternative.c |    8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> > index 4552795a8df4..9505096e2cd1 100644
> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> > @@ -1134,8 +1134,14 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
> >  	 * sync_core() implies an smp_mb() and orders this store against
> >  	 * the writing of the new instruction.
> >  	 */
> > -	bp_patching.vec = NULL;
> >  	bp_patching.nr_entries = 0;
> > +	/*
> > +	 * This sync_core () ensures that all int3 handlers in progress
> > +	 * have finished. This allows poke_int3_handler () after this to
> > +	 * avoid touching bp_paching.vec by checking nr_entries == 0.
> > +	 */
> > +	text_poke_sync();
> > +	bp_patching.vec = NULL;
> >  }
> 
> Hurm.. is there no way we can merge that with the 'last'
> text_poke_sync() ? It seems a little daft to do 2 back-to-back IPI
> things like that.

Maybe we can add a NULL check of bp_patchig.vec in poke_int3_handler()
but it doesn't ensure the fundamental safeness, because the array
pointed by bp_patching.vec itself can be released while
poke_int3_handler() accesses it.

When I hit similar issue on unregister_kprobe, I used synchronize_rcu()
to ensure all cores passed scheduler once. This can avoid sending IPI
but will take a longer time.

Thank you,
-- 
Masami Hiramatsu <mhiramat@kernel.org>
