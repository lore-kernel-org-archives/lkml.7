Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2877C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D292E222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 13:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfKMNwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 08:52:11 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:47828 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKMNwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:52:11 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A2DFF1C1250; Wed, 13 Nov 2019 14:52:09 +0100 (CET)
Date:   Wed, 13 Nov 2019 14:52:09 +0100
From:   Pavel Machek <pavel@denx.de>
To:     pavel@denx.de
Cc:     linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 113/125] usb: dwc3: gadget: fix race when disabling
 ep with cancelled xfers
Message-ID: <20191113135209.GB20980@duo.ucw.cz>
References: <20191111181438.945353076@linuxfoundation.org>
 <20191111181454.916507789@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20191111181454.916507789@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Felipe Balbi <felipe.balbi@linux.intel.com>
>=20
> [ Upstream commit d8eca64eec7103ab1fbabc0a187dbf6acfb2af93 ]
>=20
> When disabling an endpoint which has cancelled requests, we should
> make sure to giveback requests that are currently pending in the
> cancelled list, otherwise we may fall into a situation where command
> completion interrupt fires after endpoint has been disabled, therefore
> causing a splat.
>=20
> Fixes: fec9095bdef4 "usb: dwc3: gadget: remove wait_end_transfer"
> Reported-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
> Link: https://lore.kernel.org/r/20191031090713.1452818-1-felipe.balbi@lin=
ux.intel.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/dwc3/gadget.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 54de732550648..8398c33d08e7c 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -698,6 +698,12 @@ static void dwc3_remove_requests(struct dwc3 *dwc, s=
truct dwc3_ep *dep)
> =20
>  		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
>  	}
> +
> +	while (!list_empty(&dep->cancelled_list)) {
> +		req =3D next_request(&dep->cancelled_list);
> +
> +		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
> +	}
>  }

This is third copy of a loop. Perhaps it is time to create a helper?

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXcwKiQAKCRAw5/Bqldv6
8ixSAKCflMLincjXXFUMPrtOaJvWPURdqgCfXnLt5LhqLyDYBsUy8nhX0Yo05tM=
=a3RU
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
