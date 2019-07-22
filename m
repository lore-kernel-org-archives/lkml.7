Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104EAC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DEB216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBa9LUpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbfGVTjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:39:31 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40082 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfGVTjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:39:31 -0400
Received: by mail-qk1-f194.google.com with SMTP id s145so29404755qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LChY1sbu1+LC+YxX6vN9ih8Kpijqy99VRh++JE8a6k4=;
        b=RBa9LUpwTej/FGkdMBV2FO2i41fBVHrMv0POFjBa4sI/sM5gndIquj/2bxGcMY3fCC
         BFnUI112jqUF+1SipN/BJ6wzE3Qs2piURmseoTDf5YaYRWwBMS0jZDNAotyjUVXg+4i7
         2jLgNjizr0mGcWPwvXGO1CXVU80tUJCIN7kNWiW6S6jT6Tp9nuDq0U6jVk6YeiCgiK1j
         Lrr2ll+Abl0oyEgurHGAu5utdgV/mt9ZCL2CQKBhtqLzFQm0zJd7bKtWnQPxR0QcqZSs
         Ik3Kkflq9LcXXLpApuXu/5xuao7+1xozlBLAQzjrgI4J0H+3diZmb44ATDH1h5WZxrRz
         A5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LChY1sbu1+LC+YxX6vN9ih8Kpijqy99VRh++JE8a6k4=;
        b=XEZA3ZDEJ2T6JHthAo/sIdNu6F/VOQxotq8mwOXv/uh/cMkzenGf+iad0ghdWI8/Om
         bqpXQ53/G0hEnwnm56lcCrC0VGrH6SZt0pSghqD6U3U2NeIwyD7qAQcToDSsxf50Yk4z
         suUuZUilNczHWyjQSx2IkRfros2O3hwIXPA+5XuW++h0a78i9E1Uq5WLI/MHuRvhw8sT
         5tPASuyp1U5LxMP4CadEEmc3JRKC0uoIG4Vj1RC0CkGlBH66DmTe0hKqdEeGUQma0ZlW
         +XyeK+qgK15oH9ixEK2NBUFQ17SXQZaEoPzmgjh/AuxEHk8V2uwtHISwVeZBmCoQfCEd
         Wnyw==
X-Gm-Message-State: APjAAAVMIgp1syZsaX/6zxww8PYyrVO1eD6Nhsx5H5vl1YR5nBljTU0p
        7uLbX4lHfc1QHRJgUghQzRM=
X-Google-Smtp-Source: APXvYqyzFeZgk4iYMewEImJeABmRKbOenqz/mMoYMAv9xpt0cJ5qKHB4wnVNDYL+IgWrN/aN7k94FQ==
X-Received: by 2002:a37:7ec1:: with SMTP id z184mr48150871qkc.491.1563824369751;
        Mon, 22 Jul 2019 12:39:29 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([2804:1b1:210a:ccf0:9924:e487:2782:cded])
        by smtp.gmail.com with ESMTPSA id r40sm25657181qtk.2.2019.07.22.12.39.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:39:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C5F3440340; Mon, 22 Jul 2019 16:39:25 -0300 (-03)
Date:   Mon, 22 Jul 2019 16:39:25 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 38/79] libperf: Add perf_evlist__init function
Message-ID: <20190722193925.GV3624@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-39-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721112506.12306-39-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 21, 2019 at 01:24:25PM +0200, Jiri Olsa escreveu:
> Adding perf_evlist__init function to initialize
> perf_evlist struct.
> 
> Link: http://lkml.kernel.org/n/tip-uhs894b98iiydutjgr1z5t8h@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/lib/evlist.c              | 5 +++++
>  tools/perf/lib/include/perf/evlist.h | 4 ++++
>  tools/perf/lib/libperf.map           | 1 +
>  tools/perf/util/evlist.c             | 3 ++-
>  4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
> index 646bdd518793..fdc8c1894b37 100644
> --- a/tools/perf/lib/evlist.c
> +++ b/tools/perf/lib/evlist.c
> @@ -2,3 +2,8 @@
>  #include <perf/evlist.h>
>  #include <linux/list.h>
>  #include <internal/evlist.h>
> +
> +void perf_evlist__init(struct perf_evlist *evlist)
> +{
> +	INIT_LIST_HEAD(&evlist->entries);
> +}
> diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
> index 92b0eb39caec..1ddfcca0bd01 100644
> --- a/tools/perf/lib/include/perf/evlist.h
> +++ b/tools/perf/lib/include/perf/evlist.h
> @@ -2,6 +2,10 @@
>  #ifndef __LIBPERF_EVLIST_H
>  #define __LIBPERF_EVLIST_H
>  
> +#include <perf/core.h>
> +
>  struct perf_evlist;
>  
> +LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
> +
>  #endif /* __LIBPERF_EVLIST_H */
> diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
> index 54f8503c6d82..5ca6ff6fcdfa 100644
> --- a/tools/perf/lib/libperf.map
> +++ b/tools/perf/lib/libperf.map
> @@ -10,6 +10,7 @@ LIBPERF_0.0.1 {
>  		perf_thread_map__get;
>  		perf_thread_map__put;
>  		perf_evsel__init;
> +		perf_evlist__init;
>  	local:
>  		*;
>  };
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index faf3ffd81d4c..aacddd9b2d64 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -33,6 +33,7 @@
>  #include <linux/log2.h>
>  #include <linux/err.h>
>  #include <linux/zalloc.h>
> +#include <perf/evlist.h>
>  
>  #ifdef LACKS_SIGQUEUE_PROTOTYPE
>  int sigqueue(pid_t pid, int sig, const union sigval value);
> @@ -48,11 +49,11 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
>  
>  	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
>  		INIT_HLIST_HEAD(&evlist->heads[i]);
> -	INIT_LIST_HEAD(&evlist->core.entries);
>  	perf_evlist__set_maps(evlist, cpus, threads);
>  	fdarray__init(&evlist->pollfd, 64);
>  	evlist->workload.pid = -1;
>  	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
> +	perf_evlist__init(&evlist->core);
>  }

This causes a segfault, since perf_evlist__set_maps() will touch stuff
that you now moved to the end of this function, applying the patch at
the end of this message fixes the issue, i.e. keeps the existing init
ordering and avoids the segfault:

gdb) run stat sleep 1
Starting program: /root/bin/perf stat sleep 1
Program received signal SIGSEGV, Segmentation fault.
0x00000000004f6b55 in __perf_evlist__propagate_maps (evlist=0xbb34c0, evsel=0x0) at util/evlist.c:161
161		if (!evsel->own_cpus || evlist->has_user_cpus) {
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-29.fc30.x86_64 elfutils-libelf-0.176-3.fc30.x86_64 elfutils-libs-0.176-3.fc30.x86_64 glib2-2.60.4-1.fc30.x86_64 libbabeltrace-1.5.6-2.fc30.x86_64 libgcc-9.1.1-1.fc30.x86_64 libunwind-1.3.1-2.fc30.x86_64 libuuid-2.33.2-1.fc30.x86_64 libxcrypt-4.4.6-2.fc30.x86_64 libzstd-1.4.0-1.fc30.x86_64 numactl-libs-2.0.12-2.fc30.x86_64 pcre-8.43-2.fc30.x86_64 perl-libs-5.28.2-436.fc30.x86_64 popt-1.16-17.fc30.x86_64 python2-libs-2.7.16-2.fc30.x86_64 slang-2.3.2-5.fc30.x86_64 xz-libs-5.2.4-5.fc30.x86_64 zlib-1.2.11-15.fc30.x86_64
(gdb) bt
#0  0x00000000004f6b55 in __perf_evlist__propagate_maps (evlist=0xbb34c0, evsel=0x0) at util/evlist.c:161
#1  0x00000000004f6c7a in perf_evlist__propagate_maps (evlist=0xbb34c0) at util/evlist.c:178
#2  0x00000000004f955e in perf_evlist__set_maps (evlist=0xbb34c0, cpus=0x0, threads=0x0) at util/evlist.c:1128
#3  0x00000000004f66f8 in evlist__init (evlist=0xbb34c0, cpus=0x0, threads=0x0) at util/evlist.c:52
#4  0x00000000004f6790 in evlist__new () at util/evlist.c:64
#5  0x0000000000456071 in cmd_stat (argc=3, argv=0x7fffffffd670) at builtin-stat.c:1705
#6  0x00000000004dd0fa in run_builtin (p=0xa21e00 <commands+288>, argc=3, argv=0x7fffffffd670) at perf.c:304
#7  0x00000000004dd367 in handle_internal_command (argc=3, argv=0x7fffffffd670) at perf.c:356
#8  0x00000000004dd4ae in run_argv (argcp=0x7fffffffd4cc, argv=0x7fffffffd4c0) at perf.c:400
#9  0x00000000004dd81a in main (argc=3, argv=0x7fffffffd670) at perf.c:522
(gdb) bt

I'm applying it to fix this issue and avoid a bisection break. I'm now
going to run 'perf test' after each cset too. And probably the next cset
has this issue as well, i.e. reordering of initialization in the
perf_evsel__init() case.

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index aacddd9b2d64..f4aa6cf80559 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -49,11 +49,11 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 
 	for (i = 0; i < PERF_EVLIST__HLIST_SIZE; ++i)
 		INIT_HLIST_HEAD(&evlist->heads[i]);
+	perf_evlist__init(&evlist->core);
 	perf_evlist__set_maps(evlist, cpus, threads);
 	fdarray__init(&evlist->pollfd, 64);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
-	perf_evlist__init(&evlist->core);
 }
 
 struct evlist *evlist__new(void)
