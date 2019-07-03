Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D857DC06513
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5F821881
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 14:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="od+waCIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfGCOwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 10:52:24 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37672 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 10:52:24 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so1428817qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=stn5qcwwHGpm8C84TV1QJfdaEi2d4Bc0kRAstqO1Rgk=;
        b=od+waCIk6MIL4fea5zyIstl86SzOVnYoaOk1PD1sqjbpN0PKYw3chl43Wfr3lZymPE
         hS8cG319nBDpVqn+z7UlUdIqBYRWt3YgIMchDdk0WipkVKEBo8JCOJ1sOTYVHm+rKpEI
         LTD4cD4wrO1rw9kZ/ZNXdStLL3q7SPEOhnINCD1xZdl0FMP89To3pRf4z1Fdt9RFlvKg
         wnEskMZjOiTBKQFApsDUfuzNVkiplDiklol/lDYZlVO4DFUDMGzwX/o4Ez6ZvYDMA0SY
         OYTcYjaHaPIQa445v6DccRS6+H+dlEiN/axF3MnK2pOoK/MLy3TlIZnYmDIA/YaIAD0U
         Ue/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=stn5qcwwHGpm8C84TV1QJfdaEi2d4Bc0kRAstqO1Rgk=;
        b=apBUQkzwEGcef6zuwR53BP8aW9Xf5VupY1e+YDX3mhdwrhkSTkJw3QjeV3MXp4PipM
         Xmc4TvqporTnDIuGJnl/L+37BOFHUsnlhh5NOYp/K43BvbWylnJcHY+c0ZL3UoXyQTNn
         SKBJWoK4VkS31A7k7Z0l6TCOvDOUwMz/CZfVYN6V25F2NbVesNMwHoqzR+7psOQDBSj+
         hBSEaX4zZTQMk+NhwFV8Pk9U+0kWUAzgsIAem+Un/n/JWbtYaTx0El5WYAPBtGli4LN4
         62WjpNPMDtgLXLwjLHVir1VV56F5woYnDdrfPWEKdge3xhwwKIk+gXWXZsC9Cwq/3MR6
         rR0w==
X-Gm-Message-State: APjAAAVab7giE1tQxyQwFBB5IBtgg6brs2wNWxWsNT2fZGJNTcwp48NR
        H1qqve1bVzvVxmBPh5RYRi0=
X-Google-Smtp-Source: APXvYqyoRtQOha2JA2ryS/daOybl6vIU6qlLj0dJKYNSe8EfRv/N2zzkW9W92qWlJAXmJGQ2cbRmug==
X-Received: by 2002:ac8:2c17:: with SMTP id d23mr30433603qta.385.1562165542841;
        Wed, 03 Jul 2019 07:52:22 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id s17sm1165910qtb.60.2019.07.03.07.52.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 07:52:22 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5C17A41153; Wed,  3 Jul 2019 11:52:18 -0300 (-03)
Date:   Wed, 3 Jul 2019 11:52:18 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Do not rely on errno values for precise_ip
 fallback
Message-ID: <20190703145218.GA24332@kernel.org>
References: <20190703080949.10356-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703080949.10356-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Jul 03, 2019 at 10:09:49AM +0200, Jiri Olsa escreveu:
> Konstantin reported problem with default perf record command,
> which fails on some AMD servers, because of the default maximum
> precise config.
> 
> The current fallback mechanism counts on getting ENOTSUP errno for
> precise_ip fails, but that's not the case on some AMD servers.
> 
> We can fix this by removing the errno check completely, because the
> precise_ip fallback is separated. We can just try  (if requested by
> evsel->precise_max) all possible precise_ip, and if one succeeds we
> win, if not, we continue with standard fallback.

Thanks, applied.

Simple test shows that behaviour continues the same on x86_64.

- Arnaldo
 
> Reported-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Cc: Quentin Monnet <quentin.monnet@netronome.com>
> Cc: Kim Phillips <kim.phillips@amd.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/evsel.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5ab31a4a658d..7fb4ae82f34c 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1800,14 +1800,8 @@ static int perf_event_open(struct perf_evsel *evsel,
>  		if (fd >= 0)
>  			break;
>  
> -		/*
> -		 * Do quick precise_ip fallback if:
> -		 *  - there is precise_ip set in perf_event_attr
> -		 *  - maximum precise is requested
> -		 *  - sys_perf_event_open failed with ENOTSUP error,
> -		 *    which is associated with wrong precise_ip
> -		 */
> -		if (!precise_ip || !evsel->precise_max || (errno != ENOTSUP))
> +		/* Do not try less precise if not requested. */
> +		if (!evsel->precise_max)
>  			break;
>  
>  		/*
> -- 
> 2.21.0

-- 

- Arnaldo
