Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD31C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D8321994
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 19:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWslAz7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbfGZTJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 15:09:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40724 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfGZTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 15:09:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so53643624qtn.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I10/oU0PFDARVAgkqlcuLI1H2p3iKjf7ry3uMpP3L8s=;
        b=eWslAz7r23Ss2BSZeYLM1wHW6ES45e3i+imLBE8tIsIPLdOfqxdy+cjTx+4Qe3qE5W
         ePhDO7TNxUF1TYmz1OGoAeEAy+I1oyEriwBO+G0nwe0ygxPhnINwk4KF+rJS04jtb5i1
         CCwNGiPuJOnFCil6rgnmcW/lYk+JoUoecvuhj5LiFUiC2HOWoJHU+XOjhEFz+NjJovwx
         9pksWOMVoD+NxTtgeIg3Vh/51ab+jVlOLrKCwGrcPDX7j9h19ISjROUN5TAriGGSTnj1
         mlSsFF9ax/LNpyEX8j4NO/sGxy0UL8JHVL74Wgtay7MCZSubd3zqYGAaJvF7JHCN8TKT
         3KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=I10/oU0PFDARVAgkqlcuLI1H2p3iKjf7ry3uMpP3L8s=;
        b=Z/NuDaeo4thPF5OtB1Azb5aa3xTBu3nQ8dwLgTJJKpdptUVV74togJIUw/O3yGkkcj
         Jy838rQvhai62MJzbT36eeWkK3BejBSujOZP9lOsidwG9IEf6TjUu8/R4+jppoIR8GdG
         MkDpeIyFWm83otoLuqFmeZ0K5j6u1IRXhkmofpTo/rGz74soii8Ahyyb2mPv9bBeMDLO
         5Yhi8CP+u51Rc0ey7AjS+znpHnnz4PRg0E2YzKxDAVSzMX+Pknx+IMZsMUwlNJSddZe9
         GM2i+gCNffjUo3ygJs7q2L+AptpEJqF//Ui4XttvG7+AY7VrK9kNl3cWaiG00q6rpWjM
         1T6Q==
X-Gm-Message-State: APjAAAUAiq+DpWIkA03z8JS5FSv3pIV23WqFNJVINngODrryvTJQpLL0
        4S6yQesk77nE6GYPhlTZoAE=
X-Google-Smtp-Source: APXvYqybrE7kK+lLH0U48/mylzNlORjCn0eBxqVD5xDyu7f11v0Rpvw1atEEqp+K8m0eIeKucy97Ww==
X-Received: by 2002:aed:22af:: with SMTP id p44mr69273443qtc.348.1564168197593;
        Fri, 26 Jul 2019 12:09:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id z19sm25052511qkg.28.2019.07.26.12.09.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 12:09:57 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E1EA40340; Fri, 26 Jul 2019 16:09:53 -0300 (-03)
Date:   Fri, 26 Jul 2019 16:09:53 -0300
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [patch] perf report segfault with 0-sized strings
Message-ID: <20190726190953.GD20482@kernel.org>
References: <alpine.DEB.2.21.1907251423410.22624@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907251423410.22624@macbook-air>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 25, 2019 at 02:27:14PM -0400, Vince Weaver escreveu:
> Hello,
> 
> the perf_data_fuzzer found an issue when strings have size 0.
> malloc() in do_read_string() is happy to allocate a string of 
> size 0 but when code (in this case the pmu parser) tries to work with 
> those it will segfault.

So here are two fixes, i.e. one is to make do_read_string() to return
NULL when len is 0, which do_read_string() already returns for failure
(NULL) and most of the callers I looked handle that.

The other is to make print_pmu_mappings() deal with a NULL
ff->ph->env.pmu_mappings, agreed?

- Arnaldo
 
> Signed-off-by: Vince Weaver <vincent.weaver@maine.edu>
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index c24db7f4909c..641129efa987 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -251,6 +252,9 @@ static char *do_read_string(struct feat_fd *ff)
>  	if (do_read_u32(ff, &len))
>  		return NULL;
>  
> +	if (len==0)
> +		return NULL;
> +
>  	buf = malloc(len);
>  	if (!buf)
>  		return NULL;
> @@ -1781,6 +1785,10 @@ static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
>  	str = ff->ph->env.pmu_mappings;
>  
>  	while (pmu_num) {
> +
> +		if (str==NULL)
> +			goto error;
> +
>  		type = strtoul(str, &tmp, 0);
>  		if (*tmp != ':')
>  			goto error;

-- 

- Arnaldo
