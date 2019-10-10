Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3ECECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED5D2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="fDdQv6Zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfJJStf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:49:35 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:39230 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfJJSte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:49:34 -0400
Received: by mail-yb1-f195.google.com with SMTP id v37so2277618ybi.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9glmzMsjEQ54wWh9m1TLXnnqt0zz0o1L0ZQOtKhkaY=;
        b=fDdQv6ZqcWcquRA0TqInY5GiGIZQO3lADzd19fpsRGR6VxXATIBGBh0cAm1MT69jW6
         fezVNb3MvUHgvELpLib8es8l5CGYbc8+ZeHVwm5pd2oCvKl5dN0dIfJFJlR2IeeNW81N
         xODItm3Q1JB4veO/2+rLOtqc5wFGXPm/XCdevrrGnQ1L8ZF3GR+VtmD+4fURxM22Tl+j
         8e6ZMiTeIV5oyEf5j5Uilzmd9fzfE60h4zXloDON32Iug1gvf5m8/eQLQA8d09A05dpu
         WiFvmJQ2fltbQ8xbgb0iZ55JkTQE94yd+YgfXV00R+2Dke1JqkRvEm9R1UsuDXmy84gK
         9IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9glmzMsjEQ54wWh9m1TLXnnqt0zz0o1L0ZQOtKhkaY=;
        b=rx2xxg/kT1Y2XI7HtoT6yJP0EvsR16hPqbhouRVG7FXDu1phYk/I1JiF/I3h9VdAVM
         DLCKVk/PlOe91sfe1iLJnqkRaRFPjGrsJESBhWEIFce4p6dOIQlfqnf5FJLckmke547j
         sVGrH8xya90EAAqriMPaGwzdDx6dZay6p495D0Mke4y0BXXC8TsT7ZVg+69YXRldAPJz
         Qr1/cs/DfLNqUv7uWWa0sZMT6zw0Vtpl8f6tZC5S9LM7i54R39WDfgppu9HRC2jhEJIu
         MXcOsjbwCdRKutzCSyP3t9bvNg+uvaS8so9e1VsFcc3ZcA1rB9lsoFW6k6Xh+do3tFTJ
         EX2Q==
X-Gm-Message-State: APjAAAUdrNTmRhhiW3rPFlPLiZJSi/nSYxDwP6/burKILJQu5nyoPgA6
        Z9k3PMwakwShXx4MQcYF1VlXu9RbxSM0GdJUMOEozw==
X-Google-Smtp-Source: APXvYqxO5LUzQhIB19OQbbQWkVY2d5dQOnkoMxjj/mE3lLAFUU2bvc4EQPHrOOU7RC7bODaE4Hf14hqvDHZ5NbFXHnQ=
X-Received: by 2002:a25:348e:: with SMTP id b136mr7032957yba.159.1570733373815;
 Thu, 10 Oct 2019 11:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191009213454.32891-1-jeffrey.l.hugo@gmail.com> <20191010184544.GK85762@art_vandelay>
In-Reply-To: <20191010184544.GK85762@art_vandelay>
From:   Sean Paul <sean@poorly.run>
Date:   Thu, 10 Oct 2019 14:48:57 -0400
Message-ID: <CAMavQKJ7iMD+4a0eftNre9xMvyoZy_=sAPRAuMctX5bueugk1g@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dsi: Implement reset correctly
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 2:45 PM Sean Paul <sean@poorly.run> wrote:
>
> On Wed, Oct 09, 2019 at 02:34:54PM -0700, Jeffrey Hugo wrote:
> > On msm8998, vblank timeouts are observed because the DSI controller is not
> > reset properly, which ends up stalling the MDP.  This is because the reset
> > logic is not correct per the hardware documentation.
> >
> > The documentation states that after asserting reset, software should wait
> > some time (no indication of how long), or poll the status register until it
> > returns 0 before deasserting reset.
> >
> > wmb() is insufficient for this purpose since it just ensures ordering, not
> > timing between writes.  Since asserting and deasserting reset occurs on the
> > same register, ordering is already guaranteed by the architecture, making
> > the wmb extraneous.
> >
> > Since we would define a timeout for polling the status register to avoid a
> > possible infinite loop, lets just use a static delay of 20 ms, since 16.666
> > ms is the time available to process one frame at 60 fps.
> >
> > Fixes: a689554ba6ed (drm/msm: Initial add DSI connector support)
> > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > ---
> >
> > Rob et al, is it possible for this to go into a 5.4-rc?

Sorry, I missed this on the first go-around, I'm Ok with this getting
into 5.4. Rob, if you're Ok with this, I can send it through -misc
unless you're planning an msm-fixes PR.

> >
> >  drivers/gpu/drm/msm/dsi/dsi_host.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > index 663ff9f4fac9..68ded9b4735d 100644
> > --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> > +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> > @@ -986,7 +986,7 @@ static void dsi_sw_reset(struct msm_dsi_host *msm_host)
> >       wmb(); /* clocks need to be enabled before reset */
> >
> >       dsi_write(msm_host, REG_DSI_RESET, 1);
> > -     wmb(); /* make sure reset happen */
> > +     msleep(20); /* make sure reset happen */
>
> Could you please pull this out into a #define used for both in case we decide to
> tweak it? I don't want these 2 values to drift.
>

oh yeah, and with that fixed,

Reviewed-by: Sean Paul <sean@poorly.run>

> Thanks,
> Sean
>
> >       dsi_write(msm_host, REG_DSI_RESET, 0);
> >  }
> >
> > @@ -1396,7 +1396,7 @@ static void dsi_sw_reset_restore(struct msm_dsi_host *msm_host)
> >
> >       /* dsi controller can only be reset while clocks are running */
> >       dsi_write(msm_host, REG_DSI_RESET, 1);
> > -     wmb();  /* make sure reset happen */
> > +     msleep(20);     /* make sure reset happen */
> >       dsi_write(msm_host, REG_DSI_RESET, 0);
> >       wmb();  /* controller out of reset */
> >       dsi_write(msm_host, REG_DSI_CTRL, data0);
> > --
> > 2.17.1
> >
>
> --
> Sean Paul, Software Engineer, Google / Chromium OS
