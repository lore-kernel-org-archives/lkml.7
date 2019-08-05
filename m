Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9ADC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9065E216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 15:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565017484;
	bh=6SJSdyDbFDLeQFF5ITDNOv7RkepckDurk2I+Z0EiFsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GMu02UXrtNJmwSebMDaph065XEtZZ3ZO4koee+x4deKmYhR7DzuGprsLKBGFVUA6N
	 tGEgYhmDnJljN1zavZPa5m+05BcYV+b4j+R168uKA58BN0O6K53RMxMyIe+GCk7rUL
	 yPwBCbp2pNNUuTOfTiGudw/2+ES++JA0LHPQtdwM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfHEPEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 11:04:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728885AbfHEPEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 11:04:42 -0400
Received: from localhost.localdomain (unknown [151.66.62.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 153B0206C1;
        Mon,  5 Aug 2019 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017481;
        bh=6SJSdyDbFDLeQFF5ITDNOv7RkepckDurk2I+Z0EiFsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yac3Z2ucmDuY654rgEaaZfCY6ZN0SK6lY4rjXjoXAMKlyxIlLfxr3x9bfJWm4dtIo
         NdVAdTEO7L/E5qt06LNC3Y2HaPeDuiLwn8AvI6EORdN1L2cfg19H/Gsc2yXYeRc87S
         v8HiIZYEck2YVQNrQMEG2kOmeP5kOl5YgZLpDjAk=
Date:   Mon, 5 Aug 2019 17:04:35 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Martin Kepplinger <martin.kepplinger@puri.sm>,
        lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: make IIO_CHAN_INFO_SCALE shared by
 type
Message-ID: <20190805150435.GA15250@localhost.localdomain>
References: <20190801143908.27608-1-martin.kepplinger@puri.sm>
 <20190805152148.0ea55f6e@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <20190805152148.0ea55f6e@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu,  1 Aug 2019 16:39:08 +0200
> Martin Kepplinger <martin.kepplinger@puri.sm> wrote:
>=20
> > in_accel_x_scale, in_accel_y_scale and in_accel_z_scale are always
> > the same. The scale is still defined to be in "info_mask_separate".
> >=20
> > Userspace (iio-sensor-proxy and others) is not used to that and only
> > looks for "in_accel_scale" for the scaling factor to apply.
> >=20
> > Change IIO_CHAN_INFO_SCALE from being separate in all channel to be
> > shared by type.
> >=20
> > This removes in_accel_x_scale, in_accel_y_scale and in_accel_z_scale and
> > makes available in_accel_scale.
> >=20
> > Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> > ---
> >=20
> > AFAIK in all other drivers, IIO_CHAN_INFO_SCALE is "shared by type". Su=
re
> > devices are different, but LSM6DSX devices still don't have different
> > scales for x/y/z channels :)
>=20
> I'm fine with this, but would like a Lorenzo ack as we have had
> devices in other series where these are not equal.   It used to
> be common in accelerometers as I think it was hard to get a large
> range in the vertical direction.  Doubt that applies on these modern
> parts though!
>=20
> Thanks,
>=20
> Jonathan

AFAIK all the supported sensors have the same sensitivity on all axis and s=
o I
am fine with this patch (it should be done in this way from day 0 actually =
:))
but is it going to break uapi? if not feel free to add:

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

Regards,
Lorenzo

>=20
>=20
> >=20
> > thanks,
> >=20
> >                               martin
> >=20
> >=20
> >=20
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index af379a5429ed..59c3ab7cbb6f 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -56,8 +56,8 @@ enum st_lsm6dsx_hw_id {
> >  	.address =3D addr,						\
> >  	.modified =3D 1,							\
> >  	.channel2 =3D mod,						\
> > -	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> > -			      BIT(IIO_CHAN_INFO_SCALE),			\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> > +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
> >  	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> >  	.scan_index =3D scan_idx,						\
> >  	.scan_type =3D {							\
>=20

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXUhFgQAKCRA6cBh0uS2t
rMtiAQCclTOniECTRlWfSm0HPOwK5O7sL9GHP5DCp2avHVWz6AEAtf9XQPfIo/Kn
ib+ne9EnoUEkLVI2HY21THROulATFQc=
=/f7d
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
