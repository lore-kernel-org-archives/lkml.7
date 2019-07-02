Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A486C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1923D2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNy441tI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfGBP6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:58:52 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40023 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfGBP6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:58:52 -0400
Received: by mail-qk1-f196.google.com with SMTP id c70so14525611qkg.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 08:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HIMyMaTT8gfuuVj92si+t8dMQRhbYWsWu2ie05INXWs=;
        b=DNy441tId8Hh7xQiWe9LVP+LxmNVDK54k/XjG8EVmd3U5Wcb2cDBzE9SpuHPcH57WJ
         lghK8ShJME9lFhcV1LDzu+ucfujzuKjI2FoFsMeN+OKNg8KAG9Xp5Ki5DmeJVKmjprhs
         MgjcX4mj2YkdHjsWMHL5PPopV+2aEKUEFhYnaSsmwT1/1B15W+wfC3vU5KE8tRzRlCjv
         fG1WJ/JOG7vFC7xxyc4VlGK7npU91hFSJXH0SPBCaCglZgY+qDzy9JEwmkTgEUaltWll
         5Fnd6JYrQcI/WanaX4N1JYFuqCl8j3SzTsS32VwKqJzWEONGi8FMW7afaUxx/8ImWmYL
         qYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HIMyMaTT8gfuuVj92si+t8dMQRhbYWsWu2ie05INXWs=;
        b=Vh04kh6TkrJqLO8Iv1C1c3LY8API9dDakGMbn7tCosrrkVDpo+eBF/uBIbQXOY8yso
         ZuWch+2rgZos+JlGcwJd/wBE0pRN0ZJWxanX2hkyL0B0jqi4Ilr4Cu1M5wbDYGACyDTb
         oM0+x9sLvhAk4Njeii2usuIubzLcuIuJ5RhlVJDg9JxeeXIw4ixQ+P9YKpNJ6mO+3OA9
         H0O44G0lLUTpMPTTansgSjdu4TGvoI1ywMFwlfzvtFyDiPwOCV6maIoxW5HW3GJ0cy1R
         5Ru0GQ4WeVX7/XK+khaIAA/voNb6ZUw0MkgeHJdEltsymg5Rt3IelLF1GwMMK4xR6Qjz
         PPTg==
X-Gm-Message-State: APjAAAXfEkt72cTWdaow8dFUlgT2KVo3Tpr/z8yHq5ilGS7+XYdTqrvn
        BPmR/IX2az82B9vsBI5vGhU=
X-Google-Smtp-Source: APXvYqzIfKeSikLI8GXHoYrtdlILSjgt8/wN+Zj7XV3wsd4FdHXYvfDHNSkFZ2YUc+yDO1QYQ2BuFg==
X-Received: by 2002:a05:620a:1393:: with SMTP id k19mr25194763qki.67.1562083130773;
        Tue, 02 Jul 2019 08:58:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id m5sm6234129qke.25.2019.07.02.08.58.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 08:58:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0EF6C41153; Tue,  2 Jul 2019 12:58:48 -0300 (-03)
Date:   Tue, 2 Jul 2019 12:58:48 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/3] perf vendor events intel: Metric fixes for SKX/CLX
Message-ID: <20190702155848.GG15462@kernel.org>
References: <20190628220737.13259-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628220737.13259-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 28, 2019 at 03:07:35PM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>

Thanks, applied the three patches.

- Arnaldo
 
> - Add a missing filter for the DRAM_Latency / DRAM_Parallel_Reads metrics
> - Remove the useless PMM_* metrics from Skylake
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  .../arch/x86/cascadelakex/clx-metrics.json    |  4 ++--
>  .../arch/x86/skylakex/skx-metrics.json        | 22 ++-----------------
>  2 files changed, 4 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> index 1a1a3501180a..a382b115633d 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> @@ -314,13 +314,13 @@
>          "MetricName": "DRAM_BW_Use"
>      },
>      {
> -        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
> +	"MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x35\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ ) / ( cha_0@event\\=0x0@ / duration_time )",
>          "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
>          "MetricGroup": "Memory_Lat",
>          "MetricName": "DRAM_Read_Latency"
>      },
>      {
> -        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
> +	"MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1\\\\\\,config\\=0x40433@",
>          "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
>          "MetricGroup": "Memory_BW",
>          "MetricName": "DRAM_Parallel_Reads"
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> index 56e03ba771f4..35b255fa6a79 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> @@ -314,35 +314,17 @@
>          "MetricName": "DRAM_BW_Use"
>      },
>      {
> -        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
> +	"MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x35\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ ) / ( cha_0@event\\=0x0@ / duration_time )",
>          "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
>          "MetricGroup": "Memory_Lat",
>          "MetricName": "DRAM_Read_Latency"
>      },
>      {
> -        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
> +	"MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,config\\=0x40433@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1\\\\\\,config\\=0x40433@",
>          "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
>          "MetricGroup": "Memory_BW",
>          "MetricName": "DRAM_Parallel_Reads"
>      },
> -    {
> -        "MetricExpr": "( 1000000000 * ( imc@event\\=0xe0\\\\\\,umask\\=0x1@ / imc@event\\=0xe3@ ) / imc_0@event\\=0x0@ ) if 1 if 0 == 1 else 0 else 0",
> -        "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
> -        "MetricGroup": "Memory_Lat",
> -        "MetricName": "MEM_PMM_Read_Latency"
> -    },
> -    {
> -        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
> -        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
> -        "MetricGroup": "Memory_BW",
> -        "MetricName": "PMM_Read_BW"
> -    },
> -    {
> -        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time ) if 1 if 0 == 1 else 0 else 0",
> -        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
> -        "MetricGroup": "Memory_BW",
> -        "MetricName": "PMM_Write_BW"
> -    },
>      {
>          "MetricExpr": "cha_0@event\\=0x0@",
>          "BriefDescription": "Socket actual clocks when any core is active on that socket",
> -- 
> 2.20.1

-- 

- Arnaldo
