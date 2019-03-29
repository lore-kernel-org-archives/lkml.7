Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED81EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0033218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbfC2Wgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:36:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:53407 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbfC2Wgk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:36:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 15:36:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="asc'?scan'208";a="159703544"
Received: from schintha-mobl1.amr.corp.intel.com ([10.251.143.114])
  by fmsmga001.fm.intel.com with ESMTP; 29 Mar 2019 15:36:39 -0700
Message-ID: <96cbc3326d61bc318a2def0c590de82fb08a6328.camel@intel.com>
Subject: Re: [PATCH][next] iavf: use struct_size() in kzalloc()
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 Mar 2019 15:36:38 -0700
In-Reply-To: <20190328174531.GA17630@embeddedor>
References: <20190328174531.GA17630@embeddedor>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-WOBYieXi2lziu+//gPdS"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WOBYieXi2lziu+//gPdS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-03-28 at 12:45 -0500, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
>=20
> struct foo {
>     int stuff;
>     struct boo entry[];
> };
>=20
> size =3D sizeof(struct foo) + count * sizeof(struct boo);
> instance =3D kzalloc(size, GFP_KERNEL)
>=20
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>=20
> instance =3D kzalloc(struct_size(instance, entry, count), GFP_KERNEL)
>=20
> Notice that, in this case, variable bufsz is not necessary, hence it
> is removed.
>=20
> This code was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Thanks Gustavo, I will queue this up.

--=-WOBYieXi2lziu+//gPdS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlyenfYACgkQ5W/vlVpL
7c6OLhAAl109XRZokpOsyeBSMWuhxnQndTVON1QvosMvLCSZ/fueTJ47xkDf0whU
mzEaAjdsTJMDADATZQkO57J4IQGGRw7KsMz3lUkSlwFEJxv09q/VK9fy847IFsb8
hBgSU9veQKkOx8jJW7HVnTqbxBT5PgYpYkHzZ6eqKFC97sg4UKvSo47jLkSKFFhG
VIUn/W3l/BLYUU5z3Q8Job7XUT6jMjW9PNbzL1aWQ4VRiIq8cLBFonzqJErqVGaP
UjjlJfCH7Zi19CGMoaksfifNPWJmC+6vb0AxfJ5oBzsjry3zlEfuKj2lP7h61cX0
lWLjj3upVqpavpIC0ltS/wzJm8pH+vqh1UcVOhWJUWbHx24Yri8RORk7MzejDscW
9XWrY8Ud1pPnsdGhavxct/L35+RfDClnb9Ory/W7OFZnA2uuG0oPC+s3/il2oglD
Kp9FT5E7Z47g02ndLDzqroh8a5fWZ6MNV7iaLW1nGAhCDR3gyFkCC2zJOwMDVxDq
n7RiOyw4TA9//+Xdf6bOs8S4/Gi6BWHznocAJ3Tv4stjt1IoEbQN2OiG4HrbyM8M
pwUxmIcCVEWqEfh/XnC/TnrwJVkKAi2eNqzhBpeGpA3s8Zf9MQCge9ELElKlxJEK
leC1A5fNu0bKeYD1EV4xgcOn2IzVBnITiuSUpgqx5M6atkxCdtI=
=Czrf
-----END PGP SIGNATURE-----

--=-WOBYieXi2lziu+//gPdS--

