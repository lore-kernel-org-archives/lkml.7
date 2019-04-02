Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89CCC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824C920883
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbfDBOvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:51:20 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59567 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfDBOvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:51:19 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 962731BF20C;
        Tue,  2 Apr 2019 14:51:14 +0000 (UTC)
Date:   Tue, 2 Apr 2019 16:51:14 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org
Subject: Re: [RFC PATCH 01/20] drm: Remove users of drm_format_num_planes
Message-ID: <20190402145114.bpt5atxxooufgzz5@flea>
References: <cover.92acdec88ee4c280cb74e08ea22f0075e5fa055c.1553032382.git-series.maxime.ripard@bootlin.com>
 <fecde1c7b65caa0e876a2f01769289a883014712.1553032382.git-series.maxime.ripard@bootlin.com>
 <CACvgo51WMD5hsyLB5QTriGNwcPmeN4TDjscJV11M3PXFncPHeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lgdfh3o7stmf4lnx"
Content-Disposition: inline
In-Reply-To: <CACvgo51WMD5hsyLB5QTriGNwcPmeN4TDjscJV11M3PXFncPHeQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lgdfh3o7stmf4lnx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Emil,

On Tue, Apr 02, 2019 at 10:43:31AM +0100, Emil Velikov wrote:
> On Tue, 19 Mar 2019 at 21:57, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > drm_format_num_planes() is basically a lookup in the drm_format_info table
> > plus an access to the num_planes field of the appropriate entry.
> >
> > Most drivers are using this function while having access to the entry
> > already, which means that we will perform an unnecessary lookup. Removing
> > the call to drm_format_num_planes is therefore more efficient.
> >
> > Some drivers will not have access to that entry in the function, but in
> > this case the overhead is minimal (we just have to call drm_format_info()
> > to perform the lookup) and we can even avoid multiple, inefficient lookups
> > in some places that need multiple fields from the drm_format_info
> > structure.
> >
>
> I'm not fan of the duplicated loop-ups either.
>
> > -int drm_format_num_planes(uint32_t format)
> > -{
> > -       const struct drm_format_info *info;
> > -
> > -       info = drm_format_info(format);
> > -       return info ? info->num_planes : 1;
> > -}
> > -EXPORT_SYMBOL(drm_format_num_planes);
> > -
>
> The existing users are not updated to cater for the num_planes != 0
> case... Which seems non-existent scenario since all the current format
> descriptions have 1+ planes.
> Should we add a test (alike the ones in 6/20) to ensure, that no entry
> has 0 planes? Is it even worth it or I'm a bit too paranoid?
>
> The above comments apply to 2/20.

I'm not entirely sure what you mean. num_planes is returned as is in
the drm_format_num_planes function and it doesn't check for the
num_planes value itself.

That being said, we could definitely add some more tests to check that
we haven't falling into the situation you describe, since most of the
drivers indeed don't check for that value themselves. But that seems
pretty othorgonal to me?

> With the name suggestions by Paul, patches 1 to 5 (incl.) are:
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lgdfh3o7stmf4lnx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKN24gAKCRDj7w1vZxhR
xdcIAPwMegTv/UcHRA+TAB4ezclPNbm+1U/NJzXvnXyZ2shdqAEA7A05cNikgqEW
zGKsikrWNgK28tqwL+rYgk+cLDOVKAA=
=PIGw
-----END PGP SIGNATURE-----

--lgdfh3o7stmf4lnx--
