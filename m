Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB69C5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878822070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="OoHZWIRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfF1EDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:03:08 -0400
Received: from ozlabs.org ([203.11.71.1]:58479 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbfF1EDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:03:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Zjm92mlYz9s7h;
        Fri, 28 Jun 2019 14:03:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561694585;
        bh=1xxaUcHXNZx9a9L4jaTe1rLO2EjfRqlBYzQY8OCcWtI=;
        h=Date:From:To:Cc:Subject:From;
        b=OoHZWIRk/N/E3O1e01DpotdFRqSgWmM/gWPqezDHwWmsUiFUf8dndBJR7/ZtdAMoz
         ztRZ2b9Wi/hdnpb/51asJFbauMLs6cpiBOtbQLMLY/g1dsamlbXA9QKiZ3P9r+grB1
         nIOpb1iKe6b0psoBus2KvkEktWNRkUQqT2X7hicm88HE19x53H/bPi9NBGirmzDeX3
         yxo67Bme57WJwFrXmGy6PUd3jBQxlTIjnQouh3UGXHV8jH9Fcu55xWXcmEq8r910kQ
         oUNAlpfMBpY2VYqX09YgNhgXWskgIzLv06LA68u0kokuDYP80PSe8UciVCyD8NkiBn
         z8tl79RvYCk0Q==
Date:   Fri, 28 Jun 2019 14:03:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: linux-next: build failure after merge of the battery tree
Message-ID: <20190628140304.76caf572@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+DcRGNVT1eLZ5KLQYd.lr_3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+DcRGNVT1eLZ5KLQYd.lr_3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the battery tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/power/supply/wilco-charger.c: In function 'wilco_charge_get_propert=
y':
drivers/power/supply/wilco-charger.c:104:8: error: implicit declaration of =
function 'wilco_ec_get_byte_property'; did you mean 'wilco_charge_get_prope=
rty'? [-Werror=3Dimplicit-function-declaration]
  ret =3D wilco_ec_get_byte_property(ec, property_id, &raw);
        ^~~~~~~~~~~~~~~~~~~~~~~~~~
        wilco_charge_get_property
drivers/power/supply/wilco-charger.c: In function 'wilco_charge_set_propert=
y':
drivers/power/supply/wilco-charger.c:130:10: error: implicit declaration of=
 function 'wilco_ec_set_byte_property'; did you mean 'wilco_charge_set_prop=
erty'? [-Werror=3Dimplicit-function-declaration]
   return wilco_ec_set_byte_property(ec, PID_CHARGE_MODE, mode);
          ^~~~~~~~~~~~~~~~~~~~~~~~~~
          wilco_charge_set_property

Caused by commit

  0736343e4c56 ("power_supply: wilco_ec: Add charging config driver")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/+DcRGNVT1eLZ5KLQYd.lr_3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0VkXgACgkQAVBC80lX
0GyXFAgAoCNNVdJJBy+QZElB1nIow/MKshUWleBAyuiAgntwnubop5lc2yDDk52n
BR8DQDvTbOn0IxEKXEawJcQt9RxgECQ28UvdvaeRnXZKR54YQbPEudqrCIrmzTWx
bVyUMMkTZVi/juXZUnOdOlh95TqTJE0vu3Bt/uGm6ygi5JUBLRdq+nmU2aHmmSUM
B+Gvot4+/B5zAqYQ4viMEkk5aD12thD1/X5bcqwd2ejhrPmSZ/H4kT/kGa4eSwh6
wix5qGr0PIDFgnQhVgzszG1cvNPNFC8ZgCul4NXwih1U31k/wWjrpidrdmU7+hZp
m6TXQskkvPhcPiOw9YN2DOgFeCtuUA==
=aDy1
-----END PGP SIGNATURE-----

--Sig_/+DcRGNVT1eLZ5KLQYd.lr_3--
