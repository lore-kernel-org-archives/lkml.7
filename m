Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2084C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A60B20854
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 06:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kzRbNUNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfCAGG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 01:06:28 -0500
Received: from ozlabs.org ([203.11.71.1]:33759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfCAGG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 01:06:27 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 449f7L6zKxz9s70;
        Fri,  1 Mar 2019 17:06:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551420384;
        bh=3N95lfmdbZZWp/pw26uI/KN5qrOsXzDaA/SgoCd2FXA=;
        h=Date:From:To:Cc:Subject:From;
        b=kzRbNUNuDjdMfVWiiGeYnQ3OFb1p5B3JLSp+y5CpgxNHW30vzJMC8PS+e/Sn/0JA1
         yaJdlXMXxS6bVan8+ka9/szwDyOdcyym2jVGUdKSU95E0dwDNwmadq9wD48+ebBhsV
         jw4Mk3ycH9POPsHz8fy03GNGcFD/Y9B1ezTJftSvUEbTMXB/syv4NFjrsJ3wUUZDgW
         HAr5McE80sVoEySQTd0/TqG87roTTDHOItXGWA9wf17AM8nvJwLpIzeeWoOIPnwbS9
         Iaf7Fk1gVQfQZRO3iKs7QcEcB0MUYd4FFWHzSAu0ClqxaRoyekVhDdmRR+ZB3IDgrn
         yai8CIBxu9CMw==
Date:   Fri, 1 Mar 2019 17:06:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Xen Devel <Xen-devel@lists.xensource.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: linux-next: manual merge of the nvdimm tree with the xen-tip tree
Message-ID: <20190301170622.6547961e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/VOyMZKpg9/519naT73GnYsI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VOyMZKpg9/519naT73GnYsI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[Thanks, Dan for the heads up and resolution.]

Today's linux-next merge of the nvdimm tree got a conflict in:

  mm/memory_hotplug.c

between commit:

  357b4da50a62 ("x86: respect memory size limiting via mem=3D parameter")

from the xen-tip tree and commit:

  2794129e902d ("mm/memory-hotplug: Allow memory resources to be children")

from the nvdimm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/memory_hotplug.c
index 1f678568ce5c,d2c44146473f..b96a3121b5e9
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@@ -101,28 -99,21 +101,24 @@@ u64 max_mem_size =3D U64_MAX
  /* add this memory to iomem resource */
  static struct resource *register_memory_resource(u64 start, u64 size)
  {
- 	struct resource *res, *conflict;
+ 	struct resource *res;
+ 	unsigned long flags =3D  IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+ 	char *resource_name =3D "System RAM";
 =20
 +	if (start + size > max_mem_size)
 +		return ERR_PTR(-E2BIG);
 +
- 	res =3D kzalloc(sizeof(struct resource), GFP_KERNEL);
- 	if (!res)
- 		return ERR_PTR(-ENOMEM);
-=20
- 	res->name =3D "System RAM";
- 	res->start =3D start;
- 	res->end =3D start + size - 1;
- 	res->flags =3D IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
- 	conflict =3D  request_resource_conflict(&iomem_resource, res);
- 	if (conflict) {
- 		if (conflict->desc =3D=3D IORES_DESC_DEVICE_PRIVATE_MEMORY) {
- 			pr_debug("Device unaddressable memory block "
- 				 "memory hotplug at %#010llx !\n",
- 				 (unsigned long long)start);
- 		}
- 		pr_debug("System RAM resource %pR cannot be added\n", res);
- 		kfree(res);
+ 	/*
+ 	 * Request ownership of the new memory range.  This might be
+ 	 * a child of an existing resource that was present but
+ 	 * not marked as busy.
+ 	 */
+ 	res =3D __request_region(&iomem_resource, start, size,
+ 			       resource_name, flags);
+=20
+ 	if (!res) {
+ 		pr_debug("Unable to reserve System RAM region: %016llx->%016llx\n",
+ 				start, start + size);
  		return ERR_PTR(-EEXIST);
  	}
  	return res;

--Sig_/VOyMZKpg9/519naT73GnYsI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx4y94ACgkQAVBC80lX
0GzieggAmiLoxygKDBJOg/eZMsP5iMc1q6sHmFialsNHFfKQjfEfXWPW5lGTWL7J
8ze2HzK2kUFBQRUysmk8v9AviXw0zxBW9OeS+0ruzczImdYDiNQkrdi97KzuEDsH
heVLTV7tUevV5+z83sYdPCFxQ1mTCcndLcbsXsl7QUlJg6mql6HNt4soSIhe9c/Q
XWvDAq+ADYkGt9NbwslcPGb3agaiganxSh62FjrVSfKuNTlmU5kSmjX5Ee5vIOjt
bbqwWh8peYkxW0jud4W77hwF4n3/cK9RGB4wY7Q6QVoVgB7Sev427bUK5eFSxhs3
sIopJXg+8EgeLY6cBfftJYXBdgAxWA==
=1QDT
-----END PGP SIGNATURE-----

--Sig_/VOyMZKpg9/519naT73GnYsI--
