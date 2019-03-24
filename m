Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBA4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75CAB2133F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="i6cW3FjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbfCXW2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:28:15 -0400
Received: from ozlabs.org ([203.11.71.1]:38949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbfCXW2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:28:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44SBqb29RVz9sRW;
        Mon, 25 Mar 2019 09:28:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553466492;
        bh=XEV9ZXY5HIJIqh3sOrGG+59tMudBznBXQp8RASSRVao=;
        h=Date:From:To:Cc:Subject:From;
        b=i6cW3FjBE5JLLX3ehSEOlJZORN8/McdyjLh4qyYeAJh/x3CG0ik48JUf+9MedcMYy
         jIXu98NTeo2WJkzvvG4qstcD+4x542CRR2woX2RhntRvDnrcJfx709FEMKkQBHV54n
         Xm0PHXFDasHUeqKRJaaLmBFyeMfpdHED933kMpo3WtPRGHk7ipEjfm/8yY87Wk12yR
         WGAw+RtA6Umu2lIDRqmbhB2micphWqKnBbT90+nls9AkM42Z9/62NXjPD+gTi3iEhs
         9Q1OLxAj7CqmT1e4ElFKfmb8XMIJjehsK+vbCVkZH48fQolFxhk/TToKLAhhGi5A0t
         EIzAia3f/npig==
Date:   Mon, 25 Mar 2019 09:28:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        David Miller <davem@davemloft.net>
Subject: linux-next: build warning after merge of the bpf-next tree
Message-ID: <20190325092804.650ebdb0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YNsqztMGNElbYCVRa5A4DFZ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YNsqztMGNElbYCVRa5A4DFZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (x86_64
allmodconfig) produced this warning:

net/core/filter.c: In function 'bpf_skb_adjust_room':
net/core/filter.c:3022:31: warning: 'inner_trans' may be used uninitialized=
 in this function [-Wmaybe-uninitialized]
   skb->inner_transport_header =3D inner_trans;
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
net/core/filter.c:2979:26: note: 'inner_trans' was declared here
  u16 mac_len, inner_net, inner_trans;
                          ^~~~~~~~~~~
net/core/filter.c:3021:29: warning: 'inner_net' may be used uninitialized i=
n this function [-Wmaybe-uninitialized]
   skb->inner_network_header =3D inner_net;
   ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
net/core/filter.c:2979:15: note: 'inner_net' was declared here
  u16 mac_len, inner_net, inner_trans;
               ^~~~~~~~~
net/core/filter.c:3026:3: warning: 'mac_len' may be used uninitialized in t=
his function [-Wmaybe-uninitialized]
   skb_set_network_header(skb, mac_len);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/core/filter.c:2979:6: note: 'mac_len' was declared here
  u16 mac_len, inner_net, inner_trans;
      ^~~~~~~

Introduced by commit

  868d523535c2 ("bpf: add bpf_skb_adjust_room encap flags")


This looks like a false positive, it seems that they are only set and
used when encap is true.

--=20
Cheers,
Stephen Rothwell

--Sig_/YNsqztMGNElbYCVRa5A4DFZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyYBHQACgkQAVBC80lX
0Gz5oQf/bqDuspc7rew3DSlB8gTjirNsI/I6Kr7rvSxha9KkS2dPYyc7PovVNLSL
plCz3k3qAIvfOuu/ZthW6/NHTSrgfyKSoYqMXpztU8O2v1886BFsnW3eGhxbWrAi
1fu4cFsTQ6VeYzVwSoKExwAKIR1/MYG6VAZzMGj91lsAmlaZtvkw4kzzKRRY6WKl
WVKYwau53lLuQTs4HFGWZ8GiCdYLhbrp4RN5GjjyflAOZJPe6RHf9Z7fXOvvufAD
+s8LlSnpxYaYIOj1uffM1ev+Vr1fzKjKUuwk7tvNYm+QW6FeqmGMRoxa+ntaHc04
+pXcOofMZUn+discynRTAN/Xkf2V9Q==
=0Joz
-----END PGP SIGNATURE-----

--Sig_/YNsqztMGNElbYCVRa5A4DFZ--
