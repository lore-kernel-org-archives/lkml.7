Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15991C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F7920861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 07:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="NZzlhmcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbfGHHYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 03:24:21 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34307 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbfGHHYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 03:24:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45hxlk2Khnz9sNg;
        Mon,  8 Jul 2019 17:24:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562570658;
        bh=s8SgSFIM00NpB+69X3WJ5ZEiPfGeXTcmA8V1PK2fc94=;
        h=Date:From:To:Cc:Subject:From;
        b=NZzlhmcuUONHM+3gJi6KA6cVGv3qiJIc6lvdd4l0uG3xkUfFkcISZHuH6sxhveZpw
         8F6mzyqdHYGFW4OsorVI4LMc6enDUsCqgD1drOCrsFcaL9K+R5AgQ6E8qJ3ID+qG2G
         5ArPOfI/LePpVOyaCgNgSFIzaKC/80x8+SfWDM/wVoLNQRty2oaLZ+GsrMdiqtjx3J
         6v1X8ZZ0R9fwwGpfQFiMcu+UY7jekHcAVsOlmT5bJggLQfaer2u6ss7ceEmObmGQtv
         MkmzBbW+3L4zH+5zH0iSI2Sm4sSHegxSjO6GX0uteWJ2bZB1mPktNHvTlSa+M88wSZ
         G/7++dAXA20Ww==
Date:   Mon, 8 Jul 2019 17:24:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Julien Thierry <julien.thierry@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: linux-next: manual merge of the kvm-arm tree with the arm64 tree
Message-ID: <20190708172417.1d3a34fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/lYTARTvOyB=0uSljEKI1slV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lYTARTvOyB=0uSljEKI1slV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kvm-arm tree got a conflict in:

  arch/arm64/include/asm/cpufeature.h

between commit:

  48ce8f80f590 ("arm64: irqflags: Introduce explicit debugging for IRQ prio=
rities")

from the arm64 tree and commit:

  c118bbb52743 ("arm64: KVM: Propagate full Spectre v2 workaround state to =
KVM guests")

from the kvm-arm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/arm64/include/asm/cpufeature.h
index 3d8db50d9ae2,948427f6b3d9..000000000000
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@@ -614,12 -614,12 +614,18 @@@ static inline bool system_uses_irq_prio
  	       cpus_have_const_cap(ARM64_HAS_IRQ_PRIO_MASKING);
  }
 =20
 +static inline bool system_has_prio_mask_debugging(void)
 +{
 +	return IS_ENABLED(CONFIG_ARM64_DEBUG_PRIORITY_MASKING) &&
 +	       system_uses_irq_prio_masking();
 +}
 +
+ #define ARM64_BP_HARDEN_UNKNOWN		-1
+ #define ARM64_BP_HARDEN_WA_NEEDED	0
+ #define ARM64_BP_HARDEN_NOT_REQUIRED	1
+=20
+ int get_spectre_v2_workaround_state(void);
+=20
  #define ARM64_SSBD_UNKNOWN		-1
  #define ARM64_SSBD_FORCE_DISABLE	0
  #define ARM64_SSBD_KERNEL		1

--Sig_/lYTARTvOyB=0uSljEKI1slV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0i76EACgkQAVBC80lX
0GwuyAf/X4XDfpURgS54pYJSE7ivCua9i8r93LDUS8oxViAWT9xvkWiiCAKCV0m3
tBWrnKpPfvmHgEXR0Nl/CTdn3otAeXns5JSwVADq6WGdp1VNnivThYkSgx8Qo2HQ
QwEFBr0xJM/4d8jUcFMVzAa/AmoPk/rnR9TSWuch6/kr0he3qZqXzsl4Iupt8UOH
0dVznUFxXK+7oJhNreYFN2eFeydD6MPOaG8vuDStnlsLr32SUB0KGcsV8/gVAc8v
/5uKS3XK4fQ/sb1APAwhzCbC+9MK69w3kw5028oRqh2CaHdSiQDIpEKDgdfOBnnY
SGAdPVA/rgK5N6eaNJrAbMFYyUYdXQ==
=fjl4
-----END PGP SIGNATURE-----

--Sig_/lYTARTvOyB=0uSljEKI1slV--
