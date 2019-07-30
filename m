Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343F1C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F19208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 04:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEUI3Lxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfG3EJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 00:09:33 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36231 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfG3EJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 00:09:32 -0400
Received: by mail-yw1-f65.google.com with SMTP id x67so22023890ywd.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 21:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CZ/qbh71cM7/4Sn8yjlhaQLGnLaI4jI9zz5SRsmHonU=;
        b=gEUI3Lxu5EebGD79kpxXdVItRKE8YQtmrOx6MnmyBgNFQsAgthepQdmZ7YR24w91Au
         t2mdnKbzJP26aoKvKj64M3Y1fbgDMqFpixGzeM4dryfG/Q7j1VgUiN7NsjbxINHXxHFD
         MkKT9HFQLK9wYcOWV5UZR2X4jiPOMR/XsKylcLWpPDfQVS+Abg8MYfhpyx29l3LoeiFa
         c+/vLs6STG4OAqwqT2s1otHpzYVR3GdRdWLH0QQH7fi/vopR5hK50jpEx4hG0kNBEd9T
         CKkXZ33pqiZn67enA6AfLOLSTk+TqDn8xdvWDXTotFeFlA21RHjqlu1Qo7h4o6LXfcr+
         gfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CZ/qbh71cM7/4Sn8yjlhaQLGnLaI4jI9zz5SRsmHonU=;
        b=jc8b+5SgFZ6Nuld5VoiseVEpXKKRdx/Xe0Jeje3IWRzLK5Bb9IYDK2UUy6PDi48sST
         vJKkinj9ocqkvMQsNT+i2uTLh9KQ9T6DBNKr8nZlpUL5+qdXmrxKAHfrSODTxQa/eMfb
         mFzElfLVbFPIakYVcFJ19NZY+paJC3PBxPqHQ6edP3s1TogbJ2aMCZ18zWxeqC0HiRMy
         pyDkGyQNmqcfH8DxNQGxFvfJsHvbcNQvCV5vHsiQD7uAW/MJy6fr/XD9NhcETn0AowE2
         d3uUQuYDy1MEgwxddA11IhVuFOl2zj0LkzA9/koLJB4ItRAWGzltrvoazk3Pp1+sgrd3
         tu7Q==
X-Gm-Message-State: APjAAAXIszBLBTs3KI/akqHOQPu+ZpJWdWhJ3WS1/MFhW/KBDQCqT87h
        Ha2gmY/W4l7y88dT8tBhfU4pOyphOqZ9Ui8EwAOEmQ==
X-Google-Smtp-Source: APXvYqxvGwed2JfCJB11l5R+IOYds/ZYaZtd3Zdle3DGE6x31mLpHihO7SiNQn4zOOnRJdqDO9fBDXBaqvxk7N3Ds58=
X-Received: by 2002:a81:3803:: with SMTP id f3mr67420374ywa.337.1564459771762;
 Mon, 29 Jul 2019 21:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <1564030601-14639-1-git-send-email-rtresidd@electromag.com.au> <5023c937-0662-57e0-c104-bb9c23b07a49@electromag.com.au>
In-Reply-To: <5023c937-0662-57e0-c104-bb9c23b07a49@electromag.com.au>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 29 Jul 2019 21:09:20 -0700
Message-ID: <CABXOdTf45YEvF7YVxczzMwC2XQ2xuTpEo7cAAEqEs4=bdxmKNQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] power: supply: sbs-battery: Add ability to force load
 a battery via the devicetree
To:     Richard Tresidder <rtresidd@electromag.com.au>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, rfontana@redhat.com,
        allison@lohutok.net, Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nick Crews <ncrews@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 8:02 PM Richard Tresidder
<rtresidd@electromag.com.au> wrote:
>
> Hi Nick and Guenter
> Just adding you to this one also seeing as you're looking at that other
> sbs_battery patch for me.
> Not sure why the get maintainers didn't list you for this one.
>
> Cheers
>     Richard Tresidder
> > Add the ability to force load a hot pluggable battery during boot where
> > there is no gpio detect method available and the module is statically
> > built. Normal polling will then occur on that battery when it is inserted.
> >
> > Signed-off-by: Richard Tresidder <rtresidd@electromag.com.au>
> > ---
> >
> > Notes:
> >      Add the ability to force load a hot pluggable battery during boot where
> >      there is no gpio detect method available and the module is statically
> >      built. Normal polling will then occur on that battery when it is inserted.
> >
> >   drivers/power/supply/sbs-battery.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
> > index 048d205..ea8ba3e 100644
> > --- a/drivers/power/supply/sbs-battery.c
> > +++ b/drivers/power/supply/sbs-battery.c
> > @@ -161,6 +161,7 @@ struct sbs_info {
> >       int                             poll_time;
> >       u32                             i2c_retry_count;
> >       u32                             poll_retry_count;
> > +     bool                            force_load;
> >       struct delayed_work             work;
> >       struct mutex                    mode_lock;
> >       u32                             flags;
> > @@ -852,6 +853,9 @@ static int sbs_probe(struct i2c_client *client,
> >       if (rc)
> >               chip->poll_retry_count = 0;
> >
> > +     chip->force_load = of_property_read_bool(client->dev.of_node,
> > +                                             "sbs,force-load");
> > +

Maybe it is documented in another patch, which I have not seen. If it
isn't, it will have to be documented and reviewed by a devicetree
maintainer. Either case, I don't immediately see why the variable
needs to reside in struct sbs_info; it seems to be used only in the
probe function.

> >       if (pdata) {
> >               chip->poll_retry_count = pdata->poll_retry_count;
> >               chip->i2c_retry_count  = pdata->i2c_retry_count;
> > @@ -890,7 +894,7 @@ static int sbs_probe(struct i2c_client *client,
> >        * Before we register, we might need to make sure we can actually talk
> >        * to the battery.
> >        */
> > -     if (!(force_load || chip->gpio_detect)) {
> > +     if (!(force_load || chip->gpio_detect || chip->force_load)) {
> >               rc = sbs_read_word_data(client, sbs_data[REG_STATUS].addr);
> >
> >               if (rc < 0) {
>
