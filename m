Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A050C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49F9A218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554473061;
	bh=tXofxIeRxSbVJICOj67+SiNUoai6W5vF0h3jC8BRAAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k0utafkCZIpLiDcHPsV6uOzIQplcqxKBpRX4GNnAe4XhqnFk+YXoAYpT6rDgK5daR
	 eRRddDxWLPGEr7UjnTSdn+df2aTAT4xTMLpdSFilLp8HIRmO5saOVMmNx8hky5hCOg
	 8Yn7hPfJuVUYECWcEzsD8ixGm9scrkayTMvtj8QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfDEOEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbfDEOET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:04:19 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25B8921850;
        Fri,  5 Apr 2019 14:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554473058;
        bh=tXofxIeRxSbVJICOj67+SiNUoai6W5vF0h3jC8BRAAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+FobSaXOchwscsPNV7rKq/JZwOdLHT02xkh8BevXErAgV2hIthWv4HOpTVyKzCja
         IaEea7rPCHLnV3zu3DxTaOp9HSiomNAHMWSsfBLfbKBMTa2hY0c+uCOSQ1Hg08lyMW
         VUVDfAqKV/VfiynyflEjt3lojNeFjPqaSyoQMUIE=
Received: by earth.universe (Postfix, from userid 1000)
        id 599373C08D5; Fri,  5 Apr 2019 16:04:16 +0200 (CEST)
Date:   Fri, 5 Apr 2019 16:04:16 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Ramakrishna Pallala <ramakrishna.pallala@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: axp288_charger: Fix unchecked return value
Message-ID: <20190405140416.5drwsaciiipaa626@earth.universe>
References: <20190318161439.GA6245@embeddedor>
 <e42cdec8-911d-950a-8b06-3b1aefaba74c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="v4x564h5nq5jwjac"
Content-Disposition: inline
In-Reply-To: <e42cdec8-911d-950a-8b06-3b1aefaba74c@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v4x564h5nq5jwjac
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 18, 2019 at 06:32:35PM +0100, Hans de Goede wrote:
> Hi,
>=20
> On 18-03-19 17:14, Gustavo A. R. Silva wrote:
> > Currently there is no check on platform_get_irq() return value
> > in case it fails, hence never actually reporting any errors and
> > causing unexpected behavior when using such value as argument
> > for function regmap_irq_get_virq().
> >=20
> > Fix this by adding a proper check, a message reporting any errors
> > and returning *pirq*
> >=20
> > Addresses-Coverity-ID: 1443940 ("Improper use of negative value")
> > Fixes: 843735b788a4 ("power: axp288_charger: axp288 charger driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > ---
> >   drivers/power/supply/axp288_charger.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supp=
ly/axp288_charger.c
> > index f8c6da9277b3..00b961890a38 100644
> > --- a/drivers/power/supply/axp288_charger.c
> > +++ b/drivers/power/supply/axp288_charger.c
> > @@ -833,6 +833,10 @@ static int axp288_charger_probe(struct platform_de=
vice *pdev)
> >   	/* Register charger interrupts */
> >   	for (i =3D 0; i < CHRG_INTR_END; i++) {
> >   		pirq =3D platform_get_irq(info->pdev, i);
> > +		if (pirq < 0) {
> > +			dev_err(&pdev->dev, "Failed to get IRQ: %d\n", pirq);
> > +			return pirq;
> > +		}
> >   		info->irq[i] =3D regmap_irq_get_virq(info->regmap_irqc, pirq);
> >   		if (info->irq[i] < 0) {
> >   			dev_warn(&info->pdev->dev,
> >=20
>=20
> Patch looks good to me:
>=20
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

--v4x564h5nq5jwjac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynYGAACgkQ2O7X88g7
+pq8vA//eN4OarDl2zaxXoMbmcPg6MH8MglCdNeKSv17IjTlOmB0gqHWPL70L7VQ
0MQrw6xh6NAqpI7toux3uzNycRgddQBTV9WyDs6Ry8b7xrcV9QhweECuFOqypwJe
RQmn+zkHgl84O4UC5DR3mVnHpxVTryZ1wpL7mVxJIQuQki1tDJDcsSepniyBb70Y
1enxIVp/CXD5haKmXDHbVKn055RBye5aRa+iIgN/ng7ecJ0xBp4owqj1UU31i0MX
6Y+9F3j6+i9bKrLVjWzl1MQwnK0s1AE+XXy1jD05Pke5c6ffE012+683R4CWlugv
npaTgdfiEJvIYfFjW8zp+FJRSjxPgLxfPocv1c74ajIWjzmcHeKOhMvsSLtO5wfz
6XAQdWOIQiKVlyvhk8zkC9rkHJ2jvVYs0Nte9U0HCoGCGJ5SjW3QHFA8mX5pX2NH
SVyr3gOgVw2r1aIAW8+QZqawQ9TOcXuIKk9fjH/WwFR9yHy7Ozn42hgdJ/LnQtHP
5OKnwqKp9LWqffTj2Yt3w+dkhJcgHlPadidSetpATUt2JumfEBSYgL3s65jlF1m9
6taemwpXLHFoLvakJMM+iBjzhaPnrV/k6Rbx8c/uG8WFg0fQb0UZJVaU+2awrqmy
YTtHYPuYguprytU/Wy0repRDfeTE3pYEJcBp+MwHRcKsMphu/j8=
=QiiC
-----END PGP SIGNATURE-----

--v4x564h5nq5jwjac--
