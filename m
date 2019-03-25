Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C60C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373A12084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ukL8f7P6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfCYXBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:01:51 -0400
Received: from ozlabs.org ([203.11.71.1]:44877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfCYXBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:01:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44SqWt4g8hz9sS1;
        Tue, 26 Mar 2019 10:01:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553554907;
        bh=k9s4Yo7CHNVY89a8LFnGMcGLpLc6rdQVwMKHPogdcnU=;
        h=Date:From:To:Cc:Subject:From;
        b=ukL8f7P6lRVvPB8uJCec1oa7MjoNoYn84wp7nIWRKntncYiAeNEnXqqU9nVJ9gnWC
         lWxtOX2DyutJg7aho8D0mjcC2SZ8rIam7YGPTxFEXeq8i9jECK3OB9gRqbzPG5ZNEW
         VewoqpPeNMf/AuGvD1tTZhUtZboyijWtDq4iDsbCRjfZPiwAEUEZ/jAySLaDF0BYTR
         qpKWPzO2SQbaWXN+/dN/IQOa9LGH8EKTKp7K3eLCm3Jk8P7OAQhZbJ1IZC0ukau6Vq
         dRPcZ8WKv7SemNS9xSethyIZfERXHn2NMB0IhnBtuexUwQHNiHMJgIv/KvvcfiZ//y
         dv+cwGV4oK5MA==
Date:   Tue, 26 Mar 2019 10:01:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20190326100145.3ee50933@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ii3hkwhZ5D44rD1XYfWX67q"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ii3hkwhZ5D44rD1XYfWX67q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

sound/soc/codecs/tlv320aic32x4-clk.c: In function 'clk_aic32x4_pll_recalc_r=
ate':
sound/soc/codecs/tlv320aic32x4-clk.c:149:38: warning: 'settings.d' may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
     ((settings->j * 10000) + settings->d);
                              ~~~~~~~~^~~
sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.d' was declare=
d here
  struct clk_aic32x4_pll_muldiv settings;
                                ^~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:149:15: warning: 'settings.j' may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
     ((settings->j * 10000) + settings->d);
       ~~~~~~~~^~~
sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.j' was declare=
d here
  struct clk_aic32x4_pll_muldiv settings;
                                ^~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:148:37: warning: 'settings.r' may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
  rate =3D (u64) parent_rate * settings->r *
                             ~~~~~~~~^~~
sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.r' was declare=
d here
  struct clk_aic32x4_pll_muldiv settings;
                                ^~~~~~~~
sound/soc/codecs/tlv320aic32x4-clk.c:151:56: warning: 'settings.p' may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
  return (unsigned long) DIV_ROUND_UP_ULL(rate, settings->p * 10000);
                                                        ^~
sound/soc/codecs/tlv320aic32x4-clk.c:197:32: note: 'settings.p' was declare=
d here
  struct clk_aic32x4_pll_muldiv settings;
                                ^~~~~~~~

Introduced by commit

  514b044cba66 ("ASoC: tlv320aic32x4: Model PLL in CCF")

--=20
Cheers,
Stephen Rothwell

--Sig_/Ii3hkwhZ5D44rD1XYfWX67q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyZXdkACgkQAVBC80lX
0Gw68ggAmJf+6gDljC6i4xZOK5rdcZ/ACrJTCXojm8RWeGzQgqFoO/97rdg+ar1q
7/NnCTxXh+XN8T/0Eb8WN1ZN9eeloFhG2EQWDga6uhaxjdENPpPsrq1hup3mUIv1
q+8rK3b5JP7Rs4/u7t/V4Xdt4/giJVI9bfs8Wsv8tPW2FcYqRsEEME03Kzcex32/
M/h12HBBumtazMLR4YQU3j5WgOz5NEd/uWJZjJo5tB32Oii2VutdjxVx2swYk70o
lncG/M3iPilmDZPnu1Urj00P4yNy73hvQDWjjHQUxjJFiCSBL7n5vD/xFPpb+g6g
V6W07Wk9pwEprzWA6dWR8GqhF1hBsA==
=H3fs
-----END PGP SIGNATURE-----

--Sig_/Ii3hkwhZ5D44rD1XYfWX67q--
