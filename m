Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0DBC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 401DE20640
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 08:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmmREtJc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394977AbfITIZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 04:25:59 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34687 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390765AbfITIZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 04:25:58 -0400
Received: by mail-pf1-f195.google.com with SMTP id b128so4044785pfa.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 01:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JAXmdTpb/xSiP8DRhBYoimT1TCs8GW8rlo3bs8Zrbps=;
        b=EmmREtJc8YLf1Ho6uWOjNk6cewsuN9DrUj+y7yP5CgQjjkbSx0V1N36fJo6sDeLkQ3
         AahUPRCMg7y66gQJNmOzPtj1MvbSlUuZ9kckKYGowh/aJlFf/ZQ9XP2SbzEysQCFXFDI
         Idoewuh9cO8NwbTKJvhdHR0oAw6UPnN5H+Fb1w40gVZgn4mfI1Bw7UUYiT2Sx7mBKQwE
         83vrjVZGmvDBQ2NqNHyEGtTED7343/nX2rKXCm3QJ9LAnxglco8QLl4s/9eNfFJryUsT
         j2E3w/Wio+yvE6zknLwRIzxWTKdozqOyVNeMR1tcSvX6jFHAAF2L/U5ZiNRPaq3W0mE+
         htjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JAXmdTpb/xSiP8DRhBYoimT1TCs8GW8rlo3bs8Zrbps=;
        b=UMdTGb8blvyNY/b09IUiOgWRItSh/PLO/HWeVOAXRp9lEiUA3Kp7DPpOK8NqsP8trW
         R+zWVaX9sngDV8SDvvd6xLmcf7hvZXdskOJl6FrJXP6vIB7G3csj2cHGFkK6keo54NQY
         1QzS+8aokdyeqel4YayN4ruFbSq6T8nh3ovxNNj8dVCoceOrPgaTpdwPG35Ld0B3C7nQ
         IKZPyXaRysksXMgbOVztpEyIlAoaWUYiylGdIAcD75G7mjQbM+UrQ37xS/AfO11akVId
         5ezfPLK4CL8tV25zXh1lgLOh10u1stVSlPraOM6Jm8UFd9uNlBTHWFrePLebtxyhTWRJ
         G8Vw==
X-Gm-Message-State: APjAAAVDKKpQeVOcVyMo6dXoQ/6FSsqnd1s1CJ+F2g0NZLa0TjoL0KaP
        cHcw3wqke2ZxRJ6JxCqMUJpfnuuf/uKeOXM/dYQ=
X-Google-Smtp-Source: APXvYqyd2r9EKLFMa7/imhbgn9R/b7KrAYqcM1zOA9AG5pDAQf/kRGvgjl5Qc5bu0zFpVz4onc+4GmOP6DiN+BsLoCA=
X-Received: by 2002:a62:c141:: with SMTP id i62mr16106765pfg.64.1568967956707;
 Fri, 20 Sep 2019 01:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190916211536.29646-1-jekhor@gmail.com> <20190916211536.29646-2-jekhor@gmail.com>
In-Reply-To: <20190916211536.29646-2-jekhor@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 20 Sep 2019 11:25:45 +0300
Message-ID: <CAHp75VeCFYZ11c0jW3aXZTXHROfU5k0YRcJC4Vz3S2_tvDwt4w@mail.gmail.com>
Subject: Re: [PATCH v2] extcon-intel-cht-wc: Don't reset USB data connection
 at probe
To:     Yauhen Kharuzhy <jekhor@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2019 at 10:29 AM Yauhen Kharuzhy <jekhor@gmail.com> wrote:
>
> Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
> PMIC at driver probing for further charger detection. This causes reset of
> USB data sessions and removing all devices from bus. If system was
> booted from Live CD or USB dongle, this makes system unusable.
>
> Check if USB ID pin is floating and re-route data lines in this case
> only, don't touch otherwise.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> ---
>  drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 9d32150e68db..da1886a92f75 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -338,6 +338,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>         struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
>         struct cht_wc_extcon_data *ext;
>         unsigned long mask = ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MASK);
> +       int pwrsrc_sts, id;
>         int irq, ret;
>
>         irq = platform_get_irq(pdev, 0);
> @@ -387,8 +388,19 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
>                 goto disable_sw_control;
>         }
>
> -       /* Route D+ and D- to PMIC for initial charger detection */
> -       cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
> +       ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
> +       if (ret) {
> +               dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
> +               goto disable_sw_control;
> +       }
> +
> +       id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
> +
> +       /* If no USB host or device connected, route D+ and D- to PMIC for
> +        * initial charger detection
> +        */
> +       if (id != INTEL_USB_ID_GND)
> +               cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
>
>         /* Get initial state */
>         cht_wc_extcon_pwrsrc_event(ext);
> --
> 2.23.0.rc1
>


-- 
With Best Regards,
Andy Shevchenko
