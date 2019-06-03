Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9976C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F37D27888
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 14:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tzn4pUMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfFCOkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 10:40:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37235 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727650AbfFCOkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 10:40:07 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Hd4f2zbfz9s1c;
        Tue,  4 Jun 2019 00:40:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559572803;
        bh=FmOgiY6lTWDTCTs9StTg9VBetPqLMyHfqz6jDfrLEw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tzn4pUMiSu0BF5kUDplr3AltOVKC3qEPEVi2vSFc0pduscleqgcb4mQ4knMeVZlQ0
         +AI7Tw85ErOshOMcx5omQ2KQEF60D0UUSz9WusycR48ts+ptuMuKFl2BZwhwd8mkv2
         PTQ611rzC32q9O40FUmpPaXdPUqHya2oQrM+p1/wx0RebbbFd8sQobSwAZUwmXAnpF
         ZGvdvEeclib+ja0S5JzavMHBg+gKnMr922Wo3hiQNmLRS3Ie/PtG94WrT1BP6Pnsc/
         JOdL61En/qVH8F7a6x6l9LDibcVMoHu+p4EDM3ksvoE+QnhrrnLae73PwCNC/iXqC1
         BbiVcLGaabBjg==
Date:   Tue, 4 Jun 2019 00:40:00 +1000
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
Message-ID: <20190604004000.0d6356a9@canb.auug.org.au>
In-Reply-To: <20190604003153.76f33dd2@canb.auug.org.au>
References: <CAJKOXPcTVpLtSSs=Q0G3fQgXYoVa=kHxWcWXyvS13ie73ByZBw@mail.gmail.com>
        <20190603135939.e2mb7vkxp64qairr@pc636>
        <CAJKOXPdczUnsaBeXTuutZXCQ70ejDT68xnVm-e+SSdLZi-vyCA@mail.gmail.com>
        <20190604003153.76f33dd2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Hhpt4L1s=8zO1hfZdUUFFal"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Hhpt4L1s=8zO1hfZdUUFFal
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 4 Jun 2019 00:31:53 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Hi Krzysztof,
>=20
> On Mon, 3 Jun 2019 16:10:40 +0200 Krzysztof Kozlowski <krzk@kernel.org> w=
rote:
> >
> > Indeed it looks like effect of merge conflict resolution or applying.
> > When I look at MMOTS, it is the same as yours:
> > http://git.cmpxchg.org/cgit.cgi/linux-mmots.git/commit/?id=3Db77b8cce67=
f246109f9d87417a32cd38f0398f2f
> >=20
> > However in linux-next it is different.
> >=20
> > Stephen, any thoughts? =20
>=20
> Have you had a look at today's linux-next?  It looks correct in
> there.  Andrew updated his patch series over the weekend.

Actually, this is the patch from mmotm (note 'm'):

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

 mm/vmalloc.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/mm/vmalloc.c~mm-vmap-get-rid-of-one-single-unlink_va-when-merge
+++ a/mm/vmalloc.c
@@ -719,8 +719,8 @@ merge_or_add_vmap_area(struct vmap_area
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
@@ -746,9 +746,6 @@ merge_or_add_vmap_area(struct vmap_area
 			/* Check and update the tree if needed. */
 			augment_tree_propagate_from(sibling);
=20
-			/* Remove this VA, it has been merged. */
-			unlink_va(va, root);
-
 			/* Free vmap_area object. */
 			kmem_cache_free(vmap_area_cachep, va);
=20
_

Do I need to replace that for tomorrow?
--=20
Cheers,
Stephen Rothwell

--Sig_/Hhpt4L1s=8zO1hfZdUUFFal
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz1MUAACgkQAVBC80lX
0GyODwgAhFRY7MDp6PN5rHGvLRcgcl0R9opYG6WWuR5pAkl9A7RGR/6BDDLm0ZVu
YvumuExfm9Z4XFQkdAqX3yPw+Zt7Y1fLTyY7G8obyw4D+L5/DbktmCKqWMHMO4OZ
iVeW4LyAGfY+t/XFu2By/hPZuIUXnjL+zWP5hW3q+bI0Kzy028LnAEcISuuMxSY4
6ePXcA4eOZZgwAn60poxjWOIgpiu13CTjEsK9/FH/kDbF+bghqvKyI7q09DcBKkm
BSTTHiXPPXCxAjFve53BBQc418H2ZZ+j0uTWZBfsjRWpOETHafQYnZAXwVl7GHaF
L7E3xO/wVQbdCMyaKMbdh3Io4lmHZw==
=/lGE
-----END PGP SIGNATURE-----

--Sig_/Hhpt4L1s=8zO1hfZdUUFFal--
