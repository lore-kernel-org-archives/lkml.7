Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D661C04A6B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 02:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE69F2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 02:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CFYwUdlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfEKCbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 22:31:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35253 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbfEKCbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 22:31:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id a39so8074785qtk.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 19:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QkHid6lisLXvpmq0JMNlVb1recKQukJ7PuauuXWUQBw=;
        b=CFYwUdlb6kDt1NhEEjrC0A0nuRHWn/prCx1A1kIqu1GhRZfmdY8bgahc02/X19llbd
         fvxssMqrQQ6Z/4ELAilm0gKIZ0OkiTljAKrePdvGDo8GmzBW4bSQ+Pk9F/xHwraaTGug
         hP27VQvggJlYqYGyMP2FvkeRHxg3gYVJdXK60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QkHid6lisLXvpmq0JMNlVb1recKQukJ7PuauuXWUQBw=;
        b=pPCQVSHo438qUIz4oCI60HCIH8x5Ien8vh1DbWiQ+YRCW+NJ+kzSNNhWmvZTqBewjt
         iGEgBoBKw03ElslNgOGcoHXXvZbMypfxx03+TbwRk4ChSP0+t0e8nHedNiOZI4COmmqX
         J0FKpXicZ0TAgAc0nHoEO14GPVlqyrdVBjtXejPF26y8wuHzk3EWjTCxD+b7D661X+J7
         DZCNe8BxvmYuHUcJ5N9fijzIHIlxCs8XtpQ8HkJbF59VcvNSWxdTQ7NeXotrTnMHOifV
         DwAQ/QNCyFTFrtk4lCbeaImRC5vzp0/Mm7iqGoPsw5fI2XqA0HULLQ84zN9PzuvPcDgw
         aCeQ==
X-Gm-Message-State: APjAAAWatBTK+0yB8rVa//yIRhxJ63ux2SuM7Z0WPj/vw9kXFTvj0c2A
        p1SYsIDTTVQeYtAAlFJSyo0KdLhbPAtRCIUfUE9vrg==
X-Google-Smtp-Source: APXvYqyW5OpnvPwOyXp+1b/92lREfPpRtf9W5zCWsq24yemetlTdNNphRPH6NE7SW8/mCSyxiaqF+3PgsW4V3IWGCTA=
X-Received: by 2002:a0c:ee28:: with SMTP id l8mr11862487qvs.67.1557541879585;
 Fri, 10 May 2019 19:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <1556793795-25204-1-git-send-email-michael.kao@mediatek.com> <1556793795-25204-8-git-send-email-michael.kao@mediatek.com>
In-Reply-To: <1556793795-25204-8-git-send-email-michael.kao@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 11 May 2019 11:31:08 +0900
Message-ID: <CANMq1KBna0V2X3_CNQrcH==WVLs7oY=GvFGzEbWS91-oZCLKTQ@mail.gmail.com>
Subject: Re: [PATCH 7/8] thermal: mediatek: add another get_temp ops for
 thermal sensors
To:     "michael.kao" <michael.kao@mediatek.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        dawei.chien@mediatek.com, louis.yu@mediatek.com,
        roger.lu@mediatek.com, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-pm@vger.kernel.org, Hsin-Yi Wang <hsinyi@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 7:45 PM michael.kao <michael.kao@mediatek.com> wrote:
>
> From: Michael Kao <michael.kao@mediatek.com>
>
> Provide thermal zone to read thermal sensor
> in the SoC. We can read all the thermal sensors
> value in the SoC by the node /sys/class/thermal/
>
> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> ---
>  drivers/thermal/mtk_thermal.c | 68 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 60 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
> index cb41e46..d5c78b0 100644
> --- a/drivers/thermal/mtk_thermal.c
> +++ b/drivers/thermal/mtk_thermal.c
> @@ -230,6 +230,11 @@ enum {
>
>  struct mtk_thermal;
>
> +struct mtk_thermal_zone {
> +       struct mtk_thermal *mt;
> +       int id;
> +};
> +
>  struct thermal_bank_cfg {
>         unsigned int num_sensors;
>         const int *sensors;
> @@ -612,7 +617,7 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>                  * not immediately shut down.
>                  */
>                 if (temp > 200000)
> -                       temp = 0;
> +                       temp = -EACCES;

EACCES/permission denied doesn't really seem to be the right error
code here. Maybe EAGAIN?

>
>                 if (temp > max)
>                         max = temp;
> @@ -623,7 +628,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
>
>  static int mtk_read_temp(void *data, int *temperature)
>  {
> -       struct mtk_thermal *mt = data;
> +       struct mtk_thermal_zone *tz = data;
> +       struct mtk_thermal *mt = tz->mt;
>         int i;
>         int tempmax = INT_MIN;
>
> @@ -636,16 +642,48 @@ static int mtk_read_temp(void *data, int *temperature)
>
>                 mtk_thermal_put_bank(bank);
>         }
> -

I'd drop that change.

>         *temperature = tempmax;
>
>         return 0;
>  }
>
> +static int mtk_read_sensor_temp(void *data, int *temperature)
> +{
> +       struct mtk_thermal_zone *tz = data;
> +       struct mtk_thermal *mt = tz->mt;
> +       const struct mtk_thermal_data *conf = mt->conf;
> +       int id = tz->id - 1;
> +       int temp = INT_MIN;

No need to initialize temp.

> +       u32 raw;
> +
> +       if (id < 0)
> +               return  -EACCES;

EINVAL?

> +
> +       raw = readl(mt->thermal_base + conf->msr[id]);
> +
> +       temp = raw_to_mcelsius(mt, id, raw);
> +
> +       /*
> +        * The first read of a sensor often contains very high bogus
> +        * temperature value. Filter these out so that the system does
> +        * not immediately shut down.
> +        */
> +

nit: Drop this blank line

> +       if (temp > 200000)
> +               return  -EACCES;

Again, EAGAIN, maybe?

> +
> +       *temperature = temp;
> +       return 0;
> +}
> +
>  static const struct thermal_zone_of_device_ops mtk_thermal_ops = {
>         .get_temp = mtk_read_temp,
>  };
>
> +static const struct thermal_zone_of_device_ops mtk_thermal_sensor_ops = {
> +       .get_temp = mtk_read_sensor_temp,
> +};
> +
>  static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>                                   u32 apmixed_phys_base, u32 auxadc_phys_base,
>                                   int ctrl_id)
> @@ -878,6 +916,7 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>         struct resource *res;
>         u64 auxadc_phys_base, apmixed_phys_base;
>         struct thermal_zone_device *tzdev;
> +       struct mtk_thermal_zone *tz;
>
>         mt = devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>         if (!mt)
> @@ -959,11 +998,24 @@ static int mtk_thermal_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, mt);
>
> -       tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, 0, mt,
> -                                                    &mtk_thermal_ops);
> -       if (IS_ERR(tzdev)) {
> -               ret = PTR_ERR(tzdev);
> -               goto err_disable_clk_peri_therm;
> +       for (i = 0; i < mt->conf->num_sensors + 1; i++) {
> +               tz = kmalloc(sizeof(*tz), GFP_KERNEL);

Are we leaking this pointer? Should this be devm_kmalloc?

> +               if (!tz)
> +                       return -ENOMEM;
> +
> +               tz->mt = mt;
> +               tz->id = i;
> +
> +               tzdev = devm_thermal_zone_of_sensor_register(&pdev->dev, i,
> +                               tz, (i == 0) ?
> +                               &mtk_thermal_ops : &mtk_thermal_sensor_ops);
> +
> +               if (IS_ERR(tzdev)) {
> +                       if (IS_ERR(tzdev) != -EACCES) {

Why would EACCES ever happen? AFAICT
devm_thermal_zone_of_sensor_register does not actually try to read the
temperature value? Or does the error come from somewhere else?

> +                               ret = PTR_ERR(tzdev);
> +                               goto err_disable_clk_peri_therm;
> +                       }
> +               }
>         }
>
>         return 0;
> --
> 1.9.1
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
