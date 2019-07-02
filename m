Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D0C0650E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B3421473
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 00:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qPqItKzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfGBABI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 20:01:08 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54485 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbfGBABI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 20:01:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45d4C43XDPz9s3Z;
        Tue,  2 Jul 2019 10:01:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562025664;
        bh=YcxBeD6Q4wC1DnqF2UHDQOk3MwaNCpte8xIEjUbQ1dE=;
        h=Date:From:To:Cc:Subject:From;
        b=qPqItKzkQ/pEKh4b82mnrZfkCF7YfOGYQmKnnatD8cvPsrK2lL/AstdIFAEc9XwrH
         D8CYchYaeW6XpHRF/y9C7CrJb5hKy686TSqcyQKXpzSlMrYZF9gzqKHU7mQTKX2DaM
         bp+iVirvn2YhHU0Vy7xL4JSkCa3Fng36YH5kmLWQ46zybTiUiwZ0H7iOfPuNjRwX1t
         GKIaJXBVlXGTVxQpOqnd4jXfFJWZ33+fVVvJJr8YHWFQzRVnMOrghXqPLyk4GMTPf2
         d1JEb+xsmMdp7YLO1CGE0vSAxaPpd2hSuWkvvRGHr3hznrpKoHreqoXcbY2dSGrFYp
         zEeiLQ9MeU7Lg==
Date:   Tue, 2 Jul 2019 10:01:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failure after merge of the clk tree
Message-ID: <20190702100103.12c132da@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/4fPfY4dz.zTw+BW=GF3We/A"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4fPfY4dz.zTw+BW=GF3We/A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the clk tree, today's linux-next build (arm omap1_defconfig
and many others) failed like this:

In file included from drivers/clk/clkdev.c:22:0:
drivers/clk/clk.h:36:23: error: static declaration of '__clk_get_hw' follow=
s non-static declaration
include/linux/clk-provider.h:808:16: note: previous declaration of '__clk_g=
et_hw' was here

Caused by commit

  59fcdce425b7 ("clk: Remove ifdef for COMMON_CLK in clk-provider.h")

This commit exposed the CONFIG_COMMON_CLK version of the __clk_get_hw()
declaration to non CONFIG_COMMON_CLK code (where there is a static
declaration of  __clk_get_hw() (which is BTW missing an "inline")
in drivers/clk/clk.h.

We need something like this (untested):

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 2 Jul 2019 09:58:18 +1000
Subject: [PATCH] clk: for up for "clk: Remove ifdef for COMMON_CLK in
 clk-provider.h"

We were getting errors like:

In file included from drivers/clk/clkdev.c:22:0:
drivers/clk/clk.h:36:23: error: static declaration of '__clk_get_hw' follow=
s non
-static declaration
include/linux/clk-provider.h:808:16: note: previous declaration of '__clk_g=
et_hw
' was here

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/clk/clk.h            | 2 +-
 include/linux/clk-provider.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk.h b/drivers/clk/clk.h
index d8400d623b34..143acac2ec81 100644
--- a/drivers/clk/clk.h
+++ b/drivers/clk/clk.h
@@ -33,7 +33,7 @@ clk_hw_create_clk(struct device *dev, struct clk_hw *hw, =
const char *dev_id,
 {
 	return (struct clk *)hw;
 }
-static struct clk_hw *__clk_get_hw(struct clk *clk)
+static inline struct clk_hw *__clk_get_hw(struct clk *clk)
 {
 	return (struct clk_hw *)clk;
 }
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 0fbf3ccad849..35c8b1c315b4 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -805,7 +805,10 @@ void devm_clk_hw_unregister(struct device *dev, struct=
 clk_hw *hw);
 /* helper functions */
 const char *__clk_get_name(const struct clk *clk);
 const char *clk_hw_get_name(const struct clk_hw *hw);
+#ifdef CONFIG_COMON_CLK
+/* There is a !CONFIG_COMMON_CLK static inline for this in drivers/clk/clk=
.h */
 struct clk_hw *__clk_get_hw(struct clk *clk);
+#endif
 unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
 struct clk_hw *clk_hw_get_parent_by_index(const struct clk_hw *hw,
--=20
2.20.1

--=20
Cheers,
Stephen Rothwell

--Sig_/4fPfY4dz.zTw+BW=GF3We/A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0anr8ACgkQAVBC80lX
0GwnlAgAkaEHrBS5hradZaLJY1asTyVxJNrgn14tKqlPFCVnK14lKAHo7lRD8Czg
aVkJM4IEGawpZE8RuiuztUZ2Oa8DF3m+2qJu4Sila+GA1RdcKo4EfdM/rvDI5ctz
RsdRSrHP7WMW/LG8UrE0wzeJfuRKfjujCIJIPlg4hw2eqj1YPeWAGVtlx92tVHLw
pEICjzIHd+NguM5UHEGNVMTn0o8/q0joCSWuG9Hq42acY5eimYUlXou2bhmnmVPG
Ikck6juC4r//MKJ4W++Gv4RZBosM7bNUcQspzNEj4QNeIGL53YAN57VWR2HCclEe
ONLcGpsTv8CnsoVAFSDAW0cig2NqEg==
=peYP
-----END PGP SIGNATURE-----

--Sig_/4fPfY4dz.zTw+BW=GF3We/A--
