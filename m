Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5D4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807AE2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mcd+2gKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfCTBzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:55:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34071 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfCTBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:55:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so544963pgq.1;
        Tue, 19 Mar 2019 18:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zLJ/uMiEq5YTdUXdWO6+7y4TcthwbeG5CkDwN5k6eA8=;
        b=Mcd+2gKgAoag8w1L8q95XO+lkKmE3n4EP3GgIST4+zLLQTFAS7OVqLMHuKp6whJBWT
         N2JsMLsYPAsTc7jA/dkulXLaxj0DwPruEuNB695fNWfpNivCrsnHbKOoVrYTooVbauld
         eDNKOSQ+holpQ102g7ryKs/hZdQOYjP8l18Ticy+hT9rshyXPGQFDb40Rqp8lWLJlXPu
         FQRrq4xv3LJErslZ2p6SGA74vFQEi89Nc2kLZDslUQoapkhYLXAmuajKxTBDw4UL6aU6
         TIfWTtGsUQxpbajswPkZ+RB1sf+s6PwUOERSWjCee6tqIQ3Ak1g5NzRnXRR9ZKfU5GeL
         qyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zLJ/uMiEq5YTdUXdWO6+7y4TcthwbeG5CkDwN5k6eA8=;
        b=JCzPF/mw3atfYxjfgpHOv68WetZdvb+7GIkpqYr8Q8rMlVQoKC5TokKa0eyRLVBJ9g
         Ksu+zoMaUwJa46Bs4Hg0S6LXUcxrptXCnbH9TkUx5qARP8I32CE1LFbDcKI3YqQRJD/A
         ztahXfKniWGzag0M6SIz+fUjzAJ5mre7oc7hy+XwhTHU1Mtzfz56hy3yJTv2f1ZiFpYF
         8o88++mGO9MbAzak8gMikbcSNwvUw4O4z4X/o3Hiw4tH0ALqR8kQP5m7+7ZeMG6chd4q
         sKyYCQqsZWDtCqhihrDzhElH84l5ApikSHm56jBBI05QUaoweJB5Ylo8KZ1IMR9eOD5d
         48IQ==
X-Gm-Message-State: APjAAAVtGVSlqSr1BpOfqjIUnxSElM7gAVu/OlnT4jFWxlGBvFu4uca3
        EkdMaDsV1wvb8U0/o7KH764=
X-Google-Smtp-Source: APXvYqwjK0dFYmBGz6AM0ZjUMxaflutOf94W8pvLO7xsqJglphsBUiEGOEDJx/K4PZgatiUoX5u/Gw==
X-Received: by 2002:a17:902:9683:: with SMTP id n3mr5287773plp.333.1553046911459;
        Tue, 19 Mar 2019 18:55:11 -0700 (PDT)
Received: from localhost ([211.246.69.17])
        by smtp.gmail.com with ESMTPSA id b138sm436261pfb.48.2019.03.19.18.55.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:55:10 -0700 (PDT)
Date:   Wed, 20 Mar 2019 10:55:07 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Makoto Wu <makotowu@google.com>
Subject: Re: [PATCH] zram: fix idle/writeback string compare
Message-ID: <20190320015507.GC4718@jagdpanzerIV>
References: <20190319231911.145968-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319231911.145968-1-minchan@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/20/19 08:19), Minchan Kim wrote:
> Cc: <stable@vger.kernel.org>	[5.0]
> Reported-by: Makoto Wu <makotowu@google.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

> +++ b/drivers/block/zram/zram_drv.c
> @@ -290,18 +290,8 @@ static ssize_t idle_store(struct device *dev,
>  	struct zram *zram = dev_to_zram(dev);
>  	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
>  	int index;
> -	char mode_buf[8];
> -	ssize_t sz;
>  
> -	sz = strscpy(mode_buf, buf, sizeof(mode_buf));
> -	if (sz <= 0)
> -		return -EINVAL;
> -
> -	/* ignore trailing new line */
> -	if (mode_buf[sz - 1] == '\n')
> -		mode_buf[sz - 1] = 0x00;
> -
> -	if (strcmp(mode_buf, "all"))
> +	if (!sysfs_streq(buf, "all"))
>  		return -EINVAL;
[..]

That's a good improvement of the code.

	-ss
