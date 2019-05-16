Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF78C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C13D2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 08:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfEPIXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 04:23:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37262 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbfEPIXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 04:23:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C7431715;
        Thu, 16 May 2019 01:23:52 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 490AB3F703;
        Thu, 16 May 2019 01:23:52 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id A66D7682413; Thu, 16 May 2019 09:23:50 +0100 (BST)
Date:   Thu, 16 May 2019 09:23:50 +0100
From:   "liviu.dudau@arm.com" <liviu.dudau@arm.com>
To:     Wen He <wen.he_1@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for required
 pixel clock rate
Message-ID: <20190516082350.GB15144@e110455-lin.cambridge.arm.com>
References: <20190515024348.43642-1-wen.he_1@nxp.com>
 <20190515154530.GX15144@e110455-lin.cambridge.arm.com>
 <AM0PR04MB48658C4B7AADE1E3FFCA7ED7E20A0@AM0PR04MB4865.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB48658C4B7AADE1E3FFCA7ED7E20A0@AM0PR04MB4865.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 08:10:21AM +0000, Wen He wrote:
> 
> 
> > -----Original Message-----
> > From: liviu.dudau@arm.com [mailto:liviu.dudau@arm.com]
> > Sent: 2019年5月15日 23:46
> > To: Wen He <wen.he_1@nxp.com>
> > Cc: dri-devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; Leo Li
> > <leoyang.li@nxp.com>
> > Subject: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for required pixel
> > clock rate
> > 
> > 
> > Hi Wen,
> 
> Hi Liviu,
> 
> > 
> > On Wed, May 15, 2019 at 02:42:08AM +0000, Wen He wrote:
> > > Disable checking for required pixel clock rate if ARCH_LAYERSCPAE is
> > > enable.
> > >
> > > Signed-off-by: Alison Wang <alison.wang@nxp.com>
> > > Signed-off-by: Wen He <wen.he_1@nxp.com>
> > > ---
> > > change in description:
> > >       - This check that only supported one pixel clock required clock rate
> > >       compare with dts node value. but we have supports 4 pixel clock
> > >       for ls1028a board.
> > 
> > So, your DT says your pixel clock provider is a fixed clock? If you support more
> > than one rate, you should instead use a real provider for it. How do you
> > support the 4 pixel clocks?
> > 
>  
> Yes , the DT node only can provided one pixel clock by using a fixed clock.
> But we Display Port controller support 4 or more resolutions, each of which
> requires a set of pixel clocks to drive, and we hope they can switch any resolution
> we want by some program every times.

That program can't be some userspace application, because it will have to make
changes to the hardware and the kernel will not know that things have changed
under its feet. That leaves the option of the bootloader or some other kernel
module doing the changes.

If you have another kernel module that knows how to change clocks, that should
be implemented using the common clocks infrastructure, at which time you can
put it in the DT as the clock provider for the pixelclock.

If the bootloader does the changes, then the bootloader should edit the DT and
set the correct value for the pixel clock. Regardless, with your change and on
your platform the user can request any resolution and the driver will silently
fail to set that resolution.

One other problem is the one Robin raised, where the kernel is compiled for
multiple platforms, like what various Linux distributions do. That kernel will
either work on other SoC or not, depending on what CONFIG_ARCH_LAYERSCAPE is
set to.

In summary, for this patch, it's a NAK. There are proper ways of achieving what
you need, but this patch is not.

Best regards,
Liviu

> 
> For example, if we set that fixed pixel clock is 27000000 (27Mhz), but user hope can see
> a group 1080p resolution penguins during startup , and hope playing a 4k video once
> system boot up done. 
> Btw, In our board, the 1080p resolution is driven by a 148.5Mhz pixel clock, 4k is driven
> by a 594Mhz. 27Mhz only can drive 480p resolution.
> 
> To meet the above user requirements, I was to setup following steps,
> 1. Add the "video=1920x1080-32@60" to bootargs command line [specify penguins size]
> 2. Play a 4K video with 4k resolution when system boot up done.
> 
> > Also, not sure what the paragraph above is meant to be. Should it be part of
> > the commit message?
> > 
> 
> These comments just want to let you know.
> 
> > Best regards,
> > Liviu
> > 
> > 
> > >  drivers/gpu/drm/arm/malidp_crtc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/arm/malidp_crtc.c
> > > b/drivers/gpu/drm/arm/malidp_crtc.c
> > > index 56aad288666e..bb79223d9981 100644
> > > --- a/drivers/gpu/drm/arm/malidp_crtc.c
> > > +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> > > @@ -36,11 +36,13 @@ static enum drm_mode_status
> > > malidp_crtc_mode_valid(struct drm_crtc *crtc,
> > >
> 
> According to our pixel configuration above,
> Now the variable req_rate value is 148500000 or 59400000, another variable rate value is
> 27000000, so we will get a warning and display will cannot works well. 
> 
> We're not sure which resolution are user want, and we also can't just offered one resolution
> to user. so I remove this check on our board, maybe it's not good change.
> 
> I want to know do you have other good suggestion? Thanks.
> 
> Best Regards,
> Wen
> 
> > >       if (req_rate) {
> > >               rate = clk_round_rate(hwdev->pxlclk, req_rate);
> > > +#ifndef CONFIG_ARCH_LAYERSCAPE
> > >               if (rate != req_rate) {
> > >                       DRM_DEBUG_DRIVER("pxlclk doesn't support %ld
> > Hz\n",
> > >                                        req_rate);
> > >                       return MODE_NOCLOCK;
> > >               }
> > > +#endif
> > >       }
> > >
> > >       return MODE_OK;
> > > --
> > > 2.17.1
> > >
> > 
> > --
> > ====================
> > | I would like to |
> > | fix the world,  |
> > | but they're not |
> > | giving me the   |
> >  \ source code!  /
> >   ---------------
> >     ¯\_(ツ)_/¯

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
