Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9009BC47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6782721D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rHSq/xld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389577AbfJYBzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 21:55:00 -0400
Received: from ozlabs.org ([203.11.71.1]:39295 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389488AbfJYBy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:54:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46znHK2bcBz9sP3;
        Fri, 25 Oct 2019 12:54:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571968493;
        bh=7C+Sf4WcmsYMuwrmETgFQmmDGqQheurLBFa+StuqxPg=;
        h=Date:From:To:Cc:Subject:From;
        b=rHSq/xldZ2Ia1Ech2xZeEfzwY2F8dj0M6TCPtPrHcuUHpRyPvxiqpGn0e/pS/wG34
         IFKmqbfIXfio3vs/ry0EZ0NK/gUkZRs+FX2HDTXbn3oy4S1IJnby/MMo75lGAz9pUQ
         dC3pZu+po47WyqPVvb+9GeF45EwpehhDBnIu5I9r0v8iMB+Jy8gtmK14tyhzU3sZ3Q
         0yx40B71AAoHweOlQSGk4wTAflEyqVdxV4H19AJixQ5YSDMyUeOLs8BJcZ0FxcCgtH
         jn/z+qKh+tCSjxgK3D9Zb7LfoqzC5PG0zaGBbBAlZFf8HeFddFeZXZaxse1/WHCgRR
         NmgXBAMvezemw==
Date:   Fri, 25 Oct 2019 12:54:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Mackerras <paulus@ozlabs.org>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Subject: linux-next: manual merge of the kvm-ppc tree with the kvm-arm tree
Message-ID: <20191025125436.6c85dbfe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lu9GUO+j=WtsnYS2MNTu8l1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lu9GUO+j=WtsnYS2MNTu8l1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-ppc tree got a conflict in:

  include/uapi/linux/kvm.h

between commits:

  c726200dd106 ("KVM: arm/arm64: Allow reporting non-ISV data aborts to use=
rspace")
  da345174ceca ("KVM: arm/arm64: Allow user injection of external data abor=
ts")

from the kvm-arm tree and commit:

  1a9167a214f5 ("KVM: PPC: Report single stepping capability")

from the kvm-ppc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/uapi/linux/kvm.h
index fb47c0fad6a6,ce8cfcc51aec..000000000000
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@@ -1006,8 -1000,7 +1006,9 @@@ struct kvm_ppc_resize_hpt=20
  #define KVM_CAP_PMU_EVENT_FILTER 173
  #define KVM_CAP_ARM_IRQ_LINE_LAYOUT_2 174
  #define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 175
 -#define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 176
 +#define KVM_CAP_ARM_NISV_TO_USER 176
 +#define KVM_CAP_ARM_INJECT_EXT_DABT 177
++#define KVM_CAP_PPC_GUEST_DEBUG_SSTEP 178
 =20
  #ifdef KVM_CAP_IRQ_ROUTING
 =20

--Sig_/lu9GUO+j=WtsnYS2MNTu8l1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2yVdwACgkQAVBC80lX
0GzfRQf/XFMevKgAPuDxOa1oqp6QHRCAz1NSh0thOKzWRSs0pGS0uDn9MTvNh0pb
mJEUL4zXCCfa2SSyQ+EdAefRynEQII1PHBDJ61oJPL83DwOmT5GijyAO4QER+1qq
iFWwXyJtaPlfzryKaBcRs+NN55/NG5QGgLpTN+ZucCOajUxQ3xmpPmrWntwnGyLI
HDll15BjirDyFYH4O+r8DSt64D1h8veFzD69BY9ijTCojjsEKFB/OppVG3hl9vXa
K8aWUbw5OIQXkkoM1km6djDqhfMUGcF9OE1lZTDjEfMygUW7fq23dX2cM7vABZwn
JUxfgHtEuSP5vUt/8p6pxZht481ynA==
=KYH1
-----END PGP SIGNATURE-----

--Sig_/lu9GUO+j=WtsnYS2MNTu8l1--
