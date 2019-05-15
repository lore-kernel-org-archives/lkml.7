Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A66C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AAB92084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="bRruT73O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfEOSFG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:05:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42541 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEOSFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:05:05 -0400
Received: by mail-qt1-f196.google.com with SMTP id j53so720367qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+hs5xg7kXU2SMsc3oKZIKfrfpdpw9b4KuC9hrmBGtlM=;
        b=bRruT73OXhXm9o91r54/0gUD2l5eMfxYgSCfb3qivODs0BuSErPmM54r4FE6OUIHW8
         phoQtIzqZKTxehM+SrYtgIc2LVo+Ka9E3elMPQ83jY/A2zsqdaOI7i2K2Um2+BKvjJlJ
         /EZBn3/xIylmGa7cJAmEEsLSSENXudtz5RSgcUnxiuCICBQiVJQWyBKJyReW/YfQPRRd
         ldKhjcu/NhuSvhW3nTBmwtaibC5MB20gENDW6FcMWs7Cc504KEbBMP331NEMzzmY7a1K
         ZaqRWwKPKHZQWWLdI8MXO+ue4ZZb2a8qg1XdocHN9iLhCOsGlisIQuglYSUNlelgGt7i
         oKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+hs5xg7kXU2SMsc3oKZIKfrfpdpw9b4KuC9hrmBGtlM=;
        b=Le2DCPRuLm8aHu48ASDu/c1mBu6BS9+YH1Pgh1knJTzzpOno+j7I9t+Enq04IL6hU+
         8f4zbAimqpEgJu+TPyhvHWeXqY40JRypEUiEYQoFPo6S6PF/qh1MVlUI1EQgkgW/Lto4
         Gnz4p+z5voQTB6yhzorjoCpFMK2jXDMrbfFDG1PuA8r7ZffleMl8nQjrevqG1WCsZWB1
         vD1nqWevzo43L5beP3nThPUQv/zqXUC4zXfo9dKb6J1mWAfnPpUfmw6tJ4agwJiMVlPM
         BK7rTQknpuMFlFk/6Oyfl38+damFUMmYXlwe7vInm/9FSyK+XRc1Pd8HRmtyBJ1T6EQw
         qrJQ==
X-Gm-Message-State: APjAAAXZLZeDpUDDEfRyL6VVjUVi1fK5SRmnaNGJ04whQU3+1If3xVz9
        tbMZQjORkqaVXsTPd7H0OioHGA==
X-Google-Smtp-Source: APXvYqzgn4I8gLwP45HY/wQks6X1Aa55QBkdkNaroINqESPe3UjrHphkUh2LgwXrGMx2OH2J7r4FNQ==
X-Received: by 2002:a0c:98f8:: with SMTP id g53mr9717980qvd.142.1557943504648;
        Wed, 15 May 2019 11:05:04 -0700 (PDT)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id e25sm2116919qta.18.2019.05.15.11.05.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:05:03 -0700 (PDT)
Date:   Wed, 15 May 2019 14:05:03 -0400
From:   Sean Paul <sean@poorly.run>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sean Paul <sean@poorly.run>, Heiko Stuebner <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>,
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
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/2] drm: bridge: dw-hdmi: Add hooks for suspend/resume
Message-ID: <20190515180503.GU17077@art_vandelay>
References: <20190502223808.185180-1-dianders@chromium.org>
 <20190515175826.GT17077@art_vandelay>
 <CAD=FV=X=ScK0H-ZNcOeEta2BL+f4TSAmXS=D585omXxbRVZcyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=X=ScK0H-ZNcOeEta2BL+f4TSAmXS=D585omXxbRVZcyQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:01:26AM -0700, Doug Anderson wrote:
> Hi,
> 
> On Wed, May 15, 2019 at 10:58 AM Sean Paul <sean@poorly.run> wrote:
> 
> > On Thu, May 02, 2019 at 03:38:07PM -0700, Douglas Anderson wrote:
> > > On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> > > cycle:
> > >
> > > 1. You lose the ability to detect an HDMI device being plugged in.
> > >
> > > 2. If you're using the i2c bus built in to dw_hdmi then it stops
> > > working.
> > >
> > > Let's add a hook to the core dw-hdmi driver so that we can call it in
> > > dw_hdmi-rockchip in the next commit.
> > >
> > > NOTE: the exact set of steps I've done here in resume come from
> > > looking at the normal dw_hdmi init sequence in upstream Linux plus the
> > > sequence that we did in downstream Chrome OS 3.14.  Testing show that
> > > it seems to work, but if an extra step is needed or something here is
> > > not needed we could improve it.
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > ---
> > >
> > >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 21 +++++++++++++++++++++
> > >  include/drm/bridge/dw_hdmi.h              |  3 +++
> > >  2 files changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > index db761329a1e3..4b38bfd43e59 100644
> > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > @@ -2780,6 +2780,27 @@ void dw_hdmi_unbind(struct dw_hdmi *hdmi)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
> > >
> > > +int dw_hdmi_suspend(struct dw_hdmi *hdmi)
> > > +{
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dw_hdmi_suspend);
> > > +
> > > +int dw_hdmi_resume(struct dw_hdmi *hdmi)
> > > +{
> > > +     initialize_hdmi_ih_mutes(hdmi);
> > > +
> > > +     dw_hdmi_setup_i2c(hdmi);
> > > +     if (hdmi->i2c)
> > > +             dw_hdmi_i2c_init(hdmi);
> > > +
> > > +     if (hdmi->phy.ops->setup_hpd)
> > > +             hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
> > > +
> > > +     return 0;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dw_hdmi_resume);
> >
> > Both patches look good to me, I'd probably prefer to just smash them together,
> > but meh.
> >
> > If no one more authoritative chimes in, I'll apply them to -misc in a few days.
> 
> Sure.  I can smash them and re-post or you can smash them for me or we
> can keep them as-is.  I originally separated because I wasn't sure if
> they'd eventually go through different trees.  Just let me know!  :-)

Definitely no need to repost. It's entirely possible Andrzej or Heiko prefer to
have the dw-hdmi stuff broken out anyways. My opinion is of little value here :)

Sean

> 
> -Doug

-- 
Sean Paul, Software Engineer, Google / Chromium OS
