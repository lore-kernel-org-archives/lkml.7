Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3330C17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3BF21783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 18:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="RCD/1hgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfKLSY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 13:24:29 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33478 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 13:24:29 -0500
Received: by mail-oi1-f196.google.com with SMTP id m193so15727110oig.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 10:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r31nz+kZF/TKNHaB6gtaSbNm2gH5BovCO5Pp07i/Wqw=;
        b=RCD/1hgFNPTp/mnDzk1v9MF0BK0jZDLGEg9Kt8xJfdSlls7xEQ3sMC+h4Mkjzxrn2L
         Zxa8Kg0E98+n58D1Y8J5CqxUDorwG4Oyg+rloM5a0Rj5C9RE8MOoG3VsN6vtWqGKdVdZ
         J7jdNLMg1zQwh+6oiBDWK9O5MK6PK848/jyaw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r31nz+kZF/TKNHaB6gtaSbNm2gH5BovCO5Pp07i/Wqw=;
        b=fdFR5eKseaPSddDpOu8yV8PbtxAY2I/Ne3JzsFXDP6G5qqCkfuoxVtcXSdywGBhvYD
         Fu0bJsGeRCmrYAFBi9lsTdEuvRCIjEwfNrE9B/jaZWUoJ3x57P/9E8PMX/t+tyAOCr7D
         sOSqrcrADMN4gwHhjpQ0yDUsEzuW2HMIahlJrpLRSJGpXM7PFY7l8kaPTHRe8R/1PUQq
         cS7QFpao7ALUt0vZPbvvj3eAU+/ZkPntP1y0lz13moAlldZSM4wBMkC36xEl/u0hn0EZ
         f9UwAyl3SZz7gB7vC9PFHyUg1P6Yxtc0dOoXFa/OTjZjN++MfQ2vZZUjhCWmsB1ieaTP
         G0RA==
X-Gm-Message-State: APjAAAU94rinwenwzglfQ43esvoqdbcGeqqIrbvl/w+gfQX+YOLtu0hl
        +UHflq8hqacBCTCJMu2lcD0Tx+2mcxV0UXZth9+k0g==
X-Google-Smtp-Source: APXvYqzRgnCRMXxqQj79BtqZX1LPtWXkExcHdXYQWDqN4Kqq2E4Z9rVKxzMdBaB6Wc5vhP9G0tDMsM1gsn38R4D4eYA=
X-Received: by 2002:aca:b805:: with SMTP id i5mr308729oif.110.1573583067752;
 Tue, 12 Nov 2019 10:24:27 -0800 (PST)
MIME-Version: 1.0
References: <20191107114155.54307-1-mihail.atanassov@arm.com>
 <20191107114155.54307-6-mihail.atanassov@arm.com> <20191111155313.iiz37se2f7526ehp@e110455-lin.cambridge.arm.com>
 <39367348.R9gcQaf2xt@e123338-lin>
In-Reply-To: <39367348.R9gcQaf2xt@e123338-lin>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 12 Nov 2019 19:24:16 +0100
Message-ID: <CAKMK7uHB-mHmuBA-VkKuhUSRHQRu0wvHHJA+a=Q1fXSXaJgrpw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] drm/komeda: add rate limiting disable to err_verbosity
To:     Mihail Atanassov <Mihail.Atanassov@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>, nd <nd@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>,
        Brian Starkey <Brian.Starkey@arm.com>,
        David Airlie <airlied@linux.ie>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 2:00 PM Mihail Atanassov
<Mihail.Atanassov@arm.com> wrote:
>
> On Monday, 11 November 2019 15:53:14 GMT Liviu Dudau wrote:
> > On Thu, Nov 07, 2019 at 11:42:44AM +0000, Mihail Atanassov wrote:
> > > It's possible to get multiple events in a single frame/flip, so add a=
n
> > > option to print them all.
> > >
> > > Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@=
arm.com>
> > > Signed-off-by: Mihail Atanassov <mihail.atanassov@arm.com>
> >
> > For the whole series:
> >
> > Acked-by: Liviu Dudau <liviu.dudau@arm.com>
>
> Thanks, applied to drm-misc-next.

And now komeda doesn't even compile anymore. I'm ... impressed.

I mean generally people break other people's driver, not their own.
-Daniel

> >
> > Best regards,
> > Liviu
> >
> > > ---
> > >
> > >  v2: Clean up continuation line warning from checkpatch.
> > >
> > >  drivers/gpu/drm/arm/display/komeda/komeda_dev.h   | 2 ++
> > >  drivers/gpu/drm/arm/display/komeda/komeda_event.c | 2 +-
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/driver=
s/gpu/drm/arm/display/komeda/komeda_dev.h
> > > index d9fc9c48859a..15f52e304c08 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> > > @@ -224,6 +224,8 @@ struct komeda_dev {
> > >  #define KOMEDA_DEV_PRINT_INFO_EVENTS BIT(2)
> > >     /* Dump DRM state on an error or warning event. */
> > >  #define KOMEDA_DEV_PRINT_DUMP_STATE_ON_EVENT BIT(8)
> > > +   /* Disable rate limiting of event prints (normally one per commit=
) */
> > > +#define KOMEDA_DEV_PRINT_DISABLE_RATELIMIT BIT(12)
> > >  };
> > >
> > >  static inline bool
> > > diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_event.c b/driv=
ers/gpu/drm/arm/display/komeda/komeda_event.c
> > > index 7fd624761a2b..bf269683f811 100644
> > > --- a/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> > > +++ b/drivers/gpu/drm/arm/display/komeda/komeda_event.c
> > > @@ -119,7 +119,7 @@ void komeda_print_events(struct komeda_events *ev=
ts, struct drm_device *dev)
> > >     /* reduce the same msg print, only print the first evt for one fr=
ame */
> > >     if (evts->global || is_new_frame(evts))
> > >             en_print =3D true;
> > > -   if (!en_print)
> > > +   if (!(err_verbosity & KOMEDA_DEV_PRINT_DISABLE_RATELIMIT) && !en_=
print)
> > >             return;
> > >
> > >     if (err_verbosity & KOMEDA_DEV_PRINT_ERR_EVENTS)
> > > --
> > > 2.23.0
> > >
> >
> > --
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     =C2=AF\_(=E3=83=84)_/=C2=AF
> >
>
>
> --
> Mihail
>
>
>


--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
