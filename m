Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47C7C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1912084B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 01:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Lp/RS2/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfDPBVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 21:21:01 -0400
Received: from ozlabs.org ([203.11.71.1]:34761 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726527AbfDPBVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 21:21:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44jncp2N3zz9s55;
        Tue, 16 Apr 2019 11:20:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555377658;
        bh=7HPL+1RkcbE0wXS3jZz5G7+bNSRwuE7lJf1r1m3n+Q8=;
        h=Date:From:To:Cc:Subject:From;
        b=Lp/RS2/l1EA1JSGad8B11k8yrVCUYFfBigkuQOlUWYksUl51Uy3tyvcIwnEMcC92i
         JopYp/ZEhfmp3RAR/lsYlzxFOXbgMox6CLohihIfraKnmaNW/D5d4nNtciIPyfBEx1
         PVT3gFdgBT7mH0S7J7Ts1eJlOk5k1y5fj04dxA83plqKdk5eDO4pkDe0vcRoJEk1nO
         3i8sagqh1pA9xntOGkFuB9qJWRR2YMHJDZpHGnPaKCCjfIjOGWWJ7mT+0LxCKxy1tL
         vpB4gOvIFrVeBVf8Soi/R+hIVuhn764wUYCBx4ESN5yXbNPMUErbppQRv2MR89ip0+
         gBvOJoP48YVGw==
Date:   Tue, 16 Apr 2019 11:20:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hurley <john.hurley@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: linux-next: build warning after merge of the net-next tree
Message-ID: <20190416112039.25136d0b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/FoZbPfiQ76bYU/4vrxheonn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FoZbPfiQ76bYU/4vrxheonn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/net/ethernet/netronome/nfp/flower/offload.c: In function 'nfp_flowe=
r_copy_pre_actions':
drivers/net/ethernet/netronome/nfp/flower/offload.c:630:7: warning: this st=
atement may fall through [-Wimplicit-fallthrough=3D]
    if (tunnel_act)
       ^
drivers/net/ethernet/netronome/nfp/flower/offload.c:632:3: note: here
   case NFP_FL_ACTION_OPCODE_PRE_LAG:
   ^~~~

Introduced by commit

  1c6952ca587d ("nfp: flower: generate merge flow rule")

I get this warning because I am building with -Wimplicit-fallthrough
in attempt to catch new additions early.  The gcc warning can be turned
off by adding a /* fall through */ comment at the point the fall through
happens (assuming that the fall through is intentional).

--=20
Cheers,
Stephen Rothwell

--Sig_/FoZbPfiQ76bYU/4vrxheonn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly1LecACgkQAVBC80lX
0GxDIwf/f3YHQgHHG2x1dVdkjePDOfjgvdNOQ1rLO8O1IFJVd/38q3koz1PKnfY0
cnSntxosbQUTB0POoryov+ZM+bNvJLtf5+Ui+/pj7QmLj//cajh1kR8SAFQl4TjI
TRKqBw9kiijeyEt60RAAOKnZjqgsGbINaAGpsTWEh82sSwgYiyKBIfu58eoScU8U
tbT756MbYE+qJ7S/YrQVdvpfaBwenpMU5db2xREI8E9hu2c6pdmXL93LtuAZbBa2
XYNpzluNffNBOrqFzVD+zjQ/YLy+tI/7GPoPO7HIz1Zs++SekZPERN9fI9emsMDk
csvCYvXZvVfamz220YnFLDrfJzfuzw==
=pCfi
-----END PGP SIGNATURE-----

--Sig_/FoZbPfiQ76bYU/4vrxheonn--
