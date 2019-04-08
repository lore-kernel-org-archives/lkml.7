Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4235AC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041AD20880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgCLhNRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfDHUA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:00:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46686 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfDHUA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:00:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id s81so8775682qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 13:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TYUTvWmjE4ISEtIOVJ3Zl49bZfuq5JwU9OUPy5nFVe4=;
        b=VgCLhNRSXUpatqIKhm1/TGOI+ml0bKaor6asxMcYsallIgc93rJKL7xY/Fu/VRDA3t
         6wVu7/HOxICrVUr+jdM5B7rlAruXiPKahAH3e2mWkOCsLNKjEfWaEcCd12Vb0sP+N+h8
         ZjzHdGXzBGEKRwVH4fjEZfxoqW2QVFaME2IVuh6RzK/rWFtybEBvVmZKDQszmh1+9Sxs
         bGEI/Hfgyxc8z24REJcH6YS668Czy9gYA9bmbyVxshLLcAEFS4x3KEshk0tWPxmUcqLz
         vSvN2H66MPJYkwoavucjLlWvmeQ5zDTJXgRP3XKBhmPqgW6UOrefVA5T3uQ67qcmRXKR
         07sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TYUTvWmjE4ISEtIOVJ3Zl49bZfuq5JwU9OUPy5nFVe4=;
        b=Aug+pJ+3gxi08ssBcN4r4PPcnGc+jXZ7JCA2NBAAKNdfCLQ+ZiyIXJ+bPW8qkLnn9x
         fK9zzFIruBZ19ANnJvuQDLWu+S151JcuX/84jThNIXn39zKxzlDCQo/uEUiI6zhHkifO
         25n7loPHp9kfBkq9c9jI1ZS+0VFwBoYI0VcotfNqWnaIxnxXkvE6od20m1pkbMZo4CAG
         Q9bSeTqzUiFhKRu+Q4Ju1Mj2ZIPj+SB43U7nW/Pm5Ge5r3LRK/juxgMkGpaT/uP2z9y0
         Jz3NZRTvyLDvaQwumHNpFcEyXfCU1EZKy7ZgJE2bMrThmnbVEm5CiXRG6QNMAkjt0FBo
         TAQw==
X-Gm-Message-State: APjAAAWdqbyCBpBTuaaVQHqonCeCz0JodU3AXl5Juhun+AcEbcWCKzFW
        FFcr5nG//dAd1EHTuAiOVog=
X-Google-Smtp-Source: APXvYqyGO7CoIftjgzDdpXfFqEL0OqPfjmq+ApZbuNPV0Rd1KQKxaQR8HO+TLLicBGRiQVAlhB5amg==
X-Received: by 2002:a37:6c84:: with SMTP id h126mr25034842qkc.168.1554753654542;
        Mon, 08 Apr 2019 13:00:54 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id a47sm21199348qtb.79.2019.04.08.13.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 13:00:53 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD7094039C; Mon,  8 Apr 2019 17:00:50 -0300 (-03)
Date:   Mon, 8 Apr 2019 17:00:50 -0300
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf header: Fix lock/unlock imbalances
Message-ID: <20190408200050.GD5796@kernel.org>
References: <20190408173355.GA10501@embeddedor>
 <B581617C-53AD-435A-8352-5E5A74B76B34@fb.com>
 <3867ffda-5d01-412b-ed55-e39ee9db2ceb@embeddedor.com>
 <20190408193555.GA5796@kernel.org>
 <3958468b-e98b-67da-f802-f1a5d5c81d91@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3958468b-e98b-67da-f802-f1a5d5c81d91@embeddedor.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 08, 2019 at 02:52:52PM -0500, Gustavo A. R. Silva escreveu:
> 
> 
> On 4/8/19 2:35 PM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Apr 08, 2019 at 01:26:09PM -0500, Gustavo A. R. Silva escreveu:
> >>
> >>
> >> On 4/8/19 1:22 PM, Song Liu wrote:
> >>>
> >>>
> >>>> On Apr 8, 2019, at 10:33 AM, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
> >>>>
> >>>> Fix lock/unlock imbalances by refactoring the code a bit and adding
> >>>> calls to up_write() before return.
> >>>>
> >>>> Addresses-Coverity-ID: 1444315 ("Missing unlock")
> >>>> Addresses-Coverity-ID: 1444316 ("Missing unlock")
> >>>> Fixes: a70a1123174a ("perf bpf: Save BTF information as headers to perf.data")
> >>>> Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers to perf.data")
> >>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >>>
> >>> Acked-by: Song Liu <songliubraving@fb.com>
> >>>
> >>> Thanks for the fix!
> >>>
> >>
> >> Glad to help. :)
> > 
> > Super cool, using the same idiom as the kernel and living in the kernel
> > sources has its advantages 8-)
> > 
> 
> :P
> 
> > But see below, 
> > 
> >>>> +++ b/tools/perf/util/header.c
> >>>> @@ -2606,6 +2606,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
> >>>> 		perf_env__insert_bpf_prog_info(env, info_node);
> >>>> 	}
> >>>>
> >>>> +	up_write(&env->bpf_progs.lock);
> >>>> 	return 0;
> >>>> out:
> >>>> 	free(info_linear);
> >>>> @@ -2623,7 +2624,9 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
> >>>> static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
> >>>> {
> >>>> 	struct perf_env *env = &ff->ph->env;
> >>>> +	struct btf_node *node;
> >>>> 	u32 count, i;
> >>>> +	int err = -1;
> > 
> > Why are you using this 'err' variable? It is only set here and at the
> > end, i.e. one write, one read. We could as well have that out: block
> > return -1 straight away.
> > 
> > Else we could do, see below
> > 
> >>>>
> >>>> 	if (ff->ph->needs_swap) {
> >>>> 		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
> >>>> @@ -2636,31 +2639,33 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
> >>>> 	down_write(&env->bpf_progs.lock);
> >>>>
> >>>> 	for (i = 0; i < count; ++i) {
> >>>> -		struct btf_node *node;
> >>>> 		u32 id, data_size;
> >>>>
> >>>> +		node = NULL;
> >>>> 		if (do_read_u32(ff, &id))
> >>>> -			return -1;
> >>>> +			goto out;
> >>>> 		if (do_read_u32(ff, &data_size))
> >>>> -			return -1;
> >>>> +			goto out;
> >>>>
> >>>> 		node = malloc(sizeof(struct btf_node) + data_size);
> >>>> 		if (!node)
> >>>> -			return -1;
> >>>> +			goto out;
> >>>>
> >>>> 		node->id = id;
> >>>> 		node->data_size = data_size;
> >>>>
> >>>> -		if (__do_read(ff, node->data, data_size)) {
> >>>> -			free(node);
> >>>> -			return -1;
> >>>> -		}
> >>>> +		if (__do_read(ff, node->data, data_size))
> >>>> +			goto out;
> >>>>
> >>>> 		perf_env__insert_btf(env, node);
> >>>> 	}
> > 
> >       err = 0;
> > 
> >>>>
> > 
> > out:
> > 
> >>>> 	up_write(&env->bpf_progs.lock);
> > 
> >       return err;
> > 
> > And delete the rest.
> > 
> > but I see, you used the same pattern in the first #ifdef HAVE_LIBBPF_SUPPORT
> > block :-)
> > 
> > Anyway, since we're fixing up that other case, we might as well
> > streamline this, please check the patch below.
> > 
> 
> Yeah. This is exactly how I would have coded this from the beginning. But, as you
> correctly pointed out, I'm using the same pattern as in HAVE_LIBBPF_SUPPORT. :)
> 
> Just a comment below...
> 
> >>>> 	return 0;
> > 
> >>>> +out:
> >>>> +	up_write(&env->bpf_progs.lock);
> >>>> +	free(node);
> >>>> +	return err;
> > 
> > So, that is what I'm applying, please holler if I introduced some
> > problem:
> > 
> > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > index b9e693825873..2d2af2ac2b1e 100644
> > --- a/tools/perf/util/header.c
> > +++ b/tools/perf/util/header.c
> > @@ -2606,6 +2606,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
> >  		perf_env__insert_bpf_prog_info(env, info_node);
> >  	}
> >  
> > +	up_write(&env->bpf_progs.lock);
> >  	return 0;
> >  out:
> >  	free(info_linear);
> > @@ -2623,7 +2624,9 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
> >  static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
> >  {
> >  	struct perf_env *env = &ff->ph->env;
> > +	struct btf_node *node = NULL;
> >  	u32 count, i;
> > +	int err = -1;
> >  
> >  	if (ff->ph->needs_swap) {
> >  		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
> > @@ -2636,31 +2639,32 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
> >  	down_write(&env->bpf_progs.lock);
> >  
> >  	for (i = 0; i < count; ++i) {
> > -		struct btf_node *node;
> >  		u32 id, data_size;
> >  
> >  		if (do_read_u32(ff, &id))
> > -			return -1;
> > +			goto out;
> >  		if (do_read_u32(ff, &data_size))
> > -			return -1;
> > +			goto out;
> >  
> >  		node = malloc(sizeof(struct btf_node) + data_size);
> >  		if (!node)
> > -			return -1;
> > +			goto out;
> >  
> >  		node->id = id;
> >  		node->data_size = data_size;
> >  
> > -		if (__do_read(ff, node->data, data_size)) {
> > -			free(node);
> > -			return -1;
> > -		}
> > +		if (__do_read(ff, node->data, data_size))
> > +			goto out;
> >  
> >  		perf_env__insert_btf(env, node);
> > +		node = NULL;
> 
> If we move this assignment to the beginning of the for loop, as in
> the original patch, we avoid the same assignment while declaring
> node at the beginning of the function.

No, we don't, since the common exit path frees node, we better not free
the last node in the success case, that is why I moved it to the end,
i.e. after we're done with it, nullify it, so that the last btf_node
isn't freed in the now uncoditionall free(node); call :-)

Right?

- Arnaldo
 
> For the rest, the code looks good to me.
> 
> Thanks for your comments. :)
> --
> Gustavo
> 
> >  	}
> >  
> > +	err = 0;
> > +out:
> >  	up_write(&env->bpf_progs.lock);
> > -	return 0;
> > +	free(node);
> > +	return err;
> >  }
> >  
> >  struct feature_ops {
> > 

-- 

- Arnaldo
