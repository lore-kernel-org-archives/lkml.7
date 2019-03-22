Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E055C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D065A206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZuKOHpAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfCVQeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:34:09 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:40249 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfCVQeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:34:08 -0400
Received: by mail-io1-f46.google.com with SMTP id d201so2200349iof.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XCAk8saCs+vjx07FiA0oCsDdc9H0fz3xlm1/QLT0rxE=;
        b=ZuKOHpAV2XYrkiBlePqoikIGkj8gekmUBbZsNRUq+0yEqqQaZEkWVlIqlkd4h+gNfp
         KCf1nBxUrxjH0pMbKjwMFgt+5J1iAXBRsYz+l4iyQ3H2ivYUF9BAi+T+xwyHPpp4fybN
         1iDpQRA/tnk65/tgnLyp4deGk0GZTDQRPSUig2s4Bg2hwEUMxbpUrf7npQ11XqnJ2xve
         Sum8XRzxlfiqMfMPNn4qZTfRYHN4bQ7THXSInGKD3YoSIidfJrEfrWhgQRq26yi080/f
         27ErB/GeoE0kk0jrsdjZJTx4iFZq3BMZR8uutSTjttBZc5KXkRI51cgVU3nlNU80UNzL
         FUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XCAk8saCs+vjx07FiA0oCsDdc9H0fz3xlm1/QLT0rxE=;
        b=aJ71sEvOdsFDobsnJrXUb6wQs5YRT7bel9Gzaj5ZkPIhSrfrRvHG1Yg2HSj758YEy6
         94c6IJf4H7dEVRc/sVTXwgVA437N1tZwTdeVwbNfhd+xzQPPbMMo1NMMN0UsVQszUPdg
         XBQzaqx2Qr30xhz4bYJozbhN9g9miPnzkppksFVwhZt33EwutbhHmlfepKPI/IXNjxoK
         OJkKueT1tRu3XFpK0LMjCKflU1P/PIUTmsOMV7jPGOxPVnjbgQCe+sVdY1x5gex6rIV+
         mWOaVgiLajBDjfQ8t6Ox572RbYl3Zdol47dJtjHIqcF8Tr6TtnmXu/Xl7GToVuKyXjft
         /ezg==
X-Gm-Message-State: APjAAAV3HwHRIQ56JKeOZTGydTQ7ApABVXEziCt1zNWmssbvU6phAc52
        WrVSdnFFNgOV9gP9S1CWulqcK1t1JyQAJJReN463hg==
X-Google-Smtp-Source: APXvYqyoUdpoiHgAMBGjOhWdwaae7giJ8fFOlqUWDqUL7v5KLYGr8s/iE2Blobpxa8TVyYDzGO9B+5y6KxiclAbKvew=
X-Received: by 2002:a5e:d608:: with SMTP id w8mr7480986iom.293.1553272448031;
 Fri, 22 Mar 2019 09:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190321151852.10216-1-yuehaibing@huawei.com>
In-Reply-To: <20190321151852.10216-1-yuehaibing@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 22 Mar 2019 10:33:57 -0600
Message-ID: <CANLsYkw_LoPTK_ahV1fGrJ_6Sok8k6wVwvsEg6Q6jffPKR_bYg@mail.gmail.com>
Subject: Re: [PATCH -next] coresight: catu: Make catu_helper_ops and catu_ops static
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2019 at 09:19, Yue Haibing <yuehaibing@huawei.com> wrote:
>
> From: YueHaibing <yuehaibing@huawei.com>
>
> Fix sparse warnings:
>
> drivers/hwtracing/coresight/coresight-catu.c:488:35: warning:
>  symbol 'catu_helper_ops' was not declared. Should it be static?
> drivers/hwtracing/coresight/coresight-catu.c:493:28: warning:
>  symbol 'catu_ops' was not declared. Should it be static?
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 170fbb6..057627a 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -485,12 +485,12 @@ static int catu_disable(struct coresight_device *csdev, void *__unused)
>         return rc;
>  }
>
> -const struct coresight_ops_helper catu_helper_ops = {
> +static const struct coresight_ops_helper catu_helper_ops = {
>         .enable = catu_enable,
>         .disable = catu_disable,
>  };
>
> -const struct coresight_ops catu_ops = {
> +static const struct coresight_ops catu_ops = {
>         .helper_ops = &catu_helper_ops,
>  };
>

Applied thanks.
Mathieu

> --
> 2.7.0
>
>
