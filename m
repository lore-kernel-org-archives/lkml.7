Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BC3C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D224121A49
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 09:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UpVDGiv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKMJBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 04:01:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfKMJBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 04:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zzs1mEJpA0dy+PCteNoSAQTEnUNE7xBIt6YRUA3dCvc=; b=UpVDGiv4evrM1KnuMK4jzbAha
        RzkAtRPD3+GH9ArcQN1ITI9ruEGQ4atNjBNCM5QUdKBEC4tZOU1omnCREu+sMkMTM/kSXameFqRsz
        umFFO3yDB1c/Qv7vRt9fzlpLDKRqY7xldCIJ7h/KfCgSIgq5HqDeOE1yQlBC7MR0a1r6y8OiwtPX5
        J4510KJn1EMkDTkO8wSaFXksgInXqHVh6YzFo3DeMuBoDu49IbtXYIHIW8JPs0VAo4JpbQKqEfeIM
        54lNdhRyy8XcWxNAYO3QfpgqD6LXMF0kQaKCRtZpJsesH7gf/4aQik0EKk7NAjfBogTq7MbM/vL+i
        EE3TiZAWw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iUoWR-0006o7-Gl; Wed, 13 Nov 2019 09:01:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F372305615;
        Wed, 13 Nov 2019 09:59:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89F352997AAC8; Wed, 13 Nov 2019 10:01:04 +0100 (CET)
Date:   Wed, 13 Nov 2019 10:01:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 05/17] x86/ftrace: Use text_poke()
Message-ID: <20191113090104.GF4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
 <20191111132457.761255803@infradead.org>
 <20191112132536.28ac1b32@gandalf.local.home>
 <20191112222413.GB4131@hirez.programming.kicks-ass.net>
 <20191112174816.7fb95948@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191112174816.7fb95948@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 05:48:16PM -0500, Steven Rostedt wrote:
> On Tue, 12 Nov 2019 23:24:13 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, Nov 12, 2019 at 01:25:36PM -0500, Steven Rostedt wrote:
> > > On Mon, 11 Nov 2019 14:12:57 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:  
> > 
> > > >  int ftrace_arch_code_modify_post_process(void)
> > > >      __releases(&text_mutex)
> > > >  {
> > > > -	set_all_modules_text_ro();
> > > > -	set_kernel_text_ro();
> > > > +	text_poke_finish();  
> > > 
> > > Why is the text_poke_finish() needed here? Can we add a comment about
> > > why?  
> > 
> > I think this is because of the text_poke_queue() in
> > ftrace_modify_code_direct(). I seem to have forgotten the code-flow
> > between the core and arch parts of ftrace again.
> 
> Hmm, I don't think there's a case where ftrace_make_nop() or
> ftrace_make_call() ever use the queued function. I added this:
> 
>  static int
>  ftrace_modify_code_direct(unsigned long ip, const char *old_code,
>  			  const char *new_code)
>  {
>  	int ret = ftrace_verify_code(ip, old_code);
>  	if (ret)
>  		return ret;
>  
>  	/* replace the text with the new text */
> - 	if (ftrace_poke_late)
> + 	if (ftrace_poke_late) {
> +		printk("POKE LATE!\n");
>  		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> - 	else
> + 	} else
>  		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
>  	return 0;
>  }
> 
> And that printk() never printed, even after running the ftracetests.

Well, then wth did it do that set_all_modules_text_rw() nonsense?
Because all I did was preserve that semantic.

Anyway, all this can be greatly simplified once we get KLP fixed and can
move where we flip modules RO,X.

At that point we can merge ftrace_module_init() and
ftrace_module_enable() (both will run before RO,X) and the core code
will loose the ftrace_arch_code_modify_*() calls (for that callchain)
and then we can remove ftrace_poke_late.

So I'll keep this for now, because it does exactly what the old code
did, and then we can clean it all up once the other stuff lands and
everything gets simpler.
