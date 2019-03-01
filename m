Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FB3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681E820857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhv+6ofr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389540AbfCARtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:49:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34465 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfCARtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:49:45 -0500
Received: by mail-qk1-f194.google.com with SMTP id a15so14789886qkc.1;
        Fri, 01 Mar 2019 09:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cVb9Egsz95MGkLg50sVh3muAd5uShcFl5o5Secm3E+I=;
        b=lhv+6ofrdPxSrWgJ7QCiv01MC6HYM8icyrgDftjQmiE2hxnziWuS32bbkUYTT5gdSw
         zdk3WD/lL/d+bLAzXKYN5mvrhLNWNdRwGj98LXuxQKVLiNiWvFsGafUJO2lrOrgA7Bgm
         ++eVb8nEenrtkyMLQN5DhVPM69/0R2/BzRNkYb7O/nQ8spdSsRCERozYfCWZlut0WwRB
         N/mEA55hfdtiE20hYtPMFVQYtZpQaUDwD6l6U5M/MSVva+JfqJd2QxHz3e7oLDIvd3cH
         rcPT7ASuN9iUJ9rG7LurhZPlNZpvHeSejQMEH94RPtFEs7ofWrR3pQySfZSfW54IzCeU
         hktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cVb9Egsz95MGkLg50sVh3muAd5uShcFl5o5Secm3E+I=;
        b=jsB71Nduj9PRc5bJGiv5LaVjox94nMGVWUz5c+44B2hBJxyWKY6I+9I0tzsMaLgyB/
         uM/T3+LFFYK77/JtyhBLphNklEqiUv2uS1TlF3mLgWp1SIEooMugxButsnnA9N0s9EQr
         qNnuXxQzhCwLcq9No6EHCwJ3Q+DPr8EsZGcr6HoH4t//JO9RrVaPN4WYoBThOZRRVkPm
         p6moAjHRDFCtyU2Ll7rentDAxqqw8gJ+hM6uqgGEdaNI9xuaXOXY+uupAqnajTUer6Sx
         CxHiiFUN9pBgPYPx7niJAUNw4KPEbkJ1tTVGc8X4A47uD2zfVYNPkOghqcbY2mgDmcX2
         uQfg==
X-Gm-Message-State: APjAAAUBZZk09g7nY/SgUQ+aeJAs5J3s2lVZk3VlE3KAAyzWSlrP0EMY
        rWbkNn0RTRCXpBBXxZge2ek=
X-Google-Smtp-Source: APXvYqyAk0XwzxOAU239kv6WILcVSySw/6RP8tooNajr+Acu0a4g1hmwGB+30D7EOEXj7sIANjS+vg==
X-Received: by 2002:ae9:f101:: with SMTP id k1mr4911812qkg.111.1551462583800;
        Fri, 01 Mar 2019 09:49:43 -0800 (PST)
Received: from quaco.ghostprotocols.net (177-59-143-241.3g.claro.net.br. [177.59.143.241])
        by smtp.gmail.com with ESMTPSA id i65sm21360513qki.32.2019.03.01.09.49.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Mar 2019 09:49:42 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F3EAD4039C; Fri,  1 Mar 2019 14:49:39 -0300 (-03)
Date:   Fri, 1 Mar 2019 14:49:39 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf intel-pt: Fix divide by zero
Message-ID: <20190301174939.GJ13100@kernel.org>
References: <20190301103536.7197-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301103536.7197-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 01, 2019 at 12:35:36PM +0200, Adrian Hunter escreveu:
> When tsc is not available, "timeless" decoding is used but a divide by
> zero occurs if perf_time_to_tsc() is called. Ensure the divisor is not
> zero.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # v4.9+
> ---
>  tools/perf/util/intel-pt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index 3b497bab4324..6d288237887b 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -2531,6 +2531,8 @@ int intel_pt_process_auxtrace_info(union perf_event *event,
>  	}
>  
>  	pt->timeless_decoding = intel_pt_timeless_decoding(pt);
> +	if (pt->timeless_decoding && !pt->tc.time_mult)
> +		pt->tc.time_mult = 1;
>  	pt->have_tsc = intel_pt_have_tsc(pt);
>  	pt->sampling_mode = false;
>  	pt->est_tsc = !pt->timeless_decoding;
> -- 
> 2.17.1

-- 

- Arnaldo
