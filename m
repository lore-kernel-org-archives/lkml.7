Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19421C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBAD206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Z0goq+VW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfDYSDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:03:05 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38460 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbfDYSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:03:05 -0400
Received: from pendragon.ideasonboard.com (net-37-182-44-227.cust.vodafonedsl.it [37.182.44.227])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9382A5F;
        Thu, 25 Apr 2019 20:03:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556215382;
        bh=GWgzd2FlAok889v50TdSHG8rqIenxkBS4jYH9ayUm9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z0goq+VWJ+2/MHScWEnhTwQ7fMl28WcYfKcVJJnoq3hZc4c30gHqRJA1py4kVI9vA
         GqkmgwAv5kVsjK1GSg3Hl4UNtT5R6Xy5W0aKeXRLqHTB2PX5AXJdg271wwtrJGXMvR
         OSMR+dQ3cw7m7aCnkPL5vi6DiTCbsbfXzZTkGRmU=
Date:   Thu, 25 Apr 2019 21:02:51 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Matt Redfearn <matt.redfearn@thinci.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Matthew Redfearn <matthew.redfearn@thinci.com>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Archit Taneja <architt@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] drm/bridge/synopsys: dsi: Don't blindly call post_disable
Message-ID: <20190425180251.GC12024@pendragon.ideasonboard.com>
References: <CGME20190424142210epcas3p403bd5159852ab4e90eca1be67800ecde@epcas3p4.samsung.com>
 <20190424142148.25927-1-matt.redfearn@thinci.com>
 <3da4c0a3-a77b-5128-63f7-9c8d6b012c68@samsung.com>
 <95c36782-7eaf-2224-bb52-cff0a53d98d8@thinci.com>
 <20190425175915.GB12024@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190425175915.GB12024@pendragon.ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 08:59:15PM +0300, Laurent Pinchart wrote:
> On Thu, Apr 25, 2019 at 12:39:27PM +0000, Matt Redfearn wrote:
> > On 25/04/2019 13:13, Andrzej Hajda wrote:
> >> On 24.04.2019 16:22, Matt Redfearn wrote:
> >>> The DRM documentation states that post_disable is an optional callback.
> >>> As such an implementing device may not populate it. To avoid panicing
> >>> the kernel by calling a NULL function pointer, we should NULL check it
> >>> before blindy calling it.
> >>>
> >>> Signed-off-by: Matt Redfearn <matt.redfearn@thinci.com>
> >> 
> >>> ---
> >>>
> >>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 3 ++-
> >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> >>> index 38e88071363..0ee440216b8 100644
> >>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> >>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
> >>> @@ -805,7 +805,8 @@ static void dw_mipi_dsi_bridge_post_disable(struct drm_bridge *bridge)
> >>>   	 * This needs to be fixed in the drm_bridge framework and the API
> >>>   	 * needs to be updated to manage our own call chains...
> >>>   	 */
> >>> -	dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
> >>> +	if (dsi->panel_bridge->funcs->post_disable)
> >>> +		dsi->panel_bridge->funcs->post_disable(dsi->panel_bridge);
> >>>   
> >> 
> >> Why not drm_bridge_post_disable ?
> > 
> > Ah - that seems like a nicer fix! Do you think the comment above 
> > describing why this function pointer is called directly can be removed 
> > as well if we go this route?
> 
> It shouldn't be necessary to call ->post_disable manually here as the
> bridge core handles it internally. This is a hack to work around a
> problem, and should be fixed properly.
> 
> > If someone calls drm_bridge_post_disable() on the Synposys DSI 
> > drm_bridge it will go on to call post_disable on all other bridges in 
> > the chain, in addition to us calling them here. Is it an issue to call 
> > it multiple times?
> 
> It depends on the panel implementation, but in general it's not a good
> idea. It may happen to work, but could break at any time in the future.

Double-checking the driver, the .attach() operation doesn't propagate to
the next bridge, so the bridge core will not know about it, and will not
propagate .post_disable() either. I think this should be fixed in a way
that uses the drm bridge core infrastructure.

> >>>   	if (dsi->slave) {
> >>>   		dw_mipi_dsi_disable(dsi->slave);

-- 
Regards,

Laurent Pinchart
