Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B77C06517
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BE62189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 10:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="E9savyrj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfGDKhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:37:05 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:56923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfGDKhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 06:37:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fZCw6Dtpz9s8m;
        Thu,  4 Jul 2019 20:37:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562236621;
        bh=whC3mB0E8R6xCRLqcYTosbnTYER6oX7bS7Yn/9Co2Es=;
        h=Date:From:To:Cc:Subject:From;
        b=E9savyrjQ51/6cKIpM0OyaoiG6EaOqeL9jkuqgaPCm/BMBEdPkQs1sfTSB6p7Ujfz
         /JQUHP49xRgBpdeTYLTvanPooxrIvMAFpfmY94FrOpcrPyCdXlodCjoSpvenv/XEWm
         /A98qWE9bhV3KzvCVa9by6oGtHgj+KdQqhOs8eI56lmgk2RbTZ9o4v9Ix3rzBFLlb6
         tgS0T2pwobjFnBZNymwxhsbH/C2bU6sQ8TNwEMUad1CkaMGazFEerTvGE1esKad0n6
         HSZk07FV8sG4U2oPPfFBhdPknHl2ICwWuhKkR5uEu1gcP7x4wbqjhqVx1oK2lE/JK9
         4KpmZ0A6AFJrw==
Date:   Thu, 4 Jul 2019 20:36:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the akpm-current tree with the hmm tree
Message-ID: <20190704203658.1d26d182@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/oAm8jCFy=m18mDYbv_b1D/6"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oAm8jCFy=m18mDYbv_b1D/6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  kernel/memremap.c

between commit:

  514caf23a70f ("memremap: replace the altmap_valid field with a PGMAP_ALTM=
AP_VALID flag")

from the hmm tree and commit:

  a10a0f39cae6 ("mm/devm_memremap_pages: enable sub-section remap")

from the akpm-current tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc kernel/memremap.c
index bea6f887adad,a0e5f6b91b04..000000000000
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@@ -11,39 -11,39 +11,37 @@@
  #include <linux/types.h>
  #include <linux/wait_bit.h>
  #include <linux/xarray.h>
 -#include <linux/hmm.h>
 =20
  static DEFINE_XARRAY(pgmap_array);
- #define SECTION_MASK ~((1UL << PA_SECTION_SHIFT) - 1)
- #define SECTION_SIZE (1UL << PA_SECTION_SHIFT)
 =20
 -#if IS_ENABLED(CONFIG_DEVICE_PRIVATE)
 -vm_fault_t device_private_entry_fault(struct vm_area_struct *vma,
 -		       unsigned long addr,
 -		       swp_entry_t entry,
 -		       unsigned int flags,
 -		       pmd_t *pmdp)
 +#ifdef CONFIG_DEV_PAGEMAP_OPS
 +DEFINE_STATIC_KEY_FALSE(devmap_managed_key);
 +EXPORT_SYMBOL(devmap_managed_key);
 +static atomic_t devmap_managed_enable;
 +
 +static void devmap_managed_enable_put(void *data)
  {
 -	struct page *page =3D device_private_entry_to_page(entry);
 -	struct hmm_devmem *devmem;
 +	if (atomic_dec_and_test(&devmap_managed_enable))
 +		static_branch_disable(&devmap_managed_key);
 +}
 =20
 -	devmem =3D container_of(page->pgmap, typeof(*devmem), pagemap);
 +static int devmap_managed_enable_get(struct device *dev, struct dev_pagem=
ap *pgmap)
 +{
 +	if (!pgmap->ops || !pgmap->ops->page_free) {
 +		WARN(1, "Missing page_free method\n");
 +		return -EINVAL;
 +	}
 =20
 -	/*
 -	 * The page_fault() callback must migrate page back to system memory
 -	 * so that CPU can access it. This might fail for various reasons
 -	 * (device issue, device was unsafely unplugged, ...). When such
 -	 * error conditions happen, the callback must return VM_FAULT_SIGBUS.
 -	 *
 -	 * Note that because memory cgroup charges are accounted to the device
 -	 * memory, this should never fail because of memory restrictions (but
 -	 * allocation of regular system page might still fail because we are
 -	 * out of memory).
 -	 *
 -	 * There is a more in-depth description of what that callback can and
 -	 * cannot do, in include/linux/memremap.h
 -	 */
 -	return devmem->page_fault(vma, addr, page, flags, pmdp);
 +	if (atomic_inc_return(&devmap_managed_enable) =3D=3D 1)
 +		static_branch_enable(&devmap_managed_key);
 +	return devm_add_action_or_reset(dev, devmap_managed_enable_put, NULL);
  }
 -#endif /* CONFIG_DEVICE_PRIVATE */
 +#else
 +static int devmap_managed_enable_get(struct device *dev, struct dev_pagem=
ap *pgmap)
 +{
 +	return -EINVAL;
 +}
 +#endif /* CONFIG_DEV_PAGEMAP_OPS */
 =20
  static void pgmap_array_delete(struct resource *res)
  {
@@@ -54,8 -54,14 +52,8 @@@
 =20
  static unsigned long pfn_first(struct dev_pagemap *pgmap)
  {
- 	return (pgmap->res.start >> PAGE_SHIFT) +
 -	const struct resource *res =3D &pgmap->res;
 -	struct vmem_altmap *altmap =3D &pgmap->altmap;
 -	unsigned long pfn;
 -
 -	pfn =3D PHYS_PFN(res->start);
 -	if (pgmap->altmap_valid)
 -		pfn +=3D vmem_altmap_offset(altmap);
 -	return pfn;
++	return (PHYS_PFN(pgmap->res.start)) +
 +		vmem_altmap_offset(pgmap_altmap(pgmap));
  }
 =20
  static unsigned long pfn_end(struct dev_pagemap *pgmap)
@@@ -101,28 -89,23 +99,23 @@@ static void devm_memremap_pages_release
  	unsigned long pfn;
  	int nid;
 =20
 -	pgmap->kill(pgmap->ref);
 +	dev_pagemap_kill(pgmap);
  	for_each_device_pfn(pfn, pgmap)
  		put_page(pfn_to_page(pfn));
 -	pgmap->cleanup(pgmap->ref);
 +	dev_pagemap_cleanup(pgmap);
 =20
  	/* pages are dead and unused, undo the arch mapping */
- 	align_start =3D res->start & ~(SECTION_SIZE - 1);
- 	align_size =3D ALIGN(res->start + resource_size(res), SECTION_SIZE)
- 		- align_start;
-=20
- 	nid =3D page_to_nid(pfn_to_page(align_start >> PAGE_SHIFT));
+ 	nid =3D page_to_nid(pfn_to_page(PHYS_PFN(res->start)));
 =20
  	mem_hotplug_begin();
  	if (pgmap->type =3D=3D MEMORY_DEVICE_PRIVATE) {
- 		pfn =3D align_start >> PAGE_SHIFT;
+ 		pfn =3D PHYS_PFN(res->start);
  		__remove_pages(page_zone(pfn_to_page(pfn)), pfn,
- 				align_size >> PAGE_SHIFT, NULL);
+ 				PHYS_PFN(resource_size(res)), NULL);
  	} else {
- 		arch_remove_memory(nid, align_start, align_size,
+ 		arch_remove_memory(nid, res->start, resource_size(res),
 -				pgmap->altmap_valid ? &pgmap->altmap : NULL);
 +				pgmap_altmap(pgmap));
- 		kasan_remove_zero_shadow(__va(align_start), align_size);
+ 		kasan_remove_zero_shadow(__va(res->start), resource_size(res));
  	}
  	mem_hotplug_done();
 =20
@@@ -173,64 -146,13 +165,59 @@@ void *devm_memremap_pages(struct devic
  	};
  	pgprot_t pgprot =3D PAGE_KERNEL;
  	int error, nid, is_ram;
 +	bool need_devmap_managed =3D true;
 +
 +	switch (pgmap->type) {
 +	case MEMORY_DEVICE_PRIVATE:
 +		if (!IS_ENABLED(CONFIG_DEVICE_PRIVATE)) {
 +			WARN(1, "Device private memory not supported\n");
 +			return ERR_PTR(-EINVAL);
 +		}
 +		if (!pgmap->ops || !pgmap->ops->migrate_to_ram) {
 +			WARN(1, "Missing migrate_to_ram method\n");
 +			return ERR_PTR(-EINVAL);
 +		}
 +		break;
 +	case MEMORY_DEVICE_FS_DAX:
 +		if (!IS_ENABLED(CONFIG_ZONE_DEVICE) ||
 +		    IS_ENABLED(CONFIG_FS_DAX_LIMITED)) {
 +			WARN(1, "File system DAX not supported\n");
 +			return ERR_PTR(-EINVAL);
 +		}
 +		break;
 +	case MEMORY_DEVICE_DEVDAX:
 +	case MEMORY_DEVICE_PCI_P2PDMA:
 +		need_devmap_managed =3D false;
 +		break;
 +	default:
 +		WARN(1, "Invalid pgmap type %d\n", pgmap->type);
 +		break;
 +	}
 +
 +	if (!pgmap->ref) {
 +		if (pgmap->ops && (pgmap->ops->kill || pgmap->ops->cleanup))
 +			return ERR_PTR(-EINVAL);
 +
 +		init_completion(&pgmap->done);
 +		error =3D percpu_ref_init(&pgmap->internal_ref,
 +				dev_pagemap_percpu_release, 0, GFP_KERNEL);
 +		if (error)
 +			return ERR_PTR(error);
 +		pgmap->ref =3D &pgmap->internal_ref;
 +	} else {
 +		if (!pgmap->ops || !pgmap->ops->kill || !pgmap->ops->cleanup) {
 +			WARN(1, "Missing reference count teardown definition\n");
 +			return ERR_PTR(-EINVAL);
 +		}
 +	}
 =20
 -	if (!pgmap->ref || !pgmap->kill || !pgmap->cleanup) {
 -		WARN(1, "Missing reference count teardown definition\n");
 -		return ERR_PTR(-EINVAL);
 +	if (need_devmap_managed) {
 +		error =3D devmap_managed_enable_get(dev, pgmap);
 +		if (error)
 +			return ERR_PTR(error);
  	}
 =20
- 	align_start =3D res->start & ~(SECTION_SIZE - 1);
- 	align_size =3D ALIGN(res->start + resource_size(res), SECTION_SIZE)
- 		- align_start;
- 	align_end =3D align_start + align_size - 1;
-=20
- 	conflict_pgmap =3D get_dev_pagemap(PHYS_PFN(align_start), NULL);
+ 	conflict_pgmap =3D get_dev_pagemap(PHYS_PFN(res->start), NULL);
  	if (conflict_pgmap) {
  		dev_WARN(dev, "Conflicting mapping in same section\n");
  		put_dev_pagemap(conflict_pgmap);

--Sig_/oAm8jCFy=m18mDYbv_b1D/6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0d1soACgkQAVBC80lX
0Gyxjgf+LBFAMMUjS+UNbtw3lUuoI4DnEVhgDHevjPiJPmrYuuQYMSQlsC5iBuAH
8/iPWCxOdHhTQZq4QZmx303bPEAevCxLtGFYF2Q7Xb8/Kj0NeOzGYcUBL1DVLMRM
YDa7ERRMt9hjPqeE/ujwDufvUyUtdmMcCUFs82tPK2aXgcfRD307isgriJWERSjH
XHrEjZl/0yqBs5r/vehkCUpCJt8Nx572kHTkowFHCoOJwjdiAPWFmS+die86GapM
5bEGmPp9eFp+YBrCttkPBOesPSh9q37jk0hQ8rdsifF9lA1sw4BGTKG+l4voYGWd
diuYSaG1jRv/o48+dutgo7A84xuEpA==
=9DM8
-----END PGP SIGNATURE-----

--Sig_/oAm8jCFy=m18mDYbv_b1D/6--
