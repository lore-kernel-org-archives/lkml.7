Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54721C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179622085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCRLYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:24:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:60366 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfCRLYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:24:34 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BD1AB805BC; Mon, 18 Mar 2019 12:24:24 +0100 (CET)
Date:   Mon, 18 Mar 2019 12:24:31 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-leds@vger.kernel.org
Subject: Re: [PATCH v2 2/6] leds: netdev trigger: factor out middle part of
 device_name_store
Message-ID: <20190318112431.GB6101@amd>
References: <20190313202615.22883-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-1-linux@rasmusvillemoes.dk>
 <20190314140619.3309-3-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
In-Reply-To: <20190314140619.3309-3-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Take the part of device_name_store that puts the old device (if any),
> copies the new device name, looks the name up etc. into a separate
> helper function. This is preparation for using that helper from a
> function that will initialize the led_netdev_data from a device tree
> node. No functional change.
>=20
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  drivers/leds/trigger/ledtrig-netdev.c | 30 ++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/leds/trigger/ledtrig-netdev.c b/drivers/leds/trigger=
/ledtrig-netdev.c
> index 8d476b92f58c..21605033e322 100644
> --- a/drivers/leds/trigger/ledtrig-netdev.c
> +++ b/drivers/leds/trigger/ledtrig-netdev.c
> @@ -104,19 +104,9 @@ static ssize_t device_name_show(struct device *dev,
>  	return len;
>  }
> =20
> -static ssize_t device_name_store(struct device *dev,
> -				 struct device_attribute *attr, const char *buf,
> -				 size_t size)
> +static void netdev_trig_set_device(struct led_netdev_data *trigger_data,
> +				   const char *buf, size_t size)
>  {
> -	struct led_netdev_data *trigger_data =3D led_trigger_get_drvdata(dev);
> -
> -	if (size >=3D IFNAMSIZ)
> -		return -EINVAL;
> -
> -	cancel_delayed_work_sync(&trigger_data->work);
> -
> -	spin_lock_bh(&trigger_data->lock);
> -
>  	if (trigger_data->net_dev) {
>  		dev_put(trigger_data->net_dev);
>  		trigger_data->net_dev =3D NULL;

I'd expect the helper function to do the >=3D IFNAMSIZ checking... but
not a huge deal.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyPf+8ACgkQMOfwapXb+vK4eQCcDRDfYmj+pYsMmb1KHtozXF7C
Ls0An0UlaoZ8pJxEOJEuYPMperLCEhKx
=c6Bd
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
