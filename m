Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348DBC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3572217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 13:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/NZQiMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfIBN50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 09:57:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34833 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730136AbfIBN5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 09:57:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id k10so5445658qth.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OitqN2kg6lyvRRSIBQc9gpSiVZQAXh0Y8KuNNZSdri4=;
        b=D/NZQiMNGOdQAzZMzVjWmVDBAnZuPcYTizGWZF8dh4HuCCHc8+2ZUddmim1zmqKnFP
         0aY49IrNsZDk2CpAP2ukhn4PkKdsprX9NDXHQ+65pf1zpGCnlYgV0KC60KAq0YA8W6WK
         TaCkXDMZDrLg8ssb5RCc4rl7rqqIPwcHQeNuVYrOIPEHXfO2b3IhZXHAocLdClPChdPg
         4F6rciVtNEwgVngIYbzfFjydVOyYeLBOyfV/RGQxP/ePLGdHAwBPrnpd9reveoJ/7rGi
         8L2R5pXgGFDLWGNcpLXiCzLLZS7xXiLyA3Z+PS1lgyZDKShAkPKMWqK02B/KFDxYcsFg
         tnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OitqN2kg6lyvRRSIBQc9gpSiVZQAXh0Y8KuNNZSdri4=;
        b=Ylux4bGcpzxu4KKi9KYanpuCZU18zsrbpq9DtOZurA8Qp/tH9La/r8Lly1oYr6Blgd
         uHO+eSQjpeQKibMRdaGKrNtmYl9aJKSWKo6hRA416DCf/sCufMKBSbljhrjsVgWgCe4O
         /KNSVUtLZLAZ05l6jDxM6bKo/UfZTvoSZo+rDkg7HH88cQRqg9jJsAiZaUbF++A6lvg4
         VJJKptL6prfUw2C37LbSI5pCx2nLCj+8ECZkRxniPtGwT99bHoJK/KPUEWvY15k502Rc
         FQzTJgM/Qg7ttsKFymIeecy6Q2hDk+bpn6wvU9nkyBuI/LsxKMjfu0dGWNmDXxKNN5i4
         uk0g==
X-Gm-Message-State: APjAAAXWuqlcsx/qErWbIXehRxmJ2EFinLeaUSC8mFXncQPPPzYTWfHY
        t/4CMMTBth98BrvKSjUVWDU=
X-Google-Smtp-Source: APXvYqwRPV4EgjjaxkgVrZtrV2b+51PPx/oI0oCF5U1zfDxhCsdp3i6fUnI87mUOi58J/wSGh2hkoQ==
X-Received: by 2002:ac8:25b1:: with SMTP id e46mr8710341qte.51.1567432644760;
        Mon, 02 Sep 2019 06:57:24 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id t13sm6343486qkm.117.2019.09.02.06.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:57:23 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E418341146; Mon,  2 Sep 2019 10:57:21 -0300 (-03)
Date:   Mon, 2 Sep 2019 10:57:21 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/3] libperf: Add perf_cpu_map__max function
Message-ID: <20190902135721.GC8396@kernel.org>
References: <20190902121255.536-1-jolsa@kernel.org>
 <20190902121255.536-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902121255.536-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 02, 2019 at 02:12:53PM +0200, Jiri Olsa escreveu:
> So it can be used from multiple places.

Applied.

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-yp3h5rl9e8piybufq41zqnla@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/builtin-stat.c            | 14 +-------------
>  tools/perf/lib/cpumap.c              | 12 ++++++++++++
>  tools/perf/lib/include/perf/cpumap.h |  1 +
>  tools/perf/lib/libperf.map           |  1 +
>  4 files changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 7e17bf9f700a..5bc0c570b7b6 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -822,18 +822,6 @@ static int perf_stat__get_core(struct perf_stat_config *config __maybe_unused,
>  	return cpu_map__get_core(map, cpu, NULL);
>  }
>  
> -static int cpu_map__get_max(struct perf_cpu_map *map)
> -{
> -	int i, max = -1;
> -
> -	for (i = 0; i < map->nr; i++) {
> -		if (map->map[i] > max)
> -			max = map->map[i];
> -	}
> -
> -	return max;
> -}
> -
>  static int perf_stat__get_aggr(struct perf_stat_config *config,
>  			       aggr_get_id_t get_id, struct perf_cpu_map *map, int idx)
>  {
> @@ -928,7 +916,7 @@ static int perf_stat_init_aggr_mode(void)
>  	 * taking the highest cpu number to be the size of
>  	 * the aggregation translate cpumap.
>  	 */
> -	nr = cpu_map__get_max(evsel_list->core.cpus);
> +	nr = perf_cpu_map__max(evsel_list->core.cpus);
>  	stat_config.cpus_aggr_map = perf_cpu_map__empty_new(nr + 1);
>  	return stat_config.cpus_aggr_map ? 0 : -ENOMEM;
>  }
> diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
> index 1f0e6f334237..2ca1fafa620d 100644
> --- a/tools/perf/lib/cpumap.c
> +++ b/tools/perf/lib/cpumap.c
> @@ -260,3 +260,15 @@ int perf_cpu_map__idx(struct perf_cpu_map *cpus, int cpu)
>  
>  	return -1;
>  }
> +
> +int perf_cpu_map__max(struct perf_cpu_map *map)
> +{
> +	int i, max = -1;
> +
> +	for (i = 0; i < map->nr; i++) {
> +		if (map->map[i] > max)
> +			max = map->map[i];
> +	}
> +
> +	return max;
> +}
> diff --git a/tools/perf/lib/include/perf/cpumap.h b/tools/perf/lib/include/perf/cpumap.h
> index 8aa995c59498..ac9aa497f84a 100644
> --- a/tools/perf/lib/include/perf/cpumap.h
> +++ b/tools/perf/lib/include/perf/cpumap.h
> @@ -16,6 +16,7 @@ LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
>  LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
>  LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
>  LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
> +LIBPERF_API int perf_cpu_map__max(struct perf_cpu_map *map);
>  
>  #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
>  	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
> diff --git a/tools/perf/lib/libperf.map b/tools/perf/lib/libperf.map
> index dc4d66363bc4..cd0d17b996c8 100644
> --- a/tools/perf/lib/libperf.map
> +++ b/tools/perf/lib/libperf.map
> @@ -9,6 +9,7 @@ LIBPERF_0.0.1 {
>  		perf_cpu_map__nr;
>  		perf_cpu_map__cpu;
>  		perf_cpu_map__empty;
> +		perf_cpu_map__max;
>  		perf_thread_map__new_dummy;
>  		perf_thread_map__set_pid;
>  		perf_thread_map__comm;
> -- 
> 2.21.0

-- 

- Arnaldo
