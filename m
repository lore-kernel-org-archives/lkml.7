Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D5AC46499
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 05:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E83214AE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 05:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562475871;
	bh=L+JpguuIDqqO5+DF+izAClJz+73pjPuz93J+6JzKhGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OAPl/NfheHCkjqo9ubEZH8ZNAhQHNKjCyzDv5V5+BGe6cAfQJJ8nYlVkbdCvXjKjU
	 1CN+4Zju5sml5a2GjOcYU4X34ch7UPJU+hWfapfLv4ySJXSbY6vh8GgMYBe7WyCsqg
	 HU29I6Obs8W0Kq/W/KEHO4eisWt/uxMAtSs17CmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbfGGFE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 01:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfGGFE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 01:04:29 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01A202146E;
        Sun,  7 Jul 2019 05:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562475867;
        bh=L+JpguuIDqqO5+DF+izAClJz+73pjPuz93J+6JzKhGk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Xe7OGCjmUL40Ms3R+R3ORuqB/v+FTj3PldONYoj3wFZ0MR/gKqtUfLoKYQPtUZHI5
         ym5yhwdKXazmoiqlrJ3Hy7Dd9eF0VD7Cy5IFcUZl4M605ClX6N3uDpQdIBvCH0MwkC
         0FIO7TA8aR8z0DvO+pYEjJoPeQ1YmnwQHm/ER+Bw=
Date:   Sat, 6 Jul 2019 22:04:26 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: linux-next: manual merge of the akpm-current tree with the hmm
 tree
Message-Id: <20190706220426.c2c4518f20e1ecc7ddd069fa@linux-foundation.org>
In-Reply-To: <20190705120810.GA31525@mellanox.com>
References: <20190704205536.32740b34@canb.auug.org.au>
        <20190704125539.GL3401@mellanox.com>
        <20190704230133.1fe67031@canb.auug.org.au>
        <20190704132836.GM3401@mellanox.com>
        <20190705070810.1e01ea9d@canb.auug.org.au>
        <CAPcyv4hHC3s3nePSSHaKkFFbxuABZE3GLa7Li=0j6Z45ERrPEg@mail.gmail.com>
        <20190705120810.GA31525@mellanox.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2019 12:08:15 +0000 Jason Gunthorpe <jgg@mellanox.com> wrote:

> On Thu, Jul 04, 2019 at 04:29:55PM -0700, Dan Williams wrote:
> > Guys, Andrew has kicked the subsection patches out of -mm because of
> > the merge conflicts. Can we hold off on the hmm cleanups for this
> > cycle?
>=20
> I agree with you we should prioritize your subsection patches over
> CH's cleanup if we cannot have both.
>=20
> As I said, I'll drop CH's at Andrews request, but I do not want to
> make any changes without being aligned with him.

OK, I had a shot at repairing the damage on top of current linux-next.=20
The great majority of the issues were in
mm-devm_memremap_pages-enable-sub-section-remap.patch.

Below are the rejects which I saw and below that is my attempt to
resolve it all.  Dan, please go through this with a toothcomb.  I've
just done an mmotm release with all this in it so please do whatever's
needed to verify that it's all working correctly.


--- kernel/memremap.c~mm-devm_memremap_pages-enable-sub-section-remap
+++ kernel/memremap.c
@@ -58,7 +58,7 @@ static unsigned long pfn_first(struct de
 	struct vmem_altmap *altmap =3D &pgmap->altmap;
 	unsigned long pfn;
=20
-	pfn =3D res->start >> PAGE_SHIFT;
+	pfn =3D PHYS_PFN(res->start);
 	if (pgmap->altmap_valid)
 		pfn +=3D vmem_altmap_offset(altmap);
 	return pfn;
@@ -95,25 +94,21 @@ static void devm_memremap_pages_release(
 	pgmap->cleanup(pgmap->ref);
=20
 	/* pages are dead and unused, undo the arch mapping */
-	align_start =3D res->start & ~(PA_SECTION_SIZE - 1);
-	align_size =3D ALIGN(res->start + resource_size(res), PA_SECTION_SIZE)
-		- align_start;
-
-	nid =3D page_to_nid(pfn_to_page(align_start >> PAGE_SHIFT));
+	nid =3D page_to_nid(pfn_to_page(PHYS_PFN(res->start)));
=20
 	mem_hotplug_begin();
 	if (pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE) {
-		pfn =3D align_start >> PAGE_SHIFT;
+		pfn =3D PHYS_PFN(res->start);
 		__remove_pages(page_zone(pfn_to_page(pfn)), pfn,
-				align_size >> PAGE_SHIFT, NULL);
+				PHYS_PFN(resource_size(res)), NULL);
 	} else {
-		arch_remove_memory(nid, align_start, align_size,
+		arch_remove_memory(nid, res->start, resource_size(res),
 				pgmap->altmap_valid ? &pgmap->altmap : NULL);
-		kasan_remove_zero_shadow(__va(align_start), align_size);
+		kasan_remove_zero_shadow(__va(res->start), resource_size(res));
 	}
 	mem_hotplug_done();
=20
-	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
+	untrack_pfn(NULL, PHYS_PFN(res->start), resource_size(res));
 	pgmap_array_delete(res);
 	dev_WARN_ONCE(dev, pgmap->altmap.alloc,
 		      "%s: failed to free all reserved pages\n", __func__);
@@ -140,16 +135,13 @@ static void devm_memremap_pages_release(
  */
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 {
-	resource_size_t align_start, align_size, align_end;
-	struct vmem_altmap *altmap =3D pgmap->altmap_valid ?
-			&pgmap->altmap : NULL;
 	struct resource *res =3D &pgmap->res;
 	struct dev_pagemap *conflict_pgmap;
 	struct mhp_restrictions restrictions =3D {
 		/*
 		 * We do not want any optional features only our own memmap
 		*/
-		.altmap =3D altmap,
+		.altmap =3D pgmap->altmap_valid ? &pgmap->altmap : NULL,
 	};
 	pgprot_t pgprot =3D PAGE_KERNEL;
 	int error, nid, is_ram;
@@ -159,12 +151,7 @@ void *devm_memremap_pages(struct device
 		return ERR_PTR(-EINVAL);
 	}
=20
-	align_start =3D res->start & ~(PA_SECTION_SIZE - 1);
-	align_size =3D ALIGN(res->start + resource_size(res), PA_SECTION_SIZE)
-		- align_start;
-	align_end =3D align_start + align_size - 1;
-
-	conflict_pgmap =3D get_dev_pagemap(PHYS_PFN(align_start), NULL);
+	conflict_pgmap =3D get_dev_pagemap(PHYS_PFN(res->start), NULL);
 	if (conflict_pgmap) {
 		dev_WARN(dev, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
@@ -220,25 +207,25 @@ void *devm_memremap_pages(struct device
 	 * arch_add_memory().
 	 */
 	if (pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE) {
-		error =3D add_pages(nid, align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, &restrictions);
+		error =3D add_pages(nid, PHYS_PFN(res->start),
+				PHYS_PFN(resource_size(res)), &restrictions);
 	} else {
-		error =3D kasan_add_zero_shadow(__va(align_start), align_size);
+		error =3D kasan_add_zero_shadow(__va(res->start), resource_size(res));
 		if (error) {
 			mem_hotplug_done();
 			goto err_kasan;
 		}
=20
-		error =3D arch_add_memory(nid, align_start, align_size,
-					&restrictions);
+		error =3D arch_add_memory(nid, res->start, resource_size(res),
+				&restrictions);
 	}
=20
 	if (!error) {
 		struct zone *zone;
=20
 		zone =3D &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
-		move_pfn_range_to_zone(zone, align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, altmap);
+		move_pfn_range_to_zone(zone, PHYS_PFN(res->start),
+				PHYS_PFN(resource_size(res)), restrictions.altmap);
 	}
=20
 	mem_hotplug_done();






From: Dan Williams <dan.j.williams@intel.com>
Subject: mm/devm_memremap_pages: enable sub-section remap

Teach devm_memremap_pages() about the new sub-section capabilities of
arch_{add,remove}_memory().  Effectively, just replace all usage of
align_start, align_end, and align_size with res->start, res->end, and
resource_size(res).  The existing sanity check will still make sure that
the two separate remap attempts do not collide within a sub-section (2MB
on x86).

Link: http://lkml.kernel.org/r/156092355542.979959.10060071713397030576.stg=
it@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>	[ppc64]
Cc: Michal Hocko <mhocko@suse.com>
Cc: Toshi Kani <toshi.kani@hpe.com>
Cc: J=E9r=F4me Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yang <richardw.yang@linux.intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 kernel/memremap.c |   57 +++++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 34 deletions(-)

--- a/kernel/memremap.c~mm-devm_memremap_pages-enable-sub-section-remap
+++ a/kernel/memremap.c
@@ -54,7 +54,7 @@ static void pgmap_array_delete(struct re
=20
 static unsigned long pfn_first(struct dev_pagemap *pgmap)
 {
-	return (pgmap->res.start >> PAGE_SHIFT) +
+	return PHYS_PFN(pgmap->res.start) +
 		vmem_altmap_offset(pgmap_altmap(pgmap));
 }
=20
@@ -98,7 +98,6 @@ static void devm_memremap_pages_release(
 	struct dev_pagemap *pgmap =3D data;
 	struct device *dev =3D pgmap->dev;
 	struct resource *res =3D &pgmap->res;
-	resource_size_t align_start, align_size;
 	unsigned long pfn;
 	int nid;
=20
@@ -108,25 +107,21 @@ static void devm_memremap_pages_release(
 	dev_pagemap_cleanup(pgmap);
=20
 	/* pages are dead and unused, undo the arch mapping */
-	align_start =3D res->start & ~(SECTION_SIZE - 1);
-	align_size =3D ALIGN(res->start + resource_size(res), SECTION_SIZE)
-		- align_start;
-
-	nid =3D page_to_nid(pfn_to_page(align_start >> PAGE_SHIFT));
+	nid =3D page_to_nid(pfn_to_page(PHYS_PFN(res->start)));
=20
 	mem_hotplug_begin();
 	if (pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE) {
-		pfn =3D align_start >> PAGE_SHIFT;
+		pfn =3D PHYS_PFN(res->start);
 		__remove_pages(page_zone(pfn_to_page(pfn)), pfn,
-				align_size >> PAGE_SHIFT, NULL);
+				 PHYS_PFN(resource_size(res)), NULL);
 	} else {
-		arch_remove_memory(nid, align_start, align_size,
+		arch_remove_memory(nid, res->start, resource_size(res),
 				pgmap_altmap(pgmap));
-		kasan_remove_zero_shadow(__va(align_start), align_size);
+		kasan_remove_zero_shadow(__va(res->start), resource_size(res));
 	}
 	mem_hotplug_done();
=20
-	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
+	untrack_pfn(NULL, PHYS_PFN(res->start), resource_size(res));
 	pgmap_array_delete(res);
 	dev_WARN_ONCE(dev, pgmap->altmap.alloc,
 		      "%s: failed to free all reserved pages\n", __func__);
@@ -162,13 +157,12 @@ static void dev_pagemap_percpu_release(s
  */
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 {
-	resource_size_t align_start, align_size, align_end;
 	struct resource *res =3D &pgmap->res;
 	struct dev_pagemap *conflict_pgmap;
 	struct mhp_restrictions restrictions =3D {
 		/*
 		 * We do not want any optional features only our own memmap
-		*/
+		 */
 		.altmap =3D pgmap_altmap(pgmap),
 	};
 	pgprot_t pgprot =3D PAGE_KERNEL;
@@ -225,12 +219,7 @@ void *devm_memremap_pages(struct device
 			return ERR_PTR(error);
 	}
=20
-	align_start =3D res->start & ~(SECTION_SIZE - 1);
-	align_size =3D ALIGN(res->start + resource_size(res), SECTION_SIZE)
-		- align_start;
-	align_end =3D align_start + align_size - 1;
-
-	conflict_pgmap =3D get_dev_pagemap(PHYS_PFN(align_start), NULL);
+	conflict_pgmap =3D get_dev_pagemap(PHYS_PFN(res->start), NULL);
 	if (conflict_pgmap) {
 		dev_WARN(dev, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
@@ -238,7 +227,7 @@ void *devm_memremap_pages(struct device
 		goto err_array;
 	}
=20
-	conflict_pgmap =3D get_dev_pagemap(PHYS_PFN(align_end), NULL);
+	conflict_pgmap =3D get_dev_pagemap(PHYS_PFN(res->end), NULL);
 	if (conflict_pgmap) {
 		dev_WARN(dev, "Conflicting mapping in same section\n");
 		put_dev_pagemap(conflict_pgmap);
@@ -246,7 +235,7 @@ void *devm_memremap_pages(struct device
 		goto err_array;
 	}
=20
-	is_ram =3D region_intersects(align_start, align_size,
+	is_ram =3D region_intersects(res->start, resource_size(res),
 		IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
=20
 	if (is_ram !=3D REGION_DISJOINT) {
@@ -267,8 +256,8 @@ void *devm_memremap_pages(struct device
 	if (nid < 0)
 		nid =3D numa_mem_id();
=20
-	error =3D track_pfn_remap(NULL, &pgprot, PHYS_PFN(align_start), 0,
-			align_size);
+	error =3D track_pfn_remap(NULL, &pgprot, PHYS_PFN(res->start), 0,
+			resource_size(res));
 	if (error)
 		goto err_pfn_remap;
=20
@@ -286,16 +275,16 @@ void *devm_memremap_pages(struct device
 	 * arch_add_memory().
 	 */
 	if (pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE) {
-		error =3D add_pages(nid, align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, &restrictions);
+		error =3D add_pages(nid, PHYS_PFN(res->start),
+				PHYS_PFN(resource_size(res)), &restrictions);
 	} else {
-		error =3D kasan_add_zero_shadow(__va(align_start), align_size);
+		error =3D kasan_add_zero_shadow(__va(res->start), resource_size(res));
 		if (error) {
 			mem_hotplug_done();
 			goto err_kasan;
 		}
=20
-		error =3D arch_add_memory(nid, align_start, align_size,
+		error =3D arch_add_memory(nid, res->start, resource_size(res),
 					&restrictions);
 	}
=20
@@ -303,8 +292,8 @@ void *devm_memremap_pages(struct device
 		struct zone *zone;
=20
 		zone =3D &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
-		move_pfn_range_to_zone(zone, align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, pgmap_altmap(pgmap));
+		move_pfn_range_to_zone(zone, PHYS_PFN(res->start),
+				PHYS_PFN(resource_size(res)), restrictions.altmap);
 	}
=20
 	mem_hotplug_done();
@@ -316,8 +305,8 @@ void *devm_memremap_pages(struct device
 	 * to allow us to do the work while not holding the hotplug lock.
 	 */
 	memmap_init_zone_device(&NODE_DATA(nid)->node_zones[ZONE_DEVICE],
-				align_start >> PAGE_SHIFT,
-				align_size >> PAGE_SHIFT, pgmap);
+				PHYS_PFN(res->start),
+				PHYS_PFN(resource_size(res)), pgmap);
 	percpu_ref_get_many(pgmap->ref, pfn_end(pgmap) - pfn_first(pgmap));
=20
 	error =3D devm_add_action_or_reset(dev, devm_memremap_pages_release,
@@ -328,9 +317,9 @@ void *devm_memremap_pages(struct device
 	return __va(res->start);
=20
  err_add_memory:
-	kasan_remove_zero_shadow(__va(align_start), align_size);
+	kasan_remove_zero_shadow(__va(res->start), resource_size(res));
  err_kasan:
-	untrack_pfn(NULL, PHYS_PFN(align_start), align_size);
+	untrack_pfn(NULL, PHYS_PFN(res->start), resource_size(res));
  err_pfn_remap:
 	pgmap_array_delete(res);
  err_array:
_

