Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D20CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683E820684
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lb+r+yCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfJUJWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:22:32 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54196 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfJUJWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:22:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A0scbkaqHhEh8rvyWJWor/5edVTtxyhXMs8x1A+/lKQ=; b=Lb+r+yCu6S7QyMLyVhmPphsls
        ANciRLCm+5uPZkne6QUTcuxqQrSBpipkQXCcIIjo7YhFdpP5CI4QtJLkxnG53cOU6jUTj593gZUL+
        16aSxAzpv64+MG5lidtvxgei9zFkloV/VrefG37Z55aOWSGI/TBUFqCM2MXz2OkEa+iPRnQmNDgm7
        FLcpFRfYz9g1USdo/wn6Q4C+RkR9prz+sbVF2HS7B/5+ygo5DJ2CGGAyl0n181jPpVYC+noGKfw0u
        7fBQaHATwZ+z8/7HAU05XlAxLb8oEMueOXzFY07hRJ3sh20nq2Ndo9mjfa78fDduMGUIc375U7kAi
        TFxfi5oKQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iMTt5-0001Hg-JU; Mon, 21 Oct 2019 09:22:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F2F5A300EBF;
        Mon, 21 Oct 2019 11:21:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 063AB2022BA0B; Mon, 21 Oct 2019 11:21:59 +0200 (CEST)
Date:   Mon, 21 Oct 2019 11:21:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 03/16] x86/alternatives,jump_label: Provide better
 text_poke() batching interface
Message-ID: <20191021092158.GA1800@hirez.programming.kicks-ass.net>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.113249026@infradead.org>
 <20191021084802.GA825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021084802.GA825@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 10:48:02AM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > --- a/arch/x86/kernel/jump_label.c
> > +++ b/arch/x86/kernel/jump_label.c
> > @@ -35,18 +35,19 @@ static void bug_at(unsigned char *ip, in
> >  	BUG();
> >  }
> >  
> > -static void __jump_label_set_jump_code(struct jump_entry *entry,
> > -				       enum jump_label_type type,
> > -				       union jump_code_union *code,
> > -				       int init)
> > +static const void *
> > +__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
> >  {
> > +	static union jump_code_union code; /* relies on text_mutex */
> >  	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
> >  	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
> >  	const void *expect;
> >  	int line;
> >  
> > -	code->jump = 0xe9;
> > -	code->offset = jump_entry_target(entry) -
> > +	lockdep_assert_held(&text_mutex);
> > +
> > +	code.jump = JMP32_INSN_OPCODE;
> > +	code.offset = jump_entry_target(entry) -
> >  		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
> >  
> >  	if (init) {
> > @@ -54,23 +55,23 @@ static void __jump_label_set_jump_code(s
> >  	} else if (type == JUMP_LABEL_JMP) {
> >  		expect = ideal_nop; line = __LINE__;
> >  	} else {
> > -		expect = code->code; line = __LINE__;
> > +		expect = code.code; line = __LINE__;
> 
> Side note: the whole 'line' logic looked weird to me and it obsfuscates 
> the logic a bit, and I had to look it up to see what it's about: 
> improving the debug output of text-patching crashes.
> 
> How about something like the below on top of your queue? We have %phD 
> that can nicely print instructions in hex.

I have a patch like that somewhere; see here:

  https://lkml.kernel.org/r/20191007090012.00469193.6@infradead.org

But yes, the __LINE__ thing is mostly about identifying which case it is
and I suppose we can infer that when we have the expected text printed
too.
