Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC22C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D88A218AE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568837782;
	bh=0jWrdETYu7QZ6nLUVrv66CQvk9+vFSveR8OObhBCino=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=yI2uauoCFOGvYPlowGDCjDGfzQiJQNopQsgsGNuI3OYKKDxbd4lTKUG2SZCx/68dw
	 ZiTCgM/aZqBdmVbcq2kgAu86OCRNZC7+vc2sKOeQce0t8lD8yMyYDHcB3YigiaQgtw
	 JqAbijUt3kceAVuuxkQ/nb/S0UVTf46ya3djHiJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391228AbfIRUQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391193AbfIRUQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:16:21 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B2B321927;
        Wed, 18 Sep 2019 20:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568837780;
        bh=0jWrdETYu7QZ6nLUVrv66CQvk9+vFSveR8OObhBCino=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=EFgyMRfQj+z7INZY4gk4LkQGc+RqodGEvpbG64mfh86DvbU+un9q2XvuNyMSJF19y
         e7Ms4hV+8A+0wJ156gguMKhnJ0q197TzBP95/NqDL3Q7DmZbXJH85EiV1q6ETqnWB0
         xuMTzwPMSHKmqEeyaaPIfA8e1RwymHwPmxOuWJ/4=
Date:   Wed, 18 Sep 2019 22:16:17 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: sun8i-ui/vi: Fix layer zpos change/atomic
 modesetting
Message-ID: <20190918201617.5gwzmshoxbcxbmrx@gilmour>
References: <20190914220337.646719-1-megous@megous.com>
 <20190918141734.kerdbbaynwutrxf6@gilmour>
 <20190918152309.j2dbu63jaru6jn2t@core.my.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tk4bbuln473dg4yq"
Content-Disposition: inline
In-Reply-To: <20190918152309.j2dbu63jaru6jn2t@core.my.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tk4bbuln473dg4yq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 05:23:09PM +0200, Ond=C5=99ej Jirman wrote:
> Hi,
>
> On Wed, Sep 18, 2019 at 04:17:34PM +0200, Maxime Ripard wrote:
> > Hi,
> >
> > On Sun, Sep 15, 2019 at 12:03:37AM +0200, megous@megous.com wrote:
> > > From: Ondrej Jirman <megous@megous.com>
> > >
> > > There are various issues that this re-work of sun8i_[uv]i_layer_enable
> > > function fixes:
> > >
> > > - Make sure that we re-initialize zpos on reset
> > > - Minimize register updates by doing them only when state changes
> > > - Fix issue where DE pipe might get disabled even if it is no longer
> > >   used by the layer that's currently calling sun8i_ui_layer_enable
> > > - .atomic_disable callback is not really needed because .atomic_update
> > >   can do the disable too, so drop the duplicate code
> > >
> > > Signed-off-by: Ondrej Jirman <megous@megous.com>
> >
> > It looks like these fixes should be in separate patches. Is there any
> > reason it's not the case?
>
> Bullet points just describe the resulting effect/benefits of the change t=
o fix
> the pipe control register update issue (see the referenced e-mail).

It's definitely ok to have multiple patches needed to address a single
perceived issue.

A commit is not about what you're fixing but what you're changing. And
the fact that you have tha bullet list in the first place proves that
you have multiple logical changes in your patch.

And even then, your commit log mentions that you're fixing multiple
issues (without explaining them).

> I can maybe split off the first bullet point into a separate patch. But
> I can't guarantee it will not make the original issue worse, because it m=
ight
> have been hiding the other issue with register updates.
>
> The rest is just a result of the single logical change. It doesn't work
> individually, it all has the goal of fixing the issue as a whole.
>
> If I were to split it I would have to actually re-implement .atomic_disab=
le
> callback only to remove it in the next patch. I don't see the benefit.

Your commit log says that you remove atomic_disable. Why would you
remove it, to add it back, to remove it again?

Maxime

--tk4bbuln473dg4yq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYKQkQAKCRDj7w1vZxhR
xf8DAP9GfuXKiu3V08w0e+632ZjU7AktNEcXwFiyue0LwCXXDQEAhgjDhYaEmgtB
PS6Q2gQ7ymKhYKJ1fiSUPtE0JM/QOQA=
=Yn7Q
-----END PGP SIGNATURE-----

--tk4bbuln473dg4yq--
