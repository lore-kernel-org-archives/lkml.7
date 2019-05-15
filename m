Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9F3C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C6620818
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 20:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfEOUEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 16:04:02 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44892 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbfEOUEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 16:04:02 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hR07s-0000bC-Ci; Wed, 15 May 2019 22:03:44 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Sean Paul <sean@poorly.run>
Cc:     Doug Anderson <dianders@chromium.org>,
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
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>, David Airlie <airlied@linux.ie>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 1/2] drm: bridge: dw-hdmi: Add hooks for suspend/resume
Date:   Wed, 15 May 2019 22:03:43 +0200
Message-ID: <1842218.E6FT6db3r4@diego>
In-Reply-To: <20190515180503.GU17077@art_vandelay>
References: <20190502223808.185180-1-dianders@chromium.org> <CAD=FV=X=ScK0H-ZNcOeEta2BL+f4TSAmXS=D585omXxbRVZcyQ@mail.gmail.com> <20190515180503.GU17077@art_vandelay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 15. Mai 2019, 20:05:03 CEST schrieb Sean Paul:
> On Wed, May 15, 2019 at 11:01:26AM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Wed, May 15, 2019 at 10:58 AM Sean Paul <sean@poorly.run> wrote:
> > 
> > > On Thu, May 02, 2019 at 03:38:07PM -0700, Douglas Anderson wrote:
> > > > On Rockchip rk3288-based Chromebooks when you do a suspend/resume
> > > > cycle:
> > > >
> > > > 1. You lose the ability to detect an HDMI device being plugged in.
> > > >
> > > > 2. If you're using the i2c bus built in to dw_hdmi then it stops
> > > > working.
> > > >
> > > > Let's add a hook to the core dw-hdmi driver so that we can call it in
> > > > dw_hdmi-rockchip in the next commit.
> > > >
> > > > NOTE: the exact set of steps I've done here in resume come from
> > > > looking at the normal dw_hdmi init sequence in upstream Linux plus the
> > > > sequence that we did in downstream Chrome OS 3.14.  Testing show that
> > > > it seems to work, but if an extra step is needed or something here is
> > > > not needed we could improve it.
> > > >
> > > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > > > ---
> > > >
> > > >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 21 +++++++++++++++++++++
> > > >  include/drm/bridge/dw_hdmi.h              |  3 +++
> > > >  2 files changed, 24 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > > index db761329a1e3..4b38bfd43e59 100644
> > > > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > > > @@ -2780,6 +2780,27 @@ void dw_hdmi_unbind(struct dw_hdmi *hdmi)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(dw_hdmi_unbind);
> > > >
> > > > +int dw_hdmi_suspend(struct dw_hdmi *hdmi)
> > > > +{
> > > > +     return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_hdmi_suspend);
> > > > +
> > > > +int dw_hdmi_resume(struct dw_hdmi *hdmi)
> > > > +{
> > > > +     initialize_hdmi_ih_mutes(hdmi);
> > > > +
> > > > +     dw_hdmi_setup_i2c(hdmi);
> > > > +     if (hdmi->i2c)
> > > > +             dw_hdmi_i2c_init(hdmi);
> > > > +
> > > > +     if (hdmi->phy.ops->setup_hpd)
> > > > +             hdmi->phy.ops->setup_hpd(hdmi, hdmi->phy.data);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(dw_hdmi_resume);
> > >
> > > Both patches look good to me, I'd probably prefer to just smash them together,
> > > but meh.
> > >
> > > If no one more authoritative chimes in, I'll apply them to -misc in a few days.
> > 
> > Sure.  I can smash them and re-post or you can smash them for me or we
> > can keep them as-is.  I originally separated because I wasn't sure if
> > they'd eventually go through different trees.  Just let me know!  :-)
> 
> Definitely no need to repost. It's entirely possible Andrzej or Heiko prefer to
> have the dw-hdmi stuff broken out anyways. My opinion is of little value here :)

I guess my own preference is to keep them as they are now - so separate.
It makes it easier to see what gets done and also keeps the boundary on
where to split pretty clear.


Heiko


