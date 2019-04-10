Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8948C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE702083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6uOWQwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732283AbfDJNIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:08:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39182 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfDJNIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:08:45 -0400
Received: by mail-qk1-f194.google.com with SMTP id c189so1137332qke.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zXqE8Yqv58ur6T6gEcKPVBzlJNHR7AFx08+xBw+rh0E=;
        b=W6uOWQwN8qU7ciWE+ocH0Bh8tdWhTvW4XW33nzfISUh9e1Li0ow2vBu0O9e7gIizN7
         JBI7drTgo8dm2Jy4OOdy8ovYdFyL6HjBiiEaJIdKbJ5YFkKbEu9T2/I/I09g3kMgtDdK
         bWKlxRfpKbYdT0qktwPdanr4AAHbvnavktdzbMOzW+ayiGnDluYCyxVdMh0u/XH7/qGa
         sDwCfzMFyDmWy8AezfIgYkg2f15Ogv08xhbSH5OC5eNto76Kr3tRk5TdIZf/eWxBojOk
         1LzDpge0GqRzJQRAjOj9FbqScJzod/iYG+54B38xc7Wp5erdIt1ktrRUDFCR/yXM+iCs
         Ihcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zXqE8Yqv58ur6T6gEcKPVBzlJNHR7AFx08+xBw+rh0E=;
        b=tNx48+FrcinNpR2p/FTgJrQ9QOZQ/JZi3h2x0eODfJ9oDM/9vOfMZja5wpHOBLMzYs
         wEXQzROkc8m6wgSc7gxSPiBGwb3iYSK/LbGU+NEfQ8dS8UhD/WbN6ca7iSGc/c088H4b
         IfMsJ3keOeEJWZ2I+RP4AG6KGSDayyyZi8f6MRyRma3yvqTgBwPpEnG7GHbO9EK1tP5z
         Iv+5ks0A9tkUMzBN7DKRVYHddpHU1pSdd0m+T9pIaY7/WkoHivPb8H1QUbbxOFb1+6Nh
         o57ZNNnOpbkMyiIOt9rjPtTr24HorZAOk0X/gLBQBRw+7f8Wp8yYlkvlzdxvmxRPN9fE
         goXQ==
X-Gm-Message-State: APjAAAV1ODeba7G5TTL3jeSiEcYn7waJaDQJLWunsaGgUDb1XSmW3/Ck
        ytItoCj61kGoCDHi+Ad/yv4=
X-Google-Smtp-Source: APXvYqxtrV2DkDI7tjpRkbkeiHCYgHvNoSxXPaFBiDTpl2sq3zHU3KoshcIbykRpvNJZbfaRLsvuPw==
X-Received: by 2002:a37:a78b:: with SMTP id q133mr34213477qke.289.1554901724767;
        Wed, 10 Apr 2019 06:08:44 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 56sm23824484qto.57.2019.04.10.06.08.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 06:08:43 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F8D34039C; Wed, 10 Apr 2019 10:08:41 -0300 (-03)
Date:   Wed, 10 Apr 2019 10:08:41 -0300
To:     Mao Han <han_mao@c-sky.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v3 1/3] perf: use hweight64 instead of hweight_long
Message-ID: <20190410130841.GE13888@kernel.org>
References: <cover.1554883878.git.han_mao@c-sky.com>
 <29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29ad7947dc8fd1ff0abd2093a72cc27a2446be9f.1554883878.git.han_mao@c-sky.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 10, 2019 at 04:16:43PM +0800, Mao Han escreveu:
> On 32-bits platform with more than 32 registers, the 64 bits mask is
> truncate to the lower 32 bits and the return value of hweight_long will
> always smaller than 32. When kernel outputs more than 32 registers, but
> the user perf program only counts 32, there will be a data mismatch
> result to overflow check fail.
> 
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Arnaldo Carvalho de Melo <acme@kernel.org>
> CC: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> CC: Jiri Olsa <jolsa@redhat.com>
> CC: Namhyung Kim <namhyung@kernel.org>
> 
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> ---
>  tools/perf/util/evsel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 7835e05..73c78be 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2322,7 +2322,7 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
>  		if (data->user_regs.abi) {
>  			u64 mask = evsel->attr.sample_regs_user;
>  
> -			sz = hweight_long(mask) * sizeof(u64);
> +			sz = hweight64(mask) * sizeof(u64);
>  			OVERFLOW_CHECK(array, sz, max_size);
>  			data->user_regs.mask = mask;
>  			data->user_regs.regs = (u64 *)array;

Later on, in the same function, perf_evsel__parse_sample() we have:

        data->intr_regs.abi = PERF_SAMPLE_REGS_ABI_NONE;
        if (type & PERF_SAMPLE_REGS_INTR) {
                OVERFLOW_CHECK_u64(array);
                data->intr_regs.abi = *array;
                array++;

                if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
                        u64 mask = evsel->attr.sample_regs_intr;

                        sz = hweight_long(mask) * sizeof(u64);
                        OVERFLOW_CHECK(array, sz, max_size);
                        data->intr_regs.mask = mask;
                        data->intr_regs.regs = (u64 *)array;
                        array = (void *)array + sz;
                }
        }

You forgot to convert that one, doing it for you,

Thanks,

- Arnaldo
