Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E640CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D57ED20862
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Yl2TS2xa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfJaN2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:28:11 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51838 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbfJaN2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:28:11 -0400
Received: from pendragon.ideasonboard.com (lmontsouris-658-1-103-151.w92-154.abo.wanadoo.fr [92.154.14.151])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6711A320;
        Thu, 31 Oct 2019 14:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1572528489;
        bh=fyvh80DRgyI9E6PTPAl80n4Ep0JkBrHpvJt615thuBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yl2TS2xaE6HWYahAVg9MatuaPiBE5dz3WaV0c4HjBNygbm7ZCK4ayTvTy0lbm7MYm
         wuqSLpRlO1uoDDZ/XxPscACHzvqnn9knAqOCaNwVHNITY7heiPBs1BEx1vrR+DnCCr
         oz26aNCVH/kdN+hC00kxvo2HXaXg+95peRZ2iueU=
Date:   Thu, 31 Oct 2019 15:28:01 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     mchehab@kernel.org, robh+dt@kernel.org, sakari.ailus@iki.fi,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com, peter.griffin@linaro.org
Subject: Re: [PATCH v4 0/2] Add IMX296 CMOS image sensor support
Message-ID: <20191031132801.GC5018@pendragon.ideasonboard.com>
References: <20191030094902.32582-1-manivannan.sadhasivam@linaro.org>
 <20191031131644.GA8917@pendragon.ideasonboard.com>
 <20191031132352.GA24273@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191031132352.GA24273@mani>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,

On Thu, Oct 31, 2019 at 06:53:52PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Oct 31, 2019 at 03:16:44PM +0200, Laurent Pinchart wrote:
> > On Wed, Oct 30, 2019 at 03:19:00PM +0530, Manivannan Sadhasivam wrote:
> > > Hello,
> > > 
> > > This patchset adds support for IMX296 CMOS image sensor from Sony.
> > > Sensor can be programmed through I2C and 4-wire interface but the
> > > current driver only supports I2C interface. The sensor is
> > > capable of outputting frames in CSI2 format (1 Lane). In the case
> > > of sensor resolution, driver only supports 1440x1088 at 30 FPS.
> > > 
> > > The driver has been validated using Framos IMX296 module interfaced to
> > > 96Boards Dragonboard410c.
> > 
> > I've just been made aware of your work. I also worked on an IMX296
> > sensor driver in parallel, which I will post to the list. My driver
> > doesn't hardcode the resolution but computes register values at runtime,
> > so I wonder if it could be a better option. I'll post it now.
> 
> I'm fine with it. The reason the driver is simple in the first place is, that's
> how my usual workflow is. Start small and build it big ;-)
> 
> Anyway, I'm happy if your driver gets in.

My driver sometimes has trouble finding the sensor at probe time, so
I'll study and try your code too. It could be a problem specific to my
platform (I'm testing on a custom i.MX7 board).

> > > Changes in v4:
> > > 
> > > * Fixed issues related to gain settings and few misc cleanups in driver
> > > * Documented port node and removed maxItems, default prop from dt binding
> > >   as per the review
> > > 
> > > Changes in v3:
> > > 
> > > * Fixed the reference to video-interfaces.txt in binding.
> > > 
> > > Changes in v2:
> > > 
> > > * Switched to YAML binding
> > > 
> > > Manivannan Sadhasivam (2):
> > >   dt-bindings: media: i2c: Add IMX296 CMOS sensor binding
> > >   media: i2c: Add IMX296 CMOS image sensor driver
> > > 
> > >  .../devicetree/bindings/media/i2c/imx296.yaml |  94 +++
> > >  MAINTAINERS                                   |   8 +
> > >  drivers/media/i2c/Kconfig                     |  11 +
> > >  drivers/media/i2c/Makefile                    |   1 +
> > >  drivers/media/i2c/imx296.c                    | 715 ++++++++++++++++++
> > >  5 files changed, 829 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/i2c/imx296.yaml
> > >  create mode 100644 drivers/media/i2c/imx296.c

-- 
Regards,

Laurent Pinchart
