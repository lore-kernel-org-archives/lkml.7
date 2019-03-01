Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08986C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61532085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 02:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="krqo598Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbfCACYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 21:24:00 -0500
Received: from ozlabs.org ([203.11.71.1]:53425 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfCACYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 21:24:00 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 449YBd4cqsz9s4V;
        Fri,  1 Mar 2019 13:23:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551407037;
        bh=oZlwRUfuxCc354Fb3zW6x4JC89IDxaOzMO5/ibazr68=;
        h=Date:From:To:Cc:Subject:From;
        b=krqo598QrR4VMVPcnj2kfRRrQ51q/EgJzdycSwLdbAM5ayWXGgYQNHhRe12UHuAf+
         tFLrWLqtVGgBeC+X+1h0f9L7AyjKy5vb6H+RCA49uiuZjPUQlVb8pMlmpDi6tNvLtB
         WlZHey7xrP4ijhVAc3M8Vlf9sSYzhfEULNWic2eQdp2McG4BBO7UfVEQLr+fE6BtW7
         gQYpizJO3hVFLvDvq3udgxOjZ+/hUlWoVwKT9paALsYLoM1dL2QTzObKz5KskDgDcz
         n/CXKGhRqdMYm4RofdGJ4urj2DjLzQAMPL/AN3LZNooTmX27WeiXR6XLhRKGdTISG1
         d9+Pid/m02iQw==
Date:   Fri, 1 Mar 2019 13:23:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mario Kleiner <mario.kleiner.de@gmail.com>,
        David Francis <David.Francis@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <20190301132351.6f4e815f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/UfcNgO3NRzprj7em811gPnl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UfcNgO3NRzprj7em811gPnl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c

between commit:

  d63716658ac1 ("drm/amd/display: Use vrr friendly pageflip throttling in D=
C.")

from the drm-fixes tree and commits:

  8a48b44cd00f ("drm/amd/display: Call into DC once per multiplane flip")
  bc7f670ee04c ("drm/amd/display: Perform plane updates only when needed")

from the drm tree.

I had no idea how to resolve this, so I just effectively reverted the
drm-fixes commit.

I fixed it up (see above) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/UfcNgO3NRzprj7em811gPnl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx4l7cACgkQAVBC80lX
0Gwk2gf/db06P2eC151aw7EZr+PzAu18jkqbNDEMzeVWYd+7oMjcmlY2BEnQA040
Z+uL90Lu24M0ar8lCwRpvq6A7KJG0IzhgudHYG0K6JzWwP+MmJsUYZT1rzTpLcuy
EsNRI00+UQTK51LsSTYdToQsMNX2maasDtlZzYtkXoooRB8oRsytyiDaGBAVA/pb
C4IvTeYqtDGC/viJ+0oqHaUUEVf9uuipXaThUlt8XO/l7RSs2ytQfqPfXExmpEoL
PMEgSBG26etYrNTpZoR6ksmR728W3cozR5jl20eLGsRT8lgMIPyIivu5v5xUo0Oo
xT0MmQdddaFU0oDPBz5NkW6zoDM4Tg==
=NNfy
-----END PGP SIGNATURE-----

--Sig_/UfcNgO3NRzprj7em811gPnl--
