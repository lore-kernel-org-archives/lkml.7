Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AECDC43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65F120675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="RucAGgmO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfDYVhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:37:14 -0400
Received: from ozlabs.org ([203.11.71.1]:46817 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfDYVhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:37:14 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44qr9z3BhDz9s00;
        Fri, 26 Apr 2019 07:37:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556228231;
        bh=eI0mQoy/UHVM3LOzKKqhuAzOw3IoQFx3YRZbn8I+BhU=;
        h=Date:From:To:Cc:Subject:From;
        b=RucAGgmOZgz1ShSWDTk2Scad7i+eVJTbyYZnRVZql9NXtny6fgHIgydrXAyXX1S2A
         Nsdk/pflA1EO/l8JnaI+hds5CVJsC+yWHe3QSOEP0liRzKV175jya0Rl2HfX+Sluct
         bCOJY8yKNiICcY1rz83hrB5mPOLBOQ66JzLBppCcUj8qCYz1xGWUg1/VB+dzPqOE2m
         hH90L8IuZMDXtvBq5HksZIZcLMYIzg53A9+NrmclL47AUwpWhA05soQc5Ne9wDlmZl
         OnZHXkK1lEbgq/tpKnSXfDkgBdzesH1veVcY3wxga9aUoPW2HeYct0CibkClezw/V0
         Gq80jzBMaBtow==
Date:   Fri, 26 Apr 2019 07:37:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: linux-next: manual merge of the rdma-fixes tree with Linus' tree
Message-ID: <20190426073709.77e7b0bb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2ThAo/GKnTkTAEoqNWTyG/4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2ThAo/GKnTkTAEoqNWTyG/4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rdma-fixes tree got a conflict in:

  drivers/infiniband/core/uverbs_main.c

between commit:

  04f5866e41fb ("coredump: fix race condition between mmget_not_zero()/get_=
task_mm() and core dumping")

from Linus' tree and commit:

  67f269b37f9b ("RDMA/ucontext: Fix regression with disassociate")

from the rdma-fixes tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/infiniband/core/uverbs_main.c
index f2e7ffe6fc54,db20b6e0f253..000000000000
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@@ -992,9 -1039,7 +1039,9 @@@ void uverbs_user_mmap_disassociate(stru
  		 * at a time to get the lock ordering right. Typically there
  		 * will only be one mm, so no big deal.
  		 */
- 		down_write(&mm->mmap_sem);
+ 		down_read(&mm->mmap_sem);
 +		if (!mmget_still_valid(mm))
 +			goto skip_mm;
  		mutex_lock(&ufile->umap_lock);
  		list_for_each_entry_safe (priv, next_priv, &ufile->umaps,
  					  list) {
@@@ -1006,11 -1051,9 +1053,10 @@@
 =20
  			zap_vma_ptes(vma, vma->vm_start,
  				     vma->vm_end - vma->vm_start);
- 			vma->vm_flags &=3D ~(VM_SHARED | VM_MAYSHARE);
  		}
  		mutex_unlock(&ufile->umap_lock);
 +	skip_mm:
- 		up_write(&mm->mmap_sem);
+ 		up_read(&mm->mmap_sem);
  		mmput(mm);
  	}
  }

--Sig_/2ThAo/GKnTkTAEoqNWTyG/4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzCKIUACgkQAVBC80lX
0GwHVwf/ZrNV36PBAapIgDy+mi4MTqKAXXdl8vobgt+TdpXfF5AUNsZyvhNh32HO
yZRVITnyaZx5fofjehE566jxz2nI6x56RXT031szgbVGnbtIViJpSLrTfHutqyTJ
KiBvMiuaXYk+ELfqA6WML4qV+nh+Zne4fxjUckj0Inj4sOTQk8t0j+S/pAmmKMLO
GXwX/Speum6UGykYDBzuNdMGDeYDyGcrWF3bWhhvu0PW207rjsft6Ds4EuNGgvws
GzEQkylx9Y7O5avetSIF6vH2jOhSISWYaw1a2mdMqf/Gzu9f97ziURB6u6+v0BUk
mKo2TpnH18Hacsr94okzQ0xXtT4sJw==
=dKKb
-----END PGP SIGNATURE-----

--Sig_/2ThAo/GKnTkTAEoqNWTyG/4--
