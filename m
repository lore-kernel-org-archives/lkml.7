Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65963C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EC02082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOYQkoIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfEFJ0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:26:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43562 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfEFJ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:26:13 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so6069568plp.10;
        Mon, 06 May 2019 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGOZ5+NdqMpJLrU4CaMy17CdDX8diVXHj58x8U+Awp8=;
        b=AOYQkoIeXCioWtq/D99TmWzPoDa1LZbJRtPpXnIAR7ty/VHcvOvAExl2ELuuCAXuTS
         zqealCDMPdk8CYB2wB1UEVX696dJDeCYt7PBHAyfANlVgulek/fNuvQZRRh34Gcdygqe
         wG7nbJipuBB5XUrYv5LdQVMo9vU4tfahZ+Jvfri4PcN43ShmjhHZS7uyhnNiuZros0Uu
         vjAlg7RZcCqNS1StM7CCTjUgqxea7VdmYAU1Us7IZRwdRg+N18I5J2xKKWEqVko0X+ar
         dElhMBQFUD48XecdqHQtMql2RuqJoN2fcWFOMXapb+i5OS+3Z9AGJWPR+vJxMcXjh08F
         lnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGOZ5+NdqMpJLrU4CaMy17CdDX8diVXHj58x8U+Awp8=;
        b=LVOWYmVsNS6Wa2HgjDXWp5HDXi5fNNZeqvIAl3iTIKR+SxPcJGO77x4KM0gQondWsd
         +jqtX/D/ZZY+r2Th1WiKbFr/TNxWx6GWQeai8Ya7NKSR5xNwlQkikbDfb26yU9ojJbi6
         mKWdhZigNKjaR/UXajOnGson1aPDVwtqisP7lPJcsyDyqY0LIv3CkvYl0GcPwVPLve1e
         sLATiOCGzVm+9fRKBlnpM4TMB3ZKkajpvq7a8L+v9GkUCRmfm9g3jubzlqBoAJsj2JCE
         5O2G12yhakUT9WsxWB6dVGVU1KU3UrDScB+zXoGCNxIl7CuDqsQouBWzBJ2hX9ueetvF
         XzdA==
X-Gm-Message-State: APjAAAWKlVTKAOveefbnLX/bfNm9XtTKkCAsaGxRd8c1JDuNilj41z+u
        F6I1pgyTk1Ac+oKs+xl9DrtI1NA79iZIfcrUYvJpicpciYphrw==
X-Google-Smtp-Source: APXvYqxDXYKUe86e9zPA+B/RVkzp4tTUm4DgXoJnjMrb5YLrfmxmZHr/Iw5xvjt8pZOO5i0gFKe98gM5Y5AroWHR1xI=
X-Received: by 2002:a17:902:8349:: with SMTP id z9mr30509309pln.144.1557134772204;
 Mon, 06 May 2019 02:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190418064648.25706-1-chiu@endlessm.com> <CAB4CAwfsbgP9DrYEHs2c9HRc5MS_k-BfZ9EOhmUu7XsJ9pHh4g@mail.gmail.com>
In-Reply-To: <CAB4CAwfsbgP9DrYEHs2c9HRc5MS_k-BfZ9EOhmUu7XsJ9pHh4g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 12:26:01 +0300
Message-ID: <CAHp75VcxcxiiJ3jFs8ZNxkJtf=W4Gkav88PK_fZu9fKJHqxFpw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Add fn-lock mode switch support
To:     Chris Chiu <chiu@endlessm.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 3:54 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Thu, Apr 18, 2019 at 2:46 PM Chris Chiu <chiu@endlessm.com> wrote:
> >
> > Some of latest ASUS laptops support new fn-lock mode switching.
> > This commit detect whether if the fn-lock option is enabled in
> > BIOS setting, and toggle the fn-lock mode via a new WMI DEVID
> > 0x00100023 when the corresponding notify code captured.
> >
> > The ASUS fn-lock mode switch is activated by pressing Fn+Esc.
> > When on, keys F1 to F12 behave as applicable, with meanings
> > defined by the application being used at the time. When off,
> > F1 to F12 directly triggers hardware features, well known audio
> > volume up/down, brightness up/down...etc, which were triggered
> > by holding down Fn key and F-keys.
> >
> > Because there's no way to retrieve the fn-lock mode via existing
> > WMI methods per ASUS spec, driver need to initialize and keep the
> > fn-lock mode by itself.
> >

Pushed to my review and testing queue, thanks!


> > Signed-off-by: Chris Chiu <chiu@endlessm.com>
> > ---
> >  drivers/platform/x86/asus-wmi.c            | 36 ++++++++++++++++++++++++++++++
> >  include/linux/platform_data/x86/asus-wmi.h |  1 +
> >  2 files changed, 37 insertions(+)
> >
> > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > index 37b5de541270..5f52b66e40cb 100644
> > --- a/drivers/platform/x86/asus-wmi.c
> > +++ b/drivers/platform/x86/asus-wmi.c
> > @@ -69,6 +69,7 @@ MODULE_LICENSE("GPL");
> >  #define NOTIFY_KBD_BRTUP               0xc4
> >  #define NOTIFY_KBD_BRTDWN              0xc5
> >  #define NOTIFY_KBD_BRTTOGGLE           0xc7
> > +#define NOTIFY_FNLOCK_TOGGLE           0x4e
> >
> >  #define ASUS_FAN_DESC                  "cpu_fan"
> >  #define ASUS_FAN_MFUN                  0x13
> > @@ -177,6 +178,8 @@ struct asus_wmi {
> >         struct workqueue_struct *hotplug_workqueue;
> >         struct work_struct hotplug_work;
> >
> > +       bool fnlock_locked;
> > +
> >         struct asus_wmi_debug debug;
> >
> >         struct asus_wmi_driver *driver;
> > @@ -1619,6 +1622,24 @@ static int is_display_toggle(int code)
> >         return 0;
> >  }
> >
> > +static bool asus_wmi_has_fnlock_key(struct asus_wmi *asus)
> > +{
> > +#define ASUS_WMI_FNLOCK_BIOS_DISABLED  BIT(0)
> > +       u32 result;
> > +
> > +       asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_FNLOCK, &result);
> > +
> > +       return (result & ASUS_WMI_DSTS_PRESENCE_BIT) &&
> > +               !(result & ASUS_WMI_FNLOCK_BIOS_DISABLED);
> > +}
> > +
> > +static void asus_wmi_fnlock_update(struct asus_wmi *asus)
> > +{
> > +       int mode = asus->fnlock_locked;
> > +
> > +       asus_wmi_set_devstate(ASUS_WMI_DEVID_FNLOCK, mode, NULL);
> > +}
> > +
> >  static void asus_wmi_notify(u32 value, void *context)
> >  {
> >         struct asus_wmi *asus = context;
> > @@ -1680,6 +1701,12 @@ static void asus_wmi_notify(u32 value, void *context)
> >                 goto exit;
> >         }
> >
> > +       if (code == NOTIFY_FNLOCK_TOGGLE) {
> > +               asus->fnlock_locked = !asus->fnlock_locked;
> > +               asus_wmi_fnlock_update(asus);
> > +               goto exit;
> > +       }
> > +
> >         if (is_display_toggle(code) &&
> >             asus->driver->quirks->no_display_toggle)
> >                 goto exit;
> > @@ -2134,6 +2161,11 @@ static int asus_wmi_add(struct platform_device *pdev)
> >         } else
> >                 err = asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL);
> >
> > +       if (asus_wmi_has_fnlock_key(asus)) {
> > +               asus->fnlock_locked = true;
> > +               asus_wmi_fnlock_update(asus);
> > +       }
> > +
> >         status = wmi_install_notify_handler(asus->driver->event_guid,
> >                                             asus_wmi_notify, asus);
> >         if (ACPI_FAILURE(status)) {
> > @@ -2213,6 +2245,8 @@ static int asus_hotk_resume(struct device *device)
> >         if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
> >                 kbd_led_update(asus);
> >
> > +       if (asus_wmi_has_fnlock_key(asus))
> > +               asus_wmi_fnlock_update(asus);
> >         return 0;
> >  }
> >
> > @@ -2249,6 +2283,8 @@ static int asus_hotk_restore(struct device *device)
> >         if (!IS_ERR_OR_NULL(asus->kbd_led.dev))
> >                 kbd_led_update(asus);
> >
> > +       if (asus_wmi_has_fnlock_key(asus))
> > +               asus_wmi_fnlock_update(asus);
> >         return 0;
> >  }
> >
> > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> > index 53dfc2541960..bfba245636a7 100644
> > --- a/include/linux/platform_data/x86/asus-wmi.h
> > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > @@ -67,6 +67,7 @@
> >  /* Input */
> >  #define ASUS_WMI_DEVID_TOUCHPAD                0x00100011
> >  #define ASUS_WMI_DEVID_TOUCHPAD_LED    0x00100012
> > +#define ASUS_WMI_DEVID_FNLOCK          0x00100023
> >
> >  /* Fan, Thermal */
> >  #define ASUS_WMI_DEVID_THERMAL_CTRL    0x00110011
> > --
> > 2.11.0
> >
>
> Gentle ping. Any comments or suggestions for this are appreciated.
>
> Chris



-- 
With Best Regards,
Andy Shevchenko
