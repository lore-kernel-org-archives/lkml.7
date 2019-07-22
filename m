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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C9EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300642064A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 20:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uR8eAQzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbfGVUjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:39:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46440 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbfGVUjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 16:39:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id r4so29439662qkm.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 13:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jggCyjkZ3kqvJdGpWTHCbMhUKz0XqEFteSbnMpjRCV4=;
        b=uR8eAQzINwFPTeiBPXM2k3ifzMLM1lvum9wIHu/nWqO1Q2imd34tXpKGHt3+n1V/8A
         VTJy+F93OoTo8ZvIEnyV1DlrzoucR2H2g4JE7jHJ3eeQ0bjZafNThwt3qAmfqLOFgg/k
         DjqWHipH3l8Vy/6dFcqtIpfIxgy5SKEv5OTskjV2PbOx0z0Hy5HBbNcu0wRO1jm4vsZB
         Y0moz9xhJWzztXv/48hsOQNjE6zoXnwWRHF/Z99xeJKYVG+Q8Mct4M/6Wo4ihJacufBk
         Ubxs0vNq/qZm1G99Hzy39IUdTZlAXUeTPrdNB9FEm3+qwcTg6uJS4Men7zETPkyLc+vL
         xYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jggCyjkZ3kqvJdGpWTHCbMhUKz0XqEFteSbnMpjRCV4=;
        b=FhCE46LASSdkvTh+9huE52tLK/GRfwN33LmBJI7KDPt+lwOYCrGlzLl9Z46m+m1Wq6
         beqNvmZxsETaynaJwT9j3H3vDV5gHwuvCYIQPiQItj/nbrLcrWa6aqtQ3A1fpje2BH8r
         VtWFF5cswTRk6c40MYbHOZQpBMdzsXBrfYov7AHwAJoX/8a7yk0aEppO7fze2U5+bsUj
         OXAcHi/rH4Mz19P9wT1J4tTw4h8pjGI30ekC3iiA9pWtm1bDsLj7Orzbh8SQmJdTVMyQ
         dEtVCotiZYnitH84T5LjMnAi4bwUznnD6n1DTdNNXSYFm3QDPRCzND3cQxkwdMup68Da
         AZGw==
X-Gm-Message-State: APjAAAVs0kdsSsyYHgox9Qb+73ZoVCsXOoNVdq8/LxUwxTnt5nVHvntr
        jg6mHDu9LbM6nZ8cQiBM9mg=
X-Google-Smtp-Source: APXvYqx8Msas+jHA1N4uyLLAwBipaIzL/nOBLfI+WoLZ0ORW+O7UCD38bf+p58ztcgqVQglFLgdH+A==
X-Received: by 2002:a37:4dc6:: with SMTP id a189mr46725924qkb.41.1563827941349;
        Mon, 22 Jul 2019 13:39:01 -0700 (PDT)
Received: from quaco.ghostprotocols.net (177.207.140.177.dynamic.adsl.gvt.net.br. [177.207.140.177])
        by smtp.gmail.com with ESMTPSA id m4sm16835779qka.70.2019.07.22.13.38.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 13:38:59 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 62E2A40340; Mon, 22 Jul 2019 17:38:56 -0300 (-03)
Date:   Mon, 22 Jul 2019 17:38:56 -0300
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
Message-ID: <20190722203856.GW3624@kernel.org>
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

this inversion was ok, it by definition doesn't use entry->evlist, just
core stuff.

- Arnaldo
