Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22B3CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9FE20700
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 23:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="hMeV34WE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389794AbfJVXpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 19:45:40 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732733AbfJVXpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 19:45:40 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46yVW552w4z9sP3;
        Wed, 23 Oct 2019 10:45:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571787937;
        bh=pjSGfJ9xwL4vPmNyWBEzwR2IEKqpPveOC2PiffyubUo=;
        h=Date:From:To:Cc:Subject:From;
        b=hMeV34WEAtzXLxWBRZ0WHq/bW6RpQwQ0cu7LgeVWnMuq+kOUAffKdg1T1YiFzA4Fb
         TnjJHEIuL/3CLNAXEC8blrmQpZuNt4z/Sxmkbyxep8CHeZ/mpNKPzoftEnOFvt8ydu
         DZSZIjpH8IpUP0PHlCD//GOPGMvgxZKOH25SAcopyw745QfpNmVXpr5ApSo1KKk7p3
         215/C4dnHm8EfVbdbdpbHRRDJO8fQdRxx+YdtBBP/uBdq4MU01S+KP7RSt3EqG8lca
         /jRN3rMafwtvopANjoJa1pwEEvXOrnP1pxragA/ECFZzLa94GFaKe683CMwczNSod/
         ifhG3kwqa2eEw==
Date:   Wed, 23 Oct 2019 10:45:28 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Zhang <benzh@chromium.org>
Subject: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20191023104528.3007f943@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4PX7+0+Xvj=RqulK6jGl_.w";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4PX7+0+Xvj=RqulK6jGl_.w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound-asoc tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

sound/soc/codecs/rt5677-spi.c: In function 'rt5677_spi_pcm_close':
sound/soc/codecs/rt5677-spi.c:114:30: warning: unused variable 'rtd' [-Wunu=
sed-variable]
  114 |  struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
      |                              ^~~

Introduced by commit

  a0e0d135427c ("ASoC: rt5677: Add a PCM device for streaming hotword via S=
PI")

--=20
Cheers,
Stephen Rothwell

--Sig_/4PX7+0+Xvj=RqulK6jGl_.w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2vlJgACgkQAVBC80lX
0Gy0Ewf8DZgHKeG4RTSaAnQqxEl5WpY/CX+6gYrUtKymTGDY/R8EZevrQSQkiF5a
DAdnM0mMkERAKpetDbcUP1EV0+2nP0B9VQGxxlw5cNnG1Rm5qtceeSDgGn2Nglmx
otf8fhj3CTrNKyzORi3seXA80mfHdOIKC7CM5E8x2Qmz57WmzYc/yr1rLaBBmCvP
aXb9JjSMm9afQ0h6lR+EBQygYCS8zqK8A+LGksBytat4n5sMVwnRPgN0e2zEfwSA
FQuTOaFec6oCieEDl1Qs04mX2LLxXHneVorSlRa+ADvBf019BrTjoUbsNYKoS9zd
tU0K9fTMGkdz3znhVikFeZJ/6I9ilA==
=lmCk
-----END PGP SIGNATURE-----

--Sig_/4PX7+0+Xvj=RqulK6jGl_.w--
