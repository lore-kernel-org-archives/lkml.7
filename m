Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAB8C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E744C2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="gVztby/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbfLLI3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 03:29:06 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:35561 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfLLI3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 03:29:05 -0500
Received: by mail-vs1-f66.google.com with SMTP id x123so976598vsc.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 00:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgxCnRiTfja1L+B6Xn0JuIUwn0x0QrtKVBtLGuTEljg=;
        b=gVztby/BHQJ9PZBKa3D0z7om1skfkDzVsuhBRH82k9/hXT9aRdfZ6KGtjWHOutFleq
         uF1WSfJ8tUrou3WPu+hDg5If+SNIO2Ufb6a+9pPgHemfEqDmvBGYc79gx+x1N0w8G0b1
         l1mEnz/PBcmVnZppUrc7t6d4FNIcEk6K6weCBa6/VehlKZP6Ob5UcMo1iORqF65cBM/c
         Iv41qh9jbeSX7tFgULRbU1bGCyznTNPQrmyJqJoywgSrOx082uCOuDCRoTAmQ/wANuxW
         GK/IyyFBIHd5E9Li4OslsbEGWt4pWiS40vkZpksi5880AnShIACe0dpD/onBAzjlkhvw
         nHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgxCnRiTfja1L+B6Xn0JuIUwn0x0QrtKVBtLGuTEljg=;
        b=gouz0FxsVYzFU0k3tRciGiUOgqs8qvC434dZCYs0REOB4l52J5Isro7rvpxxYeyGML
         Gq9LZYGMQyoi51vkOwd73kvKJsvo6HLula3b2LZ/CWvuue/mmVYOKSan4FiUVH/AeOm2
         ixLEZtOp/+TVMIzEcecSwMPC5VaaHj0mYBDbP3JHS11tJvZLBP2ToLBvkUKpm4dXGtGH
         +geQ7DvL53t5xKisyM+F1OdpY9paTBvfGWqr6ccp0kJyXp1dbfUJyIcLwkRakpCWhKYu
         yB5u5pk7e2GHzvB04mKF+Kvu/m8zjc2m4ytMepj8fIUFXafiTkP1sxV6RTOLvshYQWfc
         EaBA==
X-Gm-Message-State: APjAAAWSHxxwxRD4KsTCs4+fIipw4p1XJSMO8gxS25zbKMjSjzIXtyu4
        9DNot1iJLIA3KXE89VDa9ZoBnVbvhahyleKCtwOZbw==
X-Google-Smtp-Source: APXvYqxwBVwLqxEvOxIflOhsGsMSkYb6lfxJt1tosG6/eY6xpGyjucXTvEj741coTmOODqT107Q/DNxtylHdDzMIdYA=
X-Received: by 2002:a67:7acd:: with SMTP id v196mr5961661vsc.95.1576139344363;
 Thu, 12 Dec 2019 00:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20191212061702.BFE2D6E85603@corona.crabdance.com>
In-Reply-To: <20191212061702.BFE2D6E85603@corona.crabdance.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 12 Dec 2019 13:58:52 +0530
Message-ID: <CAHLCerOHjAEEA1BpUqPdZvFwHMy11SqC+ZtjdFyManu7iOpBXA@mail.gmail.com>
Subject: Re: [RESEND PATCH] thermal: rockchip: enable hwmon
To:     schaecsn@gmx.net
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lakml <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:47 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
>
> By default, of-based thermal drivers do not enable hwmon.
> Explicitly enable hwmon for both, the soc and gpu temperature
> sensor.

Is there any reason you need to expose this in hwmon?

> Signed-off-by: Stefan Schaeckeler <schaecsn@gmx.net>
>
> ---
>  drivers/thermal/rockchip_thermal.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
> index 343c2f5c5a25..e47c60010259 100644
> --- a/drivers/thermal/rockchip_thermal.c
> +++ b/drivers/thermal/rockchip_thermal.c
> @@ -19,6 +19,8 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/pinctrl/consumer.h>
>
> +#include "thermal_hwmon.h"
> +
>  /**
>   * If the temperature over a period of time High,
>   * the resulting TSHUT gave CRU module,let it reset the entire chip,
> @@ -1321,8 +1323,15 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
>
>         thermal->chip->control(thermal->regs, true);
>
> -       for (i = 0; i < thermal->chip->chn_num; i++)
> +       for (i = 0; i < thermal->chip->chn_num; i++) {
>                 rockchip_thermal_toggle_sensor(&thermal->sensors[i], true);
> +               thermal->sensors[i].tzd->tzp->no_hwmon = false;
> +               error = thermal_add_hwmon_sysfs(thermal->sensors[i].tzd);
> +               if (error)
> +                       dev_warn(&pdev->dev,
> +                                "failed to register sensor %d with hwmon: %d\n",
> +                                i, error);
> +       }
>
>         platform_set_drvdata(pdev, thermal);
>
> @@ -1344,6 +1353,7 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
>         for (i = 0; i < thermal->chip->chn_num; i++) {
>                 struct rockchip_thermal_sensor *sensor = &thermal->sensors[i];
>
> +               thermal_remove_hwmon_sysfs(sensor->tzd);
>                 rockchip_thermal_toggle_sensor(sensor, false);
>         }
>
> --
> 2.24.0
>
