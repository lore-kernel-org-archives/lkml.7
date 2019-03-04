Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03A8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6D220835
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GlaGPnq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbfCDWvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:51:17 -0500
Received: from ozlabs.org ([203.11.71.1]:50537 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbfCDWvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:51:17 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44CwHQ03Fyz9s00;
        Tue,  5 Mar 2019 09:51:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1551739874;
        bh=v+2/2BRZP0k7+KJ3/wqGl1EdA/GmC8m940jnYJquNWk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GlaGPnq+IeG6I15ClfKomIFx+BVx5+b2m6EiocYFBH1rAhftweRJsFoXcEfqT7WnN
         GPaGW/+exXPX2r0PmvKmefCdv2QfKQQ2BTpDwSBT54JPgpQ8nySOljj3GwY9IKBgbw
         iNDYS7GM5XYJJXGZw/z2ECVx6lL2Ldcoi9RHFmVAvTTosTEoeveOL59b8lEftybzwE
         vHw9PVy7AX66Mv8Qmo65k8hoTJXc2XwdWI0Tmr9AI9L+BkPFzUxgGwQqczyoHI/gXB
         w2v/u4quBdqQf9vtLkTKebw34nRXuAyA4cLJhYFoXHIKg7wwGuWdd/U8Zkge8PfPgo
         29s8xecREaPwQ==
Date:   Tue, 5 Mar 2019 09:51:00 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bp@alien8.de, natechancellor@gmail.com, niravd@google.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86/boot: clean up headers
Message-ID: <20190305095100.243a40e3@canb.auug.org.au>
In-Reply-To: <20190304175016.40538-1-ndesaulniers@google.com>
References: <20190302132750.0916adc4@canb.auug.org.au>
        <20190304175016.40538-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/s2NMWtIWecU_eQD7L1+SzGt"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s2NMWtIWecU_eQD7L1+SzGt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Mon,  4 Mar 2019 09:50:16 -0800 Nick Desaulniers <ndesaulniers@google.co=
m> wrote:
>
> Changes V1 -> V2:
> * Add Reviewed, Tested, Suggested tags.
> * Drop linux/types.h; it's included in linux/limits.h.
>=20
> My original intention was to unsort the headers (sorted in V1), but if
> we drop the out of place linux/types.h, then we can insert the two more
> specific headers in alphabetic order.

I don't understand why you care about the include file ordering.

Also, since this file uses things from linux/types.h, I would argue
that we need the explicit include of linux/types.h.  Just imagine if
someone at a later date reomves the linux/types.h include from
linux/limits.h (however unlikely that is).

Just do your bug fix.

--=20
Cheers,
Stephen Rothwell

--Sig_/s2NMWtIWecU_eQD7L1+SzGt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlx9q9QACgkQAVBC80lX
0GwMUAgAnewz0+cEI6RdEIPRq6K1Sly8eoK1ndXeAGPjK4Pnx5V6+ptD/rgLJe5R
rZ/03boLh8V1dcjBRCPeLTCNuT7WILxiHi1dzNfR3mSfNmH+3QkDTq9LnLq1FARe
8pcU3Ps0vX82hq5wtE2opnzU6Ju0TQAjEZdi3fRcu7/86BqS1vYJ+RruPLI+ReM6
ZYGtuHMnyVbhSxyNssd074lUgqmhFj3lMKYjerYVW6DjltLdOnWEfDStCueGp9n5
sOpUVSREbcvi+6sV9qlMw2EfpinvWbCCq6oh1C/A+1zV1eH5i/TSJKFNU3pgrKMO
YGmo8KERHWWHzqeEcc1JASSQ+/9evg==
=brI9
-----END PGP SIGNATURE-----

--Sig_/s2NMWtIWecU_eQD7L1+SzGt--
