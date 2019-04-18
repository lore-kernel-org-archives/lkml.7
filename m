Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB48C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3528206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbfDRRXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:23:09 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:59349 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRRXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:23:09 -0400
Received: from collins (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0FF17200009;
        Thu, 18 Apr 2019 17:23:05 +0000 (UTC)
Message-ID: <db33cf62349f13dbb6e1eaa7dc970df97d2cb257.camel@bootlin.com>
Subject: Re: [linux-sunxi] [PATCH 3/3] drm/sun4i: Fix component unbinding
 and component master deletion
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
Date:   Thu, 18 Apr 2019 19:23:05 +0200
In-Reply-To: <CAGb2v67MYXQsdv7E_SGXALVVr0T7aTTP6AhwA3N8U7HNJkRH7w@mail.gmail.com>
References: <20190418132727.5128-1-paul.kocialkowski@bootlin.com>
         <20190418132727.5128-4-paul.kocialkowski@bootlin.com>
         <CAGb2v67MYXQsdv7E_SGXALVVr0T7aTTP6AhwA3N8U7HNJkRH7w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.0 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le jeudi 18 avril 2019 à 08:03 -0700, Chen-Yu Tsai a écrit :
> On Thu, Apr 18, 2019 at 6:27 AM Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
> > For our component-backed driver to be properly removed, we need to
> > delete the component master in sun4i_drv_remove and make sure to call
> > component_unbind_all in the master's unbind so that all components are
> > unbound when the master is.
> > 
> > Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")
> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_drv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > index af07291544a4..0ea365e54de1 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > @@ -137,6 +137,8 @@ static void sun4i_drv_unbind(struct device *dev)
> >         drm_mode_config_cleanup(drm);
> >         of_reserved_mem_device_release(dev);
> >         drm_dev_put(drm);
> > +
> > +       component_unbind_all(dev, NULL);
> 
> Shouldn't this be before drm_dev_put? Everything being in reverse order
> of the complement calls in the bind function and all. The component
> drivers might still be using the drm dev before they are unbound.

Mhh, yes that's a valid concern, thanks for pointing it out. I'll send
out a fix for it tomorrow.

Cheers,

Paul

> ChenYu
> 
> >  }
> > 
> >  static const struct component_master_ops sun4i_drv_master_ops = {
> > @@ -385,6 +387,8 @@ static int sun4i_drv_probe(struct platform_device *pdev)
> > 
> >  static int sun4i_drv_remove(struct platform_device *pdev)
> >  {
> > +       component_master_del(&pdev->dev, &sun4i_drv_master_ops);
> > +
> >         return 0;
> >  }
> > 
> > --
> > 2.21.0
> > 
> > --
> > You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> > For more options, visit https://groups.google.com/d/optout.

