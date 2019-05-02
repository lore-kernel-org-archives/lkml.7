Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA559C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A758D20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="h+18VXzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfEBJLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:11:24 -0400
Received: from ozlabs.org ([203.11.71.1]:45765 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfEBJLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:11:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44vqJ92hbXz9sBb;
        Thu,  2 May 2019 19:11:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556788281;
        bh=6yw6lFiL2VJdps6TUQAjMUxeS1o//YaEA61Fispl6yw=;
        h=Date:From:To:Cc:Subject:From;
        b=h+18VXzDeCsQTC1hTs3/s4lOd1kkFj+AsJAxO3QXn6+N5NYM5QVAo/B8oGMPByHLr
         H89/V36nhCQ6a9LqmF1HSoQ/ghYHjHr/jg5+ZSdinPV2xyttgwVePQXmfr+VRW3v6i
         C4uRq9illkwppZyJLLd1pL7HIA8foMl9W4hwP+z338aQhdK0L8IcM4ZjCZDdJw/HRD
         fVYroZKBwVJT7CpKqhGrjDKJr/P+q6QFf2M8SE6AXSJlnsHOT8xAB2mH5CuDAE3uVb
         DIzMpaOryuFZHZknjq9D/9K9BoPav/VVJmUecR8iJFv3rGhtU1Uy6l+61OjbP9TjfW
         nV2aWHhXZPAaA==
Date:   Thu, 2 May 2019 19:11:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Helge Deller <deller@gmx.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: linux-next: manual merge of the akpm-current tree with the
 parisc-hd tree
Message-ID: <20190502191119.2707499f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/BsfIab0PZhRmkZAhb4BTTxp"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BsfIab0PZhRmkZAhb4BTTxp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  arch/parisc/mm/init.c

between commit:

  1fb55c4cf4e6 ("parisc: Enable SPARSEMEM_VMEMMAP")

from the parisc-hd tree and commit:

  2e5adbd9e97a ("initramfs: provide a generic free_initrd_mem implementatio=
n")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/parisc/mm/init.c
index 6d29eb22d460,437d4c35c562..000000000000
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@@ -927,18 -921,3 +927,11 @@@ void flush_tlb_all(void
  	spin_unlock(&sid_lock);
  }
  #endif
 +
- #ifdef CONFIG_BLK_DEV_INITRD
- void free_initrd_mem(unsigned long start, unsigned long end)
- {
- 	free_reserved_area((void *)start, (void *)end, -1, "initrd");
- }
- #endif
-=20
 +#if defined(CONFIG_SPARSEMEM_VMEMMAP)
 +int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
 +			       int node, struct vmem_altmap *altmap)
 +{
 +	return vmemmap_populate_basepages(vstart, vend, node);
 +}
 +#endif

--Sig_/BsfIab0PZhRmkZAhb4BTTxp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzKtDcACgkQAVBC80lX
0GxBzQf/aVRtbemK5KkZpF1uc7l8rw8TQAKfmSjJAb2MNgsCw61ZhPWpBE2mThNo
BxUOofS2A0ykz34jPLM5RsmctAgYqcKNzx8+ErzQcZYOcB3GmIxNrUiFB+wFhcGa
X1r5FAO/tkqR64pi96LwLA0Ny6vmfFvZjTsW4W8ha/33X9rdMde/4rQu16ASbIuz
+fIM9qjeJkB9WFQ5D+R7L7tlyEwiGCNoD86Pq5FMkMB8LwN2kYmxKs/gfCyWOgdN
KZJFAZ5TLS3/QuhwPOMVx9ktXm6yL2CnrBRtJSOfuEJP7Gi046hZdMWG4AWjbsLm
iN2ZhM//dRFcwxLqENi2JfIuOQ2wVw==
=md76
-----END PGP SIGNATURE-----

--Sig_/BsfIab0PZhRmkZAhb4BTTxp--
