Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF1DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE506206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9rwbTH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbfDPTd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:33:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36685 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPTd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:33:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id s15so24726570qtn.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0ASbOHLSF52KJJ31MlDPvA+KUWSUFceU54AR9l+z7EI=;
        b=V9rwbTH2NSsyXr3F5FG5BEhFNlE8kCs0YsNd0W7bpBu4iOORCQX/OTfh04x+6Q8Qm/
         jgsAJoyig7Z4z7Xy7X7ZDHBx93RFuVRLdNnThSeKWc2RW4Ctrzh/zKE0qpac5jgNJX6b
         fVTXGvauUQCIFkuBZGGL0K7eZG3ojmVxZEGXs1lPgPiJjfMFkzXerwUQL6MP7eO9aPpL
         0lALvIaksH+jRGZozGPgwYDODweu1EmrbPrgPlY0IUB1Qm3AH0Y3mukSOSQNH4zqwVCi
         hMrPtHoZOnlj688svUB5MqSuRYxwuKB4+Wa+DE0/dVCtX4Pk9pVp1MmVkDs35jESgpIo
         77tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0ASbOHLSF52KJJ31MlDPvA+KUWSUFceU54AR9l+z7EI=;
        b=O4BbbZrv+PZeMgW5GSStk+0lxR+x72aZPMMHyIq4k3V3AERrfzdgolGcilC4AlD1wG
         FhSrocIF+wfDw7G02S4+X12P1UMi6VlFD0+Tqw+8eZvfE36rxT8StAO+71BOWsq0UnDk
         bEEmOTCdRO8ZPWbCBHZmiY31tlelBrVJZzJQaNidRCnupA2GjSJeDxUB8PrJ7mv8K0hq
         stXyEeWR5WAOTKd6ZVPhdvPfXSRHx2JX++NeGI0T7cfzr4341KJ/6Az5d+8fRgwlentG
         HbZzT3gQFaI8zkKanmavKFkwRP6z9bXpSPjCnGc2AS0Ehci3RbWvPInZdNDJB2m/qwzK
         gSWg==
X-Gm-Message-State: APjAAAUzszfGD2iZ1nj2gaLTr3hnx6MW3AfY2QkYwryG+zWBXnJFq3Wv
        CpBzZzQG8jCX0Vk9djSMwgY=
X-Google-Smtp-Source: APXvYqzKjfLX4yy0oiCWAPxVyC+5MmqfMlpphqw1c7vFWzhYZGjJm4IyF4ig3R3gOXSEJc2VBlkX3w==
X-Received: by 2002:ac8:2d13:: with SMTP id n19mr64050144qta.31.1555443205267;
        Tue, 16 Apr 2019 12:33:25 -0700 (PDT)
Received: from quaco.ghostprotocols.net (179-240-182-11.3g.claro.net.br. [179.240.182.11])
        by smtp.gmail.com with ESMTPSA id y13sm29683279qkj.30.2019.04.16.12.33.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 12:33:24 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8E104039C; Tue, 16 Apr 2019 16:33:20 -0300 (-03)
Date:   Tue, 16 Apr 2019 16:33:20 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH 08/12] perf tools: Fix side band thread draining
Message-ID: <20190416193320.GC9247@kernel.org>
References: <20190416160127.30203-1-jolsa@kernel.org>
 <20190416160127.30203-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416160127.30203-9-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 16, 2019 at 06:01:23PM +0200, Jiri Olsa escreveu:
> Current perf_evlist__poll_thread code could finish
> without draining the data. Adding the logic that
> makes sure we won't finish before the drain.
> 
> Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")

Thanks, applied to perf/urgent.

- Arnaldo

> Link: http://lkml.kernel.org/n/tip-41i888xyim9n5ceyr44jb468@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/evlist.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index f2bbae38278d..4b6783ff5813 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1868,12 +1868,12 @@ static void *perf_evlist__poll_thread(void *arg)
>  {
>  	struct perf_evlist *evlist = arg;
>  	bool draining = false;
> -	int i;
> +	int i, done = 0;
> +
> +	while (!done) {
> +		bool got_data = false;
>  
> -	while (draining || !(evlist->thread.done)) {
> -		if (draining)
> -			draining = false;
> -		else if (evlist->thread.done)
> +		if (evlist->thread.done)
>  			draining = true;
>  
>  		if (!draining)
> @@ -1894,9 +1894,13 @@ static void *perf_evlist__poll_thread(void *arg)
>  					pr_warning("cannot locate proper evsel for the side band event\n");
>  
>  				perf_mmap__consume(map);
> +				got_data = true;
>  			}
>  			perf_mmap__read_done(map);
>  		}
> +
> +		if (draining && !got_data)
> +			break;
>  	}
>  	return NULL;
>  }
> -- 
> 2.17.2

-- 

- Arnaldo
