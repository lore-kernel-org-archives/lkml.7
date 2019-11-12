Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD54C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E68321925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfKLWsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfKLWsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:48:20 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CDE821783;
        Tue, 12 Nov 2019 22:48:18 +0000 (UTC)
Date:   Tue, 12 Nov 2019 17:48:16 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH -v5 05/17] x86/ftrace: Use text_poke()
Message-ID: <20191112174816.7fb95948@gandalf.local.home>
In-Reply-To: <20191112222413.GB4131@hirez.programming.kicks-ass.net>
References: <20191111131252.921588318@infradead.org>
        <20191111132457.761255803@infradead.org>
        <20191112132536.28ac1b32@gandalf.local.home>
        <20191112222413.GB4131@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Nov 2019 23:24:13 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

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

Hmm, I don't think there's a case where ftrace_make_nop() or
ftrace_make_call() ever use the queued function. I added this:

 static int
 ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 			  const char *new_code)
 {
 	int ret = ftrace_verify_code(ip, old_code);
 	if (ret)
 		return ret;
 
 	/* replace the text with the new text */
- 	if (ftrace_poke_late)
+ 	if (ftrace_poke_late) {
+		printk("POKE LATE!\n");
 		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
- 	else
+ 	} else
 		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
 	return 0;
 }

And that printk() never printed, even after running the ftracetests.

> 
> But sure, I can try and dig that out again and write a comment.
> 
> 
> > > +	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL); // BATCH  
> > 
> > What do you mean by "BATCH" ?  
> 
> Ah, that was a question, can/should we use text_poke_queue() there?

Probably not, as that's just a single location or two. It modifies the
static trampolines if only a single user is registered to ftrace.

-- Steve
