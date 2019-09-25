Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2607FC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC7021D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 15:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeyepVHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfIYPGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 11:06:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35215 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfIYPGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 11:06:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id y10so2579403plp.2;
        Wed, 25 Sep 2019 08:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWeo8krif/UekVRwpmtaUYK8YwdrIn7K/7zLQHxnGnQ=;
        b=NeyepVHakp0nKAQMbjMg+3wg1iy/dVqPumwZOSxV+9CsVfBWoUlWQUkC9Y/H4QexEL
         IKIl2NY2eLLZeLj5e2Y0Psw14Ln+CfZQ+Vv/FKIy9pUPA9Xm/WucsQEnbBB7DbHUKRyo
         wsZpNckW+kqNE0BRM0ix6zpTjDDfX6K6F64gFE3JnE1ggGf8oDZ9jcF08UuOGKRZvrBU
         91STIm+eCoufAv9UOOr8lYcaNWtuhBZiYPh84WLrKJXnWMFTsvigtEhCdt93Gyi3QbhI
         ERoY2BnTQSDIbho9Gl+Kt/cVkc97igvOW7xS8Lxc+Oo+BQiiRBbHGt6bgmQbkBUqMxbS
         Yr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWeo8krif/UekVRwpmtaUYK8YwdrIn7K/7zLQHxnGnQ=;
        b=Uugsg+KOl8t5Jz7aVmGuEZbDL97XUETmhGZlGOid22HxMELdWLEC2bi1r5zX/g1HnG
         mbO5pQ4iCHuCkidSbqybqgAtC1SMnk1GElj4EKD68np0hqaVXsvYDKdANlpLv74SOC8k
         s43pPZYR9IHfT80JjNmhRRWCesUAURhtnDylRowzaQDhmXmd89tPddxvsIrV8f46kR3V
         j18Dgmf73Hj+DvnhuBrNWKDdP7RkSspkVI1LxzFp6NBwEgg0VsvlYCvw3ldZo4KY6I57
         Cs+08ugcvEFMXXB5kUU/AVXwiVJdsFLoOIoFZTNMFaVuAepGzurCoFsTJvvuIJtOVtj8
         3Kfw==
X-Gm-Message-State: APjAAAVs5X+QVDMnBGOqhaJ0UZFbvstRgXakM/ZU7250+QHuA6+fomrC
        745VsW5JiCxqvn2PC0n656KdJCfZuzcM3HfeKkU=
X-Google-Smtp-Source: APXvYqyB5TzhgZEQmfi0grGRDVH37M2U2LvgaTaQoAmYVNZlJATKBHIcpVQZ42v3UpH3WJQsnSoXvj1rB44VyOi3tOU=
X-Received: by 2002:a17:902:ac86:: with SMTP id h6mr9986660plr.18.1569424011821;
 Wed, 25 Sep 2019 08:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190925082149.yjhmmb64i4h6sddi@pali> <156940489220.8635.14349142383780268583@WARFSTATION>
In-Reply-To: <156940489220.8635.14349142383780268583@WARFSTATION>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Sep 2019 18:06:40 +0300
Message-ID: <CAHp75VfkL3QGXYjeEEqr75SWCKo1SDEqS9q3YEQWYM4iXbUzcg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: dell-laptop: fix broken kbd backlight on
 Inspiron 10xx
To:     Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 12:48 PM Pacien TRAN-GIRARD
<pacien.trangirard@pacien.net> wrote:
>
> This patch adds a quirk disabling keyboard backlight support for the
> Dell Inspiron 1012 and 1018.
>
> Those models wrongly report supporting keyboard backlight control
> features (through SMBIOS tokens) even though they're not equipped with
> a backlit keyboard. This led to broken controls being exposed
> through sysfs by this driver which froze the system when used.
>

Pali, are you okay with this one?

> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=107651
> Signed-off-by: Pacien TRAN-GIRARD <pacien.trangirard@pacien.net>
> ---
>  drivers/platform/x86/dell-laptop.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
> index d27be2836bc2..ffe5abbdadda 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -33,6 +33,7 @@
>
>  struct quirk_entry {
>         bool touchpad_led;
> +       bool kbd_broken_backlight;
>         bool kbd_led_levels_off_1;
>         bool kbd_missing_ac_tag;
>
> @@ -73,6 +74,10 @@ static struct quirk_entry quirk_dell_latitude_e6410 = {
>         .kbd_led_levels_off_1 = true,
>  };
>
> +static struct quirk_entry quirk_dell_inspiron_1012 = {
> +       .kbd_broken_backlight = true,
> +};
> +
>  static struct platform_driver platform_driver = {
>         .driver = {
>                 .name = "dell-laptop",
> @@ -310,6 +315,24 @@ static const struct dmi_system_id dell_quirks[] __initconst = {
>                 },
>                 .driver_data = &quirk_dell_latitude_e6410,
>         },
> +       {
> +               .callback = dmi_matched,
> +               .ident = "Dell Inspiron 1012",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1012"),
> +               },
> +               .driver_data = &quirk_dell_inspiron_1012,
> +       },
> +       {
> +               .callback = dmi_matched,
> +               .ident = "Dell Inspiron 1018",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron 1018"),
> +               },
> +               .driver_data = &quirk_dell_inspiron_1012,
> +       },
>         { }
>  };
>
> @@ -2040,6 +2063,9 @@ static int __init kbd_led_init(struct device *dev)
>  {
>         int ret;
>
> +       if (quirks && quirks->kbd_broken_backlight)
> +               return -ENODEV;
> +
>         kbd_init();
>         if (!kbd_led_present)
>                 return -ENODEV;
> --
> 2.19.2



-- 
With Best Regards,
Andy Shevchenko
