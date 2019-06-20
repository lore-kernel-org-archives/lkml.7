Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC199C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6A32083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:37:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qZvhTIf6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfFTPhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:37:52 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44642 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731805AbfFTPhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:37:51 -0400
Received: by mail-vs1-f65.google.com with SMTP id v129so1807749vsb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fAkCXQIzvrGJE7G4mvAtSJe7EeGegVZuqg9dRlW43UQ=;
        b=qZvhTIf6xU/oaLzt7SZvKqOjBmRxjhPFeS5pyLry1fPU9IkIP9bflMbQ9thXT5EZab
         WlMJiJI2TmkRrmM40j0SWz7IlRD5QQIokXVt37a9crDWUalwOPfVxDD+Hgtrv1809EsV
         zhJyLJ7r/bPcEYis1k2KA7UV2HvLz3wTxVFTYMrpmQJsxuZe+KZZxfPyPum6xf2FTu+g
         ygJjeyu/cSAsat4GbilOKDVqmgXFhk6PduBzoV9TaS5H2gsOFjobDYH53f2mZuOL0Ty+
         tqpXhAYwjjIA0rnm//k5dDfSIVqWelTU1xQzsVTZ3nrwqU97PnuPu8Y7gR11N2y/Ae/c
         UmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fAkCXQIzvrGJE7G4mvAtSJe7EeGegVZuqg9dRlW43UQ=;
        b=br6RtqVAYwizJ2czI1RpCyAtDX0QQzL1fOU0jxzSiFYGz84IpbuS4yty5/C8vfGpEa
         7qYZGbvZ+viVE5ADptmueAthjjxC4FY6KQEmrPyvBGvdl3sTOqa83gXbqbq11shINek7
         HrbLFP0tQTrFtnA6dLkRHY8iHNDlXu8eyJ9DUyWVzF+GrqKTqvc9tqlqjpX0ERSKHWjL
         nNjDeTeHAahJGKYERup2lRX9vOljGoUCEHbogrZQ9w7BXhK+S0T/loIexDBJhWEkUnWQ
         iX5PLBsWJazp9hhiP54hOc0rkWzlYg9zK5mfmN/Sd2d65+Ei8kND/PCB+MQBKzPdvNbI
         hRDw==
X-Gm-Message-State: APjAAAV9A/lVjWxKGPGt5GtVWkty0T+debCLVRYqCpy+zkwZqpDBpItn
        3D1TAumzDnN9hWIlimpu7UpRRF0TeQ4sD1cMfCL7qKuiuBk=
X-Google-Smtp-Source: APXvYqyjsTzxd6ILuE03oriIxK2fzvr1/YmzfivHfyCj2Ep7ML74BwZifmWATzt0v+egEgHdDeR3Zhhxm5KzDflUv0Q=
X-Received: by 2002:a67:ee5b:: with SMTP id g27mr11197551vsp.165.1561045070853;
 Thu, 20 Jun 2019 08:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190620152432.1408278-1-lkundrak@v3.sk>
In-Reply-To: <20190620152432.1408278-1-lkundrak@v3.sk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 20 Jun 2019 17:37:14 +0200
Message-ID: <CAPDyKFrSQR7+POv++8jW5VF4hTcQbNwZzqHntK1k4eNpy2gH=Q@mail.gmail.com>
Subject: Re: [PATCH RESEND] mmc: core: try to use an id from the devicetree
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Doug

On Thu, 20 Jun 2019 at 17:24, Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> If there's a mmc* alias in the device tree, take the device number from
> it, so that we end up with a device name that matches the alias.

Lots of people would be happy if I queue something along the lines of
what you propose. I am not really having any big problems with it, but
I am reluctant to queue it because of other peoples quite strong
opinions [1] that have been expressed in regards to this already.

Kind regards
Uffe

[1]
https://www.spinics.net/lists/devicetree-spec/msg00254.html

>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/mmc/core/host.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 6a51f7a06ce7..4733ddb894da 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -411,7 +411,12 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         /* scanning will be enabled when we're ready */
>         host->rescan_disable = 1;
>
> -       err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
> +       /* prefer an alias */
> +       err = of_alias_get_id(dev->of_node, "mmc");
> +       if (err < 0)
> +               err = 0;
> +
> +       err = ida_simple_get(&mmc_host_ida, err, 0, GFP_KERNEL);
>         if (err < 0) {
>                 kfree(host);
>                 return NULL;
> --
> 2.21.0
>
