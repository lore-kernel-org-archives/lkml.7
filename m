Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023A1CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC4A2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 17:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geeqURtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfKDRFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 12:05:35 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41749 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfKDRFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 12:05:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id m9so18445792ljh.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 09:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qJiFRAU1ANgQBEoCGJorJXFwWND9KhJu4ptLqqShZY=;
        b=geeqURtuQ0iMZyZU2JHAx0IIgyNxihwJ/tz8LlMhNGKscQrPvXfVI8M1H/YMxQWlFT
         qF16TQZ6/ZmOk8D9ptBrhEfRY5oamsNqOKOni0Gs51K/BAbboo/7TXPH9ivalonLHLUf
         DUEm+AD37BwvxAT03Aa2Po2MXd0Rerh4qM+7/4IYIv/6zP/OrZsfVnmUuWTwTeD/MgGu
         siSUtozk/md7BLOwWuE1gpANrNX2/T6ZV5bYQC7F04frd7IH/HozwBNqMkfvhYfYBANf
         ckkDHSv+dNqQAFmUDUIq9zbRBZFTjTtBWOtVzV/XQe5btPcwmCDS2RIL9zeX8C2Rg6Wl
         q3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qJiFRAU1ANgQBEoCGJorJXFwWND9KhJu4ptLqqShZY=;
        b=BDmN4mt0dHNke7UjHBYbqPq7fuyds+gche2/8x4/3Ubf6+mob8SREFdMSKbr+ziWkg
         mvjAY8BkyIhLSbH035fVMwBzhhONwoPisVnFpLQYexAzoTasZzOZpc7PV4+Vb4wA4xgG
         1RbVldCo4T606g2sjzBGjMSUacEct9V0U5n0QBio0fxJ2omEtuitsiY5BGZL13qQZVih
         owdY8B2iNoabp7xIRAGn+agu05BjkaKimkXifA+rQ8bNqAb2xoQ3lOwiareR3O8VbL5Q
         jCMaEknB7h28ULC3A+wRDTLjlP/HpqF9i4yFy3zqo8kiqBG+s75W4Z6UJVC2fYCmyXyt
         8qnQ==
X-Gm-Message-State: APjAAAVS0RGmlIsm40vkFUxeUAYxOCgIeGxugf410klDTZ68nIeoumxy
        1xks3DSk4cFuU3dnXeEwaz+m6tDl70ckdFyLDoQ=
X-Google-Smtp-Source: APXvYqwJDCfSR1r8hM4MJdBNSycomr3d/Yl4nSIe1J1+qFv3cbMoiF0nRwJfSkMA4D4BnhqwxP5Me1aU8/u2x0tDkVQ=
X-Received: by 2002:a2e:9e45:: with SMTP id g5mr2776409ljk.58.1572887131574;
 Mon, 04 Nov 2019 09:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20191016123342.19119-1-patrik.r.jakobsson@gmail.com>
 <87lftdfb4c.fsf@intel.com> <20191022084423.GB1531961@ulmo>
 <87imohf6rf.fsf@intel.com> <CAMeQTsYbY+2=w1m_zMo95vrR008otQESYQJ5K1PfyYOi_Ff2BQ@mail.gmail.com>
In-Reply-To: <CAMeQTsYbY+2=w1m_zMo95vrR008otQESYQJ5K1PfyYOi_Ff2BQ@mail.gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Mon, 4 Nov 2019 18:05:20 +0100
Message-ID: <CAMeQTsZ5eXSS3OTG_uHUZpPj_=A4Uj_z5x0ZH-CwHRB2L5-YBg@mail.gmail.com>
Subject: Re: [PATCH] drm/scdc: Fix typo in bit definition of SCDC_STATUS_FLAGS
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <treding@nvidia.com>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 5:53 PM Patrik Jakobsson
<patrik.r.jakobsson@gmail.com> wrote:
>
> On Tue, Oct 22, 2019 at 11:51 AM Jani Nikula
> <jani.nikula@linux.intel.com> wrote:
> >
> > On Tue, 22 Oct 2019, Thierry Reding <thierry.reding@gmail.com> wrote:
> > > On Tue, Oct 22, 2019 at 11:16:51AM +0300, Jani Nikula wrote:
> > >> On Wed, 16 Oct 2019, Patrik Jakobsson <patrik.r.jakobsson@gmail.com> wrote:
> > >> > Fix typo where bits got compared (x < y) instead of shifted (x << y).
> > >>
> > >> Fixes: 3ad33ae2bc80 ("drm: Add SCDC helpers")
> > >> Cc: Thierry Reding <treding@nvidia.com>
> > >
> > > I'm not sure we really need the Fixes: tag here. These defines aren't
> > > used anywhere, so technically there's no bug.
> >
> > Yeah well, I just logged it here as I happened to do the drive-by git
> > blame.
>
> I think we can skip the fixes tag here. Thanks for review!
>
> Did anyone apply this or can I take it through drm-misc-next?
>
> -Patrik

Applied to drm-misc-next

>
> >
> > BR,
> > Jani.
> >
> >
> >
> > >
> > > Thierry
> > >
> > >>
> > >> > Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> > >> > ---
> > >> >  include/drm/drm_scdc_helper.h | 6 +++---
> > >> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >> >
> > >> > diff --git a/include/drm/drm_scdc_helper.h b/include/drm/drm_scdc_helper.h
> > >> > index f92eb2094d6b..6a483533aae4 100644
> > >> > --- a/include/drm/drm_scdc_helper.h
> > >> > +++ b/include/drm/drm_scdc_helper.h
> > >> > @@ -50,9 +50,9 @@
> > >> >  #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
> > >> >
> > >> >  #define SCDC_STATUS_FLAGS_0 0x40
> > >> > -#define  SCDC_CH2_LOCK (1 < 3)
> > >> > -#define  SCDC_CH1_LOCK (1 < 2)
> > >> > -#define  SCDC_CH0_LOCK (1 < 1)
> > >> > +#define  SCDC_CH2_LOCK (1 << 3)
> > >> > +#define  SCDC_CH1_LOCK (1 << 2)
> > >> > +#define  SCDC_CH0_LOCK (1 << 1)
> > >> >  #define  SCDC_CH_LOCK_MASK (SCDC_CH2_LOCK | SCDC_CH1_LOCK | SCDC_CH0_LOCK)
> > >> >  #define  SCDC_CLOCK_DETECT (1 << 0)
> > >>
> > >> --
> > >> Jani Nikula, Intel Open Source Graphics Center
> > >> _______________________________________________
> > >> dri-devel mailing list
> > >> dri-devel@lists.freedesktop.org
> > >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
> > --
> > Jani Nikula, Intel Open Source Graphics Center
