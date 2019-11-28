Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC882C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3FE215F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfK1BA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:00:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727563AbfK1BAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:00:25 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B32F2158A;
        Thu, 28 Nov 2019 01:00:24 +0000 (UTC)
Date:   Wed, 27 Nov 2019 20:00:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Linus <torvalds@linux-foundation.org>
Subject: Re: linux-next: manual merge of the ftrace tree with the tip tree
Message-ID: <20191127200022.4e90beb8@gandalf.local.home>
In-Reply-To: <20191128114704.7d705a98@canb.auug.org.au>
References: <20191121151041.4ff886d5@canb.auug.org.au>
        <20191128114704.7d705a98@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2019 11:47:04 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Thu, 21 Nov 2019 15:10:40 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the ftrace tree got a conflict in:
> > 
> >   kernel/trace/trace_export.c
> > 
> > between commit:
> > 
> >   60fdad00827c ("ftrace: Rework event_create_dir()")
> > 
> > from the tip tree and commit:
> > 
> >   6dff4d7dd3e0 ("tracing: Make internal ftrace events static")
> > 
> > from the ftrace tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> > 
> > -- 
> > Cheers,
> > Stephen Rothwell
> > 
> > diff --cc kernel/trace/trace_export.c
> > index 6d64c1c19fd5,2e6d2e9741cc..000000000000
> > --- a/kernel/trace/trace_export.c
> > +++ b/kernel/trace/trace_export.c
> > @@@ -142,10 -168,12 +142,10 @@@ static struct trace_event_fields ftrace
> >   #define F_printk(fmt, args...) __stringify(fmt) ", "  __stringify(args)
> >   
> >   #undef FTRACE_ENTRY_REG
> >  -#define FTRACE_ENTRY_REG(call, struct_name, etype, tstruct, print, filter,\
> >  -			 regfn)						\
> >  -									\
> >  +#define FTRACE_ENTRY_REG(call, struct_name, etype, tstruct, print, regfn) \
> > - struct trace_event_class __refdata event_class_ftrace_##call = {	\
> > + static struct trace_event_class __refdata event_class_ftrace_##call = {	\
> >   	.system			= __stringify(TRACE_SYSTEM),		\
> >  -	.define_fields		= ftrace_define_fields_##call,		\
> >  +	.fields_array		= ftrace_event_fields_##call,		\
> >   	.fields			= LIST_HEAD_INIT(event_class_ftrace_##call.fields),\
> >   	.reg			= regfn,				\
> >   };									\  
> 
> This is now a conflict between the tip tree and Linus' tree.

This looks to be a trivial conflict, as the change in the ftrace (now
Linus's) tree just makes event_class_ftrace_##call static, and
shouldn't interfere with the changes in tip.

-- Steve

