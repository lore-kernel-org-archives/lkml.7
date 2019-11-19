Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1C4C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1598520679
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 15:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al9cWTCE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfKSP7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 10:59:43 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42393 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfKSP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:59:42 -0500
Received: by mail-qt1-f193.google.com with SMTP id t20so25132591qtn.9;
        Tue, 19 Nov 2019 07:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m9owisihVoUKEdIZBWaiOa7IHVOtGuTKDH0fF9E2sX4=;
        b=Al9cWTCEmFGh3dhfC5/fKcqfTRLGohNSOfErqJi+7K5fc2lSuvvijW3iX/vmJK0cWt
         a7OLToGABHj2RVK4WJXwnBBbElEEJlGKwYwVUlJ52L8p78++2L4n6HtoV8AtcOKD+2C/
         7vFPhoVONDnEZqcEmMGL5evbFvsW30sXKhrn+TTIFoy7RfZatqKB7gvS/2FwGdnxoHvP
         6cSgUAhZwQGSbzWeOQtHk55l1Ot1TlKDR7qiEur+j4UukR0Wt0j8STLHQmNwUzVWz+Pp
         +f69kGr++ExDEWmSOKPLovTztggqQWUOfD7XZKBLZMhXEfWYMXaLHfWF96fxB5xNeMmj
         Umkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m9owisihVoUKEdIZBWaiOa7IHVOtGuTKDH0fF9E2sX4=;
        b=IHfFVgAXWQ/42yz6XIiq5XpI6WbMhfaLu5G74jgtYYUf7lKDsDz8ig/x/V5xiBbjpJ
         2tDD48Vyah1V79/3GZ6ArpMNCAtXsFDcZkYs9+2LEKbkfu0nBrsoXrH9ad+OhFTWI/EH
         nsHFYsqR5Fdn0ZnXyxxJa8ZVArlAJl/aKnz3h8oB0LH0k021LnEkkbNQrfQMawrvOw3d
         LF79nufp7mwE6pGUa0rXC4hhz0/ddze59cgGbGe7p5HHRRhRtGP+U6p++jk65sk64z3r
         rJk/Nn4nEcOZO+B9dRXwg9i5aMWa9dcPW//SGfY5gB4HnR+Bl8V0fck+MZilfnx+5xQz
         hFSQ==
X-Gm-Message-State: APjAAAWwWacJRuV4KQA1XYe5RKoNp57FMqCCr0w1YzpI2FnrEWy4k2wz
        2qPji2rCcwzDilDHdt5xea0=
X-Google-Smtp-Source: APXvYqxw/mipy1xv+BDJlBvv52s6KA03uNVaG1x2rooAK6M1x9d1rm+UBPPUswr6Wmfn2RDN9gzhiw==
X-Received: by 2002:ac8:342b:: with SMTP id u40mr32830412qtb.87.1574179179727;
        Tue, 19 Nov 2019 07:59:39 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id w5sm10141364qkf.43.2019.11.19.07.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 07:59:39 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E981D40D3E; Tue, 19 Nov 2019 12:59:36 -0300 (-03)
Date:   Tue, 19 Nov 2019 12:59:36 -0300
To:     lqqq341 <liuqi115@hisilicon.com>
Cc:     peterz@infradead.org, mingo@redhat.com, ak@linux.intel.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linuxarm@huawei.com, john.garry@huawei.com,
        zhangshaokun@hisilicon.com, huangdaode@hisilicon.com,
        linyunsheng@huawei.com
Subject: Re: [PATCH] Perf stat: Fix the ratio comments of miss-events
Message-ID: <20191119155936.GC24290@kernel.org>
References: <1573890521-56450-1-git-send-email-liuqi115@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573890521-56450-1-git-send-email-liuqi115@hisilicon.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Nov 16, 2019 at 03:48:41PM +0800, lqqq341 escreveu:
> From: Qi Liu <liuqi115@hisilicon.com>
> 
> Perf stat displays miss ratio of L1-dcache, L1-icache, dTLB cache,
> iTLB cache and LL-cache. Take L1-dcache for example, its miss ratio
> is caculated as "L1-dcache-load-misses/L1-dcache-loads". So "of all
> L1-dcache hits" is unsuitable to describe it, and "of all L1-dcache
> accesses" seems better. The comments of L1-icache, dTLB cache, iTLB
> cache and LL-cache are fixed in the same way.
> 
> Signed-off-by: Qi Liu <liuqi115@hisilicon.com>
> ---
>  tools/perf/util/stat-shadow.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> index 2c41d47..a3bdf2b 100644
> --- a/tools/perf/util/stat-shadow.c
> +++ b/tools/perf/util/stat-shadow.c
> @@ -506,7 +506,8 @@ static void print_l1_dcache_misses(struct perf_stat_config *config,
>  
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
>  
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%",
> +			  "of all L1-dcache accesses", ratio);


Why have you reflowed all those lines? This patch should have been like:

-	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache hits", ratio);
+	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-dcache accesses", ratio);

Notice how it is easier to compare the changes, and also to keep the
flowing like it was before your change,

Thanks,

- Arnaldo

>  }
>  
>  static void print_l1_icache_misses(struct perf_stat_config *config,
> @@ -527,7 +528,8 @@ static void print_l1_icache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
>  
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all L1-icache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%",
> +			  "of all L1-icache accesses", ratio);
>  }
>  
>  static void print_dtlb_cache_misses(struct perf_stat_config *config,
> @@ -547,7 +549,8 @@ static void print_dtlb_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
>  
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all dTLB cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%",
> +			  "of all dTLB cache accesses", ratio);
>  }
>  
>  static void print_itlb_cache_misses(struct perf_stat_config *config,
> @@ -567,7 +570,8 @@ static void print_itlb_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
>  
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all iTLB cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%",
> +			  "of all iTLB cache accesses", ratio);
>  }
>  
>  static void print_ll_cache_misses(struct perf_stat_config *config,
> @@ -587,7 +591,8 @@ static void print_ll_cache_misses(struct perf_stat_config *config,
>  		ratio = avg / total * 100.0;
>  
>  	color = get_ratio_color(GRC_CACHE_MISSES, ratio);
> -	out->print_metric(config, out->ctx, color, "%7.2f%%", "of all LL-cache hits", ratio);
> +	out->print_metric(config, out->ctx, color, "%7.2f%%",
> +			  "of all LL-cache accesses", ratio);
>  }
>  
>  /*
> @@ -872,7 +877,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
>  			print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all L1-dcache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL,
> +				     "of all L1-dcache accesses", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
> @@ -882,7 +888,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
>  			print_l1_icache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all L1-icache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL,
> +				     "of all L1-icache accesses", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
> @@ -892,7 +899,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
>  			print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all dTLB cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL,
> +				     "of all dTLB cache accesses", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
> @@ -902,7 +910,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
>  			print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all iTLB cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL,
> +				     "of all iTLB cache accesses", 0);
>  	} else if (
>  		evsel->core.attr.type == PERF_TYPE_HW_CACHE &&
>  		evsel->core.attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
> @@ -912,7 +921,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
>  		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
>  			print_ll_cache_misses(config, cpu, evsel, avg, out, st);
>  		else
> -			print_metric(config, ctxp, NULL, NULL, "of all LL-cache hits", 0);
> +			print_metric(config, ctxp, NULL, NULL,
> +				     "of all LL-cache accesses", 0);
>  	} else if (perf_evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
>  		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
>  
> -- 
> 2.8.1

-- 

- Arnaldo
