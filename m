Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19714C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE98B2133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 18:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDCS6E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 14:58:04 -0400
Received: from anholt.net ([50.246.234.109]:33908 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCS6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 14:58:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 8462710A2F03;
        Wed,  3 Apr 2019 11:58:03 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Oa6nLxpAaIoY; Wed,  3 Apr 2019 11:58:02 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 11EB110A275D;
        Wed,  3 Apr 2019 11:58:02 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 7A2C42FE33BA; Wed,  3 Apr 2019 11:58:01 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Eben Upton <eben@raspberrypi.org>,
        Daniel Stone <daniel@fooishbar.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: Re: [PATCH v4 3/4] drm/vc4: Check for the binner bo before handling OOM interrupt
In-Reply-To: <20190403154856.9470-4-paul.kocialkowski@bootlin.com>
References: <20190403154856.9470-1-paul.kocialkowski@bootlin.com> <20190403154856.9470-4-paul.kocialkowski@bootlin.com>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Wed, 03 Apr 2019 11:58:01 -0700
Message-ID: <87ef6ior0m.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Paul Kocialkowski <paul.kocialkowski@bootlin.com> writes:

> Since the OOM interrupt directly deals with the binner bo, it doesn't
> make sense to try and handle it without a binner buffer registered.
> The interrupt will kick again in due time, so we can safely ignore it
> without a binner bo allocated.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/gpu/drm/vc4/vc4_irq.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/vc4/vc4_irq.c b/drivers/gpu/drm/vc4/vc4_irq.c
> index ffd0a4388752..723dc86b4511 100644
> --- a/drivers/gpu/drm/vc4/vc4_irq.c
> +++ b/drivers/gpu/drm/vc4/vc4_irq.c
> @@ -64,6 +64,9 @@ vc4_overflow_mem_work(struct work_struct *work)
>  	struct vc4_exec_info *exec;
>  	unsigned long irqflags;

Since OOM handling is tricky, could we add a comment to help the next
person try to understand it:

/* The OOM IRQ is level-triggered, so we'll see one at power-on before
 * any jobs are submitted.  The OOM IRQ is masked when this work is
 * scheduled, so we can safely return if there's no binner memory
 * (because no client is currently using 3D).  When a bin job is
 * later submitted, its tile memory allocation will end up bringing us
 * back to a non-OOM state so the OOM can be triggered again.
 */

But, actually, I don't see how the OOM IRQ will ever get re-enabled.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlylAjkACgkQtdYpNtH8
nug79xAAmqpPcXhAJ+UODSXAWaH1qtbied6T0kvUBd1i7KViGR6irn47VA564+Bc
6e5V5jdrPlg2SymscflE5aNbSZ4AlgOZhIj1m+btznZRBEPYunoLddY1kKtsOXwh
T63s6By2Hm9SQCrtxsvP6AJfOFTTuX7+/zocaYwkBbEYMHXPcWzDXZEZ4bIoWQqj
gUnBMxu5wxpbIsUTJ+M7Y6Bsy1ox/T0pZy+bBOcSDUki+LTGbdyT/wKuiBtLxd2E
6v6BJu3SOEdx/AxuMZ2EzNMhp+WTKv4/0IryC94N6VGe73YnS6KCWzN/0p+Bne6W
NoNy+boYrlRPtezFWvT3b+trYcPp0OAZ4WKFxHxTEoSFaUnmHbjccvQOJD/ZgCzK
kuieOerorpEyEy+KZsw25bFQumYiOmBTqUR3PPUXKbE2gmjF7MQ0p0uqCAFlJmxn
wo7mm2F9xN6Vhe2WlKCXyS8m4jAmqGgKKsA3fldZcjrOr/3e5p8z85qtbGe7JvRj
0pe0wIINia4T+tEj9wXjWmk52Sgk99owOuOqvt/FVjcOYNDC2lejMjsVsHD1/VEo
WJ2OsbblXnBAyagQ2gn7iB6+2LDyTNKppYewHnM0L0cvIXjnWQoc7JAGHU7DfuAb
hbRAvZiS461CGEKBUcJ1F3TU/Z2jkezOYiIN4x9ZSL+akyaaLqY=
=6Wqr
-----END PGP SIGNATURE-----
--=-=-=--
