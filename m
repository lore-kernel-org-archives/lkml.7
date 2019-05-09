Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C12C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DA42173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557412912;
	bh=N2vQy9JTK8LN7IWchKikRhEJ1xsEYEkPcuyuyxOaX88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0EC9VkH5+Z0L1+kAbJ3Ohi/D11HRiqlx04Xc99Jl55A9pNBDl1tDiG3D2bgpdCjUF
	 Z8klPu9U45sGJpaRaoR4TBz2sbnUx/T+vrAX+3z0l1ajnIap1/L0EDdUoFfHFKNxLK
	 4AiWcutmdyvHNCOzWrJ8/gyiT2Yq3l2oeGsRL61w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfEIOlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 10:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfEIOlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 10:41:51 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 898D42053B;
        Thu,  9 May 2019 14:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557412910;
        bh=N2vQy9JTK8LN7IWchKikRhEJ1xsEYEkPcuyuyxOaX88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=faB1yoGJaYipGa3/KWKFQOxY5+j7FnG9QjqYccubTWIyYg4d36SGpo2eOvvxv6Z9/
         iwHmyQBxcVA6wdEmhm5XJhOoWT4mCfP+FfOe++l68ufJnxSXY5Za1A1F/7p9IffZ03
         xoUiVpOT/C4ZlNPVcn4mm+T9oHTw0OJeyKPtWqCA=
Date:   Thu, 9 May 2019 23:41:43 +0900
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
Subject: Re: [PATCH v7 6/6] perf-probe: Add user memory access attribute
 support
Message-Id: <20190509234143.d2f6cc6979daba4252ba410f@kernel.org>
In-Reply-To: <20190509091735.GC90202@gmail.com>
References: <155732230159.12756.15040196512285621636.stgit@devnote2>
        <155732238071.12756.3969249515654160948.stgit@devnote2>
        <20190509091735.GC90202@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 May 2019 11:17:35 +0200
Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > --- a/tools/perf/util/probe-event.h
> > +++ b/tools/perf/util/probe-event.h
> > @@ -37,6 +37,7 @@ struct probe_trace_point {
> >  struct probe_trace_arg_ref {
> >  	struct probe_trace_arg_ref	*next;	/* Next reference */
> >  	long				offset;	/* Offset value */
> > +	bool				user;	/* User-memory access */
> >  };
> >  
> >  /* kprobe-tracer and uprobe-tracer tracing argument */
> > @@ -82,6 +83,7 @@ struct perf_probe_arg {
> >  	char				*var;	/* Variable name */
> >  	char				*type;	/* Type name */
> >  	struct perf_probe_arg_field	*field;	/* Structure fields */
> > +	bool				user;	/* User-memory */
> 
> Why did the 'access' qualifier get dropped from the second comment?

Ah, it's my typo.

> Also, please name it and related parameters and local variables 
> 'user_access' - in that case no comments are needed and it's all super 
> clear. Only 'user' is ambiguous really.

Yes, that's a good idea! OK. I'll change it.

Thank you!

> 
> Thanks,
> 
> 	ngo


-- 
Masami Hiramatsu <mhiramat@kernel.org>
