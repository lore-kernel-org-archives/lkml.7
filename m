Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D270C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C93E20823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560843230;
	bh=jTVsM3abHm+rU7xAxotgBljTljQR8L8QQ5Ojozvh/uo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=ehkyCpWm/1XbFFqM5AXw5yRkWUAvmr4B6LjBfRXP9N+jN8eRE3sZEFz6AOH3jBScL
	 PfKgaSmJgMLfn9ID1DI4bABV156bG6FWvg9Jwbi2aSk8x+eOvpSe9oF7SyR2jGP3Bg
	 CZBYDXMhkU2szcEcGYsW8LGMcrbrptrGgO6BzQls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfFRHds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:33:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:22887 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfFRHds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:33:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 00:33:48 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jun 2019 00:33:45 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sylvain Lemieux <slemieux.tyco@gmail.com>,
        James Grant <james.grant@jci.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] usb: gadget: udc: lpc32xx: allocate descriptor with GFP_ATOMIC
In-Reply-To: <20190510124248.2430-1-alexandre.belloni@bootlin.com>
References: <20190510124248.2430-1-alexandre.belloni@bootlin.com>
Date:   Tue, 18 Jun 2019 10:33:41 +0300
Message-ID: <87zhmffiui.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Alexandre Belloni <alexandre.belloni@bootlin.com> writes:

> Gadget drivers may queue request in interrupt context. This would lead to
> a descriptor allocation in that context. In that case we would hit
> BUG_ON(in_interrupt()) in __get_vm_area_node.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/usb/gadget/udc/lpc32xx_udc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/ud=
c/lpc32xx_udc.c
> index d8f1c60793ed..b706d9c85a35 100644
> --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> @@ -938,7 +938,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(struc=
t lpc32xx_udc *udc)
>  	struct lpc32xx_usbd_dd_gad	*dd;
>=20=20
>  	dd =3D (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
> -			udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
> +			udc->dd_cache, (GFP_ATOMIC | GFP_DMA), &dma);

doesn't apply:

checking file drivers/usb/gadget/udc/lpc32xx_udc.c
Hunk #1 FAILED at 938.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0Ik9UACgkQzL64meEa
mQZe/BAA1Wmem2fEj1kGc0BIPALzcahe+BFPQjo2Rm2du+gW/LJhZXH7KZnPXSLj
CaJGl79vPA0+cG+50uf25eAL3Q9DjuJPSENwD723ZNGdM+eLUnW5a+q8kLnGgSyk
wqgvrXzwnmiIY6v5fM4s1+gfmqZEssA9VnG+/JhODxJpVmbSEIc5WSGWmQ4zdRyO
t/82DKMnCkYRhgNzxSqVfm7Rua2bfW47UL9B4X4vm9Lgm6K5qwBAF9+AghFPDoyP
OHM1d6tPgoO1bVByW7yU3HVYKiVXnqlxo3E1M7Zm+dinuYgDrvQ7SDU9wfbhx42n
8x8NaHShxval8T2v0knz/9F0SwjU/FHAoCO3XHMzqs5u0BCFyE8FBJ0+oFCFuX90
nDBGNnIkPt3bZRdAPd1qkxBnu1tpKU8h0yguKuecPhnnm1da3/ec5pLWaLBPGlzH
5NSQt/ROyJzJAfLRiiRgFeFr6iLV4cZqM0xPdJzA8EJwZ+vQjiQKroSxAZ+6oyuW
xrd6CZaR1r1sm1OPIGOJZxb9YNfttNiOtDDe7rcP42EpyC7+IXYqmYAcHsWSr1lr
Xr6MdIJlGBH9/2F7dl3exjfe4xD8bOkwqD3LrQ8eSnNdlsRR74UcREx4llhqA/c+
PTKq6k/wEu8h2skItle3dBJX8YvNVY5JMWoGO5s78MIW7Zkf8Co=
=U+ZK
-----END PGP SIGNATURE-----
--=-=-=--
