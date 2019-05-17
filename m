Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FF4C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681BA2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbfEQQNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:13:25 -0400
Received: from foss.arm.com ([217.140.101.70]:45316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfEQQNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:13:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21C5F1715;
        Fri, 17 May 2019 09:13:25 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1C343F575;
        Fri, 17 May 2019 09:13:24 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 1351468240D; Fri, 17 May 2019 17:13:23 +0100 (BST)
Date:   Fri, 17 May 2019 17:13:23 +0100
From:   "liviu.dudau@arm.com" <liviu.dudau@arm.com>
To:     Wen He <wen.he_1@nxp.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>
Subject: Re: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for required
 pixel clock rate
Message-ID: <20190517161322.GE15144@e110455-lin.cambridge.arm.com>
References: <20190515024348.43642-1-wen.he_1@nxp.com>
 <3f87b2a7-c7e8-0597-2f62-d421aa6ccaa5@arm.com>
 <AM0PR04MB4865435E9FA2D61E2D9A238EE20A0@AM0PR04MB4865.eurprd04.prod.outlook.com>
 <edd9dc6c-aba2-3881-3121-efee388b47cf@arm.com>
 <AM0PR04MB4865EC817EB0B441D4042D38E20B0@AM0PR04MB4865.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM0PR04MB4865EC817EB0B441D4042D38E20B0@AM0PR04MB4865.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 10:37:01AM +0000, Wen He wrote:
> 
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > Sent: 2019年5月16日 18:45
> > To: Wen He <wen.he_1@nxp.com>; dri-devel@lists.freedesktop.org;
> > linux-kernel@vger.kernel.org; liviu.dudau@arm.com
> > Cc: Leo Li <leoyang.li@nxp.com>
> > Subject: Re: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for required
> > pixel clock rate
> > 
> > 
> > On 16/05/2019 10:42, Wen He wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Robin Murphy [mailto:robin.murphy@arm.com]
> > >> Sent: 2019年5月16日 1:14
> > >> To: Wen He <wen.he_1@nxp.com>; dri-devel@lists.freedesktop.org;
> > >> linux-kernel@vger.kernel.org; liviu.dudau@arm.com
> > >> Cc: Leo Li <leoyang.li@nxp.com>
> > >> Subject: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for
> > >> required pixel clock rate
> > >>
> > >> Caution: EXT Email
> > >>
> > >> On 15/05/2019 03:42, Wen He wrote:
> > >>> Disable checking for required pixel clock rate if ARCH_LAYERSCPAE is
> > >>> enable.
> > >>>
> > >>> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> > >>> Signed-off-by: Wen He <wen.he_1@nxp.com>
> > >>> ---
> > >>> change in description:
> > >>>        - This check that only supported one pixel clock required clock
> > rate
> > >>>        compare with dts node value. but we have supports 4 pixel clock
> > >>>        for ls1028a board.
> > >>>    drivers/gpu/drm/arm/malidp_crtc.c | 2 ++
> > >>>    1 file changed, 2 insertions(+)
> > >>>
> > >>> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c
> > >>> b/drivers/gpu/drm/arm/malidp_crtc.c
> > >>> index 56aad288666e..bb79223d9981 100644
> > >>> --- a/drivers/gpu/drm/arm/malidp_crtc.c
> > >>> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
> > >>> @@ -36,11 +36,13 @@ static enum drm_mode_status
> > >>> malidp_crtc_mode_valid(struct drm_crtc *crtc,
> > >>>
> > >>>        if (req_rate) {
> > >>>                rate = clk_round_rate(hwdev->pxlclk, req_rate);
> > >>> +#ifndef CONFIG_ARCH_LAYERSCAPE
> > >>
> > >> What about multiplatform builds? The kernel config doesn't tell you
> > >> what hardware you're actually running on.
> > >>
> > >
> > > Hi Robin,
> > >
> > > Thanks for your reply.
> > >
> > > In fact, Only one platform integrates this IP when
> > CONFIG_ARCH_LAYERSCAPE is set.
> > > Although this are not good ways, but I think it won't be a problem under
> > multiplatform builds.
> > 
> > My point is that ARCH_LAYERSCAPE is going to be enabled in distribution
> > kernels along with everything else, so you're effectively removing this check for
> > all other vendors' Mali-DP implementations as well, which is probably not OK.
> > 
> > Furthermore, if LS1028A really only supports 4 specific modes as the BSP
> > documentation I found claims, then surely you'd want a *more* specific check
> > here, rather than no check at all?
> 
> Hi Robin,
> 
> Thanks for your comments.
> 
> Yes, As you said, now LS1028A only supports 4 modes, and we use three clocks to support
> all four modes. In fact, this was really the point.
> 
> However, we can only enable one mode to meet the check statement in this place.
> 
> For example, If user has a 1080p monitor, we must be set the pixel fixed-clock to 148.5MHz. 
> if user want to choice 4k monitor, we also to be change the pixel fixed-clock to 594MHz in
> DT node. In reality, We have no way of knowing what kind of monitor the user wants. Right?

How does your DT know which monitor the user is going to plug in? Like I've
said, if you expose the mechanism you use to set the fixed-clock to a certain
value via the clk provider then you will be able to switch automatically to
that frequency without your patch.

Best regards,
Liviu

> 
> Moreover, user cannot to change screen resolution in this case, I don't think this place is
> reasonable. we need to supporting Ubuntu , Wayland and other embedded GU, so we need
> to switch the resolutions.
> 
> Maybe it's that most android device used, and android system always only need one
> resolution.
> 
> Best Regards,
> Wen
> 
> > 
> > Robin.

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
