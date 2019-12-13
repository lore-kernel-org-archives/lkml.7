Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A653C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D505D21655
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 01:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="eIp0qYbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731565AbfLMBtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 20:49:08 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:54933 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727084AbfLMBtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 20:49:08 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Ytr13FGyz9sPT;
        Fri, 13 Dec 2019 12:49:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576201745;
        bh=Vq9r75kTrcGQj0IfaZDoNCuocae9mJfyEKqKph3OmCM=;
        h=Date:From:To:Cc:Subject:From;
        b=eIp0qYbQU7O8oscmSzM2cqy0xFBNCuzvFG29508QeEtKm5M+qZiXX9raP6CEwjbLq
         Cdb6zhAof63h9a60IlORsQz/jlIdJrlkvtfOL+pGAIcAlJPX1o68Ii9grbCehJDVco
         FVWe2fi9G5JEU5OYfyX+/aFL0P5wuWi8fJ8EaUJDY8HHGTm7iGoU0CjhJyU6tEMHAv
         paXrx/KMScVoNl6WnsNKS/muh/vA9a7VwvsBG3FJSbUudKJdOEUZsofMybgcokqrDt
         /SPwHAB5yDJkFSI4HIquXrfaNm6FBnckfYJUTmuu7Xtz0iBz9BF05Gl8ZeK7y3972w
         huitWPCfSWo8A==
Date:   Fri, 13 Dec 2019 12:49:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the devfreq tree
Message-ID: <20191213124904.467443c1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d2nyw.a._8NN8zVPn4uY9_E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d2nyw.a._8NN8zVPn4uY9_E
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the devfreq tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: "__arm_smccc_smc" [drivers/devfreq/rk3399_dmc.ko] undefined!

Caused by commit

  6c877bff8315 ("PM / devfreq: rk3399_dmc: Add COMPILE_TEST dependency")

I reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/d2nyw.a._8NN8zVPn4uY9_E
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3y7hAACgkQAVBC80lX
0Gy9EAf+P+3ZT3IT/ku+xBAGRaooPdsXiCcJpe14/brCf9ipJEwud8B7SJBEbf+f
7V5EBfjLt+wzo+Dht52W2t/7lBEgvOcIRyDyFhzIxNBYXRTWtY3yHMl89hIclE3F
r7bkA1mIsTYj6lmZ7+QgacP77k/w04373dbtO0tIJ1FvJcsCUWxeLQc/5x0OO2On
nyBxYYQ34Hzt2QosmasEHgh/nQa/K1JW90Q4FE7aOqz2K/hAywsY4E1TIQRPMovG
XY/ncO0rFxS8ZSwKxivW8r23etLNEFWccj9NdkU2yAz6fhBG4gaG+l83JdDOqmGt
S2UinyBBrNtCFKoI51JWp7OEhH/ubQ==
=FJw0
-----END PGP SIGNATURE-----

--Sig_/d2nyw.a._8NN8zVPn4uY9_E--
