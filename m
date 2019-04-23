Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDEAC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC7A218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 17:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbfDWRG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:06:56 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54707 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbfDWRGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 13:06:55 -0400
X-Originating-IP: 93.29.109.196
Received: from collins (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id B8EE3C0009;
        Tue, 23 Apr 2019 17:06:52 +0000 (UTC)
Message-ID: <41c94d93321b10ee9173e0b5bce9bc37a1ea7532.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH] drm/sun4i: Unbind components before
 releasing DRM and mem at master unbind
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date:   Tue, 23 Apr 2019 19:06:52 +0200
In-Reply-To: <1fcd1b7b1b52e67e4f0a28fca567bf3243fe0ada.camel@bootlin.com>
References: <20190419080235.24396-1-paul.kocialkowski@bootlin.com>
         <CAGb2v64iFwqPJ-me2KOWUjGuObg2brjRNvD_pkPw98Y60hnwQg@mail.gmail.com>
         <1fcd1b7b1b52e67e4f0a28fca567bf3243fe0ada.camel@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le vendredi 19 avril 2019 à 19:10 +0200, Paul Kocialkowski a écrit :
> Hi,
> 
> On Fri, 2019-04-19 at 09:02 -0700, Chen-Yu Tsai wrote:
> > On Fri, Apr 19, 2019 at 1:03 AM Paul Kocialkowski
> > <paul.kocialkowski@bootlin.com> wrote:
> > > Our components may still be using the DRM device driver (if only to
> > > access our driver's private data), so make sure to unbind them before
> > > the final drm_dev_put.
> > > 
> > > Also release our resserved memory adter unbind to match reverse
> > 
> > typos...
> 
> I'll probably spin up a v2 to fix them, they annoy me as well.
> 
> > > creation order.
> > > 
> > > Fixes: f5a9ed867c83 ("drm/sun4i: Fix component unbinding and component master deletion")
> > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > ---
> > >  drivers/gpu/drm/sun4i/sun4i_drv.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > > index 843b86661833..29258b404e54 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > > @@ -149,10 +149,11 @@ static void sun4i_drv_unbind(struct device *dev)
> > >         drm_kms_helper_poll_fini(drm);
> > >         drm_atomic_helper_shutdown(drm);
> > >         drm_mode_config_cleanup(drm);
> > > -       of_reserved_mem_device_release(dev);
> > > -       drm_dev_put(drm);
> > > 
> > >         component_unbind_all(dev, NULL);
> > > +       of_reserved_mem_device_release(dev);
> > 
> > You should probably mention this change in the commit log as well.
> 
> That's what I meant with the line that has typos. Maybe I should make
> it slightly more explicit as:
> 
> Also released our reserved memory after component unbind instead of
> before to match reverse creation order.
> 
> What do you think?
> 
> > Otherwise,
> > 
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> Thanks for the review!

Unless you have objections at this point, I'll send out the patch with
your Reviewed-by soon to get the patch out ASAP.

Cheers,

Paul

> Cheers,
> 
> Paul
> 
> > > +
> > > +       drm_dev_put(drm);
> > >  }
> > > 
> > >  static const struct component_master_ops sun4i_drv_master_ops = {
> > > --
> > > 2.21.0
> > > 
> > > --
> > > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > > For more options, visit https://groups.google.com/d/optout.

