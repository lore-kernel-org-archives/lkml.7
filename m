Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C801CC4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B3A120B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 19:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pka68BAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733105AbfIWTKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 15:10:45 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40425 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfIWTKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 15:10:44 -0400
Received: by mail-qt1-f194.google.com with SMTP id x5so18516093qtr.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 12:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nh5uQxofgjd/HxLCPXYGjgYm+Vw5vt2amQBb4m/iRaw=;
        b=Pka68BAZvVh68+0J/sNuwZVMZOTXIHn2PTBmmhgSdNoubx8xw0lHmj0BjwW0aDJdKC
         r+VVFjMFcZILPWNKTCjAYe5rlMj84sI4EV3UR45Nxp/UQ1CGJxPFgjLtOrppk0MG7bcD
         KrIgb6eTrRJjzc/2Wjx6l/lVuqAYBczzQBb09/wMt0skHLF9pywsVyWssYntmtEorAlX
         jD7SK/bfBHN3tgEM7jLPexDIfSIoeBVfqwVMlZz1Z05T3RGMGY4a0m7w3ViNLEwwqs00
         3zorWdJsF6s0aEYwe1ItaN/w4+jUPnIdT94ZMe3f5D9/4SN9+GznVl8m3AkIg+25v55D
         hQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nh5uQxofgjd/HxLCPXYGjgYm+Vw5vt2amQBb4m/iRaw=;
        b=VPp44/7l1r/FO2L4jNFDGQlRKc3BG+NK4MRTjcQIV7B2BSzhyfllIsqTVdHtG8F++Y
         Sb6lxmdDzVWFHXyLPr2nctiO/9Zhq/P/gmmjg8N2I1+68OF6e569d9P/w6390J6XZbNo
         xCeltsN991DcnPG37xFi8QxVSFVUE15rqt63ieHaUb8QYHBBYAsoQlyv0GzPHbUeo7dg
         5XaGDAjS+c/UV+nO8UgfN5U9zxBDhhMEBUs6t/ZLn8xRRSSwzNQ9sXv6LqxUwPyva1VQ
         JC13lDGFQkSH3t6Z0+WQeMiUeuCNX3YE6Hd1LDzKOfeRXtgFu+hz5VaH9vng/2j4KlvL
         mJKA==
X-Gm-Message-State: APjAAAXLPB6a6tZeJJWe+Ct6btCotmgxcJ3SN7PiuBGEZAn067TlXBuD
        GMG1qV/d0RoUAxTLQP7qDH4=
X-Google-Smtp-Source: APXvYqy/cWKN12crGTYgtE2FlSKNE5gqE2uo7G43mNK0TPuy9yOXwZc5Yal1ksCJCOIypiOCdc1cng==
X-Received: by 2002:ac8:7644:: with SMTP id i4mr1754974qtr.62.1569265843026;
        Mon, 23 Sep 2019 12:10:43 -0700 (PDT)
Received: from quaco.ghostprotocols.net (189-94-129-1.3g.claro.net.br. [189.94.129.1])
        by smtp.gmail.com with ESMTPSA id v5sm7796794qtk.66.2019.09.23.12.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 12:10:41 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5392F41105; Mon, 23 Sep 2019 16:10:36 -0300 (-03)
Date:   Mon, 23 Sep 2019 16:10:36 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH 32/73] libperf: Move page_size into libperf
Message-ID: <20190923191036.GB13508@kernel.org>
References: <20190913132355.21634-1-jolsa@kernel.org>
 <20190913132355.21634-33-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913132355.21634-33-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 13, 2019 at 03:23:14PM +0200, Jiri Olsa escreveu:
> We need page_size in libperf, so moving it in there.
> Adding libperf_init as a global libperf init functon.
> 
> Link: http://lkml.kernel.org/n/tip-g6auuaej31nsusuevuhcgxli@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/lib/core.c                 | 7 +++++++
>  tools/perf/lib/include/internal/lib.h | 2 ++
>  tools/perf/lib/include/perf/core.h    | 1 +
>  tools/perf/lib/lib.c                  | 2 ++
>  tools/perf/lib/libperf.map            | 1 +
>  tools/perf/perf.c                     | 4 ++--
>  tools/perf/util/util.h                | 2 --

you forgot to remove it from tools/perf/util/util.c, I did it, and also
added internal/lib.h to the places that use page_size, after this I'll
remove that include from util/util.h, that header has to die :-)

- Arnaldo

>  7 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/lib/core.c b/tools/perf/lib/core.c
> index 29d5e3348718..6689d593c2d1 100644
> --- a/tools/perf/lib/core.c
> +++ b/tools/perf/lib/core.c
> @@ -4,7 +4,9 @@
>  
>  #include <stdio.h>
>  #include <stdarg.h>
> +#include <unistd.h>
>  #include <perf/core.h>
> +#include <internal/lib.h>
>  #include "internal.h"
>  
>  static int __base_pr(enum libperf_print_level level, const char *format,
> @@ -32,3 +34,8 @@ void libperf_print(enum libperf_print_level level, const char *format, ...)
>  	__libperf_pr(level, format, args);
>  	va_end(args);
>  }
> +
> +void libperf_init(void)
> +{
> +	page_size = sysconf(_SC_PAGE_SIZE);
> +}
> diff --git a/tools/perf/lib/include/internal/lib.h b/tools/perf/lib/include/internal/lib.h
> index 0b56f1201dc9..9168b7d2a7e1 100644
> --- a/tools/perf/lib/include/internal/lib.h
> +++ b/tools/perf/lib/include/internal/lib.h
> @@ -4,6 +4,8 @@
>  
>  #include <unistd.h>
>  
> +extern unsigned int page_size;
> +
>  ssize_t readn(int fd, void *buf, size_t n);
>  ssize_t writen(int fd, const void *buf, size_t n);
>  
> diff --git a/tools/perf/lib/include/perf/core.h b/tools/perf/lib/include/perf/core.h
> index c341a7b2c874..ba2f4e76a3e2 100644
> --- a/tools/perf/lib/include/perf/core.h
> +++ b/tools/perf/lib/include/perf/core.h
> @@ -18,5 +18,6 @@ typedef int (*libperf_print_fn_t)(enum libperf_print_level level,
>  				  const char *, va_list ap);
>  
>  LIBPERF_API void libperf_set_print(libperf_print_fn_t fn);
> +LIBPERF_API void libperf_init(void);
>  
>  #endif /* __LIBPERF_CORE_H */
> diff --git a/tools/perf/lib/lib.c b/tools/perf/lib/lib.c
> index 2a81819c3b8c..18658931fc71 100644
> --- a/tools/perf/lib/lib.c
> +++ b/tools/perf/lib/lib.c
> @@ -5,6 +5,8 @@
>  #include <linux/kernel.h>
>  #include <internal/lib.h>
>  
> +unsigned int page_size;
> +
>  static ssize_t ion(bool is_read, int fd, void *buf, size_t n)
>  {
>  	void *buf_start = buf;
> diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
> index dc4d66363bc4..3fbf050b5add 100644
> --- a/tools/perf/lib/libperf.map
> +++ b/tools/perf/lib/libperf.map
> @@ -1,5 +1,6 @@
>  LIBPERF_0.0.1 {
>  	global:
> +		libperf_init;
>  		libperf_set_print;
>  		perf_cpu_map__dummy_new;
>  		perf_cpu_map__get;
> diff --git a/tools/perf/perf.c b/tools/perf/perf.c
> index 1193b923e801..ead18b712d6c 100644
> --- a/tools/perf/perf.c
> +++ b/tools/perf/perf.c
> @@ -25,6 +25,7 @@
>  #include "perf-sys.h"
>  #include <api/fs/fs.h>
>  #include <api/fs/tracing_path.h>
> +#include <internal/lib.h>
>  #include <errno.h>
>  #include <pthread.h>
>  #include <signal.h>
> @@ -438,8 +439,7 @@ int main(int argc, const char **argv)
>  	exec_cmd_init("perf", PREFIX, PERF_EXEC_PATH, EXEC_PATH_ENVIRONMENT);
>  	pager_init(PERF_PAGER_ENVIRONMENT);
>  
> -	/* The page_size is placed in util object. */
> -	page_size = sysconf(_SC_PAGE_SIZE);
> +	libperf_init();
>  
>  	cmd = extract_argv0_path(argv[0]);
>  	if (!cmd)
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 45a5c6f20197..d6ae394e67c4 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -33,8 +33,6 @@ int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size);
>  
>  size_t hex_width(u64 v);
>  
> -extern unsigned int page_size;
> -
>  int sysctl__max_stack(void);
>  
>  int fetch_kernel_version(unsigned int *puint,
> -- 
> 2.21.0

-- 

- Arnaldo
