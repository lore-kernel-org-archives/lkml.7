Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A9C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD86207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="SV6txlwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgAHBE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:04:57 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50253 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgAHBE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:04:56 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47srcz5RJnz9sRl;
        Wed,  8 Jan 2020 12:04:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1578445494;
        bh=K98i5nHFZAE1tD4rWgYo8VA8Ctitbjp2S9UCU59KOyo=;
        h=Date:From:To:Cc:Subject:From;
        b=SV6txlwm0NUDfX9rOvIyhyU/NGgJWtowdWGofd2s5FToaXhBqkNoj5cP5WDgFOiVE
         OxKPR1DbLy16devM9/mv7JSNir4l57rS5PCz0773/uJW5gmsuHiKXpU+Meoq8DzULG
         9NAehWmL3FVtxxM6SMPSY3AhcFteGUeC9xZkFh8ab2LukNq0QSsS69Fnh09L2aOuvD
         /wLMmSnFSH3RzD9QPg08SMQTHoVfWk73v2PbcYctFBdEE0FUMOLTwlld63VDSE4D/C
         gIv2wCZSiDWAGu1DG4mNSOsSF4I2OikOFT1Z6Re7kMTSUpfJJmZvAOS2ur7z4IKgoK
         +NQUScVmBCt/Q==
Date:   Wed, 8 Jan 2020 12:04:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: linux-next: manual merge of the drm tree with the drm-intel-fixes
 tree
Message-ID: <20200108120450.33ec0fdd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DiL.+_mnf3=aA6Zinzamh2K";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DiL.+_mnf3=aA6Zinzamh2K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/gt/intel_ring_submission.c

between commit:

  103309977589 ("drm/i915/gt: Do not restore invalid RS state")

from the drm-intel-fixes tree and commit:

  3cd6e8860ecd ("drm/i915/gen7: Re-enable full-ppgtt for ivb & hsw")
  f997056d5b17 ("drm/i915/gt: Push the flush_pd before the set-context")
  f70de8d2ca6b ("drm/i915/gt: Track the context validity explicitly")
  902eb748e5c3 ("drm/i915/gt: Tidy up full-ppgtt on Ivybridge")

from the drm tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/i915/gt/intel_ring_submission.c
index 93026217c121,81f872f9ef03..000000000000
--- a/drivers/gpu/drm/i915/gt/intel_ring_submission.c
+++ b/drivers/gpu/drm/i915/gt/intel_ring_submission.c
@@@ -1574,28 -1602,20 +1594,26 @@@ static int switch_context(struct i915_r
 =20
  	GEM_BUG_ON(HAS_EXECLISTS(rq->i915));
 =20
- 	if (vm) {
- 		ret =3D load_pd_dir(rq, i915_vm_to_ppgtt(vm));
- 		if (ret)
- 			return ret;
- 	}
+ 	ret =3D switch_mm(rq, vm_alias(ce));
+ 	if (ret)
+ 		return ret;
 =20
  	if (ce->state) {
 -		u32 hw_flags;
 +		u32 flags;
 =20
  		GEM_BUG_ON(rq->engine->id !=3D RCS0);
 =20
 -		hw_flags =3D 0;
 +		/* For resource streamer on HSW+ and power context elsewhere */
 +		BUILD_BUG_ON(HSW_MI_RS_SAVE_STATE_EN !=3D MI_SAVE_EXT_STATE_EN);
 +		BUILD_BUG_ON(HSW_MI_RS_RESTORE_STATE_EN !=3D MI_RESTORE_EXT_STATE_EN);
 +
 +		flags =3D MI_SAVE_EXT_STATE_EN | MI_MM_SPACE_GTT;
- 		if (!i915_gem_context_is_kernel(rq->gem_context))
+ 		if (!test_bit(CONTEXT_VALID_BIT, &ce->flags))
 -			hw_flags =3D MI_RESTORE_INHIBIT;
 +			flags |=3D MI_RESTORE_EXT_STATE_EN;
 +		else
 +			flags |=3D MI_RESTORE_INHIBIT;
 =20
 -		ret =3D mi_set_context(rq, hw_flags);
 +		ret =3D mi_set_context(rq, flags);
  		if (ret)
  			return ret;
  	}

--Sig_/DiL.+_mnf3=aA6Zinzamh2K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4VKrIACgkQAVBC80lX
0GxXTwgAjrn/2Opi2eDUpAbcg3YhI7Pq0iGOP2GOzUknv3xhkNvNQnDZCC5pJotT
Zx4VEPz0ttNJvzGJ6n7AGXzTYv8XrWk1ToPHSB178e/mYd+POPwvw7RF4+q12NeK
wH4BVuEtT7vKYtVZ86M+7kZNaWG3VvDmaMvXBSGi9txbuuJb0/Hu4/BMaQRlKpc/
oyhcO3+nbF2TMF8Q5PKX2D+HXaOQsNPe/jIgrAob1f//mKXstyr+pJW5OHT3KZdu
4DZkTvNxI3WV7kXi886JoO02oyawO3p+Opg+fRnB2Z6xBWKOc7zC05Ugn7GYv0EB
H9/m5a9on0A0FUayHoBImgHGw+Vx1w==
=afzz
-----END PGP SIGNATURE-----

--Sig_/DiL.+_mnf3=aA6Zinzamh2K--
