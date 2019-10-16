Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836AAFA3728
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C31620854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 13:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6em5sPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405294AbfJPNEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 09:04:09 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34246 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405282AbfJPNEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 09:04:08 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so36009220qta.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 06:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PaygqXHQuaC5ycCiWRMEVFWLxwJSQTfQRD8hMbozOH4=;
        b=a6em5sPq1kYjTh4Gos9mjEHYuHVIoQ98XWy3VObQZGiwnnP/leACZU1CNNpZJ6o60O
         /mwUxKTvXUlAxlxFSb9BqRu92qGDsiR1JH8G0jOApChowQFE36vSlqfuvz75TUDINh8I
         Efs05XCBc8g/knvY0gGexx83lnfLwkxJSK91xRB1JUnjpJ2lHjwY+1cYctWgKs0kE8Dv
         Fs/hA6VbnEZkaHNcqpXZYjpADL+G/oznyiePyh29gY5d8j9jZmwXt4srKXwSTXzAyrAC
         K3liiotHtoBvrraYMcdDkhVajOafop/kMnFKyS9FQrh4xAum/UiLT+mL1WfF2BO9e1G5
         v8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PaygqXHQuaC5ycCiWRMEVFWLxwJSQTfQRD8hMbozOH4=;
        b=L04C4PAHhQonVSKQJCD+i7ipFmShgchZODTenZw3hfpIkB1KTCpbR/IPdGEtNh1Kxa
         bwD5v+QOqcR96VtqM1uOMA5ZYM2j5wKSsBeR3vCnzXlJgg8rqcDpHc+UBLfWzARi9RIX
         FqQxcy05JHwWbK/KAceExeTjZlQiitQJWci/KdLpbDg6X4RHyustZUb+NiUOVVbI+wSw
         q9HVu/fww+rioe9n5d6HaC8SVTrmSYMHzDCAo4IrqClwjfgj7WF4WUxzQK5PygqVR+i0
         +UhKM7cdYlO7QULg5+RN9a/a1CszSCbf9TmlBomaqEfLeEbxOXgtTIFu6NYSF/p+3rmm
         wWTQ==
X-Gm-Message-State: APjAAAWB9SSJXjn90dYSkNqrmsG5t/sVeF2S5tWUK5hvDsD0A/mFHKip
        tUIEMRdHpY1Df/XEFs4HYR4=
X-Google-Smtp-Source: APXvYqwfcq2We+5TqhLAfkE7OnROz8ZlXCvXe3ha0WVLYlpbcyKu5rl+oq5H6JP40X5Z5zo5fasWMw==
X-Received: by 2002:ac8:368b:: with SMTP id a11mr24854169qtc.362.1571231046562;
        Wed, 16 Oct 2019 06:04:06 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id b22sm11636807qkc.58.2019.10.16.06.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 06:04:05 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BE85B4DD66; Wed, 16 Oct 2019 10:04:03 -0300 (-03)
Date:   Wed, 16 Oct 2019 10:04:03 -0300
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com, linfeilong@huawei.com
Subject: Re: [PATCH] perf kmem: Fix memory leak in compact_gfp_flags()
Message-ID: <20191016130403.GA22835@kernel.org>
References: <f9e9f458-96f3-4a97-a1d5-9feec2420e07@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9e9f458-96f3-4a97-a1d5-9feec2420e07@huawei.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 16, 2019 at 04:38:45PM +0800, Yunfeng Ye escreveu:
> The memory @orig_flags is allocated by strdup(), it is freed on the
> normal path, but leak to free on the error path.

Are you using some tool to find out these problems? Or is it just visual
inspection?

- Arnaldo
 
> Fix this by adding free(orig_flags) on the error path.
> 
> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> ---
>  tools/perf/builtin-kmem.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 1e61e353f579..9661671cc26e 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -691,6 +691,7 @@ static char *compact_gfp_flags(char *gfp_flags)
>  			new = realloc(new_flags, len + strlen(cpt) + 2);
>  			if (new == NULL) {
>  				free(new_flags);
> +				free(orig_flags);
>  				return NULL;
>  			}
> 
> -- 
> 2.7.4.3

-- 

- Arnaldo
