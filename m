Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A98DC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1950D206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ydVeMG+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389951AbfDRTbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:31:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40308 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDRTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:31:47 -0400
Received: by mail-io1-f66.google.com with SMTP id i21so2256638iol.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WRTTylwDAGf2v1275eftz005pUmhpeMZ1PNz9A/x0Js=;
        b=ydVeMG+oMBKe1RKDIguIRueX0K1vWgfIxt7XHfzEF4PoUf85M7wVmArsN8m3pmQ/A5
         Sis+/wD7JHihVla8YgHu9YWOb/A/3F2lVH96EAtymLb7Hp3Rl/zqOHt2vRQez4ZidjK3
         RxQGhfIBHbASnfGIo3v4REFnsUdO0haCkrFVKtDftmmi5v7df+8k+GurCV0PJnc4uss8
         h8Sn6GoeyhUP5GcPOMH6q4l+lV3wpu+WQ3YEo+CMApIsA/RDIBuw45HP54C5401P3He9
         5lCl6RkuNrID4gq0slKtqWPpndwNGMFiKz7TEfSs/v1d/chTgdbyFbxY7bnibhR4cd8k
         Kd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=WRTTylwDAGf2v1275eftz005pUmhpeMZ1PNz9A/x0Js=;
        b=iiVhYulJYds2hwZG8zrZUablI2DZzYnBMxHXa6Xn0NUDi4gJa6D0E66infIy2AOo8G
         iLaZ59HfCSR01Ub2dKLN8wCUBW6rkgldKPwqaXr3x0YHRcUV4X3Cc8RbD5oaYiyOkAyV
         m+6S0pMBM1752+pGgp8ozwEsDjSXcK+DdB0tAwHfriBPJdRUiNSeqPmzg6KACrqU84aR
         k3nT4wzhZ0q57dQGDHpxfG/DB5XKR8ozBtu4CYGsuB1MuR5CYTB5OOi/oHwNTGuwqyjs
         Y5jjvr7Ej6xVv9ijDLJEyX+H0RrTvP1aHWtWOfm0m1d4546+dU+VjTi/fHqlEh7M0fJN
         5OXA==
X-Gm-Message-State: APjAAAXxqSnkPWEGOPwsjqx98AEgSfym+JIU37p3Kg629Za/GGjZad3p
        QZb+MlASat2YIgttqFiihzZK9w==
X-Google-Smtp-Source: APXvYqwrgAZu1gwHsTcT6FoaKfsImERIJPUy2JlW1oWbhFDw553/bbmaxPchN1c73n6vE0EOIKLfsg==
X-Received: by 2002:a6b:f007:: with SMTP id w7mr5612464ioc.292.1555615906003;
        Thu, 18 Apr 2019 12:31:46 -0700 (PDT)
Received: from localhost (c-107-2-67-121.hsd1.mn.comcast.net. [107.2.67.121])
        by smtp.gmail.com with ESMTPSA id v134sm1363055ita.16.2019.04.18.12.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 12:31:44 -0700 (PDT)
Date:   Thu, 18 Apr 2019 14:31:43 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.0 39/93] perf top: Delete the evlist before
 perf_session, fixing heap-use-after-free issue
Message-ID: <20190418193143.aq2i7g2upngge7e6@xps.therub.org>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
References: <20190418160436.781762249@linuxfoundation.org>
 <20190418160441.339477070@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418160441.339477070@linuxfoundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 07:57:17PM +0200, Greg Kroah-Hartman wrote:
> [ Upstream commit 0dba9e4be95b59e77060645ca8e37ca3231061f5 ]
> 
> The evlist should be destroyed before the perf session.
> 
> Detected with gcc's ASan:
> 
>   =================================================================
>   ==27350==ERROR: AddressSanitizer: heap-use-after-free on address 0x62b000002e38 at pc 0x5611da276999 bp 0x7ffce8f1d1a0 sp 0x7ffce8f1d190
>   WRITE of size 8 at 0x62b000002e38 thread T0
>       #0 0x5611da276998 in __list_del /home/work/linux/tools/include/linux/list.h:89
>       #1 0x5611da276d4a in __list_del_entry /home/work/linux/tools/include/linux/list.h:102
>       #2 0x5611da276e77 in list_del_init /home/work/linux/tools/include/linux/list.h:145
>       #3 0x5611da2781cd in thread__put util/thread.c:130
>       #4 0x5611da2cc0a8 in __thread__zput util/thread.h:68
>       #5 0x5611da2d2dcb in hist_entry__delete util/hist.c:1148
>       #6 0x5611da2cdf91 in hists__delete_entry util/hist.c:337
>       #7 0x5611da2ce19e in hists__delete_entries util/hist.c:365
>       #8 0x5611da2db2ab in hists__delete_all_entries util/hist.c:2639
>       #9 0x5611da2db325 in hists_evsel__exit util/hist.c:2651
>       #10 0x5611da1c5352 in perf_evsel__exit util/evsel.c:1304
>       #11 0x5611da1c5390 in perf_evsel__delete util/evsel.c:1309
>       #12 0x5611da1b35f0 in perf_evlist__purge util/evlist.c:124
>       #13 0x5611da1b38e2 in perf_evlist__delete util/evlist.c:148
>       #14 0x5611da069781 in cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1645
>       #15 0x5611da17d038 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
>       #16 0x5611da17d577 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
>       #17 0x5611da17d97b in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
>       #18 0x5611da17e0e9 in main /home/changbin/work/linux/tools/perf/perf.c:520
>       #19 0x7fdcc970f09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)
>       #20 0x5611d9ff35c9 in _start (/home/work/linux/tools/perf/perf+0x3e95c9)
> 
>   0x62b000002e38 is located 11320 bytes inside of 27448-byte region [0x62b000000200,0x62b000006d38)
>   freed by thread T0 here:
>       #0 0x7fdccb04ab70 in free (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xedb70)
>       #1 0x5611da260df4 in perf_session__delete util/session.c:201
>       #2 0x5611da063de5 in __cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1300
>       #3 0x5611da06973c in cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1642
>       #4 0x5611da17d038 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
>       #5 0x5611da17d577 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
>       #6 0x5611da17d97b in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
>       #7 0x5611da17e0e9 in main /home/changbin/work/linux/tools/perf/perf.c:520
>       #8 0x7fdcc970f09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)
> 
>   previously allocated by thread T0 here:
>       #0 0x7fdccb04b138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
>       #1 0x5611da26010c in zalloc util/util.h:23
>       #2 0x5611da260824 in perf_session__new util/session.c:118
>       #3 0x5611da0633a6 in __cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1192
>       #4 0x5611da06973c in cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1642
>       #5 0x5611da17d038 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
>       #6 0x5611da17d577 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
>       #7 0x5611da17d97b in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
>       #8 0x5611da17e0e9 in main /home/changbin/work/linux/tools/perf/perf.c:520
>       #9 0x7fdcc970f09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)
> 
>   SUMMARY: AddressSanitizer: heap-use-after-free /home/work/linux/tools/include/linux/list.h:89 in __list_del
>   Shadow bytes around the buggy address:
>     0x0c567fff8570: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>     0x0c567fff8580: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>     0x0c567fff8590: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>     0x0c567fff85a0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>     0x0c567fff85b0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   =>0x0c567fff85c0: fd fd fd fd fd fd fd[fd]fd fd fd fd fd fd fd fd
>     0x0c567fff85d0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>     0x0c567fff85e0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>     0x0c567fff85f0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>     0x0c567fff8600: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>     0x0c567fff8610: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
>   Shadow byte legend (one shadow byte represents 8 application bytes):
>     Addressable:           00
>     Partially addressable: 01 02 03 04 05 06 07
>     Heap left redzone:       fa
>     Freed heap region:       fd
>     Stack left redzone:      f1
>     Stack mid redzone:       f2
>     Stack right redzone:     f3
>     Stack after return:      f5
>     Stack use after scope:   f8
>     Global redzone:          f9
>     Global init order:       f6
>     Poisoned by user:        f7
>     Container overflow:      fc
>     Array cookie:            ac
>     Intra object redzone:    bb
>     ASan internal:           fe
>     Left alloca redzone:     ca
>     Right alloca redzone:    cb
>   ==27350==ABORTING

I'm seeing the following build error as a result of this patch being
backported to 5.0:

    builtin-top.c: In function ‘__cmd_top’:
    builtin-top.c:1241:3: error: label ‘out_delete’ used but not defined
       goto out_delete;
       ^~~~
      CC       builtin-script.o

Dropping this patch from 5.0 (along with ad59b96f965a ("perf data: Don't store
auxtrace index for directory data file") does fix the perf build.

Dan

> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Link: http://lkml.kernel.org/r/20190316080556.3075-8-changbin.du@gmail.com
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/perf/builtin-top.c | 42 ++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index f64e312db787..9b215007924b 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1192,23 +1192,19 @@ static int __cmd_top(struct perf_top *top)
>  	pthread_t thread, thread_process;
>  	int ret;
>  
> -	top->session = perf_session__new(NULL, false, NULL);
> -	if (top->session == NULL)
> -		return -1;
> -
>  	if (!top->annotation_opts.objdump_path) {
>  		ret = perf_env__lookup_objdump(&top->session->header.env,
>  					       &top->annotation_opts.objdump_path);
>  		if (ret)
> -			goto out_delete;
> +			return ret;
>  	}
>  
>  	ret = callchain_param__setup_sample_type(&callchain_param);
>  	if (ret)
> -		goto out_delete;
> +		return ret;
>  
>  	if (perf_session__register_idle_thread(top->session) < 0)
> -		goto out_delete;
> +		return ret;
>  
>  	if (top->nr_threads_synthesize > 1)
>  		perf_set_multithreaded();
> @@ -1224,13 +1220,18 @@ static int __cmd_top(struct perf_top *top)
>  
>  	if (perf_hpp_list.socket) {
>  		ret = perf_env__read_cpu_topology_map(&perf_env);
> -		if (ret < 0)
> -			goto out_err_cpu_topo;
> +		if (ret < 0) {
> +			char errbuf[BUFSIZ];
> +			const char *err = str_error_r(-ret, errbuf, sizeof(errbuf));
> +
> +			ui__error("Could not read the CPU topology map: %s\n", err);
> +			return ret;
> +		}
>  	}
>  
>  	ret = perf_top__start_counters(top);
>  	if (ret)
> -		goto out_delete;
> +		return ret;
>  
>  	ret = perf_evlist__apply_drv_configs(evlist, &pos, &err_term);
>  	if (ret) {
> @@ -1257,7 +1258,7 @@ static int __cmd_top(struct perf_top *top)
>  	ret = -1;
>  	if (pthread_create(&thread_process, NULL, process_thread, top)) {
>  		ui__error("Could not create process thread.\n");
> -		goto out_delete;
> +		return ret;
>  	}
>  
>  	if (pthread_create(&thread, NULL, (use_browser > 0 ? display_thread_tui :
> @@ -1301,19 +1302,7 @@ static int __cmd_top(struct perf_top *top)
>  out_join_thread:
>  	pthread_cond_signal(&top->qe.cond);
>  	pthread_join(thread_process, NULL);
> -out_delete:
> -	perf_session__delete(top->session);
> -	top->session = NULL;
> -
>  	return ret;
> -
> -out_err_cpu_topo: {
> -	char errbuf[BUFSIZ];
> -	const char *err = str_error_r(-ret, errbuf, sizeof(errbuf));
> -
> -	ui__error("Could not read the CPU topology map: %s\n", err);
> -	goto out_delete;
> -}
>  }
>  
>  static int
> @@ -1644,10 +1633,17 @@ int cmd_top(int argc, const char **argv)
>  		signal(SIGWINCH, winch_sig);
>  	}
>  
> +	top.session = perf_session__new(NULL, false, NULL);
> +	if (top.session == NULL) {
> +		status = -1;
> +		goto out_delete_evlist;
> +	}
> +
>  	status = __cmd_top(&top);
>  
>  out_delete_evlist:
>  	perf_evlist__delete(top.evlist);
> +	perf_session__delete(top.session);
>  
>  	return status;
>  }
> -- 
> 2.19.1
> 
> 
> 

-- 
Linaro - Kernel Validation
