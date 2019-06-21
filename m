Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C9C48BE3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 05:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FE420665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 05:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WVg9EafK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfFUFnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 01:43:21 -0400
Received: from ozlabs.org ([203.11.71.1]:38949 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfFUFnV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 01:43:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45VSK11HTHz9s5c;
        Fri, 21 Jun 2019 15:43:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561095797;
        bh=OfLNpJ2uc2JmVNb9tH8U2cqr9Ecuo7xcTm/Vb1dr5H8=;
        h=Date:From:To:Cc:Subject:From;
        b=WVg9EafK6jG9AdMhaUvvaYqwCHhf8zlKAQ0LVAxH5WuER3FOxCaOHs4EQJqLQeRyd
         nTNyDYyw9xoR031ZfhCmlB0jA3giQWDgjYWZcFkOpCs8d+0lIWRE65bbOQV9EhIQrN
         HC9pzejOJIg8M1h9A+esBf4L18PYs/wN5xS8NxbMF0j7+bZCbHXZHg4ZiOcw85w099
         CIziBVefb+RioVTZVm4KNHETD1eucJ3EUzOMK2jL8I4Brw39x2Ryrc+BHIqYsYjodK
         tXUfTQFIEtZiyFbCo5XsyrDrnT7NPzhQmTdHjiLm45rpmwgkkgc07SFdHpH5AOq+lL
         YfEzK6Lf54JAw==
Date:   Fri, 21 Jun 2019 15:43:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: linux-next: manual merge of the kvms390 tree with Linus' tree
Message-ID: <20190621154315.0a4d5f54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/h+_WOTV7xAxJJvsyE3eXxS4"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/h+_WOTV7xAxJJvsyE3eXxS4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvms390 tree got a conflict in:

  tools/testing/selftests/kvm/Makefile

between commit:

  61cfcd545e42 ("kvm: tests: Sort tests in the Makefile alphabetically")

from Linus' tree and commits:

  ee1563f42856 ("KVM: selftests: Add the sync_regs test for s390x")
  49fe9a5d1638 ("KVM: selftests: Move kvm_create_max_vcpus test to generic =
code")

from the kvms390 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/kvm/Makefile
index 62afd0b43074,0d7265da1583..000000000000
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@@ -10,25 -10,29 +10,30 @@@ UNAME_M :=3D $(shell uname -m
  LIBKVM =3D lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/ucall.c lib=
/sparsebit.c
  LIBKVM_x86_64 =3D lib/x86_64/processor.c lib/x86_64/vmx.c
  LIBKVM_aarch64 =3D lib/aarch64/processor.c
+ LIBKVM_s390x =3D lib/s390x/processor.c
 =20
 -TEST_GEN_PROGS_x86_64 =3D x86_64/platform_info_test
 -TEST_GEN_PROGS_x86_64 +=3D x86_64/set_sregs_test
 -TEST_GEN_PROGS_x86_64 +=3D x86_64/sync_regs_test
 -TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_tsc_adjust_test
 -TEST_GEN_PROGS_x86_64 +=3D x86_64/cr4_cpuid_sync_test
 -TEST_GEN_PROGS_x86_64 +=3D x86_64/state_test
 +TEST_GEN_PROGS_x86_64 =3D x86_64/cr4_cpuid_sync_test
  TEST_GEN_PROGS_x86_64 +=3D x86_64/evmcs_test
  TEST_GEN_PROGS_x86_64 +=3D x86_64/hyperv_cpuid
- TEST_GEN_PROGS_x86_64 +=3D x86_64/kvm_create_max_vcpus
 -TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_close_while_nested_test
 +TEST_GEN_PROGS_x86_64 +=3D x86_64/mmio_warning_test
 +TEST_GEN_PROGS_x86_64 +=3D x86_64/platform_info_test
 +TEST_GEN_PROGS_x86_64 +=3D x86_64/set_sregs_test
  TEST_GEN_PROGS_x86_64 +=3D x86_64/smm_test
 +TEST_GEN_PROGS_x86_64 +=3D x86_64/state_test
 +TEST_GEN_PROGS_x86_64 +=3D x86_64/sync_regs_test
 +TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_close_while_nested_test
  TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_set_nested_state_test
 -TEST_GEN_PROGS_x86_64 +=3D kvm_create_max_vcpus
 -TEST_GEN_PROGS_x86_64 +=3D dirty_log_test
 +TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_tsc_adjust_test
  TEST_GEN_PROGS_x86_64 +=3D clear_dirty_log_test
 +TEST_GEN_PROGS_x86_64 +=3D dirty_log_test
++TEST_GEN_PROGS_x86_64 +=3D kvm_create_max_vcpus
 =20
 -TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
  TEST_GEN_PROGS_aarch64 +=3D clear_dirty_log_test
 +TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
+ TEST_GEN_PROGS_aarch64 +=3D kvm_create_max_vcpus
+=20
+ TEST_GEN_PROGS_s390x +=3D s390x/sync_regs_test
+ TEST_GEN_PROGS_s390x +=3D kvm_create_max_vcpus
 =20
  TEST_GEN_PROGS +=3D $(TEST_GEN_PROGS_$(UNAME_M))
  LIBKVM +=3D $(LIBKVM_$(UNAME_M))

--Sig_/h+_WOTV7xAxJJvsyE3eXxS4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0MbnMACgkQAVBC80lX
0Gy53Af+IvuY6eyfQRRB0rsegLHvOHxnQ1pOcGZSLv4DX6xwO/cHwlAnt2I6m9Ue
380yTzUn1isZVd4jyHmwaQdbG/MonlodGmrU4XBuRbDWrowdCSV7mWqAuVF3CI3t
G4s+z3iYSeTr/H7Cvvnk4LsjmgcdF7OqRC/6zUjL8/DEw2xgzxz4vNPaboJEKa28
Z+82KhNpVNxQrQ+XOK5anTnR+tmSZynEVX7/HESjSKU4cgn91qMCHKFz/NFD2z0S
Bv4jq1f83ojCR+ou7GdSJZivrpDZWr3Sja8yiDmQ4qseWoprosTnRwBYpSeA0O5N
kfNTnx/W20BjYzdni7EO18uDRNlDOg==
=v9PH
-----END PGP SIGNATURE-----

--Sig_/h+_WOTV7xAxJJvsyE3eXxS4--
