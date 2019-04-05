Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624E1C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B3721738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEKEA6Ah"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbfDESiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:38:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44323 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731087AbfDESiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:38:14 -0400
Received: by mail-io1-f68.google.com with SMTP id u12so5802312iop.11;
        Fri, 05 Apr 2019 11:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sS1MDVcP9r8rd8f/Exb154TT9Pe2vw4MwASpFoeBNoE=;
        b=OEKEA6AhIGiHUXjs6I7gxdrB+jYBDwbuCuSyfNVLfU4hksvGGpA32eKnlzBNd9fpO0
         vbhqYnmEZhy2ixp9GeK+ssXiKDBgLpuIKENghfC+N3WSDFw5uSz0XvLUy0bMR3rckAsW
         CFYvoM9TbEIOIROpsBi5rcDWJI9bwwa3KmrULyAODt6nl8nktSYfOoAK6yKMzPH1Uc5f
         NQaCm1+3A/Zn41WhspyJ2D2ALL6dvk0ZEvWdh6HeiQfErIkQIYZLTWOF3CnrIJj74zqj
         5JCh1JH+zUoyMalK4pMhP57ijCmvMr/cNVf1I07JOXUcAm9fTZuIJ4uIEDQi82+phMwi
         jMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sS1MDVcP9r8rd8f/Exb154TT9Pe2vw4MwASpFoeBNoE=;
        b=YQa3c9uHoDW2gWXqCOLCtZjJMWrVKkRDq1tHtz4ltDl8wKakpC4LRwal3hb8c/fKkj
         ZyPBYcChT0aFo+cPRQqTbouFbil5CsbL7+2ewY7BlMoaT6yHRxQedtXrkyhlIMrOiZBo
         HuyOejAYcTlh4m+hcCjsO686Wsmo9FDMSvKHWtx545FmzRaE9j9trDhEhJ8zGRdIj5b8
         q/FKrGr9KdWpHG2cEP33H0/sMAwric+gOlmstirBGFB0m8i9N5uTqzIFhNVYYsGkoMvr
         ACvBvGrUarw3fhTxaEdVQN08gDZtO+M2bwCoP3AYIp2fXqRwC4UVTLlP0Mp1CM8XdZy/
         hrrw==
X-Gm-Message-State: APjAAAXAvW8LMiCYzVPh4+02FxYKC6hAQ91yeYCLWIzG6MBDB3M+Qb8H
        GAjbCZiVH0ZOwLgLumIRBG6se8VUfsoli7KwCYr/lA==
X-Google-Smtp-Source: APXvYqyG4F6Lt0S/J6prNWk5ZrnsCexXsN05mCC3c0beC1gZM21C9BbV+FPlU1z50dSBj2sxY+LYzTWaMw2JPAq4Bvo=
X-Received: by 2002:a6b:c981:: with SMTP id z123mr8934997iof.123.1554489493162;
 Fri, 05 Apr 2019 11:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190401041418.5999-1-andrew.smirnov@gmail.com>
 <20190401041418.5999-14-andrew.smirnov@gmail.com> <4c6ef4cb-8214-cda6-bfa9-8f0887fc2170@linaro.org>
In-Reply-To: <4c6ef4cb-8214-cda6-bfa9-8f0887fc2170@linaro.org>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Fri, 5 Apr 2019 11:38:00 -0700
Message-ID: <CAHQ1cqGfRCCD0vL+6xUWnHyL2FPQhMB=2f6nkdQ0wTWXZR0NCA@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] thermal: qoriq: Add hwmon support
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Eduardo Valentin <edubezval@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        dl-linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 2:12 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 01/04/2019 06:14, Andrey Smirnov wrote:
> > Expose thermal readings as a HWMON device, so that it could be
> > accessed using lm-sensors.
> >
> > Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> > Cc: Chris Healy <cphealy@gmail.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: Eduardo Valentin <edubezval@gmail.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Angus Ainslie (Purism) <angus@akkea.ca>
> > Cc: linux-imx@nxp.com
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  drivers/thermal/qoriq_thermal.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> > index 9d227654f879..7fb9321a0d8c 100644
> > --- a/drivers/thermal/qoriq_thermal.c
> > +++ b/drivers/thermal/qoriq_thermal.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/thermal.h>
> >
> >  #include "thermal_core.h"
> > +#include "thermal_hwmon.h"
> >
> >  #define SITES_MAX    16
> >
> > @@ -103,7 +104,10 @@ static int qoriq_tmu_register_tmu_zone(struct device *dev,
> >               case -ENODEV:
> >                       continue;
> >               case 0:
> > -                     break;
> > +                     ret = devm_thermal_add_hwmon_sysfs(tzd);
> > +                     if (!ret)
> > +                             break;
> > +                     /* fallthrough */
>
> Do we really want to disable the thermal zone if the hwmon fails to
> register ?

Original code already disables all thermal zones if any single one
fails to register, so I though we may as well be as strict for hwmon
registration as well. Doesn't have to be though. Will change in v4.

Thanks,
Andrey Smirnov
