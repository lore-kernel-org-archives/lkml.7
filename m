Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156FAFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88CE2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 14:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbfKHOHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:07:12 -0500
Received: from gloria.sntech.de ([185.11.138.130]:59180 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfKHOHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 09:07:12 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iT4uS-0001Tu-Pp; Fri, 08 Nov 2019 15:06:44 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Wambui Karuga <wambui.karugax@gmail.com>
Cc:     Sean Paul <sean@poorly.run>, hjc@rock-chips.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: use DRM_DEV_ERROR for log output
Date:   Fri, 08 Nov 2019 15:06:44 +0100
Message-ID: <4996186.DxzAFJqeGu@diego>
In-Reply-To: <20191108124630.GA10207@wambui>
References: <20191107092945.15513-1-wambui.karugax@gmail.com> <20191107133851.GF63329@art_vandelay> <20191108124630.GA10207@wambui>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[it seems your Reply-To mail header is set strangely as
Reply-To: 20191107133851.GF63329@art_vandelay
which confuses my MTA]

Am Freitag, 8. November 2019, 13:46:30 CET schrieb Wambui Karuga:
> On Thu, Nov 07, 2019 at 08:38:51AM -0500, Sean Paul wrote:
> > On Thu, Nov 07, 2019 at 01:54:22AM -0800, Joe Perches wrote:
> > > On Thu, 2019-11-07 at 12:29 +0300, Wambui Karuga wrote:
> > > > Replace the use of the dev_err macro with the DRM_DEV_ERROR
> > > > DRM helper macro.
> > > 
> > > The commit message should show the reason _why_ you are doing
> > > this instead of just stating that you are doing this.
> > > 
> > > It's not that dev_err is uncommon in drivers/gpu/drm.
> > > 
> > 
> > It is uncommon (this is the sole instance) in rockchip, however. So it makes
> > sense to convert the dev_* prints in rockchip to DRM_DEV for consistency.
> > 
> > Wambui, could you also please convert the dev_warn instance as well?
> > 
> Hey, Sean.
> Trying to convert this dev_warn instance, but the corresponding DRM_WARN
> macro does not take the dev parameter which seems to be useful in the
> original output.
> Should I still convert it to DRM_WARN without the hdmi->dev parameter?

There exists DRM_DEV_ERROR, DRM_DEV_INFO and DRM_DEV_DEBUG to
handle actual devices. Interestingly there is no DRM_DEV_WARN though.

So depending on what Sean suggest another option would be to add the
missing DRM_DEV_WARN and then use it to replace the dev_warn.


Heiko



> 
> Thanks,
> wambui
> > I'll apply this to drm-misc-next and expand on the commit message a bit.
> > 
> > Thanks,
> > 
> > Sean
> > 
> > > $ git grep -w dev_err drivers/gpu/drm | wc -l
> > > 1950
> > > $ git grep -w DRM_DEV_ERROR drivers/gpu/drm | wc -l
> > > 756
> > > 
> > > > diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
> > > []
> > > > @@ -916,7 +916,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
> > > >  	}
> > > >  
> > > >  	if (!dsi->cdata) {
> > > > -		dev_err(dev, "no dsi-config for %s node\n", np->name);
> > > > +		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
> > > >  		return -EINVAL;
> > > >  	}
> > > 
> > > 
> > > 
> > > _______________________________________________
> > > dri-devel mailing list
> > > dri-devel@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> 




