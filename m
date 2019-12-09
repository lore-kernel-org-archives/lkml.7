Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D340FC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A842420836
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQTZrrf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfLIRep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:34:45 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36681 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfLIRep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:34:45 -0500
Received: by mail-ed1-f67.google.com with SMTP id j17so13425734edp.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 09:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MqGWgekCxDubwDbyQN/6yZHuFRZ1dg3jUzpNTfM9+xY=;
        b=gQTZrrf4vN8IBztt71aOzBZf8fdXSZ0eVtga7ZrfIAjwHB+D4J+M5Gc6L1lqW8B1ed
         2hCTiPcUFtkv1eE5pJ8WY5g1/EQiv133HBNom2s1cRHxGXsQzapUnWhENnTMW88DS0V0
         X+MOu2GLoqpNrLhY1i9kD/6WjHXWDUd8rL4Okz0SphkUCDd3igh/0rzDdH9xY6iggk97
         n/J4eEH161Cj05AB/ESQ2pCmsWfJ3Or66VZdoF6TJJXvpqjWGTkobDE7Z+WOwP/P33vo
         1/r0SEQ509ttPWpW6Ir9mHvPzwSGe+e9bwI+Xks5GVVqRrLSU/BcZlXHZ9zeFuYKsGKH
         sbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MqGWgekCxDubwDbyQN/6yZHuFRZ1dg3jUzpNTfM9+xY=;
        b=Z+6S2JUU9Lrw+2eDHOwAfW4L7oA/lyGcnvmhBNKs4E8h6blc79nL2yG8+/pkFQs5wq
         xhXSCfc3jk+Xms6aVwuJvvdZjFJheeRu4oz+76BCNQ+QE8632rskMHyYyRpXaMbHPNmF
         jI24Zm1/2i96R0ap0wKj9tckVHgPK2QBeKxIQrtFHwDeMsmEOoE72u/1GBBuGQz0edi3
         awzYJqqZJQxm1kyw9h2TESfRNqmSWAgZ8yCrpRT3nUL+VnG/ip5WRwd3RImG7XFze8Rw
         MWSHL12glD6QGpk8WIntxJEStQcQDssAd6fSd98hR+qsHEge/QT7BoygGCbOyzT77Qlx
         QGbg==
X-Gm-Message-State: APjAAAWo8S3Um4Tu2s5XcOrzCH648mmSvIW8zLo3Sq7Myy/GBRf5Zd5s
        nGIpHcDo8E/kkVUejyrvzm71hpXQm+xNeelLlb8uPg==
X-Google-Smtp-Source: APXvYqxbnJ4K1dmT7UAnkHHGB8sYwJAHvtz+y4Cpn1GujHOMPOb23yrCn28dziXqoH6a2Nzeh2ZTilyr6s+P03U6XxU=
X-Received: by 2002:a17:906:4881:: with SMTP id v1mr9011744ejq.329.1575912882849;
 Mon, 09 Dec 2019 09:34:42 -0800 (PST)
MIME-Version: 1.0
References: <20191205071953.121511-1-wvw@google.com> <20191205071953.121511-2-wvw@google.com>
 <CAHLCerOFUTrg+sJJVaP0wpRErhDdfNebfM4OAOepH4RfXopvQg@mail.gmail.com>
In-Reply-To: <CAHLCerOFUTrg+sJJVaP0wpRErhDdfNebfM4OAOepH4RfXopvQg@mail.gmail.com>
From:   Wei Wang <wvw@google.com>
Date:   Mon, 9 Dec 2019 09:34:31 -0800
Message-ID: <CAGXk5yox+g4U-g22_+UqEOLHzpn+TZFmuPmehUNBk5SWpvNpzQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] thermal: prevent cooling device with no type to be registered
To:     Amit Kucheria <amit.kucheria@verdurent.com>
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

On Sun, Dec 8, 2019 at 11:41 PM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> On Thu, Dec 5, 2019 at 12:50 PM Wei Wang <wvw@google.com> wrote:
> >
> > commit 54fa38cc2eda ("thermal: core: prevent zones with no types to be
> > registered") added logic to prevent thermal zone with empty type to be
> > registered. Similarly, there are APIs that rely on cdev->type.
> > This patch prevents cooling device without valid type to be registered.
> >
> > Signed-off-by: Wei Wang <wvw@google.com>
>
> Looks better now. Thanks.
>

Thanks Amit for the review and testing.

> Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>
> Tested-by: Amit Kucheria <amit.kucheria@linaro.org>
>
> > ---
> >  drivers/thermal/thermal_core.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index d4481cc8958f..974e2d91c30b 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -954,12 +954,22 @@ __thermal_cooling_device_register(struct device_node *np,
> >         struct thermal_zone_device *pos = NULL;
> >         int result;
> >
> > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > +       if (!type || !type[0]) {
> > +               pr_err("Error: No cooling device type defined\n");
> >                 return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> > +               pr_err("Error: Cooling device name over %d chars: %s\n",
> > +                       THERMAL_NAME_LENGTH, type);
> > +               return ERR_PTR(-EINVAL);
> > +       }
> >
> >         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> > -           !ops->set_cur_state)
> > +           !ops->set_cur_state) {
> > +               pr_err("Error: Cooling device missing callbacks: %s\n", type);
> >                 return ERR_PTR(-EINVAL);
> > +       }
> >
> >         cdev = kzalloc(sizeof(*cdev), GFP_KERNEL);
> >         if (!cdev)
> > @@ -972,7 +982,7 @@ __thermal_cooling_device_register(struct device_node *np,
> >         }
> >
> >         cdev->id = result;
> > -       strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
> > +       strlcpy(cdev->type, type, sizeof(cdev->type));
> >         mutex_init(&cdev->lock);
> >         INIT_LIST_HEAD(&cdev->thermal_instances);
> >         cdev->np = np;
> > --
> > 2.24.0.393.g34dc348eaf-goog
> >
