Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9A9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC1220718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575297575;
	bh=YUmDWz1wBXQI817i3iQnVe6r0SPThZopJaC3WTAs9z4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Q4eWQJDPT4nT7XM7LG+B9ljV/g9uhWlLStW6qPMqV2mb2mBMP/Pl9ghJSVOEhMrei
	 EWykm7ssTKgzeAHImPsSxb8TfjTs4SZmKHFwevaND619TlgweNCgvwvd0Yd1mfkiBT
	 735Sa6hz5gAw/oZ5vCGWWVweZR3pYL+Tj4JiNkEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfLBOje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:39:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:37710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfLBOjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:39:33 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD02D20833;
        Mon,  2 Dec 2019 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575297573;
        bh=YUmDWz1wBXQI817i3iQnVe6r0SPThZopJaC3WTAs9z4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SkhUjq4tOpzq+2gpqVrg2aFPo7eCcVDK3ibQLw7yjjTjU8JD6Jj8mPdd5sPt+u5I4
         g5D4mljBas6FRJ+/SD2/21xB8ejtyth6Y99dxwnlR9c/HmgEp+aEj5pF45pRE3OPjH
         1nZCPheuz6RgMhqU4PswpBR9x8c4fm+vdFhAHzVM=
Date:   Mon, 2 Dec 2019 23:39:27 +0900
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
Message-Id: <20191202233927.1f85f6967fc8d784be329fe4@kernel.org>
In-Reply-To: <20191202134354.GF2827@hirez.programming.kicks-ass.net>
References: <157483420094.25881.9190014521050510942.stgit@devnote2>
        <157483421229.25881.15314414408559963162.stgit@devnote2>
        <20191202091519.GA2827@hirez.programming.kicks-ass.net>
        <20191202205012.8109bf98b649f38cdcd1e535@kernel.org>
        <20191202134354.GF2827@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 14:43:54 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Dec 02, 2019 at 08:50:12PM +0900, Masami Hiramatsu wrote:
> > On Mon, 2 Dec 2019 10:15:19 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Wed, Nov 27, 2019 at 02:56:52PM +0900, Masami Hiramatsu wrote:
> 
> > > > --- a/arch/x86/kernel/alternative.c
> > > > +++ b/arch/x86/kernel/alternative.c
> > > > @@ -1134,8 +1134,14 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
> > > >  	 * sync_core() implies an smp_mb() and orders this store against
> > > >  	 * the writing of the new instruction.
> > > >  	 */
> > > > -	bp_patching.vec = NULL;
> > > >  	bp_patching.nr_entries = 0;
> > > > +	/*
> > > > +	 * This sync_core () ensures that all int3 handlers in progress
> > > > +	 * have finished. This allows poke_int3_handler () after this to
> > > > +	 * avoid touching bp_paching.vec by checking nr_entries == 0.
> > > > +	 */
> > > > +	text_poke_sync();
> > > > +	bp_patching.vec = NULL;
> > > >  }
> > > 
> > > Hurm.. is there no way we can merge that with the 'last'
> > > text_poke_sync() ? It seems a little daft to do 2 back-to-back IPI
> > > things like that.
> > 
> > Maybe we can add a NULL check of bp_patchig.vec in poke_int3_handler()
> > but it doesn't ensure the fundamental safeness, because the array
> > pointed by bp_patching.vec itself can be released while
> > poke_int3_handler() accesses it.
> 
> No, what I mean is something like:
> 
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 30e86730655c..347a234a7c52 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1119,17 +1119,13 @@ static void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries
>  	 * Third step: replace the first byte (int3) by the first byte of
>  	 * replacing opcode.
>  	 */
> -	for (do_sync = 0, i = 0; i < nr_entries; i++) {
> +	for (i = 0; i < nr_entries; i++) {
>  		if (tp[i].text[0] == INT3_INSN_OPCODE)
>  			continue;
>  
>  		text_poke(text_poke_addr(&tp[i]), tp[i].text, INT3_INSN_SIZE);
> -		do_sync++;
>  	}
>  
> -	if (do_sync)
> -		text_poke_sync();
> -
>  	/*
>  	 * sync_core() implies an smp_mb() and orders this store against
>  	 * the writing of the new instruction.
> 
> 
> Or is that unsafe ?

OK, let's check it. 

text_poke_bp_batch() {
  update vec
  update nr_entries
  smp_wmb()
  write int3
  text_poke_sync()
  write rest_bytes
  text_poke_sync() if rest_bytes
  write first_byte
  text_poke_sync() if first_byte ... (*)
  update nr_entries
  text_poke_sync() ... (**)
  update vec
}

Before (*), the first byte can be new opcode or int3, thus
poke_int3_handler() can be called. But anyway, at that point
nr_entries != 0, thus poke_int3_handler() correctly emulate
the new instruction.

Before (**), all int3 should be removed, so nr_entries must
not accessed, EXCEPT for writing int3 case.

If we just remove the (*) as you say, the poke_int3_handler()
can see nr_entries = 0 before (**). So it is still unsafe.

I considered another way that skipping (**) if !first_byte,
since (*) ensured the target address(text) doesn't hit int3
anymore.
However, this will be also unsafe because there can be another
int3 (by kprobes) has been hit while updating nr_entries and vec.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
