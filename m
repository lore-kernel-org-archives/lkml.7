Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAD0C74A3F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 01:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A00214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 01:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qSzfKBCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfGKBcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 21:32:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfGKBcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 21:32:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45kdnw1qSVz9sNH;
        Thu, 11 Jul 2019 11:32:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562808724;
        bh=oXURTSiso/pbVdpPreT7AFrzmlXmw+vBMmU79HOlTME=;
        h=Date:From:To:Cc:Subject:From;
        b=qSzfKBCTGwmP991UTGYRzZTQYDWLmTcPIgR3+9wMEwweCw98cc8PUp7mSxqxK9Y1M
         5hNhb9SXsvDRtE0Z3r0yVg54szWyA7DaNZpGzlhjSxsKuU4mj1fHSOdz6LGAy46pZD
         v54vj8OGH69vfNH0Z59Bxgf3jtX5pKXyMAvPVjjFTSulHmMQcRy2KzYhZKe3irHxA+
         JrlPlMcBNw5fzUz+hAyajkDEYNzKecQNpT7k/ewf2tS/NASYoaF/rdVIPvT7E+eZJS
         I3OHb02hplukt/kF1AgINz/Dkqql6edX1Q29Tb/FYaDdZpvyuwr3JHua5rhCOTuHN6
         Sxxrdl9ecst7Q==
Date:   Thu, 11 Jul 2019 11:31:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: linux-next: build warning after merge of the pm tree
Message-ID: <20190711113138.22d6f93e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/3vRJGYp3R3UPDj_5cp+7Fv8"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3vRJGYp3R3UPDj_5cp+7Fv8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

drivers/cpufreq/pasemi-cpufreq.c: In function 'pas_cpufreq_cpu_init':
drivers/cpufreq/pasemi-cpufreq.c:199:1: warning: label 'out_unmap_sdcpwr' d=
efined but not used [-Wunused-label]
 out_unmap_sdcpwr:
 ^~~~~~~~~~~~~~~~

Introduced by commit

  f43e075f7252 ("cpufreq/pasemi: fix an use-after-free in pas_cpufreq_cpu_i=
nit()")

--=20
Cheers,
Stephen Rothwell

--Sig_/3vRJGYp3R3UPDj_5cp+7Fv8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0mkXoACgkQAVBC80lX
0GzTgQgAhXBqd+IIy62deac3C7XwkUnWtyLPBbWLFUvlAW8qU/1DbVMDDbzDND6s
hLWcFA9BQ/5gHNQAOlbIX/RU3bmtsPYl9Z5Y7rk7LkJV6Bk85JHje2DLxeMy9mo+
CGKKtHOjRgGyU3piVIbCNeXfgNR30cKBlQ1Yb5afJ/++JWC1zc1usnu9QbRMfCK/
q9dnmOU1HF1B/LIuziRyva/RAZhJ5XiaQh/wYIAeSS8jRIhIHkBrgDiTCzt6U+Ww
I8BeI4BRG3uMv/7nVarUoNYZhPhrPYc3pqFZFrUfCpxsyq7liKZgJe/FhSgBCVLT
B2/PLhKOJtAaIXSvFuDHsfsxKvObRQ==
=z8J0
-----END PGP SIGNATURE-----

--Sig_/3vRJGYp3R3UPDj_5cp+7Fv8--
