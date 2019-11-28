Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A3CC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D24021774
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 08:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Jia25AtA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfK1IKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 03:10:00 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:43838 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfK1IJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 03:09:59 -0500
Received: from pendragon.ideasonboard.com (unknown [104.132.253.101])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 36215729;
        Thu, 28 Nov 2019 09:09:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1574928597;
        bh=4275TLqavidGFPsDBkZNj9mIhffOCitIlDAiAtt5RTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jia25AtAMik5jIDCOTSO/dq60rdg6LyCZI64IGWVenk/0KEFt+8vxt//Cpd8yDmeD
         K1BEYSDAYIa4meJ77TzXpfkM4hRjVrsgmfHxhW21shJ8aI8mQPCeXq+dFxjJyzNIum
         5bXL5WVlhN2v+Buuzo0PlfFmA5oVvU4PPKvLS+GQ=
Date:   Thu, 28 Nov 2019 10:09:46 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 3/7] drm: rcar-du: Add support for CMM
Message-ID: <20191128080946.GF4711@pendragon.ideasonboard.com>
References: <20191113100556.15616-1-jacopo+renesas@jmondi.org>
 <20191113100556.15616-4-jacopo+renesas@jmondi.org>
 <CAMuHMdWS2bv=RhQ3y5gNzZFT6CeH-a+h7xc6KYvcv0Anht6zGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWS2bv=RhQ3y5gNzZFT6CeH-a+h7xc6KYvcv0Anht6zGw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Nov 28, 2019 at 08:56:14AM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 13, 2019 at 11:04 AM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > Add a driver for the R-Car Display Unit Color Correction Module.
> > In most of Gen3 SoCs, each DU output channel is provided with a CMM unit
> > to perform image enhancement and color correction.
> >
> > Add support for CMM through a driver that supports configuration of
> > the 1-dimensional LUT table. More advanced CMM features will be
> > implemented on top of this initial one.
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> > --- a/drivers/gpu/drm/rcar-du/Kconfig
> > +++ b/drivers/gpu/drm/rcar-du/Kconfig
> > @@ -5,6 +5,7 @@ config DRM_RCAR_DU
> >         depends on ARM || ARM64
> >         depends on ARCH_RENESAS || COMPILE_TEST
> >         imply DRM_RCAR_LVDS
> > +       imply DRM_RCAR_CMM
> >         select DRM_KMS_HELPER
> >         select DRM_KMS_CMA_HELPER
> >         select DRM_GEM_CMA_HELPER
> > @@ -13,6 +14,13 @@ config DRM_RCAR_DU
> >           Choose this option if you have an R-Car chipset.
> >           If M is selected the module will be called rcar-du-drm.
> >
> > +config DRM_RCAR_CMM
> > +       tristate "R-Car DU Color Management Module (CMM) Support"
> > +       depends on DRM && OF
> > +       depends on DRM_RCAR_DU
> 
> DRM_RCAR_DU already depends on DRM && OF, so the line above
> can be removed.

I've sent a pull request already. Can we address this on top ? Or is it
worth a separate patch, should we wait until we have to touch this and
then fix it in a "while at it" fashion ?

-- 
Regards,

Laurent Pinchart
