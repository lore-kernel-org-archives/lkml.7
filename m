Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989F2C10F00
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8FA20842
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 16:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551630049;
	bh=Fl4XDc1TSgQkLG8CUDvtRZ9nUfLZ6Zal4BNSZ1/lgpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lko66C/VM9aH/p8LUp53xNO16hLIpHexOQy91qMhUDnOxhL6ha3DKdJz0PRZgT72y
	 5pADCFJ7uF3OMR8jBp3FmKqagxobhvPA8VqGlpyppIXxoMKSAxG6M6YFSP2b0NwTyA
	 ZGIMg6dbir66Ytpro5g1P2cq9YMqAAAgnVu0iGk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfCCQUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 11:20:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfCCQUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 11:20:47 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC3E20818;
        Sun,  3 Mar 2019 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551630046;
        bh=Fl4XDc1TSgQkLG8CUDvtRZ9nUfLZ6Zal4BNSZ1/lgpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r826n7cJYFo2rmUXxf8vF59/ioGtth63YZ04yLvRsEpJPqDX3NkSbL5qO9ZJwppp9
         eTuHNIDsZGtyuuIlmMeLYbUv/MN74mcNyUp7aU6ofrNi1C5YoGhKngn+drLRPjsshG
         1eajzbjNREKDg2P3WKKfl6uvU0qpPc1k0bS6gNGU=
Date:   Sun, 3 Mar 2019 16:20:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] iio: cros_ec_accel_legacy: Refactor code in
 cros_ec_accel_legacy_probe
Message-ID: <20190303162040.152e4613@archlinux>
In-Reply-To: <946ab58e-ad7e-4815-4dd3-42aeaa3f4299@collabora.com>
References: <20190221020633.GA4195@embeddedor>
        <CAGXu5jK1fKaSSfHP1dGFyKVjRM7APvqdOhHNjZnN=+An950J1A@mail.gmail.com>
        <946ab58e-ad7e-4815-4dd3-42aeaa3f4299@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Feb 2019 09:03:39 +0100
Enric Balletbo i Serra <enric.balletbo@collabora.com> wrote:

> On 21/2/19 8:00, Kees Cook wrote:
> > On Wed, Feb 20, 2019 at 6:06 PM Gustavo A. R. Silva
> > <gustavo@embeddedor.com> wrote: =20
> >>
> >> Refactor some code in order to fix both the technical implementation
> >> and the following warnings:
> >>
> >> drivers/iio/accel/cros_ec_accel_legacy.c: In function =E2=80=98cros_ec=
_accel_legacy_probe=E2=80=99:
> >> drivers/iio/accel/cros_ec_accel_legacy.c:387:36: warning: this stateme=
nt may fall through [-Wimplicit-fallthrough=3D]
> >>     ec_accel_channels[X].scan_index =3D Y;
> >>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> >> drivers/iio/accel/cros_ec_accel_legacy.c:388:3: note: here
> >>    case Y:
> >>    ^~~~
> >> drivers/iio/accel/cros_ec_accel_legacy.c:389:36: warning: this stateme=
nt may fall through [-Wimplicit-fallthrough=3D]
> >>     ec_accel_channels[Y].scan_index =3D X;
> >>     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> >> drivers/iio/accel/cros_ec_accel_legacy.c:390:3: note: here
> >>    case Z:
> >>    ^~~~
> >>
> >> Notice that neither the for loop nor the switch statement is needed.
> >> Also, "state->sign[Y] =3D 1" should be unconditional.
> >>
> >> This patch is part of the ongoing efforts to enable
> >> -Wimplicit-fallthrough.
> >>
> >> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com> =20
> >=20
> > Acked-by: Kees Cook <keescook@chromium.org>
> >  =20
>=20
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

This will probably only make it upstream at the 'next' merge window
given the timing.

Jonathan

>=20
> Thanks,
>  Enric
>=20
> > -Kees
> >  =20
> >> ---
> >>  drivers/iio/accel/cros_ec_accel_legacy.c | 27 +++++++++++-------------
> >>  1 file changed, 12 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/ac=
cel/cros_ec_accel_legacy.c
> >> index 063e89eff791..021f9f5cd3bb 100644
> >> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> >> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> >> @@ -353,7 +353,7 @@ static int cros_ec_accel_legacy_probe(struct platf=
orm_device *pdev)
> >>         struct cros_ec_sensor_platform *sensor_platform =3D dev_get_pl=
atdata(dev);
> >>         struct iio_dev *indio_dev;
> >>         struct cros_ec_accel_legacy_state *state;
> >> -       int ret, i;
> >> +       int ret;
> >>
> >>         if (!ec || !ec->ec_dev) {
> >>                 dev_warn(&pdev->dev, "No EC device found.\n");
> >> @@ -381,20 +381,17 @@ static int cros_ec_accel_legacy_probe(struct pla=
tform_device *pdev)
> >>          * Present the channel using HTML5 standard:
> >>          * need to invert X and Y and invert some lid axis.
> >>          */
> >> -       for (i =3D X ; i < MAX_AXIS; i++) {
> >> -               switch (i) {
> >> -               case X:
> >> -                       ec_accel_channels[X].scan_index =3D Y;
> >> -               case Y:
> >> -                       ec_accel_channels[Y].scan_index =3D X;
> >> -               case Z:
> >> -                       ec_accel_channels[Z].scan_index =3D Z;
> >> -               }
> >> -               if (state->sensor_num =3D=3D MOTIONSENSE_LOC_LID && i =
!=3D Y)
> >> -                       state->sign[i] =3D -1;
> >> -               else
> >> -                       state->sign[i] =3D 1;
> >> -       }
> >> +       ec_accel_channels[X].scan_index =3D Y;
> >> +       ec_accel_channels[Y].scan_index =3D X;
> >> +       ec_accel_channels[Z].scan_index =3D Z;
> >> +
> >> +       state->sign[Y] =3D 1;
> >> +
> >> +       if (state->sensor_num =3D=3D MOTIONSENSE_LOC_LID)
> >> +               state->sign[X] =3D state->sign[Z] =3D -1;
> >> +       else
> >> +               state->sign[X] =3D state->sign[Z] =3D 1;
> >> +
> >>         indio_dev->num_channels =3D ARRAY_SIZE(ec_accel_channels);
> >>         indio_dev->dev.parent =3D &pdev->dev;
> >>         indio_dev->info =3D &cros_ec_accel_legacy_info;
> >> --
> >> 2.20.1
> >> =20
> >=20
> >  =20

