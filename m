Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0D1C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042162064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552337437;
	bh=WmnWnvhH8xU87ulSyPbAeUXZlyUM3QlsDz8cNEfmt0s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=X2IUwhrpWUb8/IqftR4xAts7+drB3wkrE+FE1yFbCilAZ8Mw8taY9zHPeFufqktdM
	 /n9eV0b0PjyaAfsvoRBLdumcxeVn7JUOBmjWXjw0nNya+TdqGpNbn/uJGiQBPqBxf4
	 GVzr6n3RXV1UvMght+21QcaUnB4EO96EsY/+E+uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfCKUug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728067AbfCKUuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:50:35 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13EF221741;
        Mon, 11 Mar 2019 20:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552337434;
        bh=WmnWnvhH8xU87ulSyPbAeUXZlyUM3QlsDz8cNEfmt0s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f2b7cfq4PQ89SN1Xoi9Ha237YKmHKyacm71MLg50GMSyBhl9qOSATAWSh5ZyuS7GG
         jY/vEUQWyoFxwjRhDcL48lcZkHhFEZvPUklyhycHtsEq6HF8chQhaBGtmXBdnPj5tr
         +tUsZzm/aqFKsuTLjt723hDkW+gpYzA0cIkeOKEw=
Received: by mail-wm1-f46.google.com with SMTP id a188so481860wmf.3;
        Mon, 11 Mar 2019 13:50:34 -0700 (PDT)
X-Gm-Message-State: APjAAAUpL9/LdspRdlpWjhnKCn/Oxc3p55vS6ACI73f3/k6735FG6zJp
        Gn6u6J8m1b79AASm9F/T97STRJ+hWQfkqH5P0nc=
X-Google-Smtp-Source: APXvYqzDai9Dyx9OsaBigd7uYRVJCW6GOdcbvE+paemXRGcNrJ+R1kr5bCHNJ9SRIWPwk12NyZA9cJsY5qaDadIwr6U=
X-Received: by 2002:a1c:234d:: with SMTP id j74mr75208wmj.130.1552337432486;
 Mon, 11 Mar 2019 13:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <1552275991-34648-1-git-send-email-hsin-hsiung.wang@mediatek.com> <1552275991-34648-9-git-send-email-hsin-hsiung.wang@mediatek.com>
In-Reply-To: <1552275991-34648-9-git-send-email-hsin-hsiung.wang@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 11 Mar 2019 13:50:21 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzq4D56PbivbHkQd41-TCoGACTiBqLz+Jyiqiog=YMvEbQ@mail.gmail.com>
Message-ID: <CAGp9Lzq4D56PbivbHkQd41-TCoGACTiBqLz+Jyiqiog=YMvEbQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] rtc: mt6397: fix alarm register overwrite
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ran Bi <ran.bi@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Mar 10, 2019 at 8:49 PM Hsin-Hsiung Wang
<hsin-hsiung.wang@mediatek.com> wrote:
>
> From: Ran Bi <ran.bi@mediatek.com>
>
> Alarm registers high byte was reserved for other functions.
> This add mask in alarm registers operation functions.
> This also fix error condition in interrupt handler.
>
> Fixes: fc2979118f3f ("rtc: mediatek: Add MT6397 RTC driver")
>

add a  Cc: stable@vger.kernel.org  here to apply to all stable kernels
for the critical fixup patch.

> Signed-off-by: Ran Bi <ran.bi@mediatek.com>
> ---
>  drivers/rtc/rtc-mt6397.c | 47 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> index e9a25ec..f85f1fc 100644
> --- a/drivers/rtc/rtc-mt6397.c
> +++ b/drivers/rtc/rtc-mt6397.c
> @@ -55,6 +55,14 @@
>
>  #define RTC_AL_SEC             0x0018
>
> +#define RTC_AL_SEC_MASK                0x003f
> +#define RTC_AL_MIN_MASK                0x003f
> +#define RTC_AL_HOU_MASK                0x001f
> +#define RTC_AL_DOM_MASK                0x001f
> +#define RTC_AL_DOW_MASK                0x0007
> +#define RTC_AL_MTH_MASK                0x000f
> +#define RTC_AL_YEA_MASK                0x007f
> +
>  #define RTC_PDN2               0x002e
>  #define RTC_PDN2_PWRON_ALARM   BIT(4)
>
> @@ -111,7 +119,7 @@ static irqreturn_t mtk_rtc_irq_handler_thread(int irq, void *data)
>                 irqen = irqsta & ~RTC_IRQ_EN_AL;
>                 mutex_lock(&rtc->lock);
>                 if (regmap_write(rtc->regmap, rtc->addr_base + RTC_IRQ_EN,
> -                                irqen) < 0)
> +                                irqen) == 0)
>                         mtk_rtc_write_trigger(rtc);
>                 mutex_unlock(&rtc->lock);
>
> @@ -233,12 +241,12 @@ static int mtk_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alm)
>         alm->pending = !!(pdn2 & RTC_PDN2_PWRON_ALARM);
>         mutex_unlock(&rtc->lock);
>
> -       tm->tm_sec = data[RTC_OFFSET_SEC];
> -       tm->tm_min = data[RTC_OFFSET_MIN];
> -       tm->tm_hour = data[RTC_OFFSET_HOUR];
> -       tm->tm_mday = data[RTC_OFFSET_DOM];
> -       tm->tm_mon = data[RTC_OFFSET_MTH];
> -       tm->tm_year = data[RTC_OFFSET_YEAR];
> +       tm->tm_sec = data[RTC_OFFSET_SEC] & RTC_AL_SEC_MASK;
> +       tm->tm_min = data[RTC_OFFSET_MIN] & RTC_AL_MIN_MASK;
> +       tm->tm_hour = data[RTC_OFFSET_HOUR] & RTC_AL_HOU_MASK;
> +       tm->tm_mday = data[RTC_OFFSET_DOM] & RTC_AL_DOM_MASK;
> +       tm->tm_mon = data[RTC_OFFSET_MTH] & RTC_AL_MTH_MASK;
> +       tm->tm_year = data[RTC_OFFSET_YEAR] & RTC_AL_YEA_MASK;
>
>         tm->tm_year += RTC_MIN_YEAR_OFFSET;
>         tm->tm_mon--;
> @@ -259,14 +267,25 @@ static int mtk_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
>         tm->tm_year -= RTC_MIN_YEAR_OFFSET;
>         tm->tm_mon++;
>
> -       data[RTC_OFFSET_SEC] = tm->tm_sec;
> -       data[RTC_OFFSET_MIN] = tm->tm_min;
> -       data[RTC_OFFSET_HOUR] = tm->tm_hour;
> -       data[RTC_OFFSET_DOM] = tm->tm_mday;
> -       data[RTC_OFFSET_MTH] = tm->tm_mon;
> -       data[RTC_OFFSET_YEAR] = tm->tm_year;
> -
>         mutex_lock(&rtc->lock);
> +       ret = regmap_bulk_read(rtc->regmap, rtc->addr_base + RTC_AL_SEC,
> +                              data, RTC_OFFSET_COUNT);
> +       if (ret < 0)
> +               goto exit;
> +

Why did we need an additional regmap_bulk_read here? I would suppose
data[RTC_OFFSET_*] & ~(RTC_AL_*_MASK) is always equal to 0.

It might be another fixup since change is not being mentioned in the
git message.

> +       data[RTC_OFFSET_SEC] = ((data[RTC_OFFSET_SEC] & ~(RTC_AL_SEC_MASK)) |
> +                               (tm->tm_sec & RTC_AL_SEC_MASK));
> +       data[RTC_OFFSET_MIN] = ((data[RTC_OFFSET_MIN] & ~(RTC_AL_MIN_MASK)) |
> +                               (tm->tm_min & RTC_AL_MIN_MASK));
> +       data[RTC_OFFSET_HOUR] = ((data[RTC_OFFSET_HOUR] & ~(RTC_AL_HOU_MASK)) |
> +                               (tm->tm_hour & RTC_AL_HOU_MASK));
> +       data[RTC_OFFSET_DOM] = ((data[RTC_OFFSET_DOM] & ~(RTC_AL_DOM_MASK)) |
> +                               (tm->tm_mday & RTC_AL_DOM_MASK));
> +       data[RTC_OFFSET_MTH] = ((data[RTC_OFFSET_MTH] & ~(RTC_AL_MTH_MASK)) |
> +                               (tm->tm_mon & RTC_AL_MTH_MASK));
> +       data[RTC_OFFSET_YEAR] = ((data[RTC_OFFSET_YEAR] & ~(RTC_AL_YEA_MASK)) |
> +                               (tm->tm_year & RTC_AL_YEA_MASK));
> +
>         if (alm->enabled) {
>                 ret = regmap_bulk_write(rtc->regmap,
>                                         rtc->addr_base + RTC_AL_SEC,
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
