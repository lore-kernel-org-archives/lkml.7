Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE417C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672E5217D6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 01:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZkwiNea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730797AbfDEBRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 21:17:44 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34881 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbfDEBRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 21:17:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so2311849pfe.2;
        Thu, 04 Apr 2019 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VBFRVxdUCNHIbsrakcfoReZRua6nxgcxfEPmNCKa8cE=;
        b=VZkwiNea7g7rmsqSG4CYMtFyvwxoeMd5QY1B5+pd2m7OpcWw9a13bmE6b3OZRJyEcC
         TJNt7eUeptwxInck0W0T/feaZwet8FzbV9UMc2RKdZkHQwpmA4owNGlX8akudsYlAHLE
         yQ0dJmMALZNNDY09YaqtJA5WSmyz1W9opTA4eUvRhA3s4SCjVFitcPfUtipzdC6NNsZ7
         psW5pjMQ4BoaRhNZknr+sRnOZuOKVvGqzvoEW143ZWAdsf9bUeoNk+LxYRWoZkBroU9D
         sm+MyReiEpoHOXk3cWr9+pyXA+ccuRVkmqVlj830IkorAnmxlqroMAqc8WthbDvvqAZs
         4RDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VBFRVxdUCNHIbsrakcfoReZRua6nxgcxfEPmNCKa8cE=;
        b=el8/JzfShzCFH8gbl/lX+Ylf9IIS8w3b2BdG45N4LcMnEFwMjCZcOmPCZx3aKAWnDF
         2UUKxFAfhnACWCsaVlSdZMbUGedpuIE7zQug+2DiL2DmJGr0uOZet8DQsNKIhJBR+sXP
         sUNSn8GO4HvXqqICCQ9vDeIai/A0wK+7NIenrr/ZN/rf2YlbYjJkC6njIV8uWFmDLuZr
         TXNd+ZS6/lIRbnEq6eGhEoD8tGIdrp6bTqTtJt7S9+J6YCWqX33TLtNj/DRtThpl5QNb
         PcV0I4usbEINGiToRCkWwxdXlLqNv8rQGzlBOJZ+7bCBd6CT4UK6JdakpV4sadApdaM2
         WgzA==
X-Gm-Message-State: APjAAAX1T4iX2VSFdKHDzkjrE0lGMqakC5GBnwNVqxbGItWNimrxY0G4
        NTApBqz8eGfoHKEe/TSD2FiUFyk3
X-Google-Smtp-Source: APXvYqzFmFrIk04oKoS2eIupGycuXjFUGlgxiKGh+H20+kfU0SyuKPfMddouJsn7CC9nN3OAlTPzXA==
X-Received: by 2002:a63:6941:: with SMTP id e62mr8657706pgc.99.1554427062163;
        Thu, 04 Apr 2019 18:17:42 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::3:bfce])
        by smtp.gmail.com with ESMTPSA id m16sm49006559pfi.29.2019.04.04.18.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 18:17:41 -0700 (PDT)
Date:   Thu, 4 Apr 2019 18:17:39 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Matt Mullins <mmullins@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Andrew Hall <hall@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Martin Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: add writable context for raw
 tracepoints
Message-ID: <20190405011738.k2dzevf45ftgbwhd@ast-mbp>
References: <20190329000758.494762-1-mmullins@fb.com>
 <20190329000758.494762-2-mmullins@fb.com>
 <1b2c864b-dbec-753f-a594-17a34b291c46@iogearbox.net>
 <5b37dd88467eb83efd8306f6d18b6e8fb035a356.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b37dd88467eb83efd8306f6d18b6e8fb035a356.camel@fb.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 06:39:12PM +0000, Matt Mullins wrote:
> On Mon, 2019-04-01 at 22:40 +0200, Daniel Borkmann wrote:
> > On 03/29/2019 01:07 AM, Matt Mullins wrote:
> > > This is an opt-in interface that allows a tracepoint to provide a safe
> > > buffer that can be written from a BPF_PROG_TYPE_RAW_TRACEPOINT program.
> > > The size of the buffer must be a compile-time constant, and is checked
> > > before allowing a BPF program to attach to a tracepoint that uses this
> > > feature.
> > > 
> > > The pointer to this buffer will be the first argument of tracepoints
> > > that opt in; the buffer is readable by both BPF_PROG_TYPE_RAW_TRACEPOINT
> > > and BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE programs that attach to such a
> > > tracepoint, but the buffer to which it points may only be written by the
> > > latter.
> > > 
> > > bpf_probe: assert that writable tracepoint size is correct
> > 
> > Maybe also add a kselftest into bpf test suite to i) demo it and ii) make
> > sure it's continuously been tested by bots running the suite?
> 
> Will do.
> 
> > 
> > > Signed-off-by: Matt Mullins <mmullins@fb.com>
> > > ---
> > >  include/linux/bpf.h             |  2 ++
> > >  include/linux/bpf_types.h       |  1 +
> > >  include/linux/tracepoint-defs.h |  1 +
> > >  include/trace/bpf_probe.h       | 27 +++++++++++++++++++++++++--
> > >  include/uapi/linux/bpf.h        |  1 +
> > >  kernel/bpf/syscall.c            |  8 ++++++--
> > >  kernel/bpf/verifier.c           | 11 +++++++++++
> > >  kernel/trace/bpf_trace.c        | 21 +++++++++++++++++++++
> > >  8 files changed, 68 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index a2132e09dc1c..d3c71fd67476 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -263,6 +263,7 @@ enum bpf_reg_type {
> > >  	PTR_TO_SOCK_COMMON_OR_NULL, /* reg points to sock_common or NULL */
> > >  	PTR_TO_TCP_SOCK,	 /* reg points to struct tcp_sock */
> > >  	PTR_TO_TCP_SOCK_OR_NULL, /* reg points to struct tcp_sock or NULL */
> > > +	PTR_TO_TP_BUFFER,	 /* reg points to a writable raw tp's buffer */
> > >  };
> > >  
> > >  /* The information passed from prog-specific *_is_valid_access
> > > @@ -352,6 +353,7 @@ struct bpf_prog_aux {
> > >  	u32 used_map_cnt;
> > >  	u32 max_ctx_offset;
> > >  	u32 max_pkt_offset;
> > > +	u32 max_tp_access;
> > >  	u32 stack_depth;
> > >  	u32 id;
> > >  	u32 func_cnt; /* used by non-func prog as the number of func progs */
> > > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > > index 08bf2f1fe553..c766108608cb 100644
> > > --- a/include/linux/bpf_types.h
> > > +++ b/include/linux/bpf_types.h
> > > @@ -25,6 +25,7 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_KPROBE, kprobe)
> > >  BPF_PROG_TYPE(BPF_PROG_TYPE_TRACEPOINT, tracepoint)
> > >  BPF_PROG_TYPE(BPF_PROG_TYPE_PERF_EVENT, perf_event)
> > >  BPF_PROG_TYPE(BPF_PROG_TYPE_RAW_TRACEPOINT, raw_tracepoint)
> > > +BPF_PROG_TYPE(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, raw_tracepoint_writable)
> > >  #endif
> > >  #ifdef CONFIG_CGROUP_BPF
> > >  BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_DEVICE, cg_dev)
> > > diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> > > index 49ba9cde7e4b..b29950a19205 100644
> > > --- a/include/linux/tracepoint-defs.h
> > > +++ b/include/linux/tracepoint-defs.h
> > > @@ -45,6 +45,7 @@ struct bpf_raw_event_map {
> > >  	struct tracepoint	*tp;
> > >  	void			*bpf_func;
> > >  	u32			num_args;
> > > +	u32			writable_size;
> > >  } __aligned(32);
> > >  
> > >  #endif
> > > diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> > > index 505dae0bed80..d6e556c0a085 100644
> > > --- a/include/trace/bpf_probe.h
> > > +++ b/include/trace/bpf_probe.h
> > > @@ -69,8 +69,7 @@ __bpf_trace_##call(void *__data, proto)					\
> > >   * to make sure that if the tracepoint handling changes, the
> > >   * bpf probe will fail to compile unless it too is updated.
> > >   */
> > > -#undef DEFINE_EVENT
> > > -#define DEFINE_EVENT(template, call, proto, args)			\
> > > +#define __DEFINE_EVENT(template, call, proto, args, size)		\
> > >  static inline void bpf_test_probe_##call(void)				\
> > >  {									\
> > >  	check_trace_callback_type_##call(__bpf_trace_##template);	\
> > > @@ -81,12 +80,36 @@ __bpf_trace_tp_map_##call = {						\
> > >  	.tp		= &__tracepoint_##call,				\
> > >  	.bpf_func	= (void *)__bpf_trace_##template,		\
> > >  	.num_args	= COUNT_ARGS(args),				\
> > > +	.writable_size	= size,						\
> > >  };
> > >  
> > > +#define FIRST(x, ...) x
> > > +
> > > +#undef DEFINE_EVENT_WRITABLE
> > > +#define DEFINE_EVENT_WRITABLE(template, call, proto, args, size)	\
> > > +static inline void bpf_test_buffer_##call(void)				\
> > > +{									\
> > > +	/* BUILD_BUG_ON() is ignored if the code is completely eliminated, but \
> > > +	 * BUILD_BUG_ON_ZERO() uses a different mechanism that is not	\
> > > +	 * dead-code-eliminated.					\
> > > +	 */								\
> > > +	FIRST(proto);							\
> > > +	(void)BUILD_BUG_ON_ZERO(size != sizeof(*FIRST(args)));		\
> > > +}									\
> > > +__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size)
> > > +
> > > +#undef DEFINE_EVENT
> > > +#define DEFINE_EVENT(template, call, proto, args)			\
> > > +	__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0)
> > >  
> > >  #undef DEFINE_EVENT_PRINT
> > >  #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
> > >  	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
> > >  
> > >  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > > +
> > > +#undef DEFINE_EVENT_WRITABLE
> > > +#undef __DEFINE_EVENT
> > > +#undef FIRST
> > > +
> > >  #endif /* CONFIG_BPF_EVENTS */
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index 3c38ac9a92a7..c5335d53ce82 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -166,6 +166,7 @@ enum bpf_prog_type {
> > >  	BPF_PROG_TYPE_LIRC_MODE2,
> > >  	BPF_PROG_TYPE_SK_REUSEPORT,
> > >  	BPF_PROG_TYPE_FLOW_DISSECTOR,
> > > +	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
> > >  };
> > >  
> > >  enum bpf_attach_type {
> > > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > > index 62f6bced3a3c..27e2f22879a4 100644
> > > --- a/kernel/bpf/syscall.c
> > > +++ b/kernel/bpf/syscall.c
> > > @@ -1720,12 +1720,16 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
> > >  	}
> > >  	raw_tp->btp = btp;
> > >  
> > > -	prog = bpf_prog_get_type(attr->raw_tracepoint.prog_fd,
> > > -				 BPF_PROG_TYPE_RAW_TRACEPOINT);
> > > +	prog = bpf_prog_get(attr->raw_tracepoint.prog_fd);
> > >  	if (IS_ERR(prog)) {
> > >  		err = PTR_ERR(prog);
> > >  		goto out_free_tp;
> > >  	}
> > > +	if (prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT &&
> > > +	    prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) {
> > 
> > I don't think we'd gain a lot by making this an extra prog type which can do the
> > same as BPF_PROG_TYPE_RAW_TRACEPOINT modulo optional writing. Why not integrating
> > this directly into BPF_PROG_TYPE_RAW_TRACEPOINT then? The actual opt-in comes from
> > the DEFINE_EVENT_WRITABLE(), not from the prog type.
> 
> I did that to separate the hook into
> raw_tp_writable_prog_is_valid_access, which (compared to
> raw_tp_prog_is_valid_access):
> 
>   1) permits writes, and
>   2) encodes the assumption than the context begins with the pointer to
> that writable buffer
> 
> I'm not sure those are appropriate for all users of
> BPF_PROG_TYPE_RAW_TRACEPOINT, but I can't immediately point out any
> harm in doing so -- some dereferences of ctx that have historically
> returned a SCALAR_VALUE would end up tagged as a PTR_TO_TP_BUFFER, but
> they still won't be able to access through that pointer unless they're
> attached to the right tracepoint.
> 
> I'll try to unify the two and see what I get.

I think combining raw_tp prog type with raw_tp_writeable is possible,
but too cumbersome to use from user pov.
Since such raw_tp will be accepted at prog load time,
but only at the time of attach it will be rejected in __bpf_probe_register.

raw_tp_writable_prog_is_valid_access() doesn't know future attach point.
we cannot use bpf_attr.expected_attach_type here.
That's why it simply does:
+       if (off == 0 && size == sizeof(u64))
+               info->reg_type = PTR_TO_TP_BUFFER;

essentially hard coding first argument of writeable tp to be the buffer.

TP invocation is also new.
Like in patch 2:
trace_nbd_send_request(&request, nbd->index, blk_mq_rq_from_pdu(cmd));

Patches 1,2,3 actually look fine to me,
but I agree that selftests are necessary.

Matt, could you add new writeable tracepoint somewhere in bpf_test_run()
and corresponding selftest?

Thanks

