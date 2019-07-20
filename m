Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934ADC76186
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 21:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6767F2082A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 21:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfGTVJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 17:09:29 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:45572 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfGTVJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 17:09:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 6A16EFB03;
        Sat, 20 Jul 2019 23:09:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lt3q_07BvhWh; Sat, 20 Jul 2019 23:09:23 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id ABB364017E; Sat, 20 Jul 2019 23:09:22 +0200 (CEST)
Date:   Sat, 20 Jul 2019 23:09:22 +0200
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     "marex@denx.de" <marex@denx.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [EXT] Re: [PATCH 00/10] Improvements and fixes for mxsfb DRM
 driver
Message-ID: <20190720210922.GA464@bogon.m.sigxcpu.org>
References: <1561555938-21595-1-git-send-email-robert.chiras@nxp.com>
 <20190711150403.GB23195@bogon.m.sigxcpu.org>
 <1562919331.3209.11.camel@nxp.com>
 <20190716145450.GA609@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190716145450.GA609@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
On Tue, Jul 16, 2019 at 04:54:50PM +0200, Guido Günther wrote:
> Hi Robert,
> On Fri, Jul 12, 2019 at 08:15:32AM +0000, Robert Chiras wrote:
> > Hi Guido,
> > 
> > On Jo, 2019-07-11 at 17:04 +0200, Guido Günther wrote:
> > > Hi Robert,
> > > On Wed, Jun 26, 2019 at 04:32:08PM +0300, Robert Chiras wrote:
> > > > 
> > > > This patch-set improves the use of eLCDIF block on iMX 8 SoCs (like
> > > > 8MQ, 8MM
> > > > and 8QXP). Following, are the new features added and fixes from
> > > > this
> > > > patch-set:
> > > > 
> > > > 1. Add support for drm_bridge
> > > > On 8MQ and 8MM, the LCDIF block is not directly connected to a
> > > > parallel
> > > > display connector, where an LCD panel can be attached, but instead
> > > > it is
> > > > connected to DSI controller. Since this DSI stands between the
> > > > display
> > > > controller (eLCDIF) and the physical connector, the DSI can be
> > > > implemented
> > > > as a DRM bridge. So, in order to be able to connect the mxsfb
> > > > driver to
> > > > the DSI driver, the support for a drm_bridge was needed in mxsfb
> > > > DRM
> > > > driver (the actual driver for the eLCDIF block).
> > > So I wanted to test this but with both my somewhat cleaned up nwl
> > > driver¹ and the nwl driver forward ported from the nxp vendor tree
> > > I'm
> > > looking at a black screen with current mainline - while my dcss
> > > forward
> > > port gives me nice output on mipi dsi. Do you have a tree that uses
> > > mipi
> > > dsi on imx8mq where I could look at to check for differences?
> > Somewhere on the pixel path (between the display controller and the
> > DSI) there is a block that inverts the polarity. I can't remember
> > exactly what was the role of this block, but the polarity is inverted
> > when eLCDIF is used in combination with the DSI.
> > If you take a look at my DSI driver from NXP releases (I guess you have
> > them), you will see there is a hack in mode_fixup:
> > 
> > unsigned int *flags = &mode->flags;
> > if (dsi->sync_pol {
> > 	*flags |= DRM_MODE_FLAG_PHSYNC;
> > 	*flags |= DRM_MODE_FLAG_PVSYNC;
> > 	*flags &= ~DRM_MODE_FLAG_NHSYNC;
> > 	*flags &= ~DRM_MODE_FLAG_NVSYNC;
> > } else {
> > 	*flags &= ~DRM_MODE_FLAG_PHSYNC;
> > 	*flags &= ~DRM_MODE_FLAG_PVSYNC;
> > 	*flags |= DRM_MODE_FLAG_NHSYNC;
> > 	*flags |= DRM_MODE_FLAG_NVSYNC;
> > }
> 
> Thanks for the suggestion! I'll try that.
>
> > 
> > I know it's not clean, but it works for now. You can try this in your
> > driver and see if it helps.
> > These days I will also take your nwl-dsi driver and test it, and also
> > add support for bridge and eLCDIF to see if I can make it work.
> 
> I have hacky bridge support over here already. Give me some days to
> clean it up and it might safe you some work.

Your suggestion above (plus some other fixes) worked and
mxsfb+nwl+mixel-dphy works over here. I'll try to send a v1 of the nwl
driver out during the week.
Cheers,
 -- Guido

> Cheers,
>  -- Guido
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
