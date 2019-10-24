Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23061CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CBA2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jwX9fOuI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392912AbfJXTwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:52:00 -0400
Received: from ozlabs.org ([203.11.71.1]:47283 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390431AbfJXTwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:52:00 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46zdDP46YWz9sPV;
        Fri, 25 Oct 2019 06:51:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571946716;
        bh=UWyXQ1Iw+UMZYj2SA6HBAw1NT5T7pfbx2QffwK989yU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jwX9fOuI11zIRK3ojPaBk/qXRXsPsMVeh2/gaacyvzQwL+V0aiYZkAhFPheFd9k0J
         et2FGYEubuOkFNq4vzQyFgqNJo6wcYfVP2HuSgPzo9JP9B04IjIQFB2GD4D2CW362S
         RmoMZ2HHnMqnEWbvmOCnSeko+OCrRH1U/t2yVj6g9O1O9Phf3fr5j/9TUDRDTGgSJv
         JJpGFSBVqVfJyPLUxl37q7A5t/3+kLWuHell801boDx4L5/SwSZLopVdtrSgKgmUHR
         HlyXd1W/5Q1x4JDtE6HM/ZlzOkwAZigTbqsjCBQeJGumdnSd+iDpplh2FiQA0aDLTr
         R1fjqzpS8AefQ==
Date:   Fri, 25 Oct 2019 06:51:35 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Colin Ian King <colin.king@canonical.com>,
        Sean Paul <sean@poorly.run>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Iago Toral Quiroga <itoral@igalia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][next] drm/v3d: fix double free of bin
Message-ID: <20191025065135.09175b37@canb.auug.org.au>
In-Reply-To: <CAKMK7uGbMx21+g2kQyGu5H-L7N-guKJhsZ6b1ROnz5+kDRt3LA@mail.gmail.com>
References: <20191024104801.3122-1-colin.king@canonical.com>
        <20191024123853.GH11828@phenom.ffwll.local>
        <821f0799-1f37-c853-d2c6-dd95883e02d8@canonical.com>
        <CAKMK7uGbMx21+g2kQyGu5H-L7N-guKJhsZ6b1ROnz5+kDRt3LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xwrizZz4UyloQa1ZZxKFEFk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xwrizZz4UyloQa1ZZxKFEFk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 24 Oct 2019 14:49:36 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Ok adding Stephen. There's a merge conflict between drm-misc-fixes and
> drm-next (I think) and the merge double-added the kfree(bin). See
> above for the relevant sha1. Dave is already on here as a heads-up,
> but also adding drm-misc maintainers.
>=20
> > >> ---
> > >>  drivers/gpu/drm/v3d/v3d_gem.c | 1 -
> > >>  1 file changed, 1 deletion(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d=
_gem.c
> > >> index 549dde83408b..37515e47b47e 100644
> > >> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> > >> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> > >> @@ -568,7 +568,6 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void=
 *data,
> > >>              ret =3D v3d_job_init(v3d, file_priv, &bin->base,
> > >>                                 v3d_job_free, args->in_sync_bcl);
> > >>              if (ret) {
> > >> -                    kfree(bin);
> > >>                      v3d_job_put(&render->base);
> > >>                      kfree(bin);
> > >>                      return ret;

I will add this as a merge fixup until drm-misc-fixes is merged into
the drm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/xwrizZz4UyloQa1ZZxKFEFk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2yAMcACgkQAVBC80lX
0Gy2ZggAiZaoH9RPu5iXGznPgZhzyg1plQKDAAPWiIwMq1c3Bivg6umaIroB14qg
LGpurXf9YO+Vj8S06ukixB/b1vAycWSWXfauEZPhe6lF1YGykeZUVDeKCcIoR/oU
we0+KgwxN1r854mdr4+OlzjC9VssQ8c3HiGztCldR0PnenNt/BP7m+4mQtmB2gdL
H+cQREBnDZFHYKVNiDoIybIlyg34/MXC0nt2JGsY/A/UsBIFoLKEePnMc6j7Jh3O
4mkIfZb2SYcUVz0a6Ds0XuqAOVb9IRKiTHMdE1v59cnSS+AcyNog821sMAgtwAYR
lLyleGdyeEodrJ5AFmvnpCvc4bGZ9w==
=RhRC
-----END PGP SIGNATURE-----

--Sig_/xwrizZz4UyloQa1ZZxKFEFk--
