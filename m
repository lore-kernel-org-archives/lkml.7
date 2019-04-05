Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D295A205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRxwvhDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfDEOXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:23:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36890 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfDEOXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:23:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so3379092pfr.4;
        Fri, 05 Apr 2019 07:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwNCEpBYGlJSUsM/bjteJhZ1zYLJvheT6S0o63zx06g=;
        b=iRxwvhDp7RNhVt1hN8SGMj+isgOjbsVvmokWrAR3HGMoVTGErZm1jFhmNbVN/SXXhI
         r1mJf5CXmQy7tEhSQqxpewtJbOSfaWDrakLHVDCCTXkmyvOuqjM25RG4xlt6Y20hXxVI
         qJbWLthtgtRHuzVCWi9RojpXxDEU70IR3Q+IMEImqUNtrp6R2irrjU5BReyUojipeeHD
         xx+HjAJqmCT3oILH9HuG+egaZIPy1AAXuy6CRy60m+mKkWdKpUxMPU72mBE/ilBal50l
         A/sRSW2nLJcSigPsCF9Nx3E8Emaf0OpidzE9tzxJZbKfcwpVoDdxFWHttYcRw9HDcSnf
         ae0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwNCEpBYGlJSUsM/bjteJhZ1zYLJvheT6S0o63zx06g=;
        b=sBf6ikxxYVSWyc4OtTldMCTRGqsCInUdDsFK14ml8N2GlpXT4Xs6dMib1en4H7Rr+n
         Ov01qs7g8pLT/KsfothNU7uEN1tpfteTDc66ElRYZXWEsfDB6x9/eXPB7Nh8F6Lc5AW3
         x2zQfF2GnRBFdfeYEn9jURKTKfPN9SrYKbJjZWEYpQrLkIUT3KyD53qb8vsJAPEQsz/k
         rm7bG0hJwJVCEfEkQY1zNlVhEvRsRVOM/oke7fmcrsKuY34M0eJJIwlVs5ZORDLPLdRv
         8pdSAO7m3f8ZmSC5XrgCFWp7r6+s9YotnXzGM7wJThHvYydePRqkFklyLM9QARKjgqQa
         rb+A==
X-Gm-Message-State: APjAAAVO7UdDO1e7EjIEECPrQbYNlQoEajxAUKSnjc1SN2MPEJ5gDfjH
        D0QkOqomcDjHW2kmIPCI9Xgg26/LShcWbw6e1fM=
X-Google-Smtp-Source: APXvYqwYHdgCndAoCq9TLAejLYJ8SY1lRNq00ZYXMZO7ChCTGy/JK65kRxJDx0iuAFuF2+4CH1NK75tlisE+SvxW3qM=
X-Received: by 2002:a62:2587:: with SMTP id l129mr12870704pfl.151.1554474183723;
 Fri, 05 Apr 2019 07:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190315133113.21215-1-gabriel.lazar@com.utcluj.ro> <12a67eb2-18ff-dd9f-4c48-4d01a01a2aa7@redhat.com>
In-Reply-To: <12a67eb2-18ff-dd9f-4c48-4d01a01a2aa7@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Apr 2019 17:22:52 +0300
Message-ID: <CAHp75VcS=aQCj1D_ecQq3HP=eZFYd3++rdatcMDs5hJxeniTow@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add info for Myria MY8307 2-in-1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Gabriel Lazar <gabriel.lazar@com.utcluj.ro>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        linux-input <linux-input@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 7:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/15/19 2:31 PM, Gabriel Lazar wrote:
> > Add touchscreen platform data for the Myrya MY8307 2-in-1 laptop.
> >
> > Signed-off-by: Gabriel Lazar <gabriel.lazar@com.utcluj.ro>
>
> Patch looks good to me:
>
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Pushed to my review and testing queue, thanks!

>
> Regards,
>
> Hans
>
>
>
> > ---
> >   drivers/platform/x86/touchscreen_dmi.c | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> >
> > diff --git a/drivers/platform/x86/touchscreen_dmi.c b/drivers/platform/x86/touchscreen_dmi.c
> > index 2d56ff7c8230..3319f0cbb558 100644
> > --- a/drivers/platform/x86/touchscreen_dmi.c
> > +++ b/drivers/platform/x86/touchscreen_dmi.c
> > @@ -265,6 +265,23 @@ static const struct ts_dmi_data jumper_ezpad_mini3_data = {
> >       .properties     = jumper_ezpad_mini3_props,
> >   };
> >
> > +static const struct property_entry myria_my8307_props[] = {
> > +     PROPERTY_ENTRY_U32("touchscreen-size-x", 1720),
> > +     PROPERTY_ENTRY_U32("touchscreen-size-y", 1140),
> > +     PROPERTY_ENTRY_BOOL("touchscreen-inverted-x"),
> > +     PROPERTY_ENTRY_BOOL("touchscreen-inverted-y"),
> > +     PROPERTY_ENTRY_BOOL("touchscreen-swapped-x-y"),
> > +     PROPERTY_ENTRY_STRING("firmware-name", "gsl1680-myria-my8307.fw"),
> > +     PROPERTY_ENTRY_U32("silead,max-fingers", 10),
> > +     PROPERTY_ENTRY_BOOL("silead,home-button"),
> > +     { }
> > +};
> > +
> > +static const struct ts_dmi_data myria_my8307_data = {
> > +     .acpi_name      = "MSSL1680:00",
> > +     .properties     = myria_my8307_props,
> > +};
> > +
> >   static const struct property_entry onda_obook_20_plus_props[] = {
> >       PROPERTY_ENTRY_U32("touchscreen-size-x", 1728),
> >       PROPERTY_ENTRY_U32("touchscreen-size-y", 1148),
> > @@ -690,6 +707,14 @@ static const struct dmi_system_id touchscreen_dmi_table[] = {
> >                       DMI_MATCH(DMI_PRODUCT_NAME, "FlexBook edge11 - M-FBE11"),
> >               },
> >       },
> > +     {
> > +             /* Myria MY8307 */
> > +             .driver_data = (void *)&myria_my8307_data,
> > +             .matches = {
> > +                     DMI_MATCH(DMI_SYS_VENDOR, "Complet Electro Serv"),
> > +                     DMI_MATCH(DMI_PRODUCT_NAME, "MY8307"),
> > +             },
> > +     },
> >       {
> >               /* Onda oBook 20 Plus */
> >               .driver_data = (void *)&onda_obook_20_plus_data,
> >



-- 
With Best Regards,
Andy Shevchenko
