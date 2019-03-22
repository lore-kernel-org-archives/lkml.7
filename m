Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3385BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B54218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 18:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="LKFEWKOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfCVSLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 14:11:53 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45454 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfCVSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 14:11:53 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so3503317qtv.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 11:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version;
        bh=qz6cnN0BZcfG1DHSDh71YJmldkrRVU/OMC0SkuVzbnA=;
        b=LKFEWKOl+gs9s23UnFxaMp/3/FIXFe1oB4YZw4yIaa4KrxmYNwjNG0MbiOalLW3hE0
         TkCjwa+t8uVKJtA5cto3vuK3pUhayCFsRXMgmX5UcaAoeBufD7HmLlsRosRppNCCS33S
         6jVk3BsYryaRj8MdnIuCsRIuqagOc9a2cwKtHdQNKBAZP4IvbydDSYGKAaCGYzvhPAKY
         ync/MUMAC3EkBBEZxtqdhYy6/s/A8jqaQ6df39/ccUWwvmgST6Qj0YqOAtYsHutGEk2V
         JZdQCa0sdv01Pt3+0kgo5zLM5SmcNNJ5139+UwpC3pjciwZnL6Dc7s2y7f8qbP9n3wWZ
         OI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version;
        bh=qz6cnN0BZcfG1DHSDh71YJmldkrRVU/OMC0SkuVzbnA=;
        b=cNrIsSO0UUg31rjuzhy3MSahW2+gpK1CfVZdU0fK9EdvZao3cq1lEkZPLLY8fLHq1d
         a7b/fFgl1VLZ2EOeE9y1gPXZSw9ohGU06nE5KZHljcAng9jPEvB6y2vgHYuyrORXGFH+
         vU3ez7jzdiWw3FwBFKBdTYqcEBHbIeYJojagqFHt54H8h3H9+ibGT3pyAPkhiBY8HClm
         g6TfKch3LRgMlQdv890vHn0MISM7070XZuKscD9sMEdo53RQuylLg28C2BJ0xovTfT2X
         sbu2U+eRpQNwroMKBUtNXSu7/DfzLs5ala3ebjKPu/m8UzarDPqB8uEfuzW3UJzxJmxH
         RCIg==
X-Gm-Message-State: APjAAAU4UdebSk5sLS7hvMry47+DvlNkVRXz8p/zMpBM0Mpa6ZEMriHv
        oAUKYV91lxFMx9pfAX6ZQe4fqw==
X-Google-Smtp-Source: APXvYqxhl/Qyf5n9YMHMg8Lgfv6KShenKdkifJEel7Ath+/0Aztot51GhC5EIHQhGW/XYTqDf8Y8Ww==
X-Received: by 2002:aed:3608:: with SMTP id e8mr9484739qtb.31.1553278311515;
        Fri, 22 Mar 2019 11:11:51 -0700 (PDT)
Received: from tpx230-nicolas.collaboramtl (modemcable154.55-37-24.static.videotron.ca. [24.37.55.154])
        by smtp.gmail.com with ESMTPSA id i33sm1526204qtb.64.2019.03.22.11.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Mar 2019 11:11:50 -0700 (PDT)
Message-ID: <e80d10c4c0eff681d6356d0133c7b871ef588b6a.camel@ndufresne.ca>
Subject: Re: [RFC PATCH 18/20] lib: image-formats: Add v4l2 formats support
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org, Daniel Stone <daniels@collabora.com>
Date:   Fri, 22 Mar 2019 14:11:48 -0400
In-Reply-To: <20190322144210.GB3888@intel.com>
References: <20190320142739.GK3888@intel.com>
         <a13f7fdeaf1a5e97f21a6048da765705b59d64c2.camel@ndufresne.ca>
         <20190320160939.GR3888@intel.com>
         <f3f8749e30aad81bc39ed9b60cd308ac5f3c6707.camel@ndufresne.ca>
         <20190320164133.GT3888@intel.com>
         <d46b30ca8962d3c31b1273cf010ca9fb7b145fe8.camel@ndufresne.ca>
         <20190320183914.GV3888@intel.com>
         <46df4fb13636b90c147839b0aa5ad1ac33030461.camel@bootlin.com>
         <20190321163532.GG3888@intel.com>
         <ac5329d77f83af2804c240ebe479ec323b60aec3.camel@ndufresne.ca>
         <20190322144210.GB3888@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-mXZ6tifngVMDJDmbi+Oj"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mXZ6tifngVMDJDmbi+Oj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 22 mars 2019 =C3=A0 16:42 +0200, Ville Syrj=C3=A4l=C3=A4 a =C3=
=A9crit :
> On Thu, Mar 21, 2019 at 03:14:06PM -0400, Nicolas Dufresne wrote:
> > Le jeudi 21 mars 2019 =C3=A0 18:35 +0200, Ville Syrj=C3=A4l=C3=A4 a =C3=
=A9crit :
> > > > I'm not sure what it's worth, but there is a "pixel format guide"
> > > > project that is all about matching formats from one API to another:=
=20
> > > > https://afrantzis.com/pixel-format-guide/ (and it has an associated
> > > > tool too).
> > > >=20
> > > > On the page about DRM, it seems that they got the word that DRM for=
mats
> > > > are the native pixel order in little-endian systems:
> > > > https://afrantzis.com/pixel-format-guide/drm.html
> > >=20
> > > Looks consistent with the official word in drm_fourcc.h.
> > >=20
> > > $ python3 -m pfg find-compatible V4L2_PIX_FMT_XBGR32 drm
> > > Format: V4L2_PIX_FMT_XBGR32
> > > Is compatible on all systems with:
> > >         DRM_FORMAT_XRGB8888
> > > Is compatible on little-endian systems with:
> > > Is compatible on big-endian systems with:
> > >=20
> > > $ python3 -m pfg find-compatible DRM_FORMAT_XRGB8888 v4l2
> > > Format: DRM_FORMAT_XRGB8888
> > > Is compatible on all systems with:
> > >         V4L2_PIX_FMT_XBGR32
> > > Is compatible on little-endian systems with:
> > > Is compatible on big-endian systems with:
> > >=20
> > > Even works both ways :)
> > >=20
> > > > Perhaps some drivers have been abusing the format definitions, lead=
ing
> > > > to the inconsistencies that Nicolas could witness?
> > >=20
> > > That is quite possible, perhaps even likely. No one really
> > > seems interested in making sure big endian systems actually
> > > work properly. I believe the usual approach is to hack
> > > around semi-rnadomly until the correct colors accidentally
> > > appear on the screen.
> >=20
> > We did not hack around randomly.
>=20
> BTW I didn't mean to imply it was you who hacked around randomly.
> Sorry if you got that impression.
>=20
> What I was trying to convey is the following sequence of events:
> 1. random person X gets their hand on a big endian machine for
>    a while
> 2. colors are wrong
> 3. they hack stuff until the colors are correct in their
>    current use case
> 4. they move on to more interesting things

Thanks for clarification.

Nicolas

--=-mXZ6tifngVMDJDmbi+Oj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSScpfJiL+hb5vvd45xUwItrAaoHAUCXJUlZAAKCRBxUwItrAao
HKKzAKCMEnieITwh6pMvL3NLsy7RUoZmtgCg2OozBvt/rLlUXddaD435eszT8bc=
=Hs9Q
-----END PGP SIGNATURE-----

--=-mXZ6tifngVMDJDmbi+Oj--

