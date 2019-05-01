Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE6AC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B083F21743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 06:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="qK+FMgQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbfEAGJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 02:09:07 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52863 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfEAGJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 02:09:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44v7JG5TRZz9s6w;
        Wed,  1 May 2019 16:09:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1556690943;
        bh=3b0DkrHkXlAr8QKukhNQ6kXKpjlnpsw2Vo0MhoqCt1E=;
        h=Date:From:To:Cc:Subject:From;
        b=qK+FMgQQpXPm5QXT1eCHYA9RRqST9+5Sx2IxXQqn36toz00nK72IGgnRk6CY0qxf6
         2lCs9Y0TeY4dT3ut2nkvB93PYeVEdGAYWKNIYl43SPKXfTzLbow8IV1MwsPPr9HOGK
         YIUrckBu5QHy7NPdxTEotuzmH357RbBYoAuDx9XpAwIdRgA4v+C3sdfjX5fOdT9izi
         6qS5G1iVGb7Z30VouXlywoD1R8RHop6xiWH/nCiaWn3X6E7RThws84p/wLiEcsIJvQ
         GBV/k+grNiSzotXZlrX0ujmT4KQACqrPYbE7T4zc144+64A4/bXWuGa9I0I1Ay5yby
         GfXswR02ahwig==
Date:   Wed, 1 May 2019 16:09:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Mackerras <paulus@ozlabs.org>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: linux-next: manual merge of the kvm-ppc tree with the kvm-arm tree
Message-ID: <20190501160902.49dcf348@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Kvyt6TNl2WovTZLs9y1EWnq"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Kvyt6TNl2WovTZLs9y1EWnq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-ppc tree got a conflict in:

  include/uapi/linux/kvm.h

between commits:

  555f3d03e7fb ("KVM: arm64: Add a capability to advertise SVE support")
  a243c16d18be ("KVM: arm64: Add capability to advertise ptrauth for guest")

from the kvm-arm tree and commit:

  eacc56bb9de3 ("KVM: PPC: Book3S HV: XIVE: Introduce a new capability KVM_=
CAP_PPC_IRQ_XIVE")

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
index 4dc34f8e29f6,52bf74a1616e..000000000000
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@@ -988,9 -988,7 +988,10 @@@ struct kvm_ppc_resize_hpt=20
  #define KVM_CAP_ARM_VM_IPA_SIZE 165
  #define KVM_CAP_MANUAL_DIRTY_LOG_PROTECT 166
  #define KVM_CAP_HYPERV_CPUID 167
 -#define KVM_CAP_PPC_IRQ_XIVE 168
 +#define KVM_CAP_ARM_SVE 168
 +#define KVM_CAP_ARM_PTRAUTH_ADDRESS 169
 +#define KVM_CAP_ARM_PTRAUTH_GENERIC 170
++#define KVM_CAP_PPC_IRQ_XIVE 171
 =20
  #ifdef KVM_CAP_IRQ_ROUTING
 =20

--Sig_/Kvyt6TNl2WovTZLs9y1EWnq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzJN/4ACgkQAVBC80lX
0GyFzAgAoZ5umiIReEysI3SJJuZza5scZWesvNGm1JiPWAU4xl+NTFXuGfGFsp1/
17NNVyRmKZwyqL+MXlbFIuT3IhvHR/uc6pKtRNEhQO0JZZOVnDf9tFGcBGcVZJfK
DSkSesCicMZuzzsT/bKaSjtYYrjehNMR3sBGe7SqGysnU6gQN6k+mvPQYxBnPqhH
UNVV0mX5mxX4CwunmYs4RKq/4/W0FJvfcHpHfEgLJXY6x8SEHPuXZct6JrhtYgDC
Med5c388vQcaoDnLfkjZ/g/SOdJCGIiggJyvhR/KXz30EzqY5YTLi8TrNAueCRpo
Z0Hd4G3tj/SU0hv2iXvxF8ZnARTUqA==
=AfPs
-----END PGP SIGNATURE-----

--Sig_/Kvyt6TNl2WovTZLs9y1EWnq--
