Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C035C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11C1206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 21:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W6mljHLu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfLIVNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:13:47 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40991 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLIVNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 16:13:47 -0500
Received: by mail-ed1-f66.google.com with SMTP id c26so13997314eds.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 13:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3ZAoOzsHYMKfDXOLJj5uoHSZwKX72h4MMlTI4huTal4=;
        b=W6mljHLuB1QKV1MV560FwGm++i7fBoubbLgbVEpONn17GrKMZOmybDH/7jlbsGVJmF
         cp879E+659aMh57h7kPgtmnkyQuHcpDl3jf2dFvrI59xzf9qN0JyINOW+4off2ytUmFg
         vipqu0vE85k6VRLmuHb4RTlzBSBdUQ2ntpX4eF+Pqe8HW4KFElTi6WOVh+TSxIcXViAF
         781e16UvnUeECoulj5tle+AVoj03HcxVs6rhZvyUVfpxwoUH9gsz/mr+3zkYWdxOJRFi
         xv+Ep8bNh1aExYX2uvXo2KKVy1Su7+kQuKRdehk6TUmce/uJ9HIieHpmIcyEE/j36a/H
         jMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3ZAoOzsHYMKfDXOLJj5uoHSZwKX72h4MMlTI4huTal4=;
        b=LKLvKQ3jhnXruAcA1R/H/cLjNL4Mn7ZoxKJJ9UADbXomGAJz64fx/SUNAsty2b9q/S
         C+CpHI72j/IWAF48FjXpIPqfWV0ozEf2Q8hbfySH6PloJ2jix6+xpKWaKQytzrbOv1XZ
         VN/PzH4k06m8vXE1XE9Ygr5m3ZT2Z9ZquW68HERTYqzwPMnnrH04TN4rPXpAjAa6Yoqw
         A7f5cYPyVfg1E10reGlWLgB4i3msQEUHJnaJnLl9WkRbTEquiyhUt8Zt5xFeMNHuUC9f
         SqJxqEjr8BDOSeMkQlwnMsRPxyREFQtGrl5iSXardhopoY1/uQ/KN25Sfw7roc01fQmA
         y3pA==
X-Gm-Message-State: APjAAAUwiSyHplR1jUFAY3ziU2aDMNslz2wwt1W+wKrUq4x0pQQq8arp
        tGx/7D+wgix9jiFX6P//gJHriY0cI1Egp2dUjuOrxw==
X-Google-Smtp-Source: APXvYqwOeAYRIGSS28MDvsTD1YE5oXpHxeuznU/vT5+R7gO5Mglz7Raj8PezQmQSqkVPvEy14AyTNHoSNOZgO1CmTK8=
X-Received: by 2002:a50:fb08:: with SMTP id d8mr26688858edq.79.1575926025103;
 Mon, 09 Dec 2019 13:13:45 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <20191205071953.121511-2-wvw@google.com>
 <92311e54-8ae8-d9a5-2597-f2b9b447cfb5@linaro.org>
In-Reply-To: <92311e54-8ae8-d9a5-2597-f2b9b447cfb5@linaro.org>
From:   Wei Wang <wvw@google.com>
Date:   Mon, 9 Dec 2019 13:13:33 -0800
Message-ID: <CAGXk5yrvfJW62NHRHRJ4KtQEp5qxfr1V=R37kHMnkV9xgbEU3g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: prevent cooling device with no type to be registered
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 11:36 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 05/12/2019 08:19, Wei Wang wrote:
> > commit 54fa38cc2eda ("thermal: core: prevent zones with no types to be
> > registered") added logic to prevent thermal zone with empty type to be
> > registered. Similarly, there are APIs that rely on cdev->type.
> > This patch prevents cooling device without valid type to be registered.
> >
> > Signed-off-by: Wei Wang <wvw@google.com>
> > ---
> >  drivers/thermal/thermal_core.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_c=
ore.c
> > index d4481cc8958f..974e2d91c30b 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -954,12 +954,22 @@ __thermal_cooling_device_register(struct device_n=
ode *np,
> >       struct thermal_zone_device *pos =3D NULL;
> >       int result;
> >
> > -     if (type && strlen(type) >=3D THERMAL_NAME_LENGTH)
> > +     if (!type || !type[0]) {
>
> Why not use strlen(type) =3D=3D 0 ?

Checking empty is faster than getting length and this is already a
pattern used in this file:
https://github.com/torvalds/linux/blob/v5.4/drivers/thermal/thermal_core.c#=
L63



>
> > +             pr_err("Error: No cooling device type defined\n");
> >               return ERR_PTR(-EINVAL);
> > +     }
> > +
> > +     if (strlen(type) >=3D THERMAL_NAME_LENGTH) {
> > +             pr_err("Error: Cooling device name over %d chars: %s\n",
> > +                     THERMAL_NAME_LENGTH, type);
> > +             return ERR_PTR(-EINVAL);
> > +     }
> >
> >       if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> > -         !ops->set_cur_state)
> > +         !ops->set_cur_state) {
> > +             pr_err("Error: Cooling device missing callbacks: %s\n", t=
ype);
> >               return ERR_PTR(-EINVAL);
> > +     }
> >
> >       cdev =3D kzalloc(sizeof(*cdev), GFP_KERNEL);
> >       if (!cdev)
> > @@ -972,7 +982,7 @@ __thermal_cooling_device_register(struct device_nod=
e *np,
> >       }
> >
> >       cdev->id =3D result;
> > -     strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
> > +     strlcpy(cdev->type, type, sizeof(cdev->type));
> >       mutex_init(&cdev->lock);
> >       INIT_LIST_HEAD(&cdev->thermal_instances);
> >       cdev->np =3D np;
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
