Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1157C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC10216F4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 10:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hStAk2W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfI3Kuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 06:50:37 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42384 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729870AbfI3Kuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 06:50:37 -0400
Received: by mail-qt1-f193.google.com with SMTP id w14so16334979qto.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 03:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0ZlRJxQgHxXV/iTK2etaPZeLfsaPoLF3ThsQlsQGC3w=;
        b=hStAk2W7ZqsHYjOCSVm2pwKJ9ukacp69OByFZSZrOLDALOMNTzp3dUC2zS7htmwu3G
         7VCTAX4Ud+nkb1Iq31onWVvlSTM181HCgTprRXLuuasZGE7oh5XfmCcYqUay5cULml1C
         9nZbA5N+RTtjdorWlVCkXFIBLau+XplKBHPKLWsxQKYhXOUYQJHlgGteESrBSIxs4+XM
         m5bHnNK/ESuMQ5bWFqEafa+UhFC3+KsHz3qQF5RfdN5sE4KjcfJw2Xj+vbFIgp7p07zG
         hhQk4Z7jBjELEZFlehNxzW8WSn6R9mSJ8iyWQEPC3ViLQ/bffqj3xjoUtvLy2Faf1492
         TrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0ZlRJxQgHxXV/iTK2etaPZeLfsaPoLF3ThsQlsQGC3w=;
        b=P+iQ8oWdYBtign1k4EOQnmCLRF+KKzVzKheHBZPFqWVS39fibx86M1KR6Kzy+7Nln8
         NZ0pO7vFAv4WbJVDuf9TyAqwDu+slkWhTVNb2cGdSBxSX5JN3BD9kj058YuOlANJz4Wi
         PhV8MyX5eygCa9aUfh16jNDh3bUBTkcOpeh2b19jRlYbVi2aqr8wrb+yk/Sh3bD2Xy6J
         XftESAedKio7e+wjuMMmsPuU0py5ZyNTFmXjI2gNiISEEgEEHHfS9wRCYFNrfxH5nFgz
         A1P+e3EIXjTsed4znPZHYXlU1m+p7lvGNUlE0o5b3F/HpNTivhEEs3K008VE7YYIbttW
         WfIw==
X-Gm-Message-State: APjAAAXWaz/X0nyP9vpnyyGH7FXDA0x6Ip2fwD7nuiN0+eIUIfJ0QOvA
        MShJqjflClVU15c4VBTcK0k=
X-Google-Smtp-Source: APXvYqxstNc8Bu6ElHA4RngFW5DGKosqZBtw4gyKueUUF17qBDnIV/sa0jMBIyOsJ1wHI4OmNoipnA==
X-Received: by 2002:ac8:185d:: with SMTP id n29mr24794752qtk.237.1569840636300;
        Mon, 30 Sep 2019 03:50:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id p77sm5793646qke.6.2019.09.30.03.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 03:50:35 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D0FF740396; Mon, 30 Sep 2019 07:50:33 -0300 (-03)
Date:   Mon, 30 Sep 2019 07:50:33 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/3] perf jevents: Fix period for Intel fixed counters
Message-ID: <20190930105033.GE9622@kernel.org>
References: <20190927233546.11533-1-andi@firstfloor.org>
 <20190927233546.11533-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927233546.11533-2-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Sep 27, 2019 at 04:35:45PM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> The Intel fixed counters use a special table to override the JSON
> information. During this override the period information from
> the JSON file got dropped, which results in inst_retired.any
> and similar running with frequency mode instead of a period.
> Just specify the expected period in the table.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/pmu-events/jevents.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index d413761621b0..fa85e33762f7 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -449,12 +449,12 @@ static struct fixed {
>  	const char *name;
>  	const char *event;
>  } fixed[] = {
> -	{ "inst_retired.any", "event=0xc0" },
> -	{ "inst_retired.any_p", "event=0xc0" },
> -	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03" },
> -	{ "cpu_clk_unhalted.thread", "event=0x3c" },
> -	{ "cpu_clk_unhalted.core", "event=0x3c" },
> -	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1" },
> +	{ "inst_retired.any", "event=0xc0,period=2000003" },
> +	{ "inst_retired.any_p", "event=0xc0,period=2000003" },
> +	{ "cpu_clk_unhalted.ref", "event=0x0,umask=0x03,period=2000003" },
> +	{ "cpu_clk_unhalted.thread", "event=0x3c,period=2000003" },
> +	{ "cpu_clk_unhalted.core", "event=0x3c,period=2000003" },
> +	{ "cpu_clk_unhalted.thread_any", "event=0x3c,any=1,period=2000003" },
>  	{ NULL, NULL},
>  };
>  
> -- 
> 2.21.0

-- 

- Arnaldo
