Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC7EC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1180520882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 06:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568959933;
	bh=LFxPD7bXEN0iUHzSgV2IAaqhJMR9jcy71uqdbxqIPmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y3iOese0awGotZW3dZMfTrfhZxRqwVCjXyTYYGIMSVj+O2KTBOvUOnnVwqtASGSFH
	 9ygL39CLgqHD94WdGinT1DLHeQxW/PdpLLZZ4Hh9gyWRq1ORLEK42XsFx5VuYAaDko
	 EY/v9he8H0X4cDCtGP0bVUBjd6rkk6fVOMEi4670=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390817AbfITGMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 02:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389655AbfITGMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 02:12:12 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2369F20665;
        Fri, 20 Sep 2019 06:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568959931;
        bh=LFxPD7bXEN0iUHzSgV2IAaqhJMR9jcy71uqdbxqIPmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VPUqzg6q9sM0ka6k4geicLtzFC4DJG+pHllGG5x2r85z9Orqm1+AtNmbw90l2ki4V
         EQzuvzBXyZU9ZNusHhrEERZWTEk77Rb0MC4FOuHcd5eoB1yAByb00w+7EN9eg3Kxwl
         nDD+yjxYFJcACzDu/0nZvIpNJMG+8RMI8WxBoOgE=
Date:   Fri, 20 Sep 2019 08:12:09 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     roman.stratiienko@globallogic.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/sun4i: Use vi plane as primary
Message-ID: <20190920061209.ostddxvzf6xwrmdp@gilmour>
References: <20190919123703.8545-1-roman.stratiienko@globallogic.com>
 <20190919171754.x6lq73cctnqsjr4v@gilmour>
 <104595190.vWb6g8xIPX@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ylh7nsjnj6zhso3"
Content-Disposition: inline
In-Reply-To: <104595190.vWb6g8xIPX@jernej-laptop>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ylh7nsjnj6zhso3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2019 at 08:15:49PM +0200, Jernej =C5=A0krabec wrote:
> Dne =C4=8Detrtek, 19. september 2019 ob 19:17:54 CEST je Maxime Ripard na=
pisal(a):
> > >
> > > Tested on Android.
> > >
> > > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic.com>
> >
> > It sounds like a workaround more than an actual fix.
> >
> > If the VI planes can't use the alpha, then we should just stop
> > reporting that format.
> >
> > Jernej, what do you think?
>
> Commit message is misleading. What this commit actually does is moving pr=
imary
> plane from first UI plane to bottom most plane, i.e. first VI plane. Howe=
ver, VI
> planes are scarce resource, almost all mixers have only one. I wouldn't s=
et it
> as primary, because it's the only one which provide support for YUV forma=
ts.
> That could be used for example by video player for zero-copy rendering.
> Probably most apps wouldn't touch it if it was primary (that's usually
> reserved for window manager, if used).

Yeah, we definitely don't want to use it as primary and prevent the
video display.

> I left few formats with alpha channel exposed by VI planes, just because =
they
> don't have equivalent format without alpha. But I'm fine with removing th=
em if
> you all agree on that.

If there's no alpha support, then yeah, we shouldn't expose the format
at all, and then we can either add the new formats, or just not expose
them if they are exotic enough.

Maxime

--3ylh7nsjnj6zhso3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXYRtuQAKCRDj7w1vZxhR
xeqxAP47vhP9Zt2VoOykoxUSb+0IORx7/qZJWXiMTdUUPVILWQEAgu6XBa76F/RH
QcYmCCHcvowZxHbGSkRFp2//2Y0bsAw=
=16hs
-----END PGP SIGNATURE-----

--3ylh7nsjnj6zhso3--
