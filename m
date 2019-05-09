Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B3CC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3DCB21479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557411965;
	bh=KqcmKqRLACU502LhLijjnyQpIuMoXd5JTeCqLAF52rY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OyLIl7ySf2f+lMYCcGouw2OFxn5UALSmRu0vfOzbp27daznOVofK89jAjatZhVuLL
	 AOhBcmlJVVR7byrtFs84O4ybGsmXkYGTg7ZPEY8vtY6lt99UGLAvmasnhs6goNCfiN
	 DTLkOP9zoQAhyYOGTu6mjnFKeJ8iMNzAP+ZPw1xM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEIO0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbfEIO0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:26:04 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A39F8208C3;
        Thu,  9 May 2019 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411962;
        bh=KqcmKqRLACU502LhLijjnyQpIuMoXd5JTeCqLAF52rY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RFLHsUlpzXRDmgwpQUSxgsRcT5Kyi4fqgNeV/0zv5A5eHXEuO85opYIGwe6Rez+IL
         RsSN1XR7me+EcHb4fWfu/qO31tnVi/CyT2t01KiKEFT/cwN6H6IXbYOlj0TbU2aRI7
         iP9mZXsr+2wBFH8tR3ooGL/ujUsAKW0V/mRlD8Us=
Date:   Thu, 9 May 2019 23:25:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Joel Fernandes <joel@joelfernandes.org>, yhs@fb.com
Subject: Re: [PATCH v7 3/6] tracing/probe: Add ustring type for user-space
 string
Message-Id: <20190509232555.bd1f6aad78202d8f4a38ced1@kernel.org>
In-Reply-To: <20190509091507.GB90202@gmail.com>
References: <155732230159.12756.15040196512285621636.stgit@devnote2>
        <155732234578.12756.9934987812691940806.stgit@devnote2>
        <20190509091507.GB90202@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 11:15:07 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Add "ustring" type for fetching user-space string from kprobe event.
> > User can specify ustring type at uprobe event, and it is same as
> > "string" for uprobe.
> > 
> > Note that probe-event provides this option but it doesn't choose the
> > correct type automatically since we have not way to decide the address
> > is in user-space or not on some arch (and on some other arch, you can
> > fetch the string by "string" type). So user must carefully check the
> > target code (e.g. if you see __user on the target variable) and
> > use this new type.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > 
> > ---
> >  Changes in v5:
> >  - Use strnlen_unsafe_user() in fetch_store_strlen_user().
> >  Changes in v2:
> >  - Use strnlen_user() instead of open code for fetch_store_strlen_user().
> > ---
> >  Documentation/trace/kprobetrace.rst |    9 +++++++--
> >  kernel/trace/trace.c                |    2 +-
> >  kernel/trace/trace_kprobe.c         |   29 +++++++++++++++++++++++++++++
> >  kernel/trace/trace_probe.c          |   14 +++++++++++---
> >  kernel/trace/trace_probe.h          |    1 +
> >  kernel/trace/trace_probe_tmpl.h     |   14 +++++++++++++-
> >  kernel/trace/trace_uprobe.c         |   12 ++++++++++++
> >  7 files changed, 74 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> > index 235ce2ab131a..a3ac7c9ac242 100644
> > --- a/Documentation/trace/kprobetrace.rst
> > +++ b/Documentation/trace/kprobetrace.rst
> > @@ -55,7 +55,8 @@ Synopsis of kprobe_events
> >    NAME=FETCHARG : Set NAME as the argument name of FETCHARG.
> >    FETCHARG:TYPE : Set TYPE as the type of FETCHARG. Currently, basic types
> >  		  (u8/u16/u32/u64/s8/s16/s32/s64), hexadecimal types
> > -		  (x8/x16/x32/x64), "string" and bitfield are supported.
> > +		  (x8/x16/x32/x64), "string", "ustring" and bitfield
> > +		  are supported.
> >  
> >    (\*1) only for the probe on function entry (offs == 0).
> >    (\*2) only for return probe.
> > @@ -77,7 +78,11 @@ apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
> >  wrong, but '+8($stack):x8[8]' is OK.)
> >  String type is a special type, which fetches a "null-terminated" string from
> >  kernel space. This means it will fail and store NULL if the string container
> > -has been paged out.
> > +has been paged out. "ustring" type is an alternative of string for user-space.
> > +Note that kprobe-event provides string/ustring types, but doesn't change it
> > +automatically. So user has to decide if the targe string in kernel or in user
> > +space carefully. On some arch, if you choose wrong one, it always fails to
> > +record string data.
> >  The string array type is a bit different from other types. For other base
> >  types, <base-type>[1] is equal to <base-type> (e.g. +0(%di):x32[1] is same
> >  as +0(%di):x32.) But string[1] is not equal to string. The string type itself
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index dcb9adb44be9..101a5d09a632 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -4858,7 +4858,7 @@ static const char readme_msg[] =
> >  	"\t           $stack<index>, $stack, $retval, $comm\n"
> >  #endif
> >  	"\t     type: s8/16/32/64, u8/16/32/64, x8/16/32/64, string, symbol,\n"
> > -	"\t           b<bit-width>@<bit-offset>/<container-size>,\n"
> > +	"\t           b<bit-width>@<bit-offset>/<container-size>, ustring,\n"
> >  	"\t           <type>\\[<array-size>\\]\n"
> >  #ifdef CONFIG_HIST_TRIGGERS
> >  	"\t    field: <stype> <name>;\n"
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 7d736248a070..fcb8806fc93c 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -886,6 +886,14 @@ fetch_store_strlen(unsigned long addr)
> >  	return (ret < 0) ? ret : len;
> >  }
> >  
> > +/* Return the length of string -- including null terminal byte */
> > +static nokprobe_inline int
> > +fetch_store_strlen_user(unsigned long addr)
> > +{
> > +	return strnlen_unsafe_user((__force const void __user *)addr,
> > +				   MAX_STRING_SIZE);
> > +}
> > +
> >  /*
> >   * Fetch a null-terminated string. Caller MUST set *(u32 *)buf with max
> >   * length and relative data location.
> > @@ -910,6 +918,27 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
> >  	return ret;
> >  }
> >  
> > +/*
> > + * Fetch a null-terminated string from user. Caller MUST set *(u32 *)buf
> > + * with max length and relative data location.
> > + */
> > +static nokprobe_inline int
> > +fetch_store_string_user(unsigned long addr, void *dest, void *base)
> > +{
> > +	int maxlen = get_loc_len(*(u32 *)dest);
> > +	u8 *dst = get_loc_data(dest, base);
> > +	long ret;
> > +
> > +	if (unlikely(!maxlen))
> > +		return -ENOMEM;
> > +	ret = strncpy_from_unsafe_user(dst, (__force const void __user *)addr,
> > +				       maxlen);
> 
> Pointless line break.

OK.

> 
> > +
> > +	if (ret >= 0)
> > +		*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
> > +	return ret;
> > +}
> 
> Plus the problem as in the earlier patch.

OK, I'll fix it too.

Thank you!

> 
> Thanks,
> 
> 	Ingo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
