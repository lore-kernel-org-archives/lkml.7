Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D9BC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDEA214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 13:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gySyvL0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733164AbfHHNgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 09:36:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39722 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733075AbfHHNgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 09:36:33 -0400
Received: by mail-qt1-f194.google.com with SMTP id l9so92062566qtu.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 06:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Tpo/mH7Db4UEwhSkEp+BZ3Zkb9wEFm+LqM2A/cER0z4=;
        b=gySyvL0B/oQLoH9eU/xy2G6QuF/UUUZSSTGNdrBU7FWFVcITTCccGPPdHZZyOe/dg5
         1Dcmv9iAfNbZ3+s+Qv/hQFlb8souwtyZyyIrnrblfihKk8YqB9WU2+SrbNj5MD6TmrS1
         veC4DWm94Umh+LPGfV8a060IYPklA7PSQZwvU2YsxVBVUtayVdJKKKKa46ppSPS/N1qO
         ObN9L9t23YS+3NC/1ytUPSFX9uc4T0Q/v62627wDu1GwiJQMlbj2xdW3wXkqiPsLtvVy
         lyF4k4ox57sMyU9TqeLSvjdgMHElYu3afC9e2Lzvf4FCZCZFVJEzlNEO2gb7KsyHZ49x
         nbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Tpo/mH7Db4UEwhSkEp+BZ3Zkb9wEFm+LqM2A/cER0z4=;
        b=cXjwQnC6u6+DvqFCOy0y+gsWOjp4pVNNjkGDDciW2WLv/gAdDvpNue/vgGc+Cog7mS
         8p/JJebozPtQi0+k8j96b+y2zfgBab5aNykB0i0uXqAlhM7lB1OYwqExhNAKp+17Dvpx
         cnahDl5i1yrbfOHU8pxHbJlkORGHRMVTK3K+mEBNBq73QSGirdK3cuTxFtpvJdx7uWHV
         CFU6GKx4sReX0ctdhyn42iqVeDq9infE5hSODJvHCln+YxMgIeNer+x4Lylbbl9TDqpi
         idodzsLalLS0eOsG12n/fFXkQOdU4Ms115fJP0G+SbKiovfY5KCIf+nAHN8CYuKBgaWF
         OvRg==
X-Gm-Message-State: APjAAAXWk5NMxagZOKibImNGkrYvRun2IM/O3I/m7mUAqh1mvLU92PiZ
        hEkrCIrwJuz9qbITbumn8ow=
X-Google-Smtp-Source: APXvYqwGCO4VXGhxvDyu5inPmVcZZKjMQLEhek3k3MfrHAurstHolF1V950XByCQvtZAhvvJMgvYnQ==
X-Received: by 2002:ac8:70cd:: with SMTP id g13mr5407324qtp.325.1565271392008;
        Thu, 08 Aug 2019 06:36:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id f25sm47679297qta.81.2019.08.08.06.36.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 06:36:31 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F31140340; Thu,  8 Aug 2019 10:36:29 -0300 (-03)
Date:   Thu, 8 Aug 2019 10:36:28 -0300
To:     zhe.he@windriver.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com, eranian@google.com,
        alexey.budankov@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf: Fix writing to illegal memory in handling
 cpumap mask
Message-ID: <20190808133628.GC19444@kernel.org>
References: <1564734592-15624-1-git-send-email-zhe.he@windriver.com>
 <1564734592-15624-2-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564734592-15624-2-git-send-email-zhe.he@windriver.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 02, 2019 at 04:29:52PM +0800, zhe.he@windriver.com escreveu:
> From: He Zhe <zhe.he@windriver.com>
> 
> cpu_map__snprint_mask would write to illegal memory pointed by zalloc(0)
> when there is only one cpu.
> 
> This patch fixes the calculation and adds sanity check against the input
> parameters.

Thanks, applied, and added the missing:

Fixes: 4400ac8a9a90 ("perf cpumap: Introduce cpu_map__snprint_mask()")

- Arnaldo
 
> Signed-off-by: He Zhe <zhe.he@windriver.com>
> ---
>  tools/perf/util/cpumap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 3acfbe3..39cce66 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -751,7 +751,10 @@ size_t cpu_map__snprint_mask(struct cpu_map *map, char *buf, size_t size)
>  	unsigned char *bitmap;
>  	int last_cpu = cpu_map__cpu(map, map->nr - 1);
>  
> -	bitmap = zalloc((last_cpu + 7) / 8);
> +	if (buf == NULL)
> +		return 0;
> +
> +	bitmap = zalloc(last_cpu / 8 + 1);
>  	if (bitmap == NULL) {
>  		buf[0] = '\0';
>  		return 0;
> -- 
> 2.7.4

-- 

- Arnaldo
