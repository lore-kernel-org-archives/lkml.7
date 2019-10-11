Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AB4C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEE3206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fIqW+zhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbfJKLJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:09:37 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41834 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfJKLJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hd7DeC8X5msMUThPgUPk7q3GKjl3k7DCzGsETcIzACA=; b=fIqW+zhpMmwxyXiudCtqbZKiv
        Rua75ufe08S0TzPUEwj66GcMdVNwwXbpRvk/iuPTQFxNLhZfz9f/bcY7LcVq1L/D371z5dZ5KrrEB
        oc3/AjbaMA2CBmd5sSo2S/ZVR2gHpFAPNvWN3fh6LhzM619VRjxxMdHaohZv+P+MUPzNyuBpEGXNf
        EtQIKhx10aE9evxbyVJUpnod+Mej41MZaXZSPfZdsdffT4XspS1ArVx2SpMc3SdV4mpZat1evXRc8
        BR5kPNhKGk3QyzdMI3aKXY1Hb8NJUzlavX+ANPjzLdc7zzIhQXA5VjNKkzlMm0Z5u2RM9yLdwSGC4
        vw5Mfg1XQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsne-0006qb-Ky; Fri, 11 Oct 2019 11:09:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B9193013A4;
        Fri, 11 Oct 2019 13:08:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 115BE20230369; Fri, 11 Oct 2019 13:09:33 +0200 (CEST)
Date:   Fri, 11 Oct 2019 13:09:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] ftrace/module: Allow ftrace to make only loaded module
 text read-write
Message-ID: <20191011110933.GX2328@hirez.programming.kicks-ass.net>
References: <20191009223638.60b78727@oasis.local.home>
 <20191010073121.GN2311@hirez.programming.kicks-ass.net>
 <20191010093329.GI2359@hirez.programming.kicks-ass.net>
 <20191010093650.GJ2359@hirez.programming.kicks-ass.net>
 <20191010122909.GK2359@hirez.programming.kicks-ass.net>
 <20191010105515.5eba7f31@gandalf.local.home>
 <20191010170111.GQ2328@hirez.programming.kicks-ass.net>
 <20191010132013.7f3388bc@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010132013.7f3388bc@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 01:20:13PM -0400, Steven Rostedt wrote:
> Hmm, I'm lost at what the below is trying to do with respect to the
> above.

The below is an alternative approach for the module load issue. It
accepts we patch 'late' and then uses text_poke_bp().

It works. We can then look at moving all that patching to
ftrace_module_init() later when we figure out how to do it across
architectures.

> > --- a/arch/x86/kernel/ftrace.c
> > +++ b/arch/x86/kernel/ftrace.c
> > @@ -34,6 +34,8 @@
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> >  
> > +static int ftrace_poke_late = 0;
> > +
> >  int ftrace_arch_code_modify_prepare(void)
> >      __acquires(&text_mutex)
> >  {
> > @@ -43,12 +45,15 @@ int ftrace_arch_code_modify_prepare(void
> >  	 * ftrace has it set to "read/write".
> >  	 */
> >  	mutex_lock(&text_mutex);
> > +	ftrace_poke_late = 1;
> >  	return 0;
> >  }
> >  
> >  int ftrace_arch_code_modify_post_process(void)
> >      __releases(&text_mutex)
> >  {
> > +	text_poke_finish();
> > +	ftrace_poke_late = 0;
> >  	mutex_unlock(&text_mutex);
> >  	return 0;
> >  }
> > @@ -116,7 +121,10 @@ ftrace_modify_code_direct(unsigned long
> >  		return ret;
> >  
> >  	/* replace the text with the new text */
> > -	text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
> > +	if (ftrace_poke_late)
> > +		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> > +	else
> > +		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
> >  	return 0;
> >  }
> >  
> 
