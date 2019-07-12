Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27899C742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E312921019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 03:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5i89Yz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfGLDO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 23:14:56 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44403 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfGLDO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 23:14:56 -0400
Received: by mail-qk1-f195.google.com with SMTP id d79so5371946qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 20:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fqowWkQWDIteBtwEKrdiEv26Xf58Ktw1YcMr9HD38hc=;
        b=E5i89Yz/S7p8RYcIgbxKAuw0Lu/eHuwtmFAG/skNG8Hrf9AUsrWMxu9EDOzraY6Rtr
         ZEQWnDYOaSLZNeTAOCBtK2Zp5XMJcZU/UsPJFWsCZ5/jzyIzthR2z6ZH3uLT208LnpD4
         pH9ESenYlnzb42m4/XJpuXv9sUfviULqhHZQ46EeJewJ7+EqXF8c13kR3WR579fYaEQm
         DsCYVQXEbqTtN4LY0OTOyPEQiBx5hwozxM6R51F//Y5p9xbWckgHWYq4Zi3/OV0TyiIk
         81tmr7XBvRHq1Xq87uE+oX4wYvWl9ml4j30nMsgJh5+AY9ygWQgeP1HIhadbfN/mhSRV
         5y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fqowWkQWDIteBtwEKrdiEv26Xf58Ktw1YcMr9HD38hc=;
        b=ZQdT7qd4F3jY4Jccx7iMwYUhfb3HzfZrg4EX+INmrZS3Xa0ci8PlLk5vTNiV6heYIB
         w6Q2rHmmbhE42tDNbrtuetUzUFn+phekC6aMN+QLIPf+sG61bihnONYoIaDkjYLQJzMn
         1CCfp3sxIUqXrG8R2bCAI+t8q9vUYnQzWPM3fPacPR9qqnraZ1G0CC+wcFKs6Cn7njET
         JwV9BSXRq1ZBVQDowkjfCawQNRboJjPGFfpcf52gdl/Hb/h547YCDybQYdNe3fRJy/yL
         giE0uBC0KX7Q7jBnuL0h+F5s4DcbkOkUwPx2eMOWbKf05JOGOlULcNxIJcv73piL1L7l
         fk1w==
X-Gm-Message-State: APjAAAXh1iyFrahW7eRKEinlplPSRCwAce81Do5y4EzzW8+dB7WDsTMd
        uHPWr/Xr2qEKfmb+LuQgZ1qCQUaZ+x8=
X-Google-Smtp-Source: APXvYqxMHYF82JKIlXbB93A96rz547nb8nWEiIbN14p+Pz9F+KDlBu2aOcXwexavUW+Xt9VWIqfoNA==
X-Received: by 2002:a37:9185:: with SMTP id t127mr4497870qkd.482.1562901294628;
        Thu, 11 Jul 2019 20:14:54 -0700 (PDT)
Received: from smtp.gmail.com ([187.121.151.22])
        by smtp.gmail.com with ESMTPSA id t2sm3964071qth.33.2019.07.11.20.14.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 20:14:53 -0700 (PDT)
Date:   Fri, 12 Jul 2019 00:14:49 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Brian Starkey <brian.starkey@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 4/5] drm/vkms: Compute CRC without change input data
Message-ID: <20190712031449.3pmeimkcde2hrxxh@smtp.gmail.com>
References: <cover.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <ea7e3a0daa4ee502d8ec67a010120d53f88fa06b.1561491964.git.rodrigosiqueiramelo@gmail.com>
 <20190711082105.GI15868@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6wp7bxmzbrpx433z"
Content-Disposition: inline
In-Reply-To: <20190711082105.GI15868@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6wp7bxmzbrpx433z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07/11, Daniel Vetter wrote:
> On Tue, Jun 25, 2019 at 10:38:31PM -0300, Rodrigo Siqueira wrote:
> > The compute_crc() function is responsible for calculating the
> > framebuffer CRC value; due to the XRGB format, this function has to
> > ignore the alpha channel during the CRC computation. Therefore,
> > compute_crc() set zero to the alpha channel directly in the input
> > framebuffer, which is not a problem since this function receives a copy
> > of the original buffer. However, if we want to use this function in a
> > context without a buffer copy, it will change the initial value. This
> > patch makes compute_crc() calculate the CRC value without modifying the
> > input framebuffer.
>=20
> Uh why? For writeback we're writing the output too, so we can write
> whatever we want to into the alpha channel. For writeback we should never
> accept a pixel format where alpha actually matters, that doesn't make
> sense. You can't see through a real screen either, they are all opaque :-)
> -Daniel

Hmmm,

I see your point and I agree, but even though we can write whatever we
want in the output, don=E2=80=99t you think that is weird to change the
framebuffer value in the compute_crc() function?

Thanks
=20
> >=20
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> > ---
> >  drivers/gpu/drm/vkms/vkms_composer.c | 31 +++++++++++++++++-----------
> >  1 file changed, 19 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkm=
s/vkms_composer.c
> > index 51a270514219..8126aa0f968f 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c
> > @@ -6,33 +6,40 @@
> >  #include <drm/drm_atomic_helper.h>
> >  #include <drm/drm_gem_framebuffer_helper.h>
> > =20
> > +static u32 get_pixel_from_buffer(int x, int y, const u8 *buffer,
> > +				 const struct vkms_composer *composer)
> > +{
> > +	int src_offset =3D composer->offset + (y * composer->pitch)
> > +					  + (x * composer->cpp);
> > +
> > +	return *(u32 *)&buffer[src_offset];
> > +}
> > +
> >  /**
> >   * compute_crc - Compute CRC value on output frame
> >   *
> > - * @vaddr_out: address to final framebuffer
> > + * @vaddr: address to final framebuffer
> >   * @composer: framebuffer's metadata
> >   *
> >   * returns CRC value computed using crc32 on the visible portion of
> >   * the final framebuffer at vaddr_out
> >   */
> > -static uint32_t compute_crc(void *vaddr_out, struct vkms_composer *com=
poser)
> > +static uint32_t compute_crc(const u8 *vaddr,
> > +			    const struct vkms_composer *composer)
> >  {
> > -	int i, j, src_offset;
> > +	int x, y;
> >  	int x_src =3D composer->src.x1 >> 16;
> >  	int y_src =3D composer->src.y1 >> 16;
> >  	int h_src =3D drm_rect_height(&composer->src) >> 16;
> >  	int w_src =3D drm_rect_width(&composer->src) >> 16;
> > -	u32 crc =3D 0;
> > +	u32 crc =3D 0, pixel =3D 0;
> > =20
> > -	for (i =3D y_src; i < y_src + h_src; ++i) {
> > -		for (j =3D x_src; j < x_src + w_src; ++j) {
> > -			src_offset =3D composer->offset
> > -				     + (i * composer->pitch)
> > -				     + (j * composer->cpp);
> > +	for (y =3D y_src; y < y_src + h_src; ++y) {
> > +		for (x =3D x_src; x < x_src + w_src; ++x) {
> >  			/* XRGB format ignores Alpha channel */
> > -			memset(vaddr_out + src_offset + 24, 0,  8);
> > -			crc =3D crc32_le(crc, vaddr_out + src_offset,
> > -				       sizeof(u32));
> > +			pixel =3D get_pixel_from_buffer(x, y, vaddr, composer);
> > +			bitmap_clear((void *)&pixel, 0, 8);
> > +			crc =3D crc32_le(crc, (void *)&pixel, sizeof(u32));
> >  		}
> >  	}
> > =20
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

--6wp7bxmzbrpx433z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl0n+ykACgkQWJzP/com
vP8jdA//Tv7ShkinLXNtiF8dK7UlkjVi2KNRKIbfk81SrvbLs/gCraJiW3MhGK54
V7Gcx6r33ahPA35p7K3sbm7q+jAGfVUSapQsT7GMG8D6anM0qhhp4h/k5/vsLtT4
7FTZVu0rL1E76XoyseoZXsnSHHfp0h2enSBKYt7aHMSYY2zhDQRtfWtBbCpN3MML
cfOOyoA7OlIyiz9n2vOKnI23rXPULDMN77Rp+f8s6UzwaOjDKnEPyxBFKfgU9kBy
VV8vbXiX26ENQ5j0Xz+QWWNL3S7gAqKQnPlMYBk1PXn8YdI7yoUrOhV6lZUSx5QV
xuLpewuIs+R3LR4YQvsKIL/I2WTiuTvz4I+6MK/QLJ5JxSEFhw1sllVvhZXXGoad
qSVV5gocR3g2Lz60rPzMWZ3PBy/BwZWfutxuSAV4hxozKWx0UR2R21hmuqbgoVS3
f6B5lExMqhA8CxTK+Zk1+mekztr5VxYBmnciuvshhGrfx4f2XS7Tt1awm0JrQwFv
chRARfSDVhqxkJvW72kDb+tG3Cy5mtJYmmUA4MPGEUefoIaNx4dypPRpJ8yjZRtq
A8JJ2j1zt2Fv0IVCxOSESAfniLN+U0EAkpBFxH1OmIFbU2WUuItRNTkVSSQ7zQ0Q
upcoD7Uc3QdC31ORWgnyoovloumbRCJRbA94HI1UoQbQg9KyiMw=
=Rdzr
-----END PGP SIGNATURE-----

--6wp7bxmzbrpx433z--
