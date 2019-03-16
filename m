Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C12C10F03
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E22E21900
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552749560;
	bh=gOOpIFtVh5xUu2k7isOm9AZJajRq6QzGqLm65AeifFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lsZY3d5H+6xqIc2PdUnacL9lD9vxlHrRlE5nwBNqXnKI9ED3x+PsToUPX/1sqOuPN
	 xO9yUQJr/glzyh3AkPgmqx12QDIG6yCdQxpvzACuzJGhxLGSluH/sUbbj6LZaBVq73
	 EKBCY6uxowF8m9UOCtBExYwXYnZuijJdgRQhQEE4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfCPPTT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 11:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfCPPTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 11:19:18 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB8B20449;
        Sat, 16 Mar 2019 15:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552749557;
        bh=gOOpIFtVh5xUu2k7isOm9AZJajRq6QzGqLm65AeifFo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oh3Qfp0qkhvw8/3t0OKODyUVJcPDFpxaC5IqmZeFzpsHttN4505YxMhTrZXKJxC31
         uffKpHqY+JHZ0hT4RFTJyMVlF/bo7KN6IHTgmue4rGTNiPVcnpQOLXmrdaBGNU+Ucm
         qUwkLBdep/DRtNeKq1vmwZSIlkuHnDslRNaM4DxY=
Date:   Sat, 16 Mar 2019 15:19:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, pakki001@umn.edu,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: hmc: fix a potential NULL pointer dereference
Message-ID: <20190316151912.4a7ea87d@archlinux>
In-Reply-To: <57617810-6F1A-41BF-889C-7A056423C360@umn.edu>
References: <20190309051533.14309-1-kjlu@umn.edu>
        <20190309134208.GA7820@arch>
        <20190309182950.67a7dd9d@archlinux>
        <57617810-6F1A-41BF-889C-7A056423C360@umn.edu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 02:19:25 -0500
Kangjie Lu <kjlu@umn.edu> wrote:

> > On Mar 9, 2019, at 12:29 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> >=20
> > On Sat, 9 Mar 2019 14:42:09 +0100
> > Tomasz Duszynski <tduszyns@gmail.com <mailto:tduszyns@gmail.com>> wrote:
> >  =20
> >> On Fri, Mar 08, 2019 at 11:15:32PM -0600, Kangjie Lu wrote: =20
> >>> devm_regmap_init_i2c may fail and return NULL. The fix returns
> >>> the error when it fails.
> >>>=20
> >>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> >>> ---
> >>> drivers/iio/magnetometer/hmc5843_i2c.c | 7 ++++++-
> >>> 1 file changed, 6 insertions(+), 1 deletion(-)
> >>>=20
> >>> diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/mag=
netometer/hmc5843_i2c.c
> >>> index 3de7f4426ac4..c0cd0823f8d5 100644
> >>> --- a/drivers/iio/magnetometer/hmc5843_i2c.c
> >>> +++ b/drivers/iio/magnetometer/hmc5843_i2c.c
> >>> @@ -58,8 +58,13 @@ static const struct regmap_config hmc5843_i2c_regm=
ap_config =3D {
> >>> static int hmc5843_i2c_probe(struct i2c_client *cli,
> >>> 			     const struct i2c_device_id *id)
> >>> {
> >>> +	struct regmap *devm_regmap =3D devm_regmap_init_i2c(cli,
> >>> +			&hmc5843_i2c_regmap_config);
> >>> +	if (IS_ERR(devm_regmap))
> >>> +		return PTR_ERR(devm_regmap);   =20
> >>=20
> >> This fixes only one part of the problem leaving identical spi issue
> >> behind. I guess this check should be part of *common_probe(). =20
> > It could be, but that somewhat hides the error checking.
> >=20
> > I'd prefer to see it fixed like this, but in both here and the spi
> > file.  Both this and spi in one patch would be great! =20
>=20
> I=E2=80=99ve submitted the patch for spi as well.
>=20
Ah. I missed it because of inconsistent patch naming.
Anyhow, there were some minor suggestions for that patch so please
send a v2 with the two combined.

Thanks

Jonathan

> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> >>  =20
> >>> +
> >>> 	return hmc5843_common_probe(&cli->dev,
> >>> -			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
> >>> +			devm_regmap,
> >>> 			id->driver_data, id->name);
> >>> }
> >>>=20
> >>> --
> >>> 2.17.1 =20
>=20

