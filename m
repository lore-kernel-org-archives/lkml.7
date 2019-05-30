Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23B9C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4E625B5F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="b1T1Y6wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388805AbfE3Epp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:45:45 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:32991 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388748AbfE3Epl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 00:45:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Dw4f319Qz9sTN;
        Thu, 30 May 2019 14:45:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559191538;
        bh=CW8og/tTXaggc7WogDYrOnBUihyTAEdMDiSH8tYq6xw=;
        h=Date:From:To:Cc:Subject:From;
        b=b1T1Y6wmO5kKKlaq4IxJrgTJw8qpxplHTqUW5nDN5R98YkELPTzfi2UizhaqMP7l9
         s5rtXxh3jgaXyUM59fZshCUZMPKx8yZMFE5vaD9sDFZE/JCiDEp89l+LBW2egjiHrC
         nle9z37zmFleU3cqX5/QxnVoafdsoptt9KyWTntObERD3/CGb9p96B7AAOEQn/CxF3
         F5ZQJIKS/CpQLt0ruzoeJTzXW8jINEhpHE3heMJ91R9nPHjwS19GxbuMBCQlsAIISm
         I1lSfUnmOEckBZ1WozQdaAWgfYsDLCdp2wRV4vq2Li7pHMI+aJd+iIMUxG/b/S6nMS
         ksduMUgv//W/A==
Date:   Thu, 30 May 2019 14:45:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190530144536.7b65be9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/65cL.CDXbotvOfjdJoQ/zV/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/65cL.CDXbotvOfjdJoQ/zV/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:


Caused by commit

  a826492f28d9 ("mm: move ioremap page table mapping function to mm/")

I have applied the following patch for today (which makes it build at
least):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 30 May 2019 14:42:20 +1000
Subject: [PATCH] fix "mm: move ioremap page table mapping function to mm/"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6370e0876a2c..f3abede9f161 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -322,7 +322,7 @@ int vmap_range(unsigned long addr,
 	int ret;
=20
 	ret =3D vmap_range_noflush(addr, end, phys_addr, prot, max_page_shift);
-	flush_cache_vmap(start, end);
+	flush_cache_vmap(addr, end);
 	return ret;
 }
=20
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/65cL.CDXbotvOfjdJoQ/zV/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzvX/AACgkQAVBC80lX
0GzAmwf/e9J+Ipx65rX4Ab1JfAhlegR8rrPs2FJpx7BVork0Jo6W92UA6VBMRSUF
IUU/zpNVPDV2KFQ4tLHfvOIWSIBrfYaQGE7oYb3XxAPt3nmtvzB658KANgS20DaG
rIdjKoD2h10K8fnJGyLO0PZxZPdh0d3GWT3L3wSUKqhXRnzJqU0X+WtJrPBK/Hqm
Q1tRKJKF8MYiYGXNmon/ttFO8PjpCgHOGKbsOxk3cjYe2C9+hVObQZ8Ivq3pFmG9
o7CpAXQ3Z7ppd0T6D72Ct8+UZVe0+I2Wqp0Y0uNGfEt0dJeHH27Ds9uHeXucUsOY
khvzKNInhV8Q7C4CP5YSSlKdZ3iaJg==
=BgnB
-----END PGP SIGNATURE-----

--Sig_/65cL.CDXbotvOfjdJoQ/zV/--
