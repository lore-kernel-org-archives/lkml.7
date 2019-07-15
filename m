Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAED7C74A44
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797DA21734
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 00:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ioGGQ0Wy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfGOAC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 20:02:59 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46837 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbfGOAC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 20:02:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45n3dD49fZz9sMr;
        Mon, 15 Jul 2019 10:02:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563148976;
        bh=DaK8bkp5lA3sYQ9EawKG/kyxV2b/Mon0diulkMVOQjk=;
        h=Date:From:To:Cc:Subject:From;
        b=ioGGQ0Wy1fe/H7k6UBKlt/CoOXk0Ds/4PbYssor6bTtyUPD/vf0FONRXr9v4949c+
         /sISd3JcYgJJPHYISrwuZkbiIRJQBzqbabKuxfgalEPvrU8KyZIVYcaUrRNYi8YKke
         IDyXnTWMsmXf5IRYfQ5F1VDQ9ghz5T5/AbsfDeHf/hVd7mmABbsNqLkaIRs7gObQGb
         2PLFFw9DL1QBWvyMQah/WgfrKMbJpwje9QXzB4/Lz6uKLjJr88oLp4ro6XrEO3F/7k
         hGh82hYW5xebI/B7RTA7bH6aJZ7CIkHpKS9UnEF9YC5kCIQY8mIa++tszwQeqiyRO6
         5QbZszLNxp7WQ==
Date:   Mon, 15 Jul 2019 10:02:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: linux-next: build failure after merge of the pm tree
Message-ID: <20190715100236.1e019f2c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/JvAwh/r3+t+V+F.+O2706e."; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JvAwh/r3+t+V+F.+O2706e.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

In file included from <command-line>:
include/linux/intel_rapl.h:116:19: error: field 'pcap_rapl_online' has inco=
mplete type
  enum cpuhp_state pcap_rapl_online;
                   ^~~~~~~~~~~~~~~~

Caused by commit

  7ebf8eff63b4 ("intel_rapl: introduce struct rapl_if_private")

This was detected by the new test that attempts to build each include
file standalone.

I have added the following fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 15 Jul 2019 09:56:30 +1000
Subject: [PATCH] intel_rapl: need linux/cpuhotplug.h for enum cpuhp_state

Fixes: 7ebf8eff63b4 ("intel_rapl: introduce struct rapl_if_private")
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/intel_rapl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/intel_rapl.h b/include/linux/intel_rapl.h
index 0c179d92d110..efb3ce892c20 100644
--- a/include/linux/intel_rapl.h
+++ b/include/linux/intel_rapl.h
@@ -12,6 +12,7 @@
=20
 #include <linux/types.h>
 #include <linux/powercap.h>
+#include <linux/cpuhotplug.h>
=20
 enum rapl_domain_type {
 	RAPL_DOMAIN_PACKAGE,	/* entire package/socket */
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/JvAwh/r3+t+V+F.+O2706e.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0rwpwACgkQAVBC80lX
0GySmQf/dlR2fh18KQl5okeH3QdP5Elk3xRUVvLv2O7N4WvlR9vKKOyAMEq4h7bJ
G0S+6Yb+DUJhrgkNhwBg+4zZDv/GsQ9pkJZde2mLGmWVQc+agftIb/lXPShDbGCs
CTe0BJhyzjcRp/AjaAPkHUJe9o6CIUnCEy1Bid//icZ+fM7DAjxYe1+ZX2X/Br8L
fs+nGldRtv7Hr0hC7gRGX84TLCVNDBE0GeSoY3d3ASK6z3cG5OBclkmN4kpCHbDH
rdGifNGuq8doakej4jjvB9jPxF/3ORCdVbu/ws5MpYo3SBdjAC44qYfolAmnn86L
iesqHkl7XBcWo+jbYDGlO8esHADWwQ==
=MCZn
-----END PGP SIGNATURE-----

--Sig_/JvAwh/r3+t+V+F.+O2706e.--
