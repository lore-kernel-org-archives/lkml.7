Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A072C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA442168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbfEQQrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfEQQrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:47:15 -0400
Received: from oasis.local.home (unknown [216.9.110.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CD102166E;
        Fri, 17 May 2019 16:47:14 +0000 (UTC)
Date:   Fri, 17 May 2019 12:47:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] tracing: silence GCC 9 array bounds warning
Message-ID: <20190517124715.3d82bdbe@oasis.local.home>
In-Reply-To: <20190517092502.GA22779@gmail.com>
References: <20190517092502.GA22779@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2019 11:25:02 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> Starting with GCC 9, -Warray-bounds detects cases when memset is called
> starting on a member of a struct but the size to be cleared ends up
> writing over further members.
> 
> Such a call happens in the trace code to clear, at once, all members
> after and including `seq` on struct trace_iterator:
> 
>     In function 'memset',
>         inlined from 'ftrace_dump' at kernel/trace/trace.c:8914:3:
>     ./include/linux/string.h:344:9: warning: '__builtin_memset' offset
>     [8505, 8560] from the object at 'iter' is out of the bounds of
>     referenced subobject 'seq' with type 'struct trace_seq' at offset
>     4368 [-Warray-bounds]
>       344 |  return __builtin_memset(p, c, size);
>           |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> In order to avoid GCC complaining about it, we compute the address
> ourselves by adding the offsetof distance instead of referring
> directly to the member.
> 
> Since there are two places doing this clear (trace.c and trace_kdb.c),
> take the chance to move the workaround into a single place in
> the internal header.

Hi Miguel,

Linus mentioned this too.

 https://lore.kernel.org/lkml/CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com/T/#u

I was going to do a helper function, and put it in the queue for the
next merge window (as it isn't really a bug, just gcc complaining a
little more aggressively). But since you already did the patch, I'll
use yours. But I have some nits about it below.


Add here:

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: http://lkml.kernel.org/r/CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com

> 
> Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>  kernel/trace/trace.c     |  7 +------
>  kernel/trace/trace.h     | 14 ++++++++++++++
>  kernel/trace/trace_kdb.c |  7 +------
>  3 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index ca1ee656d6d8..37990532351b 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8627,12 +8627,7 @@ void ftrace_dump(enum ftrace_dump_mode
> oops_dump_mode) 
>  		cnt++;
>  
> -		/* reset all but tr, trace, and overruns */
> -		memset(&iter.seq, 0,
> -		       sizeof(struct trace_iterator) -
> -		       offsetof(struct trace_iterator, seq));
> -		iter.iter_flags |= TRACE_FILE_LAT_FMT;

Setting the LAT_FMT isn't something a function called "reset" should do.

> -		iter.pos = -1;
> +		trace_iterator_reset(&iter);
>  
>  		if (trace_find_next_entry_inc(&iter) != NULL) {
>  			int ret;
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index d80cee49e0eb..80ad656f43eb 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -1964,4 +1964,18 @@ static inline void
> tracer_hardirqs_off(unsigned long a0, unsigned long a1) { } 
>  extern struct trace_iterator *tracepoint_print_iter;
>  
> +/* reset all but tr, trace, and overruns */
> +static __always_inline void trace_iterator_reset(struct
> trace_iterator * iter) +{
> +	/*
> +	 * Equivalent to &iter->seq, but avoids GCC 9 complaining
> about
> +	 * overwriting more members than just iter->seq
> (-Warray-bounds)
> +	 */
> +	memset((char *)(iter) + offsetof(struct trace_iterator,

Why (char *)? Please use (void *).

> seq), 0,
> +	       sizeof(struct trace_iterator) -
> +	       offsetof(struct trace_iterator, seq));

Make a variable for offset and reuse that (see Linus's email).

> +	iter->iter_flags |= TRACE_FILE_LAT_FMT;

Again, leave the LAT_FMT change in the other locations.

Please send a v2 version with these updates.

Thanks!

-- Steve

> +	iter->pos = -1;
> +}
> +
>  #endif /* _LINUX_KERNEL_TRACE_H */
> diff --git a/kernel/trace/trace_kdb.c b/kernel/trace/trace_kdb.c
> index 810d78a8d14c..0a2a166ee716 100644
> --- a/kernel/trace/trace_kdb.c
> +++ b/kernel/trace/trace_kdb.c
> @@ -41,12 +41,7 @@ static void ftrace_dump_buf(int skip_lines, long
> cpu_file) 
>  	kdb_printf("Dumping ftrace buffer:\n");
>  
> -	/* reset all but tr, trace, and overruns */
> -	memset(&iter.seq, 0,
> -		   sizeof(struct trace_iterator) -
> -		   offsetof(struct trace_iterator, seq));
> -	iter.iter_flags |= TRACE_FILE_LAT_FMT;
> -	iter.pos = -1;
> +	trace_iterator_reset(&iter);
>  
>  	if (cpu_file == RING_BUFFER_ALL_CPUS) {
>  		for_each_tracing_cpu(cpu) {

