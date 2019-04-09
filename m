Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FA9C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC8120818
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 01:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ifW01w+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbfDIBqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 21:46:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58547 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbfDIBqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 21:46:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dVWQ3VCZz9sPl;
        Tue,  9 Apr 2019 11:46:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554774386;
        bh=3DCKMSOsjDgJga8EvTSq1Ey7LySWGlBnCipRm+T7ZYo=;
        h=Date:From:To:Cc:Subject:From;
        b=ifW01w+Atojc0y7ZF+XLLNfZebWCHzgI29FfSr/Wicq5ck9CQll8dD0V/9ivY0hPS
         UUu0tDezlz8HaMqGzf/A7P9plGTAp/MHDM01JFkJQW8s7VDIK7oEpHQPxqp4OQJa2l
         sKtf5TCxssM9UTshVqZHH6PKU5QLf+3nMQJyOWcgsirLuAHBZanHOY+YWekQXvKQZz
         dB70NyeHC5crTDyACUwfN2C1xeEv1EH6W2PCcOi2HkOc8xXtirTxBNdmx3FWKhPEyM
         ejQ9E0ZZA6pDAUXnKDdfINMtPxSPpwR59VJ3F2lGGDV4b8aRshzjULHY9w88CTKZGh
         JbSRou++AfEDw==
Date:   Tue, 9 Apr 2019 11:46:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20190409114625.7bd282f5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/MP1ZEC1DMNnGhlx0NgPyzjm"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MP1ZEC1DMNnGhlx0NgPyzjm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

sound/soc/intel/boards/bytcht_es8316.c: In function 'snd_byt_cht_es8316_mc_=
probe':
sound/soc/intel/boards/bytcht_es8316.c:508:11: warning: cast from pointer t=
o integer of different size [-Wpointer-to-int-cast]
   quirk =3D (int)dmi_id->driver_data;
           ^

Introduced by commit

  a8d218f4fe81 ("ASoC: Intel: bytcht_es8316: Add quirk for the Teclast X98+=
 II")

--=20
Cheers,
Stephen Rothwell

--Sig_/MP1ZEC1DMNnGhlx0NgPyzjm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyr+XEACgkQAVBC80lX
0GwK9gf/aqkvqEyanVOIYi0cqqOVrgGhGY1te79jo9xpnvLrfDcQSe7mppoPU2/Z
7DXhz6YO10cacGQWPxm8Nuif1KyyoIOxMCKNhnU0cvJXt0MDYO3WImbNBMYfsAYr
4MzdC957YLuoUS2t4GiGFrTv7aG2/DYvkm20URzE7j3tUEkbRLfdaq5mkMXwB2ax
s91KVLVCx1h2rMCqr3Ej8ogeAaQYo2BoukSrBctU6NBu5Fhl9jtnSRVto+7Ozfg4
I+FNuYNpY+d0Gq4IpPy1jcMM5hK6fjiRUDEQ8MhNrAR4OZ35Ausz5ka7sf4AVStq
TP6GTeWcNKQMZ6+l1p2EpSUWC3RDyg==
=Wsb5
-----END PGP SIGNATURE-----

--Sig_/MP1ZEC1DMNnGhlx0NgPyzjm--
