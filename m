Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F4BC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B172147A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 10:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="REEy4gm9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfD2KpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 06:45:16 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35531 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbfD2KpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 06:45:16 -0400
Received: by mail-ua1-f68.google.com with SMTP id g16so642071uad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 03:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7gYtkBUOPSLv5k145jA7GYbd8ECOPvHhL9iGTr636I=;
        b=REEy4gm9xyMYbOdHYdCvOmm7vnZyiUb5EaRfeMyl+x3d55eCmnA7TZLoapypFxIcYU
         3cCiY7IWQkqxILzRwSKSt4JzzmB2S0eiKLWeA8yej3B9i92HoKdcfwalt98wocnVgj03
         +O7WwpTCGmf21LIKaTP5u9TqlFZCod1vp5F+FitshF8m8amHduYET+Y1XTvNvh0VVXir
         DCoIqusd5S/rM88BeW+L740a0LxiekzIlyTbCVbF0QCBBEQm//QeRWt75RScoZLgxX+2
         7TFqyxbNZzYYDZiRt5U/u26j2/ZgPn7dG/HtEfYaT9JQtOdy5wwyxJBNbsI1tXv6JASk
         YGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7gYtkBUOPSLv5k145jA7GYbd8ECOPvHhL9iGTr636I=;
        b=sWGlIb58ggBKxTPIBcCz716AHJdUwemL4wpyu8lrem+0V6Jz4TGVjtQX2EIu684Y5F
         S4dp6LIcBsSpk/h8+4rdwGFAMr0hgbFwqi01lsk5JvRlvq1RfjZNzQHOBDGs44g6jBR0
         keT70nQkLcn8oFYyNDsLfJcvE436Au9gZkId2vQCzksI6gqmC2N6m/i4qYlgr1zNqRmh
         i1NpVz/G5z6QqcaZEHi/5qeycsHIDMC11nZ4onWrqgLCsOqxW9ansxyy+PEd4Cv96AFd
         VRkSTtUd4UQc50cX7h40NBVkGFQ7jt8Pj7zkXRHIOGb4nZzywipz4QehIXRTQBeQXC/I
         xNLw==
X-Gm-Message-State: APjAAAVcQV9nMSmMgojida12EERkxm7B1zItRg/9INse1X6YABE7Z9yv
        81MqeIcFQw05LueKXct0keJ3sCk/2QT3tj7wEcO5zz1B
X-Google-Smtp-Source: APXvYqyoVysFFYfkvez3o3QNevz4TfKGfpa11v2MQNm1z+VzGayWpSsj88VnbGsZRi070xCmuHQQNe0FuHgUaZmpg4s=
X-Received: by 2002:ab0:2a53:: with SMTP id p19mr4955459uar.100.1556534715006;
 Mon, 29 Apr 2019 03:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190416075845.GA15615@amd>
In-Reply-To: <20190416075845.GA15615@amd>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 29 Apr 2019 12:44:38 +0200
Message-ID: <CAPDyKFrORt9P1f2NmZRQkwY353K2jicRueWxY-aKVO9oTG_qOQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Fix warning and undefined behavior in mmc
 voltage handling
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Apr 2019 at 09:58, Pavel Machek <pavel@ucw.cz> wrote:
>
>
> !voltage_ranges is tested for too late, allowing warning and undefined
> behavior. Fix that.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied for next, thanks!

Kind regards
Uffe


>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 3a4402a..b3fa9c9 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -363,11 +363,11 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>         int num_ranges, i;
>
>         voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
> -       num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>         if (!voltage_ranges) {
>                 pr_debug("%pOF: voltage-ranges unspecified\n", np);
>                 return 0;
>         }
> +       num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
>         if (!num_ranges) {
>                 pr_err("%pOF: voltage-ranges empty\n", np);
>                 return -EINVAL;
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
