Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E060EC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B502C22B48
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzpYPy2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbfLKSNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:13:20 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:44546 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfLKSNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:13:20 -0500
Received: by mail-ua1-f66.google.com with SMTP id d6so9210730uam.11;
        Wed, 11 Dec 2019 10:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bd29n+OqWQHmjiv4UohToE6LWwboTOECsuyuIZjyFLc=;
        b=dzpYPy2oARzQ0iGcjAca12/c3TTFocSLbTgbg/ooUwOW9F1VR/s8PE802ilhjbtbRG
         ZxZXzRCuD3aeCJMDBJMi+/K4t4OLrFjj6sqgbkVhCr3LetOWTSRVc1MReJhuDoHq6bkC
         UESo9BKJOPpJqPOWlstJIqMNAjD8ylNJmoLWN5qPTkNv/CwYL1C63i8c85RMwVN0lcIm
         g7vNBpE8X1MtiFYNeliW0xkJ3fcTpB2UQiBMdh32QcEzGSy5bZHEhP8m8tRDOQ4qdkO0
         xiVBKBLLNB1q/0OtE43sxjPEguFRhbA3k2oUx6CMWz15YMV5xoL0AdbmIJ+ADJrq3lIN
         7qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bd29n+OqWQHmjiv4UohToE6LWwboTOECsuyuIZjyFLc=;
        b=nC7E8SADC5KgvP0pePtMl1liNfoQ60iUQ1GS7tr9bfkuKIZ5owimD1GMmKKIiieIKP
         dCoYST/yAzkwekwJVjNaf3ScRRU4U4DRP+Rx81jPo6hE6sJApvFZG7abcOittq3ZEcrP
         cglp4tyOWn6KSymZumlzN2LccERUfKlyHEHSZDANPRGN16YS5hqx80OosOD4YMxgzAl+
         m4/miPU0U1kOKU5siciIoZQX9+uVGqY0/g3HI4ku+jFqetFCdBShslMdtUdV0xo66eWi
         CKnTBRArkXctwfUqU/tVvfxbezNlm0nS+qlzwI/eHBTJ6xRtbS7gsGND7MnCAvyIKGxY
         wi4g==
X-Gm-Message-State: APjAAAUmrCMTcCZiCAynv5gZBl73HywTwIGGOCSv1A6jViAVG3w392X+
        8ibdhP4ExO9Lcm6E5yrHb5S6EgQb
X-Google-Smtp-Source: APXvYqxOgC4TDxo+oV7b8znqWdp8cjvcMF9KAx5I/dgbEEczsw6rGRWj7qsgndiJMGC4M0PwYjPDqw==
X-Received: by 2002:ab0:6418:: with SMTP id x24mr4509581uao.40.1576087999267;
        Wed, 11 Dec 2019 10:13:19 -0800 (PST)
Received: from quaco.ghostprotocols.net ([177.195.211.59])
        by smtp.gmail.com with ESMTPSA id f22sm1635454vso.8.2019.12.11.10.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 10:13:18 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 37CD340352; Wed, 11 Dec 2019 15:13:13 -0300 (-03)
Date:   Wed, 11 Dec 2019 15:13:13 -0300
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Matheus Marchini <mmarchini@netflix.com>,
        linux-perf-users@vger.kernel.org, jkoch@netflix.com,
        khlebnikov@yandex-team.ru, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        Song Liu <songliubraving@fb.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf map: fix infinite loop on
 map_groups__fixup_overlappings
Message-ID: <20191211181313.GE13965@kernel.org>
References: <20191211160734.18087-1-mmarchini@netflix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211160734.18087-1-mmarchini@netflix.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 11, 2019 at 08:07:31AM -0800, Matheus Marchini escreveu:
> In some cases, when using perf inject and there are JIT_CODE_MOVE
> records in the jitdump file, perf will end up in an infinite loop on
> map_groups__fixup_overlappings, which will keep allocating memory
> indefinitely. This issue was observed on Node.js (with changes to
> generate JIT_CODE_MOVE records) and on Java.
> 
> This issue started to occur after 6a9405b56c274 (perf map:
> Optimize maps__fixup_overlappings()). To prevent it from happening,
> partially revert those changes without losing the optimizations
> introduced in it.

Konstantin, can you please take a look and provide your Acked-by or
Reviewed-by?

- Arnaldo
 
> Signed-off-by: Matheus Marchini <mmarchini@netflix.com>
> ---
>  tools/perf/util/map.c | 17 +++++++++++++++++
>  tools/perf/util/map.h |  1 +
>  2 files changed, 18 insertions(+)
> 
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 744bfbaf35cf..8918fdb8ddab 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -781,6 +781,21 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
>  	__maps__insert(&mg->maps, map);
>  }
>  
> +int map__overlap(struct map *l, struct map *r)
> +{
> +	if (l->start > r->start) {
> +		struct map *t = l;
> +
> +		l = r;
> +		r = t;
> +	}
> +
> +	if (l->end > r->start)
> +		return 1;
> +
> +	return 0;
> +}
> +
>  int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE *fp)
>  {
>  	struct maps *maps = &mg->maps;
> @@ -821,6 +836,8 @@ int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE
>  		 */
>  		if (pos->start >= map->end)
>  			break;
> +		if (!map__overlap(map, pos))
> +			continue;
>  
>  		if (verbose >= 2) {
>  
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 5e8899883231..1383571437aa 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -132,6 +132,7 @@ static inline void __map__zput(struct map **map)
>  
>  #define map__zput(map) __map__zput(&map)
>  
> +int map__overlap(struct map *l, struct map *r);
>  size_t map__fprintf(struct map *map, FILE *fp);
>  size_t map__fprintf_dsoname(struct map *map, FILE *fp);
>  char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
> -- 
> 2.17.1

-- 

- Arnaldo
