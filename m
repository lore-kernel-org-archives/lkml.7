Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1C6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36B92077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I2AtCXtu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfDWHZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:25:28 -0400
Received: from ozlabs.org ([203.11.71.1]:60947 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfDWHZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:25:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44pFN51R90z9s9G;
        Tue, 23 Apr 2019 17:25:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556004325;
        bh=x41/FnTqFKHN9cW4lUvmiyuS2AJUB6nNSHcih+SxlA4=;
        h=Date:From:To:Cc:Subject:From;
        b=I2AtCXtuKhOEprWlto2Z9HDENHkbcZEGA1XhGMxdp4GbUYIWsDtpYHHN/vOt0RZd9
         2/14KZ4C8g6BP41H4/wrHshnzQWQnJpdb2XdrW76ILbvqwduPyVA4pn+VRZSl+8BNw
         Ad37cdLuPpNGgtVHPCr0s2Y1AJBqnqN1yDfmsfneuJQY6GOKiBYigUAmd/h0QkIwNI
         xXQAE79FUdhrSXpdG/2PpFQGOUUJ9poif7LUZyPdHAPC2943h6hDRch2WMa/cfzHib
         BoWiulFNXLW1LQmzy5fsuxqn0/oiiTRWqG8rYVR1kM6IEAnJ6+AHymkmG1aQHY9rzJ
         KbLZMCXpQpcZQ==
Date:   Tue, 23 Apr 2019 17:25:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the net-next tree
Message-ID: <20190423172524.3bcf6bd0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/k9UNknx1JqUf=dlGGCpmzTt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/k9UNknx1JqUf=dlGGCpmzTt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the net-next tree, today's linux-next build (sparc64
defconfig) failed like this:

net/core/sock.c: In function 'sock_gettstamp':
net/core/sock.c:3007:23: error: expected '}' before ';' token
    .tv_sec =3D ts.tv_sec;
                       ^
net/core/sock.c:3011:4: error: expected ')' before 'return'
    return -EFAULT;
    ^~~~~~
net/core/sock.c:3013:2: error: expected expression before '}' token
  }
  ^

Caused by commit

  c7cbdbf29f48 ("net: rework SIOCGSTAMP ioctl handling")

I have applied the followinf patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 23 Apr 2019 17:12:19 +1000
Subject: [PATCH] net: fix sparc64 compilation of sock_gettstamp

Fixes: c7cbdbf29f48 ("net: rework SIOCGSTAMP ioctl handling")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 net/core/sock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 443b98d05f1e..925b84a872dd 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3004,10 +3004,10 @@ int sock_gettstamp(struct socket *sock, void __user=
 *userstamp,
 	/* beware of padding in sparc64 timeval */
 	if (timeval && !in_compat_syscall()) {
 		struct __kernel_old_timeval __user tv =3D {
-			.tv_sec =3D ts.tv_sec;
-			.tv_usec =3D ts.tv_nsec;
+			.tv_sec =3D ts.tv_sec,
+			.tv_usec =3D ts.tv_nsec,
 		};
-		if (copy_to_user(userstamp, &tv, sizeof(tv))
+		if (copy_to_user(userstamp, &tv, sizeof(tv)))
 			return -EFAULT;
 		return 0;
 	}
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/k9UNknx1JqUf=dlGGCpmzTt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly+veQACgkQAVBC80lX
0GzafQf/e3IBpnfR4vf6BXz3uaEfuMtioBsb5zL1Fa/jOu6+UCvX09AfhP9h+NR+
0jvr17MpAJeKjdN1MEUmI/Q+BG4Cg/xdPZkaOcneOm6NIxvdOlQjfmliWLsJMy+p
q1JNepOVRVffHLxM7klbBEBa6ePk5xm5bQT0CgyGToRq5sOu9Q9nKmD7reE80SK7
YH4IiOxnxA9zdUq4L773rIySDLC/grEZfZVUElMhobld6xvfc8PQ4kqSLXI3An9Q
f8l4CpGKkdZGwjmNMlW35dWZP36g/KbhTwF1GVy96ODBQ8M87+ksmagQuBLLJcKP
+wZC/1P00NIiANkoaL4yWPWweIFGrQ==
=WQ1p
-----END PGP SIGNATURE-----

--Sig_/k9UNknx1JqUf=dlGGCpmzTt--
