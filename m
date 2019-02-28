Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3771AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CD5218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551337261;
	bh=yyQcFj3sPSjnhQ8FdsAqF++MUk31qhk3E5aeMX1n1+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=feby7nWf3jrbWZAw//yrXXmZjRLn3iDMbPPBYDneb3VXR+gljrxkGB6vGeml0bycc
	 m3rcLYYMTWLJriCLN+hYnaPEk5Z/2uZNLG+TsvASoaM5hTI2ixs3TMkJPOI/nBOHjt
	 3qd4ryZDS8LoCBmPSnjp39zE0DatmEfzwFrcNr6Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbfB1HA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731142AbfB1HA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:00:59 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A3E21850;
        Thu, 28 Feb 2019 07:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551337258;
        bh=yyQcFj3sPSjnhQ8FdsAqF++MUk31qhk3E5aeMX1n1+4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qmtYNWNMK53vziV0Ht6YIHtv+aC1bL4jKntiQo3hjRjrXd+Mu3ACgzYn4C4VA/5x4
         qtdnTtYfa595BuYfKKHzHnAvD4hORfmpVg9Jv8CsvxshjlMcU86/5zf81cyMM6VIUK
         dpCabzIcNUQPhAPTCbrFVJ1YWuGZcsmQe9dzCgWU=
Date:   Thu, 28 Feb 2019 16:00:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 5/5] tracing/probe: Support user-space dereference
Message-Id: <20190228160055.92841d1b482be8c10a50b24b@kernel.org>
In-Reply-To: <20190227213132.50f3cef1@vmware.local.home>
References: <155127853496.32576.3705994926675037747.stgit@devbox>
        <155127868250.32576.2419537726154240743.stgit@devbox>
        <20190227213132.50f3cef1@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Thank you for the review.

On Wed, 27 Feb 2019 21:31:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 27 Feb 2019 23:44:42 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> >  
> > +.. _user_mem_access:
> > +User Memory Access
> > +------------------
> > +Kprobe events supports user-space memory access. For that purpose, you can use
> > +either user-space dereference syntax or 'ustring' type.
> > +
> > +user-space dereference syntax allows you to access a field of a data structure
> 
>   "The user-space"
> 
> > +n user-space. This is done by "u" prefix with dereference syntax. For example,
> 
>  in user-space?   "This is done by adding the "u" prefix to the dereference syntax"

Oops, it maybe a typo. yes "in user-space".
OK, I'll fix that.

> 
> 
> > ++u4(%si) means read a user memory from the user-space address %si+4. You can
> 
>  "means it will read memory from the address in the register %si offset
>  by 4, and that memory is expected to be in user-space."

OK,

> 
> 
> > +use this for string too, e.g. +u0(%si):string means that the read a user space
> 
> 	"for strings too"

OK,

> 
> > +string from the address where %si register points. 'ustring' is a kind of
> > +short-cut. You can use +0(%si):ustring instead of that.
> 
> "+u0(%si):string will read a string from the address in the register
>  %si that is expected to be in user-space. 'ustring' is a shortcut way
>  off performing the same task. That is, +0(%si):ustring is equivalent
>  to +u0(%si):string."

Would you mean "of performing"?

> 
> 
> > +
> > +Note that kprobe-event provides user-memory access syntax, but it
> > doesn't +use it transparently. This means if you use normal
> > dereference or string type +for user memory, it might fail, and
> > always fails on some arch. So user has to +check if the targe data is
> > in kernel or in user space carefully. 
> >  Per-Probe Event Filtering
> >  -------------------------
> > diff --git a/Documentation/trace/uprobetracer.rst
> > b/Documentation/trace/uprobetracer.rst index
> > 4c3bfde2ba47..6144423b2368 100644 ---
> > a/Documentation/trace/uprobetracer.rst +++
> > b/Documentation/trace/uprobetracer.rst @@ -42,16 +42,17 @@ Synopsis
> > of uprobe_tracer @+OFFSET	: Fetch memory at OFFSET (OFFSET
> > from same file as PATH) $stackN	: Fetch Nth entry of stack (N
> > >= 0) $stack	: Fetch stack address.
> > -   $retval	: Fetch return value.(*)
> > +   $retval	: Fetch return value.(\*1)
> >     $comm	: Fetch current task comm.
> > -   +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(**)
> > +   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS
> > address.(\*2)(\*3) NAME=FETCHARG     : Set NAME as the argument name
> > of FETCHARG. FETCHARG:TYPE     : Set TYPE as the type of FETCHARG.
> > Currently, basic types (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal
> > types (x8/x16/x32/x64), "string" and bitfield are supported.
> >  
> > -  (*) only for return probe.
> > -  (**) this is useful for fetching a field of data structures.
> > +  (\*1) only for return probe.
> > +  (\*2) this is useful for fetching a field of data structures.
> > +  (\*3) Unlike kprobe event, "u" prefix will be just ignored.
> 
> 					"will just be ignored."

OK. 

Thank you!

> 
> >  
> >  Types
> >  -----
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 4cacbb0e1538..5408a82a015d 100644
> 
> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
