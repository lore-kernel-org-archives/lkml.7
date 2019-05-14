Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF813C04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CFB020879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k6ttN9eR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfENUUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:20:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44009 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfENUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:20:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id i26so583985qtr.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gZocbH1Di1rsFgF3VC7v1kg6+HcxSdWCx1IalFX1S2k=;
        b=k6ttN9eR7ESD21xulpotRBey2M9jQbECFyuZDaclC14g7m3O6u3lrmXEwPbjLIEcIa
         ClwBDE1GOsZdGy+NeHHTVXF4UA63aO2Nz1xVTKIL81tYpTOtcXGSuL63XmBNysC5tUya
         Vvkavd5NmPsCChJlCn5wQ+0f/YW3U0sHNxB6lusBmqGMk8PqP23AH9DkrwX0kJNuCgdJ
         GUvuEErc3O1Tz4DgTEbyRC9EtdmzRGD/sYPjebd+mHw6pnmsNLQBGvw0VSUJHA8gfkCq
         ndo6cYswEpuO33rugNwlz9FeVmkIYwHdfqxcet8eOd7VvUCRSKOaipkgg5GpWi/+xmb0
         c5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gZocbH1Di1rsFgF3VC7v1kg6+HcxSdWCx1IalFX1S2k=;
        b=nUGdU7y3PbLnB242AWXiIC8QHCZJt3COzzWN+L5wBLwLZLzF+iVwWr+pVqcqpm/sHb
         GupJ7iJStlnwwQd9jPSfxEJctit/gm4R4Lj27uucFjk9xbMWHqe1XBDvzs7fJngQRvu6
         +8JLdW5GKJoBupCNWNVEZ7tweP6lG3Dyzy02/O6XcvVEBtUaH7BAx/zAgBZu6MVsQfDg
         F+UG2sjCqkRFmhJWgg0LCdXGX/JYUHnUcd4l8kt894qad6BU5GDlke29Z3H2NM8U2OsW
         AEM4E9Xhn9wf0qRpkVFo8HUObRIPjshUbLYLKUHc6ptJxIrUM+uvwMs3c35W9T7RbpFY
         uf4g==
X-Gm-Message-State: APjAAAWzyPjqEdnkoVgQPKnBglvV+Y3qAmzNVaqGKHmSNniWFsTQy4Pw
        D4mkf26G09rLKrcKKLjFIt4BhcJymAk=
X-Google-Smtp-Source: APXvYqw3t0XAgrJP6dbXhiAi9mtJeAcx37cGx3uOqDmvut6jBxvj8f357eiQB1eVDIcE0cm/I4Dx2w==
X-Received: by 2002:aed:3c2e:: with SMTP id t43mr19643686qte.39.1557865249652;
        Tue, 14 May 2019 13:20:49 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-182-78.3g.claro.net.br. [179.240.182.78])
        by smtp.gmail.com with ESMTPSA id g9sm5230427qtj.67.2019.05.14.13.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 13:20:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 80938403AD; Tue, 14 May 2019 17:20:41 -0300 (-03)
Date:   Tue, 14 May 2019 17:20:41 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 09/12] perf record: implement
 -z,--compression_level[=<n>] option
Message-ID: <20190514202041.GC8945@kernel.org>
References: <12cce142-6238-475b-b9aa-236531c12c2b@linux.intel.com>
 <9ff06518-ae63-a908-e44d-5d9e56dd66d9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ff06518-ae63-a908-e44d-5d9e56dd66d9@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 18, 2019 at 08:44:42PM +0300, Alexey Budankov escreveu:
> 
> Implemented -z,--compression_level[=<n>] option that enables compression
> of mmaped kernel data buffers content in runtime during perf record
> mode collection. Default option value is 1 (fastest compression).
> 
> Compression overhead has been measured for serial and AIO streaming
> when profiling matrix multiplication workload:
> 
>     -------------------------------------------------------------
>     | SERIAL			  | AIO-1                       |
> ----------------------------------------------------------------|
> |-z | OVH(x) | ratio(x) size(MiB) | OVH(x) | ratio(x) size(MiB) |
> |---------------------------------------------------------------|
> | 0 | 1,00   | 1,000    179,424   | 1,00   | 1,000    187,527   |
> | 1 | 1,04   | 8,427    181,148   | 1,01   | 8,474    188,562   |
> | 2 | 1,07   | 8,055    186,953   | 1,03   | 7,912    191,773   |
> | 3 | 1,04   | 8,283    181,908   | 1,03   | 8,220    191,078   |
> | 5 | 1,09   | 8,101    187,705   | 1,05   | 7,780    190,065   |
> | 8 | 1,05   | 9,217    179,191   | 1,12   | 6,111    193,024   |
> -----------------------------------------------------------------
> 
> OVH = (Execution time with -z N) / (Execution time with -z 0)
> 
> ratio - compression ratio
> size  - number of bytes that was compressed
> 
> 	size ~= trace size x ratio

[root@quaco ~]# perf record -z2
^C[ perf record: Woken up 1 times to write data ]
0x1746e0 [0x76]: failed to process type: 81 [Invalid argument]
[ perf record: Captured and wrote 1.568 MB perf.data, compressed (original 0.452 MB, ratio is 3.995) ]

[root@quaco ~]#

I've pushed what I have to the tmp.perf/core branch, please try to see
if I made any mistake in fixing up conflicts with BPF_PROG_INFO and
BPF_BTF header features. I'll continue tomorrow with 10-12/12.

- Arnaldo
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt |  5 +++++
>  tools/perf/builtin-record.c              | 25 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 18fceb49434e..0567bacc2ae6 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -471,6 +471,11 @@ Also at some cases executing less trace write syscalls with bigger data size can
>  shorter than executing more trace write syscalls with smaller data size thus lowering
>  runtime profiling overhead.
>  
> +-z::
> +--compression-level[=n]::
> +Produce compressed trace using specified level n (default: 1 - fastest compression,
> +22 - smallest trace)
> +
>  --all-kernel::
>  Configure all used events to run in kernel space.
>  
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 2e083891affa..7258f2964a3b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -440,6 +440,26 @@ static int record__mmap_flush_parse(const struct option *opt,
>  	return 0;
>  }
>  
> +#ifdef HAVE_ZSTD_SUPPORT
> +static unsigned int comp_level_default = 1;
> +static int record__parse_comp_level(const struct option *opt,
> +				    const char *str,
> +				    int unset)
> +{
> +	struct record_opts *opts = (struct record_opts *)opt->value;
> +
> +	if (unset) {
> +		opts->comp_level = 0;
> +	} else {
> +		if (str)
> +			opts->comp_level = strtol(str, NULL, 0);
> +		if (!opts->comp_level)
> +			opts->comp_level = comp_level_default;
> +	}
> +
> +	return 0;
> +}
> +#endif
>  static unsigned int comp_level_max = 22;
>  
>  static int record__comp_enabled(struct record *rec)
> @@ -2169,6 +2189,11 @@ static struct option __record_options[] = {
>  	OPT_CALLBACK(0, "affinity", &record.opts, "node|cpu",
>  		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
>  		     record__parse_affinity),
> +#ifdef HAVE_ZSTD_SUPPORT
> +	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default,
> +		     "n", "Produce compressed trace using specified level (default: 1 - fastest compression, 22 - smallest trace)",
> +		     record__parse_comp_level),
> +#endif
>  	OPT_END()
>  };
>  
> -- 
> 2.20.1

-- 

- Arnaldo
