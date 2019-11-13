Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C67C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302E9214E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2+1bnPxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfKMIyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:54:16 -0500
Received: from merlin.infradead.org ([205.233.59.134]:35386 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfKMIyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:54:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RaCx47cvCZ3gcezdlD/Dad0dV4W4cXz9wXVsioplrco=; b=2+1bnPxqWfCh7UXKKlS+DkuKJ
        HFjbw/MgjtvPnbICzMza/x6ejytciGFsiTL/ZoC5mUCxpky2a1TxKLpkHEQ7KFty74RRyJWlpEexc
        0Wbae5iCgRUAAMSIES1Acnh55KQa92E3pRvnfuq+qAxgxMmYkoRJKLr1n65XvsknJR+Ow/PLrQ+rt
        fEml2S2uDQjbm31H61Qq9QkZd8B/wVQJz378iOem16ap6tVrYLzfGBbxWpDxk93oFJgFYYXBobE0L
        LPBpa7GCXE1bztGAWAptn2RweJ2WrAOWPGsL/J6zM2gtLySJrqJNi5pGcCrzjpRYxaTJxK5t05JIM
        R79/V9LSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUoPU-00074f-KW; Wed, 13 Nov 2019 08:53:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7414830018B;
        Wed, 13 Nov 2019 09:52:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 954212997AAC8; Wed, 13 Nov 2019 09:53:54 +0100 (CET)
Date:   Wed, 13 Nov 2019 09:53:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 05/17] x86/ftrace: Use text_poke()
Message-ID: <20191113085354.GE4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111132457.761255803@infradead.org>
 <20191112132536.28ac1b32@gandalf.local.home>
 <20191112222413.GB4131@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112222413.GB4131@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:24:13PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 12, 2019 at 01:25:36PM -0500, Steven Rostedt wrote:
> > On Mon, 11 Nov 2019 14:12:57 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > >  int ftrace_arch_code_modify_post_process(void)
> > >      __releases(&text_mutex)
> > >  {
> > > -	set_all_modules_text_ro();
> > > -	set_kernel_text_ro();
> > > +	text_poke_finish();
> > 
> > Why is the text_poke_finish() needed here? Can we add a comment about
> > why?
> 
> I think this is because of the text_poke_queue() in
> ftrace_modify_code_direct(). I seem to have forgotten the code-flow
> between the core and arch parts of ftrace again.
> 
> But sure, I can try and dig that out again and write a comment.

These are the two callgraphs:

  ftrace_module_enable()
    ftrace_arch_code_modify_prepare()
      do_for_each_ftrace_rec()
	__ftrace_replace_code()
	  ftrace_make_{call,nop}()
	    ftrace_modify_code_direct()
	      text_poke_queue()

    ftrace_arch_code_modify_post_process()
      text_poke_finish();


  ftrace_run_update_code()
    ftrace_arch_code_modify_prepare()
    arch_ftrace_update_code()
      ftrace_modify_all_code()
	ftrace_replace_code()
	  for_ftrace_rec_iter()
	    text_poke_queue()
	  text_poke_finish()
    ftrace_arch_code_modify_post_process()
      text_poke_finish()


So while it is superfluous for ftrace_run_update_code() it is required
for ftrace_module_enable(), and, as I said, pairs with the
text_poke_queue() in ftrace_modify_code_direct().

I'll stick in a comment.
