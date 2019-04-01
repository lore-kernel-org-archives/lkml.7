Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805CBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403862133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 20:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfDAUkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 16:40:24 -0400
Received: from www62.your-server.de ([213.133.104.62]:60240 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfDAUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 16:40:24 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hB3j8-0000hs-4m; Mon, 01 Apr 2019 22:40:18 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hB3j7-000NN5-TV; Mon, 01 Apr 2019 22:40:17 +0200
Subject: Re: [PATCH bpf-next 1/3] bpf: add writable context for raw
 tracepoints
To:     Matt Mullins <mmullins@fb.com>, hall@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20190329000758.494762-1-mmullins@fb.com>
 <20190329000758.494762-2-mmullins@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1b2c864b-dbec-753f-a594-17a34b291c46@iogearbox.net>
Date:   Mon, 1 Apr 2019 22:40:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190329000758.494762-2-mmullins@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25406/Mon Apr  1 09:55:53 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/29/2019 01:07 AM, Matt Mullins wrote:
> This is an opt-in interface that allows a tracepoint to provide a safe
> buffer that can be written from a BPF_PROG_TYPE_RAW_TRACEPOINT program.
> The size of the buffer must be a compile-time constant, and is checked
> before allowing a BPF program to attach to a tracepoint that uses this
> feature.
> 
> The pointer to this buffer will be the first argument of tracepoints
> that opt in; the buffer is readable by both BPF_PROG_TYPE_RAW_TRACEPOINT
> and BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE programs that attach to such a
> tracepoint, but the buffer to which it points may only be written by the
> latter.
> 
> bpf_probe: assert that writable tracepoint size is correct

Maybe also add a kselftest into bpf test suite to i) demo it and ii) make
sure it's continuously been tested by bots running the suite?

> Signed-off-by: Matt Mullins <mmullins@fb.com>
> ---
>  include/linux/bpf.h             |  2 ++
>  include/linux/bpf_types.h       |  1 +
>  include/linux/tracepoint-defs.h |  1 +
>  include/trace/bpf_probe.h       | 27 +++++++++++++++++++++++++--
>  include/uapi/linux/bpf.h        |  1 +
>  kernel/bpf/syscall.c            |  8 ++++++--
>  kernel/bpf/verifier.c           | 11 +++++++++++
>  kernel/trace/bpf_trace.c        | 21 +++++++++++++++++++++
>  8 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a2132e09dc1c..d3c71fd67476 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -263,6 +263,7 @@ enum bpf_reg_type {
>  	PTR_TO_SOCK_COMMON_OR_NULL, /* reg points to sock_common or NULL */
>  	PTR_TO_TCP_SOCK,	 /* reg points to struct tcp_sock */
>  	PTR_TO_TCP_SOCK_OR_NULL, /* reg points to struct tcp_sock or NULL */
> +	PTR_TO_TP_BUFFER,	 /* reg points to a writable raw tp's buffer */
>  };
>  
>  /* The information passed from prog-specific *_is_valid_access
> @@ -352,6 +353,7 @@ struct bpf_prog_aux {
>  	u32 used_map_cnt;
>  	u32 max_ctx_offset;
>  	u32 max_pkt_offset;
> +	u32 max_tp_access;
>  	u32 stack_depth;
>  	u32 id;
>  	u32 func_cnt; /* used by non-func prog as the number of func progs */
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index 08bf2f1fe553..c766108608cb 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -25,6 +25,7 @@ BPF_PROG_TYPE(BPF_PROG_TYPE_KPROBE, kprobe)
>  BPF_PROG_TYPE(BPF_PROG_TYPE_TRACEPOINT, tracepoint)
>  BPF_PROG_TYPE(BPF_PROG_TYPE_PERF_EVENT, perf_event)
>  BPF_PROG_TYPE(BPF_PROG_TYPE_RAW_TRACEPOINT, raw_tracepoint)
> +BPF_PROG_TYPE(BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE, raw_tracepoint_writable)
>  #endif
>  #ifdef CONFIG_CGROUP_BPF
>  BPF_PROG_TYPE(BPF_PROG_TYPE_CGROUP_DEVICE, cg_dev)
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index 49ba9cde7e4b..b29950a19205 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -45,6 +45,7 @@ struct bpf_raw_event_map {
>  	struct tracepoint	*tp;
>  	void			*bpf_func;
>  	u32			num_args;
> +	u32			writable_size;
>  } __aligned(32);
>  
>  #endif
> diff --git a/include/trace/bpf_probe.h b/include/trace/bpf_probe.h
> index 505dae0bed80..d6e556c0a085 100644
> --- a/include/trace/bpf_probe.h
> +++ b/include/trace/bpf_probe.h
> @@ -69,8 +69,7 @@ __bpf_trace_##call(void *__data, proto)					\
>   * to make sure that if the tracepoint handling changes, the
>   * bpf probe will fail to compile unless it too is updated.
>   */
> -#undef DEFINE_EVENT
> -#define DEFINE_EVENT(template, call, proto, args)			\
> +#define __DEFINE_EVENT(template, call, proto, args, size)		\
>  static inline void bpf_test_probe_##call(void)				\
>  {									\
>  	check_trace_callback_type_##call(__bpf_trace_##template);	\
> @@ -81,12 +80,36 @@ __bpf_trace_tp_map_##call = {						\
>  	.tp		= &__tracepoint_##call,				\
>  	.bpf_func	= (void *)__bpf_trace_##template,		\
>  	.num_args	= COUNT_ARGS(args),				\
> +	.writable_size	= size,						\
>  };
>  
> +#define FIRST(x, ...) x
> +
> +#undef DEFINE_EVENT_WRITABLE
> +#define DEFINE_EVENT_WRITABLE(template, call, proto, args, size)	\
> +static inline void bpf_test_buffer_##call(void)				\
> +{									\
> +	/* BUILD_BUG_ON() is ignored if the code is completely eliminated, but \
> +	 * BUILD_BUG_ON_ZERO() uses a different mechanism that is not	\
> +	 * dead-code-eliminated.					\
> +	 */								\
> +	FIRST(proto);							\
> +	(void)BUILD_BUG_ON_ZERO(size != sizeof(*FIRST(args)));		\
> +}									\
> +__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), size)
> +
> +#undef DEFINE_EVENT
> +#define DEFINE_EVENT(template, call, proto, args)			\
> +	__DEFINE_EVENT(template, call, PARAMS(proto), PARAMS(args), 0)
>  
>  #undef DEFINE_EVENT_PRINT
>  #define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
>  	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
>  
>  #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> +
> +#undef DEFINE_EVENT_WRITABLE
> +#undef __DEFINE_EVENT
> +#undef FIRST
> +
>  #endif /* CONFIG_BPF_EVENTS */
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3c38ac9a92a7..c5335d53ce82 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -166,6 +166,7 @@ enum bpf_prog_type {
>  	BPF_PROG_TYPE_LIRC_MODE2,
>  	BPF_PROG_TYPE_SK_REUSEPORT,
>  	BPF_PROG_TYPE_FLOW_DISSECTOR,
> +	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
>  };
>  
>  enum bpf_attach_type {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 62f6bced3a3c..27e2f22879a4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1720,12 +1720,16 @@ static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
>  	}
>  	raw_tp->btp = btp;
>  
> -	prog = bpf_prog_get_type(attr->raw_tracepoint.prog_fd,
> -				 BPF_PROG_TYPE_RAW_TRACEPOINT);
> +	prog = bpf_prog_get(attr->raw_tracepoint.prog_fd);
>  	if (IS_ERR(prog)) {
>  		err = PTR_ERR(prog);
>  		goto out_free_tp;
>  	}
> +	if (prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT &&
> +	    prog->type != BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) {

I don't think we'd gain a lot by making this an extra prog type which can do the
same as BPF_PROG_TYPE_RAW_TRACEPOINT modulo optional writing. Why not integrating
this directly into BPF_PROG_TYPE_RAW_TRACEPOINT then? The actual opt-in comes from
the DEFINE_EVENT_WRITABLE(), not from the prog type.

> +		err = -EINVAL;
> +		goto out_put_prog;
> +	}
>  
>  	err = bpf_probe_register(raw_tp->btp, prog);
>  	if (err)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ce166a002d16..b6b4a2ca9f0c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2100,6 +2100,17 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
>  		err = check_sock_access(env, insn_idx, regno, off, size, t);
>  		if (!err && value_regno >= 0)
>  			mark_reg_unknown(env, regs, value_regno);
> +	} else if (reg->type == PTR_TO_TP_BUFFER) {
> +		if (off < 0) {
> +			verbose(env,
> +				"R%d invalid tracepoint buffer access: off=%d, size=%d",
> +				value_regno, off, size);
> +			return -EACCES;
> +		}
> +		if (off + size > env->prog->aux->max_tp_access)
> +			env->prog->aux->max_tp_access = off + size;
> +		if (t == BPF_READ && value_regno >= 0)
> +			mark_reg_unknown(env, regs, value_regno);

This should also disallow variable access into the reg, I presume (see check_ctx_reg())?
Or is there a clear rationale for having it enabled?

>  	} else {
>  		verbose(env, "R%d invalid mem access '%s'\n", regno,
>  			reg_type_str[reg->type]);
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d64c00afceb5..a2dd79dc6871 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -909,6 +909,24 @@ const struct bpf_verifier_ops raw_tracepoint_verifier_ops = {
>  const struct bpf_prog_ops raw_tracepoint_prog_ops = {
>  };
>  
> +static bool raw_tp_writable_prog_is_valid_access(int off, int size,
> +						 enum bpf_access_type type,
> +						 const struct bpf_prog *prog,
> +						 struct bpf_insn_access_aux *info)
> +{
> +	if (off == 0 && size == sizeof(u64))
> +		info->reg_type = PTR_TO_TP_BUFFER;
> +	return raw_tp_prog_is_valid_access(off, size, type, prog, info);
> +}
> +
> +const struct bpf_verifier_ops raw_tracepoint_writable_verifier_ops = {
> +	.get_func_proto  = raw_tp_prog_func_proto,
> +	.is_valid_access = raw_tp_writable_prog_is_valid_access,
> +};
> +
> +const struct bpf_prog_ops raw_tracepoint_writable_prog_ops = {
> +};
> +
>  static bool pe_prog_is_valid_access(int off, int size, enum bpf_access_type type,
>  				    const struct bpf_prog *prog,
>  				    struct bpf_insn_access_aux *info)
> @@ -1198,6 +1216,9 @@ static int __bpf_probe_register(struct bpf_raw_event_map *btp, struct bpf_prog *
>  	if (prog->aux->max_ctx_offset > btp->num_args * sizeof(u64))
>  		return -EINVAL;
>  
> +	if (prog->aux->max_tp_access > btp->writable_size)
> +		return -EINVAL;
> +
>  	return tracepoint_probe_register(tp, (void *)btp->bpf_func, prog);
>  }
>  
> 

