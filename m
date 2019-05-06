Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D304BC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A424D206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 12:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdyNLvM+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfEFMaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 08:30:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43485 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFMaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 08:30:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id t22so6385611pgi.10;
        Mon, 06 May 2019 05:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HjlWS6EdAZUgAZeMh0MJ7zt3HS64xHIgEt+/XwDaOiw=;
        b=EdyNLvM+8fFLP1+wT/6GDSs4CAJcLkNNqonuBtknJqxPV+v7kUqfvry/q6z2HkpWyn
         9bdpQaqKQZe4Ha1o7obRLU2zZGy61ovuLKp/BHRrZrW3Ht+Z3tGRd7Nclw43fWmdSsKw
         fL2D7b0ivvtPjobgWywOslWVZSIgpIRhPAy46xjiHCfvQnTf8+9hp2V+it/oKJcGkMCI
         xhTn0ll5X6/ImdZBn2vjDX893bpQz6SRHJvE7NZ9GudtFDZ6KHgCYJ/aKlycwgqeOR8s
         n/wjHKPXelLQ1A/4QyVP5UfZsfygFQw+aZV/iMDD6gD60VJsOAJVZuV4/5/ZTw9Cnm3R
         EEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HjlWS6EdAZUgAZeMh0MJ7zt3HS64xHIgEt+/XwDaOiw=;
        b=IS79UkSWLqzHe2rzYlT3cvscBsTBNVPQ869RYt4pswDaEgS4d4UHHb3XKy9ODdyLLO
         frkSNP9J10xrxC1qyOemxBEqDrckTN2l2rD2t/YHGetLcjhC6oLY681cUC2XydgoDKBb
         y4hdV02qwqjv/eqTveobB0vks+1hsUEqYwM77xD2dOw2h0zIouNeHeclBJp7svml3qH2
         MZeI3uXR0J1ysEihW+0ZrQ87973+lo2eK/tRzXW7oW00sIeAeoeSYZDybdMyrV0UkEcE
         o2Mzlm96hZCL9ZGP77VORzGoV5NF/ggzNsBcumKkxSFc+IEv62XPhzNIAKAuOHWLeTEk
         sf6g==
X-Gm-Message-State: APjAAAWLZTVX5l8OW4kp/ZudpcM2tJPtJ3ADeOIr2J/9m96VN9ceuIUs
        DMEV3MpeOnSM7sAa0lvxV0XBYhJaU9i+lDPsxgo=
X-Google-Smtp-Source: APXvYqyFZbKxTPlAuzUq3lHlt8Ic2mZu5NRZl3vIHIvNAqeIgnxv3M9b1U9kwUauD1klVEN1Cbk48tKevwmTFmbkDo0=
X-Received: by 2002:a63:8e4b:: with SMTP id k72mr32356192pge.428.1557145816958;
 Mon, 06 May 2019 05:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190429154657.26797-1-hdegoede@redhat.com>
In-Reply-To: <20190429154657.26797-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 6 May 2019 15:30:06 +0300
Message-ID: <CAHp75VdcZOP2dYYtsfk3jcnESRBjxkE49GkDGPTp=XW+5Sbrgg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for 'jumper ezpad
 6 pro b' touchscreen
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Renz <appswert@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 6:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> From: Benjamin Renz <appswert@gmail.com>
>
> Add touchscreen platform data for the 'jumper ezpad 6 pro b' touchscreen.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Benjamin Renz <appswert@gmail.com>
> [hdegoede@redhat.com: Cleanup commit msg, fix some checkpatch warnings]
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 3319f0cbb558..bd0856d2e825 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -249,6 +249,21 @@ static const struct ts_dmi_data jumper_ezpad_6_pro_data = {
>         .properties     = jumper_ezpad_6_pro_props,
>  };
>
> +static const struct property_entry jumper_ezpad_6_pro_b_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
> +       PROPERTY_ENTRY_STRING("firmware-name", "gsl3692-jumper-ezpad-6-pro-b.fw"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data jumper_ezpad_6_pro_b_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = jumper_ezpad_6_pro_b_props,
> +};
> +
>  static const struct property_entry jumper_ezpad_mini3_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-min-x", 23),
>         PROPERTY_ENTRY_U32("touchscreen-min-y", 16),
> @@ -690,6 +705,17 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_MATCH(DMI_BIOS_DATE, "08/18/2017"),
>                 },
>         },
> +       {
> +               /* Jumper EZpad 6 Pro B */
> +               .driver_data = (void *)&jumper_ezpad_6_pro_b_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Jumper"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "EZpad"),
> +                       DMI_MATCH(DMI_BIOS_VERSION, "5.12"),
> +                       /* Above matches are too generic, add bios-date match */
> +                       DMI_MATCH(DMI_BIOS_DATE, "04/24/2018"),
> +               },
> +       },
>         {
>                 /* Jumper EZpad mini3 */
>                 .driver_data = (void *)&jumper_ezpad_mini3_data,
> --
> 2.21.0
>


--
With Best Regards,
Andy Shevchenko
