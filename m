Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF5C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A41208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 20:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfITUbs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 16:31:48 -0400
Received: from mailoutvs10.siol.net ([185.57.226.201]:59652 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727518AbfITUbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 16:31:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 3AB16521EC2;
        Fri, 20 Sep 2019 22:31:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id daZqV_zAxHsF; Fri, 20 Sep 2019 22:31:43 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id D37B5523A05;
        Fri, 20 Sep 2019 22:31:43 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 7B168523890;
        Fri, 20 Sep 2019 22:31:43 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Roman Stratiienko <roman.stratiienko@globallogic.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: drm/sun4i: Add missing pixel formats to the vi layer
Date:   Fri, 20 Sep 2019 22:31:43 +0200
Message-ID: <12552832.EO9JtDEgEE@jernej-laptop>
In-Reply-To: <CAODwZ7uonAyhJAwZ+NFm_aHzC1Rzp=NyhQCu1h_85ecRxZ50cw@mail.gmail.com>
References: <20190918110541.38124-1-roman.stratiienko@globallogic.com> <9229663.7SG9YZCNdo@jernej-laptop> <CAODwZ7uonAyhJAwZ+NFm_aHzC1Rzp=NyhQCu1h_85ecRxZ50cw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 20. september 2019 ob 22:22:44 CEST je Roman Stratiienko 
napisal(a):
> On Thu, Sep 19, 2019 at 9:53 PM Jernej Škrabec <jernej.skrabec@siol.net> 
wrote:
> > Hi!
> > 
> > Dne sreda, 18. september 2019 ob 13:05:41 CEST je
> > 
> > roman.stratiienko@globallogic.com napisal(a):
> > > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > > 
> > > According to Allwinner DE2.0 Specification REV 1.0, vi layer supports
> > > the
> > > following pixel formats:  ABGR_8888, ARGB_8888, BGRA_8888, RGBA_8888
> > 
> > It's true that DE2 VI layers support those formats, but it wouldn't change
> > anything because alpha blending is not supported by those planes. These
> > formats were deliberately left out because their counterparts without
> > alpha
> > exist, for example ABGR8888 <-> XBGR8888. It would also confuse user,
> > which
> > would expect that alpha blending works if format with alpha channel is
> > selected.
> > 
> > Admittedly some formats with alpha are still reported as supported due to
> > lack of their counterparts without alpha, but I'm fine with removing them
> > for consistency.

I checked again and appropriate formats (with "X" instead of "A") already 
exist.

> 
> Why not to replace 'A' with 'X' on all relevant formats and map them
> to corresponding index marked with 'A' (that behaves as true 'X' for
> vi)

Yes, that's would be best.

Best regards,
Jernej

> 
> > Best regards,
> > Jernej
> > 
> > > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > > ---
> > > 
> > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index
> > > bd0e6a52d1d8..07c27e6a4b77
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > > @@ -404,17 +404,21 @@ static const struct drm_plane_funcs
> > > sun8i_vi_layer_funcs = { static const u32 sun8i_vi_layer_formats[] = {
> > > 
> > >       DRM_FORMAT_ABGR1555,
> > >       DRM_FORMAT_ABGR4444,
> > > 
> > > +     DRM_FORMAT_ABGR8888,
> > > 
> > >       DRM_FORMAT_ARGB1555,
> > >       DRM_FORMAT_ARGB4444,
> > > 
> > > +     DRM_FORMAT_ARGB8888,
> > > 
> > >       DRM_FORMAT_BGR565,
> > >       DRM_FORMAT_BGR888,
> > >       DRM_FORMAT_BGRA5551,
> > >       DRM_FORMAT_BGRA4444,
> > > 
> > > +     DRM_FORMAT_BGRA8888,
> > > 
> > >       DRM_FORMAT_BGRX8888,
> > >       DRM_FORMAT_RGB565,
> > >       DRM_FORMAT_RGB888,
> > >       DRM_FORMAT_RGBA4444,
> > >       DRM_FORMAT_RGBA5551,
> > > 
> > > +     DRM_FORMAT_RGBA8888,
> > > 
> > >       DRM_FORMAT_RGBX8888,
> > >       DRM_FORMAT_XBGR8888,
> > >       DRM_FORMAT_XRGB8888,




