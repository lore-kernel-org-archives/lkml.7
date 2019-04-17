Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020B7C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7AF02183E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 21:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733250AbfDQVxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:53:36 -0400
Received: from anholt.net ([50.246.234.109]:33044 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfDQVxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 17:53:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8B6C710A339A;
        Wed, 17 Apr 2019 14:53:35 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id omenQMg-A1-a; Wed, 17 Apr 2019 14:53:34 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 4A9FA10A32F5;
        Wed, 17 Apr 2019 14:53:34 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id CBAFC2FE3AA4; Wed, 17 Apr 2019 14:53:33 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com
Subject: Re: [PATCH v2 3/5] drm/v3d: Add support for compute shader dispatch.
In-Reply-To: <20190416225856.20264-4-eric@anholt.net>
References: <20190416225856.20264-1-eric@anholt.net> <20190416225856.20264-4-eric@anholt.net>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/26.1 (x86_64-pc-linux-gnu)
Date:   Wed, 17 Apr 2019 14:53:33 -0700
Message-ID: <87v9zc1eoy.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Eric Anholt <eric@anholt.net> writes:

> The compute shader dispatch interface is pretty simple -- just pass in
> the regs that userspace has passed us, with no CLs to run.  However,
> with no CL to run it means that we need to do manual cache flushing of
> the L2 after the HW execution completes (for SSBO, atomic, and
> image_load_store writes that are the output of compute shaders).
>
> This doesn't yet expose the L2 cache's ability to have a region of the
> address space not write back to memory (which could be used for
> shared_var storage).
>
> So far, the Mesa side has been tested on V3D v4.2 simpenrose (passing
> the ES31 tests), and on the kernel side on 7278 (failing atomic
> compswap tests in a way that doesn't reproduce on simpenrose).

Fixed the compswap issue in Mesa.  Looks like cmpxchg needed the TYPE
field set to vec2 instead of 32-bit, since there are two values written
to TMUD.  The spec says the field is ignored, but that doesn't seem to
be the case.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAly3oF0ACgkQtdYpNtH8
nuhmkw//W73RUmscXiZ3tiorQBErHuvZ+x0nAm8ZmNctGr0Z4+JqG/AvFTjFH7UM
IQqjpXlBJTI3PRSWM130ezsLVfznbSQiJXUVwEsi+vBkW+ZzsaHArY+BwqDu/b2r
0WwrPYkyESZ0rm3J664vAuug0R7pnaC1/ePTxF3QZlDjmsqQQxV191MXRCj0YazI
rd/3ALrqs6ZC3/7NQJRXgxUG0D0lABOsre7nkzjsjl7vlGaQlXMac1ttpfCiFe7k
ebkzgwHsCuLFPq9Ll9rJ35LsqQTr7wWGKucveU8Q99VvWA2taYvog2Ei1IrFeWKQ
ROTwvnqbTkugnQx2tzdbDvMcVLvsFaJw/u1rj6r/HOcnhc/ElGTpR4NeAztBtwu5
TvyTaDFJXhvZxygJB4oQiES6cw3Z7jBTkWTFZKKZifeVwmAdweO8iw6YSjoaEtW6
1ELfDvL98sGDxDFSFu2Gepk+ooa5fs8EiNE7wyNHwRD+icjwvVLOlOHwcX6OTjyd
Hme05kpS/yuVTohaTekawmKxi7bQN8hxXX1nc8bRBaP4VkjmMA17Fxx/9On7JB2+
4OMPpNWeJ++wiarDuSzkRnsD9xizT38MwuUhLAxdTL+bvsI4t0/jRLbkuad/i57h
oFZrt3duCwZyrpqcuEfEDQgeNMvVsCJyrAp49s9VF6QSaEPU3Sw=
=N+zs
-----END PGP SIGNATURE-----
--=-=-=--
