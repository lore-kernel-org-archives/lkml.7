Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD72C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A1B22464
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 06:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buIieAhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfLEGO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 01:14:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38616 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfLEGO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 01:14:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id i6so490759edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 22:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pW0Hn3aQ9V6GllI+q5V9oU8MXeLBI73uZ2g1iNoE2vg=;
        b=buIieAhFdrFpxCNwtChiUsQhKQY9qRW1+zBlZUCnjwiZXOQRmaaixxYsBaCsYma2rl
         gkr9OLiC304ks0YXwxGL0tnCpWZFFrHBzLRFkOPXBEOIPeKERjnRdzC1VNSsjOkrnbIZ
         Yuykw0lMDgAaStLRoXRnSqLmVKuCzwve88JsjLjfBxzBq4x3950MfxG7GfCFJ9R38sTu
         +qewiulWTRBFToNmG4t/jHEN2iYOVqhz9V9kKdgDHrqFMvEZBEfYPNnERMon3IeBz4V9
         dFNjaRqsomnlWE8N0HZP1hZUE0g7ZsgxutYf6XNhq5K4bAfAdkf4dQ303nz2L1XaWNuj
         9B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pW0Hn3aQ9V6GllI+q5V9oU8MXeLBI73uZ2g1iNoE2vg=;
        b=glclIF93iPMV9DC4Aej1M0IKyYJRT0GEJLIaw6CYDL84WBkJ7eDuGlJOGse5ICymR+
         dq7/70iMN24u6agLqCLFs+cK7audMv0Yfp/F05EBMxOb9Avqxn4v7k3RR+X0rMHSr3zm
         mEh4mWksSDECaGRuLTwuaFxmItIOliJWFiPi1NarXOIotSTHpNSZNbF/it3/8aMGBsw0
         Qndm/43oHeAA2dDqx41BnH9g6ZWiJU00vpY86WyQnFMWbn1iezJbKMjM2aKS80uLvn+6
         sbrDq7N+7i5ShBppGsV1PycV0owu4OjEhvKvDVcooTymlroyRr2i6fCLcwY9U+qCBNzG
         Py9Q==
X-Gm-Message-State: APjAAAU4z4UcqeMLtUYBDC8OlYuPfTTrhx73U0HS5eKKEXcELe6r43tv
        66iylj3xtrE9B2/NAG/VOEjyT2476BjMgeYGZxAxeg==
X-Google-Smtp-Source: APXvYqw7d8F1qpjujLQr+hMsCC4yCQhw5rhoXxi8TQKlMf99CufmanhMNflSvr2iRngV4FLd1cz3dO9uvA8PvMWUwK4=
X-Received: by 2002:a17:906:3290:: with SMTP id 16mr7504457ejw.329.1575526465741;
 Wed, 04 Dec 2019 22:14:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHLCerOD2wOJq7QNGBOcLvkMz4wvc1+6Hk2+ZD__NFged3tLcw@mail.gmail.com>
 <20191204215618.125826-1-wvw@google.com> <20191204215618.125826-2-wvw@google.com>
 <CAHLCerMQ_734AFe=QCg+qi3TOvYPMB95NPP_EEHNbuODBSEfog@mail.gmail.com>
In-Reply-To: <CAHLCerMQ_734AFe=QCg+qi3TOvYPMB95NPP_EEHNbuODBSEfog@mail.gmail.com>
From:   Wei Wang <wvw@google.com>
Date:   Wed, 4 Dec 2019 22:14:14 -0800
Message-ID: <CAGXk5yr=jfXq+n7oB0sc=6LT0raURmQ9rgFWqrg0hxMDKYFDig@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] thermal: fix and clean up tz and cdev registration
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

On Wed, Dec 4, 2019 at 8:13 PM Amit Kucheria
<amit.kucheria@verdurent.com> wrote:
>
> Hi Wei,
>
> On Thu, Dec 5, 2019 at 3:26 AM Wei Wang <wvw@google.com> wrote:
> >
> > Make cooling device registration behavior consistent with
>
> Consistent how? Please add details.
>
Consistent with
https://lore.kernel.org/linux-pm/1478581767-7009-2-git-send-email-edubezval@gmail.com/

will include aboce in next version.

> > thermal zone. This patch also cleans up a unnecessary
> > nullptr check.
> >
> > Signed-off-by: Wei Wang <wvw@google.com>
> > ---
> >  drivers/thermal/thermal_core.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index d4481cc8958f..64fbb59c2f44 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -954,8 +954,16 @@ __thermal_cooling_device_register(struct device_node *np,
> >         struct thermal_zone_device *pos = NULL;
> >         int result;
> >
> > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH)
> > -               return ERR_PTR(-EINVAL);
> > +       if (!type || !type[0]) {
> > +           pr_err("Error: No cooling device type defined\n");
> > +           return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> > +           pr_err("Error: Cooling device name (%s) too long, "
> > +                  "should be under %d chars\n", type, THERMAL_NAME_LENGTH);
>
> Consider fitting into a single greppable string as "Error: Cooling
> device name over %d chars: %s\n"
>
Was intentionally keep it the same as this
https://lore.kernel.org/linux-pm/31a29628894a14e716fff113fd9ce945fe649c05.1562876950.git.amit.kucheria@linaro.org/
Will make it shorter in both places next verion

> > +           return ERR_PTR(-EINVAL);
> > +       }
> >
> >         if (!ops || !ops->get_max_state || !ops->get_cur_state ||
> >             !ops->set_cur_state)
> > @@ -972,7 +980,7 @@ __thermal_cooling_device_register(struct device_node *np,
> >         }
> >
> >         cdev->id = result;
> > -       strlcpy(cdev->type, type ? : "", sizeof(cdev->type));
> > +       strlcpy(cdev->type, type, sizeof(cdev->type));
> >         mutex_init(&cdev->lock);
> >         INIT_LIST_HEAD(&cdev->thermal_instances);
> >         cdev->np = np;
> > @@ -1250,7 +1258,7 @@ thermal_zone_device_register(const char *type, int trips, int mask,
> >                 return ERR_PTR(-EINVAL);
> >         }
> >
> > -       if (type && strlen(type) >= THERMAL_NAME_LENGTH) {
> > +       if (strlen(type) >= THERMAL_NAME_LENGTH) {
> >                 pr_err("Error: Thermal zone name (%s) too long, should be under %d chars\n",
> >                        type, THERMAL_NAME_LENGTH);
> >                 return ERR_PTR(-EINVAL);
> > --
> > 2.24.0.393.g34dc348eaf-goog
> >
