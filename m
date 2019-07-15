Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0524FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB53020665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563228034;
	bh=opj85GkhTsX799kvL6zjC53Z5Nb4q3yDICVYRU7YfS0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NDjiSv9qyg0EBhhC7SkxW8laV2dm4hRoBLvStcAq4RHplG7ij90IsSsakBqXERgFA
	 8r3XSp/4/Ymt6ii66rzPfFKZMeNG9Kqn4dEAKnjDxSJoo4h5wjahoUQA29qS8yPaAX
	 q14xx/manHg7yRJRBhGhGS1dX6W6D2MlDY1tEPLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbfGOWAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:00:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfGOWAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:00:33 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DD472171F;
        Mon, 15 Jul 2019 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563228032;
        bh=opj85GkhTsX799kvL6zjC53Z5Nb4q3yDICVYRU7YfS0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EC6fKVCh7fcp4L3S+xIIzlJ041+FzYRiPqD+o/00VyfrmwI78fMb8glbcLyVutXZN
         SjI9PDYmbGBy8XjyzzJKqlCvHtOzhWif4oCIPemh5CMm+eEiCheYoK9L12l/K117EG
         Lki6SkcXAH/ihaC/jxXzsC9IORAdtALY1dvq1V2M=
Date:   Mon, 15 Jul 2019 15:00:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        =?ISO-8859-1?Q?J?= =?ISO-8859-1?Q?=E9r=F4me?= Glisse 
        <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH] mm/hmm: Fix bad subpage pointer in try_to_unmap_one
Message-Id: <20190715150031.49c2846f4617f30bca5f043f@linux-foundation.org>
In-Reply-To: <05fffcad-cf5e-8f0c-f0c7-6ffbd2b10c2e@nvidia.com>
References: <20190709223556.28908-1-rcampbell@nvidia.com>
        <20190709172823.9413bb2333363f7e33a471a0@linux-foundation.org>
        <05fffcad-cf5e-8f0c-f0c7-6ffbd2b10c2e@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2019 18:24:57 -0700 Ralph Campbell <rcampbell@nvidia.com> wro=
te:

>=20
> On 7/9/19 5:28 PM, Andrew Morton wrote:
> > On Tue, 9 Jul 2019 15:35:56 -0700 Ralph Campbell <rcampbell@nvidia.com>=
 wrote:
> >=20
> >> When migrating a ZONE device private page from device memory to system
> >> memory, the subpage pointer is initialized from a swap pte which compu=
tes
> >> an invalid page pointer. A kernel panic results such as:
> >>
> >> BUG: unable to handle page fault for address: ffffea1fffffffc8
> >>
> >> Initialize subpage correctly before calling page_remove_rmap().
> >=20
> > I think this is
> >=20
> > Fixes:  a5430dda8a3a1c ("mm/migrate: support un-addressable ZONE_DEVICE=
 page in migration")
> > Cc: stable
> >=20
> > yes?
> >=20
>=20
> Yes. Can you add this or should I send a v2?

I updated the patch.  Could we please have some review input?


From: Ralph Campbell <rcampbell@nvidia.com>
Subject: mm/hmm: fix bad subpage pointer in try_to_unmap_one

When migrating a ZONE device private page from device memory to system
memory, the subpage pointer is initialized from a swap pte which computes
an invalid page pointer. A kernel panic results such as:

BUG: unable to handle page fault for address: ffffea1fffffffc8

Initialize subpage correctly before calling page_remove_rmap().

Link: http://lkml.kernel.org/r/20190709223556.28908-1-rcampbell@nvidia.com
Fixes: a5430dda8a3a1c ("mm/migrate: support un-addressable ZONE_DEVICE page=
 in migration")
Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=E9r=F4me Glisse" <jglisse@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/rmap.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/rmap.c~mm-hmm-fix-bad-subpage-pointer-in-try_to_unmap_one
+++ a/mm/rmap.c
@@ -1476,6 +1476,7 @@ static bool try_to_unmap_one(struct page
 			 * No need to invalidate here it will synchronize on
 			 * against the special swap migration pte.
 			 */
+			subpage =3D page;
 			goto discard;
 		}
=20
_

