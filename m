Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB539C0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F89021850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 13:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz/0nekw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfGDN3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 09:29:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43335 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbfGDN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 09:29:13 -0400
Received: by mail-pf1-f196.google.com with SMTP id i189so2951007pfg.10;
        Thu, 04 Jul 2019 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NrC7YQIZ5xkcRSKo/zQi/MpzVFzLaSD9GHzJTC7a//g=;
        b=Iz/0nekwO8pPV/SzqU8khxYHcCdXuYX1M+qJ521b99EYKHqU/Atmqmv0wQM/0Y45wi
         dTod0mc6aImFiEqTP+Jg0VikDrpGhNItxApZZAtDK3uxpmCLAlJVB3tjBMTc311GrLNz
         Xog1gTY3fIz05+aeHS/zhAB2ajUUomt7iqBwFxkYDGVMArc0i0c8cfPnZ4dTLsvg5kes
         JnonHke14k2tewx2i4G/nPcLMQZ9VvGSmfUev2Jd6oaCMiOPpFjREypeig7b/G1lb0pr
         AG1dndriXbhndb0WdXetR2nKFUgVkryEWruySfyvlgx9u3fhJueIp6w9wyXp40yq4MaX
         81xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NrC7YQIZ5xkcRSKo/zQi/MpzVFzLaSD9GHzJTC7a//g=;
        b=mIv4TU0LtJj+Xun7y5ux/MpUzEYFAwJA6ibFqD7oRGJNEO+UUr9h0QPEfDJVGBynRn
         0v6R05VoJK/MxZ5ktGQoJEnXT4ifUE3eZCooxamFovJ62EPyUQPJDG05QZF//KRaI6Dc
         4RZDdZiOllCMpM+9hY0LSYOzer0HPhIN3q6Uy7l4XYu3VrzZWGSRErl5+4r16bkozF6T
         dYngU9t0MjTQTymVvnj6tYjwPlYOt4yhdY/NbQbQJ19+tpFDB0jefwOOTGZAwWeEjUqr
         AYSPG15av85I7ha9XU2ZaGqczgLB5wvb1wzlr+MUkANkHXQPfU6DPPSZkpnHLrOGRYQi
         1fgw==
X-Gm-Message-State: APjAAAUZ9o3APde0MrenrjV7+ZXaOjuxvklcvPSeNVLDXiIz6J0/J75n
        M+errbJVBkS/vA2WubaZBKDmRgmuwUslk2D7Kq8=
X-Google-Smtp-Source: APXvYqwb1D9+iZPTUcDo5vyAriSzsNK4XGd4dk5LVB+YuJBuLA57w0wyufhGvW3VS5yM/T8UOblbblFrLFtm1bDo4fY=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr24859212pgc.74.1562246952477;
 Thu, 04 Jul 2019 06:29:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190704084617.3602-1-gregkh@linuxfoundation.org> <20190704084617.3602-7-gregkh@linuxfoundation.org>
In-Reply-To: <20190704084617.3602-7-gregkh@linuxfoundation.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 4 Jul 2019 16:29:01 +0300
Message-ID: <CAHp75VekHC9S3o6=GvDo7EsCQwR68OYzdDecA0NeJ6yodtgT3g@mail.gmail.com>
Subject: Re: [PATCH 06/11] platform: x86: hp-wmi: convert platform driver to
 use dev_groups
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 11:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Platform drivers now have the option to have the platform core create
> and remove any needed sysfs attribute files.  So take advantage of that
> and do not register "by hand" a bunch of sysfs files.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Darren Hart <dvhart@infradead.org>
> Cc: Andy Shevchenko <andy@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/platform/x86/hp-wmi.c | 47 +++++++++--------------------------
>  1 file changed, 12 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 2521e45280b8..b4ed5902737a 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -502,6 +502,17 @@ static DEVICE_ATTR_RO(dock);
>  static DEVICE_ATTR_RO(tablet);
>  static DEVICE_ATTR_RW(postcode);
>
> +static struct attribute *hp_wmi_attrs[] = {
> +       &dev_attr_display.attr,
> +       &dev_attr_hddtemp.attr,
> +       &dev_attr_als.attr,
> +       &dev_attr_dock.attr,
> +       &dev_attr_tablet.attr,
> +       &dev_attr_postcode.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(hp_wmi);
> +
>  static void hp_wmi_notify(u32 value, void *context)
>  {
>         struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -678,16 +689,6 @@ static void hp_wmi_input_destroy(void)
>         input_unregister_device(hp_wmi_input_dev);
>  }
>
> -static void cleanup_sysfs(struct platform_device *device)
> -{
> -       device_remove_file(&device->dev, &dev_attr_display);
> -       device_remove_file(&device->dev, &dev_attr_hddtemp);
> -       device_remove_file(&device->dev, &dev_attr_als);
> -       device_remove_file(&device->dev, &dev_attr_dock);
> -       device_remove_file(&device->dev, &dev_attr_tablet);
> -       device_remove_file(&device->dev, &dev_attr_postcode);
> -}
> -
>  static int __init hp_wmi_rfkill_setup(struct platform_device *device)
>  {
>         int err, wireless;
> @@ -858,8 +859,6 @@ static int __init hp_wmi_rfkill2_setup(struct platform_device *device)
>
>  static int __init hp_wmi_bios_setup(struct platform_device *device)
>  {
> -       int err;
> -
>         /* clear detected rfkill devices */
>         wifi_rfkill = NULL;
>         bluetooth_rfkill = NULL;
> @@ -869,35 +868,12 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>         if (hp_wmi_rfkill_setup(device))
>                 hp_wmi_rfkill2_setup(device);
>
> -       err = device_create_file(&device->dev, &dev_attr_display);
> -       if (err)
> -               goto add_sysfs_error;
> -       err = device_create_file(&device->dev, &dev_attr_hddtemp);
> -       if (err)
> -               goto add_sysfs_error;
> -       err = device_create_file(&device->dev, &dev_attr_als);
> -       if (err)
> -               goto add_sysfs_error;
> -       err = device_create_file(&device->dev, &dev_attr_dock);
> -       if (err)
> -               goto add_sysfs_error;
> -       err = device_create_file(&device->dev, &dev_attr_tablet);
> -       if (err)
> -               goto add_sysfs_error;
> -       err = device_create_file(&device->dev, &dev_attr_postcode);
> -       if (err)
> -               goto add_sysfs_error;
>         return 0;
> -
> -add_sysfs_error:
> -       cleanup_sysfs(device);
> -       return err;
>  }
>
>  static int __exit hp_wmi_bios_remove(struct platform_device *device)
>  {
>         int i;
> -       cleanup_sysfs(device);
>
>         for (i = 0; i < rfkill2_count; i++) {
>                 rfkill_unregister(rfkill2[i].rfkill);
> @@ -968,6 +944,7 @@ static struct platform_driver hp_wmi_driver = {
>                 .pm = &hp_wmi_pm_ops,
>         },
>         .remove = __exit_p(hp_wmi_bios_remove),
> +       .dev_groups = hp_wmi_groups,
>  };
>
>  static int __init hp_wmi_init(void)
> --
> 2.22.0
>


-- 
With Best Regards,
Andy Shevchenko
