Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976C9C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E952245C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="ITISbBJ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbfLEG0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:26:46 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37894 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfLEG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:26:46 -0500
Received: by mail-vs1-f68.google.com with SMTP id y195so1593999vsy.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 22:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nbsCBqwsoBQXn99gJ7FljzhWrqwsgKc0+d7eAwdfQaY=;
        b=ITISbBJ610JApEniCUhf+PkDIWuBE7EiRPGPHRI/MTRnhIc75kBMw3m1t5rrxjxziF
         8mw4DTCvU0tJdqBFD5PV4ZOoTcPVg9OOgUu02BoQsZb78CSF8zUxqKRN7JlcSiyxJgzS
         LVA47BKUFiwdm1bbmlDRPrd34zR978vDhmIQJT5ubb27U6VWsy8sFFSlL+jjb+76Ydbs
         mCBmh27e0L7OGEi53LLMHyYZaOr9NRXEgWSrAqX1ZykcvALC70chpghNRYOEMZB75mS3
         nWEEjrM/m8jSjKpd/23qvsWY95zJnSKDyIQEIxbaN+ggnryy31aDmba4hnnLK4XOFmp7
         mVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nbsCBqwsoBQXn99gJ7FljzhWrqwsgKc0+d7eAwdfQaY=;
        b=WI520vEKg+oi14ogHU7O+D6ShbYG9ltdeA8fc8qgPWRGITsNY/xlPKTWWrVWmwvKLt
         XHVg1rzlAal2SXUZNiEGnZM4c5rG/4XdrXcu5FBg38nOtSEQowKPyqnUqvzXGpTCopzl
         nZ2sO67BXqxh/HzeGCov/ngSTb4VSm9sTLYpLKU7yLHjEGbvp+aXzJCYVdQnXxsUadFY
         wCNCGDk+0uyZocE1SagaDMzmdySE4jMVtRnCp8yx/K+rlyZn3la3grVHYGLEk8d3zdIz
         wQS/z1FaG5YZC3uUquJfdHvBmWiUPGtsfw46D93jnbWgmwVKpTQPdzbszqN7jkSj3JQK
         cppw==
X-Gm-Message-State: APjAAAWEzzrmvuzkC9wBwQECgOLMo/6075bVeNH5Y5tBmBLqOijkPUUm
        PMZpDqfPbpe2b6YeZ1yWIN1TsuhRwZVnj8MWzQVzfA==
X-Google-Smtp-Source: APXvYqyXHr50QT0eU4yDVmAv5OzLz5SDyDjNk45ZhtYF8ue+AOqm36+XKwU2LGd5x6NGtH2m14Vl6om+BywczCIyMeg=
X-Received: by 2002:a67:f8cf:: with SMTP id c15mr4520755vsp.27.1575527204383;
 Wed, 04 Dec 2019 22:26:44 -0800 (PST)
MIME-Version: 1.0
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
 <20191204215618.125826-1-wvw@google.com> <20191204215618.125826-2-wvw@google.com>
 <CAHLCerMQ_734AFe=QCg+qi3TOvYPMB95NPP_EEHNbuODBSEfog@mail.gmail.com> <CAGXk5yr=jfXq+n7oB0sc=6LT0raURmQ9rgFWqrg0hxMDKYFDig@mail.gmail.com>
In-Reply-To: <CAGXk5yr=jfXq+n7oB0sc=6LT0raURmQ9rgFWqrg0hxMDKYFDig@mail.gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Thu, 5 Dec 2019 11:56:33 +0530
Message-ID: <CAHLCerOpv3Dqd7AB6=EEUUMpTWujNeLok3=ZpLntCdvHewGyww@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: fix and clean up tz and cdev registration
To:     Wei Wang <wvw@google.com>
Cc:     Wei Wang <wei.vince.wang@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 5, 2019 at 11:44 AM Wei Wang <wvw@google.com> wrote:
>
> On Wed, Dec 4, 2019 at 8:13 PM Amit Kucheria
> <amit.kucheria@verdurent.com> wrote:
> >
> > Hi Wei,
> >
> > On Thu, Dec 5, 2019 at 3:26 AM Wei Wang <wvw@google.com> wrote:
> > >
> > > Make cooling device registration behavior consistent with
> >
> > Consistent how? Please add details.
> >
> Consistent with
> https://lore.kernel.org/linux-pm/1478581767-7009-2-git-send-email-edubezval@gmail.com/
>
> will include aboce in next version.

Thanks.

>
> > > thermal zone. This patch also cleans up a unnecessary
> > > nullptr check.
> > >
> > > Signed-off-by: Wei Wang <wvw@google.com>
> > > ---
> > >  drivers/thermal/thermal_core.c | 16 ++++++++++++----
> > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > > index d4481cc8958f..64fbb59c2f44 100644
> > > --- a/drivers/thermal/thermal_core.c
> > > +++ b/drivers/thermal/thermal_core.c
> > > @@ -954,8 +954,16 @@ __thermal_cooling_device_register(struct device_node *np,
> > >         struct thermal_zone_device *pos = NULL;
> > >         int result;
> > >
> > > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > > -               return ERR_PTR(-EINVAL);
> > > +       if (!type || !type[0]) {
> > > +           pr_err("Error: No cooling device type defined\n");
> > > +           return ERR_PTR(-EINVAL);
> > > +       }
> > > +
> > > +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> > > +           pr_err("Error: Cooling device name (%s) too long, "
> > > +                  "should be under %d chars\n", type, THERMAL_NAME_LENGTH);
> >
> > Consider fitting into a single greppable string as "Error: Cooling
> > device name over %d chars: %s\n"
> >
> Was intentionally keep it the same as this
> https://lore.kernel.org/linux-pm/31a29628894a14e716fff113fd9ce945fe649c05.1562876950.git.amit.kucheria@linaro.org/
> Will make it shorter in both places next verion

Yes please, make it a separate patch. We didn't catch it during review.

>
> > > +           return ERR_PTR(-EINVAL);
> > > +       }
> > >
> > >         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> > >             !ops->set_cur_state)
> > > @@ -972,7 +980,7 @@ __thermal_cooling_device_register(struct device_node *np,
> > >         }
> > >
> > >         cdev->id = result;
> > > -       strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
> > > +       strlcpy(cdev->type, type, sizeof(cdev->type));
> > >         mutex_init(&cdev->lock);
> > >         INIT_LIST_HEAD(&cdev->thermal_instances);
> > >         cdev->np = np;
> > > @@ -1250,7 +1258,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
> > >                 return ERR_PTR(-EINVAL);
> > >         }
> > >
> > > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> > > +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> > >                 pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
> > >                        type, THERMAL_NAME_LENGTH);
> > >                 return ERR_PTR(-EINVAL);
> > > --
> > > 2.24.0.393.g34dc348eaf-goog
> > >
