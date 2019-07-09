Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708BCC606B0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F88F216FD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 08:13:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGIINH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 04:13:07 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36893 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfGIINH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 04:13:07 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id D81498057F; Tue,  9 Jul 2019 10:12:53 +0200 (CEST)
Date:   Tue, 9 Jul 2019 10:13:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     pavel@ucw.cz
Cc:     linux-kernel@vger.kernel.org, Young Xiao <92siuyang@gmail.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 22/90] usb: gadget: fusb300_udc: Fix memory leak of
 fusb300->ep[i]
Message-ID: <20190709081304.GA11574@amd>
References: <20190708150521.829733162@linuxfoundation.org>
 <20190708150523.753501550@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20190708150523.753501550@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> There is no deallocation of fusb300->ep[i] elements, allocated at
> fusb300_probe.
>=20
> The patch adds deallocation of fusb300->ep array elements.
=2E..=20
> diff --git a/drivers/usb/gadget/udc/fusb300_udc.c b/drivers/usb/gadget/ud=
c/fusb300_udc.c
> index 263804d154a7..00e3f66836a9 100644
> --- a/drivers/usb/gadget/udc/fusb300_udc.c
> +++ b/drivers/usb/gadget/udc/fusb300_udc.c
> @@ -1342,12 +1342,15 @@ static const struct usb_gadget_ops fusb300_gadget=
_ops =3D {
>  static int fusb300_remove(struct platform_device *pdev)
>  {
>  	struct fusb300 *fusb300 =3D platform_get_drvdata(pdev);
> +	int i;
> =20
>  	usb_del_gadget_udc(&fusb300->gadget);
>  	iounmap(fusb300->reg);
>  	free_irq(platform_get_irq(pdev, 0), fusb300);
> =20
>  	fusb300_free_request(&fusb300->ep[0]->ep, fusb300->ep0_req);
> +	for (i =3D 0; i < FUSB300_MAX_NUM_EP; i++)
> +		kfree(fusb300->ep[i]);
>  	kfree(fusb300);
> =20
>  	return 0;
> @@ -1491,6 +1494,8 @@ clean_up:
>  		if (fusb300->ep0_req)
>  			fusb300_free_request(&fusb300->ep[0]->ep,
>  				fusb300->ep0_req);
> +		for (i =3D 0; i < FUSB300_MAX_NUM_EP; i++)
> +			kfree(fusb300->ep[i]);
>  		kfree(fusb300);
>  	}
>  	if (reg)

Maybe it would be worth it to have a common function doing the cleanup
at this point?

Alternatively consider using devm_ function family; that deallocates
memory automatically.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl0kTJAACgkQMOfwapXb+vIp7QCggP3RXuMOj8CtICSqJ6ZdFZkz
CGQAoKm38YqmF4jSyu01AO2QaxCAvDbq
=ILf2
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
