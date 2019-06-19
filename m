Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15554C31E5F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 04:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26BE2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 04:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="io9j1o88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfFSET6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 00:19:58 -0400
Received: from ozlabs.org ([203.11.71.1]:55701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfFSET5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 00:19:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TBYf35Zlz9s5c;
        Wed, 19 Jun 2019 14:19:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560917994;
        bh=g6BHo34pUX0+bJ8ZlovsR9z8dAhrs6fACHHPO6QK9y4=;
        h=Date:From:To:Cc:Subject:From;
        b=io9j1o88CHlJEueVOt9s6av7KEt0qMoYDINMNNniZKW9as5JvkLSSlGcDXAets7eG
         wLmBk4jbLuiUTetuKZb34isHF8j4G+28qqKAwwKUTzAiNWjp6CylzMQ7JbgpuNNGPF
         hYdwgw5ZVXty0qPSwU0sAGNvVCemunwRblhVpq+LB2BYbajkaTph+kuVkTYiFldLJY
         vuLVEM8Th+5w5XPUM3NRJLExKDoniWylW+X0rkWXfGX1rGXbpJ5dIlMVTn7dVQ9guM
         J5ERJeZcXNJSrKe9kbiRplFPKz6Hd2XLTc388rzcmw6qUXukmpRHEsHYUi1NwEtroU
         ZqhkDrqW0AXHQ==
Date:   Wed, 19 Jun 2019 14:19:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: linux-next: manual merge of the drm tree with the kbuild tree
Message-ID: <20190619141949.38e661e6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OFXYsSUCIef=lutNjM1jqkt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OFXYsSUCIef=lutNjM1jqkt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/Makefile.header-test

between commit:

  e846f0dc57f4 ("kbuild: add support for ensuring headers are self-containe=
d")

from the kbuild tree and commits:

  112ed2d31a46 ("drm/i915: Move GraphicsTechnology files under gt/")
  d91e657876a9 ("drm/i915: Introduce struct intel_wakeref")
  aab30b85c97a ("drm/i915: ensure more headers remain self-contained")
  b375d0ef2589 ("drm/i915: extract intel_vdsc.h from intel_drv.h and i915_d=
rv.h")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/Makefile.header-test
index 639b596a06a9,3a9663002d4a..000000000000
--- a/drivers/gpu/drm/i915/Makefile.header-test
+++ b/drivers/gpu/drm/i915/Makefile.header-test
@@@ -2,18 -2,28 +2,28 @@@
  # Copyright =C2=A9 2019 Intel Corporation
 =20
  # Test the headers are compilable as standalone units
 -header_test :=3D \
 +header-test-$(CONFIG_DRM_I915_WERROR) :=3D \
  	i915_active_types.h \
+ 	i915_debugfs.h \
+ 	i915_drv.h \
  	i915_gem_context_types.h \
+ 	i915_gem_pm.h \
+ 	i915_irq.h \
+ 	i915_params.h \
  	i915_priolist_types.h \
+ 	i915_reg.h \
  	i915_scheduler_types.h \
  	i915_timeline_types.h \
+ 	i915_utils.h \
+ 	intel_acpi.h \
+ 	intel_atomic.h \
  	intel_atomic_plane.h \
  	intel_audio.h \
+ 	intel_bios.h \
  	intel_cdclk.h \
  	intel_color.h \
+ 	intel_combo_phy.h \
  	intel_connector.h \
- 	intel_context_types.h \
  	intel_crt.h \
  	intel_csr.h \
  	intel_ddi.h \
@@@ -31,7 -54,22 +54,12 @@@
  	intel_pipe_crc.h \
  	intel_pm.h \
  	intel_psr.h \
+ 	intel_quirks.h \
+ 	intel_runtime_pm.h \
  	intel_sdvo.h \
+ 	intel_sideband.h \
  	intel_sprite.h \
  	intel_tv.h \
- 	intel_workarounds_types.h
+ 	intel_uncore.h \
+ 	intel_vdsc.h \
+ 	intel_wakeref.h
 -
 -quiet_cmd_header_test =3D HDRTEST $@
 -      cmd_header_test =3D echo "\#include \"$(<F)\"" > $@
 -
 -header_test_%.c: %.h
 -	$(call cmd,header_test)
 -
 -i915-$(CONFIG_DRM_I915_WERROR) +=3D $(foreach h,$(header_test),$(patsubst=
 %.h,header_test_%.o,$(h)))
 -
 -clean-files +=3D $(foreach h,$(header_test),$(patsubst %.h,header_test_%.=
c,$(h)))

--Sig_/OFXYsSUCIef=lutNjM1jqkt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0Jt+UACgkQAVBC80lX
0Gx+uQf+L8n3u5sfawCr66p/2odPMstJFLPc8WDFbPTrUzA0EkMogFFF9N4qSX99
jK/JEsqhY3gFNOqLYFJfFmQlzOe4ImpsoGX+dFk0y3LZXXw6yMOCinXrxZ/mYlwH
y2EOsPV2679Fnw9DyZWkGoRykM07d7hTkdKBmYQbA32zFudw0NUBpiBg2NGZtNWa
NU8Eo331pfp6ppyHCLHObpbQgOB1m02zGDSh2DsO6FVzIrTK85hcAlOFBykIwUlZ
BrwzqrywRzDNuMctR0NzFnAFcOurqu4bPn80QZIhMIXxHHhUNtx+CK58Cz3HQuQ+
oPqA1jo/aZKODh7fRm71VKXbfeNPcg==
=d5sv
-----END PGP SIGNATURE-----

--Sig_/OFXYsSUCIef=lutNjM1jqkt--
