Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9522C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F07220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6g94Rtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCKKME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:12:04 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45852 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbfCKKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:12:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id z76so1458998qkb.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 03:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lqzkT6jK38j+AXApCJ+CsCAlikIN6AkZJjM6gE9TWJM=;
        b=g6g94Rtt3/iQsz61Xwsu2kUWRqcY2JeYA9qe3L4kb+7SS+z7TQtB5xZTGlub6xKwly
         cJ2Ftyx1KjJ62gLCSS7t9bnySHGqdbF4T6ymFiCMd3UGUvVc7z8Kl9RMBley01tKld5k
         inHbL1tPVPTwxA8tyKLzmDaB6FTb5PIBZnCPkW4WwBKiedQYAtwl1/u3DWKJwisUPEfJ
         6kPeCZIeWuZBAYi/qzgz5Jnf04PlXponPBpvqS/QLl5TbpOU6DnOlnicF9BCaaMGmbrh
         Ym/GqVKk9G65NioL90dCKFiQT503J+28k1EnZYAdtKh82JL8TZekq7yWUucen4vQNkye
         YLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lqzkT6jK38j+AXApCJ+CsCAlikIN6AkZJjM6gE9TWJM=;
        b=UdMXTw9sVpB8M0WU9Ux2cOBaG3jqoOzQpmB3rTNp7TN/1cIpove/JHvkepDeObNtmk
         anagXndTGkajxCI9V8qOFebIAgxaJ3BQEvhysO4KxcOpw9arGywVmgppFpNnuQOI2Tr0
         jGRAx+709JQ5LqcCefE3in7Gt4x4eABniVmVlJhqUu5ra4Gn19Yoz9zXSkwRw8XH43S7
         5kI6NwxPxE+uqHjEK8ld2JlcXQzKyPjsdQj3n0VMylFc0iBl998MKld3QuvYwe+Dm58t
         P1V/ujR6sDc6z+pT5Rl2M47i8BC7s2387cnGEgYs4nK7kEFaKpPHwjmgp4qh7mIsJ6cW
         uwKw==
X-Gm-Message-State: APjAAAU0puiVw03HdzqS4eG4hzY0nENEMJjve4D63d/6I5cW4zx3Wmqh
        +hd+3qKMOHN35vSieP4KNi4=
X-Google-Smtp-Source: APXvYqzjasmQznTAEoffDs3qE/dWUO4gHW5DijyodpQZVv50nbITI/gYp48TFMT2qHWl1MfPX6IIOg==
X-Received: by 2002:a37:553:: with SMTP id 80mr22313879qkf.19.1552299122948;
        Mon, 11 Mar 2019 03:12:02 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id g82sm2859561qkb.34.2019.03.11.03.12.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 11 Mar 2019 03:12:02 -0700 (PDT)
Date:   Mon, 11 Mar 2019 07:11:59 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bochs: Fix NULL dereference on atomic_disable helper
Message-ID: <20190311101159.t6mbzm5sdwuh5muc@smtp.gmail.com>
References: <20190310212150.xhhb4abzm7j3ain2@smtp.gmail.com>
 <20190311062200.4mtel3j5fjxtxrcf@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="drhezydywvhjq3od"
Content-Disposition: inline
In-Reply-To: <20190311062200.4mtel3j5fjxtxrcf@sirius.home.kraxel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--drhezydywvhjq3od
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/11, Gerd Hoffmann wrote:
> On Sun, Mar 10, 2019 at 06:21:50PM -0300, Rodrigo Siqueira wrote:
> > When the subtest basic-plain-flip from IGT project was executed on Bochs
> > driver, the following bug appears:
> >=20
> > BUG: unable to handle kernel NULL pointer dereference at 00000000000000=
00
>=20
> >  ? drm_atomic_helper_commit_modeset_disables+0x396/0x3e0 [drm_kms_helpe=
r]
>=20
> > +static void  bochs_crtc_atomic_disable(struct drm_crtc *crtc,
> > +				       struct drm_crtc_state *old_state)
> > +{
> > +}
> > +
> >  static void bochs_crtc_atomic_flush(struct drm_crtc *crtc,
> >  				    struct drm_crtc_state *old_crtc_state)
> >  {
> > @@ -66,6 +71,7 @@ static const struct drm_crtc_funcs bochs_crtc_funcs =
=3D {
> >  static const struct drm_crtc_helper_funcs bochs_helper_funcs =3D {
> >  	.mode_set_nofb =3D bochs_crtc_mode_set_nofb,
> >  	.atomic_enable =3D bochs_crtc_atomic_enable,
> > +	.atomic_disable =3D bochs_crtc_atomic_disable,
>=20
> Shouldn't we make the callback optional instead of adding empty dummy
> functions to drivers?

Hi Gerd,

I agree, and I can work in this issue.
Just one question, should we make atomic_enable optional as well?
=20
Thanks for your feedback,
Best Regards
> cheers,
>   Gerd
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech
Graduate Student
Department of Computer Science
University of S=E3o Paulo

--drhezydywvhjq3od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAlyGNG8ACgkQWJzP/com
vP8wsw//UrL8vOCTOcYISOmd6tDS5RI41osGF/+I4UGtvgY9czxtp/cpff7wdgXb
fOKvat7nsgRrX1HtfKbf/nVflpI9ifyrtzCGrip8jor7Tyd5luhXSVfeqjvbYYbm
V1hoz8zU0nXKgM+ysgtRrBvLTDWpzgWw8ruvEJmHKoVX2W2PSptRsYGyhbbkXn7w
YhKjEstNbL9Bhswd7HTN91udpqUFgOMCld4Zz2XPoO3bvWEM5TGYQMWFcprsDyLQ
LpuSfftjkoJnXuzz+fOOI4+tBKJaBUOa/OJcSzwWV79jKGMucKI8jrSdY6x/sZGv
LG8+/z5knRAUrrCAByjalucp2CFohe4Xgl0FEtcvNVnK7ShiTFwtuN/M2HqdnjaC
Gw2NCiAuA7ZvXRDLgiCpjnejcG5kF9oPTGVkOtV0FoEn4j/u7OohvWGtq7RvPU+Y
+BJkwe0itpXiFk8BpoPfWfg5cFi8oEY2PiLYDqjYSxjGv0WxTAnwgFqiwNVqwwlN
cQgJUxvUUU015kyyHHZj8bY6xms11Wp0NF2MR8V1EuMF8w2XBfEM4DsTpvoTojRz
d47QaG7jQBR5sfMu0vMjAbUMctxK4tpbxQj1I3Tg8B+QrNU3IVT8ufDbw4POMltK
g2f/m6xDHBk9o0mIR528WBjf48zAfOQSHmEJtptQ2U7YB4E5GX4=
=4Sg3
-----END PGP SIGNATURE-----

--drhezydywvhjq3od--
