Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9108AC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6092190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="TGj+UyFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389002AbfGYJhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:37:19 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43655 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbfGYJhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:37:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45vRvH2DVYz9s8m;
        Thu, 25 Jul 2019 19:37:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564047435;
        bh=7RiHInY7DFEoGXyuXyrZaDPTm271sEh+0+BO/eN/XyY=;
        h=Date:From:To:Cc:Subject:From;
        b=TGj+UyFXQ3lkHKGajD69PjX7WCQCPKkIk/yGkk7uZud5Hrr76VGjffAGiQ0h0NPl0
         8MdBtGc/fVBaYwCO1E6bmliRXkAf0xEDOYLGYos6+x9oDpE69tupZJ6pFYKegaJinc
         Tg5cjhweylGo40M8YfguNvxcOuzvepF7Stx7mAHpzjAwxuAOO18IBRu4J7jPE6aj0j
         xY4RVPhWVdKpX4aUEbAYphRSAapeeeAtw5yDqEtVQRhhE7DiYw8FiJKkwGVVsrj0wu
         KHgHI6+0HTXFa7DqrY+UubwTY3CAQqtvGJHeKyDwwMHXiqPXpLQHhuwG7l4cUmOaVB
         D38GnGGETjH3A==
Date:   Thu, 25 Jul 2019 19:37:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20190725193647.388c149b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N52ruag=7bLPa+bY2JH2LKG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N52ruag=7bLPa+bY2JH2LKG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (mips
cavium_octeon_defconfig) failed like this:

drivers/staging/octeon/ethernet-tx.c:287:23: error: implicit declaration of=
 function 'skb_drag_size'; did you mean 'skb_frag_size'? [-Werror=3Dimplici=
t-function-declaration]

Caused by commit

  92493a2f8a8d ("Build fixes for skb_frag_size conversion")

--=20
Cheers,
Stephen Rothwell

--Sig_/N52ruag=7bLPa+bY2JH2LKG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl05eEEACgkQAVBC80lX
0GxEuQf8D8J95ArpVOssGYWkAXI4kje9KKTdgcPQbOQo95octSRGnr6TE0vd+zcZ
FpevIgM6HBv/LjsIg6YBV/awwpx8XxbwbSTwWcQ+a7uhSUH3fyaS6+iON9OK+kHG
SP+TpRO1IRe/DQyXE5qO8ct23WUARyVfhuu3vD6HXiZdY7Bdm789hMrUnW3PUcVI
WTVK1wsED1yNnucH7Vuym8fyFecuvdx1KyBtRwWo6N1Oit4NpJ+vukfWif+WV8iS
5A6rRAU4jDQaMdN3WZPtP5GlPMBokMzdRvDQ1Aiovpf/+B6pXZaGcDRJ6qfEbNQe
qUXVUw26dhhjhuqvplbDYZqhqqqKsQ==
=vyep
-----END PGP SIGNATURE-----

--Sig_/N52ruag=7bLPa+bY2JH2LKG--
