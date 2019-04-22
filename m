Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7B4C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7D420859
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qoaKDLJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbfDVQoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:44:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38541 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfDVQoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:44:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id c1so3974649edk.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 09:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ebT1zd4br27smf6EZfBkxJgHdh7UMLcjjUXNrZyZOT8=;
        b=qoaKDLJKDRDOLrUU1AMfafnGpgw5ntc5sL4OzwAdUD9UBmbl7AExjhkEGTNfY6XeU0
         QQz5nKk/lTZnDs1SPLSXvCfySEq8bMWDBtdnYpckG33aRLTmmzae/a/9d/aff78DXQyI
         ns3VXRWSR/ZycgsZVnPpeuYksYLvN1TxZNuEXIHPslOPQ3Q9FJJXzul+gh+z3j7U+Wjp
         TjZ/Ccxg4j1GFxgdHsmv/QTrk8z3O7p5C6USfDs/xxrjPUNZV4PNIAO3GRDjo3dSpjti
         Js/nGX73UByJQlxW/0RpL/88hum1P+lztKC3LfJUnlaKaCzO3gsKC/stEA+rV2pUKnap
         2W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ebT1zd4br27smf6EZfBkxJgHdh7UMLcjjUXNrZyZOT8=;
        b=RQsb2RB/RJ8YrcYJxVr26WEfyxKsi7bd9XWUMLfdA3XhdEo7NUotuAX9fbfRI/58ug
         1pJpNZWvreYAbmsh6tFsENFQGtrn++b2XgsZk9m/6y7SxZKgKv9O/AuhGYtRoGN4GWjk
         rGiVrnYwlmSgVtIM0PkoKxZfhisrMEM44Nf20OPt/3DNMx68IXESFN80lh5UGIx3Tbct
         AwB7hx4TU6BwDmsUFVaMNZQW126Ik4DqeJuRN/kyI6Sf8WZHSG5W0jU2d+z0pM74jxEo
         yYqcM+SrnBbH1mePEZW28y2tOy4RqDzdWnsQVZYyzHV4RiJ65PYSXVXd5h8NvaJ7uRwN
         Yuhg==
X-Gm-Message-State: APjAAAVXHpGK/WKjMWiqG30ut4VAZAan0t34UdRUazDDnEyDKpeavrMN
        x766s3afbLPlddsEa5X6cr7cbF6SJjoh1EeGdoITHg==
X-Google-Smtp-Source: APXvYqy8WG5Ky42+WKuzAypEhyjWGI+ixmX4Ua2v+4AbrT0/ud6RhLx9M3ZifZz7+ve/4miI62XJdAaBebiUOJfu02o=
X-Received: by 2002:a17:906:4b10:: with SMTP id y16mr10098502eju.19.1555951452181;
 Mon, 22 Apr 2019 09:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190416170701.50333-1-wvw@google.com> <1555923800.26198.30.camel@intel.com>
In-Reply-To: <1555923800.26198.30.camel@intel.com>
From:   Wei Wang <wvw@google.com>
Date:   Mon, 22 Apr 2019 09:44:01 -0700
Message-ID: <CAGXk5yoXgzYyK9eJMHietgqPqyT_QHXAby6+G_fSwXL-tKfd=Q@mail.gmail.com>
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

On Mon, Apr 22, 2019 at 2:03 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> On =E4=BA=8C, 2019-04-16 at 10:07 -0700, Wei Wang wrote:
> > It is unnecessary to update disabled thermal zones post suspend and
> > sometimes leads error/warning in bad behaved thermal drivers.
> >
> a good catch, and in fact, there are more issues about thermal handling
> for disabled thermal zones, like we're able to read the temperature of
> disabled thermal zones, either via sysfs or via function calls like
> thermal_zone_device_update.
Thanks Rui for following up. Yes, we noticed the same behavior. Right
now, individual thermal driver can still respect set_mode and present
value meaningful or return error when thermal zone disabled, and
that's what we do locally.
Currently, sysfs-api documents "Preventing kernel thermal zone driver
actions upon trip points so that user application can take full charge
of the thermal management.", so is it intended for some other agents
in kernel or user land polling temperature with function call or sysfs
respectively?

Thanks!
-Wei
> For this patch, I will take it as it fixes one of the problem.
>
> thanks,
> rui
>
> > Signed-off-by: Wei Wang <wvw@google.com>
> > ---
> >  drivers/thermal/thermal_core.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c
> > index 6590bb5cb688..5baf5cfab999 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -1494,6 +1494,7 @@ static int thermal_pm_notify(struct
> > notifier_block *nb,
> >                            unsigned long mode, void *_unused)
> >  {
> >       struct thermal_zone_device *tz;
> > +     enum thermal_device_mode tz_mode;
> >
> >       switch (mode) {
> >       case PM_HIBERNATION_PREPARE:
> > @@ -1506,6 +1507,13 @@ static int thermal_pm_notify(struct
> > notifier_block *nb,
> >       case PM_POST_SUSPEND:
> >               atomic_set(&in_suspend, 0);
> >               list_for_each_entry(tz, &thermal_tz_list, node) {
> > +                     tz_mode =3D THERMAL_DEVICE_ENABLED;
> > +                     if (tz->ops->get_mode)
> > +                             tz->ops->get_mode(tz, &tz_mode);
> > +
> > +                     if (tz_mode =3D=3D THERMAL_DEVICE_DISABLED)
> > +                             continue;
> > +
> >                       thermal_zone_device_init(tz);
> >                       thermal_zone_device_update(tz,
> >                                                  THERMAL_EVENT_UNS
> > PECIFIED);
