Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB6C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FA721773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 16:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9fFwYVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390813AbfEXQnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 12:43:42 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46432 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390314AbfEXQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 12:43:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id y11so795736pfm.13;
        Fri, 24 May 2019 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hs6h6Dgd1YCJieChdKMoYG/F0MKYbjsY/eSGua0Qxeg=;
        b=C9fFwYVN6U5H/GTP4DwlmFxR9piykObPH4+srce8G0o5RRfx3Vm1ask5lZK/DnNoXY
         f6m41rrMmP0p1W9D2fIAUSMy954o8chKiMp4sQh4j9/Ip2JlbW0ruTucLPWUC8gk5172
         ykxfoa/Sr2U/Cgl6+L1i0HUErRjEWNuLsrvVlRaYG0X3kTykuKUKSrrkWJ5nIJgUMBnW
         ZpfChUvXEncy3me+h3PJgztLJvPwA7t2EUkyM/cUbCHFbBiimJ+VpQP/m0l8Oosvd78b
         tiBlg9/0pvZGpi700v8ib8owf3SPZ1qe5xpDgGcRWIxFAQcJR2Ig52OP7wHUPV5rXyu8
         pmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hs6h6Dgd1YCJieChdKMoYG/F0MKYbjsY/eSGua0Qxeg=;
        b=PVDcCqSceIyItNQpETNKeOJ5XiJW16gV4wY5Bc/h0JZjsomSJPxJEfeg5jCpzfgKPY
         MAiOF+xL1/LbAohCMvhcbQNvSlyS6gFowuTwfaZvVD++lq1ZiQ7f0LIXhgAg7ecJekRx
         rK0Tk2Ia49Kp9mHP2E/2TBCmRRTSyBe/gy8UiKz6946mGQw+D4B8LEiPxOknXciRZmXt
         1ZB5tlpN+ilKxDkH9igWPqtcYGhILyGkKyqOZAeUe0BEX5KrLxinNSv1QtL0HFiH06G8
         eCGBX0J7KXytmaSF+AnH0DHjFFx+EBaLtS0lbFSF9M/6mt3MIOiSqdxHaPdILWdrFaO6
         UscQ==
X-Gm-Message-State: APjAAAUDZlLLeAKzRfb6OWpiVASYNZ8KZwb8TZ98BFNLTD/Id1Hv1w6j
        V4hdhb756v6vAD0u2SmF31Sn8oNTs2W/gY8RP7o=
X-Google-Smtp-Source: APXvYqzXSRVvNXdMjkTZ+soAuasix3Sv25okqcaS75wOeO+F4gLU2nJjITJsHMTnEQ1/fzx+rOiK3DTLi+kBuLwlvi0=
X-Received: by 2002:a17:90a:778b:: with SMTP id v11mr10825449pjk.132.1558716220822;
 Fri, 24 May 2019 09:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190521062837.3887-1-hdegoede@redhat.com>
In-Reply-To: <20190521062837.3887-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 May 2019 19:43:30 +0300
Message-ID: <CAHp75Vf6qzq3O1qz481FRuT1MN2EZOV43FpoSCC-vqATzyRF8w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Only Tell EC the OS will handle
 display hotkeys from asus_nb_wmi
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 9:28 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Commit 78f3ac76d9e5 ("platform/x86: asus-wmi: Tell the EC the OS will
> handle the display off hotkey") causes the backlight to be permanently of=
f
> on various EeePC laptop models using the eeepc-wmi driver (Asus EeePC
> 1015BX, Asus EeePC 1025C).
>
> The asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2, NULL) call added
> by that commit is made conditional in this commit and only enabled in
> the quirk_entry structs in the asus-nb-wmi driver fixing the broken
> display / backlight on various EeePC laptop models.
>

Hmm... doesn't apply.

> Cc: Jo=C3=A3o Paulo Rechi Vita <jprvita@endlessm.com>
> Fixes: 78f3ac76d9e5 ("platform/x86: asus-wmi: Tell the EC the OS will han=
dle the display off hotkey")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/asus-nb-wmi.c | 8 ++++++++
>  drivers/platform/x86/asus-wmi.c    | 2 +-
>  drivers/platform/x86/asus-wmi.h    | 1 +
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/as=
us-nb-wmi.c
> index b6f2ff95c3ed..59f3a37a44d7 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -78,10 +78,12 @@ static bool asus_q500a_i8042_filter(unsigned char dat=
a, unsigned char str,
>
>  static struct quirk_entry quirk_asus_unknown =3D {
>         .wapf =3D 0,
> +       .wmi_backlight_set_devstate =3D true,
>  };
>
>  static struct quirk_entry quirk_asus_q500a =3D {
>         .i8042_filter =3D asus_q500a_i8042_filter,
> +       .wmi_backlight_set_devstate =3D true,
>  };
>
>  /*
> @@ -92,26 +94,32 @@ static struct quirk_entry quirk_asus_q500a =3D {
>  static struct quirk_entry quirk_asus_x55u =3D {
>         .wapf =3D 4,
>         .wmi_backlight_power =3D true,
> +       .wmi_backlight_set_devstate =3D true,
>         .no_display_toggle =3D true,
>  };
>
>  static struct quirk_entry quirk_asus_wapf4 =3D {
>         .wapf =3D 4,
> +       .wmi_backlight_set_devstate =3D true,
>  };
>
>  static struct quirk_entry quirk_asus_x200ca =3D {
>         .wapf =3D 2,
> +       .wmi_backlight_set_devstate =3D true,
>  };
>
>  static struct quirk_entry quirk_asus_ux303ub =3D {
>         .wmi_backlight_native =3D true,
> +       .wmi_backlight_set_devstate =3D true,
>  };
>
>  static struct quirk_entry quirk_asus_x550lb =3D {
> +       .wmi_backlight_set_devstate =3D true,
>         .xusb2pr =3D 0x01D9,
>  };
>
>  static struct quirk_entry quirk_asus_forceals =3D {
> +       .wmi_backlight_set_devstate =3D true,
>         .wmi_force_als_set =3D true,
>  };
>
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index ee1fa93708ec..a66e99500c12 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -2131,7 +2131,7 @@ static int asus_wmi_add(struct platform_device *pde=
v)
>                 err =3D asus_wmi_backlight_init(asus);
>                 if (err && err !=3D -ENODEV)
>                         goto fail_backlight;
> -       } else
> +       } else if (asus->driver->quirks->wmi_backlight_set_devstate)
>                 err =3D asus_wmi_set_devstate(ASUS_WMI_DEVID_BACKLIGHT, 2=
, NULL);
>
>         status =3D wmi_install_notify_handler(asus->driver->event_guid,
> diff --git a/drivers/platform/x86/asus-wmi.h b/drivers/platform/x86/asus-=
wmi.h
> index 6c1311f4b04d..57a79bddb286 100644
> --- a/drivers/platform/x86/asus-wmi.h
> +++ b/drivers/platform/x86/asus-wmi.h
> @@ -44,6 +44,7 @@ struct quirk_entry {
>         bool store_backlight_power;
>         bool wmi_backlight_power;
>         bool wmi_backlight_native;
> +       bool wmi_backlight_set_devstate;
>         bool wmi_force_als_set;
>         int wapf;
>         /*
> --
> 2.21.0
>


--=20
With Best Regards,
Andy Shevchenko
