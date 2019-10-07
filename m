Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3788DECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02128206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 19:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKWapvpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbfJGTbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 15:31:48 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35257 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfJGTbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 15:31:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id m7so14971965lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6janG/twynO5N6RLQTcAa8FnjT+uKYqGn399L8c11Xw=;
        b=IKWapvpNRq1xHEY7GPQfDPs22GMw9wvc21ZN5KRGPv/xYt3khp+SeCRMoM/fSpVKpB
         4tXNJ8F0RIfSv24JeUQuNX6XWMz8Y65ue+gViSckr3CFvIDPdF++OXJLaYQfPy9D2jh5
         TcqoFXRmbAK5Im/RmfuUsP5p0U6Z1RC2fgyC/biZl9Ao8jKUK6AKUF7OQVtB4X+W/TNA
         TMz2qnQlwqKynTBphxbH7vLfktSjT3VswEyLc57z+aX2gm6OMLZy6N3XV1Pf6cPRC9ew
         Ht9mtRDe2oFMFBITKZqXJW9BGSw+6Sd/Rz1dFtOPX5RXGw1yID007FMGGshWsGwW7+RJ
         lYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6janG/twynO5N6RLQTcAa8FnjT+uKYqGn399L8c11Xw=;
        b=a3K7NrlmQVUF46WRet2kL4FF5cZyIrLoc9jFO0QP/OVZY8SrKlEaokbKvTC3hONyNK
         mJ/PMaswDGtx5HKJiQHHAfRQ1YbWkyzMoGtd2zNoTXLgaFNz3mjQy3bufJUZFuQ3Wdk6
         5lwUMRV+ev+SW638UKVNUFcfz4O7kfxeFMxZn+lG95Yu15byEpG+Ahbl5w93enNdY4DN
         y7+5s6o5HgBgP8zrptl2qAH0ivPAt/BuqygYGSpuyTVRIziZjTev0On+90o+o+INAHMz
         QBRf6tOKZI3hvTBMOBBmNeAjeEOokgvQXRqs3fNpxO5lhyj4byyNJ64FNoZZmrf7PELI
         3mYQ==
X-Gm-Message-State: APjAAAWNZJWsrurMjiUpYB+zzH2DD+UzcKL1akt/zqXnKsz+yRDbokhZ
        fHi9g1zqizDbli0GALErxm6injv9WkbK4Onvnt2a2A==
X-Google-Smtp-Source: APXvYqxDDz2qJJc79lbL5ebXszVSYDWfg+4D6lLlqjAogPaHqCThU85XWA4j67TE/Cr1e90BP+LTMb2HvsWUYEQ9kmQ=
X-Received: by 2002:a2e:2e13:: with SMTP id u19mr17510537lju.112.1570476704924;
 Mon, 07 Oct 2019 12:31:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAL_quvRknSSVvXN3q_Se0hrziw2oTNS3ENNoeHYhvciCRq9Yww@mail.gmail.com>
 <87h84rbile.fsf@intel.com> <20191002102428.zaid63hp6wpd7w34@holly.lan>
 <8736gbbf2b.fsf@intel.com> <CAL_quvQkFjkBjJC5wH2t5XmyEq9OKWYSbAv39BJWT1hrKO7j8g@mail.gmail.com>
 <87h84q9pcj.fsf@intel.com> <CAL_quvQoWnWqS5OQAqbLcBO-bR9_obr1FBc6f6mA1T00n1DJNQ@mail.gmail.com>
 <CAOw6vbJ7XX8=nrJDENfn2pacf4MqQOkP+x8JV0wbqzoMfLvZWQ@mail.gmail.com> <CAL_quvTe_v9Vsbd0u4URitojmD-_VFeaOQ1BBYZ_UGwYWynjVA@mail.gmail.com>
In-Reply-To: <CAL_quvTe_v9Vsbd0u4URitojmD-_VFeaOQ1BBYZ_UGwYWynjVA@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Mon, 7 Oct 2019 12:31:08 -0700
Message-ID: <CACK8Z6H+tBHproaH2hf59mYF406ohYhAWj8szYn=Fjao2SUZVA@mail.gmail.com>
Subject: Re: New sysfs interface for privacy screens
To:     Mat King <mathewk@google.com>
Cc:     Sean Paul <seanpaul@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ross Zwisler <zwisler@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
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

On Mon, Oct 7, 2019 at 9:19 AM Mat King <mathewk@google.com> wrote:
>
> On Mon, Oct 7, 2019 at 7:09 AM Sean Paul <seanpaul@chromium.org> wrote:
> >
> > On Thu, Oct 3, 2019 at 3:57 PM Mat King <mathewk@google.com> wrote:
> > >
> > > On Thu, Oct 3, 2019 at 2:59 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > >
> > > > On Wed, 02 Oct 2019, Mat King <mathewk@google.com> wrote:
> > > > > On Wed, Oct 2, 2019 at 4:46 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> > > > >>
> > > > >> On Wed, 02 Oct 2019, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > > > >> > On Wed, Oct 02, 2019 at 12:30:05PM +0300, Jani Nikula wrote:
> > > > >> >> On Tue, 01 Oct 2019, Mat King <mathewk@google.com> wrote:
> > > > >> >> > Resending in plain text mode
> >
> > /snip
> >
> > >
> > > So my proposal would now be to add a new standard property to
> > > drm_connector called "privacy_screen" this property would be an enum
> > > which can take one of three values.
> > >
> > > PRIVACY_UNSUPPORTED - Privacy is not available for this connector
> > > PRIVACY_DISABLED - Privacy is available but turned off
> > > PRIVACY_ENABLED - Privacy is available and turned on
> >
> > Agree with Jani, use the property presence to determine if it's supported
>
> That makes sense; just to confirm can a property be added or removed
> after the connector is registered?
>
> >
> > >
> > > When the connector is initized the privacy screen property is set to
> > > PRIVACY_UNSUPPORTED and cannot be changed unless a drm_privacy_screen
> > > is registered to the connector. drm_privacy_screen will look something
> > > like
> > >
> > > struct drm_privacy_screen_ops {
> > >     int (*get_privacy_state)(struct drm_privacy_screen *);
> > >     int (*set_privacy_state)(struct drm_privacy_screen *, int);
> > > }
> > >
> > > struct drm_privacy_screen {
> > >     /* The privacy screen device */
> > >     struct device *dev;
> > >
> > >     /* The connector that the privacy screen is attached */
> > >     struct drm_connector *connector;
> > >
> > >     /* Ops to get and set the privacy screen state */
> > >     struct drm_privacy_screen_ops *ops;
> > >
> > >     /* The current state of the privacy screen */
> > >     int state;
> > > }
> > >
> > > Privacy screen device drivers will call a function to register the
> > > privacy screen with the connector.
> >
> > Do we actually need dedicated drivers for privacy screen? It seems
> > like something that is panel-specific hardware, so I'd suggest just
> > using the panel driver.
>
> The privacy screen is physically part of the display but the control
> interface, at least in all current use cases, is ACPI. Is there a way
> to control an ACPI device with the panel driver?

I feel that doing it in a dedicated driver has the advantage that if
we can standardise the control interface, it can be used across
different panels. So a new panel can be supported using the existing
driver by merely instantiating the right ACPI HID "privacy screen"
device as a child device of the parent display / panel device. This
parent-child relation would also give the kernel the connection needed
about "which display does this privacy screen attach to". In future,if
non-x86 platforms need the feature using a different control interface
(say via a GPIO driver), the privacy screen driver can be updated to
support that also.

Thanks,

Rajat

>
> >
> > Sean
> >
> > >
> > > int drm_privacy_screen_register(struct drm_privacy_screen_ops *ops,
> > > struct device *dev, struct drm_connector *);
> > >
> > > Calling this will set a new field on the connector "struct
> > > drm_privacy_screen *privacy_screen" and change the value of the
> > > property to ops->get_privacy_state(). When
> > > drm_mode_connector_set_obj_prop() is called with the
> > > privacy_screen_proptery if a privacy_screen is registered to the
> > > connector the ops->set_privacy_state() will be called with the new
> > > value.
> > >
> > > Setting of this property (and all drm properties) is done in user
> > > space using ioctrl.
> > >
> > > Registering the privacy screen with a connector may be tricky because
> > > the driver for the privacy screen will need to be able to identify
> > > which connector it belongs to and we will have to deal with connectors
> > > being added both before and after the privacy screen device is added
> > > by it's driver.
> > >
> > > How does that sound? I will work on a patch if that all sounds about right.
> > >
> > > One question I still have is there a way to not accept a value that is
> > > passed to drm_mode_connector_set_obj_prop()? In this case if a privacy
> > > screen is not registered the property must stay PRIVACY_UNSUPPORTED
> > > and if a privacy screen is registered then PRIVACY_UNSUPPORTED must
> > > never be set.
