Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E07C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42252146E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 04:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h+veNXvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfDCEW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 00:22:56 -0400
Received: from ozlabs.org ([203.11.71.1]:45465 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfDCEW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 00:22:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44YtGh1DBSz9sRs;
        Wed,  3 Apr 2019 15:22:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554265373;
        bh=srT79qgkT+73/cUjoOe2PJNbWSyGuLzHXwpY197h6zw=;
        h=Date:From:To:Cc:Subject:From;
        b=h+veNXvhbtB4SFV7Utwxql+zyxskFebXnsiMiII+iZt0xkoMV1++JEad5m27vbTlI
         6dBO0oF8ARmsuLriH41GmwNZMFyFKbc0Bm2oj7CDUSGl1ajnY4WpRSBk+0AddswAZC
         NJ34oGePkCtyPnYZLelZZLo+2avq21tW6/kRd5tcYEFhskgToug97t96pn+rRpGeSD
         sGYKiM9DwtoC88abTqL7TZ0q9oFZd76LeyvWOemHcok6fWP8fxEdGUMnsrR/Uh/UGD
         RpUrbTG8tsX53cQQVnYpY/YkiVqTFfgATjuF3lDnIlRzt4oerpHVQn4f1eg618y7wT
         3pPjlA5cLOqpg==
Date:   Wed, 3 Apr 2019 15:22:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: linux-next: manual merge of the vhost tree with the net-next tree
Message-ID: <20190403152237.631a0b3c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/s62lV97IyNeb3ffEJ54elnK"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s62lV97IyNeb3ffEJ54elnK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vhost tree got a conflict in:

  drivers/net/virtio_net.c

between commit:

  6b16f9ee89b8 ("net: move skb->xmit_more hint to softnet data")

from the net-next tree and commit:

  916faccfe56d ("virtio-net: bql support")

from the vhost tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/virtio_net.c
index ba246fc475ae,955b3e76eb8d..000000000000
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@@ -1568,13 -1571,15 +1572,15 @@@ static netdev_tx_t start_xmit(struct sk
  	struct send_queue *sq =3D &vi->sq[qnum];
  	int err;
  	struct netdev_queue *txq =3D netdev_get_tx_queue(dev, qnum);
- 	bool kick =3D !netdev_xmit_more();
 -	bool more =3D skb->xmit_more;
++	bool more =3D netdev_xmit_more();
  	bool use_napi =3D sq->napi.weight;
+ 	unsigned int bytes =3D skb->len;
+ 	bool kick;
 =20
  	/* Free up any pending old buffers before queueing new ones. */
- 	free_old_xmit_skbs(sq, false);
+ 	free_old_xmit_skbs(sq, txq, false);
 =20
- 	if (use_napi && kick)
+ 	if (use_napi && !more)
  		virtqueue_enable_cb_delayed(sq->vq);
 =20
  	/* timestamp packet in software */

--Sig_/s62lV97IyNeb3ffEJ54elnK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlykNQ0ACgkQAVBC80lX
0GzsTQf+Pxa9z5oMKmnyw2PcfDshstSYPMe2ncWXjTfjBSFDsmUJr3w31CCmTLpm
crAnvBdX5PFTqcfQlsGoBcDG6iG9yFGxsB9jA+bSPHOQsUTPkBlG0JSz8pJO5ABj
JFv24q2sLeaQF8xcD0ercsOupZxExfov4PdlAHmoLwNRbaR1oB02S4rhCmg+oRH5
QyEjVF5cbHGGyfQEzV81pWDXrXtXlooHoDzRRgkKIjSVf2NeStwnk1fSK62j1Vtq
RSHZ/aaNujmDBH45igXJgF50PAADMkPT5wvtqGDTaqkehYqqcn6ZZbYupySiCII5
l4dWQGY6M4NYMWXkP1WCJTu/pMPOFg==
=/gvM
-----END PGP SIGNATURE-----

--Sig_/s62lV97IyNeb3ffEJ54elnK--
