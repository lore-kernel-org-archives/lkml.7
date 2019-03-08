Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE59C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBD820661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9B6gHXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfCHNpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:45:39 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40890 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfCHNpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:45:39 -0500
Received: by mail-qk1-f194.google.com with SMTP id h28so11147658qkk.7;
        Fri, 08 Mar 2019 05:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nzr+8V+DgOFp0mJA048yuisf5jmj+/9hXbKAc2+oCMs=;
        b=h9B6gHXq9e1V6E5OyaTxWTR+zKNtuGH7UP+GslbWz3ptkATLRuYxsC6C0IgNIqRhLr
         Gg5eFfXvU34Bx8/cGgMv6NPtOIlNrgoV3pHTMD9FE5G7RITR75aniUhznF+SdWOWmulJ
         vhH8pvtLVS838pdsUEfKijR9LyFRWnAqii/+RCD/lRyjM3uPCQk41BD9TgXa+ar12HLM
         skBBw6Agzzxmal837kAEfvxJoDcsfMMmC/tx83S1bBpuVYXBqSZt1F31OIouEY59osJO
         T93drpd2yXbKJGT9YAmyEoxERSKj6YkrWkH3lRBkta6q5cTnSLSx14gTkS8T2Wet8oUI
         NHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nzr+8V+DgOFp0mJA048yuisf5jmj+/9hXbKAc2+oCMs=;
        b=X2v+KGOUb/Ib/Pe+hi+oV0baa+z2AKKavjqTQ+dx/tIl6f6g02UBs18XXn+IO+5kxo
         Zc0IVSXf+ZvLiJ9xjJqGE7JnLgvaaALvGAMzaMSKpDV6sAb/m/UPDOHY6V1KJqXTrIHa
         JuZsEDHwegQcyNGV7NK8X8Wip/ItU3z05dt1qL2j4Ftuh8tCvtvmSduGTInpkN6GCCm6
         euIxOnIX8wPAehVcVa9COYJ/KB9ZGzGNTvNwhpdy9/VMVsdFy34rN+s9CDzuLFZfVA/i
         byw0xTOIl5rtsc2xzB+eoJlpG5eTwEHHRhpJGWLnX6Zs2ciUso3jE/uldsIv4/cQUyVj
         r1fg==
X-Gm-Message-State: APjAAAWvFJDbzT8ulJNEz1KKvShFodlZRl5I55TJnDIxoOZS98ti5EyZ
        vEBoIr3mUqNiEV9ZimdfNYo=
X-Google-Smtp-Source: APXvYqxdSaGYoRzG6LJtebEWdApRfTxGcdngzkX4joqntiDCkmwrFIQFREKvIhtRZJqoXKFWVFnO4w==
X-Received: by 2002:a37:8285:: with SMTP id e127mr14257314qkd.182.1552052737934;
        Fri, 08 Mar 2019 05:45:37 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-154-188.3g.claro.net.br. [177.59.154.188])
        by smtp.gmail.com with ESMTPSA id h10sm7140608qta.3.2019.03.08.05.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Mar 2019 05:45:36 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3AD304039C; Fri,  8 Mar 2019 10:45:32 -0300 (-03)
Date:   Fri, 8 Mar 2019 10:45:32 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 05/15] perf tools report: Parse time quantum
Message-ID: <20190308134532.GC26260@kernel.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-6-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305144758.12397-6-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 05, 2019 at 06:47:48AM -0800, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Many workloads change over time. perf report currently aggregates
> the whole time range reported in perf.data.
> 
> This patch adds an option for a time quantum to quantisize the
> perf.data over time.
> 
> This just adds the option, will be used in follow on patches
> for a time sort key.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> ---
> v2:
> Move time_quantum to symbol_conf. check for zero time quantum
> v3:
> Document s unit
> ---
>  tools/perf/Documentation/perf-report.txt |  4 +++
>  tools/perf/builtin-report.c              | 41 ++++++++++++++++++++++++
>  tools/perf/util/symbol.c                 |  1 +
>  tools/perf/util/symbol_conf.h            |  1 +
>  4 files changed, 47 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
> index 51dbc519dbce..9ec1702bccdd 100644
> --- a/tools/perf/Documentation/perf-report.txt
> +++ b/tools/perf/Documentation/perf-report.txt
> @@ -497,6 +497,10 @@ include::itrace.txt[]
>  	The period/hits keywords set the base the percentage is computed
>  	on - the samples period or the number of samples (hits).
>  
> +--time-quantum::
> +	Configure time quantum for time sort key. Default 100ms.
> +	Accepts s, us, ms, ns units.
> +
>  include::callchain-overhead-calculation.txt[]
>  
>  SEE ALSO
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 09180e559ad6..c19952072a3a 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -47,6 +47,7 @@
>  #include <errno.h>
>  #include <inttypes.h>
>  #include <regex.h>
> +#include "sane_ctype.h"
>  #include <signal.h>
>  #include <linux/bitmap.h>
>  #include <linux/stringify.h>
> @@ -926,6 +927,43 @@ report_parse_callchain_opt(const struct option *opt, const char *arg, int unset)
>  	return parse_callchain_report_opt(arg);
>  }
>  
> +static int
> +parse_time_quantum(const struct option *opt, const char *arg,
> +		   int unset __maybe_unused)
> +{
> +	unsigned long *time_q = opt->value;
> +	char *end;
> +
> +	*time_q = strtoul(arg, &end, 0);
> +	if (end == arg)
> +		goto parse_err;
> +	if (*time_q == 0) {
> +		pr_err("time quantum cannot be 0");
> +		return -1;
> +	}
> +	while (isspace(*end))
> +		end++;
> +	if (*end == 0)
> +		return 0;

We have tools/include/linux/time64.h, just like the kernel, so please
use:

#include <linux/time64.h>

> +	if (!strcmp(end, "s")) {
> +		*time_q *= 1000000000;
                           NSEC_PER_SEC;


> +		return 0;
> +	}
> +	if (!strcmp(end, "ms")) {
> +		*time_q *= 1000000;
                           NSEC_PER_MSEC;
> +		return 0;
> +	}
> +	if (!strcmp(end, "us")) {
> +		*time_q *= 1000;
                           NSEC_PER_USEC;

one more note below

> +		return 0;
> +	}
> +	if (!strcmp(end, "ns"))
> +		return 0;
> +parse_err:
> +	pr_err("Cannot parse time quantum `%s'\n", arg);
> +	return -1;
> +}
> +
>  int
>  report_parse_ignore_callees_opt(const struct option *opt __maybe_unused,
>  				const char *arg, int unset __maybe_unused)
> @@ -1148,6 +1186,9 @@ int cmd_report(int argc, const char **argv)
>  		     "Set percent type local/global-period/hits",
>  		     annotate_parse_percent_type),
>  	OPT_BOOLEAN(0, "ns", &symbol_conf.nanosecs, "Show times in nanosecs"),
> +	OPT_CALLBACK(0, "time-quantum", &symbol_conf.time_quantum, "time (ms|us|ns|s)",
> +		     "Set time quantum for time sort key (default 100ms)",
> +		     parse_time_quantum),
>  	OPT_END()
>  	};
>  	struct perf_data data = {
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index eb873ea1c405..0f80743a1c25 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -45,6 +45,7 @@ struct symbol_conf symbol_conf = {
>  	.demangle		= true,
>  	.demangle_kernel	= false,
>  	.cumulate_callchain	= true,
> +	.time_quantum		= 100000000, /* 100ms */

                                  100 * NSEC_PER_MSEC;

>  	.show_hist_headers	= true,
>  	.symfs			= "",
>  	.event_group		= true,
> diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
> index 095a297c8b47..a5684a71b78e 100644
> --- a/tools/perf/util/symbol_conf.h
> +++ b/tools/perf/util/symbol_conf.h
> @@ -56,6 +56,7 @@ struct symbol_conf {
>  			*sym_list_str,
>  			*col_width_list_str,
>  			*bt_stop_list_str;
> +	unsigned long	time_quantum;
>         struct strlist	*dso_list,
>  			*comm_list,
>  			*sym_list,
> -- 
> 2.20.1

-- 

- Arnaldo
