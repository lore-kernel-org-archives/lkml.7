Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394F0C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108E620B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 01:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="UimalsXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbfHABxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 21:53:50 -0400
Received: from ozlabs.org ([203.11.71.1]:52801 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfHABxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 21:53:49 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45zYHH1fgrz9sMr;
        Thu,  1 Aug 2019 11:53:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564624427;
        bh=qA+DdzH9hW92l3545Ern1lVxlp+wJWRpfNpGdbQZ2eY=;
        h=Date:From:To:Cc:Subject:From;
        b=UimalsXL+VsMURodnJMJmpF0A+5HxB5itnRkuKUp+idnYuswYDN7iIYZyIXfgsvJ2
         pbgKUKi15h92Hb6/THcmadIqpG6ZNCP2PsMRL2qM2xKfZ95lbyK9vEPWPWIaC7NrrG
         jTrkTA6rl2Fpah5wNDwGlWS/7rwC0fW1ukmwAAciQQgBRo7yvvfZI/fZW/5Vtcz5jf
         fQVaALjK7F8ildpgOp6GlDrFA0Q9JMxfOgrZxdmKbOBpEL4Mie1yy16daiqdiHg+wa
         VgEcz3uKG0sieduxU4ABt06ZHR2lQ+KM7luttcV/Rb4EWOE5a70AgSvWt4IORfEIBW
         VTKiMTCeHLMfA==
Date:   Thu, 1 Aug 2019 11:53:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: linux-next: build warnings after merge of the crypto tree
Message-ID: <20190801115346.77439e35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xos6cSQgdCPocAQXX1g8kft";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xos6cSQgdCPocAQXX1g8kft
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

scripts/Makefile.asm-generic:25: redundant generic-y found in arch/arm/incl=
ude/asm/Kbuild: simd.h

Introduced by commit

  82cb54856874 ("asm-generic: make simd.h a mandatory include/asm header")

Also the powerpc ppc64_defconfig build produced this warning:

scripts/Makefile.asm-generic:25: redundant generic-y found in arch/powerpc/=
include/asm/Kbuild: simd.h

--=20
Cheers,
Stephen Rothwell

--Sig_/xos6cSQgdCPocAQXX1g8kft
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1CRioACgkQAVBC80lX
0Gy80Qf/Z5wG6jTUzCB5bSU7bNOflLTWZir7lzHdMQTSAxlHSxisazhg4kSgt9ov
Prj0giZRnYNzD8SDDOg3/lygPUhE/igXzCS42eD1hlByMRDncpNoLIEFO2JMUdB9
5nouLllS2i4Q11X0Xnc40LTEZ4LDpy7nwAnYRtfGczA2rOyjeXLT/RvRzk0bD0we
Vz/PmJg8fRhq5edIlUzfWVIvRWR6d+khD+iI4xv2NOk63j00auueBJQg+gQupxlZ
rtEDIwCGCkPUvBJDGOLcRwzUC2WUT0GGW/aRquYlGNG3rJ/xCSNhuaEypIPG8WtZ
EQPwnwRF52Pug4imDNnBzfFe9j+UKg==
=WXZJ
-----END PGP SIGNATURE-----

--Sig_/xos6cSQgdCPocAQXX1g8kft--
