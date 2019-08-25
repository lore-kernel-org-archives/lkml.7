Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB11C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AB62080C
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvQW9+kE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfHYObS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 10:31:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34844 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 10:31:18 -0400
Received: by mail-qk1-f195.google.com with SMTP id r21so12183773qke.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+fgqAm1h08BgghmcydOpUO4IRP3gRWmzjl2DDbpqLCU=;
        b=XvQW9+kEdUJQ18ninWksU3hZp8i/tzTErdBPgjlEWFZ6ol/pRCTaEp3H5GLH+ogj0Z
         /L1zup08wjx5m3GjGpgVan7V3EfOCLMcGu/VAGHbmgw0gRcWLER3Z8mL5r5s0hlV0ijh
         Bichz78Of3hil8toaXQeDUfCarngMCJaiETMEl7vtRqHgzhpzx+Qsy36Dzu3gyCM+G7P
         EElXqH1buirsBLbamULJRQUN02BagMXFC0Ckt9/3MwEI1c5wPK9cDc+g2f+QWNtQQHdK
         9s/nucrMnyOY/D+s8BBRoWKQ0hlP/2GSVSKN1QDanlbLNdixm3V0aADa2jYjStrjD777
         LHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+fgqAm1h08BgghmcydOpUO4IRP3gRWmzjl2DDbpqLCU=;
        b=pcOC5lpc8MhSgCwV/ARfgSbBofWCLewOPeOYca+wSecXF70RN+MqWIuJ/uBwQR98Ey
         1pECCrdpASJccZwomBFhkLdghB7D/zI5dLC6JJxn9MkRp+uVl+0wsbNnX6+sBFLL8a23
         4JSRxFUmi05FFGdje5oMjN7MPVgfkd/qelrl9yT7yBizRzFtZzUH2JXWmxgSyO23hFL1
         EkSdhs+CdL75amOwllVAZgQ9tLyWAAsci/QcMWQySWztpCDIHQq8jJ+JADMjN9WywlcY
         BpzbFQOkTGvuIHqNxtHx/WjqhPadfVgMhkB832ngKJltjyq4NSpiHhi/1crwaEjhFey1
         LfxQ==
X-Gm-Message-State: APjAAAWHS/ilvTFoqwAGrM1mntGKQHDZyFXgUFbwV89tZSU0OskHUTtl
        SzqvHidtAzXesgfYDFoP+Ihduayn
X-Google-Smtp-Source: APXvYqzWvbUrZdyy09US8d0Dll4JRplLFKLMLtUTCEG6uzP/s92m5J1TX066Ky7VP4f0nYuD5ydkkA==
X-Received: by 2002:a05:620a:4:: with SMTP id j4mr11574756qki.181.1566743476919;
        Sun, 25 Aug 2019 07:31:16 -0700 (PDT)
Received: from quaco.ghostprotocols.net (user.186-235-140-211.acesso10.net.br. [186.235.140.211])
        by smtp.gmail.com with ESMTPSA id s58sm5753805qth.59.2019.08.25.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 07:31:16 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F3D9D40340; Sun, 25 Aug 2019 11:31:13 -0300 (-03)
Date:   Sun, 25 Aug 2019 11:31:13 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 1/2] perf report: Use timestamp__scnprintf_nsec for time
 sort key
Message-ID: <20190825143113.GD26569@kernel.org>
References: <20190823210338.12360-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823210338.12360-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 23, 2019 at 02:03:37PM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Use timestamp__scnprintf_nsec to print nanoseconds for the time
> sort key, instead of open coding.

Thanks, tested and applied.

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/util/sort.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> index f9a38a1dd4d1..0985e9072db0 100644
> --- a/tools/perf/util/sort.c
> +++ b/tools/perf/util/sort.c
> @@ -668,17 +668,11 @@ sort__time_cmp(struct hist_entry *left, struct hist_entry *right)
>  static int hist_entry__time_snprintf(struct hist_entry *he, char *bf,
>  				    size_t size, unsigned int width)
>  {
> -	unsigned long secs;
> -	unsigned long long nsecs;
>  	char he_time[32];
>  
> -	nsecs = he->time;
> -	secs = nsecs / NSEC_PER_SEC;
> -	nsecs -= secs * NSEC_PER_SEC;
> -
>  	if (symbol_conf.nanosecs)
> -		snprintf(he_time, sizeof he_time, "%5lu.%09llu: ",
> -			 secs, nsecs);
> +		timestamp__scnprintf_nsec(he->time, he_time,
> +					  sizeof(he_time));
>  	else
>  		timestamp__scnprintf_usec(he->time, he_time,
>  					  sizeof(he_time));
> -- 
> 2.20.1

-- 

- Arnaldo
