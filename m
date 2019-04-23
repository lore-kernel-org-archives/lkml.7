Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6BCC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62EDB206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="D6jgEDFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfDWMvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:51:07 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:51434 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWMvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:51:06 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B025E5F;
        Tue, 23 Apr 2019 14:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556023863;
        bh=fMsj4MfaMmrN9B+gwEZ2g5G6brfCXed+7WelLvVEGTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6jgEDFXNhY18UGvcM3sIIROklSGbKNbWccu7hx7qaz8HgahL1sRSsjYWzAbhXino
         +QV8jL0d1TNl8ENkokxBS66CI68p6iCcRryP81vVz0J0de2rePjdTqHmfCnJGJydKG
         9CcEH6YVMFVxfBZR4JkP19KKTrDAfimpKw9pYLb8=
Date:   Tue, 23 Apr 2019 15:50:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/bridge: dw-hdmi: fix SCDC configuration for
 ddc-i2c-bus
Message-ID: <20190423125054.GB4816@pendragon.ideasonboard.com>
References: <VE1PR03MB59031814B5BCAB2152923BDAAC210@VE1PR03MB5903.eurprd03.prod.outlook.com>
 <2275367.P1g2IIHPGP@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2275367.P1g2IIHPGP@phil>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 12:26:02PM +0200, Heiko Stuebner wrote:
> Am Sonntag, 21. April 2019, 10:25:50 CEST schrieb Jonas Karlman:
> > When ddc-i2c-bus property is used, a NULL pointer dereference is reported:
> > 
> > [   31.041669] Unable to handle kernel NULL pointer dereference at virtual address 00000008
> > [   31.041671] pgd = 4d3c16f6
> > [   31.041673] [00000008] *pgd=00000000
> > [   31.041678] Internal error: Oops: 5 [#1] SMP ARM
> > 
> > [   31.041711] Hardware name: Rockchip (Device Tree)
> > [   31.041718] PC is at i2c_transfer+0x8/0xe4
> > [   31.041721] LR is at drm_scdc_read+0x54/0x84
> > [   31.041723] pc : [<c073273c>]    lr : [<c05926c4>]    psr: 280f0013
> > [   31.041725] sp : edffdad0  ip : 5ccb5511  fp : 00000058
> > [   31.041727] r10: 00000780  r9 : edf91608  r8 : c11b0f48
> > [   31.041728] r7 : 00000438  r6 : 00000000  r5 : 00000000  r4 : 00000000
> > [   31.041730] r3 : edffdae7  r2 : 00000002  r1 : edffdaec  r0 : 00000000
> > 
> > [   31.041908] [<c073273c>] (i2c_transfer) from [<c05926c4>] (drm_scdc_read+0x54/0x84)
> > [   31.041913] [<c05926c4>] (drm_scdc_read) from [<c0592858>] (drm_scdc_set_scrambling+0x30/0xbc)
> > [   31.041919] [<c0592858>] (drm_scdc_set_scrambling) from [<c05cc0f4>] (dw_hdmi_update_power+0x1440/0x1610)
> > [   31.041926] [<c05cc0f4>] (dw_hdmi_update_power) from [<c05cc574>] (dw_hdmi_bridge_enable+0x2c/0x70)
> > [   31.041932] [<c05cc574>] (dw_hdmi_bridge_enable) from [<c05aed48>] (drm_bridge_enable+0x24/0x34)
> > [   31.041938] [<c05aed48>] (drm_bridge_enable) from [<c0591060>] (drm_atomic_helper_commit_modeset_enables+0x114/0x220)
> > [   31.041943] [<c0591060>] (drm_atomic_helper_commit_modeset_enables) from [<c05c3fe0>] (rockchip_atomic_helper_commit_tail_rpm+0x28/0x64)
> > 
> > hdmi->i2c may not be set when ddc-i2c-bus property is used in device tree.
> > Fix this by using hdmi->ddc as the i2c adapter when calling drm_scdc_*().
> > Also report that SCDC is not supported when there is no DDC bus.
> > 
> > Fixes: 264fce6cc2c1 ("drm/bridge: dw-hdmi: Add SCDC and TMDS Scrambling support")
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> 
> I've looked that up and yeah, hdmi->ddc seems the right thing to use
> as it points either to the external i2c or the internal one, so
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

That matches my own analysis,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index 7a47c65d8ecb..fd1c319a4ee0 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -1046,6 +1046,10 @@ static bool dw_hdmi_support_scdc(struct dw_hdmi *hdmi)
> >  	if (hdmi->version < 0x200a)
> >  		return false;
> >  
> > +	/* Disable if no DDC bus */
> > +	if (!hdmi->ddc)
> > +		return false;
> > +
> >  	/* Disable if SCDC is not supported, or if an HF-VSDB block is absent */
> >  	if (!display->hdmi.scdc.supported ||
> >  	    !display->hdmi.scdc.scrambling.supported)
> > @@ -1683,13 +1687,13 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
> >  			 * Source Devices compliant shall set the
> >  			 * Source Version = 1.
> >  			 */
> > -			drm_scdc_readb(&hdmi->i2c->adap, SCDC_SINK_VERSION,
> > +			drm_scdc_readb(hdmi->ddc, SCDC_SINK_VERSION,
> >  				       &bytes);
> > -			drm_scdc_writeb(&hdmi->i2c->adap, SCDC_SOURCE_VERSION,
> > +			drm_scdc_writeb(hdmi->ddc, SCDC_SOURCE_VERSION,
> >  				min_t(u8, bytes, SCDC_MIN_SOURCE_VERSION));
> >  
> >  			/* Enabled Scrambling in the Sink */
> > -			drm_scdc_set_scrambling(&hdmi->i2c->adap, 1);
> > +			drm_scdc_set_scrambling(hdmi->ddc, 1);
> >  
> >  			/*
> >  			 * To activate the scrambler feature, you must ensure
> > @@ -1705,7 +1709,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
> >  			hdmi_writeb(hdmi, 0, HDMI_FC_SCRAMBLER_CTRL);
> >  			hdmi_writeb(hdmi, (u8)~HDMI_MC_SWRSTZ_TMDSSWRST_REQ,
> >  				    HDMI_MC_SWRSTZ);
> > -			drm_scdc_set_scrambling(&hdmi->i2c->adap, 0);
> > +			drm_scdc_set_scrambling(hdmi->ddc, 0);
> >  		}
> >  	}
> >  

-- 
Regards,

Laurent Pinchart
