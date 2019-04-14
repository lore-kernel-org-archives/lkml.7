Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2EFAC282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724F7218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 10:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555238801;
	bh=vVbD6rgm7vtKOq3whzD9UJOqpGGo8ige86PIpwf4JeA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=El2HDYDRO84XpqNgrUNaP0AUzbGRelBR93wW86AtNgjxxGfkh0drc5Tqnwn/b4tIe
	 5JGpyLnyCiHIc9m0QkarPI1P63c4NfARCD5fVI9aGctlOr7qg2tyADQXYOQMw2ViXb
	 PcGO/lk+bWQYv5vbcIdYbaJsVNUtTn8QeaP5CFAI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfDNKqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 06:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:59144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfDNKqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 06:46:39 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C6B20848;
        Sun, 14 Apr 2019 10:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555238798;
        bh=vVbD6rgm7vtKOq3whzD9UJOqpGGo8ige86PIpwf4JeA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V31nvPtWtCbegnDCNzLmx1E+70HmP4hyTxwhFzJLYQWmupIrIVEHEFfxLIz0V0DKB
         xVfdTJsCT5+ajX8Q1VSCYOS3hx1egM4S80JrE57pGIE0nvo6YURffK4vG1Bh9qedVH
         YmwuK4fAdDbPYXKIZohemA//RpLKprbVDXrMRGk0=
Date:   Sun, 14 Apr 2019 11:46:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     "stevemo@skydio.com" <stevemo@skydio.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        Randolph =?UTF-8?B?TWFhw59lbg==?= <gaireg@gaireg.de>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: mpu6050: Fix FIFO layout for ICM20602
Message-ID: <20190414114631.263047ef@archlinux>
In-Reply-To: <MN2PR12MB3373887FD2E7211E6AFB7F7DC42C0@MN2PR12MB3373.namprd12.prod.outlook.com>
References: <20190326090238.23651-1-stevemo@skydio.com>
        <20190403062910.5047-1-stevemo@skydio.com>
        <20190407124501.1a8b21d8@archlinux>
        <MN2PR12MB3373887FD2E7211E6AFB7F7DC42C0@MN2PR12MB3373.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2019 14:32:00 +0000
Jean-Baptiste Maneyrol <JManeyrol@invensense.com> wrote:

> Hello,
>=20
> overall looks good for me.
>=20
> I would just prefer to change the define name for temperature to INV_ICM2=
0602_SCAN_TEMP. It is the chip temperature that can be used for temperature=
 compensation for both accel and gyro data.
>=20
> But it is really just a details.
>=20
> Best regards,
> Jean-Baptiste Maneyrol

Rather than go around again, I've made the change and applied the
patch to the fixes-togreg branch of iio.git.  I also added a
fixes tag.

Thanks,

Jonathan

>=20
>=20
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Sunday, April 7, 2019 13:45
> To: stevemo@skydio.com
> Cc: Jean-Baptiste Maneyrol; Hartmut Knaack; Lars-Peter Clausen; Peter Mee=
rwald-Stadler; Martin Kelly; Jonathan Marek; Brian Masney; Randolph Maa=C3=
=9Fen; Douglas Fischer; linux-iio@vger.kernel.org; linux-kernel@vger.kernel=
.org
> Subject: Re: [PATCH v2] iio: imu: mpu6050: Fix FIFO layout for ICM20602
> =C2=A0
> =C2=A0CAUTION: This email originated from outside of the organization. Pl=
ease make sure the sender is who they say they are and do not click links o=
r open attachments unless you recognize the sender and know the content is =
safe.
>=20
> On Tue,=C2=A0 2 Apr 2019 23:28:56 -0700
> stevemo@skydio.com wrote:
>=20
> > From: Steve Moskovchenko <stevemo@skydio.com>
> >
> > The MPU6050 driver has recently gained support for the
> > ICM20602 IMU, which is very similar to MPU6xxx. However,
> > the ICM20602's FIFO data specifically includes temperature
> > readings, which were not present on MPU6xxx parts. As a
> > result, the driver will under-read the ICM20602's FIFO
> > register, causing the same (partial) sample to be returned
> > for all reads, until the FIFO overflows.
> >
> > Fix this by adding a table of scan elements specifically
> > for the ICM20602, which takes the extra temperature data
> > into consideration.
> >
> > While we're at it, fix the temperature offset and scaling
> > on ICM20602, since it uses different scale/offset constants
> > than the rest of the MPU6xxx devices.
> >
> > Signed-off-by: Steve Moskovchenko <stevemo@skydio.com> =20
> I'd like a reviewed-by or acked-by from Jean-Baptiste on this before
> I take it.
>=20
> thanks,
>=20
> Jonathan
>=20
> > ---
> > v2: Read temperature when running in accel-only mode, too.
> >
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 46 +++++++++++++++++=
+++--
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h=C2=A0 | 20 +++++++++-
> >=C2=A0 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |=C2=A0 3 ++
> >=C2=A0 3 files changed, 64 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_core.c
> > index 650de0fefb7b..fedd3f2b0135 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> > @@ -471,7 +471,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return I=
IO_VAL_INT_PLUS_MICRO;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 case IIO_TEMP:
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D=
 0;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D INV_MPU6050_T=
EMP_SCALE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_type =3D=
=3D INV_ICM20602)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D INV_ICM20602_TEMP_SCALE;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *val2 =3D INV_MPU6050_TEMP_SCALE;
> >=C2=A0
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return I=
IO_VAL_INT_PLUS_MICRO;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 default:
> > @@ -480,7 +483,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case IIO_CHAN_INFO_OFFSET:
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 switch (chan->type) {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 case IIO_TEMP:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D INV_MPU6050_TE=
MP_OFFSET;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_type =3D=
=3D INV_ICM20602)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D INV_ICM20602_TEMP_OFFSET;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 *val =3D INV_MPU6050_TEMP_OFFSET;
> >=C2=A0
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return I=
IO_VAL_INT;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 default:
> > @@ -845,6 +851,32 @@ static const struct iio_chan_spec inv_mpu_channels=
[] =3D {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, I=
IO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
> >=C2=A0 };
> >=C2=A0
> > +static const struct iio_chan_spec inv_icm20602_channels[] =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIM=
ESTAMP),
> > +=C2=A0=C2=A0=C2=A0=C2=A0 {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .type =3D IIO_TEMP,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_OFFSET)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | BIT(IIO_CHAN_INFO_SCALE),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_index =3D INV_ICM20602_SCAN_GYRO_TEMP,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 .scan_type =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .sign =3D 's',
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .realbits =3D 16,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .storagebits =3D 16,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .shift =3D 0,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 .endianness =3D IIO_BE,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 },
> > +=C2=A0=C2=A0=C2=A0=C2=A0 },
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV=
_ICM20602_SCAN_GYRO_X),
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV=
_ICM20602_SCAN_GYRO_Y),
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV=
_ICM20602_SCAN_GYRO_Z),
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_IC=
M20602_SCAN_ACCL_Y),
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_IC=
M20602_SCAN_ACCL_X),
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_IC=
M20602_SCAN_ACCL_Z),
> > +};
> > +
> >=C2=A0 /*
> >=C2=A0=C2=A0 * The user can choose any frequency between INV_MPU6050_MIN=
_FIFO_RATE and
> >=C2=A0=C2=A0 * INV_MPU6050_MAX_FIFO_RATE, but only these frequencies are=
 matched by the
> > @@ -1100,8 +1132,14 @@ int inv_mpu_core_probe(struct regmap *regmap, in=
t irq, const char *name,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 indio_dev->name =3D name;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 indio_dev->name =3D dev_name(dev);
> > -=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->channels =3D inv_mpu_channels;
> > -=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_mp=
u_channels);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (chip_type =3D=3D INV_ICM20602) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 indio_dev->channels =3D inv_icm20602_channels;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_icm20602_channels);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 indio_dev->channels =3D inv_mpu_channels;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 indio_dev->num_channels =3D ARRAY_SIZE(inv_mpu_channels);
> > +=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=C2=A0
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->info =3D &mpu_info;
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indio_dev->modes =3D INDIO_BU=
FFER_TRIGGERED;
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_iio.h
> > index 325afd9f5f61..2ed4b98e0cd7 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > @@ -208,6 +208,9 @@ struct inv_mpu6050_state {
> >=C2=A0 #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR=C2=A0=C2=A0 6
> >=C2=A0 #define INV_MPU6050_FIFO_COUNT_BYTE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 2
> >=C2=A0
> > +/* ICM20602 FIFO samples include temperature readings */
> > +#define INV_ICM20602_BYTES_PER_TEMP_SENSOR=C2=A0=C2=A0 2
> > +
> >=C2=A0 /* mpu6500 registers */
> >=C2=A0 #define INV_MPU6500_REG_ACCEL_CONFIG_2=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0x1D
> >=C2=A0 #define INV_MPU6500_REG_ACCEL_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x77
> > @@ -229,6 +232,9 @@ struct inv_mpu6050_state {
> >=C2=A0 #define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT=C2=A0=C2=A0=C2=A0 3
> >=C2=A0 #define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT=C2=A0=C2=A0=C2=A0 3
> >=C2=A0
> > +#define INV_ICM20602_TEMP_OFFSET=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 8170
> > +#define INV_ICM20602_TEMP_SCALE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3060
> > +
> >=C2=A0 /* 6 + 6 round up and plus 8 */
> >=C2=A0 #define INV_MPU6050_OUTPUT_DATA_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 24
> >=C2=A0
> > @@ -270,7 +276,7 @@ struct inv_mpu6050_state {
> >=C2=A0 #define INV_ICM20608_WHOAMI_VALUE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0xAF
> >=C2=A0 #define INV_ICM20602_WHOAMI_VALUE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x12
> >=C2=A0
> > -/* scan element definition */
> > +/* scan element definition for generic MPU6xxx devices */
> >=C2=A0 enum inv_mpu6050_scan {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_ACCL_X,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_ACCL_Y,
> > @@ -281,6 +287,18 @@ enum inv_mpu6050_scan {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_SCAN_TIMESTAMP,
> >=C2=A0 };
> >=C2=A0
> > +/* scan element definition for ICM20602, which includes temperature */
> > +enum inv_icm20602_scan {
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_ACCL_X,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_ACCL_Y,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_ACCL_Z,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_GYRO_TEMP,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_GYRO_X,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_GYRO_Y,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_GYRO_Z,
> > +=C2=A0=C2=A0=C2=A0=C2=A0 INV_ICM20602_SCAN_TIMESTAMP,
> > +};
> > +
> >=C2=A0 enum inv_mpu6050_filter_e {
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_FILTER_256HZ_NOLP=
F2 =3D 0,
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INV_MPU6050_FILTER_188HZ,
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/i=
mu/inv_mpu6050/inv_mpu_ring.c
> > index 548e042f7b5b..57bd11bde56b 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> > @@ -207,6 +207,9 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_config.gyro_fifo=
_enable)
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 bytes_per_datum +=3D INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
> >=C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0 if (st->chip_type =3D=3D INV_ICM20602)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 bytes_per_datum +=3D INV_ICM20602_BYTES_PER_TEMP_SENSOR;
> > +
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * read fifo_count regis=
ter to know how many bytes are inside the FIFO
> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * right now =20
>=20

