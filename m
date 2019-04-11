Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119EDC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FAC2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfDKPzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:55:46 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60793 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDKPzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:55:45 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 0BFC31C000C;
        Thu, 11 Apr 2019 15:55:40 +0000 (UTC)
Date:   Thu, 11 Apr 2019 17:55:40 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [RFC PATCH 18/20] lib: image-formats: Add v4l2 formats support
Message-ID: <20190411155540.poquzzx2apa5ahgb@flea>
References: <cover.92acdec88ee4c280cb74e08ea22f0075e5fa055c.1553032382.git-series.maxime.ripard@bootlin.com>
 <c97024b97d3261dcf41aad3c8bc1c5d9906f33c9.1553032382.git-series.maxime.ripard@bootlin.com>
 <3f5748a6422d2f7eb11601bad297df870ff5952b.camel@ndufresne.ca>
 <5385672c-cfee-7bc4-9c2e-e4d8d964b748@xs4all.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zlq2z5366q2vxuf"
Content-Disposition: inline
In-Reply-To: <5385672c-cfee-7bc4-9c2e-e4d8d964b748@xs4all.nl>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4zlq2z5366q2vxuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Apr 11, 2019 at 09:38:06AM +0200, Hans Verkuil wrote:
> >> @@ -149,6 +155,7 @@ static const struct image_format_info formats[] = {
> >>  		.has_alpha = true,
> >>  	}, {
> >>  		.drm_fmt = DRM_FORMAT_RGB565,
> >> +		.v4l2_fmt = V4L2_PIX_FMT_RGB565,
> >
> > -> V4L2_PIX_FMT_RGB565X
> >
> > Was added later, as what you expect is not compatible.
>
> All these 16-bit V4L2 pixelformats are ancient, but they are (to my knowledge)
> correct w.r.t. the documented layout of the bits in memory. I.e., that's what
> the hardware will give you.
>
> I think if there is no equivalence between the drm and v4l2 fourcc's, then
> you need two entries in this table, one for drm (v4l2_fmt == 0), one for v4l2
> (drm_fmt == 0).

Yeah, that was my plan. I'd definitely expect some formats in V4L2
while not supported by DRM, or the other way around.

> >> @@ -473,6 +496,7 @@ static const struct image_format_info formats[] = {
> >>  		.is_yuv = true,
> >>  	}, {
> >>  		.drm_fmt = DRM_FORMAT_NV24,
> >> +		.v4l2_fmt = V4L2_PIX_FMT_NV24,
> >
> > For extra fun, the M variant has not been added yet.
>
> Note that it has been the practice in V4L2 to avoid adding pixelformats unless
> they are in use by a V4L2 driver. So that's why some combinations do not exist.
>
> If we are creating a common library then I think we should change that rule
> to: "unless they are in use by a DRM or V4L2 driver". And when new formats are
> added, and they exists already for DRM or V4L2, then we should use the same
> fourcc for the other subsystem.
>
> I.e. if pixelformat V4L2_PIX_FMT_FOO was already defined, then add a:
>
> #define DRM_FORMAT_FOO V4L2_PIX_FMT_FOO
>
> rather than creating a new fourcc.

That makes sense

> We could even start looking at redoing the whole scheme in a unified way, but
> that's something for the (far) future.

Yeah, my secret plan is to have eventually a single fourcc (or even
#define) for both DRM and v4l2 for any new format. But don't tell
anyone :)

> This is already a big step forward.

Great, I'll respin this then.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--4zlq2z5366q2vxuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXK9jfAAKCRDj7w1vZxhR
xdJlAQCX/ejxdQlqYsc7uKU3WqAQ58yIuyHgkeKWJ9DIA/fmVAEAx4t6BCOAD9PO
8n2ksoAJZYjJniOKhV/5HHr9/khBhQ4=
=66eR
-----END PGP SIGNATURE-----

--4zlq2z5366q2vxuf--
