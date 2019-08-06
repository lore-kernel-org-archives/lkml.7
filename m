Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A9FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 565B1218D8
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 07:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbfHFH34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 03:29:56 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:42819 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731807AbfHFH34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 03:29:56 -0400
Received: from uno.localdomain (mob-109-112-31-244.net.vodafone.it [109.112.31.244])
        (Authenticated sender: jacopo@jmondi.org)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 79D0420000F;
        Tue,  6 Aug 2019 07:29:51 +0000 (UTC)
Date:   Tue, 6 Aug 2019 09:31:14 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Stefan Agner <stefan@agner.ch>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: Fix temperature reading in probe
Message-ID: <20190806073114.4mujzdvbrgxivizs@uno.localdomain>
References: <20190805155515.22621-1-jacopo+renesas@jmondi.org>
 <20190805181244.663585ac@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hmkibl6tqohgtmac"
Content-Disposition: inline
In-Reply-To: <20190805181244.663585ac@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hmkibl6tqohgtmac
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Jonathan,

On Mon, Aug 05, 2019 at 06:12:44PM +0100, Jonathan Cameron wrote:
> On Mon,  5 Aug 2019 17:55:15 +0200
> Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
>
> > The max9611 driver reads the die temperature at probe time to validate
> > the communication channel. Use the actual read value to perform the test
> > instead of the read function return value, which was mistakenly used so
> > far.
> >
> > The temperature reading test was only successful because the 0 return
> > value is in the range of supported temperatures.
> >
> > Fixes: 69780a3bbc0b ("iio: adc: Add Maxim max9611 ADC driver")
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> Applied to the fixes-togreg branch of iio.git and marked for
> stable.  That'll be a bit fiddly given other changes around this
> so we may need to do backports.
>

Indeed, I should have mentioned this patch depends on Joe's
ae8cc91a7d85 ("iio: adc: max9611: Fix misuse of GENMASK macro")
which is now in linux-next, otherwise it might atually trigger errors
due to the wrong mask value.

I wonder if there's a way to keep track of these dependencies for the
sake of backporting, or it's an operation that has to be carried out
manually...

Thanks
   j

>
> > ---
> >  drivers/iio/adc/max9611.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> > index 917223d5ff5b..e9f6b1da1b94 100644
> > --- a/drivers/iio/adc/max9611.c
> > +++ b/drivers/iio/adc/max9611.c
> > @@ -480,7 +480,7 @@ static int max9611_init(struct max9611_dev *max9611)
> >  	if (ret)
> >  		return ret;
> >
> > -	regval = ret & MAX9611_TEMP_MASK;
> > +	regval &= MAX9611_TEMP_MASK;
> >
> >  	if ((regval > MAX9611_TEMP_MAX_POS &&
> >  	     regval < MAX9611_TEMP_MIN_NEG) ||
> > --
> > 2.22.0
> >
>

--hmkibl6tqohgtmac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEtcQ9SICaIIqPWDjAcjQGjxahVjwFAl1JLMIACgkQcjQGjxah
Vjx4OBAAxQU3tgkW1phGiUlCylmAblCdAtYezFCdcbL28QA5ui5zPocDUerLjRar
06uAx/kjK5oxH9rDMWh5OgwznfUkenGpNeo3n6/n7CVq6yUW4oTzb802/5EgqOfP
4P7iKVRbEwOj3DJgcS/l+GCqkZfDj+IncK5C4up2c0NYvTr4kIDOHFCr84qI4Doe
6O7DDmNZsA1GHTc/KbMBuo0AekVF7SdXgzSHm+EN41SOPK93YtvS7d9z7ethOvYr
cHrdtWveTOK+HNTO0fWILq0wdKC+n0FXSnGBVdWDPRBJCzYyUIvP9m4NTDETe9fE
PQH84hC052OmoUxwQmnLh8FB15d4VfOfP/QuykvaVuao3JoQyI4EeVzEgiGV1Eg6
nhkr/QsEMmxgAzDGVZ39eSXJWZos4lueWnQ5ohzTs5SjeYQnFsPMEnsNoGfX15wL
z3Z2hZh9Ra8fs3cDeijbwbyljffVEA+ZnFXPItjlZaNeMTKXM66qSy0vKENteRJi
JJPNAO+3/MDDWFweAUFXimd8htUSAHWEuRRG2EE5sweBam4V/AnkC3AdZsVXBMeg
QtuS4/VfkZXS1UL8FOGyWU9xQ+daMc2vMDWeA/+EwEes8s1uMzP6aAQ1h6y/W46s
g6+sxY53Yp+RzsNKoi8OCiQpF7lkESc9XxUKuKV0jhrhT6oQLZE=
=oFtH
-----END PGP SIGNATURE-----

--hmkibl6tqohgtmac--
