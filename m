Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56928C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C167206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k/bGgghB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731346AbfJINIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:08:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbfJINIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:08:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=psCz/V/MzUX3gC4qKnQonY+IERGktWH5zpYXs9h8XnE=; b=k/bGgghBwVpOEwqLq/iPSoR8v
        WOC1U64zzo3YVPWtLmTo+e9XHIPkHkCY+7FUfzXRFT8VSXJC9CAjEijK4pXAQAUAywFcaTHLTG73f
        UBtRckgkvgE3yOcUSwXzuKO/GjoVBNrBfYwbRf6DfqbBRYAGEHpbyWXIzM+YEEkFmZ+7zptJFtiU+
        UzvjOq/eItqjKhyXbvq+Qo8ry5VzqWLHaPeJxNt8yHKgA+IQAKJP+bYGWahHJVDpPzeaUJGZie051
        i2DilMcWC/hIdoiaDzMbKG1CAU4HRjLFopyTcFUn0oHxh8bqbS9+1BHktGHgIOvHy0Lbt/0d/tZ1g
        W+svUKQUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iIBh6-0000Mx-7W; Wed, 09 Oct 2019 13:07:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 460D030034F;
        Wed,  9 Oct 2019 15:07:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12B442009B59E; Wed,  9 Oct 2019 15:07:54 +0200 (CEST)
Date:   Wed, 9 Oct 2019 15:07:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        paulmck@kernel.org
Subject: x86/kprobes bug? (was: [PATCH 1/3] x86/alternatives: Teach
 text_poke_bp() to emulate instructions)
Message-ID: <20191009130754.GL2311@hirez.programming.kicks-ass.net>
References: <20190827180622.159326993@infradead.org>
 <20190827181147.053490768@infradead.org>
 <20191003140050.1d4cf59d3de8b5396d36c269@kernel.org>
 <20191003082751.GQ4536@hirez.programming.kicks-ass.net>
 <20191003110106.GI4581@hirez.programming.kicks-ass.net>
 <20191004224540.766dc0fd824bcd5b8baa2f4c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191004224540.766dc0fd824bcd5b8baa2f4c@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 10:45:40PM +0900, Masami Hiramatsu wrote:

> > > > >  	text_poke_bp(op->kp.addr, insn_buff, RELATIVEJUMP_SIZE,
> > > > > -		     op->optinsn.insn);
> > > > > +		     emulate_buff);
> > > > >  }
> > > 
> > > As argued in a previous thread, text_poke_bp() is broken when it changes
> > > more than a single instruction at a time.
> > > 
> > > Now, ISTR optimized kprobes does something like:
> > > 
> > > 	poke INT3
> > 
> > Hmm, it does this using text_poke(), but lacks a
> > on_each_cpu(do_sync_core, NULL, 1), which I suppose is OK-ish IFF you do
> > that synchronize_rcu_tasks() after it, but less so if you don't.
> > 
> > That is, without either, you can't really tell if the kprobe is in
> > effect or not.
> 
> Yes, it doesn't wait the change by design at this moment.

Right, this might surprise some, I suppose, and I might've found a small
issue with it, see below.

> > > 	synchronize_rcu_tasks() /* waits for all tasks to schedule
> > > 				   guarantees instructions after INT3
> > > 				   are unused */
> > > 	install optimized probe /* overwrites multiple instrctions with
> > > 				   JMP.d32 */
> > > 
> > > And the above then undoes that by:
> > > 
> > > 	poke INT3 on top of the optimzed probe
> > > 
> > > 	poke tail instructions back /* guaranteed safe because the
> > > 				       above INT3 poke ensures the
> > > 				       JMP.d32 instruction is unused */
> > > 
> > > 	poke head byte back
> 
> Yes, anyway, the last poke should recover another INT3... (for kprobe)

It does indeed.

> > > Is this correct? If so, we should probably put a comment in there
> > > explaining how all this is unusual but safe.

So from what I can tell of kernel/kprobes.c, what it does is something like:

ARM: (__arm_kprobe)
	text_poke(INT3)
	/* guarantees nothing, INT3 will become visible at some point, maybe */

     (kprobe_optimizer)
	if (opt) {
		/* guarantees the bytes after INT3 are unused */
		syncrhonize_rcu_tasks();
		text_poke_bp(JMP32);
		/* implies IPI-sync, kprobe really is enabled */
	}


DISARM: (__unregister_kprobe_top)
	if (opt) {
		text_poke_bp(INT3 + tail);
		/* implies IPI-sync, so tail is guaranteed visible */
	}
	text_poke(old);


FREE: (__unregister_kprobe_bottom)
	/* guarantees 'old' is visible and the kprobe really is unused, maybe */
	synchronize_rcu();
	free();


Now the problem is that I don't think the synchronize_rcu() at free
implies enough to guarantee 'old' really is visible on all CPUs.
Similarly, I don't think synchronize_rcu_tasks() is sufficient on the
ARM side either. It only provides the guarantee -provided- the INT3 is
actually visible. If it is not, all bets are off.

I'd feel much better if we switch arch_arm_kprobe() over to using
text_poke_bp(). Or at the very least add the on_each_cpu(do_sync_core)
to it.

Hmm?
