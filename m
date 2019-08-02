Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB13EC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDCF21726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 15:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oYUAnuQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395163AbfHBPQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:16:56 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46686 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731569AbfHBPQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 11:16:55 -0400
Received: by mail-vs1-f65.google.com with SMTP id r3so51518327vsr.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=02PgarY9hGDl326q3KdZGpdoyG2z5/gmo/+lY6dtD7w=;
        b=oYUAnuQWpvva0ER9slPuzWKzdTne6KE9auRNZju1J7VZo8/tHk+wk0xJM+50nei02Y
         38hMOnGMQSIFHpkFKcPCJxox7C6uYkv00OtYM7S4GqK7EHFzOWIKvrV16H8v60WHEp61
         Dh4owbAJLrdIjAKcpCeZboNCniSCCpn4N5zlfljQsWHfLl1TYdTkFPdcXpeOUxzvrPXD
         dKdbSQf4dhgmQyqpZ2DYDkxDvJzxXQJtyeXqILY5UzeQiCzYcc1ddpCYwTWYlOPJX+35
         4ETaSN3mcWdXxxd3kJApgEb/0rPdyFdo+wB5En1GfY22RwfImLkeFCzQ3V18PRVSofDI
         VYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=02PgarY9hGDl326q3KdZGpdoyG2z5/gmo/+lY6dtD7w=;
        b=r+nuakaAZaSslCmWNeOtfB048/ttQ7k4Lqun8hhmpy6k52fpzufyEhDx5BI0WmszyN
         6iUgRrZlySbMuOOkRszin/0ezj9cbWCXUCeS2LaTC+4TjNhOzJlIQGkUVvui870muN4v
         csXY+crZi+yfNnodEqUV5BEnoP1SSu23k+nR8SgdvvsdBACrX2XktDrBOex+JjcgzO9a
         /jvgF/j/XiN2fUH1oLSAbBTajAaoYnGu8tWWJE5NvMJb+Zqv3nfjVF/UkXuDAkNw3nGa
         IU9Z1OkMFYmZrCDLxSEBBsGZaER8rkNnonc1032pUFhpeanpCTwSe9GZhMFYFdfKvbrn
         CEaw==
X-Gm-Message-State: APjAAAWwbvlL8wZiBXls79n1izYU8NCiIJVg10qkAyYBauuVRVNppg/5
        YN839vWRL+3UMxk/un9zCjvLWrCYR2g4sgyj/TMZZg==
X-Google-Smtp-Source: APXvYqwoy4HVJG+PFUlM8UABxT8+fEnJlhCe2cFSBeGIXL/cFE3IS8ytrhzDhqLehfiGAH1qqaGRCFWDqNb60AZHaeo=
X-Received: by 2002:a67:6203:: with SMTP id w3mr19595138vsb.200.1564759014867;
 Fri, 02 Aug 2019 08:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190729000259.GA24022@embeddedor>
In-Reply-To: <20190729000259.GA24022@embeddedor>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 2 Aug 2019 17:16:18 +0200
Message-ID: <CAPDyKFpv0CW2G9ServNX9UKEtGrHRK=u9KoQWfZ8LyQ6Gy3-KQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: Mark expected switch fall-through
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jul 2019 at 02:03, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Mark switch cases where we are expecting to fall through.
>
> This patch fixes the following warnings:
>
> drivers/mmc/host/sdhci-s3c.c: In function 'sdhci_s3c_probe':
> drivers/mmc/host/sdhci-s3c.c:613:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> drivers/mmc/host/sdhci-s3c.c:614:2: note: here
>   case 4:
>   ^~~~
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-s3c.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 8e4a8ba33f05..cefa0fb8cfde 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -611,6 +611,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
>         switch (pdata->max_width) {
>         case 8:
>                 host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> +               /* Fall through */
>         case 4:
>                 host->mmc->caps |= MMC_CAP_4_BIT_DATA;
>                 break;
> --
> 2.22.0
>
