Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06D3C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8010F2081B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 07:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564039432;
	bh=yLBS79RacfNg6ARLZ0IM2pWRWzR+JhAuTHcK7Bi5sus=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ATaVPxSMBqJpZwxw/39nV3OdLZCvfTMojVtmGhUJnB5LmTIgzxZh2/3euHqn8kn/u
	 EP2DZFyUdNkSZZgKeG5yNDFPA40kW6e+cAg7n3ktGA+5576F6iBsAexSa5exojcxcC
	 +TEGpWvj1d+2pEoIvyXM9n638eQjZ90J55nVxMNE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfGYHXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:23:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387990AbfGYHXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 03:23:51 -0400
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CC742081B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564039430;
        bh=yLBS79RacfNg6ARLZ0IM2pWRWzR+JhAuTHcK7Bi5sus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=061Mb/6SY+cgcTn9YWM++jfwZFbsnpFfOWMCuSD0z161IqIJFhXiN4XCkmEcxAb12
         fdjo1W+gO4JRbbfwHzernMKnp684VuQ5anTe9VSMhgnlxxn4fOKmyZFYyCA/R0/BoK
         Kf1steOJaDnmICX5dAjephI+0MjW6XjpRzcloPh8=
Received: by mail-lj1-f176.google.com with SMTP id t28so46984654lje.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 00:23:50 -0700 (PDT)
X-Gm-Message-State: APjAAAUhGuyC+XZXfIWkyURGvmN3cIeqinl+q54XOfOkSH4IIGacDo7B
        4vUgLUEyOIYnLfB2nbXNeC+nqv+ezCpBCYfLpls=
X-Google-Smtp-Source: APXvYqw2lqTY/8+7BqE80WKNGpSC/iiVIEbJrqTL3JiKPZIjiCMODHdAxOfHhDwrYE/YgD3YDElRG1dUz49EIqK96zQ=
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr19996420ljm.5.1564039428406;
 Thu, 25 Jul 2019 00:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190725063644.5982-1-gomonovych@gmail.com>
In-Reply-To: <20190725063644.5982-1-gomonovych@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Thu, 25 Jul 2019 09:23:37 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd1sL_GqajZN6YAz+frapt2wCCW9WPvF8eYGsZ9iOdxsg@mail.gmail.com>
Message-ID: <CAJKOXPd1sL_GqajZN6YAz+frapt2wCCW9WPvF8eYGsZ9iOdxsg@mail.gmail.com>
Subject: Re: [PATCH] extcon: max77693: Add extra IRQF_ONESHOT
To:     Vasyl Gomonovych <gomonovych@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, myungjoo.ham@samsung.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2019 at 08:37, Vasyl Gomonovych <gomonovych@gmail.com> wrote:
>
> Do not fire irq again until thread done
> This issue was found by code inspection
> Coccicheck irqf_oneshot.cocci

Rationale does not look convincing. Do you fix real problem or just
automatic fix from coccinelle? If the latter, then it looks wrong.
This is virtual IRQ so no need for oneshot. The hardware IRQ has
oneshot set. Otherwise please provide slightly more specific rationale
for this commit.

Best regards,
Krzysztof


>
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> ---
>  drivers/extcon/extcon-max77693.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/extcon/extcon-max77693.c b/drivers/extcon/extcon-max77693.c
> index 32fc5a66ffa9..68e42cd87e98 100644
> --- a/drivers/extcon/extcon-max77693.c
> +++ b/drivers/extcon/extcon-max77693.c
> @@ -1142,7 +1142,7 @@ static int max77693_muic_probe(struct platform_device *pdev)
>
>                 ret = devm_request_threaded_irq(&pdev->dev, virq, NULL,
>                                 max77693_muic_irq_handler,
> -                               IRQF_NO_SUSPEND,
> +                               IRQF_NO_SUSPEND | IRQF_ONESHOT,
>                                 muic_irq->name, info);
>                 if (ret) {
>                         dev_err(&pdev->dev,
> --
> 2.17.1
>
