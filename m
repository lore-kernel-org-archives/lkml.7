Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6645C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00DD218D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:51:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBJgJ3JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfDWWvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:51:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33557 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfDWWvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:51:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id d55so14189036ede.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Azihi0+y+0A9GqQQKlVvEfb9wIg0Y4clL04ZCREwPkY=;
        b=DBJgJ3JFtWrhy6k9uAuDJH1eTtTuqdpkfE62I2fdCmymaSazbsb9HkLkhe+94dUSHL
         dPdG0lEPRDlK9G005sQJCiSAlaDdUS9TGpd731NTC/aKLaDjl4W6ulM+cRg9wbJd27PK
         bsXEsFTcqn8gNGHcaS78nfgzY4dw5UjEvmrvpRsUiVTL5+CAogclUPigxD8sO1ehHi/d
         fBESRTO6Ts73/CXNm7xcFe5t/NHJg7ew8COCVnivHCbOlZQJKBw/w1bpi1B5Dt7aWcQt
         Uu1F7Fs2caWVvLGN9CCf7Ii+nbQmpir9ZzZQc5SUEWG+v9mPFZkj8ba5ibmYYydO1STg
         /3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Azihi0+y+0A9GqQQKlVvEfb9wIg0Y4clL04ZCREwPkY=;
        b=dJhwPW7Iq16r4IK2hj0ClgflwPsDKXmTdXJzCUCb5dnISV8VMfSHdegxOkd9+ntnAb
         lS8VyBPX83ltfnqqpIvL0Iy8EHpfoSzVy+5cgBoLAQpLgl5QKp0TZlU1wmxNom/RKrho
         Eihs45cnYJU1x/tAyn147j9SfMQsBWihNbpI8JEfJxNrMd2jYA4hCA5Sagt6dH1oR1nH
         sNlZjMCKGa9P6GxLdFQFShTGlTNPq78XHKONAcYdPGv1lLDgqthUYLhiWmGSwnycZZ2n
         gEMuUrZIW49dQ65p5yNE36/jPuLqiFlLtFzwE5Bgymj6kVrCY3BUDRc6TlFnu5eyTjzt
         tcXA==
X-Gm-Message-State: APjAAAUmr4snBeAuop63RJ+vueetFES98jdcKwtk0H+A2kSSMIEl086N
        BoKWXtn9ajGWpeVbLAsNLUInymKJEskV8vCKOtFLUQ==
X-Google-Smtp-Source: APXvYqzAgWSvFmwXvZqHU/FHFza7GHyetVHeAnFJmJCXz5ucFwqzPKxmGeB1UPL7/LK2EWoMsV3eqS7yhFuHHd/5b0s=
X-Received: by 2002:a50:b265:: with SMTP id o92mr18010685edd.221.1556059867217;
 Tue, 23 Apr 2019 15:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190416170701.50333-1-wvw@google.com> <1555923800.26198.30.camel@intel.com>
 <CAGXk5yoXgzYyK9eJMHietgqPqyT_QHXAby6+G_fSwXL-tKfd=Q@mail.gmail.com> <1556000129.26198.50.camel@intel.com>
In-Reply-To: <1556000129.26198.50.camel@intel.com>
From:   Wei Wang <wvw@google.com>
Date:   Tue, 23 Apr 2019 15:50:53 -0700
Message-ID: <CAGXk5ypj0ULM6mN1ZUYZimuf+7DV3BrN9wJWTm2G27OrizjzwA@mail.gmail.com>
Subject: Re: [PATCH] thermal: core: skip update disabled thermal zones after suspend
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 11:15 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On =E4=B8=80, 2019-04-22 at 09:44 -0700, Wei Wang wrote:
> > On Mon, Apr 22, 2019 at 2:03 AM Zhang Rui <rui.zhang@intel.com>
> > wrote:
> > >
> > >
> > > On =E4=BA=8C, 2019-04-16 at 10:07 -0700, Wei Wang wrote:
> > > >
> > > > It is unnecessary to update disabled thermal zones post suspend
> > > > and
> > > > sometimes leads error/warning in bad behaved thermal drivers.
> > > >
> > > a good catch, and in fact, there are more issues about thermal
> > > handling
> > > for disabled thermal zones, like we're able to read the temperature
> > > of
> > > disabled thermal zones, either via sysfs or via function calls like
> > > thermal_zone_device_update.
> > Thanks Rui for following up. Yes, we noticed the same behavior. Right
> > now, individual thermal driver can still respect set_mode and present
> > value meaningful or return error when thermal zone disabled, and
> > that's what we do locally.
> > Currently, sysfs-api documents "Preventing kernel thermal zone driver
> > actions upon trip points so that user application can take full
> > charge
> > of the thermal management.", so is it intended for some other agents
> > in kernel or user land polling temperature with function call or
> > sysfs
> > respectively?
>
> hmmm, here we have three cases,
> 1). we can read the temperature and we can take cooling actions.
> 2). we can read the temperature only
> 3). we can not read the temperature
>
> we do have a case for 3), e.g. the wifi device, which registers a
> thermal zone, but it does not work if wifi firmware is unloaded. And
> IMO, we should set the thermal zone mode to disable for this case.

Agree.

Another thought of suspend/resume case is in mobile world, most of the
thermal zone sensors are interrupt capable and the linked cooling
devices are platform cooling devices whose states won't be affected
during suspend.  So resetting each thermal zone during suspend/resume
just wasted cycles/power on mobile due to re-setting trip threshold
again and again and also delays in device resume. I am proposing that
we have a flag in device tree per thermal zone to let thermal core not
reset during suspend/resume.

> I'm not sure if there is any case for 2), but if we do, it seems to me
> that we should set its governor to nop, rather then the way we're
> describing in the sys-abi file.
+1 noop sounds good. Do you have plan to change it?

>
> we should fix the code and doc to use "mode" attribute to handle case
> 3) instead.
>
> thanks,
> rui
> >
> > Thanks!
> > -Wei
> > >
> > > For this patch, I will take it as it fixes one of the problem.
> > >
> > > thanks,
> > > rui
> > >
> > > >
> > > > Signed-off-by: Wei Wang <wvw@google.com>
> > > > ---
> > > >  drivers/thermal/thermal_core.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > >
> > > > diff --git a/drivers/thermal/thermal_core.c
> > > > b/drivers/thermal/thermal_core.c
> > > > index 6590bb5cb688..5baf5cfab999 100644
> > > > --- a/drivers/thermal/thermal_core.c
> > > > +++ b/drivers/thermal/thermal_core.c
> > > > @@ -1494,6 +1494,7 @@ static int thermal_pm_notify(struct
> > > > notifier_block *nb,
> > > >                            unsigned long mode, void *_unused)
> > > >  {
> > > >       struct thermal_zone_device *tz;
> > > > +     enum thermal_device_mode tz_mode;
> > > >
> > > >       switch (mode) {
> > > >       case PM_HIBERNATION_PREPARE:
> > > > @@ -1506,6 +1507,13 @@ static int thermal_pm_notify(struct
> > > > notifier_block *nb,
> > > >       case PM_POST_SUSPEND:
> > > >               atomic_set(&in_suspend, 0);
> > > >               list_for_each_entry(tz, &thermal_tz_list, node) {
> > > > +                     tz_mode =3D THERMAL_DEVICE_ENABLED;
> > > > +                     if (tz->ops->get_mode)
> > > > +                             tz->ops->get_mode(tz, &tz_mode);
> > > > +
> > > > +                     if (tz_mode =3D=3D THERMAL_DEVICE_DISABLED)
> > > > +                             continue;
> > > > +
> > > >                       thermal_zone_device_init(tz);
> > > >                       thermal_zone_device_update(tz,
> > > >                                                  THERMAL_EVENT_UN
> > > > S
> > > > PECIFIED);
