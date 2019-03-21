Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8024C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB512218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 16:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfCUQUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 12:20:35 -0400
Received: from anholt.net ([50.246.234.109]:41626 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728064AbfCUQUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 12:20:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 1C98110A2ED3;
        Thu, 21 Mar 2019 09:20:34 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Eti73gC0CRL5; Thu, 21 Mar 2019 09:20:32 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id A485A10A11A3;
        Thu, 21 Mar 2019 09:20:32 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 3282A2FE4653; Thu, 21 Mar 2019 09:20:32 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Eben Upton <eben@raspberrypi.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 2/2] drm/vc4: Allocated/liberate the binner BO at firstopen/lastclose
In-Reply-To: <a027f99e59c90b2b3a87c4b18a263cfee4cc5795.camel@bootlin.com>
References: <20190320154809.14823-1-paul.kocialkowski@bootlin.com> <20190320154809.14823-3-paul.kocialkowski@bootlin.com> <87wokth498.fsf@anholt.net> <a027f99e59c90b2b3a87c4b18a263cfee4cc5795.camel@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Mar 2019 09:20:29 -0700
Message-ID: <871s3042sy.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Hi,
>
> Le mercredi 20 mars 2019 =C3=A0 09:58 -0700, Eric Anholt a =C3=A9crit :
>> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
>>=20
>> > The binner BO is a pre-requisite to GPU operations, so we must ensure
>> > that it is always allocated when the GPU is in use. Currently, we are
>> > allocating it at probe time and liberating/allocating it during runtime
>> > pm cycles.
>> >=20
>> > First, since the binner buffer is only required for GPU rendering, it's
>> > a waste to allocate it when the driver probes since internal users of
>> > the driver (such as fbcon) won't try to use the GPU.
>> >=20
>> > Move the allocation/liberation to the firstopen/lastclose instead to
>> > only allocate it when userspace has opened the device and adapt the IRQ
>> > handler to return early when no binner BO was allocated yet.
>> >=20
>> > Second, because the buffer is allocated from the same pool as other GPU
>> > buffers, we might run into a situation where we are out of memory at
>> > runtime resume. This causes the binner BO allocation to fail and resul=
ts
>> > in all subsequent operations to fail, resulting in a major hang in
>> > userspace.
>> >=20
>> > As a result, keep the buffer alive during runtime pm.
>> >=20
>> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> > ---
>> > diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_i=
rq.c
>> > index 4cd2ccfe15f4..efaba2b02f6c 100644
>> > --- a/drivers/gpu/drm/vc4/vc4_irq.c
>> > +++ b/drivers/gpu/drm/vc4/vc4_irq.c
>> > @@ -64,6 +64,9 @@ vc4_overflow_mem_work(struct work_struct *work)
>> >  	struct vc4_exec_info *exec;
>> >  	unsigned long irqflags;
>> >=20=20
>> > +	if (!bo)
>> > +		return;
>> > +
>> >  	bin_bo_slot =3D vc4_v3d_get_bin_slot(vc4);
>> >  	if (bin_bo_slot < 0) {
>> >  		DRM_ERROR("Couldn't allocate binner overflow mem\n");
>>=20
>> Hmm.  We take the OOM IRQ on poweron, have no bin BO since nobody's
>> opened yet, and leave it.  Do we ever get the OOM IRQ again after that?
>> Seems like vc4_allocate_bin_bo() might need to kick something so that we
>> can fill an OOM request.
>
> I just had a look and it seems that we do get the OOM interrupt again
> after the bin BO is allocated. Actually, I can see it kicking from time
> to time when using X with glamor.
>
> From what I understood, this looks fairly legitimate. Should we be
> worried about this?

Great.  I think how it ends up working is that when the job is
submitted, the bin allocation it supplies internally gets us out of the
OOM condition, so OOM can edge trigger again later.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyTuc4ACgkQtdYpNtH8
nuja2xAAtyp4j1VInkIuNIkkh1Kx8yWqpbndPR9pXaks5Gp8rIMF6/P9briWGuLY
9cC+D2L6EPpk/4wmypEpzuy7h1il894TQjAutaOEbPqLM66ZqpE7vU5ULAyMm1+O
nLj3YkbtzggaxKGDNIJDX7K8iO+U+P/IqFBAG3Rvu8Gy61Ol/pPO83HaSv1oqKOT
DKGoAtlyWngghFo10A3jPpIu+QIpAu902Krf3tpIc7w/LJmqfAyKjMQmQ2072L+p
Au6Xf6C3UOPIRPQQlbwGyzV4Nqsnjj47JrnlmvV1NSvo7kmev5NloPqEdjqZ6QNx
VRLwvvw00Z/rsFUxIRUEqE3dAGnmZTLy+f7gJVcQeDcNLz94yrtWExSFZkP/TBlq
pF3owZmcFvQSwsz1Hz2bAbpPZXIiZ0DhFgoKCi4wU6udNx9K+vsCWQ/+enO3npsZ
gTvijtNNGvwm8NoT+QeB3KS12XoSZujNB8/4u5NMk28Jd3/TJDd+8vz2XIq5Qu4E
L9x0d3+WS5pM42OB4DxDFlbPB2ns+38FG4MqqeZJAO9Mw7SjtURCjy8MTHfi6zg8
2cIK5MIPiL3IzbKNnk4SaTsi9O2PvyXsi824LBOAECrdGmgnh5SUBAK8v2FP9Pac
iElQyCZLVtCMhKYGYFlyi4CwzLQ2+ti9uygKb7ShA5Au4/XZdFM=
=kuQ/
-----END PGP SIGNATURE-----
--=-=-=--
