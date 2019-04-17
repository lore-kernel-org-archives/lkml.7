Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF48CC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36122177B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 01:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cxC6JhMB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbfDQBJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 21:09:07 -0400
Received: from ozlabs.org ([203.11.71.1]:54083 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbfDQBJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 21:09:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44kPJc2Jrrz9s55;
        Wed, 17 Apr 2019 11:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555463344;
        bh=gx/m3xcElozFNplOIZLgXvME1X2j76PV32tUNT6mwjs=;
        h=Date:From:To:Cc:Subject:From;
        b=cxC6JhMBLZunL8dOEiIQwZBSS8ImYiAP+pCZqJQll/KBYSoOo4GK7yqFwocieYCaP
         BvDIDD29AuMxLGVvHnTRdnUn38r+YobK08aUAIsiCh1x3QdbxbIOpP59y3YnMU3pTW
         qwTdWJw820cav5G7eod9pXHukgXLlCcmyt2k/+eG66ca/ehx3muzZVC870fOIzVgr9
         cJnAJyh9FAQGv48SmAdmbUPRssnjA14OY+rutg3dmAAhMO9zJie4suRCt+Hil1W6P+
         MCPFAmdS7+JiBl3jFdCPxGj4kEnsvuIGVKs/2WTuEcu0uz+dNbytMan7VHbUVYED2C
         8Ca64YAWXRSbw==
Date:   Wed, 17 Apr 2019 11:08:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benjamin Poirier <bpoirier@suse.com>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20190417110856.54b4ac1c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/PToTIyXnHLFQ77QlRBaumDo"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PToTIyXnHLFQ77QlRBaumDo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/bpf/bpftool/map.c

between commit:

  e0665239e07f ("bpftool: Fix errno variable usage")

from the bpf tree and commit:

  0478c3bf8124 ("bpftool: Use print_entry_error() in case of ENOENT when du=
mping")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/bpf/bpftool/map.c
index 1744bf61a0b8,44b192e87708..000000000000
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@@ -722,11 -715,16 +715,16 @@@ static int dump_map_elem(int fd, void *
  		jsonw_string_field(json_wtr, "error", strerror(lookup_errno));
  		jsonw_end_object(json_wtr);
  	} else {
+ 		const char *msg =3D NULL;
+=20
 -		if (errno =3D=3D ENOENT)
 +		if (lookup_errno =3D=3D ENOENT)
- 			print_entry_plain(map_info, key, NULL);
- 		else
- 			print_entry_error(map_info, key,
- 					  strerror(lookup_errno));
+ 			msg =3D "<no entry>";
+ 		else if (lookup_errno =3D=3D ENOSPC &&
+ 			 map_info->type =3D=3D BPF_MAP_TYPE_REUSEPORT_SOCKARRAY)
+ 			msg =3D "<cannot read>";
+=20
+ 		print_entry_error(map_info, key,
+ 				  msg ? : strerror(lookup_errno));
  	}
 =20
  	return 0;

--Sig_/PToTIyXnHLFQ77QlRBaumDo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly2fKgACgkQAVBC80lX
0Gw8OQf/VvGCw2rn2B10cwgm/rjs+IduAfPs8kwMGJ+1YheHdRd6PggMRa2kqDPI
2NW4J1kENtmWz5Jx48JzKrKbbwmpK5Af19oWbg7nTApBwTIeePd/uHeqorJYt/7P
gSleXDPgq3TnyDhQhlzWLyTcRAaL7QadSdQWUjW1/zi/BI+HnzqzeXFDBX2F+yhn
cWB6V0irEqDw11sLG8CmZi6FMJ9G/5HyP/T+LAv3lKR3thF6B1m8KBdPKuLfylSI
kZ6cq6hcaINXHpO4ZMJ6rRWoE39kjOpv/nfuWTJUBY//xWkSsUxQuNmzt7DDV/Z5
oTdt+XPhJeSnZeiDHKoRGq0WyAhNxw==
=/wDW
-----END PGP SIGNATURE-----

--Sig_/PToTIyXnHLFQ77QlRBaumDo--
