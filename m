Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4C8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32712146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 16:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbfCTQ6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 12:58:30 -0400
Received: from anholt.net ([50.246.234.109]:34662 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfCTQ6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 12:58:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9CE9710A2EE3;
        Wed, 20 Mar 2019 09:58:29 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id KgdFXMxPWADn; Wed, 20 Mar 2019 09:58:28 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 56BFE10A2E9D;
        Wed, 20 Mar 2019 09:58:28 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id CB56B2FE4653; Wed, 20 Mar 2019 09:58:27 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v2 2/2] drm/vc4: Allocated/liberate the binner BO at firstopen/lastclose
In-Reply-To: <20190320154809.14823-3-paul.kocialkowski@bootlin.com>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com> <20190320154809.14823-3-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 20 Mar 2019 09:58:27 -0700
Message-ID: <87wokth498.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> The binner BO is a pre-requisite to GPU operations, so we must ensure
> that it is always allocated when the GPU is in use. Currently, we are
> allocating it at probe time and liberating/allocating it during runtime
> pm cycles.
>
> First, since the binner buffer is only required for GPU rendering, it's
> a waste to allocate it when the driver probes since internal users of
> the driver (such as fbcon) won't try to use the GPU.
>
> Move the allocation/liberation to the firstopen/lastclose instead to
> only allocate it when userspace has opened the device and adapt the IRQ
> handler to return early when no binner BO was allocated yet.
>
> Second, because the buffer is allocated from the same pool as other GPU
> buffers, we might run into a situation where we are out of memory at
> runtime resume. This causes the binner BO allocation to fail and results
> in all subsequent operations to fail, resulting in a major hang in
> userspace.
>
> As a result, keep the buffer alive during runtime pm.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---

> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
> index 4cd2ccfe15f4..efaba2b02f6c 100644
> --- a/drivers/gpu/drm/vc4/vc4_irq.c
> +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> @@ -64,6 +64,9 @@ vc4_overflow_mem_work(struct work_struct *work)
>  	struct vc4_exec_info *exec;
>  	unsigned long irqflags;
>=20=20
> +	if (!bo)
> +		return;
> +
>  	bin_bo_slot =3D vc4_v3d_get_bin_slot(vc4);
>  	if (bin_bo_slot < 0) {
>  		DRM_ERROR("Couldn't allocate binner overflow mem\n");

Hmm.  We take the OOM IRQ on poweron, have no bin BO since nobody's
opened yet, and leave it.  Do we ever get the OOM IRQ again after that?
Seems like vc4_allocate_bin_bo() might need to kick something so that we
can fill an OOM request.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyScTMACgkQtdYpNtH8
nui6ghAAqhbHbg2QfivGQ63+Rm60JIWOE6iCD7FgLRTy98Wg9hieAqpr0W/E68IZ
eBHveuFbclHqunaJlfwa4zLAYFzRa6UWiH2YGGFu80g1K8hSJBLbpxVkhYumJA4P
hy/FiszNlwp9KbnyihUtRRwFNXEePd6Y1TPFYgIOX0Sk3AKs7HIVnNbgpTH7t/Cw
jdPa6McMYlA69/6z7G3l3F7/Yy6MpjkbsiMymLjtb2SC/V27j7p9Mh+QhayyAQpJ
B3chSOPsApD3VRhEbhZ62eaa9re1nXRyVIQpR1K69LgGk7h+k3t9vz2Wqx/e4CDI
drgukwZUwViH4JZL1QxirICUUQuEAODXLO3MdGpeWix/Xhl+3TVytvaA2to5iugJ
Y3960bw9ZtpVCC5aGadxt16dgdp18fA1KqwqbA1/Wgp5T6tmsmZ0xzPuaS+pZof8
mGodIOZ/SmZxSDpUIWs2s0q5P0g/r2crBQMrpnIsMWyZ3mjIG63cGgoayQYc9UJt
iq7zd0xntkF2m2IIU4B0S1Xq6T8uwFmu7kfYgss0ugWXkNN9M0hE+Ruy0zbOBwR5
wVFqY/5Eem0lBQ4h7CeSAsc+CjN95c9k1dUZ8F25F9/RuiCXZUr4Ggvg8/Jq9gwB
lFCSfRG7qOswlxx+u2BjBRMy3OQZsh9KD3qRk7qEKLOWrhdMhCs=
=bdx7
-----END PGP SIGNATURE-----
--=-=-=--
