Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81DBC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96877205F4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEerKJ/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfJHOtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:49:00 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41516 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJHOs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WUifg8s41/H2ktYAnF9JcK1UUwDPde5AduPaiCDkcVU=; b=oEerKJ/dubC7IVAosFqcr6x5n
        oDGjQJUDvMem+7Pa9fuah/Bp9SbDSOEwYqAYOEaHZQLF4m3wagn/CxnETpL9819jJXvNfrU7k2z34
        eSr1g6CNsyE7wtOY0+3sIjSq8OLDIKf4LdAsIQEG2aZ4GegOjTTUwZzkt1iQu1qP0F1HJ7hlnv8L/
        XCeoYnkUyfGCKQc8fCybbmTU3yfrxC/klav7B4+skNXM609A+Vya7AwAhR8xRjEDbco7dcITv+r/u
        hZYzWtS9YtNd4K1kELshnDqdIqhVF1X592LnmgQJV6xe0CXEEERW9ID41mMHkjtsEJl5du2gHHA7X
        MJQe47amQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHqmz-0001k0-4k; Tue, 08 Oct 2019 14:48:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 95E3E30034F;
        Tue,  8 Oct 2019 16:47:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED8792020725C; Tue,  8 Oct 2019 16:48:34 +0200 (CEST)
Date:   Tue, 8 Oct 2019 16:48:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com
Subject: Re: [PATCH v3 1/6] x86/alternatives: Teach text_poke_bp() to emulate
 instructions
Message-ID: <20191008144834.GD2328@hirez.programming.kicks-ass.net>
References: <20191007081716.07616230.8@infradead.org>
 <20191007081944.88332264.2@infradead.org>
 <20191008142924.GE14765@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008142924.GE14765@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 04:29:24PM +0200, Borislav Petkov wrote:
> On Mon, Oct 07, 2019 at 10:17:17AM +0200, Peter Zijlstra wrote:

> > @@ -63,8 +66,17 @@ static inline void int3_emulate_jmp(stru
> >  	regs->ip = ip;
> >  }
> >  
> > -#define INT3_INSN_SIZE 1
> > -#define CALL_INSN_SIZE 5
> > +#define INT3_INSN_SIZE		1
> > +#define INT3_INSN_OPCODE	0xCC
> > +
> > +#define CALL_INSN_SIZE		5
> > +#define CALL_INSN_OPCODE	0xE8
> > +
> > +#define JMP32_INSN_SIZE		5
> > +#define JMP32_INSN_OPCODE	0xE9
> > +
> > +#define JMP8_INSN_SIZE		2
> > +#define JMP8_INSN_OPCODE	0xEB
> 
> You probably should switch those to have the name prefix come first and
> make them even shorter:
> 
> OPCODE_CALL
> INSN_SIZE_CALL
> OPCODE_JMP32
> INSN_SIZE_JMP32
> OPCODE_JMP8
> ...
> 
> This way you have the opcodes prefixed with OPCODE_ and the insn sizes
> with INSN_SIZE_. I.e., what they actually are.

I really don't like that; the important part is which instruction and
that really should come first. Also, your variant is horribly
inconsistent.

> > --- a/arch/x86/kernel/alternative.c
> > +++ b/arch/x86/kernel/alternative.c
> 
> ...
> 
> > @@ -1027,9 +1046,9 @@ NOKPROBE_SYMBOL(poke_int3_handler);
> >   */
> >  void text_poke_bp_batch(struct text_poke_loc *tp, unsigned int nr_entries)
> >  {
> > -	int patched_all_but_first = 0;
> > -	unsigned char int3 = 0xcc;
> > +	unsigned char int3 = INT3_INSN_OPCODE;
> >  	unsigned int i;
> > +	int do_sync;
> >  
> >  	lockdep_assert_held(&text_mutex);
> >  
> > @@ -1053,16 +1072,16 @@ void text_poke_bp_batch(struct text_poke
> >  	/*
> >  	 * Second step: update all but the first byte of the patched range.
> >  	 */
> > -	for (i = 0; i < nr_entries; i++) {
> > +	for (do_sync = 0, i = 0; i < nr_entries; i++) {
> >  		if (tp[i].len - sizeof(int3) > 0) {
> >  			text_poke((char *)tp[i].addr + sizeof(int3),
> > -				  (const char *)tp[i].opcode + sizeof(int3),
> > +				  (const char *)tp[i].text + sizeof(int3),
> >  				  tp[i].len - sizeof(int3));
> > -			patched_all_but_first++;
> > +			do_sync++;
> >  		}
> >  	}
> >  
> > -	if (patched_all_but_first) {
> > +	if (do_sync) {
> >  		/*
> >  		 * According to Intel, this core syncing is very likely
> >  		 * not necessary and we'd be safe even without it. But
> > @@ -1075,10 +1094,17 @@ void text_poke_bp_batch(struct text_poke
> >  	 * Third step: replace the first byte (int3) by the first byte of
> >  	 * replacing opcode.
> >  	 */
> > -	for (i = 0; i < nr_entries; i++)
> > -		text_poke(tp[i].addr, tp[i].opcode, sizeof(int3));
> > +	for (do_sync = 0, i = 0; i < nr_entries; i++) {
> 
> Can we have the do_sync reset outside of the loop?

Can, but why? That's more lines for no raisin ;-)

> > +		if (tp[i].text[0] == INT3_INSN_OPCODE)
> > +			continue;
> 
> I'm guessing we preset the 0th byte to 0xcc somewhere.... I just can't
> seem to find it...

Very first pass, we write INT3's everywhere.
