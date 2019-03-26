Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D22C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2D820811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbfCZWTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:19:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:8936 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729506AbfCZWTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:19:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 15:19:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,274,1549958400"; 
   d="asc'?scan'208";a="330944834"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by fmsmga006.fm.intel.com with ESMTP; 26 Mar 2019 15:19:45 -0700
Message-ID: <5bf2a409fb5f3fbb44ac3eda591ba0cbc6122d44.camel@intel.com>
Subject: Re: [PATCH] net: fm10k: fix a potential NULL pointer dereference
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, "David S. Miller" <davem@davemloft.net>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 Mar 2019 15:21:41 -0700
In-Reply-To: <FA2DD268-9578-49B5-8E9E-D3FA8C9AEDFC@umn.edu>
References: <20190311061732.19064-1-kjlu@umn.edu>
         <FA2DD268-9578-49B5-8E9E-D3FA8C9AEDFC@umn.edu>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-v5t2SqFGA1CzO/OY134f"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-v5t2SqFGA1CzO/OY134f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-03-22 at 22:26 -0500, Kangjie Lu wrote:
> > On Mar 11, 2019, at 1:17 AM, Kangjie Lu <kjlu@umn.edu> wrote:
> >=20
> > In case alloc_workqueue fails, the fix returns -ENOMEM to avoid
> > potential NULL pointer dereference.
> >=20
> > Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> > ---
> > drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > index 5a0419421511..215f232674f1 100644
> > --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> > @@ -41,6 +41,8 @@ static int __init fm10k_init_module(void)
> > 	/* create driver workqueue */
> > 	fm10k_workqueue =3D alloc_workqueue("%s", WQ_MEM_RECLAIM, 0,
> > 					  fm10k_driver_name);
> > +	if (unlikely(!fm10k_workqueue))
> > +		return -ENOMEM;
> >=20
>=20
> Jeff, can you review this patch?

Yep, sorry for the delay in getting back to you.  I already had this
change in my tree queued up from Yue Haibing.  I am actually preparing
to push this fix and few others to Dave in a couple of hours.

>=20
> > 	fm10k_dbg_init();
> >=20
> > --=20
> > 2.17.1
> >=20


--=-v5t2SqFGA1CzO/OY134f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAlyapfUACgkQ5W/vlVpL
7c6uMA//chPevC63IzhImPhVpOM9YY6K1j2nV805nzKcruLfkWWiMOxGJOBgGlJa
tXvYf4LqqKU7ubwcA+IeDHiatMh9+VmHGxblTP/rKHdU3tBQxJtSsCxI4CgBfd19
3C9M8WLxw7gD3ziWfNGHT4ZRzUpJ5iX73nGuaBUH4lHPKWzRo/cECbO+5rGqtD9g
LgI0QU8gMnmA6ka0xjBs5JkJdPU8ja4MFA2eZLagXzYCWmM3xrwsCPW9ZSQkgMAo
dzvMnDDzi0PcpQI1IRHDgoQt3T8r3EtAtcED2yi8W2X3dH2XvCGXaATXPabPHj8B
Xi+Z0qb1nUHfCacAxw/lNLa/ISqvZi1RqoMN5Qu5y1ISwm1we3COPxKZh6aihGMK
7s98rNq3d0/FGQSgqSlrr14EScBi991vX5rpgLD9L77LX4ugBt2Xc1b1bVfaF9hz
IkLCi6qfgPm1HF8y9VLgKI2CW8aauAHXDZWLVEYCOeGq4tXr5Q2jYKgh2NzRRqdQ
MX3T4TfwFkoSxTWlMespV8OnoQWA+LxUyN3FhVBeE89wtQ7mgCcnrY4Kt/WpvN9G
YssKf347Ljw2ME8Uqr8s9Qly5eJ7FZxK/hzZeEH1QQjR89lBHMcPKEKlpGux6Uwv
/EiwdKmXMb3H8B1cEvogn395yj+HWq82Q+3Go6bbwo+UIxPTmBk=
=efGo
-----END PGP SIGNATURE-----

--=-v5t2SqFGA1CzO/OY134f--

