Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB417CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B499E20B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 10:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPP45qct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbfJVKbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 06:31:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55250 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731761AbfJVKbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 06:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oGXqvKq/gQw1kFy1CCcjXeG012Q/MaLJgKwZFIYOTZE=; b=gPP45qct/5tRq4RjHiYFllSvM
        S8xyheu9OWbqubuOu6qzB6tZ2nQWIdtouaUs7/ZakFH8cLU5cRwCXbBX6hPfe6Y0pVPJZyzHE/fdD
        JOEPnObZJEczzLTdvPZrM/bZWkCyC/yFOjIQ11EF9epkv7zU5KP+YpWwHGGsQ2JxAwkmzyYCYVpVS
        Jsyu9aBKjgB5cvR5xhcr4E0HxECsRRiskRQMpogvTIgEgnIMxCMp/eLfvS5XLgW3M78oeO0qq5VDF
        2e+byrwbIltwgDI1fGXVWTaGWnzRLgv2AgR8M7+csvikbv5aqNJjsA56MXoxkI7QyYoHXLFQBeQsG
        3Z4WV+icQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMrRp-0000B3-SC; Tue, 22 Oct 2019 10:31:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 65528300489;
        Tue, 22 Oct 2019 12:30:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E4FA120420870; Tue, 22 Oct 2019 12:31:26 +0200 (CEST)
Date:   Tue, 22 Oct 2019 12:31:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        paulmck@kernel.org, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 12/16] x86/kprobes: Fix ordering
Message-ID: <20191022103126.GN1817@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.629386219@infradead.org>
 <20191022103521.3015bc5e128cd68fa645013c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022103521.3015bc5e128cd68fa645013c@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:35:21AM +0900, Masami Hiramatsu wrote:
> On Fri, 18 Oct 2019 09:35:37 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Kprobes does something like:
> > 
> > register:
> > 	arch_arm_kprobe()
> > 	  text_poke(INT3)
> >           /* guarantees nothing, INT3 will become visible at some point, maybe */
> > 
> >         kprobe_optimizer()
> > 	  /* guarantees the bytes after INT3 are unused */
> > 	  syncrhonize_rcu_tasks();
> > 	  text_poke_bp(JMP32);
> > 	  /* implies IPI-sync, kprobe really is enabled */
> > 
> > 
> > unregister:
> > 	__disarm_kprobe()
> > 	  unoptimize_kprobe()
> > 	    text_poke_bp(INT3 + tail);
> > 	    /* implies IPI-sync, so tail is guaranteed visible */
> >           arch_disarm_kprobe()
> >             text_poke(old);
> > 	    /* guarantees nothing, old will maybe become visible */
> > 
> > 	synchronize_rcu()
> > 
> >         free-stuff
> 
> Note that this is only for the case of optimized kprobe.
> (On some probe points we can not optimize it)

Of course..

> > Now the problem is that on register, the synchronize_rcu_tasks() does
> > not imply sufficient to guarantee all CPUs have already observed INT3
> > (although in practise this is exceedingly unlikely not to have
> > happened) (similar to how MEMBARRIER_CMD_PRIVATE_EXPEDITED does not
> > imply MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE).
> 
> OK, so the sync_core() after int3 is needed to guarantee the probe
> is enabled on each core.

Indeed, AFAIU the old instruction can stay in I$ or micro-ops caches
which are not (fully) cache coherent.

So without forcing a serializing instruction (CPUID, CR3 write, etc..)
there is no guarantee.

> > Worse, even if it did, we'd have to do 2 synchronize calls to provide
> > the guarantee we're looking for, the first to ensure INT3 is visible,
> > the second to guarantee nobody is then still using the instruction
> > bytes after INT3.
> 
> I think this 2nd guarantee is done by syncrhonize_rcu() if we
> put sync_core() after int3. syncrhonize_rcu() ensures that
> all cores once scheduled and all interrupts have done.

Right, with IPI it all works, without IPI it might be that the INT3 is
still visible when we start synchronize_rcu() and thereby violate the
RCU guarantees.

> > --- a/arch/x86/kernel/kprobes/opt.c
> > +++ b/arch/x86/kernel/kprobes/opt.c
> > @@ -444,14 +444,10 @@ void arch_optimize_kprobes(struct list_h
> >  /* Replace a relative jump with a breakpoint (int3).  */
> >  void arch_unoptimize_kprobe(struct optimized_kprobe *op)
> >  {
> > -	u8 insn_buff[JMP32_INSN_SIZE];
> > -
> > -	/* Set int3 to first byte for kprobes */
> > -	insn_buff[0] = INT3_INSN_OPCODE;
> > -	memcpy(insn_buff + 1, op->optinsn.copied_insn, DISP32_SIZE);
> > -
> > -	text_poke_bp(op->kp.addr, insn_buff, JMP32_INSN_SIZE,
> > -		     text_gen_insn(JMP32_INSN_OPCODE, op->kp.addr, op->optinsn.insn));
> > +	arch_arm_kprobe(&op->kp);
> > +	text_poke(op->kp.addr + INT3_INSN_SIZE,
> > +		  op->optinsn.copied_insn, DISP32_SIZE);
> > +	text_poke_sync();
> >  }
> 
> For this part, I thought it was same as what text_poke_bp() does.
> But, indeed, this looks better (simpler & lighter) than using
> text_poke_bp()...

Indeed. The reason I wrote it as such is that now the
text_poke_bp(.emulate) argument is unused, which I can go remove in a
future patch.

The whole reason I went looking here is that I was going to write a
comment on how this was correct; it seems I've still to do that..

/me adds the two entries to the TODO list.

> So, in total, this looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!
