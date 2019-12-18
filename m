Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947A3C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C4F52176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 14:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xypjkYDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfLROBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:01:51 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37524 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfLROBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:01:51 -0500
Received: by mail-ua1-f65.google.com with SMTP id f9so667880ual.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 06:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ub3jDkVXoFjawCXWgcdphIOh69+aHGNxuUvMvCWN74E=;
        b=xypjkYDvpBu+0YnibowNJfb6SWTtMnGzkvUnAAg94mM8QXUAoL0rKHH/OV3JheG3SQ
         f1zv3evsczX2rPEsrbMQzzC+kHCeNmVKbv1j1ahYLMIN58eKz5MulRphevE9Sh73la4Q
         vPjI7X3Fx545jz98jIrV8LwVoLR6B/S4+5keQd5w0I8Wb47bqgUkR+0uAXwxiVT95va3
         ME6Td/64WN44pOwthaQIqRU9R8/LpB/TTXasUlRXcjb3kGyu0dRZx2cGlbooZTmiA2iq
         k7GLW93JSceSvsyUeEsleLrv8xTHVCkJ+bF/ss/GTVR7n9PgwWE/TrkYyilul39MXiNP
         WR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ub3jDkVXoFjawCXWgcdphIOh69+aHGNxuUvMvCWN74E=;
        b=I+I0oKUV++niTwO6y7lXyJPZibCfv/LMTvCFS8plY2crycvjIxKuIn431WmI2M8K7x
         g/VMJlhNpMSOUPZOa8WUVMJZ3w9KOCo6JolKSBQn7Qq6zaCWaCGsq1D3zShuWP4fg9Xt
         Qpsb8deMsm4P5eA9jbUjYXxz0BH0YNgO7rZuwUGkiVYEubmc9wmQsITclkO/2X14rVFf
         VOh6QFQymz2Ow4wqfkmcPXPLVoYIqWrz96WMq/2wO0lr8rx0LmPTng+xsPojvBeB0cpP
         BQD24k9sZHrkqCAxirgUjLycfPZVydF2iSQAQl3tO7h3BX8Ru9jnI9pnGG7a8coNA4+6
         +YLQ==
X-Gm-Message-State: APjAAAXs7lGznI3BEtNAdg0GkVHE2gN48fxKiMMqF70+N5aKYz70mC2a
        RfkrB3qS17GhclSnDeXj2+KRQN8avhW0INKZcP9vVw==
X-Google-Smtp-Source: APXvYqyj8G0AzGnjKiPT8tWVw/h9C4RPKPz3QS7UIAnULGOVbVM57bTgtOXxLbu86sz2tuJ2mLBx0B3eASeWlXQ4bzo=
X-Received: by 2002:ab0:e16:: with SMTP id g22mr1385696uak.129.1576677709856;
 Wed, 18 Dec 2019 06:01:49 -0800 (PST)
MIME-Version: 1.0
References: <3f12c2deaae9e77a5e7ab8415db7751a27bc3b98.1575916477.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <3f12c2deaae9e77a5e7ab8415db7751a27bc3b98.1575916477.git.mirq-linux@rere.qmqm.pl>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 15:01:13 +0100
Message-ID: <CAPDyKFo3fqYUe43Hcs4pERuO6hAG9myBFDpqjsvb8heiKr274g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: remove unused ext_cd_gpio field
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Dec 2019 at 19:37, Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmq=
m.pl> wrote:
>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-s3c.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 51e096f27388..8b15945dd499 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -117,7 +117,6 @@ struct sdhci_s3c {
>         struct s3c_sdhci_platdata *pdata;
>         int                     cur_clk;
>         int                     ext_cd_irq;
> -       int                     ext_cd_gpio;
>
>         struct clk              *clk_io;
>         struct clk              *clk_bus[MAX_BUS_CLK];
> @@ -512,7 +511,6 @@ static int sdhci_s3c_probe(struct platform_device *pd=
ev)
>                         goto err_pdata_io_clk;
>         } else {
>                 memcpy(pdata, pdev->dev.platform_data, sizeof(*pdata));
> -               sc->ext_cd_gpio =3D -1; /* invalid gpio number */
>         }
>
>         drv_data =3D sdhci_s3c_get_driver_data(pdev);
> --
> 2.20.1
>
