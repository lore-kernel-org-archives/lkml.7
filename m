Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44AEC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF2620673
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gggESg/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfJGQT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:19:56 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35555 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGQT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:19:56 -0400
Received: by mail-yb1-f195.google.com with SMTP id f4so4874440ybm.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 09:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fuxnneegK0n5AQkn3Efg7QQxvRdE8FlI4AZRcfswJc0=;
        b=gggESg/a8iQOk/eiOTYXQcYqkbR3kHUOK4ySOsws+CmrSgKU4qCuh6MRVhVwZrOSqH
         EAVlps2UTDr67pjAIsQp6XjADyOhQByETJApt/rPvGhO4mx+JUJc8a6WCAEw2o94ZVpp
         puHtiiLQI3X9djyBadmRMxRWZJ6Otqn7YHM4X2WzEML79wT25lncdGXCFPMnx3jfFxzI
         WozJkgi2KYnGBwwTGFvSlydzybZrzld2q7kJshd4T/uUKvvgx93IrP8zbRk0jpTeo6+c
         +klcRS1tsciAetBVSSO4cns8cCH1Ox95p+8JHTky6IFRRQ0zFbUEBN3hvRvzwDteUtTk
         sONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fuxnneegK0n5AQkn3Efg7QQxvRdE8FlI4AZRcfswJc0=;
        b=jpklN5n5JEw8HhORMdz03txBsRKXRdRWygCMqV8EpE68b08lSWo9Wt4WPpG+a9xOVN
         N6Je62TRdVjo5XBv5lc6sWDBONiAAi8ILv0/CLNS1V131G7TaUztpg5E9eqwbPrac6FT
         6QYic+f02vG5vkYwxGfQTYIXc7t4wJQNk3STXhP5EcgKzTaTergBszLODf50rGr4SzP9
         ZYa9h7AAjd0LPvOXv842cUaMHJLQvGOgG280CuM78tdBWSMNdvmecRuJRtpQtc/PM1cU
         Noonpim+CycuC5Sic82/GTuF87GszLWsinXPpdWvl1oHNnOzwMWKj6zpa90tH3YZBO5X
         5efQ==
X-Gm-Message-State: APjAAAWXUCVNoUMXwDOG9ei1ud9k8u3v4ZOpf5owU+shNliTRy1zn4gA
        Zhf+5FrZskpXa1nTgcPEF+sVjjDF1JkKHuemQ94QNA==
X-Google-Smtp-Source: APXvYqwsVP7yARKuOjpTCziICZb3EqEs18JlF2GJwWix24wKGGcr2npXgkv47FEXsEOdQO6ilnSn55kjSDH227sF/7Q=
X-Received: by 2002:a25:df8d:: with SMTP id w135mr10874114ybg.453.1570465192707;
 Mon, 07 Oct 2019 09:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <87h84rbile.fsf@intel.com> <20191002102428.zaid63hp6wpd7w34@holly.lan>
 <8736gbbf2b.fsf@intel.com> <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com>
 <87h84q9pcj.fsf@intel.com> <CAL_quvQoWnWqS5OQAqbLcBO-bR9_obr1FBc6f6mA1T00n1DJNQ@mail.gmail.com>
 <CAOw6vbJ7XX8=nrJDENfn2pacf4MqQOkP+x8JV0wbqzoMfLvZWQ@mail.gmail.com>
In-Reply-To: <CAOw6vbJ7XX8=nrJDENfn2pacf4MqQOkP+x8JV0wbqzoMfLvZWQ@mail.gmail.com>
From:   Mat King <mathewk@google.com>
Date:   Mon, 7 Oct 2019 10:19:40 -0600
Message-ID: <CAL_quvTe_v9Vsbd0u4URitojmD-_VFeaOQ1BBYZ_UGwYWynjVA@mail.gmail.com>
Subject: Re: New sysfs interface for privacy screens
To:     Sean Paul <seanpaul@chromium.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, rafael@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Alexander Schremmer <alex@alexanderweb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 7:09 AM Sean Paul <seanpaul@chromium.org> wrote:
>
> On Thu, Oct 3, 2019 at 3:57 PM Mat King <mathewk@google.com> wrote:
> >
> > On Thu, Oct 3, 2019 at 2:59 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > >
> > > On Wed, 02 Oct 2019, Mat King <mathewk@google.com> wrote:
> > > > On Wed, Oct 2, 2019 at 4:46 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > >>
> > > >> On Wed, 02 Oct 2019, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > > >> > On Wed, Oct 02, 2019 at 12:30:05PM +0300, Jani Nikula wrote:
> > > >> >> On Tue, 01 Oct 2019, Mat King <mathewk@google.com> wrote:
> > > >> >> > Resending in plain text mode
>
> /snip
>
> >
> > So my proposal would now be to add a new standard property to
> > drm_connector called "privacy_screen" this property would be an enum
> > which can take one of three values.
> >
> > PRIVACY_UNSUPPORTED - Privacy is not available for this connector
> > PRIVACY_DISABLED - Privacy is available but turned off
> > PRIVACY_ENABLED - Privacy is available and turned on
>
> Agree with Jani, use the property presence to determine if it's supported

That makes sense; just to confirm can a property be added or removed
after the connector is registered?

>
> >
> > When the connector is initized the privacy screen property is set to
> > PRIVACY_UNSUPPORTED and cannot be changed unless a drm_privacy_screen
> > is registered to the connector. drm_privacy_screen will look something
> > like
> >
> > struct drm_privacy_screen_ops {
> >     int (*get_privacy_state)(struct drm_privacy_screen *);
> >     int (*set_privacy_state)(struct drm_privacy_screen *, int);
> > }
> >
> > struct drm_privacy_screen {
> >     /* The privacy screen device */
> >     struct device *dev;
> >
> >     /* The connector that the privacy screen is attached */
> >     struct drm_connector *connector;
> >
> >     /* Ops to get and set the privacy screen state */
> >     struct drm_privacy_screen_ops *ops;
> >
> >     /* The current state of the privacy screen */
> >     int state;
> > }
> >
> > Privacy screen device drivers will call a function to register the
> > privacy screen with the connector.
>
> Do we actually need dedicated drivers for privacy screen? It seems
> like something that is panel-specific hardware, so I'd suggest just
> using the panel driver.

The privacy screen is physically part of the display but the control
interface, at least in all current use cases, is ACPI. Is there a way
to control an ACPI device with the panel driver?

>
> Sean
>
> >
> > int drm_privacy_screen_register(struct drm_privacy_screen_ops *ops,
> > struct device *dev, struct drm_connector *);
> >
> > Calling this will set a new field on the connector "struct
> > drm_privacy_screen *privacy_screen" and change the value of the
> > property to ops->get_privacy_state(). When
> > drm_mode_connector_set_obj_prop() is called with the
> > privacy_screen_proptery if a privacy_screen is registered to the
> > connector the ops->set_privacy_state() will be called with the new
> > value.
> >
> > Setting of this property (and all drm properties) is done in user
> > space using ioctrl.
> >
> > Registering the privacy screen with a connector may be tricky because
> > the driver for the privacy screen will need to be able to identify
> > which connector it belongs to and we will have to deal with connectors
> > being added both before and after the privacy screen device is added
> > by it's driver.
> >
> > How does that sound? I will work on a patch if that all sounds about right.
> >
> > One question I still have is there a way to not accept a value that is
> > passed to drm_mode_connector_set_obj_prop()? In this case if a privacy
> > screen is not registered the property must stay PRIVACY_UNSUPPORTED
> > and if a privacy screen is registered then PRIVACY_UNSUPPORTED must
> > never be set.
