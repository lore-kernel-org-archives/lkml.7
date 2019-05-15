Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA352C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9254C2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nAu9PbC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfEOSBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:01:42 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43398 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEOSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:01:42 -0400
Received: by mail-ua1-f66.google.com with SMTP id u4so191598uau.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GOlh4dTx7Vxhh5KS401+ytTuib/HBS2y3FGyL2kxQBo=;
        b=nAu9PbC6WUHU/fSI4IYsoxpnM/EQB4isVALdhOLUwqXWeRYNm+Ao3nLr92q9A+3UlN
         6iZPhlFXWl24Wsk78ch56s1us49NagE5IYyR/a0VhbVwp+b6KvWJgyRB2aP+NFC0D+rA
         tpZXjs0CFoouD5hfxeRvD6orP7xjpL43qbcqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GOlh4dTx7Vxhh5KS401+ytTuib/HBS2y3FGyL2kxQBo=;
        b=FCZJ2ltOvu3947m90erPGwPwIH7CgMHOFjzdn+jX+ZJPhN9SCu+88+4wVQ+txTk0jY
         HNtGGFXlbcuBu66+b81c4Nxz0XsgIEpMKc/j7dbUqbtvOnoS0GJ0agTfTBSMLKDFKGyU
         zVGb/r8LGP2tO5acz5x09POM8muoQwwrrzJ+Y8Ovtor4VQHXj2KLlXc8U4IkmMzDynkc
         UaY0KCxQyrSsisXYTrQaDJQLvgKopKA7peIvmvJsRY0dlsFtO0F0LcVzjcCTD+VsMdLq
         DcOGf5O5bhLigGW791pTTKQDeRQdHU/TovlEsMzO7QWWlVPR7g3mCa5cv7IM93EmLXSD
         NzfA==
X-Gm-Message-State: APjAAAVGx4lxreks/CXiww/9c3dMsSHOAk9TV4s6jwG60RrkSv/Azh4C
        QEU4ln+a92HwV/nj0ZqbZVmMB7v3rKE=
X-Google-Smtp-Source: APXvYqwmhjbun6wDmXVJ+bzk9dIvnWBKBgQGxy544T4R4zgBP+B5fi70AgYr1tCUBbn0nCPzDM3x/Q==
X-Received: by 2002:ab0:2bd8:: with SMTP id s24mr21262468uar.121.1557943300559;
        Wed, 15 May 2019 11:01:40 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a9sm1059714vka.21.2019.05.15.11.01.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 11:01:39 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id l20so535319vsp.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:01:38 -0700 (PDT)
X-Received: by 2002:a67:f60b:: with SMTP id k11mr14004140vso.111.1557943298290;
 Wed, 15 May 2019 11:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190502223808.185180-1-dianders@chromium.org> <20190515175826.GT17077@art_vandelay>
In-Reply-To: <20190515175826.GT17077@art_vandelay>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 15 May 2019 11:01:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X=ScK0H-ZNcOeEta2BL+f4TSAmXS=D585omXxbRVZcyQ@mail.gmail.com>
Message-ID: <CAD=FV=X=ScK0H-ZNcOeEta2BL+f4TSAmXS=D585omXxbRVZcyQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: bridge: dw-hdmi: Add hooks for suspend/resume
To:     Sean Paul <sean@poorly.run>
Cc:     Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 15, 2019 at 10:58 AM Sean Paul <sean@poorly.run> wrote:

> On Thu, May 02, 2019 at 03:38:07PM -0700, Douglas Anderson wrote:
> > On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> > cycle:
> >
> > 1. You lose the ability to detect an HDMI device being plugged in.
> >
> > 2. If you're using the i2c bus built in to dw_hdmi then it stops
> > working.
> >
> > Let's add a hook to the core dw-hdmi driver so that we can call it in
> > dw_hdmi-rockchip in the next commit.
> >
> > NOTE: the exact set of steps I've done here in resume come from
> > looking at the normal dw_hdmi init sequence in upstream Linux plus the
> > sequence that we did in downstream Chrome OS 3.14.  Testing show that
> > it seems to work, but if an extra step is needed or something here is
> > not needed we could improve it.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 21 +++++++++++++++++++++
> >  include/drm/bridge/dw_hdmi.h              |  3 +++
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index db761329a1e3..4b38bfd43e59 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -2780,6 +2780,27 @@ void dw_hdmi_unbind(struct dw_hdmi *hdmi)
> >  }
> >  EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
> >
> > +int dw_hdmi_suspend(struct dw_hdmi *hdmi)
> > +{
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_hdmi_suspend);
> > +
> > +int dw_hdmi_resume(struct dw_hdmi *hdmi)
> > +{
> > +     initialize_hdmi_ih_mutes(hdmi);
> > +
> > +     dw_hdmi_setup_i2c(hdmi);
> > +     if (hdmi->i2c)
> > +             dw_hdmi_i2c_init(hdmi);
> > +
> > +     if (hdmi->phy.ops->setup_hpd)
> > +             hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_hdmi_resume);
>
> Both patches look good to me, I'd probably prefer to just smash them together,
> but meh.
>
> If no one more authoritative chimes in, I'll apply them to -misc in a few days.

Sure.  I can smash them and re-post or you can smash them for me or we
can keep them as-is.  I originally separated because I wasn't sure if
they'd eventually go through different trees.  Just let me know!  :-)

-Doug
