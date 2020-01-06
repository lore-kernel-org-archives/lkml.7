Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2435C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE1D2080A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 22:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ7MhDAQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgAFWQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 17:16:52 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34060 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgAFWQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 17:16:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so43749158qtz.1;
        Mon, 06 Jan 2020 14:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+nXiDz6R5HZcfgMTAAzizU/KV5oJuJ/6T5HyojKY08o=;
        b=ZZ7MhDAQ8RDL0V1dX4mHwvQjNz1uriecaCSzCEVoo8cXs05h4HTFVQnVaEmEpGXWBU
         borZL4D4AhAwREU+y8x+bL0oO8jDoRUTRQIbosoOQ/eaSCizLy9JCdJIVQmqlVL8lPcm
         QqIbgBqzCNI2UbkmGv++4HS/d1P270VztznESXvgdSr9yLrbRwYMG5yWTnuSD0ECv9Bh
         n5NqcKe/iF4VBeWEJGsk+eF1uAWErz25bBem18J+1z2+b/Ln8C2Lf3qnea/l7G//qWsr
         gQtTc9D5Ewa4miu5kzXWia0wPXxmmRFgIJSLfQBx5wJ4gebF6UTUIfGd+Duof8zWqfPJ
         LQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+nXiDz6R5HZcfgMTAAzizU/KV5oJuJ/6T5HyojKY08o=;
        b=O/iVN5d19JsBZT2wRMgGZ/pwV9dT2D5yg8qn8UKW2usTuYjEs5TItYLKjgCcuqRE4d
         g4jyvZc7Ut7nk7LjFE/QWjnPmrvlsQhlc56v5kSaWrCj0KRBWPPd+VsxMsoM8qPQMl+C
         7RSAPRTVkiLUCboAK97XeZ58a2OTLMLShm1qnrEvqD6YdW5T3bYpct1OslOlNrcqbNqL
         m5RaDS9rmoqCaPdt/4bVC79w7vWtK4OXkcXnNIeBd1i2Pc6ULi6dQoOKNL2wqEzzry5q
         /pkPxDX6HqrD/vfuswrRbTtkmDyBnuxQV11SUmfYvug3FNHEGT0gf/S5pR5QdgzeB2Q3
         6oFQ==
X-Gm-Message-State: APjAAAXqjBsI9w6gYtXw/MjNVgJFeixq5avEUq68u7GzEN2YtmcL/VBZ
        3wtPmL3JpBEf9Hig8xQ5U+E=
X-Google-Smtp-Source: APXvYqwKGd4ocv9wBiE7LiOCeYO14bY5ctkoB0WpVgTp86bGNBvpzBfR8C1p5a/cVspZmgiLEbwFtg==
X-Received: by 2002:ac8:685:: with SMTP id f5mr75848158qth.199.1578349010378;
        Mon, 06 Jan 2020 14:16:50 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 124sm21518200qkn.58.2020.01.06.14.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 14:16:49 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99EAB40DFD; Mon,  6 Jan 2020 19:16:47 -0300 (-03)
Date:   Mon, 6 Jan 2020 19:16:47 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf report: Clarify in help that --children is default
Message-ID: <20200106221647.GA16851@kernel.org>
References: <20200103183643.149150-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103183643.149150-1-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jan 03, 2020 at 10:36:43AM -0800, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Refer to --no-children, which is what most people probably
> want.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-report.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 387311c67264..059639f437e5 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -1163,7 +1163,8 @@ int cmd_report(int argc, const char **argv)
>  			     report_callchain_help, &report_parse_callchain_opt,
>  			     callchain_default_opt),
>  	OPT_BOOLEAN(0, "children", &symbol_conf.cumulate_callchain,
> -		    "Accumulate callchains of children and show total overhead as well"),
> +		    "Accumulate callchains of children and show total overhead as well. "
> +		    "Enabled by default, use --no-children to disable."),
>  	OPT_INTEGER(0, "max-stack", &report.max_stack,
>  		    "Set the maximum stack depth when parsing the callchain, "
>  		    "anything beyond the specified depth will be ignored. "
> -- 
> 2.23.0

-- 

- Arnaldo
