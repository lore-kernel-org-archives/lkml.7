Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382CACA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6762086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 19:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdxrRycM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391345AbfJWTIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 15:08:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37873 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389752AbfJWTIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 15:08:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so12694847pgi.4;
        Wed, 23 Oct 2019 12:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MxX/DmpVboZjshq+xEtg+czp+G1yghOR3A33pj8rse0=;
        b=EdxrRycMQG2Bq+4TKZg+FfJ1SlAtfiPjaHX35fLqSiGOLA8eMpzPSmWmoBzylbt2DF
         KkvsZb6U4lpRflsxFcdYVSDiNHkkl6ViN1R/W1AwwwaCh8EZJIUvo5czEm4SoJ1EQXem
         rGJ97ALVJHg0SgGm6Jb8Hln5qtYXA127/qKEe5UYUXvuPxm6Jawhoo9ADsa3rXSn2DNT
         lkbuLfvy4x68581mBueCG5f71ezcAg6GRy7CME2N+z9CE8hJ3qHP5skXsxBdC5hjf/Ln
         OjXPKEa30h9gjbOwVmitOx69UNxtflLqrKJYh631mbwFSYSCljZNBWMAHfuoilz8M0Rb
         W1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MxX/DmpVboZjshq+xEtg+czp+G1yghOR3A33pj8rse0=;
        b=nAAYlHWZXZqeeSTlNrX2KB1kapU3I5m2MurOXTteS0QvADhW4gNqKrQUXxKxsyoGlf
         01Nk6jhZDm5DDf87y4HBICZm/KdZMUHow2MDCMUp7Ksis6epE4xqgH4015HxW6yVE6ty
         7WKAgT2WfiHednif6XhAsD9PH1HGaVCs2bh2/LnfFl5rQnFV/VTuDTKXq9VYFaZBJ9Fw
         zhUUh8S4DVKpYi968+JYEx0ktR9LPir+BpJ5/Fad2sb/Uto8xOVbmyc1gfjXPLZOG3p6
         NaW8j9S6iv+ZYEMWUYmzQMRjtyHytPJYnoZks4Rma2tw02MgPHBdrlwerQcOtYbA5AfR
         zXEg==
X-Gm-Message-State: APjAAAUW4TU41bnGwMtLel9o5Nqy0BNfbXnqD2915WBjhL2IhnoZ393T
        vQFqG8irkJ7gGA3c0MQO+rq2zNZdjLnlltUaIuM=
X-Google-Smtp-Source: APXvYqwEin0+/jsXwQNm/vxdFCBXHX86fl3Tm6aT6NKthLdEtaFBZC10goQGEE0Fy0nlLOqnTNwk5dIX/EwWchLQJRU=
X-Received: by 2002:aa7:8b02:: with SMTP id f2mr13097433pfd.151.1571857702529;
 Wed, 23 Oct 2019 12:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20191023185323.13552-1-hdegoede@redhat.com>
In-Reply-To: <20191023185323.13552-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 23 Oct 2019 22:08:10 +0300
Message-ID: <CAHp75VfhKzXfJEwHLdkwJHPXmL6bCRMtvo-0aCSQxdiHQyXHHQ@mail.gmail.com>
Subject: Re: [PATCH resend] Add touchscreen platform data for the Schneider
 SCT101CTM tablet
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Gorbea Ainz <danielgorbea@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 9:53 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> From: Daniel Gorbea Ainz <danielgorbea@hotmail.com>
>
> Add touchscreen platform data for the Schneider SCT101CTM tablet

Thanks, now patchwork sees it.

> Signed-off-by: Daniel Gorbea <danielgorbea@hotmail.com>

> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I'm not sure you need to put Rb when you have your SoB.
Do you think it's fine if I remove Rb when applying?

> ---
> hdegoede: Resend from my email address as vger.kernel.org does not like
> Daniel's emails
> ---
>  drivers/platform/x86/touchscreen_dmi.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> index 8bfef880e216..ba494ace83d4 100644
> --- a/drivers/platform/x86/touchscreen_dmi.c
> +++ b/drivers/platform/x86/touchscreen_dmi.c
> @@ -549,6 +549,24 @@ static const struct ts_dmi_data pov_mobii_wintab_p1006w_v10_data = {
>         .properties     = pov_mobii_wintab_p1006w_v10_props,
>  };
>
> +static const struct property_entry schneider_sct101ctm_props[] = {
> +       PROPERTY_ENTRY_U32("touchscreen-size-x", 1715),
> +       PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> +       PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> +       PROPERTY_ENTRY_STRING("firmware-name",
> +                             "gsl1680-schneider-sct101ctm.fw"),
> +       PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> +       PROPERTY_ENTRY_BOOL("silead,home-button"),
> +       { }
> +};
> +
> +static const struct ts_dmi_data schneider_sct101ctm_data = {
> +       .acpi_name      = "MSSL1680:00",
> +       .properties     = schneider_sct101ctm_props,
> +};
> +
>  static const struct property_entry teclast_x3_plus_props[] = {
>         PROPERTY_ENTRY_U32("touchscreen-size-x", 1980),
>         PROPERTY_ENTRY_U32("touchscreen-size-y", 1500),
> @@ -968,6 +986,14 @@ const struct dmi_system_id touchscreen_dmi_table[] = {
>                         DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
>                 },
>         },
> +       {
> +               /* Schneider SCT101CTM */
> +               .driver_data = (void *)&schneider_sct101ctm_data,
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Default string"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "SCT101CTM"),
> +               },
> +       },
>         {
>                 /* Teclast X3 Plus */
>                 .driver_data = (void *)&teclast_x3_plus_data,
> --
> 2.23.0
>


-- 
With Best Regards,
Andy Shevchenko
