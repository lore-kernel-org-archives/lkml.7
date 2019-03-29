Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3881BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A03217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbfC2WhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:37:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:37562 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbfC2WhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:37:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 15:36:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="asc'?scan'208";a="138458005"
Received: from schintha-mobl1.amr.corp.intel.com ([10.251.143.114])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2019 15:36:59 -0700
Message-ID: <51444c930eb77df0acfdbd354ef003b81e6c6b66.camel@intel.com>
Subject: Re: [PATCH][next] i40e: Use struct_size() in kzalloc()
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 Mar 2019 15:36:58 -0700
In-Reply-To: <20190328175223.GA18532@embeddedor>
References: <20190328175223.GA18532@embeddedor>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-z7V8TW3p32cWZ6khHBTT"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-z7V8TW3p32cWZ6khHBTT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-03-28 at 12:52 -0500, Gustavo A. R. Silva wrote:
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
> Notice that, in this case, variable size is not necessary, hence it
> is removed.
>=20
> This code was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks Gustavo, I will queue this up.

--=-z7V8TW3p32cWZ6khHBTT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlyengoACgkQ5W/vlVpL
7c7L7hAAmhMw6cOgofeUL6iNvuJFDjYu4IWgFedSGVmTdML+bXuGSvpV32hR7kB/
aBWhu1vl75y39zknHcjRxB9/xsHSCzG22O968ADjJsl+UPHmeVvAtUBvGFXoBddB
tu41Lj75Sy8MwducdJCHp4IfdpoyRcboaxkGz7eKmuqHZ2PnnuQBtz4/45AwRmkw
aDHA4hK+aGVKgY1Ul+c9LkcAp4fTv5s4bXOchgInjDdP/sKAEejk12U37Z7838rj
uSFMywG/zOQfe2wYrsUcOv+1or/jIP8dHDvtPMM9uJbhNSH8/0h2FMouUGNeK1iK
UjURgfrioJmfAapMGppGWt1Q8MjTAvago+f7ZOZFIRKAtqtWnEBfpTWI3I3cl4YN
kCJuo0mYPD9ZNXpTxQQvkgYTGFp17R8MzZPlwqcALwQZwPjT2YbZoQvyaJIWQPmI
TSyjOG6ept+JrJLm5lCktZarXaNiFLV+KGVAJgFy//n7ZZIU7zluZTRPLJ3MraKa
iLYzQmX5vIsni+LGzT1g05L8eOeeufTcEeSnVCiEJsJRL2MzVyH8x9IEaB5mlK8T
8MiqQ+UO9LKZzhFcV+xafsJE6maOv8M8fas/FKlUVdZLuA3zn+wCJac/lDWHycLu
87jZoK/+vT9xdANMDsv40IAVoU9j0ZJL9aOTM3ChoMW90C/d1vs=
=j+4y
-----END PGP SIGNATURE-----

--=-z7V8TW3p32cWZ6khHBTT--

