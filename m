Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530C2C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5A52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 11:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbfDQLBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 07:01:24 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:55319 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfDQLBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 07:01:24 -0400
Received: from localhost (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 38D5A200003;
        Wed, 17 Apr 2019 11:01:19 +0000 (UTC)
Date:   Wed, 17 Apr 2019 13:01:19 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH 04/20] drm/fourcc: Pass the format_info pointer to
 drm_format_plane_width/height
Message-ID: <20190417110119.ygp6h7kpzzo5a27l@flea>
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <194fd02a37172de6f2a799fee5c98ced5e7e9d76.1555487650.git-series.maxime.ripard@bootlin.com>
 <776131c6-b8be-4302-ea9a-f7d84203f28c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dcwfro6eoycpkuuy"
Content-Disposition: inline
In-Reply-To: <776131c6-b8be-4302-ea9a-f7d84203f28c@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dcwfro6eoycpkuuy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 12:47:48PM +0200, Maarten Lankhorst wrote:
> > +/**
> > + * drm_format_info_plane_width - width of the plane given the first plane
> > + * @format: pixel format info
> > + * @width: width of the first plane
> > + * @plane: plane index
> > + *
> > + * Returns:
> > + * The width of @plane, given that the width of the first plane is @width.
> > + */
> > +static inline
> > +int drm_format_info_plane_width(const struct drm_format_info *info, int width,
> > +				int plane)
> > +{
> > +	if (!info || plane >= info->num_planes)
> > +		return 0;
> > +
> > +	if (plane == 0)
> > +		return width;
> > +
> > +	return width / info->hsub;
> > +}
> > +
> > +/**
> > + * drm_format_info_plane_height - height of the plane given the first plane
> > + * @format: pixel format info
> > + * @height: height of the first plane
> > + * @plane: plane index
> > + *
> > + * Returns:
> > + * The height of @plane, given that the height of the first plane is @height.
> > + */
> > +static inline
> > +int drm_format_info_plane_height(const struct drm_format_info *info, int height,
> > +				 int plane)
> > +{
> > +	if (!info || plane >= info->num_planes)
> > +		return 0;
> > +
> > +	if (plane == 0)
> > +		return height;
> > +
> > +	return height / info->vsub;
> > +}
>
> Why the null checks? None of the other inlines for drm_format_info
> perform them.

Unless I'm mistaken, the subsampling only applies to the planes with
the chrominance, which are always >= 1. Therefore the plane 0 is
always the luminance, to which the subsampling doesn't apply.

Or are you talking about something else?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dcwfro6eoycpkuuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLcHfwAKCRDj7w1vZxhR
xSpmAPwKXGZNhBp2kZZZWrU1vBO0LBQUPntCvgviU70XWrnWGwEA6PwNOBbw5jIs
rDUiFVXJb415RVz6MZcP8QAJlhQleAY=
=4vey
-----END PGP SIGNATURE-----

--dcwfro6eoycpkuuy--
