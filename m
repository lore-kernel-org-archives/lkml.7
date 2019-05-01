Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32886C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 11:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3AE92183E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 11:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VYFojUtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfEALLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 07:11:13 -0400
Received: from ozlabs.org ([203.11.71.1]:59579 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfEALLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 07:11:13 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vG0r3W7pz9sB8;
        Wed,  1 May 2019 21:11:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556709070;
        bh=lsMvESVyOeSnprDet45y/tXWUQqz+VKeCIWe4VhLqjE=;
        h=Date:From:To:Cc:Subject:From;
        b=VYFojUtqlOLIhUlUCI2X0uDSl5wBVgQ8/59Rew2+1j1xL/QWo8/k5+kqopZsj1v3I
         fWyGX3RQRchdkNox2WzdvYv+qKcg2IFUD71yI6njvWFmXl/XCeY0mN9HeN4cUmhmm+
         UciuEUT2vMXFa5fU3tPxUYSC4TonrUFdm2csBwNbIwkibLrSgm3Eq8/Z/0cFGfXdRs
         48aJKYAd70+L2RS6rAQr8C2X8CP+iE0fE0KjqUjrzqCX/xV9hhApP/iHdRgjK7uypd
         vQCGrZ2h4y13+4Z2Yy9x3gefnJryegz95QyppxxJSBrWADBqqKDLFPAT7D94r8LuSe
         uZW/WkU9Be14g==
Date:   Wed, 1 May 2019 21:10:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>
Subject: linux-next: manual merge of the akpm-current tree with the tip tree
Message-ID: <20190501211031.1f0eb5a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/QxL+bWKEAp1VX8+Fdfr48cU"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QxL+bWKEAp1VX8+Fdfr48cU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/vmalloc.c

between commit:

  bade3b4bdcdb ("mm/vmalloc.c: refactor __vunmap() to avoid duplicated call=
 to find_vm_area()")

from the tip tree and commit:

  868b104d7379 ("mm/vmalloc: Add flag for freeing of special permsissions")

from the akpm-current tree.

I fixed it up (I made an attempt ta a fix up - see below) and can carry
the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/vmalloc.c
index e5e9e1fcac01,4a91acce4b5f..000000000000
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@@ -1490,94 -2103,16 +2110,83 @@@ static struct vm_struct *__remove_vm_ar
   */
  struct vm_struct *remove_vm_area(const void *addr)
  {
+ 	struct vm_struct *vm =3D NULL;
  	struct vmap_area *va;
 =20
- 	might_sleep();
-=20
  	va =3D find_vmap_area((unsigned long)addr);
- 	if (va && va->flags & VM_VM_AREA) {
- 		struct vm_struct *vm =3D va->vm;
-=20
- 		spin_lock(&vmap_area_lock);
- 		va->vm =3D NULL;
- 		va->flags &=3D ~VM_VM_AREA;
- 		va->flags |=3D VM_LAZY_FREE;
- 		spin_unlock(&vmap_area_lock);
-=20
- 		kasan_free_shadow(vm);
- 		free_unmap_vmap_area(va);
+ 	if (va && va->flags & VM_VM_AREA)
+ 		vm =3D __remove_vm_area(va);
 =20
- 		return vm;
- 	}
- 	return NULL;
+ 	return vm;
  }
 =20
 +static inline void set_area_direct_map(const struct vm_struct *area,
 +				       int (*set_direct_map)(struct page *page))
 +{
 +	int i;
 +
 +	for (i =3D 0; i < area->nr_pages; i++)
 +		if (page_address(area->pages[i]))
 +			set_direct_map(area->pages[i]);
 +}
 +
 +/* Handle removing and resetting vm mappings related to the vm_struct. */
- static void vm_remove_mappings(struct vm_struct *area, int deallocate_pag=
es)
++static void vm_remove_mappings(struct vmap_area *va, int deallocate_pages)
 +{
++	struct vm_struct *area =3D va->vm;
 +	unsigned long addr =3D (unsigned long)area->addr;
 +	unsigned long start =3D ULONG_MAX, end =3D 0;
 +	int flush_reset =3D area->flags & VM_FLUSH_RESET_PERMS;
 +	int i;
 +
 +	/*
 +	 * The below block can be removed when all architectures that have
 +	 * direct map permissions also have set_direct_map_() implementations.
 +	 * This is concerned with resetting the direct map any an vm alias with
 +	 * execute permissions, without leaving a RW+X window.
 +	 */
 +	if (flush_reset && !IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
 +		set_memory_nx(addr, area->nr_pages);
 +		set_memory_rw(addr, area->nr_pages);
 +	}
 +
- 	remove_vm_area(area->addr);
++	__remove_vm_area(va);
 +
 +	/* If this is not VM_FLUSH_RESET_PERMS memory, no need for the below. */
 +	if (!flush_reset)
 +		return;
 +
 +	/*
 +	 * If not deallocating pages, just do the flush of the VM area and
 +	 * return.
 +	 */
 +	if (!deallocate_pages) {
 +		vm_unmap_aliases();
 +		return;
 +	}
 +
 +	/*
 +	 * If execution gets here, flush the vm mapping and reset the direct
 +	 * map. Find the start and end range of the direct mappings to make sure
 +	 * the vm_unmap_aliases() flush includes the direct map.
 +	 */
 +	for (i =3D 0; i < area->nr_pages; i++) {
 +		if (page_address(area->pages[i])) {
 +			start =3D min(addr, start);
 +			end =3D max(addr, end);
 +		}
 +	}
 +
 +	/*
 +	 * Set direct map to something invalid so that it won't be cached if
 +	 * there are any accesses after the TLB flush, then flush the TLB and
 +	 * reset the direct map permissions to the default.
 +	 */
 +	set_area_direct_map(area, set_direct_map_invalid_noflush);
 +	_vm_unmap_aliases(start, end, 1);
 +	set_area_direct_map(area, set_direct_map_default_noflush);
 +}
 +
  static void __vunmap(const void *addr, int deallocate_pages)
  {
  	struct vm_struct *area;
@@@ -1599,8 -2136,7 +2210,8 @@@
  	debug_check_no_locks_freed(area->addr, get_vm_area_size(area));
  	debug_check_no_obj_freed(area->addr, get_vm_area_size(area));
 =20
- 	vm_remove_mappings(area, deallocate_pages);
 -	__remove_vm_area(va);
++	vm_remove_mappings(va, deallocate_pages);
 +
  	if (deallocate_pages) {
  		int i;
 =20

--Sig_/QxL+bWKEAp1VX8+Fdfr48cU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzJfqcACgkQAVBC80lX
0Gywpgf/fkQGSKG68XdL83eMJERncTj8Pr1TQpGxQtR5nqMxC+D9Uy1cjCerDgGA
3xYP7bVzBpH7amGWi3Bh2kHgfo6VzdL3u88CrC6LnpfgMozy+9QvZb1GV/BzWI9E
8jLk6t06oI8ZVvxH+8Zabk+KQ2DUkrKVBC90/m9q+TGfaBajMM11qkAwM+t9RWju
nyZ1Az4U/b9Gmg7NLBulwXH81LMTFKMGhp9/DUVhgRkSBi0anWLLRRsAW72RvdnS
0C1YHyqMYipNBbHZDOcr1I7ZRa6KdHtdoyPNoxuKeoteeGOtr8QqWlxeEgTeJfOn
ukA7aU8GKGV9fyl1tchV86kZ3UELkA==
=X3ak
-----END PGP SIGNATURE-----

--Sig_/QxL+bWKEAp1VX8+Fdfr48cU--
