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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839CEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E65121901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5icFJQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731041AbfGVTJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:09:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36536 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfGVTJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:09:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id g18so29338331qkl.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BorIU3/J9wKYje5vLKBGeW8nSdZEqmGg9FCV3IDdpTk=;
        b=N5icFJQ5/eV9Fyo37LvdzpljMwwK8YxSePpTBCzeKHr9MSE+u5eynHjy6bmgx5YkFn
         U8ZvpSYdUeBfmjiSeDU3GOJGTboZcHfwLOMdXG9P056mz35Kw0a7qxzlygEs8glrY9xE
         SXeyhgVS1rv+GzH5qQ9/rrYXGYXHCWiB6qG0WgI1FhiQibkNtKgW4cqicWYLoF0R8YqA
         XvGdYv/UqgAW0drkcNVxSGfdR0plDBi/aFwXrvhHDJrHhC4aJQG3koj/9jR19ZJiZ1Lh
         13FDAFt9ioi/UUuqVOiYvssbb+kb3n6v9TI+1+474D74QZw/+c6jxKT5eG/trZ+qU84g
         E1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BorIU3/J9wKYje5vLKBGeW8nSdZEqmGg9FCV3IDdpTk=;
        b=eagFH8N1kHQK82VA1llcwZ3AxnP6ydK6LOMwVw3aIVEzCBz9YjmVkWDgdsD6nQlHOf
         t2yKZz0ESWNRjf8SWCcFLni+Nj/WAzWFnj2UWHRH0+j8MvdEmr4TEJAUpoJBKjyXa2Gd
         kXaGn4RoCiDLpxsND8aGs5fSi4PC/a8N0SIV+sXYiTmQE3jMl/g+dUf2TVMv4e3QW+JL
         ghlA4JYWn3Yw5M3ZmX4jF8B0vtD5gPl467L1DmONsa3WqzeuYAYDKfJzgPTIUAuuywu3
         7NO3LR9l9oiTA+98GRDDqJoKhipVbz+ymFHmQgPY4Ftv9cEx64/2/rk8mfD4kfWPfMSG
         7y0g==
X-Gm-Message-State: APjAAAVXrL2QfXig5GLv0MZdHCRGJf06J/IovlnwDh0ZK5yrH+UoXlBp
        INUzrNvBPA8NF2ecqd323G4=
X-Google-Smtp-Source: APXvYqxqiDJtJxX3TMKKtGXGMcFbyAUY5Pp3b1SlcPQL0J8NmXdgDZxK3/72yX6pDtFZysrIeCASZw==
X-Received: by 2002:a05:620a:10bc:: with SMTP id h28mr47502168qkk.289.1563822582234;
        Mon, 22 Jul 2019 12:09:42 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id y20sm19385049qka.14.2019.07.22.12.09.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:09:41 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C74F740340; Mon, 22 Jul 2019 16:09:35 -0300 (-03)
Date:   Mon, 22 Jul 2019 16:09:35 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 39/79] libperf: Add perf_evlist__add function
Message-ID: <20190722190935.GU3624@kernel.org>
References: <20190721112506.12306-1-jolsa@kernel.org>
 <20190721112506.12306-40-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721112506.12306-40-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jul 21, 2019 at 01:24:26PM +0200, Jiri Olsa escreveu:
> Adding perf_evlist__add function to add perf_evsel
> in perf_evlist struct.
> 
> Link: http://lkml.kernel.org/n/tip-pnfovrqcgxquioroelzfzb57@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/lib/evlist.c              | 7 +++++++
>  tools/perf/lib/include/perf/evlist.h | 3 +++
>  tools/perf/lib/libperf.map           | 1 +
>  tools/perf/util/evlist.c             | 2 +-
>  4 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
> index fdc8c1894b37..e5f187fa4e57 100644
> --- a/tools/perf/lib/evlist.c
> +++ b/tools/perf/lib/evlist.c
> @@ -2,8 +2,15 @@
>  #include <perf/evlist.h>
>  #include <linux/list.h>
>  #include <internal/evlist.h>
> +#include <internal/evsel.h>
>  
>  void perf_evlist__init(struct perf_evlist *evlist)
>  {
>  	INIT_LIST_HEAD(&evlist->entries);
>  }
> +
> +void perf_evlist__add(struct perf_evlist *evlist,
> +		      struct perf_evsel *evsel)
> +{
> +	list_add_tail(&evsel->node, &evlist->entries);
> +}
> diff --git a/tools/perf/lib/include/perf/evlist.h b/tools/perf/lib/include/perf/evlist.h
> index 1ddfcca0bd01..6992568b14a0 100644
> --- a/tools/perf/lib/include/perf/evlist.h
> +++ b/tools/perf/lib/include/perf/evlist.h
> @@ -5,7 +5,10 @@
>  #include <perf/core.h>
>  
>  struct perf_evlist;
> +struct perf_evsel;
>  
>  LIBPERF_API void perf_evlist__init(struct perf_evlist *evlist);
> +LIBPERF_API void perf_evlist__add(struct perf_evlist *evlist,
> +				  struct perf_evsel *evsel);
>  
>  #endif /* __LIBPERF_EVLIST_H */
> diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
> index 5ca6ff6fcdfa..06ccf31eb24d 100644
> --- a/tools/perf/lib/libperf.map
> +++ b/tools/perf/lib/libperf.map
> @@ -11,6 +11,7 @@ LIBPERF_0.0.1 {
>  		perf_thread_map__put;
>  		perf_evsel__init;
>  		perf_evlist__init;
> +		perf_evlist__add;
>  	local:
>  		*;
>  };
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index aacddd9b2d64..ea25c7b49a4c 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -180,8 +180,8 @@ static void perf_evlist__propagate_maps(struct evlist *evlist)
>  
>  void evlist__add(struct evlist *evlist, struct evsel *entry)
>  {
> +	perf_evlist__add(&evlist->core, &entry->core);
>  	entry->evlist = evlist;
> -	list_add_tail(&entry->core.node, &evlist->core.entries);
>  	entry->idx = evlist->nr_entries;
>  	entry->tracking = !entry->idx;

Right after applying this patch my alias for building perf crashes:

I.e. I have:

alias m='perf stat -e cycles:u,instructions:u make -k O=/tmp/build/perf  -C tools/perf install-bin'

And I'm applyin your series patch by patch, it stopped working when I
tried to build the next patch in this series, as the previous one caused
the segfault below, investigating...

(gdb) run stat sleep 1
Starting program: /root/bin/perf stat sleep 1
Missing separate debuginfos, use: dnf debuginfo-install glibc-2.29-15.fc30.x86_64
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib64/libthread_db.so.1".

Program received signal SIGSEGV, Segmentation fault.
0x00000000004f6b55 in __perf_evlist__propagate_maps (evlist=0xbb34c0, evsel=0x0) at util/evlist.c:161
161		if (!evsel->own_cpus || evlist->has_user_cpus) {
Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.6-29.fc30.x86_64 elfutils-libelf-0.176-3.fc30.x86_64 elfutils-libs-0.176-3.fc30.x86_64 glib2-2.60.4-1.fc30.x86_64 libbabeltrace-1.5.6-2.fc30.x86_64 libgcc-9.1.1-1.fc30.x86_64 libunwind-1.3.1-2.fc30.x86_64 libuuid-2.33.2-1.fc30.x86_64 libxcrypt-4.4.6-2.fc30.x86_64 libzstd-1.4.0-1.fc30.x86_64 numactl-libs-2.0.12-2.fc30.x86_64 pcre-8.43-2.fc30.x86_64 perl-libs-5.28.2-436.fc30.x86_64 popt-1.16-17.fc30.x86_64 python2-libs-2.7.16-2.fc30.x86_64 slang-2.3.2-5.fc30.x86_64 xz-libs-5.2.4-5.fc30.x86_64 zlib-1.2.11-15.fc30.x86_64
(gdb) p evsel
$1 = (struct evsel *) 0x0
(gdb) p evlist
$2 = (struct evlist *) 0xbb34c0
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
(gdb)
