Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0039C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6B32186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 18:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDSdxxB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfCOSnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 14:43:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39392 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfCOSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 14:43:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id i20so6941675pfo.6;
        Fri, 15 Mar 2019 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UzIvI6hUKtM345OPRMvag+o1k0P7RZYP6J+h26B8ay8=;
        b=iDSdxxB4k9x/hn52pJyNyYzdxVs7rBxwoNAFGvN0B9Cw0fswiZK57LfeNwRh1+wQy5
         iLtCe6URXqD3yuJPsbqjHRW0t4bQvJ8cAdJ6Q/Ms3cByLM81B/d2qZZXUwkfI4Xf3c+1
         3vk3U7wfIAmYkKW0OPt5tYHdcOMnICqk51G7ReDp9gfnl7YhFcn9BRX5EQFsNsE5pBEV
         be/6hKDpecBViOLZse0vUIbNC/a3AuIQuLvYZ4o8ts8tGW+HycUl3Z7cI+4ztYG1gzMz
         q14sNQytzkxf03zSoZUjuwGHRrHRdGnUjFP7QnutGItSoYCCtHnDwvC+fCTjkN/a7tAc
         jzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UzIvI6hUKtM345OPRMvag+o1k0P7RZYP6J+h26B8ay8=;
        b=ppb0yqakfhbQE8wKKefXgbPtrelA1sqff7cIuL2NnxUpAKWUHOxFM+wbXtyHM040hv
         xAayP37ANdrZzp630NRSQFN2hStq5FnPYpll5Qh4mzGlYMXNmoF7wl99rVE7j3jgYmB6
         Z3V+EALUfwEg66bbBs+OI/oU+LOssZKAfGiaIXCQY7pioIs9wwJCSuif4uJy0au2zBde
         63RGvzaDVlnuSICUen7N8u5VnQ5lcpYmPS5lKLNNd1N8cZT9swmzxYdanNvlHqjIKQL9
         +TY9F3+wBDybU38lZetqWyKv57egfT7ZNXjcFpJNd0KZON5kJk8uqVlogCdUYYKRWjZR
         8MZA==
X-Gm-Message-State: APjAAAWO/N8M6vOJAI4ghWU8otrG/maaYmFTA1tSMOiIiW8C0XO5+6ta
        yI6kWFmYwaVOkHb+YcX8D+2p85vVKyiuO/X4dBU=
X-Google-Smtp-Source: APXvYqyS0+ZkigTGbGwd3UfYEmZKJPsT/bAX2aS1P3a2hiucMk4RjcizVwL8obeASZT10vxxXE8IzAMT8it/l8LCNBI=
X-Received: by 2002:a63:b902:: with SMTP id z2mr4958179pge.428.1552675414054;
 Fri, 15 Mar 2019 11:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190315133113.21215-1-gabriel.lazar@com.utcluj.ro> <12a67eb2-18ff-dd9f-4c48-4d01a01a2aa7@redhat.com>
In-Reply-To: <12a67eb2-18ff-dd9f-4c48-4d01a01a2aa7@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Mar 2019 20:43:21 +0200
Message-ID: <CAHp75VeAdFdHWWRXe-Jr=kvufCrQzq5dOCj9rW3tBvtzHEcEYA@mail.gmail.com>
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
>

OK, thanks for explanation.
I'll take it after merge window will be closed.

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
