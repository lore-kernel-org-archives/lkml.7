Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD61C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116242085A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 23:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cl1Nz4Nt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfCQXaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 19:30:30 -0400
Received: from ozlabs.org ([203.11.71.1]:42165 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfCQXaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 19:30:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44MwXg42qwz9ryj;
        Mon, 18 Mar 2019 10:30:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1552865427;
        bh=X0l26mIHr48zUWeYTy68Wr00wHaPBnBiYsqnSSjiLJc=;
        h=Date:From:To:Cc:Subject:From;
        b=cl1Nz4NtSLV4D7PvlQ8dKjkpNSpNgHOFuM3H0eZVhik1cIjDApgiH3AohrhqXSpYb
         8AHrC6pw3B2h04Lu/kXEDj58lHkZlsX9nTuw20s0qnMKjhqDeL1qYN7vBwHF44wy7g
         2bu1TXQLrIw8ClB+QfNzRuXUSc+RIW8t3X6UQVHL9FA707FExmchYGAJpqQplu1zmo
         0qjHCVw9jFMHjWOBtwtgS934vzR7lk89z2I63BA2NJndzpnH6h41w7KLu2uM228JB8
         DHkheQUz3v7kvbEa3PaILVByHnPvc9tBnWW7NcWQsLc3i+0D/guO5+GH28mU5R13zl
         y4ngDWa067dkQ==
Date:   Mon, 18 Mar 2019 10:30:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: linux-next: build warning after merge of the bluetooth tree
Message-ID: <20190318103025.12221d14@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VoK8rJ/=9pFlPirTxDeQ.3P"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VoK8rJ/=9pFlPirTxDeQ.3P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bluetooth tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

drivers/bluetooth/btmtksdio.c: In function 'btmtksdio_interrupt':
drivers/bluetooth/btmtksdio.c:470:2: warning: 'old_len' may be used uniniti=
alized in this function [-Wmaybe-uninitialized]
  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          old_data, old_len, true);
          ~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bluetooth/btmtksdio.c:376:15: note: 'old_len' was declared here
  unsigned int old_len;
               ^~~~~~~
drivers/bluetooth/btmtksdio.c:470:2: warning: 'old_data' may be used uninit=
ialized in this function [-Wmaybe-uninitialized]
  print_hex_dump(KERN_ERR, "err sdio rx: ", DUMP_PREFIX_NONE, 4, 1,
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          old_data, old_len, true);
          ~~~~~~~~~~~~~~~~~~~~~~~~
drivers/bluetooth/btmtksdio.c:375:17: note: 'old_data' was declared here
  unsigned char *old_data;
                 ^~~~~~~~

Introduced by commit

  d74eef2834b5 ("Bluetooth: mediatek: add support for MediaTek MT7663S and =
MT7668S SDIO")

--=20
Cheers,
Stephen Rothwell

--Sig_/VoK8rJ/=9pFlPirTxDeQ.3P
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyO2JEACgkQAVBC80lX
0GxFNAf/ReP9mM3KG+CGIOkr/Rj72tuecW+ZaikVqYk7wgTUPvSwlJlUXgbMFBmP
QBB8RTELrKq0+pX6deHOyFstiHY9N8Qt/u7siY2/WigNbBL9n1/nbxQoYxiKyXcp
gpY/lZJ6X9sULmCTOUEJD87v1HrrqKCL8solsX+VCNgbHQ5IB6gqTMEuTuxfK2Lj
tkop/xExYhuRbloXVmKA2PxVLgAuxPFvgfJ5iO33G3u+eWMpue8SAb0n4Roy9JRB
wffylM5ltAulhvpTz23GGNyn7RBNjN40TjkZ5ZaRzYmE50JERUpTQ86Iduji39+S
gKl8ttjFTO9vYg2pMozt5EQMD16fJg==
=Q1J2
-----END PGP SIGNATURE-----

--Sig_/VoK8rJ/=9pFlPirTxDeQ.3P--
