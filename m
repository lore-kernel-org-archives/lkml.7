Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E268C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1839F2171F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbfDDUJn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:09:43 -0400
Received: from anholt.net ([50.246.234.109]:42624 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729497AbfDDUJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:09:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 94B2110A06DA;
        Thu,  4 Apr 2019 13:09:42 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Ouh9KHZ2BCRs; Thu,  4 Apr 2019 13:09:41 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id E7DA910A068A;
        Thu,  4 Apr 2019 13:09:40 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 732CE2FE3601; Thu,  4 Apr 2019 13:09:40 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH v4 3/4] drm/vc4: Check for the binner bo before handling OOM interrupt
In-Reply-To: <041896dd4a8fb7e234356ee6d37a8a04909dd8b2.camel@bootlin.com>
References: <20190403154856.9470-1-paul.kocialkowski@bootlin.com> <20190403154856.9470-4-paul.kocialkowski@bootlin.com> <87ef6ior0m.fsf@anholt.net> <041896dd4a8fb7e234356ee6d37a8a04909dd8b2.camel@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Thu, 04 Apr 2019 13:09:40 -0700
Message-ID: <87y34pv8fv.fsf@anholt.net>
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

> Hey,
>
> Le mercredi 03 avril 2019 =C3=A0 11:58 -0700, Eric Anholt a =C3=A9crit :
>> Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:
>>=20
>> > Since the OOM interrupt directly deals with the binner bo, it doesn't
>> > make sense to try and handle it without a binner buffer registered.
>> > The interrupt will kick again in due time, so we can safely ignore it
>> > without a binner bo allocated.
>> >=20
>> > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>> > ---
>> >  drivers/gpu/drm/vc4/vc4_irq.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >=20
>> > diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_i=
rq.c
>> > index ffd0a4388752..723dc86b4511 100644
>> > --- a/drivers/gpu/drm/vc4/vc4_irq.c
>> > +++ b/drivers/gpu/drm/vc4/vc4_irq.c
>> > @@ -64,6 +64,9 @@ vc4_overflow_mem_work(struct work_struct *work)
>> >  	struct vc4_exec_info *exec;
>> >  	unsigned long irqflags;
>>=20
>> Since OOM handling is tricky, could we add a comment to help the next
>> person try to understand it:
>>=20
>> /* The OOM IRQ is level-triggered, so we'll see one at power-on before
>>  * any jobs are submitted.  The OOM IRQ is masked when this work is
>>  * scheduled, so we can safely return if there's no binner memory
>>  * (because no client is currently using 3D).  When a bin job is
>>  * later submitted, its tile memory allocation will end up bringing us
>>  * back to a non-OOM state so the OOM can be triggered again.
>>  */
>>=20
>> But, actually, I don't see how the OOM IRQ will ever get re-enabled.
>
> Okay so I investigated that to try and understand what's going on.
> We are definitely writing the OUTOMEM bit to V3D_INTDIS just before
> scheduling the workqueue, and never re-enable the IRQ when leaving
> early in the workqueue because !vc4->bin_bo.
>
> It turns out that what saves us here is vc4_irq_postinstall being
> called from runtime resume at "the right time". Obviously this is more
> than fragile, so we should really be re-enabling the IRQ as soon as we
> have the binner bo allocated.
>
> Since we're now allocating at the first non-dumb bo alloc, I think we
> need to make sure that we did in fact get the irq and registered the
> allocated BO with the workqueue before submitting the rcl. Or does the
> hardware provide any mechanism to take that off our hands somehow?

Maybe just enable the OOM interrupt using INTENA in the bin BO
allocation's success case?  That feels race-free, since it's a level
interrupt and even if we were racing the !bin_bo check in the work, we'd
end up re-scheduling the work?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlymZIQACgkQtdYpNtH8
nui0fhAAhVvMVUVK+u4cC7CN6ctNAd0SsqTDHb0yqtzFvpKWgVg1gBRNK2SvpI4v
rB+UKyU0KLRLwzhWSQhfT9emlTDiMfefz/cMcn1hoTBHh+OEkEfoMHuVn9YfDstA
CxaMgD/+8aseJLJfidJdxBi9BhLdntza9EfzBG5Ljg/p+Vkg3ZDRGptFKSjyWHOC
XtvAPCc8Ww+gHGPP82zXisgVVR7YcYGoWtzfCfeLdKvBg6srKL8M/gMyYA6WE41g
MU4fhIQ2J4BTQJkMpbGCnQO3boDukMmFdec30xcEGWcgdDO7tMaHqvyI6cQ1TYta
c+N6o2HKUVO4DmAHpHqjZtF1zprYesjyMnblQj2jjin+yZkQNOHP5Ez0QwXPCVc+
/CpCDaPpstBToXnqWvx+zcTNhpfsPl0eJ+WIhAp7C5HPEvy9ldImivgbpuLBaXdf
gDWsqUJ6+36C0uXjGxKquubmuIAaxUDLky4e7HMVuiZTJ58OZtBwiM4FkhmVb5Yh
/bCA68KHpxg+cV88F7eIAZfBKLFlBo7VM3e5/ZVTUzR0+NxUTk+JmWskZdj+IJO9
7L25SXvrJ001abdb8iNwpElB5qKGC/ya357KzcZxk3yfHqBV5xHXPQh1lkpHAQUR
IThD701wJGuzqpxMSUQjCzQN90uRrQZ9ejXq/CMJd/xjC6tokVA=
=ptXX
-----END PGP SIGNATURE-----
--=-=-=--
