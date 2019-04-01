Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA5EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA0F20856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 22:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BhrjqVuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfDAWaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 18:30:25 -0400
Received: from ozlabs.org ([203.11.71.1]:40495 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbfDAWaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 18:30:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Y6VP4byVz9sSj;
        Tue,  2 Apr 2019 09:30:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554157822;
        bh=rch9U+c93EoX479sjw2qOfCcDRFzdfpQgecgiFeKr2s=;
        h=Date:From:To:Cc:Subject:From;
        b=BhrjqVuHjPeAZ1uQLKA5Zb5uezzKgj5wZkTJPvBvdhWlyCR7iBZL2lNpNnppPis/g
         YHW+/9uy3Y1ZBrcJ9UhzE6uP4Z6Imh/OSgnIW0H6Ub07GOFdxAAoJyindkLn6ULdPG
         heAibPkwIzv+681lZvugPlagncT6iGq0LxgNRdU3w8t9oLNwGUaGND4sH+Ore6vwHF
         pQ39hQfKF9J5mh5xQ9kzUSXUFJ5+N4osUCa9wAr7NhIFn0cAiTQgYvjddF+4Ghx4Et
         J7qQYjODV6LoABmwwHlEJeSHA+RQiF0jJ2V4wmPO/44PWdIqVBAEpQutFEVnDmZd2n
         Kp9fkRJ8FBvOA==
Date:   Tue, 2 Apr 2019 09:30:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yifeng Li <tomli@tomli.me>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the fbdev tree
Message-ID: <20190402093007.0b03b02e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P/3Nxd.XblUEf2RjQpecfHe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P/3Nxd.XblUEf2RjQpecfHe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Bartlomiej,

After merging the fbdev tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/video/fbdev/sm712fb.c: In function 'smtc_blank':
drivers/video/fbdev/sm712fb.c:900:4: warning: this statement may fall throu=
gh [-Wimplicit-fallthrough=3D]
    smtc_seqw(0x6b, 0x02);
    ^~~~~~~~~~~~~~~~~~~~~
drivers/video/fbdev/sm712fb.c:901:3: note: here
   case 0x720:
   ^~~~

Introduced by commit

  f627caf55b8e ("fbdev: sm712fb: fix crashes and garbled display during DPM=
S modesetting")

I get this warning because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/P/3Nxd.XblUEf2RjQpecfHe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyikO8ACgkQAVBC80lX
0GzPiwf/RsxhnQrKYYUV4DYpBXGK70zlPEcW1Bdz8Wmom/nfLea2LnqUgbmPa3Yl
dXWMtEB7pN+ApkeNqDJYGRUQmgYg2TyKE03JuIaGGZiOMauIGsjxY77pcd9C8AHo
bN6KIKjYItL+K7uzjaq8nCSS9rfU+HXvp0/olGxjRt1fqZKxixWOVfWAL+V+xJRE
zO1p6x9+Us/17Ye8SYRp/RISWWpYeXOIW5C7ouhACj2pYYw2blgcxgkk8Ss/ga7f
qmlfRYb5ERNKdKGvzN9BWP2EipZH69rT2mV7v0NHdELj/lTLYsjaFkJPUb2KDVU2
yNLW5UsQ7I2qyRd/ESK702j+liouMQ==
=E5eg
-----END PGP SIGNATURE-----

--Sig_/P/3Nxd.XblUEf2RjQpecfHe--
