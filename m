Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B7EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B14A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 02:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VCaHt9Mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732614AbfC0C7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 22:59:11 -0400
Received: from ozlabs.org ([203.11.71.1]:51379 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbfC0C7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 22:59:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44TXlF5yWbz9sT4;
        Wed, 27 Mar 2019 13:59:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553655547;
        bh=6Kr7GdozTU/5GwwyvmGvSYqPZtL4gEhsVopM4zLNv0Q=;
        h=Date:From:To:Cc:Subject:From;
        b=VCaHt9MpCKFhIMkr0UsCf5UE3UPjK69svInPJCaIz7gIsTgxVhSDrVw8BuWyxELPB
         AJ7OxUxV44QZhYmmQYvzM0yux31tcFik8j20lXQHSS1+2kyqxxdQhBzhEMhSQyW9h5
         69iVVQ4l0Qd4VW9Z64ubVYjYojNNgdwss+b2d4zcSW60Q04enuePfASY9+DGa8dC7Y
         DZYwLEZCaaJln/M4A1a0LsxzFzeGGQ/s+x3fG3i3fsGlXt+8QCSIeNw+vrmmQipPWs
         yT5Z4Q1RXdWpHZPfl+RsLgGSHTEIR54ND70OgXkMNTdt3uf/J36KVrEVM5OX8k8B9H
         ItnKoFfkvNpYw==
Date:   Wed, 27 Mar 2019 13:59:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Paulo Zanoni <paulo.r.zanoni@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20190327135904.7830c60c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Ia1Gj60M+J_G=l6Dzpsyw2j"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ia1Gj60M+J_G=l6Dzpsyw2j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel tree, today's linux-next build (i386
defconfig) failed like this:

In file included from drivers/gpu/drm/i915/intel_guc.h:28:0,
                 from drivers/gpu/drm/i915/intel_uc.h:27,
                 from drivers/gpu/drm/i915/intel_uc.c:25:
drivers/gpu/drm/i915/intel_uncore.h: In function '__raw_uncore_read64':
drivers/gpu/drm/i915/intel_uncore.h:257:9: error: implicit declaration of f=
unction 'readq'; did you mean 'readl'? [-Werror=3Dimplicit-function-declara=
tion]
  return read##s__(uncore->regs + i915_mmio_reg_offset(reg)); \
         ^
drivers/gpu/drm/i915/intel_uncore.h:269:1: note: in expansion of macro '__r=
aw_read'
 __raw_read(64, q)
 ^~~~~~~~~~
drivers/gpu/drm/i915/intel_uncore.h: In function '__raw_uncore_write64':
drivers/gpu/drm/i915/intel_uncore.h:264:2: error: implicit declaration of f=
unction 'writeq'; did you mean 'writel'? [-Werror=3Dimplicit-function-decla=
ration]
  write##s__(val, uncore->regs + i915_mmio_reg_offset(reg)); \
  ^
drivers/gpu/drm/i915/intel_uncore.h:274:1: note: in expansion of macro '__r=
aw_write'
 __raw_write(64, q)
 ^~~~~~~~~~~

Caused by commit

  6cc5ca768825 ("drm/i915: rename raw reg access functions")

I have reverted that commit and the following ones in the tree up to

  9511cb6481af ("drm/i915: Adding missing '; ' to ENGINE_INSTANCES")

--=20
Cheers,
Stephen Rothwell

--Sig_/Ia1Gj60M+J_G=l6Dzpsyw2j
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlya5vgACgkQAVBC80lX
0GyFfQgAi7dRjhiXA+BM8N8B637jL5naqlVhgGyfiImegPNTN2Sr7jLKR4v8XFcZ
MHBzucDThx+w9SrWua7Xa/QiGvgMKiJff1AeCOnMwf6nIbEzCgzIDqUxrIdelq5k
VvyXwLJqUJmXQRcCDdOXK9cyfG4NJSGuuok80jvzbeLhAIYY4CAde2IglWFz7tBo
ZwD/SOYO6Acw1UQLVb3Or/I5prevtkLG4vk/0d4v4TgLFJP1yz/1DMv4mDSqf4nO
8aQXvklT9g39UGn853D7pENqYs2Df46BniHIPTDOMw3N8FZtaVb+qdzMCywMWSt+
+kO0SPS5mB8IN5+e2+TNuyE421M7ZQ==
=d0Jl
-----END PGP SIGNATURE-----

--Sig_/Ia1Gj60M+J_G=l6Dzpsyw2j--
