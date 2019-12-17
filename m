Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DB6C2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4719C207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 08:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576569792;
	bh=25HsI9t+Bqog4y9A5SHa9MC0k7uJ8M9CNTOiEeQd6Js=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IFLZ9EulJXHQ4Bew+94GQCIVmr7ulFyGXDc8c2ThpgFQDtFUj8eEIcMMI54Vv9qSy
	 74rNnW3O7pBZoIDU5HqdMKti08Yp9OvUmCOhMy6vuzIYsnJheki8yjVNFGs/fUFqES
	 30mv2JnE9XkgWwMdEQMjO25igE18TW0IRtA1ffF4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfLQIDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 03:03:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfLQIDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 03:03:08 -0500
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 672EA21D7D;
        Tue, 17 Dec 2019 08:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576569787;
        bh=25HsI9t+Bqog4y9A5SHa9MC0k7uJ8M9CNTOiEeQd6Js=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DvMpZbB7IMXqeX4QWcO8IidCczC9xn9mkLwwqoYLgM5vsug6dsyrsPkNlUjElcdjj
         o7hy5AimWrV23+EW+uPpkq77mQ7qWPhxDGeFqm4k5dgwaFkhibUekR6YfYCfhrZZsp
         wyJwXhekHJQfP01vpqFUQkUgm9WV1sjfrFo2bYIw=
Received: by mail-wr1-f49.google.com with SMTP id w15so10224332wru.4;
        Tue, 17 Dec 2019 00:03:07 -0800 (PST)
X-Gm-Message-State: APjAAAVVrMW1Qcj9xvbCUQF6/3K0eGjAVTxKjKexu0rU+MxL14AMcRAE
        X7cDs/r0MjYy4zzfPJb/Tk/cE4tEAxnNYpbq4SE=
X-Google-Smtp-Source: APXvYqzf3OsaJa9aVxYfyxYMjeroNjRrzOjIIzFzUrGof8GRCCHuk/JVJP69n/Ph+I/wKcqIgvXDGi2L7XlZJ9tfLAY=
X-Received: by 2002:a05:6000:11c6:: with SMTP id i6mr36083863wrx.178.1576569785910;
 Tue, 17 Dec 2019 00:03:05 -0800 (PST)
MIME-Version: 1.0
References: <20191217052328.25633-1-wens@kernel.org> <7f2be28d-9bf5-79a8-8720-4615a4e9f463@linaro.org>
In-Reply-To: <7f2be28d-9bf5-79a8-8720-4615a4e9f463@linaro.org>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 17 Dec 2019 16:02:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v65TA0patyNO_xw0gpWR62N4Q_40amFW9OUh7jat3f9J8g@mail.gmail.com>
Message-ID: <CAGb2v65TA0patyNO_xw0gpWR62N4Q_40amFW9OUh7jat3f9J8g@mail.gmail.com>
Subject: Re: [PATCH] thermal: rockchip: enable hwmon
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Chen-Yu Tsai <wens@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 4:01 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Chen-Yu,
>
> On 17/12/2019 06:23, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > By default of-based thermal driver do not have hwmon entries registered=
.
> >
> > Do this explicitly so users can use standard hwmon interfaces and tools
> > to read the temperature.
> >
> > This is based on similar changes for bcm2835_thermal in commit
> > d56c19d07e0b ("thermal: bcm2835: enable hwmon explicitly").
>
> Thanks for submitting this patch, but it is duplicate with:
>
> https://lore.kernel.org/linux-arm-kernel/20191212061702.BFE2D6E85603@coro=
na.crabdance.com/
>
> which I picked up.

No problem. Thanks for the pointer.

ChenYu

>   -- Daniel
>
>
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > ---
> >  drivers/thermal/rockchip_thermal.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockc=
hip_thermal.c
> > index 9ed8085bb792..d53ba7dabf16 100644
> > --- a/drivers/thermal/rockchip_thermal.c
> > +++ b/drivers/thermal/rockchip_thermal.c
> > @@ -19,6 +19,8 @@
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/pinctrl/consumer.h>
> >
> > +#include "thermal_hwmon.h"
> > +
> >  /*
> >   * If the temperature over a period of time High,
> >   * the resulting TSHUT gave CRU module,let it reset the entire chip,
> > @@ -1210,7 +1212,11 @@ rockchip_thermal_register_sensor(struct platform=
_device *pdev,
> >               return error;
> >       }
> >
> > -     return 0;
> > +     /* thermal_zone doesn't enable hwmon as default, enable it here *=
/
> > +     sensor->tzd->tzp->no_hwmon =3D false;
> > +     error =3D thermal_add_hwmon_sysfs(sensor->tzd);
> > +
> > +     return error;
> >  }
> >
> >  /**
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
