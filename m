Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97010C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F732082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/VTn7WI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbfCENmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:42:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35548 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfCENmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:42:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so5679696pgd.2;
        Tue, 05 Mar 2019 05:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c/ICc2q2l3ru0hH9c6yn1gICeQRZ3s7eRFxqpZBbsVs=;
        b=V/VTn7WIjZkAq72VG/S0AiwLV1BsjjI9wVR5fnVikCYSVo7UbZqyUQc98rrRMc5qhD
         FUo3wqieudavkL9Q9TjQRbIIZkLiggYNUUMrV4y5Vl9koJHxCPJGrKsVMrPxXBWekB8x
         0FPO9CEE61FIVZ/k1gN6xTSJqi3i77wuj4/hlJ76jalEiid1RoeAG8FJFxyZk8cxOZYR
         QWc/u83gt4cBf0gOKndPM41LBS9g0XC0JXs70Kdo3k9Oe5rmH80+ZX0rBs+QJ+guNgLQ
         Ljo1dPBvabIt8SvTkNp1uF1MG+NL0dRHNNfb9YHlV+6YMC6e2doI05Yp5v7CEqnBpY3f
         gZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c/ICc2q2l3ru0hH9c6yn1gICeQRZ3s7eRFxqpZBbsVs=;
        b=sovilrH+irF6m7A12gjuxl+fE7J/6tfC7+d4UzQmEyuk6GgFYynzwghCBJaXIZ9+Ud
         CrP05R70muQcnVzpXpMapSxqGXFOqo7LucCfH8GfhYZXsiX90QtIQ/bP5LbRA0lesFnb
         u8YAjDtVlA6TJP7/4y0NDfMxRamy85bH3BLHmiNg30a99F4mxoRqXSFyVxkPmXbaFBp8
         Z3Ye+K4lTNmdsfmU4WhmESesMh2cQaN/AIJpbgTFKTyPIMXlmobh9NyScm4qnMJogHbh
         9Ssd5nMTHmnrCimlKbDqdBzSS9R+ClyKaADhtM0MdME1iClsKiLsTMTOn04G5PopZrd8
         SX+w==
X-Gm-Message-State: APjAAAWzNPfTbuj7Mi34iLZLAQVLisxmwnNhzpN7Wrxm3e4la855mJy8
        a/Bg4to4NZYzzfrYxAz+9WlA19KoFyM46eKFK75sWaiNc1M=
X-Google-Smtp-Source: APXvYqwXqyZMKiKTA33wtn1JXiz7SoxYeF2WA19o6cZfTIciPAxPak0F42Bo2py0eNpDUYRBe1KQVf0T6uHESnwE93o=
X-Received: by 2002:a17:902:a40d:: with SMTP id p13mr1255364plq.144.1551793355472;
 Tue, 05 Mar 2019 05:42:35 -0800 (PST)
MIME-Version: 1.0
References: <c6b0c2ef-eed9-ffae-e974-92260d5356aa@redhat.com>
 <20190303134727.6680-1-me@myself5.de> <f4937ec1-9dac-0810-7386-a15ec5d306ae@redhat.com>
In-Reply-To: <f4937ec1-9dac-0810-7386-a15ec5d306ae@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Mar 2019 15:42:23 +0200
Message-ID: <CAHp75VfHVWj-JBxqDMu1R249M_WpkzHgyX2dQr40JkPUNwNL5A@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: touchscreen_dmi: Add info for the CHUWI
 Hi10 Air tablet
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Christian Oder <me@myself5.de>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 3, 2019 at 3:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Christian,
>
> On 03-03-19 14:47, Christian Oder wrote:
> > Add  touchscreen info for the CHUWUI Hi10 Air tablet.
> >
> > Signed-off-by: Christian Oder <me@myself5.de>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Pushed to my review and testing queue, thanks!

> > ---
> > Changes in v2:
> > - added review tag
>
> A quick note for any patches you may submit in the future, there
> is no need to send a v2 just to add someones Reviewed-by or Acked-by,
> these will be picked up automatically by the subsys-maintainer when
> they add the patch to their tree.
>
> Regards,
>
> Hans
>
> >
> >   drivers/platform/x86/touchscreen_dmi.c | 27 ++++++++++++++++++++++++++
> >   1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> > index 167a156e3cc7..2d56ff7c8230 100644
> > --- a/drivers/platform/x86/touchscreen_dmi.c
> > +++ b/drivers/platform/x86/touchscreen_dmi.c
> > @@ -72,6 +72,25 @@ static const struct ts_dmi_data chuwi_hi8_pro_data = {
> >       .properties     = chuwi_hi8_pro_props,
> >   };
> >
> > +static const struct property_entry chuwi_hi10_air_props[] = {
> > +     PROPERTY_ENTRY_U32("touchscreen-size-x", 1981),
> > +     PROPERTY_ENTRY_U32("touchscreen-size-y", 1271),
> > +     PROPERTY_ENTRY_U32("touchscreen-min-x", 99),
> > +     PROPERTY_ENTRY_U32("touchscreen-min-y", 9),
> > +     PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> > +     PROPERTY_ENTRY_U32("touchscreen-fuzz-x", 5),
> > +     PROPERTY_ENTRY_U32("touchscreen-fuzz-y", 4),
> > +     PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-chuwi-hi10-air.fw"),
> > +     PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> > +     PROPERTY_ENTRY_BOOL("silead,home-button"),
> > +     { }
> > +};
> > +
> > +static const struct ts_dmi_data chuwi_hi10_air_data = {
> > +     .acpi_name      = "MSSL1680:00",
> > +     .properties     = chuwi_hi10_air_props,
> > +};
> > +
> >   static const struct property_entry chuwi_vi8_props[] = {
> >       PROPERTY_ENTRY_U32("touchscreen-min-x", 4),
> >       PROPERTY_ENTRY_U32("touchscreen-min-y", 6),
> > @@ -546,6 +565,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "X1D3_C806N"),
> >               },
> >       },
> > +     {
> > +             /* Chuwi Hi10 Air */
> > +             .driver_data = (void *)&chuwi_hi10_air_data,
> > +             .matches = {
> > +                     DMI_MATCH(DMI_BOARD_VENDOR, "Hampoo"),
> > +                     DMI_MATCH(DMI_PRODUCT_SKU, "P1W6_C109D_B"),
> > +             },
> > +     },
> >       {
> >               /* Chuwi Vi8 (CWI506) */
> >               .driver_data = (void *)&chuwi_vi8_data,
> >



-- 
With Best Regards,
Andy Shevchenko
