Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EC3C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BB9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m1RuRHeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfFZM6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:58:11 -0400
Received: from ozlabs.org ([203.11.71.1]:34271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbfFZM6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:58:11 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45YjkS54wDz9s3l;
        Wed, 26 Jun 2019 22:58:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561553888;
        bh=AHU7rLCuxNpibvuw6IOaAB7wBK1hfkU21LqnbPO1Lyk=;
        h=Date:From:To:Cc:Subject:From;
        b=m1RuRHeK320ov6fR38N/SI4UQmFRGUFemCLY4KTHeajjLSP7xKay5RwIYUb9JMujI
         KJ5u7sdhEqZq01HDdf4clYeEpfjJuoCYvIs/k8jULHMwpZuxtPI6N11LTKpXTPhuGM
         33m4b2VGqL7txr2WBQ32itlXZKRgBxUPcQ/tqYs90tNnkvldmOL/V8tHjHB5MERF8z
         geNPTUrr8x2izNl5pgOaPq0vtRUkH+9RAP+raZw1qdhKsXaaXQmo5zhSNDWaPZOF4e
         fRQR99Bu6OQ0d0Olhq+8/RSyJP8U8pyo5GVWKYDIzJVhc5KaZEToGDRnfa101XSK6k
         5SZl0IxYDhRag==
Date:   Wed, 26 Jun 2019 22:58:07 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20190626225807.205f1382@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K=.Tt1Id24AKO3xhdP/MtcW"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K=.Tt1Id24AKO3xhdP/MtcW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm tree, today's linux-next build (sparc64 defconfig)
failed like this:

In file included from arch/sparc/include/asm/page_64.h:130:0,
                 from arch/sparc/include/asm/page.h:8,
                 from arch/sparc/include/asm/thread_info_64.h:27,
                 from arch/sparc/include/asm/thread_info.h:5,
                 from include/linux/thread_info.h:38,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/sparc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:51,
                 from mm/gup.c:5:
mm/gup.c: In function 'gup_huge_pgd':
arch/sparc/include/asm/pgtable_64.h:864:37: error: implicit declaration of =
function 'pgd_pfn'; did you mean 'pud_pfn'? [-Werror=3Dimplicit-function-de=
claration]
 #define pgd_page(pgd)   pfn_to_page(pgd_pfn(pgd))
                                     ^
include/asm-generic/memory_model.h:54:40: note: in definition of macro '__p=
fn_to_page'
 #define __pfn_to_page(pfn) (vmemmap + (pfn))
                                        ^~~
mm/gup.c:2147:9: note: in expansion of macro 'pgd_page'
  page =3D pgd_page(orig) + ((addr & ~PGDIR_MASK) >> PAGE_SHIFT);
         ^~~~~~~~

Caused by commit

  51bbf54b3f26 ("sparc64: add the missing pgd_page definition")

I don't see a simple way to fix this, so sparc64 is broken for today :-(
--=20
Cheers,
Stephen Rothwell

--Sig_/K=.Tt1Id24AKO3xhdP/MtcW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0Ta98ACgkQAVBC80lX
0Gx2mAf/XQw9UT3Wv6uQYUASgZanLjWNzfA8uhZ72juQ8LKWMAbe3YWbH1UM5jy3
t9W6UcZjTIuSySg8yryd2AeRlh+Cc6EUPDY2NgRrXoOecHYBSMVF6R5MICjlkqhs
Ue4c1zdtZnlBaqlF41y4XDmGQW722wWu7BStEVelQAQEtkNtWVxmeZVCgUe7Y9DV
jdl01KKZVdHODA+SB/A81Le7sZhG0lWO3D79y41oXL+ZygK2C7N2/GSgw3eLrCQu
8fBLk17st1nOXOWPtwtek7J4PrG/FZGaClD83t8PoDJMqPprYanqSfS3Cy0UucfV
DSzmp076uM42+XR+3QsIO88wR+FxdQ==
=4X1n
-----END PGP SIGNATURE-----

--Sig_/K=.Tt1Id24AKO3xhdP/MtcW--
