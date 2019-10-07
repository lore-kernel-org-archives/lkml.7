Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58248ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C869206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="gdq/aase"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbfJGX6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:58:18 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729529AbfJGX6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:58:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46nHVb3n2jz9sP7;
        Tue,  8 Oct 2019 10:58:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1570492695;
        bh=Qv3iTVsyGwJLydNCtMzU9LVXqjJPzB1CUWXM4JAvODs=;
        h=Date:From:To:Cc:Subject:From;
        b=gdq/aaseZsltn0hrUa7Kt5AlSufCJT3u2+ZTg7VHMKk94BmxRiLia1ec9H0ZQE9Qu
         zSeT70vIbHYITlKKtFC0Ery6MdXc/MUbTFIDt8/yF3+Jj6OfrOxuqrA/pmM/utAK0F
         lDgC2CsfwBdyROAYgVXsLIFRoi/I1KdkC40wIhzyiYYJFYWngbTfXOa+11e9c36bMN
         5NR7ou5qC2FMxpdDvYt2eDDLaRudC0v6LtYilNgj1LViwU5TRt2cAAuIEk5Nvr+Mwd
         a+e70sHjedUl/yu26euI941KEDY8jA39pNDmQO2FXpgq/+1VX/lJC4t1n5e/NZWlIh
         ANZQGxbmid2+w==
Date:   Tue, 8 Oct 2019 10:58:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20191008105815.1011a0fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iXOu8kz7_GA2Yb3=GILuK/9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iXOu8kz7_GA2Yb3=GILuK/9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

sound/soc/jz4740/jz4740-i2s.c: In function 'jz4740_i2s_dev_probe':
sound/soc/jz4740/jz4740-i2s.c:500:29: warning: unused variable 'match' [-Wu=
nused-variable]
  500 |  const struct of_device_id *match;
      |                             ^~~~~

Introduced by commit

  67ad656bdd70 ("ASoC: jz4740: Use of_device_get_match_data()")

--=20
Cheers,
Stephen Rothwell

--Sig_/iXOu8kz7_GA2Yb3=GILuK/9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2b0RcACgkQAVBC80lX
0GwHIQf9G2MFoGzn+a8F0UJP5ZRtAin9G8CFDg/Pg9WTAd+VL717U5tCwIpfhse9
EuKjRt2iNTv2U2wSrZ8Ww8SzxjvqKHEuUsDk0f65kG8xzSKzcnzomWpQcvVeC+Qs
iHVgRVniGjQfEbcyesnoZrJoA2uHrhI8ifxvjwoSD4ueDMR8BIzPqtvUbl2Q30TW
7RLAAZZFjZNZCT9+qklHGqECtCYXRh2gY+v3UlOPh2Mp6HLE1F6bcgOWY8yIjYr9
muKb3cBPIwB9Dv/8OAe+faFNYs6L+ZC30pz67eTrj8d3dcwjoaCzGx/wBrmFdT09
bNH23+eugHYgtu0Zdzm8jp6xB8fWpQ==
=kCO8
-----END PGP SIGNATURE-----

--Sig_/iXOu8kz7_GA2Yb3=GILuK/9--
