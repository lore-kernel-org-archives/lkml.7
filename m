Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E79C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C124A2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 01:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VmVfFMY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfFXB6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 21:58:06 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:54192 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfFXB6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 21:58:06 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 115892E7;
        Mon, 24 Jun 2019 01:32:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1561332766;
        bh=ZwQFWKzylctm08JmQty7ouBHLLmW49Cc/PVD4oe55bw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=VmVfFMY8V1HSANbboGANKSV49ISdL/edBWNI5njU/0h59r7/z/3CNcCQ/iz/Hl7VI
         P3RlGCykuwWCZ2GniYPHndCKSgxtCOAfv+/PkjuhnBTenhDBxtjdSDPCVy4+aD97VD
         f9HK/fpZfAg8LZuiDTuGovSPYWtYwvVWuxVF4QGo=
Date:   Mon, 24 Jun 2019 02:30:17 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "zhengyang@rock-chips.com" <zhengyang@rock-chips.com>
Subject: Re: [PATCH 0/4] drm/bridge: dw-hdmi: Add support for HDR metadata
Message-ID: <20190623233017.GI6124@pendragon.ideasonboard.com>
References: <VI1PR03MB420621617DDEAB3596700DE0AC1C0@VI1PR03MB4206.eurprd03.prod.outlook.com>
 <085dc3be-20e5-b2fe-4c02-bf4a4d1473da@baylibre.com>
 <20190621090125.GX12905@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190621090125.GX12905@phenom.ffwll.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:01:25AM +0200, Daniel Vetter wrote:
> On Thu, Jun 20, 2019 at 04:40:12PM +0200, Neil Armstrong wrote:
> > Hi Andrzej,
> > 
> > Gentle ping, could you review the dw-hdmi changes here ?
> 
> btw not sure you absolutely need review from Andrzej, we're currently a
> bit undersupplied with bridge reviewers I think ... Better to ramp up
> more.

I try to review DRM bridge patches when possible, but dw-hdmi is a
special case. I was told by the supplier of an SoC datasheet that
contains the HDMI encoder IP core documentation that Synopsys required
them to route all contributions made based on that documentation through
Synopsys' internal legal review before publishing them. I thus decided
to not contribute to the driver anymore, at least for areas that require
access to documentation.

> > On 26/05/2019 23:18, Jonas Karlman wrote:
> > > Add support for HDR metadata using the hdr_output_metadata connector property,
> > > configure Dynamic Range and Mastering InfoFrame accordingly.
> > > 
> > > A drm_infoframe flag is added to dw_hdmi_plat_data that platform drivers
> > > can use to signal when Dynamic Range and Mastering infoframes is supported.
> > > This flag is needed because Amlogic GXBB and GXL report same DW-HDMI version,
> > > and only GXL support DRM InfoFrame.
> > > 
> > > The first patch add functionality to configure DRM InfoFrame based on the
> > > hdr_output_metadata connector property.
> > > 
> > > The remaining patches sets the drm_infoframe flag on some SoCs supporting
> > > Dynamic Range and Mastering InfoFrame.
> > > 
> > > Note that this was based on top of drm-misc-next and Neil Armstrong's
> > > "drm/meson: Add support for HDMI2.0 YUV420 4k60" series at [1]
> > > 
> > > [1] https://patchwork.freedesktop.org/series/58725/#rev2
> > > 
> > > Jonas Karlman (4):
> > >   drm/bridge: dw-hdmi: Add Dynamic Range and Mastering InfoFrame support
> > >   drm/rockchip: Enable DRM InfoFrame support on RK3328 and RK3399
> > >   drm/meson: Enable DRM InfoFrame support on GXL, GXM and G12A
> > >   drm/sun4i: Enable DRM InfoFrame support on H6
> > > 
> > >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c   | 109 ++++++++++++++++++++
> > >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.h   |  37 +++++++
> > >  drivers/gpu/drm/meson/meson_dw_hdmi.c       |   5 +
> > >  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   2 +
> > >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c       |   2 +
> > >  drivers/gpu/drm/sun4i/sun8i_dw_hdmi.h       |   1 +
> > >  include/drm/bridge/dw_hdmi.h                |   1 +
> > >  7 files changed, 157 insertions(+)

-- 
Regards,

Laurent Pinchart
