Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B991BC282DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81380214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 01:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k94hEwEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387884AbfDRB6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 21:58:09 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39991 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730037AbfDRB6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 21:58:09 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44l2Lk1vzbz9s47;
        Thu, 18 Apr 2019 11:58:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555552686;
        bh=3GkzFSNg/RcI78dZhxCnG2WKngY0rCNueYTue+tyAb8=;
        h=Date:From:To:Cc:Subject:From;
        b=k94hEwEk/HL6vhPRvovwepDUpU41xJPrsuuWuDsWjw75coEhomtohgtHoEFhWy5+1
         ZJ/URj/aIdSpcwTr5EUYvejhVZbsFM7qmadfB8iSGsQfSE6d+xeM0LcMTObIrGatP9
         0FIQ9Zpc8GeAXwlxFYkGo5YwtXvPnrplAa8+u60+ycliUWah7gjsB/u8rJtTPtdI9V
         lGRbP5AskcyDHzjjgjmWcV0HtBqroeS9OWIIMLO/21p+MPs2bvMKbHY6DVL+lLoEFo
         UkGfz54fg52IOPD4fWyNZkCyTt+KwFc+sY3JVlh1QTDb8OF4Tfl9gJbRDocgvhuqFU
         tRVFjag1dMjGA==
Date:   Thu, 18 Apr 2019 11:57:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>
Subject: linux-next: build failure after merge of the bpf-next tree
Message-ID: <20190418115748.0b0aefdc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Uey02cAE9AV_yMzV/uuoi04"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Uey02cAE9AV_yMzV/uuoi04
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bpf-next tree, today's linux-next build (powerpc perf)
failed like this:

In file included from xsk.c:32:
libbpf_util.h:49:3: error: #warning Architecture missing native barrier fun=
ctions in libbpf_util.h. [-Werror=3Dcpp]
 # warning Architecture missing native barrier functions in libbpf_util.h.
   ^~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  b7e3a28019c9 ("libbpf: remove dependency on barrier.h in xsk.h")

I have applied the following patch for today ... please fix this.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 18 Apr 2019 11:54:56 +1000
Subject: [PATCH] suppress warning in tools/lib/bpf/libbpf_util.h

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 tools/lib/bpf/libbpf_util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf_util.h b/tools/lib/bpf/libbpf_util.h
index 172b707e007b..a54eb2cdbdd6 100644
--- a/tools/lib/bpf/libbpf_util.h
+++ b/tools/lib/bpf/libbpf_util.h
@@ -46,7 +46,7 @@ do {				\
 # define libbpf_smp_mb() asm volatile("dmb ish" : : : "memory")
 # define libbpf_smp_rwmb() libbpf_smp_mb()
 #else
-# warning Architecture missing native barrier functions in libbpf_util.h.
+//# warning Architecture missing native barrier functions in libbpf_util.h.
 # define libbpf_smp_rmb() __sync_synchronize()
 # define libbpf_smp_wmb() __sync_synchronize()
 # define libbpf_smp_mb() __sync_synchronize()
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/Uey02cAE9AV_yMzV/uuoi04
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly32ZwACgkQAVBC80lX
0GwnQAf+IUy3PBBmu9rOY+hoEog4+s52xXFZ7p67Cn6Vh7n+VrZbhPl1NhyHjtEj
tms/einrmeJrRF4sFrkk6S79CWrfkZjH54SOTsj4KQaw1Us47zNiQIDFMZWIh5Fh
nCVen72GKjPoy8xXdk1IiQj9a2fb5gCyrnOUDNcqx04LITM4JKpSkCYNCYFODmKQ
3O4UEYUdEr98KDoYfb5XIkA6brL3+T0oJHObwSPAuUwwwPSKiBpWoKk5su9jximg
pLNwHVnFQqfHPZHknQ4bP6Q3f7P5V4U7uLuJFXpOg/738oQhvnHY0Usd+Jnkj/pd
ARlTMmW+1Elriz4fBS7XY4/VnMuXpQ==
=xoS5
-----END PGP SIGNATURE-----

--Sig_/Uey02cAE9AV_yMzV/uuoi04--
