Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCCEC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC1F21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557749499;
	bh=WNG2MlrAJcFt1wXzqMpPwwrfEuEKFEwSqbcfrwsQu5Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Cv4oAZ6HXLH7WYCwaczz4bUhLjN+dWZEsuGZ8Fg6v6X8BPN63g2wCUuLxPbHafH/e
	 e5dXf+arFLhBgK8J1SKAliiVuiN7dChXRPW7QmaJ/YvGSRd4W1y0FbFywxDFrA88m1
	 y+2Qvy9NIgSHxJjCIxzzrBKVh3JpC/vSd9jLXi/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbfEMMLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727830AbfEMMLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:11:38 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D78620879;
        Mon, 13 May 2019 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557749497;
        bh=WNG2MlrAJcFt1wXzqMpPwwrfEuEKFEwSqbcfrwsQu5Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fyK1Mtl7s9+iTTAyV27myT0UUSzjXGyTI2AuFkuhIveXginRru0cpGKlL9S7zaFq6
         LWdDhG7peI5E9MSxYcy72WUomcWdGQzaX5MGK87Y/BF4ZUtl2qFsAZPJEGOE9mXCoP
         dZnO7a70Ovh9fBwp+arysaeXyWKmqbLIKiKv0E6A=
Date:   Mon, 13 May 2019 21:11:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-Id: <20190513211130.24735357a329cfdc25fcecf9@kernel.org>
In-Reply-To: <20190508112237.76bd0e6b@gandalf.local.home>
References: <155289137555.7218.9282784065958321058.stgit@devnote2>
        <155289143224.7218.6083289081805224583.stgit@devnote2>
        <20190506115226.70c62f7a@gandalf.local.home>
        <20190508131143.6f69abddd4c11b47bea138fb@kernel.org>
        <20190508112237.76bd0e6b@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 May 2019 11:22:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > >  Per-Probe Event Filtering
> > > >  -------------------------
> > > > diff --git a/Documentation/trace/uprobetracer.rst b/Documentation/trace/uprobetracer.rst
> > > > index 4346e23e3ae7..de8812c932bc 100644
> > > > --- a/Documentation/trace/uprobetracer.rst
> > > > +++ b/Documentation/trace/uprobetracer.rst
> > > > @@ -42,16 +42,17 @@ Synopsis of uprobe_tracer
> > > >     @+OFFSET	: Fetch memory at OFFSET (OFFSET from same file as PATH)
> > > >     $stackN	: Fetch Nth entry of stack (N >= 0)
> > > >     $stack	: Fetch stack address.
> > > > -   $retval	: Fetch return value.(*)
> > > > +   $retval	: Fetch return value.(\*1)
> > > >     $comm	: Fetch current task comm.
> > > > -   +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(**)
> > > > +   +|-[u]OFFS(FETCHARG) : Fetch memory at FETCHARG +|- OFFS address.(\*2)(\*3)
> > > >     NAME=FETCHARG     : Set NAME as the argument name of FETCHARG.
> > > >     FETCHARG:TYPE     : Set TYPE as the type of FETCHARG. Currently, basic types
> > > >  		       (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> > > >  		       (x8/x16/x32/x64), "string" and bitfield are supported.  
> > > 
> > > Hmm, shouldn't uprobes default to userspace. Isn't the purpose mostly
> > > to find out what's going on in userspace. Perhaps we should add a 'k'
> > > annotation to uprobes to denote that it's for kernel space, as that
> > > should be the exception and not the norm.  
> > 
> > No, uprobe can not access kernel space, because it doesn't have the
> > current kernel context. Note that all registers, stacks which
> > can be accessed from uprobe handler are user-space. We can not access
> > kernel context from that. See below
> > 
> > > > -  (*) only for return probe.
> > > > -  (**) this is useful for fetching a field of data structures.
> > > > +  (\*1) only for return probe.
> > > > +  (\*2) this is useful for fetching a field of data structures.
> > > > +  (\*3) Unlike kprobe event, "u" prefix will just be ignored.  
> > 
> > Thus the 'u' is just ignored on uprobe event.
> 
> I totally missed the footnote here. Can we stress this point more up in
> the "User Memory Access" section. Specifically state something like:
> "Uprobes only access userspace memory, thus the 'u' is not required,
> and if it is added to a uprobe, it will simply be ignored".

Sorry, I missed this mail. 

Since the "User Memory Access" section is only in kprobetrace.rst, I think
mentioning uprobe-events in kprobetrace.rst is meaningless. Uprobe user
might read uprobetracer.rst instead of kprobetrace.rst.
So I think it is enough to mention it as a footnote in uprobetracer.rst.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
