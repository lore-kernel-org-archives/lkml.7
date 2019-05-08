Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87861C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D10920644
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOzKLA6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfEHN7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:59:00 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39790 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEHN67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:58:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so2560635plm.6;
        Wed, 08 May 2019 06:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0bvqrgA4F5XZynGJCRPkIBd3H5fWH/HZp7AEC0pXxY=;
        b=EOzKLA6es+XvThG8+Vm28DWXbTUzThnv+UrqNhdSzdD2TSu8lXOpwg0/bVIYVKq6IA
         LV5K8KAZa2rkyVRPMhlB9wJSJIOGYNRiv5XAWOqX5srdQPtxypdRvw96QOvtCOdRFleL
         SxEZT0Op695AaG/ICPDnZWAUAKIRGhmHux6FLAHCrh37HCni0nJax4zARrUAwYqY+o1R
         P/47CpgNOjI4dcJ6NLpSOtdV18hBebtPnFW5F1gAmGUQB1KW2LrBHvQu0aDVedtVK01u
         5jKo78kjB1yrusMPxTFmwslJW8zLSJ2505oYlL92Tp1odyGVi9ueO09YkF2w0Be4muTq
         MMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0bvqrgA4F5XZynGJCRPkIBd3H5fWH/HZp7AEC0pXxY=;
        b=LHpErsp4lPE+gAnggX/9QfDhSWjwVVXBs4rFNqTyHSpSOval+dtDle5zwAK1I8+Ict
         p0o0K3PWhbzE9QScKMf9n1WzxZhmQFT2SDcLHvXGZEgdRfU1xoX5WQUCREIY4J9s/bjf
         Nvp91DfkTkZUBvQL8KOAMqMWQ/by4FWsqdkGQvctzJMtX5prxnfO82KODcQFEDYt3mzB
         nqIZLxh31kcQVGZMbLnt50ud3Qrwq/TYEuMPeZq5V6vgzXl/05vv/4oEzk1YiO0rlo3N
         rhcq3miyMeGBcZs+eB59lsHcf5UoV124y1FeVv3lU7xGjdrKh7dzeyN4oYthehCzie0P
         qwnw==
X-Gm-Message-State: APjAAAURGd/hDL23YupS6yf4wap7o1mHoUql7f/38Adv6cam+muKWpGI
        iA31S3ef76lVimBhz4yOmiOkvj8/6sf3JuepwPKFhPPBMB0=
X-Google-Smtp-Source: APXvYqyECzHKscwcLIRhkbZNjtvs4hzx0DcRpQiv8wPh6NS9GieTlXYqZCC2p+AYERx00NjBr//0CUH12jJT04eX2kY=
X-Received: by 2002:a17:902:7b8f:: with SMTP id w15mr47075315pll.314.1557323938460;
 Wed, 08 May 2019 06:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com> <7595c4f0-3dbb-2fe5-4daf-4b9a266f67d7@gmail.com>
In-Reply-To: <7595c4f0-3dbb-2fe5-4daf-4b9a266f67d7@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 May 2019 16:58:47 +0300
Message-ID: <CAHp75VdE7MBjyLj=9bS6oc5jc8+BC_hftWUJgZGG02iDd=saiQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] platform/x86: asus-wmi: Enhance detection of
 thermal data
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2019 at 1:12 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
>
> The obviously wrong value 1 for temperature device ID in this driver is
> returned by at least some devices, including TUF Gaming series laptops,
> instead of 0 as expected previously. Observable effect is that a
> temp1_input in hwmon reads temperature near absolute zero.
>
> * Consider 0.1 K an erroneous value in addition to 0 K.
> * Refactor detection of thermal input availability to a separate function.


> +static int asus_hwmon_check_thermal_available(struct asus_wmi *asus)
> +{
> +       u32 value = ASUS_WMI_UNSUPPORTED_METHOD;
> +       int err;
> +
> +       asus->asus_hwmon_thermal_available = false;

> +       err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_THERMAL_CTRL, &value);

> +

The blank line probably should go before a call, but definitely not here.

> +       if (err < 0) {

This needs comment why -ENODEV considered as non-fatal.
> +               if (err == -ENODEV)
> +                       return 0;

> +
> +               return err;
> +       }

> +
> +       /*
> +        * If the temperature value in deci-Kelvin is near the absolute
> +        * zero temperature, something is clearly wrong.
> +        */
> +       if (!value || value == 1)
> +               return 0;
> +
> +       asus->asus_hwmon_thermal_available = true;
> +       return 0;
> +}

>         if (attr == &dev_attr_pwm1.attr)
>                 dev_id = ASUS_WMI_DEVID_FAN_CTRL;

> -       else if (attr == &dev_attr_temp1_input.attr)
> -               dev_id = ASUS_WMI_DEVID_THERMAL_CTRL;

I don't see how this change affects the user output or driver
behaviour. Why is it done?

> -               if (value == ASUS_WMI_UNSUPPORTED_METHOD || value & 0xFFF80000
> +               if (value == ASUS_WMI_UNSUPPORTED_METHOD || (value & 0xFFF80000)

Seems like a bug fix and thus should be a separate commit predecessing
the series.

> -       } else if (dev_id == ASUS_WMI_DEVID_THERMAL_CTRL) {

> +       } else if (attr == &dev_attr_temp1_input.attr) {

So, I don't see why you change this line.

> +               pr_warn("Could not check if thermal available: %d\n", status);

> +       pr_info("Thermal available: %d\n", asus->asus_hwmon_thermal_available);

dev_*() ?

-- 
With Best Regards,
Andy Shevchenko
