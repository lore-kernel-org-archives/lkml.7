Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D8CC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB833206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 14:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEohqPa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfHAOfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 10:35:22 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45989 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732065AbfHAOfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 10:35:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id x22so65498168qtp.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p45ES7b7NK+c/udqJP6oKfrqjRszRW+7OJRl6m1ohCs=;
        b=SEohqPa5AGP4DnjdyYthjCULQLq5iN+YIanfrlKdV6i3f8NFWX0ZL0lODdukT1JhFa
         oyTlBLnrpTfsPLVODoF9JRo0y3HF7+YszLNGL6DW9qKxWGipFntdghc8b4lhBCstKgFK
         kbn3XWj4ORV/EvWWmR4g6XiMdpbBbfB0LXvP76U8rWtrEBhvvS5flbvUd8ZO6M2pWB6o
         /lsllwtOid2SOG3egQ9+tZFmd9D2MQ7NVLBSKhmRjH2F9HDczIiPBgNYxywJR+Z+3IW7
         ldvlSpPkainjUSKoA6bOev8S3w8Hul2huZONqb3F8qmVUMhc1UjmUsQ8JETRv44u3kP/
         wQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p45ES7b7NK+c/udqJP6oKfrqjRszRW+7OJRl6m1ohCs=;
        b=K0vuN7uW/vHbtqbHV352gZXD2O5rBS9drLz/XnOIr+KbhSomaV5F0jy4GgwBcCHvhE
         yNNuL5lyzuuLdgJixHQWNGD9g/zTvxZ0lwvuo7JMhKfOjCJAbPi6yRh08i9oebUnGeXU
         9e4xYVJxeoxeuM2nacUo94St1sSOnMDorfGaHPmWOtvvylJsRJtOOXKInGoJmvxycjLo
         nok15h7C5i/zXGVsOPqfRzqhu+HrSO2hZvFMXreTXzzRVGS9ncUkAiEerRelQxoJ7+pO
         1+u7uENgZf0nHExDd98kCYQO/hqnaTsv7bVtn6hsEdmw+/p1fSRfS00l101blsDrOnbj
         rSuQ==
X-Gm-Message-State: APjAAAVutoJ7qAp9Iat3UAVT7qInnXlx3YGWwEpGR0B8AUOSKr7ItTpu
        mHSYvU2WGLKL+das5i7QnwM=
X-Google-Smtp-Source: APXvYqzUjwMw3GDo+RfKG5TirOPfv3LplbWQMkxlOS/vwn1v7YhxfMOtg3orzfwAnkVeoQN7FGm6zA==
X-Received: by 2002:a0c:ac98:: with SMTP id m24mr95586715qvc.9.1564670120245;
        Thu, 01 Aug 2019 07:35:20 -0700 (PDT)
Received: from quaco.ghostprotocols.net (189-94-128-63.3g.claro.net.br. [189.94.128.63])
        by smtp.gmail.com with ESMTPSA id r36sm38146276qte.71.2019.08.01.07.35.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 07:35:19 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id DEE3140340; Thu,  1 Aug 2019 11:35:15 -0300 (-03)
Date:   Thu, 1 Aug 2019 11:35:15 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf bench numa: Fix cpu0 binding
Message-ID: <20190801143515.GB19710@kernel.org>
References: <20190801142642.28004-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801142642.28004-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 01, 2019 at 04:26:42PM +0200, Jiri Olsa escreveu:
> Michael reported an issue with perf bench numa failing with
> binding to cpu0 with '-0' option.
> 
>   # perf bench numa mem -p 3 -t 1 -P 512 -s 100 -zZcm0 --thp 1 -M 1 -ddd
>   # Running 'numa/mem' benchmark:
> 
>    # Running main, "perf bench numa numa-mem -p 3 -t 1 -P 512 -s 100 -zZcm0 --thp 1 -M 1 -ddd"
>   binding to node 0, mask: 0000000000000001 => -1
>   perf: bench/numa.c:356: bind_to_memnode: Assertion `!(ret)' failed.
>   Aborted (core dumped)
> 
> This happens when the cpu0 is not part of node0,
> which is the benchmark assumption and we can see
> that's not the case for some powerpc servers.
> 
> Using correct node for cpu0 binding.

Thanks, applied to perf/urgent.

- Arnaldo
 
> Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Reported-by: Michael Petlan <mpetlan@redhat.com>
> Link: http://lkml.kernel.org/n/tip-9m9j1xm3xjaa1sogvbva0o8i@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/bench/numa.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index a640ca7aaada..513cb2f2fa32 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -379,8 +379,10 @@ static u8 *alloc_data(ssize_t bytes0, int map_flags,
>  
>  	/* Allocate and initialize all memory on CPU#0: */
>  	if (init_cpu0) {
> -		orig_mask = bind_to_node(0);
> -		bind_to_memnode(0);
> +		int node = numa_node_of_cpu(0);
> +
> +		orig_mask = bind_to_node(node);
> +		bind_to_memnode(node);
>  	}
>  
>  	bytes = bytes0 + HPSIZE;
> -- 
> 2.21.0

-- 

- Arnaldo
