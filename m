Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AADCC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E98232081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paB+UUDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCHVXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:23:54 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39111 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCHVXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:23:54 -0500
Received: by mail-pg1-f196.google.com with SMTP id h8so15096329pgp.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 13:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yWWq+S2SctGM3+XFGJawidQ/wULPoNDkk/2RDu6ScBM=;
        b=paB+UUDJrxcbiEybxdAfOYYGnEB6Z8YzEp/krMloy0uzScn1w28EDGMFnESv9f6FiQ
         oXijgzJMu9SCWiOX/Es8UcZP0GMMO09MNCHvwT7oFD8CJOaGe9XxJZpN7TD179frW65I
         Zg7Bi4Z7jCWEWPzarBP43KCCfSrUPQVeDYlEwImyIAXJALCBdvy35f2VT5YmBZWVOZks
         yty26ihl+PESu41tFMknkm4ZHcUdEKbgVdhH/4ByBl5mjJmYES7N89koAN1aNL86yJE/
         ug6EyK1pAcpwZgYEuD6WWQ/18UxPi3agOgU4Vb6oqywRB679PD4I40FCdnSs0fyevPX1
         LmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yWWq+S2SctGM3+XFGJawidQ/wULPoNDkk/2RDu6ScBM=;
        b=KbJGK7VoUdhcyiVBV0YH2vWNRr1pBo93fQyRTyypyIDFF1x8I4Jth1RER/Puz/Xym4
         I5fgZdbWzLB7lvFcmY++7/FLiPFUMLdiVLZZiybQTo/xPH9CuPlE5dR1ZykcdU5PkCP8
         YnGC9QUH18FB3Caqka81PRyFk7+7FJwVQu5OXiaSGbw3fwE1JPKpAQ9kGDKT/pU/ypxO
         yJs4kdI7wxAvarqYyOz3I8JZDzdRAdytQsB7ozxVbikOyQ5xjXdjSxzMUJFk+eb1AtOO
         nRocJqpHOhC6zOORXLcepIewGaP6vO791SCUysjxIVJctmqsoypRNbSi3uI/nDKTFM/R
         VfZg==
X-Gm-Message-State: APjAAAXIVG9bK5MfFiV1VOFXi2gfwMqWqoCuSZ6PAsdMwAg/Wf0zY35d
        GtuGhEHDlJwRyoL87dYYHIUBTDPzPi047pFvrjfwZg==
X-Google-Smtp-Source: APXvYqwyW61lOi2Uwi9G05MbhbTWQZKJwE1Zayn1ENNw6IDV5it9f+iVbvMAAOCMBEWWB4dEptZ2K9gt6G3l921NmHk=
X-Received: by 2002:a17:902:56a:: with SMTP id 97mr20763694plf.320.1552080233008;
 Fri, 08 Mar 2019 13:23:53 -0800 (PST)
MIME-Version: 1.0
References: <20190307223628.21270-1-natechancellor@gmail.com>
 <20190308085316.7eaynrb746o6xsz7@pengutronix.de> <CAKwvOdmA6=_-_uC8PAC8i+-mLA8FN6GOeY544139N2AsA8RbsQ@mail.gmail.com>
 <20190308211852.wnhivsnlwhr4kqn3@pengutronix.de>
In-Reply-To: <20190308211852.wnhivsnlwhr4kqn3@pengutronix.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 13:23:41 -0800
Message-ID: <CAKwvOd=W0MKF_bYtgCOz2hH+RvpZPJawcaBnR2YkcBTP_NZHuA@mail.gmail.com>
Subject: Re: [PATCH] pwm: img: Turn final 'else if' into 'else' in img_pwm_config
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 8, 2019 at 1:18 PM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Fri, Mar 08, 2019 at 10:38:11AM -0800, Nick Desaulniers wrote:
> > On Fri, Mar 8, 2019 at 12:53 AM Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Thu, Mar 07, 2019 at 03:36:28PM -0700, Nathan Chancellor wrote:
> > > > When building with -Wsometimes-uninitialized, Clang warns:
> > > >
> > > > drivers/pwm/pwm-img.c:126:13: error: variable 'timebase' is used
> > > > uninitialized whenever 'if' condition is false
> > > > [-Werror,-Wsometimes-uninitialized]
> > > >
> > > > The final else if functions as an else; make that explicit so that =
Clang
> > > > understands that timebase cannot be used uninitialized.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/400
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  drivers/pwm/pwm-img.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
> > > > index 815f5333bb8f..1cc5fbe1e1d3 100644
> > > > --- a/drivers/pwm/pwm-img.c
> > > > +++ b/drivers/pwm/pwm-img.c
> > > > @@ -123,7 +123,7 @@ static int img_pwm_config(struct pwm_chip *chip=
, struct pwm_device *pwm,
> > > >       } else if (mul <=3D max_timebase * 512) {
> > > >               div =3D PWM_CTRL_CFG_SUB_DIV0_DIV1;
> > > >               timebase =3D DIV_ROUND_UP(mul, 512);
> > > > -     } else if (mul > max_timebase * 512) {
> > > > +     } else {
> > > >               dev_err(chip->dev,
> > > >                       "failed to configure timebase steps/divider v=
alue\n");
> > > >               return -EINVAL;
> > >
> > > This can even be simplified further.
> > >
> > > From the probe function we have:
> > >
> > >         pwm_chip->max_period_ns =3D NSEC_PER_SEC * 512 * max_timebase=
 / input_clk_hz
> >
> > I had trouble verifying `input_clk_hz` in the above.  The divisor is
> > `clk_get_rate(pwm->pwm_clk)`, but is it guaranteed to always be
> > `input_clk_hz`? If so, where?
>
> In the probe function it's called "clk_rate". We have:
>
>         clk_rate =3D clk_get_rate(pwm->pwm_clk);
>         ...
>         val =3D (u64)NSEC_PER_SEC * 512 * pwm->data->max_timebase;
>         do_div(val, clk_rate);
>         pwm->max_period_ns =3D val;
>
> and in img_pwm_config we have:
>
>         input_clk_hz =3D clk_get_rate(pwm_chip->pwm_clk);
>
> I used the name used in img_pwm_config with the intention that my
> reasoning is easier to understand, but obviously I failed.
>
> This by the way highlights another patch opportunity: Unify the names
> that the same thing gets the same name in the different functions. This
> doesn't only affect "clk_rate" vs "input_clk_hz", but also "pwm_chip"
> vs. "pwm".

Sure, those seem like nice little cleanups that will help with
maintainability.  Would you mind sending a patch for those, and I'll
review? Otherwise Nathan's patch exists and is ready to go.
--=20
Thanks,
~Nick Desaulniers
