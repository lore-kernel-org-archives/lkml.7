Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD09C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C03221783
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 10:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbfKMKma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 05:42:30 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:50244 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfKMKma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 05:42:30 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 571C01C122E; Wed, 13 Nov 2019 11:42:28 +0100 (CET)
Date:   Wed, 13 Nov 2019 11:42:27 +0100
From:   Pavel Machek <pavel@denx.de>
To:     pavel@denx.de
Cc:     linux-kernel@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 123/125] iio: imu: inv_mpu6050: fix no data on
 MPU6050
Message-ID: <20191113104227.GC32553@amd>
References: <20191111181438.945353076@linuxfoundation.org>
 <20191111181456.142299857@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
Content-Disposition: inline
In-Reply-To: <20191111181456.142299857@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Mon 2019-11-11 19:29:22, Greg Kroah-Hartman wrote:
> From: Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
>=20
> [ Upstream commit 6e82ae6b8d11b948b74e71396efd8e074c415f44 ]
>=20
> Some chips have a fifo overflow bit issue where the bit is always
> set. The result is that every data is dropped.
>=20
> Change fifo overflow management by checking fifo count against
> a maximum value.
>=20
> Add fifo size in chip hardware set of values.

> @@ -216,6 +213,18 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	if (result)
>  		goto end_session;
>  	fifo_count =3D get_unaligned_be16(&data[0]);
> +
> +	/*
> +	 * Handle fifo overflow by resetting fifo.
> +	 * Reset if there is only 3 data set free remaining to mitigate
> +	 * possible delay between reading fifo count and fifo data.
> +	 */
> +	nb =3D 3 * bytes_per_datum;
> +	if (fifo_count >=3D st->hw->fifo_size - nb) {
> +		dev_warn(regmap_get_device(st->map), "fifo overflow reset\n");
> +		goto flush_fifo;
> +	}
> +
>  	/* compute and process all complete datum */
>  	nb =3D fifo_count / bytes_per_datum;
>  	inv_mpu6050_update_period(st, pf->timestamp, nb);

Would this make sense to reduce code duplication?

Signed-off-by: Pavel Machek <pavel@denx.de>

Best regards,
									Pavel

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/i=
nv_mpu6050/inv_mpu_ring.c
index 548e042f7b5b..9b9d90f41610 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -232,16 +232,12 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 		timestamp =3D inv_mpu6050_get_timestamp(st);
 		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
 	}
-
-end_session:
-	mutex_unlock(&st->lock);
-	iio_trigger_notify_done(indio_dev->trig);
-
-	return IRQ_HANDLED;
+	goto end_session;
=20
 flush_fifo:
 	/* Flush HW and SW FIFOs. */
 	inv_reset_fifo(indio_dev);
+end_session:
 	mutex_unlock(&st->lock);
 	iio_trigger_notify_done(indio_dev->trig);
=20

--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl3L3hMACgkQMOfwapXb+vK3BQCfQf/mNq0hXcQ2MvLDrh/KCvUU
OCkAnjKy1oEzOXUNQmkWf+iH6Kdji+Eo
=kKFw
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
