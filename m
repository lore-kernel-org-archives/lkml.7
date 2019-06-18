Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E268C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FB7213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RjIbAgrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfFRHrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:47:04 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35409 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfFRHrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:47:02 -0400
Received: by mail-io1-f65.google.com with SMTP id m24so27669561ioo.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxKYkLgA5MVuzsXMSMGfzla77yJINMaSigfo4ssAuus=;
        b=RjIbAgrDl9/qI0Gii7VVzjfDkkA4UNrDQYVufYwYf/7w9vv+rUari1Sq1mvxZKpVXv
         HaIXkNWo7j6M5sCPdtYLiEMFaEoOc1VdJf/4sMfMFzLfEb8cS2GpcVmxlv3o5DgQrlIr
         /0peXvokP7Oc2S5VY+81T7ibHogSkES0k5wnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxKYkLgA5MVuzsXMSMGfzla77yJINMaSigfo4ssAuus=;
        b=ZNWgTVi6nUGqG76VegjphRVDKmFMapzrPNJfJkoaf2mPi25PWmxuFJNo7BWcfahM6o
         EzZkyToQTjPc3xixHgvPnsDY89o7ktk58MTdaKnD9Vk3fOJvaWC8cY4oINFRuH7rcC8V
         xbFy8IYFNYfpPG7vBzEYv3H2xfbPqYrzZPWtB9Z5TxFXbAb2zDSSxkkOoiGafZzNztqD
         YMVuRLJwZKT27YM1koF8OGMRCZ4RRFouDkRMzl9ZuzYFkLErSEmkz1XocYcfvFmBWiaZ
         AaWE0ZdaKwG+zYDrPfmBrw2RGHX1aqUB1/N7BKE9eHTN+VIv2r9e31oOhQPPTmOIO6A2
         PpDw==
X-Gm-Message-State: APjAAAW5i87aFBOGbaoNmt+SRJfN97BPLwPeXH4daFPTBPKG9BL8kyJZ
        mJEfOmFK8+uLI46fl+O9EBBbpvC7OpQasVyV7DBtWw==
X-Google-Smtp-Source: APXvYqycTbdlGgVagVEKSPFXn3d5LsyT9I6EZwTdqQk/dkFhmrBl6uOW3Kl4M+fU023lwzcVYQVx/JhGLarll+uzkVY=
X-Received: by 2002:a02:380c:: with SMTP id b12mr67109907jaa.85.1560844021305;
 Tue, 18 Jun 2019 00:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190614164324.9427-1-jagan@amarulasolutions.com>
 <20190614164324.9427-6-jagan@amarulasolutions.com> <20190617114503.pclqsf6bo3ih47nt@flea>
 <CAGb2v66RU=m0iA9VoBiYbake+mDoiiGcd5gGGXvNCBjhY2n+Dw@mail.gmail.com>
 <CAMty3ZA0J+2fSRwX+tS-waJDLMyTOf6UY_1pHjXe0qOk5QuzrQ@mail.gmail.com> <CAGb2v64htYr+iRUnLx0hKkqCtYa0GbzZJEvb-ViyJFAYzU1sig@mail.gmail.com>
In-Reply-To: <CAGb2v64htYr+iRUnLx0hKkqCtYa0GbzZJEvb-ViyJFAYzU1sig@mail.gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Tue, 18 Jun 2019 13:16:50 +0530
Message-ID: <CAMty3ZBDjNa+Sso4hmKxXOg_LT8giNYQAuJCgjZW8AeVQhAtyQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 5/9] drm/sun4i: tcon_top: Register
 clock gates in probe
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 12:53 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> On Tue, Jun 18, 2019 at 3:12 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > On Mon, Jun 17, 2019 at 6:31 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > >
> > > On Mon, Jun 17, 2019 at 7:45 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > > >
> > > > On Fri, Jun 14, 2019 at 10:13:20PM +0530, Jagan Teki wrote:
> > > > > TCON TOP have clock gates for TV0, TV1, dsi and right
> > > > > now these are register during bind call.
> > > > >
> > > > > Of which, dsi clock gate would required during DPHY probe
> > > > > but same can miss to get since tcon top is not bound at
> > > > > that time.
> > > > >
> > > > > To solve, this circular dependency move the clock gate
> > > > > registration from bind to probe so-that DPHY can get the
> > > > > dsi gate clock on time.
> > > >
> > > > It's not really clear to me what the circular dependency is?
> > > >
> > > > if you have a chain that is:
> > > >
> > > > tcon-top +-> DSI
> > > >          +-> D-PHY
> > > >
> > > > There's no loop, right?
> > >
> > > Looking at how the DTSI patch structures things (without going into
> > > whether it is correct or accurate):
> > >
> > > The D-PHY is not part of the component graph. However it requests
> > > the DSI gate clock from the TCON-TOP.
> > >
> > > The TCON-TOP driver, in its current form, only registers the clocks
> > > it provides at component bind time. Thus the D-PHY can't successfully
> > > probe until the TCON-TOP has been bound.
> > >
> > > The DSI interface requires the D-PHY to bind. It will return -EPROBE_DEFER
> > > if it cannot request it. This in turn goes into the error path of
> > > component_bind_all, which unbinds all previous components.
> > >
> > > So it's actually
> > >
> > >     D-PHY -> TCON-TOP -> DSI
> > >       ^                   |
> > >       |--------------------
> > >
> > > I've not checked, but I suspect there's no possibility of having other
> > > drivers probe (to deal with deferred probing) within component_bind_all.
> > > Otherwise we shouldn't run into this weird circular dependency issue.
> > >
> > > So the question for Jagan is that is this indeed the case? Does this
> > > patch solve it, or at least work around it.
> >
> > Yes, this is what I was mentioned in initial version, since the "dsi"
> > gate in tcon top is registering during bind, the dphy of dsi
> > controller won't get the associated clock for "mod" so it is keep on
> > returning -EPROBE_DEFER. By moving the clock gate registration to
> > probe, everything bound as expected.
>
> I believe you failed to mention the DSI block, which is the part that
> completes the circular dependency. Don't expect others to have full
> awareness of the context. You have to provide it in your commit log.

I have mentioned DPHY and yes it is possible to give more information
will update in next version, no problem. thanks for mentioning that.
