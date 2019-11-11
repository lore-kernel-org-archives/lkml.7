Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E121C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E22DB21925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkSvIJGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfKKONF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:13:05 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35153 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfKKONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:13:05 -0500
Received: by mail-qk1-f193.google.com with SMTP id i19so11275433qki.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 06:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rgSWwzjmz4uEPQ2fbZCZJBoWOHVsDThsh2PO7LUyt9U=;
        b=VkSvIJGOLzcf7QcQfb0/mXdxWbyIWH0en0EvJNrvT6m/nJvy5ZzFJBwFoXMOcLBwIq
         QxoZLlRnmAC3qZMrhlR1f+wcASOGOfO70B/+lhxRbQU4aYEx0xnnss6UsQtjcBj5vyDl
         kN2RkjjxBt6lqmv/yY8sz2Q7/IjM0Z5Ud4grEeOOU51F0o2+DLSKSb+z/wqRksd7e2Mw
         kykOhHTs+C48gjXEP/mIZZ9nEN1Md0cgxIsWvAKXDhG7nbu31Nq4Dd+PA88hXmfzb5Tx
         hg27W3rKr6KTBAyDQ/x8BIBzB9iArmrL3BTNe9d+UQSN6CLkEhSL2IIokBrvTgEqr+/r
         9dvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rgSWwzjmz4uEPQ2fbZCZJBoWOHVsDThsh2PO7LUyt9U=;
        b=XXfu5mGDdFyLZAAImmBqdMlnI9pESR/aHjo/605yj+LjBx8pYXYOI24sSRDAe1nntB
         boRLxYP/SMUSbf0sDLmzDi45vbojyTSk6CwadwhJ2rMRwrzPsBt8unZcdlqbT2Jr56dS
         GhFP663sR2VdMRF4/LHlPLfTz6ZdCya/vINoCXLu0+G42samq5AH9jVBJ2g1LOQgsf6F
         IMstfEQM9pJPLdl2nLJpgjkmSJJhWVPhpOnOqu3xYupg7w5l5I343qm755dKgJ8kvYK4
         Zrb8FgkEzPxYe5VrCpj9+muUSQbN2J+NW7tDRxjHWRE2ra+wc40cn0UvnUvuj5V7MKth
         qS9g==
X-Gm-Message-State: APjAAAXQoOCYXQVR6khworP1TexdG6suA784YYfY+axtD90bqG0j+iE3
        L13CFadiUgidaCwTx7QB3ek=
X-Google-Smtp-Source: APXvYqweIkMdG9Qp66QyhTt5QapreHZWnXsBkGjlEXZYood0pfi2V1euKFAHhTPvUQxAvFFtAb/GtA==
X-Received: by 2002:a37:c44b:: with SMTP id h11mr10672888qkm.234.1573481584176;
        Mon, 11 Nov 2019 06:13:04 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id g25sm8385222qtc.90.2019.11.11.06.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2019 06:13:03 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71331411B3; Mon, 11 Nov 2019 11:13:01 -0300 (-03)
Date:   Mon, 11 Nov 2019 11:13:01 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: address 2 parse event memory leaks
Message-ID: <20191111141301.GE9365@kernel.org>
References: <20191109075840.181231-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191109075840.181231-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 08, 2019 at 11:58:40PM -0800, Ian Rogers escreveu:
> Using return rather than YYABORT means that the stack isn't cleared up
> following a failure. The change to YYABORT means the return value is 1
> rather than -1, but the callers just check for a result of 0 (success).
> Add missing free of a list when an error occurs in event_pmu.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.y | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index 4cac830015be..e2eea4e601b4 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -284,6 +284,7 @@ PE_NAME opt_pmu_config
>  	do {						\
>  		parse_events_terms__delete($2);		\
>  		parse_events_terms__delete(orig_terms);	\
> +		free(list);				\
>  		free($1);				\
>  		free(pattern);				\
>  		YYABORT;				\
> @@ -550,7 +551,7 @@ tracepoint_name opt_event_config
>  	free($1.event);
>  	if (err) {
>  		free(list);
> -		return -1;
> +		YYABORT;
>  	}
>  	$$ = list;
>  }
> -- 
> 2.24.0.432.g9d3f5f5b63-goog

-- 

- Arnaldo
