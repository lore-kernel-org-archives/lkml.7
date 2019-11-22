Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254FDC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE872068F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 07:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKVHWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 02:22:47 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45925 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfKVHWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 02:22:46 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1iY3H9-0000om-N2; Fri, 22 Nov 2019 08:22:43 +0100
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1iY3H5-0001Uh-II; Fri, 22 Nov 2019 08:22:39 +0100
Date:   Fri, 22 Nov 2019 08:22:39 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Navid Emamdoost <emamd001@umn.edu>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] drm/imx: fix memory leak in imx_pd_bind
Message-ID: <20191122072239.dhbhi2uawoqsclwy@pengutronix.de>
References: <20191004190938.15353-1-navid.emamdoost@gmail.com>
 <CAEkB2EQGCcwBO4iZBiHthUAJUeprw2Q09932GATd6XVyXqukzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkB2EQGCcwBO4iZBiHthUAJUeprw2Q09932GATd6XVyXqukzw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:19:40 up 6 days, 22:38, 23 users,  load average: 0.00, 0.00, 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Navid,

On 19-11-21 12:31, Navid Emamdoost wrote:
> On Fri, Oct 4, 2019 at 2:09 PM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
> >
> > In imx_pd_bind, the duplicated memory for imxpd->edid via kmemdup should
> > be released in drm_of_find_panel_or_bridge or imx_pd_register fail.
> >
> > Fixes: ebc944613567 ("drm: convert drivers to use drm_of_find_panel_or_bridge")
> > Fixes: 19022aaae677 ("staging: drm/imx: Add parallel display support")
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> > ---
> 
> Would you please review this patch?
> 
> Thanks,

I currently work on the drm/imx driver(s) to avoid errors like [1].
Hopefully I have a working version till next week. There I fixed this
issue by using the devm_kmemdup() and dropped the explicit kfree()
within unbind().

[1] https://www.spinics.net/lists/dri-devel/msg189388.html

Regards,
  Marco

> 
> >  drivers/gpu/drm/imx/parallel-display.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
> > index e7ce17503ae1..9522d2cb0ad5 100644
> > --- a/drivers/gpu/drm/imx/parallel-display.c
> > +++ b/drivers/gpu/drm/imx/parallel-display.c
> > @@ -227,14 +227,18 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
> >
> >         /* port@1 is the output port */
> >         ret = drm_of_find_panel_or_bridge(np, 1, 0, &imxpd->panel, &imxpd->bridge);
> > -       if (ret && ret != -ENODEV)
> > +       if (ret && ret != -ENODEV) {
> > +               kfree(imxpd->edid);
> >                 return ret;
> > +       }
> >
> >         imxpd->dev = dev;
> >
> >         ret = imx_pd_register(drm, imxpd);
> > -       if (ret)
> > +       if (ret) {
> > +               kfree(imxpd->edid);
> >                 return ret;
> > +       }
> >
> >         dev_set_drvdata(dev, imxpd);
> >
> > --
> > 2.17.1
> >
> 
> 
> -- 
> Navid.
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
