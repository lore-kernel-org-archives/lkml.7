Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893A7CA9EA1
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62423222C6
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 07:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8OAMr9n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504929AbfJRHwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 03:52:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38410 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504820AbfJRHwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 03:52:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so3355368pfe.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0pJmJ81GxYw9u8IJm7SVtdF3GPmYHg5dQZCWkgXLGIU=;
        b=Q8OAMr9nHevdo+0lJFuF2HiKvfAJZVyax2lvF7NnqCvyVkjY04OtE6FlMWTxNcuFLZ
         wXFbUyzsXn27m08iQG1ffRg5P3+maP3h4obxTtV0KhYvEUSvZdQ/q6OxNM6hq2xia6Bb
         R2iG2WEu5PgxfTj/30FnaoQsi5i1nQI6hBKMimBkGwg5J0CRxtKfEHmFZxU2wHU5LLtN
         585ci5FLUSTq9ZZEckAjKw1bFLqI2iUlI6DnuFFp5UfRX0J4QamJTYZtFdDl1EWPHxb0
         xF5Cdqogg9gth5WjfqUsm37pwyeBz37o4z6SU7to4eh+hp4NK5C7PrfaE2+bVvoIxuuH
         PxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0pJmJ81GxYw9u8IJm7SVtdF3GPmYHg5dQZCWkgXLGIU=;
        b=k8U2pyYzpAG4XQ7Nd5YqwVWmS2q5bWPFWBgidd/b3SQdWBWa3+uo7Nn28lvFi4cD7H
         bVvPkj9YswjHyUlsVGRXIgcjD+DN5EbCfhsW7tTfwKPPlSwKw04aD4uUeAT5MuzkfAX8
         QkypPrPbGUGKmQteJG6MX+5XlSaKlbrA7DBRznPbjS0TjoGZV1h4S/zLbsXDPrLlxQ0j
         ecTYkDcyAdkAL34iXiPysHE11b+O4SEUHOD3RYW2JojGp0ZedQuJWIBQD7h9vkqqaMXf
         0ISkqfQQaNsMKUqkZei+4TG+9/5WrQL+M1ug/HhUXqerjxLDB1Us62c6imbTIz1sS3jG
         htag==
X-Gm-Message-State: APjAAAX5Vedxh3j8cAmJiSCZ6vTNEuu/jrcYsopygZtVxv4K+WTJbe6L
        LRj7400aMU6eJ2apQb5fK+xR8EA/Z+vssTOFRE8=
X-Google-Smtp-Source: APXvYqx/jvH8yxn34bDc/vIukWC/QMLPnsascOkXaCYKgaMMWM+qJLzkwl4J/dOag4my3exXSRVo0yyXMbmi5N2Vdso=
X-Received: by 2002:a62:e206:: with SMTP id a6mr5108202pfi.64.1571385150303;
 Fri, 18 Oct 2019 00:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20191018031710.41052-1-wangkefeng.wang@huawei.com>
 <20191018031850.48498-1-wangkefeng.wang@huawei.com> <20191018031850.48498-20-wangkefeng.wang@huawei.com>
In-Reply-To: <20191018031850.48498-20-wangkefeng.wang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 18 Oct 2019 10:52:19 +0300
Message-ID: <CAHp75VdL8+_nd1-H=q92qxscSYc8ovMRxrC0w19=Fw320y+oSw@mail.gmail.com>
Subject: Re: [PATCH v2 20/33] platform/x86: intel_oaktrail: Use pr_warn
 instead of pr_warning
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 6:19 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> As said in commit f2c2cbcc35d4 ("powerpc: Use pr_warn instead of
> pr_warning"), removing pr_warning so all logging messages use a
> consistent <prefix>_warn style. Let's do it.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Corentin Chary <corentin.chary@gmail.com>
> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  drivers/platform/x86/intel_oaktrail.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_oaktrail.c b/drivers/platform/x86/intel_oaktrail.c
> index 3c0438ba385e..1a09a75bd16d 100644
> --- a/drivers/platform/x86/intel_oaktrail.c
> +++ b/drivers/platform/x86/intel_oaktrail.c
> @@ -243,7 +243,7 @@ static int oaktrail_backlight_init(void)
>
>         if (IS_ERR(bd)) {
>                 oaktrail_bl_device = NULL;
> -               pr_warning("Unable to register backlight device\n");
> +               pr_warn("Unable to register backlight device\n");
>                 return PTR_ERR(bd);
>         }
>
> @@ -313,20 +313,20 @@ static int __init oaktrail_init(void)
>
>         ret = platform_driver_register(&oaktrail_driver);
>         if (ret) {
> -               pr_warning("Unable to register platform driver\n");
> +               pr_warn("Unable to register platform driver\n");
>                 goto err_driver_reg;
>         }
>
>         oaktrail_device = platform_device_alloc(DRIVER_NAME, -1);
>         if (!oaktrail_device) {
> -               pr_warning("Unable to allocate platform device\n");
> +               pr_warn("Unable to allocate platform device\n");
>                 ret = -ENOMEM;
>                 goto err_device_alloc;
>         }
>
>         ret = platform_device_add(oaktrail_device);
>         if (ret) {
> -               pr_warning("Unable to add platform device\n");
> +               pr_warn("Unable to add platform device\n");
>                 goto err_device_add;
>         }
>
> @@ -338,7 +338,7 @@ static int __init oaktrail_init(void)
>
>         ret = oaktrail_rfkill_init();
>         if (ret) {
> -               pr_warning("Setup rfkill failed\n");
> +               pr_warn("Setup rfkill failed\n");
>                 goto err_rfkill;
>         }
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
