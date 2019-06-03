Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9574BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6806B27B42
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 15:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ZoKRYuqv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfFCPLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 11:11:32 -0400
Received: from ozlabs.org ([203.11.71.1]:50211 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfFCPLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 11:11:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Hdmv545Hz9s4Y;
        Tue,  4 Jun 2019 01:11:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559574688;
        bh=eDuRZMdVYYQROCCGmu+HKfLRFO7Y6eokeOO3l7DvWCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZoKRYuqvpdEn7yiFycsiV4IDbycT0IPTFEnpBIksDlOrF1XldtLiq+2iloNCVu7Ey
         42EgecTyjdqed8SbCbEbfYMj/p0/65mIlJngX8IOIyKbJd4Qd0jh4EKeVX5Fi7KWn8
         vboNbS+dur7m6TyeZmY7wvdxsUsume249CrlxODn9R31tYvBiUdYlJrNZHDoqZeLBK
         zDL9zRUKTqZWCuwO3RoiyergKGDPZm8AIA5NEz7RP1GqBPWLgMdupEiif1PA3OiE64
         pJ8Yn3y0KXTDy9VgJjYl9XQsJkt6m7vf0GMQC49wUnE/pcKNFbj00bQYHfzfhHoFhG
         mz3dWxEa2/9xw==
Date:   Tue, 4 Jun 2019 01:11:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, Andrei Vagin <avagin@gmail.com>
Subject: Re: [BUG BISECT] bug mm/vmalloc.c:470 (mm/vmalloc.c: get rid of one
 single unlink_va() when merge)
Message-ID: <20190604011125.266222a8@canb.auug.org.au>
In-Reply-To: <CAJKOXPed=npnfk0H2WUDityHg5cPLH_zwShyRd+B2RS8h6C7SQ@mail.gmail.com>
References: <CAJKOXPcTVpLtSSs=Q0G3fQgXYoVa=kHxWcWXyvS13ie73ByZBw@mail.gmail.com>
        <20190603135939.e2mb7vkxp64qairr@pc636>
        <CAJKOXPdczUnsaBeXTuutZXCQ70ejDT68xnVm-e+SSdLZi-vyCA@mail.gmail.com>
        <20190604003153.76f33dd2@canb.auug.org.au>
        <CAJKOXPed=npnfk0H2WUDityHg5cPLH_zwShyRd+B2RS8h6C7SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ydAB_847pdF8mWcT_YXzIYL"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ydAB_847pdF8mWcT_YXzIYL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Mon, 3 Jun 2019 16:35:22 +0200 Krzysztof Kozlowski <krzk@kernel.org> wro=
te:
>
> On Mon, 3 Jun 2019 at 16:32, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
> >
> > On Mon, 3 Jun 2019 16:10:40 +0200 Krzysztof Kozlowski <krzk@kernel.org>=
 wrote: =20
> > >
> > > Indeed it looks like effect of merge conflict resolution or applying.
> > > When I look at MMOTS, it is the same as yours:
> > > http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/commit/?id=3Db77b8cce=
67f246109f9d87417a32cd38f0398f2f
> > >
> > > However in linux-next it is different.
> > >
> > > Stephen, any thoughts? =20
> >
> > Have you had a look at today's linux-next?  It looks correct in
> > there.  Andrew updated his patch series over the weekend. =20
>=20
> Yes, I am looking at today's next. Both the source code and the commit
> 728e0fbf263e3ed359c10cb13623390564102881 have wrong "if (merged)" (put
> in wrong hunk).

OK, I have replaced that commit with this:

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: mm/vmalloc.c: get rid of one single unlink_va() when merge

It does not make sense to try to "unlink" the node that is definitely not
linked with a list nor tree.  On the first merge step VA just points to
the previously disconnected busy area.

On the second step, check if the node has been merged and do "unlink" if
so, because now it points to an object that must be linked.

Link: http://lkml.kernel.org/r/20190527151843.27416-4-urezki@gmail.com
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Acked-by: Hillf Danton <hdanton@sina.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Thomas Garnier <thgarnie@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/vmalloc.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/mm/vmalloc.c~mm-vmap-get-rid-of-one-single-unlink_va-when-merge
+++ a/mm/vmalloc.c
@@ -719,9 +719,6 @@ merge_or_add_vmap_area(struct vmap_area
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
=20
-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
-
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
=20
@@ -746,12 +743,11 @@ merge_or_add_vmap_area(struct vmap_area
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
=20
-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
+			if (merged)
+				unlink_va(va, root);
=20
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
-
 			return;
 		}
 	}
_

Which is the patch from mmots but with different line numbers.
--=20
Cheers,
Stephen Rothwell

--Sig_/ydAB_847pdF8mWcT_YXzIYL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz1OJ0ACgkQAVBC80lX
0Gy1Awf8CHdwemQ/KgeILWHLGe2zYZfMlga1K+adEnhVDxrxEryZFGJiRTFghndD
y2UPZLjUfSTmwmZwmUydCCNYHem0/M89nP6f6o2GYHtg3wQJKSVzDE7JXssQ0+p/
DMtYxHL8VCKIzTU250tEC2kzxU+9IXwflrLHuLLEaWYmbtgudEpUdFr0xWGbGPh7
17rGAfC7A+rJY3DoomLyJfsGYID6dbHewlghDzEPvNLziVfsAZH35bmzAnwEs3vv
hZhB8TZb8Lj5U4e3JT6SqVBON96IAkOj2Ti5QaeEyjXrmrQuyZ57xy+yaZmTpmLj
yFnHYZX/pQ2pSj41p4nS1joBmTaVOQ==
=XHt+
-----END PGP SIGNATURE-----

--Sig_/ydAB_847pdF8mWcT_YXzIYL--
