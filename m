Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A817C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E272086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:11:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QyK7ZsmB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbfCaWLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:11:31 -0400
Received: from ozlabs.org ([203.11.71.1]:47837 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731172AbfCaWLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:11:30 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44XV7260WKz9sR0;
        Mon,  1 Apr 2019 09:11:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554070287;
        bh=ne9zn8TBpR2bbYKhtTUcTQ+C6DhHB8d0FxKotxvd98o=;
        h=Date:From:To:Cc:Subject:From;
        b=QyK7ZsmB/kDXk26s0bQaw3tHSbnj0ISwQzJ2ap0wo/uBhcZDDs6p0OrQJBTM9rr5S
         prJCHbIphJ+lU91Gx8mbqmTJrawqupfsKjhvzwVD4/DhKifbvrjORrzFb+6glYLBP3
         UCKkui2mRtEcGmieSPFImuAgELX2ivIbyyMNpq0X2sasIjHGhglUa2RILAgm9Gtgjm
         Z+7AeN4GwpkahiZDG0u3Uukbx28eN85BQHteulA6rBhZzyNMVdnI0nwMJhSPo3UrVj
         saOIAZD36sDFWcLcSgZgtZ2maV/u7CjXmYoOUZHqOkn8ClRgWQ39ZHThG9g5qITD27
         vgqOyxw1bZ93A==
Date:   Mon, 1 Apr 2019 09:11:19 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Huy Nguyen <huyn@mellanox.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20190401091119.3ac313e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4miz+nnpburOjOx=KhAFDFk"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4miz+nnpburOjOx=KhAFDFk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c

between commit:

  e28408e98bce ("net/mlx5e: Update xon formula")

from the net tree and commit:

  d3669ca9ff33 ("net/mlx5e: Fix port buffer function documentation format")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 4ab0d030b544,b0ce68feb0f3..000000000000
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@@ -167,25 -165,25 +167,25 @@@ static int update_xoff_threshold(struc
  }
 =20
  /**
-  * update_buffer_lossy()
-  *   max_mtu: netdev's max_mtu
-  *   pfc_en: <input> current pfc configuration
-  *   buffer: <input> current prio to buffer mapping
-  *   xoff:   <input> xoff value
-  *   port_buffer: <output> port receive buffer configuration
-  *   change: <output>
+  *	update_buffer_lossy	- Update buffer configuration based on pfc
 - *	@mtu: device's MTU
++ *	@max_mtu: netdev's max_mtu
+  *	@pfc_en: <input> current pfc configuration
+  *	@buffer: <input> current prio to buffer mapping
+  *	@xoff:   <input> xoff value
+  *	@port_buffer: <output> port receive buffer configuration
+  *	@change: <output>
   *
-  *   Update buffer configuration based on pfc configuraiton and priority
-  *   to buffer mapping.
-  *   Buffer's lossy bit is changed to:
-  *     lossless if there is at least one PFC enabled priority mapped to t=
his buffer
-  *     lossy if all priorities mapped to this buffer are PFC disabled
+  *	Update buffer configuration based on pfc configuraiton and
+  *	priority to buffer mapping.
+  *	Buffer's lossy bit is changed to:
+  *		lossless if there is at least one PFC enabled priority
+  *		mapped to this buffer lossy if all priorities mapped to
+  *		this buffer are PFC disabled
   *
-  *   Return:
-  *     Return 0 if no error.
-  *     Set change to true if buffer configuration is modified.
+  *	@return: 0 if no error,
+  *	sets change to true if buffer configuration was modified.
   */
 -static int update_buffer_lossy(unsigned int mtu,
 +static int update_buffer_lossy(unsigned int max_mtu,
  			       u8 pfc_en, u8 *buffer, u32 xoff,
  			       struct mlx5e_port_buffer *port_buffer,
  			       bool *change)

--Sig_/4miz+nnpburOjOx=KhAFDFk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyhOwcACgkQAVBC80lX
0Gz2AQf8D9KE6qKJKKuXQBPLoXP6jApXBKTPQpiOiTEzuDXktBzaN9DfcrX4H/vu
OE6BaDVB5jz9AkTDlguYE7ylYW+ZWlZPUkigG7yvDHsOoNxjS/5nO29DBkzVZXyD
HouO0ch+AevEDVgVF+xWy97yCZD1+rDQ8Zq5G+pEn692VD68VWPr01W4cpMD0rz0
oPQeVhmzUNsr+t9Jz07pulHrzRCw0Y1JavTQYNzTQaG2keyImnfHSdalYx1Z1qHK
ERqX058CjoMutSQxS1KpPqOXfXWQirmRnEo3fisOLd4ZgkXnYaDkrtjmQuVBYu0J
BLW2P+FSVPJf9TuVT+qYLprsyRcCZQ==
=EsSp
-----END PGP SIGNATURE-----

--Sig_/4miz+nnpburOjOx=KhAFDFk--
