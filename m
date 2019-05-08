Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CC6C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697FE20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfEHPWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbfEHPWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:22:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05910216C8;
        Wed,  8 May 2019 15:22:38 +0000 (UTC)
Date:   Wed, 8 May 2019 11:22:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [RFC PATCH v6 4/6] tracing/probe: Support user-space
 dereference
Message-ID: <20190508112237.76bd0e6b@gandalf.local.home>
In-Reply-To: <20190508131143.6f69abddd4c11b47bea138fb@kernel.org>
References: <155289137555.7218.9282784065958321058.stgit@devnote2>
        <155289143224.7218.6083289081805224583.stgit@devnote2>
        <20190506115226.70c62f7a@gandalf.local.home>
        <20190508131143.6f69abddd4c11b47bea138fb@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 13:11:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 6 May 2019 11:52:26 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 18 Mar 2019 15:43:52 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >   
> > > +.. _user_mem_access:
> > > +User Memory Access
> > > +------------------
> > > +Kprobe events supports user-space memory access. For that purpose, you can use
> > > +either user-space dereference syntax or 'ustring' type.
> > > +
> > > +The user-space dereference syntax allows you to access a field of a data
> > > +structure in user-space. This is done by adding the "u" prefix to the
> > > +dereference syntax. For example, +u4(%si) means it will read memory from the
> > > +address in the register %si offset by 4, and the mory is expected to be in  
> > 
> >                                                     ^^^^
> >  "memory"  
> 
> OK, thanks!
> 
> >   
> > > +user-space. You can use this for strings too, e.g. +u0(%si):string will read
> > > +a string from the address in the register %si that is expected to be in user-
> > > +space. 'ustring' is a shortcut way of performing the same task. That is,
> > > ++0(%si):ustring is equivalent to +u0(%si):string.
> > > +
> > > +Note that kprobe-event provides the user-memory access syntax but it doesn't
> > > +use it transparently. This means if you use normal dereference or string type
> > > +for user memory, it might fail, and always fails on some arch. So user has to  
> > 
> >   "and may always fail on some archs. The user has to carefully check
> >   if the target data is in kernel or user space."  
> 
> OK. I'll update.
> 
> > > +check if the targe data is in kernel or in user space carefully.
> > >  
> > >  Per-Probe Event Filtering
> > >  -------------------------
> > > diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
> > > index 4346e23e3ae7..de8812c932bc 100644
> > > --- a/Documentation/trace/uprobetracer.rst
> > > +++ b/Documentation/trace/uprobetracer.rst
> > > @@ -42,16 +42,17 @@ Synopsis of uprobe_tracer
> > >     @+OFFSET	: Fetch memory at OFFSET (OFFSET from same file as PATH)
> > >     $stackN	: Fetch Nth entry of stack (N >= 0)
> > >     $stack	: Fetch stack address.
> > > -   $retval	: Fetch return value.(*)
> > > +   $retval	: Fetch return value.(\*1)
> > >     $comm	: Fetch current task comm.
> > > -   +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(**)
> > > +   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*2)(\*3)
> > >     NAME=FETCHARG     : Set NAME as the argument name of FETCHARG.
> > >     FETCHARG:TYPE     : Set TYPE as the type of FETCHARG. Currently, basic types
> > >  		       (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> > >  		       (x8/x16/x32/x64), "string" and bitfield are supported.  
> > 
> > Hmm, shouldn't uprobes default to userspace. Isn't the purpose mostly
> > to find out what's going on in userspace. Perhaps we should add a 'k'
> > annotation to uprobes to denote that it's for kernel space, as that
> > should be the exception and not the norm.  
> 
> No, uprobe can not access kernel space, because it doesn't have the
> current kernel context. Note that all registers, stacks which
> can be accessed from uprobe handler are user-space. We can not access
> kernel context from that. See below
> 
> > > -  (*) only for return probe.
> > > -  (**) this is useful for fetching a field of data structures.
> > > +  (\*1) only for return probe.
> > > +  (\*2) this is useful for fetching a field of data structures.
> > > +  (\*3) Unlike kprobe event, "u" prefix will just be ignored.  
> 
> Thus the 'u' is just ignored on uprobe event.

I totally missed the footnote here. Can we stress this point more up in
the "User Memory Access" section. Specifically state something like:
"Uprobes only access userspace memory, thus the 'u' is not required,
and if it is added to a uprobe, it will simply be ignored".

Thanks!

-- Steve
