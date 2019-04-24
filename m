Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFA6C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FF0206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="Ukq50uhy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfDXAya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:54:30 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42610 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728985AbfDXAya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:54:30 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so18395989qtc.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 17:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qoC+E7lBKNvcCzRmmnK1vrl3clSuNzbpD63zp21AZkY=;
        b=Ukq50uhyCWgNzm0YENKl2YBgy+gdk75SR7DnlZFMrozvSn/D+DPZ81eVjnz209Q8c0
         ypTjVKy4u0hJRLbTLFHWQyoaOscI9sySfhsBUofbwrODNiQ88xeNWVPkTPLIxLl9P0Yh
         pNgbimLw/fRONyajmGXt5v9q9YkcN0t7TaQr0LVFsIbnU3h1eUVuvG2u1u4NQOx2hY7j
         Bx4fXIa1gicGra5kfdzvtHDgL5ogH5rTJYYU+8d+n+q4g8Q4zcU7flA2eszE+ToITHYe
         n9uVNIuj7QuDYsklOVyDfqJiaKK4irMmfwCPr7gen93V1mvAsVeLvaSKxJj6it50XWWu
         R8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qoC+E7lBKNvcCzRmmnK1vrl3clSuNzbpD63zp21AZkY=;
        b=nt7VX7pMfH1VxjRL/l0V57BQgS7kT1xXzUM1IPNGPjWeTL3Z8j2LAkvg3lc7GcqrXn
         FBvc1pTsDHGVSWy2pVglpHHPAyfV4dLaw+DsdDHM+vjQk5dwMwh7nl3/dny6yMqOJXzI
         n401BOncv3awc8+WiBi1EBGDg4NzqopUi0GhpjdikYQobC+9NaDXigzQhw15SxKGmYAT
         CPfYcA+PbBLkvLA91o1/bAa9DrwgDZR0b/hSqlhQtkl7X0gm91w7bq/QyTuZsYk9CkVf
         KeGd6yycuJvLIlQ4ZSW8nmyU6BakalR2TACh6eaW/6PYwY4QavDil8heTSBmkgQuZhWq
         jgNw==
X-Gm-Message-State: APjAAAVuOgiS7kl7fGAggJSIn5NV0dzQoqtKWQZmptzYQTeHGPMF+prW
        is0glgstHjuCEiq+I1yJrNmKJzNPj7MNzYU/WtTEjw==
X-Google-Smtp-Source: APXvYqycaT6AJTIA5szVZNC3TJdv7b0IOfGcCBdViR/HoJ2nKLdZQJufqjK2ISdIofzwS/Fj/FUPjDO3fMwtHchCA+0=
X-Received: by 2002:ac8:8ad:: with SMTP id v42mr17595458qth.337.1556067268420;
 Tue, 23 Apr 2019 17:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190418064648.25706-1-chiu@endlessm.com>
In-Reply-To: <20190418064648.25706-1-chiu@endlessm.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 24 Apr 2019 08:54:17 +0800
Message-ID: <CAB4CAwfsbgP9DrYEHs2c9HRc5MS_k-BfZ9EOhmUu7XsJ9pHh4g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Add fn-lock mode switch support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>
Cc:     acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 2:46 PM Chris Chiu <chiu@endlessm.com> wrote:
>
> Some of latest ASUS laptops support new fn-lock mode switching.
> This commit detect whether if the fn-lock option is enabled in
> BIOS setting, and toggle the fn-lock mode via a new WMI DEVID
> 0x00100023 when the corresponding notify code captured.
>
> The ASUS fn-lock mode switch is activated by pressing Fn+Esc.
> When on, keys F1 to F12 behave as applicable, with meanings
> defined by the application being used at the time. When off,
> F1 to F12 directly triggers hardware features, well known audio
> volume up/down, brightness up/down...etc, which were triggered
> by holding down Fn key and F-keys.
>
> Because there's no way to retrieve the fn-lock mode via existing
> WMI methods per ASUS spec, driver need to initialize and keep the
> fn-lock mode by itself.
>
> Signed-off-by: Chris Chiu <chiu@endlessm.com>
> ---
>  drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 37 insertions(+)
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 37b5de541270..5f52b66e40cb 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -69,6 +69,7 @@ MODULE_LICENSE("GPL");
>  #define NOTIFY_KBD_BRTUP               0xc4
>  #define NOTIFY_KBD_BRTDWN              0xc5
>  #define NOTIFY_KBD_BRTTOGGLE           0xc7
> +#define NOTIFY_FNLOCK_TOGGLE           0x4e
>
>  #define ASUS_FAN_DESC                  "cpu_fan"
>  #define ASUS_FAN_MFUN                  0x13
> @@ -177,6 +178,8 @@ struct asus_wmi {
>         struct workqueue_struct *hotplug_workqueue;
>         struct work_struct hotplug_work;
>
> +       bool fnlock_locked;
> +
>         struct asus_wmi_debug debug;
>
>         struct asus_wmi_driver *driver;
> @@ -1619,6 +1622,24 @@ static int is_display_toggle(int code)
>         return 0;
>  }
>
> +static bool asus_wmi_has_fnlock_key(struct asus_wmi *asus)
> +{
> +#define ASUS_WMI_FNLOCK_BIOS_DISABLED  BIT(0)
> +       u32 result;
> +
> +       asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FNLOCK, &result);
> +
> +       return (result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
> +               !(result & ASUS_WMI_FNLOCK_BIOS_DISABLED);
> +}
> +
> +static void asus_wmi_fnlock_update(struct asus_wmi *asus)
> +{
> +       int mode = asus->fnlock_locked;
> +
> +       asus_wmi_set_devstate(ASUS_WMI_DEVID_FNLOCK, mode, NULL);
> +}
> +
>  static void asus_wmi_notify(u32 value, void *context)
>  {
>         struct asus_wmi *asus = context;
> @@ -1680,6 +1701,12 @@ static void asus_wmi_notify(u32 value, void *context)
>                 goto exit;
>         }
>
> +       if (code == NOTIFY_FNLOCK_TOGGLE) {
> +               asus->fnlock_locked = !asus->fnlock_locked;
> +               asus_wmi_fnlock_update(asus);
> +               goto exit;
> +       }
> +
>         if (is_display_toggle(code) &&
>             asus->driver->quirks->no_display_toggle)
>                 goto exit;
> @@ -2134,6 +2161,11 @@ static int asus_wmi_add(struct platform_device *pdev)
>         } else
>                 err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
>
> +       if (asus_wmi_has_fnlock_key(asus)) {
> +               asus->fnlock_locked = true;
> +               asus_wmi_fnlock_update(asus);
> +       }
> +
>         status = wmi_install_notify_handler(asus->driver->event_guid,
>                                             asus_wmi_notify, asus);
>         if (ACPI_FAILURE(status)) {
> @@ -2213,6 +2245,8 @@ static int asus_hotk_resume(struct device *device)
>         if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
>                 kbd_led_update(asus);
>
> +       if (asus_wmi_has_fnlock_key(asus))
> +               asus_wmi_fnlock_update(asus);
>         return 0;
>  }
>
> @@ -2249,6 +2283,8 @@ static int asus_hotk_restore(struct device *device)
>         if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
>                 kbd_led_update(asus);
>
> +       if (asus_wmi_has_fnlock_key(asus))
> +               asus_wmi_fnlock_update(asus);
>         return 0;
>  }
>
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 53dfc2541960..bfba245636a7 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -67,6 +67,7 @@
>  /* Input */
>  #define ASUS_WMI_DEVID_TOUCHPAD                0x00100011
>  #define ASUS_WMI_DEVID_TOUCHPAD_LED    0x00100012
> +#define ASUS_WMI_DEVID_FNLOCK          0x00100023
>
>  /* Fan, Thermal */
>  #define ASUS_WMI_DEVID_THERMAL_CTRL    0x00110011
> --
> 2.11.0
>

Gentle ping. Any comments or suggestions for this are appreciated.

Chris
