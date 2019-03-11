Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B0AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E6C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeXrkCA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfCKSWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:22:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35433 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCKSWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:22:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id b16so5106671qtt.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wLQa4UCGmstXjyVit0hJDGZjCmC4cy2B9qKpSVMWjYA=;
        b=CeXrkCA8hrzLhSbldSMGvbiULQB2gaC7Sba2o2OgN5IxVlKYr+sG6DFQAvhHtYnqoA
         RO9cshePev8sUkuyuUDAEUAgRkaJbRqTklmrIfbUA1uoz0cKYtl0wRlcTwmctvOGkD2A
         O/lxMUwIuDvJi1JMugBi0BIUSEidjfboDMEwEOYD9ha3AhkPueC4W4/UP8/wkGJHMmzR
         nKkCFjRSXjbI83EXcTMLwHPUw6RAyxm8Q7UA1ZFtysn1vAJyEVX90llKCr+oEmuAQjfG
         NuBZOlAxUfJCJEOvOZD7JgXPT9Xj+o9maymMUwV9tqhj1WqHxmcRB5JMBU1k2f4zWbk8
         pg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wLQa4UCGmstXjyVit0hJDGZjCmC4cy2B9qKpSVMWjYA=;
        b=FmayleD1FkrdHBe/kUJAt7ewoJgRcPmx3AXXdVB2cQjXsa54AXX/1FYK5yRm54GcdZ
         nwCufA7gBdtNfARShmfo6BRFDtzldnKbC7KC814neHNc7oRbLM5hSK5aqokA8YUwDrpU
         ZsaVZmW1Eb6YKQrtDUaAd4MZY+tfayFraFHZmNLihJc9uOKFYDWaVdlZ/2EftZXMVDd1
         FE7H7HCzVBjS82WXFgoc53F+fCL1AsYCLhHBjWRx+YYGePYJXyZmvM1/bF69DUmAykCH
         +DRCCRskWpTxEkRk/KLVK0TvUQgNMMW+DlRIAcFd58dwgTgnxOVcfy8riRZu8Oe6hwKW
         70zg==
X-Gm-Message-State: APjAAAXcRIUQM85c04aoYIng+xY7WAerfwC5TGZz6uljmx1ttQY5K5Qw
        zr21XyPo/k73F88SUgAqCqk=
X-Google-Smtp-Source: APXvYqzcKDYcgG1zO2zKzIw6qkm9RYiZdRag3wMDynNV/W6U1c/dEx7HjoWAro4IEN9B8Y7X4xVbPA==
X-Received: by 2002:a0c:96f5:: with SMTP id b50mr26504247qvd.11.1552328571782;
        Mon, 11 Mar 2019 11:22:51 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.162.132.204])
        by smtp.gmail.com with ESMTPSA id s5sm3824210qkf.87.2019.03.11.11.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 11:22:50 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C2D3C4039C; Mon, 11 Mar 2019 15:22:47 -0300 (-03)
Date:   Mon, 11 Mar 2019 15:22:47 -0300
To:     Jiwei Sun <jiwei.sun@windriver.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf record: Add support for limit perf output file
 size
Message-ID: <20190311182247.GW10690@kernel.org>
References: <20190311071233.13777-1-jiwei.sun@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311071233.13777-1-jiwei.sun@windriver.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 03:12:33PM +0800, Jiwei Sun escreveu:
> The patch adds a new option to limit the output file size, then based
> on it, we can create a wrapper of the perf command that uses the option
> to avoid exhausting the disk space by the unconscious user.
> 
> Testing it:
> 
>   # ./perf record -a --max-size 100M
>   Couldn't synthesize bpf events.
>   WARNING: The perf data has already reached the limit, stop recording!
>   WARNING: The perf data has already reached the limit, stop recording!
>   WARNING: The perf data has already reached the limit, stop recording!
>   WARNING: The perf data has already reached the limit, stop recording!
>   WARNING: The perf data has already reached the limit, stop recording!
>   WARNING: The perf data has already reached the limit, stop recording!
>   WARNING: The perf data has already reached the limit, stop recording!
>   WARNING: The perf data has already reached the limit, stop recording!

why so many messages? I tried with --max-size 50K and got way more
messages, please find why this is taking place and try show just one
message and finish the command as soon as the max size is reached.

- Arnaldo

>   [ perf record: Woken up 392 times to write data ]
>   [ perf record: Captured and wrote 100.104 MB perf.data (2128267 samples) ]
>   Terminated
> 
>   # ls -lh perf.data
>   -rw------- 1 root root 101M Mar 11 14:48 perf.data
> 
> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
> ---
> v3 changes:
>   - add a test result
>   - add the new option to tools/perf/Documentation/perf-record.txt
> 
> v2 changes:
>   - make patch based on latest Arnaldo's perf/core,
>   - display warning message when reached the limit.
> ---
>  tools/perf/Documentation/perf-record.txt |  3 ++
>  tools/perf/builtin-record.c              | 42 ++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 8f0c2be34848..731dcfabe7fa 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -524,6 +524,9 @@ config terms. For example: 'cycles/overwrite/' and 'instructions/no-overwrite/'.
>  
>  Implies --tail-synthesize.
>  
> +--max-size::
> +Limit the output data max size.
> +
>  SEE ALSO
>  --------
>  linkperf:perf-stat[1], linkperf:perf-list[1]
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index a468d882e74f..fe0e87781841 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -83,6 +83,7 @@ struct record {
>  	struct switch_output	switch_output;
>  	unsigned long long	samples;
>  	cpu_set_t		affinity_mask;
> +	unsigned long		output_max_size;	/* = 0: unlimited */
>  };
>  
>  static volatile int auxtrace_record__snapshot_started;
> @@ -112,6 +113,12 @@ static bool switch_output_time(struct record *rec)
>  	       trigger_is_ready(&switch_output_trigger);
>  }
>  
> +static bool record__output_max_size_exceeded(struct record *rec)
> +{
> +	return (rec->output_max_size &&
> +	       rec->bytes_written >= rec->output_max_size);
> +}
> +
>  static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
>  			 void *bf, size_t size)
>  {
> @@ -124,6 +131,12 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
>  
>  	rec->bytes_written += size;
>  
> +	if (record__output_max_size_exceeded(rec)) {
> +		pr_warning("WARNING: The perf data has already reached "
> +			   "the limit, stop recording!\n");
> +		raise(SIGTERM);
> +	}
> +
>  	if (switch_output_size(rec))
>  		trigger_hit(&switch_output_trigger);
>  
> @@ -1672,6 +1685,33 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
>  	return 0;
>  }
>  
> +static int parse_output_max_size(const struct option *opt,
> +				 const char *str, int unset)
> +{
> +	unsigned long *s = (unsigned long *)opt->value;
> +	static struct parse_tag tags_size[] = {
> +		{ .tag  = 'B', .mult = 1       },
> +		{ .tag  = 'K', .mult = 1 << 10 },
> +		{ .tag  = 'M', .mult = 1 << 20 },
> +		{ .tag  = 'G', .mult = 1 << 30 },
> +		{ .tag  = 0 },
> +	};
> +	unsigned long val;
> +
> +	if (unset) {
> +		*s = 0;
> +		return 0;
> +	}
> +
> +	val = parse_tag_value(str, tags_size);
> +	if (val != (unsigned long) -1) {
> +		*s = val;
> +		return 0;
> +	}
> +
> +	return -1;
> +}
> +
>  static int record__parse_mmap_pages(const struct option *opt,
>  				    const char *str,
>  				    int unset __maybe_unused)
> @@ -1983,6 +2023,8 @@ static struct option __record_options[] = {
>  	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
>  		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
>  		     record__parse_affinity),
> +	OPT_CALLBACK(0, "max-size", &record.output_max_size,
> +		     "size", "Limit the maximum size of the output file", parse_output_max_size),
>  	OPT_END()
>  };
>  
> -- 
> 2.20.1

-- 

- Arnaldo
