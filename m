Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264B3C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F188A20718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="drTQw6Ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfKNTNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:13:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46849 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfKNTNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:13:46 -0500
Received: by mail-qt1-f195.google.com with SMTP id r20so7961416qtp.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 11:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s7K7QRUqbf9Temd7llxS32t393V34zAyTAVFia8Ciqc=;
        b=drTQw6Ua+mo61cZncZs42n6HGq/ohCgLCnzjKOx9MVS8CzNVABU+Md5TsNodLdK7Eg
         o6pLh/fr3ciysaqtJyYsnteVFKW0XTnwiz4QVdB6sbhIXW/sQ/Hb24z/yt29p4sgmZzx
         a+E81Xune6EjZ7+P/fGozRwN9XTP95h8r2cncICSBH7Bw01/l8CBttIGGbLBgkNO8h6T
         ZCGihzXlwH5wOiTS+7TwkBc8COa6wkIYVQIxa1fET5iB3RgfvD0IjPVDoMq8IXWM+fiE
         IrAAWGMPTY9GL+VKzy189BYVJfYtu32OAncox8Fuv+Ycck+HWQX6m4VCMbPdIJwoLIt3
         TvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s7K7QRUqbf9Temd7llxS32t393V34zAyTAVFia8Ciqc=;
        b=Es+EQQdBD1rWyCOsq9Zui57pO2LLAn0m84LyDR8aEQ3ZxMHzKAgqu/LoZ7aMwIzrlf
         saNDvJHwrmu+zj8MgbGBz2E9RN88WzFrqgvYDiDHR/2KtgprSHLO2aSg+bvXepLECtBk
         l6q7f3ezU9YMUfGybfqa9Y6nU4AxGG13FEQ8XKek8vt0k/RNqNGNTP41K5JdZXk0pYAY
         ijiX8zQtGOCbJ3DTgcX29y38a9i00W68jT2YPwA/SHP0lmvBsPGYDkDSJQSte1NfpvR6
         8Jign7yvDTEdWv8be+Tn/lo98Zdr5GwqmNW8J3WIpyQgjAIPR6przHwVJskXP73TsByD
         6e3g==
X-Gm-Message-State: APjAAAUQrOBJvOEkYHxkGLJUOzN2d44uvUG13ALAsxMf1vaXru5cVPiy
        CDuHZNDG5jdT1daoUyxuBNI=
X-Google-Smtp-Source: APXvYqwMEoFf7Uo4uEQC7K9dQ3SqZxtAo+Dd3ACkx2WOvqrq8yhGcM73XkjIToDP03cTdttbhWsUnA==
X-Received: by 2002:ac8:434a:: with SMTP id a10mr10172411qtn.263.1573758825583;
        Thu, 14 Nov 2019 11:13:45 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-107-110.3g.claro.net.br. [187.26.107.110])
        by smtp.gmail.com with ESMTPSA id 7sm3154706qkf.67.2019.11.14.11.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 11:13:44 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D216B40D3E; Thu, 14 Nov 2019 16:13:35 -0300 (-03)
Date:   Thu, 14 Nov 2019 16:13:35 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf callchain: Fix segfault in
 thread__resolve_callchain_sample()
Message-ID: <20191114191335.GA24290@kernel.org>
References: <20191114142538.4097-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114142538.4097-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 14, 2019 at 04:25:38PM +0200, Adrian Hunter escreveu:
> Do not dereference 'chain' when it is NULL.
> 
>   $ perf record -e intel_pt//u -e branch-misses:u uname
>   $ perf report --itrace=l --branch-history
>   perf: Segmentation fault

Thanks, tested and applied.

- Arnaldo
 
> Fixes: e9024d519d89 ("perf callchain: Honour the ordering of PERF_CONTEXT_{USER,KERNEL,etc}")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 6a0f5c25ce3e..0a21ab69a247 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2414,7 +2414,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
>  	}
>  
>  check_calls:
> -	if (callchain_param.order != ORDER_CALLEE) {
> +	if (chain && callchain_param.order != ORDER_CALLEE) {
>  		err = find_prev_cpumode(chain, thread, cursor, parent, root_al,
>  					&cpumode, chain->nr - first_call);
>  		if (err)
> -- 
> 2.17.1

-- 

- Arnaldo
