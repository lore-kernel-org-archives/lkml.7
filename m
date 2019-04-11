Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E546C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F8B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 11:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXyowxng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDKLBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 07:01:54 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46854 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfDKLBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 07:01:53 -0400
Received: by mail-vs1-f68.google.com with SMTP id e2so3186588vsc.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 04:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDqohFlSwNc4TTMK6tjkDhfZYXNScmh7dJMV8w8OofE=;
        b=MXyowxngEtoxsW3zLCAmpPTfB5kTJhmvNlieokm4Rh7Xd0JiLxvq1o9w4BM46jY7EW
         GfpoAVa/enhvgC/Q9AH4YhxwZaJPN907wJKCt+2Gt6waAGGJmWDIFTPnwDgexlUtVV9u
         EUz9kek8m9X3cTH6kMBZWMi5VgDgRN7CtHYHwaUvhQw0DrUhVqguJa49vi+rA7nfbQAa
         PgAuyUBXJQeuT5VftE1e/ifQgVyfdhMMO5r2qMuUOQJJfUvc+ucWAG4rfM3gkCdYwHMU
         P/o7yGHHQQ2DkXvLaPOCroV6XOwJsJbJC+8I0VfpPKS18blyokdal1Xie7+196/SRYrm
         tEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDqohFlSwNc4TTMK6tjkDhfZYXNScmh7dJMV8w8OofE=;
        b=Jgo0KmclGVcTXgjHRx6V7m1Fdp2Q7zqHa8xJ8wjtuarsO1O33mVJG8Jhta8fmPdD1Y
         mDcbAfh2iMeTFt0GAd8hLzp75ROlQEnJMv7xhYZBJT61ryTitGtMnlF77wAyUWUt59sp
         RBa2rOat9LA/iBjPr0sFIqQduuBWJ5CbIU5EC2jWD/h6sGxlDzrROzqaDjGv15cA7l2E
         /BLEGau0OSmh+xEVFxGdla84RLhO2DxxG2QUxWvXql+d7JGO5uQaew4oxbW0quy9GMNa
         lqFsNpz2gph56G1uGbqDa9ciLyprXocQoLOEeRHGkj+AlF2lGK1NWdXtwJUre1FRdrfX
         klGw==
X-Gm-Message-State: APjAAAWaPPP6NLKy9BIFeR9H0EvdVVlXa4+elTPNfwG30b2AxA0XVJBN
        vD343i6OiRNjZh28lw0YJKRoBbYA+Yqt9T7CQFY9FQ==
X-Google-Smtp-Source: APXvYqyHFcQXX0WlvAi6y6D/hRb/QlOoiWJoAmYdjDDxSHAsYm9zAJ6faLyKKK/FmTJUYTWx4fsog/iWQm8TGsY1IRo=
X-Received: by 2002:a67:fa95:: with SMTP id f21mr26912415vsq.180.1554980512968;
 Thu, 11 Apr 2019 04:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190411025904.188152-1-yuehaibing@huawei.com>
In-Reply-To: <20190411025904.188152-1-yuehaibing@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Apr 2019 13:01:17 +0200
Message-ID: <CAPDyKFq8icX27w2FaLgTWtdV1MicfVO+rG_5sZT9n-5pT7iAWg@mail.gmail.com>
Subject: Re: [PATCH -next] memstick: remove set but not used variable 'data'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Will Deacon <will.deacon@arm.com>, Jens Axboe <axboe@kernel.dk>,
        Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Apr 2019 at 04:48, YueHaibing <yuehaibing@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/memstick/host/jmb38x_ms.c: In function 'jmb38x_ms_issue_cmd':
> drivers/memstick/host/jmb38x_ms.c:371:17: warning:
>  variable 'data' set but not used [-Wunused-but-set-variable]
>
> It's never used since introduction and can be removed.
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied for next (to my mmc tree), thanks!

Next time, please post to linux-mmc as well.

Kind regards
Uffe


> ---
>  drivers/memstick/host/jmb38x_ms.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index e3a5af65dbce..acec09813419 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -368,7 +368,6 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
>  static int jmb38x_ms_issue_cmd(struct memstick_host *msh)
>  {
>         struct jmb38x_ms_host *host = memstick_priv(msh);
> -       unsigned char *data;
>         unsigned int data_len, cmd, t_val;
>
>         if (!(STATUS_HAS_MEDIA & readl(host->addr + STATUS))) {
> @@ -400,8 +399,6 @@ static int jmb38x_ms_issue_cmd(struct memstick_host *msh)
>                         cmd |= TPC_WAIT_INT;
>         }
>
> -       data = host->req->data;
> -
>         if (!no_dma)
>                 host->cmd_flags |= DMA_DATA;
>
>
>
