Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAB0C31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 19:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096052070B
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 19:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfFPTlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 15:41:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54616 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfFPTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 15:41:09 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 3638A801F6; Sun, 16 Jun 2019 21:40:55 +0200 (CEST)
Date:   Sun, 16 Jun 2019 21:41:05 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Jiada Wang <jiada_wang@mentor.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 017/118] thermal: rcar_gen3_thermal: disable
 interrupt in .remove
Message-ID: <20190616194105.GA6676@amd>
References: <20190613075643.642092651@linuxfoundation.org>
 <20190613075644.637943969@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <20190613075644.637943969@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

stable removed from cc.


On Thu 2019-06-13 10:32:35, Greg Kroah-Hartman wrote:
> [ Upstream commit 63f55fcea50c25ae5ad45af92d08dae3b84534c2 ]
>=20
> Currently IRQ remains enabled after .remove, later if device is probed,
> IRQ is requested before .thermal_init, this may cause IRQ function be
> called before device is initialized.
>=20
> this patch disables interrupt in .remove, to ensure irq function
> only be called after device is fully initialized.

Well, I guess this fixes your problem, but it does not seem like a
correct fix.

Could .init be reordered so that you initialize hardware, first, and
only then request irq? That should solve the problem in a reliable
way.

Thanks,

								Pavel

> +++ b/drivers/thermal/rcar_gen3_thermal.c
> @@ -328,6 +328,9 @@ MODULE_DEVICE_TABLE(of, rcar_gen3_thermal_dt_ids);
>  static int rcar_gen3_thermal_remove(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> +	struct rcar_gen3_thermal_priv *priv =3D dev_get_drvdata(dev);
> +
> +	rcar_thermal_irq_set(priv, false);
> =20
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0Gm1EACgkQMOfwapXb+vLh9QCeMXFi73ITs+6YvBFddy8uY9Et
gBkAnj+MMzzdLuuuaDdCxm7MtjGbSYo5
=Dtfz
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
