Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7BBC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F7320657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL8skUEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEOTMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:12:20 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45040 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEOTMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:12:20 -0400
Received: by mail-qt1-f196.google.com with SMTP id f24so964698qtk.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bg7m/1qWkWo5TRhd5MX8S0XL4dmkBCvpbqi5zYfZ7i0=;
        b=gL8skUEtAL4Y5DkoqLQ7yzbg+tCFI7pFUGFFb5Ly1PBxk+9U0sEQzgEFF2eoUCd07Z
         OS/kMaLnW/1LYfj/Q049t3xscxW9HpMQaregt6GM5o/fd2FgpkVM1xLw540WT7JCdj9l
         Ym3aITt2m20DYdf4W2qZor9mQ2DPr/tsQA1/XMt36Y2q6c0g+/F4GzhT50dKbJXjobFM
         DyTfZPWGprxPW0eawFxkA0ipEPZMWEYB11jLmrxVmkYjIGz3SXS02eBu1OeHiZJbi4QY
         L3hfM3aEC3oVF2LODCAa1Il7NcbBWMuvWwQHkws2jbyZK/qLS0xiLI1SIB2H0iigS/JN
         rCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bg7m/1qWkWo5TRhd5MX8S0XL4dmkBCvpbqi5zYfZ7i0=;
        b=pmIUi9UhLvyMf42bHF3z9DsTvRHNf9COTLQgnj3yGz34m+h86YjLOdyOLiiVi+M4t/
         o4qKw/a/fpu94/HM1y3hw9sq6CkWcqWeqT+iwBDjSQ26PfnYTQZo+6kk5s8zcuUVYbZd
         wOjO5yYH1/pic6pvLq4ZtY1kmz/yl3+9nBZLOmEq2n8hOz9n60jas8sjDjftrKPV0flY
         EC7v06eZUTDZBZS0pG8wodSlKnyW5OizY36+hjTsa7nEBC9iIzw6bKT08upNSHGuas/u
         rRaMzcJMfhY3+VucwsI7TeFjYsuC5bZdjN96I92Hqh3bLVTnigvO4eKqL5ED9niEojQV
         mgwQ==
X-Gm-Message-State: APjAAAXUJRD6z2lzDk7WMNW8GM9asVN+At1on6lM/QLwf+cTSDIUInF9
        7wS9erLHRatV9oVQ2AGAXpw=
X-Google-Smtp-Source: APXvYqyw+x81fYj1T0sFd4hFL2GclK6siE65dhtSUvJoSVvX4TqlVQtTwc6hqQgSq32vLLuUQn7+iw==
X-Received: by 2002:ac8:30bb:: with SMTP id v56mr25052729qta.183.1557947538946;
        Wed, 15 May 2019 12:12:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id v195sm1689900qka.28.2019.05.15.12.12.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 12:12:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F3D70404A1; Wed, 15 May 2019 16:12:07 -0300 (-03)
Date:   Wed, 15 May 2019 16:12:07 -0300
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     acme@redhat.com, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, john.garry@huawei.com,
        wanghaibin.wang@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jevents: Remove unused variables
Message-ID: <20190515191207.GC23162@kernel.org>
References: <1557919169-23972-1-git-send-email-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1557919169-23972-1-git-send-email-yuzenghui@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 15, 2019 at 11:19:29AM +0000, Zenghui Yu escreveu:
> Fix gcc warning:

s/Fix/Address/g

Thanks, applied.

- Arnaldo
 
> pmu-events/jevents.c: In function ‘save_arch_std_events’:
> pmu-events/jevents.c:417:15: warning: unused variable ‘sb’ [-Wunused-variable]
>   struct stat *sb = data;
>                ^~
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  tools/perf/pmu-events/jevents.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 68c92bb..92e60fd 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -414,7 +414,6 @@ static int save_arch_std_events(void *data, char *name, char *event,
>  				char *metric_name, char *metric_group)
>  {
>  	struct event_struct *es;
> -	struct stat *sb = data;
>  
>  	es = malloc(sizeof(*es));
>  	if (!es)
> -- 
> 1.8.3.1
> 

-- 

- Arnaldo
