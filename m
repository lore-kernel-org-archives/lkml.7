Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF9BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2057120675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 19:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyYaa/Zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfCGTME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 14:12:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33326 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfCGTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 14:12:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id x9so9742362qkf.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 11:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cpfggOg3lyaSZBxbnfIxBL3zqoeOYTpPDR54+P8F1RI=;
        b=JyYaa/ZdmxfhGOkWwuf34+liJt0Ui/ZSx7c7SlyviXtacQfPbm/v8iRDjsB03P9vsT
         RsYRvpQzLj2U9XZBL/LpWpPF9aknlK9qct44HofmvGUmfzWaJO+iAl8PmmvtF461Wlqg
         iWDXdMXTOSa9jULDFdPs6vhZGEo+WX2Ki5osPzVmHVLJmejm64+UPo0UpzXcp2RpBm4Z
         j5ONyTusQdGmAuGGIIu9gM6jFCpVR6E6xtnhQfLXr/7XvPl5GhSP5QE12ZBw8uRIK/Sr
         Ff3Rj8bgpGDFZEOrPS/o/V8haRYZmPH0Lta8ASQknvhwxzJ5t+t+qoTOh6CDSnvOaND5
         ZDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cpfggOg3lyaSZBxbnfIxBL3zqoeOYTpPDR54+P8F1RI=;
        b=UWww6n9gWzlTET08HFhcCcp8i0q3EP2MBEhh7oMJmHrVwyLVK9gJOzAuH+xBOWbNt8
         fcV+OckLvx8pNuh39WWIwt7gG/OxauJwNGB+lxAUitlxBeow0VvSKKfXaab306NY3IVI
         oNf/sIVV8uvIokumUyBaeD1q52mAb24wL4XUx8/nU8AH3dqcW0JKcpzfsyGUh+xaGMx3
         4kT+4xqQIvWbpVDJWaMuOaXwiTgKelJ3qlLACTKo4icl7gozKPQ9aJII55ppuockfM+g
         LTjaspvtICYRZWbyW3dWLdueEQoftYWfdhuD5I8BXGVDxeDVVKTG1kWEAa/nQFueEs6d
         VXRg==
X-Gm-Message-State: APjAAAUQNYcXMmiGPwx0EQOAPbufykKRwn1hsR/7bMIHQIU6pY/nkARI
        M11cZnvgEbgoEygMmantc/uimVLNQFE=
X-Google-Smtp-Source: APXvYqwME5Oza9BsztDkuAQcodg5FH8wP/oQx9oXsXXmfbYhILkUe0twGXwz9sTX5Z0pdJddGvlieg==
X-Received: by 2002:a05:620a:1403:: with SMTP id d3mr2631712qkj.16.1551985922492;
        Thu, 07 Mar 2019 11:12:02 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id d51sm3742963qta.31.2019.03.07.11.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 11:12:01 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 063F04039C; Thu,  7 Mar 2019 16:11:58 -0300 (-03)
Date:   Thu, 7 Mar 2019 16:11:57 -0300
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Ingo Molnar <mingo@kernel.org>, mgorman@techsingularity.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] tools/perf-bench: Add basic syscall benchmark
Message-ID: <20190307191157.GB32240@kernel.org>
References: <20190307185253.28432-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307185253.28432-1-dave@stgolabs.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 07, 2019 at 10:52:53AM -0800, Davidlohr Bueso escreveu:
> The usefulness of having a standard way of testing syscall performance
> has come up from time to time[0]. Furthermore, some of our testing
> machinery (such as 'mmtests') already makes use of a simplified version
> of the microbenchmark. This patch mainly takes the same idea to measure
> syscall throughput compatible with 'perf-bench' via getppid(2), yet
> without any of the additional template stuff from Ingo's version (based
> on numa.c). The code is identical to what mmtests uses.

You forgot to update tools/perf/Documentation/perf-bench.txt, and please
take a look at tools/perf/util/pmu.c convert_scale() to see how to save
the current locale, set the one you want, then restore the previous one,
so that at the end of this benchmark the environment is back to where it
was.

Thanks.

- Arnaldo
 
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1067469.html
> 
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
> ---
>  tools/perf/bench/Build     |  1 +
>  tools/perf/bench/bench.h   |  1 +
>  tools/perf/bench/syscall.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
>  tools/perf/builtin-bench.c |  8 +++++
>  4 files changed, 90 insertions(+)
>  create mode 100644 tools/perf/bench/syscall.c
> 
> diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
> index e4e321b6f883..839f9b790587 100644
> --- a/tools/perf/bench/Build
> +++ b/tools/perf/bench/Build
> @@ -1,5 +1,6 @@
>  perf-y += sched-messaging.o
>  perf-y += sched-pipe.o
> +perf-y += syscall.o
>  perf-y += mem-functions.o
>  perf-y += futex-hash.o
>  perf-y += futex-wake.o
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index fddb3ced9db6..31ad3283d41b 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -29,6 +29,7 @@
>  int bench_numa(int argc, const char **argv);
>  int bench_sched_messaging(int argc, const char **argv);
>  int bench_sched_pipe(int argc, const char **argv);
> +int bench_syscall_basic(int argc, const char **argv);
>  int bench_mem_memcpy(int argc, const char **argv);
>  int bench_mem_memset(int argc, const char **argv);
>  int bench_futex_hash(int argc, const char **argv);
> diff --git a/tools/perf/bench/syscall.c b/tools/perf/bench/syscall.c
> new file mode 100644
> index 000000000000..149129cca639
> --- /dev/null
> +++ b/tools/perf/bench/syscall.c
> @@ -0,0 +1,80 @@
> +/*
> + *
> + * syscall.c
> + *
> + * syscall: Benchmark for system call performance
> + */
> +#include "../perf.h"
> +#include "../util/util.h"
> +#include <subcmd/parse-options.h>
> +#include "../builtin.h"
> +#include "bench.h"
> +
> +#include <stdio.h>
> +#include <locale.h>
> +#include <sys/time.h>
> +#include <sys/syscall.h>
> +
> +#define LOOPS_DEFAULT 10000000
> +static	int loops = LOOPS_DEFAULT;
> +
> +static const struct option options[] = {
> +	OPT_INTEGER('l', "loop",	&loops,		"Specify number of loops"),
> +	OPT_END()
> +};
> +
> +static const char * const bench_syscall_usage[] = {
> +	"perf bench syscall <options>",
> +	NULL
> +};
> +
> +int bench_syscall_basic(int argc, const char **argv)
> +{
> +	struct timeval start, stop, diff;
> +	unsigned long long result_usec = 0;
> +	int i;
> +
> +	argc = parse_options(argc, argv, options, bench_syscall_usage, 0);
> +
> +	gettimeofday(&start, NULL);
> +
> +	for (i = 0; i < loops; i++)
> +		getppid();
> +
> +	gettimeofday(&stop, NULL);
> +	timersub(&stop, &start, &diff);
> +
> +	switch (bench_format) {
> +	case BENCH_FORMAT_DEFAULT:
> +		setlocale(LC_NUMERIC, "");
> +		printf("# Executed %'d getppid() calls\n", loops);
> +
> +		result_usec = diff.tv_sec * 1000000;
> +		result_usec += diff.tv_usec;
> +
> +		printf(" %14s: %lu.%03lu [sec]\n\n", "Total time",
> +		       diff.tv_sec,
> +		       (unsigned long) (diff.tv_usec/1000));
> +
> +		printf(" %14lf usecs/op\n",
> +		       (double)result_usec / (double)loops);
> +		printf(" %'14d ops/sec\n",
> +		       (int)((double)loops /
> +			     ((double)result_usec / (double)1000000)));
> +		break;
> +
> +	case BENCH_FORMAT_SIMPLE:
> +		printf("%lu.%03lu\n",
> +		       diff.tv_sec,
> +		       (unsigned long) (diff.tv_usec / 1000));
> +		break;
> +
> +	default:
> +		/* reaching here is something disaster */
> +		fprintf(stderr, "Unknown format:%d\n", bench_format);
> +		exit(1);
> +		break;
> +	}
> +
> +	return 0;
> +}
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index 334c77ffc1d9..4e9dd0f4eced 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -11,6 +11,7 @@
>   * Available benchmark collection list:
>   *
>   *  sched ... scheduler and IPC performance
> + *  syscall ... System call performance
>   *  mem   ... memory access performance
>   *  numa  ... NUMA scheduling and MM performance
>   *  futex ... Futex performance
> @@ -50,6 +51,12 @@ static struct bench sched_benchmarks[] = {
>  	{ NULL,		NULL,						NULL			}
>  };
>  
> +static struct bench syscall_benchmarks[] = {
> +	{ "basic",	"Benchmark for basic getppid() system calls",	bench_syscall_basic	},
> +	{ "all",	"Run all syscall benchmarks",			NULL			},
> +	{ NULL,		NULL,						NULL			},
> +};
> +
>  static struct bench mem_benchmarks[] = {
>  	{ "memcpy",	"Benchmark for memcpy() functions",		bench_mem_memcpy	},
>  	{ "memset",	"Benchmark for memset() functions",		bench_mem_memset	},
> @@ -85,6 +92,7 @@ struct collection {
>  
>  static struct collection collections[] = {
>  	{ "sched",	"Scheduler and IPC benchmarks",			sched_benchmarks	},
> +	{ "syscall",	"System call benchmarks",			syscall_benchmarks	},
>  	{ "mem",	"Memory access benchmarks",			mem_benchmarks		},
>  #ifdef HAVE_LIBNUMA_SUPPORT
>  	{ "numa",	"NUMA scheduling and MM benchmarks",		numa_benchmarks		},
> -- 
> 2.16.4

-- 

- Arnaldo
