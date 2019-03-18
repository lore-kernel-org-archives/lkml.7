Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6790C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 875F820828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 19:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IA0KLxr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfCRTjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 15:39:55 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41085 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfCRTjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 15:39:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id o129so10403998qke.8;
        Mon, 18 Mar 2019 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mn0fvvrAaAJs5Xt8e3Evsf6/MaDG5vDHxC9OOVa8eCk=;
        b=IA0KLxr4DwFE7Jbs4hhwJWmvBAhvbpKWE5qiC2ubSnnFYiy9fYBxwCOawiYMimTdNW
         1vgNnsVSDS9HYqvTHny5CB+kXcqVY6UxBWRiKYykeHyuWbT6Aw/8kIEKzQWl7pjb0UoP
         2BkV+xDZI30HwHp92DSwTEAxVbZq7fPN0tnGhgKyxfSp0tc+pMPlTpLiByByTWz6mvsY
         ZTHLfNsY2HkFSRrcBUAOXg63k4cC4cd8b2Di/cwa0uIFpMSmP0bXHL/H67TALpDPOUoB
         8Pw83WD89pPjz5Tjo53cJE4MYtFJKXuZK2+Rvnn5icWgVZZREJjKzEFgmNcVte6+hmBH
         Y+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mn0fvvrAaAJs5Xt8e3Evsf6/MaDG5vDHxC9OOVa8eCk=;
        b=Kwuer02OmsRefYNOKBiHqoPdIaE9X86hcXVg09lZcmtr8RateuAHnq+D5J62bjvKnI
         yTaB3URVQwrMmgkaMTutd80LOeo0VPsdovBEDb2X6ahx0Cg+QknN97GLkAIZucAVoF8o
         wVn+Odqj95LuGhD+ayRtbSDYaaO/0m+v+mNh2Ksj4I08b/uNHMgFgphjyefpw5EUJr66
         yKMgzfK3dSMA5r+sDsqhgzg9zYWklqf0ipP9zzm8Vwv14Uii90ygGrtnfdweP/4JdPQX
         mt/W30WQ4IAsIeTmf2vovNrPNFtFf6p7w2G+yrrjZYxzEaULoll0MDpsJWa2Rls/eyaC
         bdow==
X-Gm-Message-State: APjAAAUbLDBW+WVQsWUS3Wu6JkUWaOzd9raw41v7HFHClj45LiygjYXZ
        TW1vLGEOQcJ/yEh9UR6p6KU=
X-Google-Smtp-Source: APXvYqxU/lGDgd+vIOYsaGJVJqtUcjDxq0ESnVs7MdgOMBQnYwdtlC8+GBveXDK2QJsMEXhSoh5roA==
X-Received: by 2002:a37:d91c:: with SMTP id u28mr13706696qki.99.1552937992861;
        Mon, 18 Mar 2019 12:39:52 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:1b1:210a:504f:5027:31fa:e70e:3668])
        by smtp.gmail.com with ESMTPSA id p6sm919195qtk.70.2019.03.18.12.39.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 12:39:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A7FA64039C; Mon, 18 Mar 2019 16:39:39 -0300 (-03)
Date:   Mon, 18 Mar 2019 16:39:39 -0300
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 13/16] perf: free all counts in perf_evsel__exit
Message-ID: <20190318193939.GC3967@kernel.org>
References: <20190316080556.3075-1-changbin.du@gmail.com>
 <20190316080556.3075-14-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316080556.3075-14-changbin.du@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 16, 2019 at 04:05:53PM +0800, Changbin Du escreveu:
> Ensure that we have freed all allocated counts for struct perf_evsel.
> 
> =================================================================
> ==7494==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 48 byte(s) in 1 object(s) allocated from:
>     #0 0x7f0333a89138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
>     #1 0x5625e5330a5e in zalloc util/util.h:23
>     #2 0x5625e5330a9b in perf_counts__new util/counts.c:10
>     #3 0x5625e5330ca0 in perf_evsel__alloc_counts util/counts.c:47
>     #4 0x5625e520d8e5 in __perf_evsel__read_on_cpu util/evsel.c:1505

Does this backtrace corresponds to this patch? I don't think so, this is
allocating evsel->counts, not evsel->prev_raw_counts.

The fix for this specific one is to call perf_evsel__free_counts() in
perf_evsel__exit(), ok? I'm adding a patch to that effect.

The case for evsel->prev_raw_counts is different, I think this started
in 'perf stat' and ended up moving from evsel->priv handled by 'perf
stat' to a new evsel field, prev_raw_counts, and that was being handled
by the stat code, that would call perf_evsel__free_prev_raw_counts()
before calling perf_evsel__delete(), I think. But I would have to double
check.

If you find some leak where evsel->prev_raw_counts leaks, or if you
determine that by looking at the code, please submit a patch for that
case, ok?

- Arnaldo

>     #5 0x5625e517a985 in perf_evsel__read_on_cpu /home/work/linux/tools/perf/util/evsel.h:347
>     #6 0x5625e517ad1a in test__openat_syscall_event tests/openat-syscall.c:47
>     #7 0x5625e51528e6 in run_test tests/builtin-test.c:358
>     #8 0x5625e5152baf in test_and_print tests/builtin-test.c:388
>     #9 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
>     #10 0x5625e515572f in cmd_test tests/builtin-test.c:722
>     #11 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
>     #12 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
>     #13 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
>     #14 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
>     #15 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)
> 
> Indirect leak of 72 byte(s) in 1 object(s) allocated from:
>     #0 0x7f0333a89138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
>     #1 0x5625e532560d in zalloc util/util.h:23
>     #2 0x5625e532566b in xyarray__new util/xyarray.c:10
>     #3 0x5625e5330aba in perf_counts__new util/counts.c:15
>     #4 0x5625e5330ca0 in perf_evsel__alloc_counts util/counts.c:47
>     #5 0x5625e520d8e5 in __perf_evsel__read_on_cpu util/evsel.c:1505
>     #6 0x5625e517a985 in perf_evsel__read_on_cpu /home/work/linux/tools/perf/util/evsel.h:347
>     #7 0x5625e517ad1a in test__openat_syscall_event tests/openat-syscall.c:47
>     #8 0x5625e51528e6 in run_test tests/builtin-test.c:358
>     #9 0x5625e5152baf in test_and_print tests/builtin-test.c:388
>     #10 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
>     #11 0x5625e515572f in cmd_test tests/builtin-test.c:722
>     #12 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
>     #13 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
>     #14 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
>     #15 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
>     #16 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/perf/util/counts.c | 18 ++++++++++++++++++
>  tools/perf/util/counts.h |  4 ++++
>  tools/perf/util/evsel.c  |  2 ++
>  tools/perf/util/stat.c   | 18 ------------------
>  4 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
> index 03032b410c29..c5715d08b1f9 100644
> --- a/tools/perf/util/counts.c
> +++ b/tools/perf/util/counts.c
> @@ -53,3 +53,21 @@ void perf_evsel__free_counts(struct perf_evsel *evsel)
>  	perf_counts__delete(evsel->counts);
>  	evsel->counts = NULL;
>  }
> +
> +int perf_evsel__alloc_prev_raw_counts(struct perf_evsel *evsel,
> +				      int ncpus, int nthreads)
> +{
> +	struct perf_counts *counts;
> +
> +	counts = perf_counts__new(ncpus, nthreads);
> +	if (counts)
> +		evsel->prev_raw_counts = counts;
> +
> +	return counts ? 0 : -ENOMEM;
> +}
> +
> +void perf_evsel__free_prev_raw_counts(struct perf_evsel *evsel)
> +{
> +	perf_counts__delete(evsel->prev_raw_counts);
> +	evsel->prev_raw_counts = NULL;
> +}
> diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
> index 0d1050ccc586..b8bdbff586bb 100644
> --- a/tools/perf/util/counts.h
> +++ b/tools/perf/util/counts.h
> @@ -36,4 +36,8 @@ void perf_evsel__reset_counts(struct perf_evsel *evsel);
>  int perf_evsel__alloc_counts(struct perf_evsel *evsel, int ncpus, int nthreads);
>  void perf_evsel__free_counts(struct perf_evsel *evsel);
>  
> +int perf_evsel__alloc_prev_raw_counts(struct perf_evsel *evsel,
> +				      int ncpus, int nthreads);
> +void perf_evsel__free_prev_raw_counts(struct perf_evsel *evsel);
> +
>  #endif /* __PERF_COUNTS_H */
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3bbf73e979c0..8e0fbe34e5d9 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1294,6 +1294,8 @@ void perf_evsel__exit(struct perf_evsel *evsel)
>  	assert(evsel->evlist == NULL);
>  	perf_evsel__free_fd(evsel);
>  	perf_evsel__free_id(evsel);
> +	perf_evsel__free_counts(evsel);
> +	perf_evsel__free_prev_raw_counts(evsel);
>  	perf_evsel__free_config_terms(evsel);
>  	cgroup__put(evsel->cgrp);
>  	cpu_map__put(evsel->cpus);
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 4d40515307b8..6a22842f76d2 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -136,24 +136,6 @@ static void perf_evsel__free_stat_priv(struct perf_evsel *evsel)
>  	zfree(&evsel->stats);
>  }
>  
> -static int perf_evsel__alloc_prev_raw_counts(struct perf_evsel *evsel,
> -					     int ncpus, int nthreads)
> -{
> -	struct perf_counts *counts;
> -
> -	counts = perf_counts__new(ncpus, nthreads);
> -	if (counts)
> -		evsel->prev_raw_counts = counts;
> -
> -	return counts ? 0 : -ENOMEM;
> -}
> -
> -static void perf_evsel__free_prev_raw_counts(struct perf_evsel *evsel)
> -{
> -	perf_counts__delete(evsel->prev_raw_counts);
> -	evsel->prev_raw_counts = NULL;
> -}
> -
>  static int perf_evsel__alloc_stats(struct perf_evsel *evsel, bool alloc_raw)
>  {
>  	int ncpus = perf_evsel__nr_cpus(evsel);
> -- 
> 2.19.1

-- 

- Arnaldo
