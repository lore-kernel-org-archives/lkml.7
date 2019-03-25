Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84964C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446002075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 06:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfCYGSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 02:18:30 -0400
Received: from mailoutvs10.siol.net ([185.57.226.201]:45559 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729568AbfCYGSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 02:18:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 5F30D521313;
        Mon, 25 Mar 2019 07:18:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GspQSRoBxfG7; Mon, 25 Mar 2019 07:18:27 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id D7E7B5212F2;
        Mon, 25 Mar 2019 07:18:26 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-86-58-52-202.static.triera.net [86.58.52.202])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 1ADD552139E;
        Mon, 25 Mar 2019 07:18:25 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     maxime.ripard@bootlin.com, a.hajda@samsung.com, airlied@linux.ie,
        daniel@ffwll.ch, wens@csie.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] drm/bridge/synopsys: dw-hdmi: Add an option to suppress loading CEC driver
Date:   Mon, 25 Mar 2019 07:18:24 +0100
Message-ID: <2258732.39EEuFg67f@jernej-laptop>
In-Reply-To: <20190325013531.GB4540@pendragon.ideasonboard.com>
References: <20190324212144.3652-1-jernej.skrabec@siol.net> <20190324212144.3652-2-jernej.skrabec@siol.net> <20190325013531.GB4540@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 25. marec 2019 ob 02:35:31 CET je Laurent Pinchart napisal(a):
> Hi Jernej,
> 
> Thank you for the patch.
> 
> On Sun, Mar 24, 2019 at 10:21:42PM +0100, Jernej Skrabec wrote:
> > DW HDMI controller on some Allwinner SoCs has support for CEC, but due
> > to additional logic put between CEC controller and pins, it doesn't work
> > correctly, at least not with a lot of instrusive changes. Fortunately,
> > it's still possible to bitbang protocol.
> > 
> > For such cases, add a platform option to suppress loading CEC driver. If
> > DW HDMI CEC driver would be loaded, it wouldn't work anyway and only
> > cause a confusion with multiple /dev entries.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 2 +-
> >  include/drm/bridge/dw_hdmi.h              | 2 ++
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c index
> > a63e5f0dae56..fdda26f8b056 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -2634,7 +2634,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
> > 
> >  		hdmi->audio = platform_device_register_full(&pdevinfo);
> >  	
> >  	}
> > 
> > -	if (config0 & HDMI_CONFIG0_CEC) {
> > +	if (!plat_data->is_cec_unusable && (config0 & HDMI_CONFIG0_CEC)) {
> > 
> >  		cec.hdmi = hdmi;
> >  		cec.ops = &dw_hdmi_cec_ops;
> >  		cec.irq = irq;
> > 
> > diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
> > index 66e70770cce5..764b8bcfa62c 100644
> > --- a/include/drm/bridge/dw_hdmi.h
> > +++ b/include/drm/bridge/dw_hdmi.h
> > @@ -144,6 +144,8 @@ struct dw_hdmi_plat_data {
> > 
> >  	int (*configure_phy)(struct dw_hdmi *hdmi,
> >  	
> >  			     const struct dw_hdmi_plat_data *pdata,
> >  			     unsigned long mpixelclock);
> > 
> > +
> > +	unsigned int is_cec_unusable : 1;
> 
> Strictly speaking your CEC controller isn't unusable, it's just a bit
> difficult to use it according to your commit message. Would disable_cec
> be a more appropriate field name ? And how difficult would it be to
> support the hardware CEC controller, would that result in changes that
> could be useful to other vendors too ?

Ok, maybe naming of the variable is a bit harsh. Currently I don't know any 
other hardware with the same issue. While I don't know CEC protocol or DW HDMI 
CEC controller very well, I think it would be difficult to implement change of 
direction during ACK transmission. At that time, packet is not fully received 
or transmitted, so I doubt we could use any interrupt for that. In any case, I 
don't think it's worth the hassle and we should just use proven software 
implementation.

Early attempt on fixing this on kernel provided by Allwinner resulted in very 
ugly code and I'm not sure it works 100% (driver based on i.MX6 one):
https://github.com/jernejsk/OpenELEC-OPi2/blob/openelec-7.0/projects/H3/
patches/linux/linux-008-add-hw-hdmi-cec-support.patch#L1321

> 
> >  };
> >  
> >  struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,




