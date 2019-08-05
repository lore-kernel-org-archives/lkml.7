Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927A0C32750
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8E620679
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 05:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhZy+wh7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfHEFhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 01:37:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33493 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbfHEFhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 01:37:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id i11so13991561edq.0;
        Sun, 04 Aug 2019 22:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e7SmD7yFaW7cupdfnMf69Nas41lybmIWNy4DUrYdi6w=;
        b=lhZy+wh7Ot9Dm7RjJrPbQxWLNBhtMeA1F1ai8JvZCvtBjgyJPWXNrw6az1sZNJJuZJ
         EGtFURcXUhouTqHYbkToePxtWpqowff4TI0EnVDGiko9/Jf4KG880MnQLwHPLxQ/zAlK
         FBjSbpWnkf7bRP22CnU3Qg7iif2LxF+EcrpGK6Oi0CEzh255FxmYz1LUCuChTMhaxHbj
         qvTf4BJPR4zhu8r/I5aM7vZzZNpIgK5kblDMP2icLOU3QNouGqimoiAxYgDewZxdWJxa
         bkW813g+MBoyY3UxvP8vhw/D3app9dzTG7eDewryvRE5t6+AdMHRzomt8LgabueQ0l8s
         hB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e7SmD7yFaW7cupdfnMf69Nas41lybmIWNy4DUrYdi6w=;
        b=axB0MHRb4o0YVhuQNbpNOgPpBTpSJg2Yzdy8vUif4yrmizcMNrnG20LdDrkJ8Y8qmV
         xL/0gkADWhe3J3p9fL/opBiRo0BaMG8wWZ0kvXx2psjo5aljKrwo+sniOYpku/o1AOee
         elklAMmgXXmeHoSvrdje5/biaSiwTyU0AA312WWLx3P5fo9rUMxZLEt0aarKwsqBkxBp
         BhWr/nneCbSAEIH/yFSv8lnQMqwsx+xr6MYJVbwE2FRrijEyzouKLmGyZaq8vXw+SVtj
         UIucqzNgwvq7+5KTOrDe+3J06WGqBbyeCT+KKpYRARn1b4AU+UQEcvlZqmvmhJaNsHCX
         fmMQ==
X-Gm-Message-State: APjAAAXM7T5AE/c8H2HFyKK2Uc8FlmAHorMnqZcErbATv//pddFBbpj2
        2DEzykh/Kj95Ccu13dmore8csr11J5Hn8kikPp8a7c0hgj0=
X-Google-Smtp-Source: APXvYqzrUQ0KIxAAmZ9dGaqc1E25enFfHxJarD7mXqpkO/aMJjYoooZMKJ2WujGIRObOn/+MA4uklnkSYtnGn3fZdt0=
X-Received: by 2002:aa7:d781:: with SMTP id s1mr86532706edq.20.1564983458349;
 Sun, 04 Aug 2019 22:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190805145736.2d39f95b@canb.auug.org.au>
In-Reply-To: <20190805145736.2d39f95b@canb.auug.org.au>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Mon, 5 Aug 2019 13:37:27 +0800
Message-ID: <CANhBUQ2gBYtPhyfBizu1T6V+XCoyy-bKgkqiHKY2ZOHskg_s_Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the crypto tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 5, 2019 at 12:57 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the crypto tree, today's linux-next build (sparc64
> defconfig) failed like this:
>
> drivers/char/hw_random/n2-drv.c: In function 'n2rng_probe':
> drivers/char/hw_random/n2-drv.c:771:29: error: 'pdev' undeclared (first use in this function); did you mean 'cdev'?
>   err = devm_hwrng_register(&pdev->dev, &np->hwrng);
>                              ^~~~
>                              cdev
> drivers/char/hw_random/n2-drv.c:771:29: note: each undeclared identifier is reported only once for each function it appears in
>
> Caused by commit
>
>   3e75241be808 ("hwrng: drivers - Use device-managed registration API")
>

It is my typo, thanks for your fix!

Regards,
Chuhong

> I applied the following patch for today:
>
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 5 Aug 2019 14:49:59 +1000
> Subject: [PATCH] hwrng: fix typo in n2-drv.c
>
> Fixes: 3e75241be808 ("hwrng: drivers - Use device-managed registration API")
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/char/hw_random/n2-drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
> index 2d256b3470db..73e408146420 100644
> --- a/drivers/char/hw_random/n2-drv.c
> +++ b/drivers/char/hw_random/n2-drv.c
> @@ -768,7 +768,7 @@ static int n2rng_probe(struct platform_device *op)
>         np->hwrng.data_read = n2rng_data_read;
>         np->hwrng.priv = (unsigned long) np;
>
> -       err = devm_hwrng_register(&pdev->dev, &np->hwrng);
> +       err = devm_hwrng_register(&op->dev, &np->hwrng);
>         if (err)
>                 goto out_hvapi_unregister;
>
> --
> 2.20.1
>
> --
> Cheers,
> Stephen Rothwell
