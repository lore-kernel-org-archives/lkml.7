Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55EB3206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVvsaDCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfCKSAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:00:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41058 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfCKSAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:00:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id v10so6100459qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9aqeExQQTAA5xJYBxMWOYF6Tat1QVQk7SmfChLWrBOc=;
        b=ZVvsaDCj/lE29CCah6+IHdsn1Vmu6Da/eXOhuHWjyQoBhboZ5cD9SqkzQiD5Qnq6il
         l+Vg770Gey6eUlRXeKmhq16jlqeC08nETOFVoP5IF94Rp2wIqBvX6arRNOe/JAvyBVOJ
         qehXnNNvqlqKXM+AdzVxQWIKPFGeK5yV58hkLDgV568Yf8u2y4C4T4kVZutrIAUib/14
         EJSsemH7C017gxUW4OjjTGJ4fNzqF+HiwnvMMMjwsgvonHBzlVe5h5RtfxOOUvYBua4u
         eTnGX4UZ2afmAkh+yXBMCRgNIc/fflESQpLLdlNIS+fwmS8pml+N+rRsiGZQqYuI1/Gb
         WH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9aqeExQQTAA5xJYBxMWOYF6Tat1QVQk7SmfChLWrBOc=;
        b=VAWFODaHKpMVcjNr/xrnnwmOQqSHjOPg4lrDxNyVgfB4nGge4z58OhXX5MkiORScJ+
         i1iUk4cWRLzNzpaDxCkk1E12OR0tn+0rv9mVYY8GJcRhGck7NtuTzBg1+ceQ7SPL0yOv
         WlLKeYJjSSqlW6pixOvelXfxbtEK6RK4ScJv7tNu1zfRC2l1obRx1PL+RqApVJWXAD41
         kK25+RA6PO8HBX19ZDphqH3erS2kH91sw0zCUUqxKKJXjhfvT8nmo09ApWGOnMxHyCBY
         68SYNyuR0lAKZ3GV2kpSUJuBGml058akvlpICMKvpBNFpAQ11crYMaRxpOFELUzatLzL
         71kQ==
X-Gm-Message-State: APjAAAUxSG1HbhNpdQqjn8f4YdINFQ/vBlaUjmo+6nfNTER7Ya2sNCPi
        CIge7fZ2PoL5IBjWj8iXa6Q=
X-Google-Smtp-Source: APXvYqxvg9OAsvA/bUm9Tw15FDbqLHDvy/WvpsftBK8yOKvbvKs2D7j/rsHMlEr18gEkvSWuzIuuhQ==
X-Received: by 2002:ac8:168b:: with SMTP id r11mr26280792qtj.387.1552327208132;
        Mon, 11 Mar 2019 11:00:08 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id s186sm1751412qkb.57.2019.03.11.11.00.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 11:00:07 -0700 (PDT)
Date:   Mon, 11 Mar 2019 15:00:04 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/vkms: Remove useless call to drm_connector_register()
Message-ID: <20190311180004.6wljdhyhkmn66lpi@smtp.gmail.com>
References: <20190310212241.4fsqejz5rlnp7m2k@smtp.gmail.com>
 <20190311132938.GG2665@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vuw4btwyf5tpthnz"
Content-Disposition: inline
In-Reply-To: <20190311132938.GG2665@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vuw4btwyf5tpthnz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/11, Daniel Vetter wrote:
> On Sun, Mar 10, 2019 at 06:22:41PM -0300, Rodrigo Siqueira wrote:
> > The function vkms_output_init() is invoked during the module
> > initialization, and it handles the creation/configuration of the vkms
> > essential elements (e.g., connectors, encoder, etc). Among the
> > initializations, this function tries to initialize a connector and
> > register it by calling drm_connector_register(). However, inside the
> > drm_connector_register(), at the beginning of this function there is the
> > following validation:
> >=20
> >  if (!connector->dev->registered)
> >    return 0;
> >=20
> > In this sense, invoke drm_connector_register() after initializing the
> > connector has no effect because the register field is false. The
> > connector register happens when drm_dev_register() is invoked.
> > Therefore, this commit removes the drm_connector_register() from
> > vkms_output_init().
> >=20
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_output.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/vkms/vkms_output.c b/drivers/gpu/drm/vkms/=
vkms_output.c
> > index 3b162b25312e..a6cee4c279c2 100644
> > --- a/drivers/gpu/drm/vkms/vkms_output.c
> > +++ b/drivers/gpu/drm/vkms/vkms_output.c
> > @@ -71,12 +71,6 @@ int vkms_output_init(struct vkms_device *vkmsdev)
> > =20
> >  	drm_connector_helper_add(connector, &vkms_conn_helper_funcs);
> > =20
> > -	ret =3D drm_connector_register(connector);
>=20
> Yeah that's only needed for connectors added when hotplugging at runtime,
> not for connectors which are created at driver load time.
>=20
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>=20
> btw same issue exists with the drm_connector_unregister, that's also not
> needed.

Thanks for your review :)

Should I send a V2 that also removes the drm_connector_unregister()? Or
should I send it in a separated patch?

Best Regards

> -Daniel
>=20
> > -	if (ret) {
> > -		DRM_ERROR("Failed to register connector\n");
> > -		goto err_connector_register;
> > -	}
> > -
> >  	ret =3D drm_encoder_init(dev, encoder, &vkms_encoder_funcs,
> >  			       DRM_MODE_ENCODER_VIRTUAL, NULL);
> >  	if (ret) {
> > --=20
> > 2.21.0
>=20
> --=20
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--vuw4btwyf5tpthnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlyGoiQACgkQWJzP/com
vP9hXQ//XQnUpPZ9eL8ka8N0w2/by5wUzIxth/cZWG4KT6dBFmhVe56BwytewjlK
FauC8Ev7sbI8HP6DsRZArQLlKefbL5tHYt9kZAAS8qwMvWrwxpJf788aAYiRia0E
Svuni78WupOGShq2+XW28LB8liqcxcQ5l1Iyxw+qf2Pq/aCn4VPWVYcb45dg99PR
awjpmlUAdF3QHMLm+FjxZkuL4wQlP399c/SrImLwBm2SfYWAzscAdGaHpJl2Tl6m
Rm5T59jSktrMS0EjwqV6ic805oBIvlmJPKpekw1cFLUuJZPCyYwL/nugn29jSXPJ
wZRNC3wklp/EEdyyI269twATwzBVLd/+b6Eh1JAB8xzeU3A+t/y3Xq36o0IF4FP5
Vd9IZvZYw2e4k2rPtP39gvEy4kUyeBxGoIDq/pR2lnqt62JqVJFr3pslNbqjTbZC
TdfnmYFwJd7c2MJOd1EFmVFU2qvtNFiyTbTcMaDjR04bww96X/bQK7GJEo4LoGLH
mHWT33bFu5VCNmMdagt25FA1rgESkOBnzo50Kw/Ao8C7tsrSjdTjd9qV4XHwpVQ6
9+Hpifm+viIk2HYvE9Hw+43DD+Bh1kmK/wFfek+cI8R77cS5Y8528hg5kAjdEg1i
Orb9uujM0VUQCvTQLFivr6bQbw0uJCSx1qrRpqUi8yJonliZNDE=
=cIXa
-----END PGP SIGNATURE-----

--vuw4btwyf5tpthnz--
