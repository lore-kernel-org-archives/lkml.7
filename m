Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B030FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5A6217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730533AbfC2WgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:36:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:44423 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730137AbfC2WgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:36:22 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Mar 2019 15:36:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,286,1549958400"; 
   d="asc'?scan'208";a="145055763"
Received: from schintha-mobl1.amr.corp.intel.com ([10.251.143.114])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2019 15:36:21 -0700
Message-ID: <7b8d499ab640820685ddd455a26c81fb139d3c5e.camel@intel.com>
Subject: Re: [PATCH][next] ice: Use struct_size() helper
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 29 Mar 2019 15:36:21 -0700
In-Reply-To: <20190328163419.GA5446@embeddedor>
References: <20190328163419.GA5446@embeddedor>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-n6tYRBA24AulwKUphVdC"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-n6tYRBA24AulwKUphVdC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-03-28 at 11:34 -0500, Gustavo A. R. Silva wrote:
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
> instance =3D alloc(size, GFP_KERNEL);
>=20
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
>=20
> size =3D struct_size(instance, entry, count);
>=20
> This code was detected with the help of Coccinelle.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks Gustavo, I will queue this up.

--=-n6tYRBA24AulwKUphVdC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlyeneUACgkQ5W/vlVpL
7c6QwQ//dxRCV3e7CXZvdPRGR6mHS5548xG4BZr1U5O5CgUN0UdGKcQzTsfVrNew
HpLGg0C/64DadfCavtUy4rdOnpt1hzCfMBFmobaos2a8XkzYkwGAVLi179ZaN/8T
b130eFGbHMM82NUR7l4f8XtmdYQ7xwrJawxgfx28khVmop4q5sPLAIbJLHMukBkx
wJyWceqa9wh5QjYcJhgQU/pCVREARJ9a0rWKMzpjs/+QbKq2bTUZD+pZr5Z1LbdM
pVZllaf0aiKzAcoPV/6M0PtFA5ZrT46+pUBSb7XgYYoYC2x6d2mLxH0DDZ/JWUZO
4DhV6hpxsItYTiaq/yUqUKAxrJcBu0kR29oRtA1UAHTD6Uti08Jfg2acJKlcjOI+
xLRZZcbC2jr1Q7u3LZeL8VPhxk7dPGrn7awaiD3AEjTRZPsQIroXH8UW/Sb1qY+1
C07045tviQPds5CESCtNBW1Q/K8YI5qVqJuEF4Ez7guGUCWiYl1HHrHU06St+1I3
h+y88edgwPibWKrITE6RSH1qINKWKZdQwwbWNWJGnT5GLYpRWJtvXRc3y0Mzma/0
f46FfWuHzJJeBJhJ8/4oZ9pzs9yhAeDDtULPEQlL1KE9C/yS98dygA0MGByAa9Ux
iBYjj+cvQ0Kfg+IPHtrWxCCi+kK0QHtwtpNg3DYx97rdq81pc60=
=PtKg
-----END PGP SIGNATURE-----

--=-n6tYRBA24AulwKUphVdC--

