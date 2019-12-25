Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBE6C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58272075E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 18:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h6HhfZ51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfLYSgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 13:36:06 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35020 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYSgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 13:36:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so22160144wro.2;
        Wed, 25 Dec 2019 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qMv6ZLPM7hCxbk7bCKDXLP5blGfXJiXsRRFE0KSzRnM=;
        b=h6HhfZ51wXhB7/nPe4rJdATonmGAyngBKwg7CfhtVVUdEzWzx9bFeYQcRpkGsQ1Djd
         OuTEPbPNlVqK3xaVfl5uYfvsNmUKl3KuNIthBcoqXdCCxS89PjS0DgsThAEuf6j6sfLa
         kV/4jIX8InMLsRE12HI3W1RdJt0QxY1v22ow8bbRNJTBDFl42mkYA8FJIzVlbAcRuUbR
         mWytZH+TPYrAE8AEdsYzG8TwLxcQX6ZvQBzNqVqum7kjcSkjU51x+Ej9J4Y3zEdBuX2e
         yD9qo3XkHSOpjuTZV9e+bBp1oaFNGn3Lh1r0NV8qZzWG6vQ9Yt5yPcQaYdT6aD8Sz62d
         Ef+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qMv6ZLPM7hCxbk7bCKDXLP5blGfXJiXsRRFE0KSzRnM=;
        b=pJoKVT9PSISr+WwWD9NLe3J6/NZchZAT2IZ0VWLRzAcxQ4ykSlSnAwWx4H7k5lZZ12
         /aBl3SJfYsTmaREiOnskGXSSbtfeOsyDAc2zJdxb7RRsLiQ0ZqkSjs0lNX1sy1R5/VCB
         efXwkJigfXwXbOj57TUqLT2eeuHnLka6Xgs/xsyypWy+3eDU3cnBe8JxV9l0priL0+g6
         v3jWcA2JkVOihesBpsOYbGZiW28hGjGr0sfuWNyxZrRz5KMO1BU64EZEyM/bXweT3vLv
         boSvTf5EQ6Du2MPszOIKHjhGj2032vIdP8pt++W4GOXpWmwQeMnDvvJn/WSN/aeJ/BHc
         tApw==
X-Gm-Message-State: APjAAAXWrsXCynA12CX9R+vv/hR4hDE5UEaLnV/4a3ImoAAsRwSo5bUA
        YORC3K8XPghMnuAcnT9NVztP3S9LqLg=
X-Google-Smtp-Source: APXvYqxjBVV2HWut3Uhndf/8dawGx2g1BP2+dy5Ls7Xve7ikklYlsJqyz0tVK8jAY7c8cg2Jjj86NA==
X-Received: by 2002:a5d:6b82:: with SMTP id n2mr41160739wrx.153.1577298963467;
        Wed, 25 Dec 2019 10:36:03 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id z124sm6495007wmc.20.2019.12.25.10.36.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Dec 2019 10:36:02 -0800 (PST)
Date:   Wed, 25 Dec 2019 19:36:01 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
Message-ID: <20191225183601.mh4doqri6teuf2am@pali>
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
 <20191225181840.ooo6mw5rffghbmu2@pali>
 <ad600bac-fd26-2d6b-85e6-372c072be9f5@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uavokmfwgobx24dp"
Content-Disposition: inline
In-Reply-To: <ad600bac-fd26-2d6b-85e6-372c072be9f5@kernel.dk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uavokmfwgobx24dp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 25 December 2019 11:26:47 Jens Axboe wrote:
> On 12/25/19 11:18 AM, Pali Roh=C3=A1r wrote:
> > Hello Sascha!
> >=20
> > On Friday 13 December 2019 09:04:08 Sascha Hauer wrote:
> >> ata_qc_complete_multiple() is called with a mask of the still active
> >> tags.
> >>
> >> mv_sata doesn't have this information directly and instead calculates
> >> the still active tags from the started tags (ap->qc_active) and the
> >> finished tags as (ap->qc_active ^ done_mask)
> >>
> >> Since 28361c40368 the hw_tag and tag are no longer the same and the
> >> equation is no longer valid. In ata_exec_internal_sg() ap->qc_active is
> >> initialized as 1ULL << ATA_TAG_INTERNAL, but in hardware tag 0 is
> >> started and this will be in done_mask on completion. ap->qc_active ^
> >> done_mask becomes 0x100000000 ^ 0x1 =3D 0x100000001 and thus tag 0 use=
d as
> >> the internal tag will never be reported as completed.
> >>
> >> This is fixed by introducing ata_qc_get_active() which returns the
> >> active hardware tags and calling it where appropriate.
> >>
> >> This is tested on mv_sata, but sata_fsl and sata_nv suffer from the sa=
me
> >> problem. There is another case in sata_nv that most likely needs fixing
> >> as well, but this looks a little different, so I wasn't confident enou=
gh
> >> to change that.
> >=20
> > I can confirm that sata_nv.ko does not work in 4.18 (and new) kernel
> > version correctly. More details are in email:
> >=20
> > https://lore.kernel.org/linux-ide/20191225180824.bql2o5whougii4ch@pali/=
T/
> >=20
> > I tried this patch and it fixed above problems with sata_nv.ko. It just
> > needs small modification (see below).
> >=20
> > So you can add my:
> >=20
> > Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> >=20
> > And I hope that patch would be backported to 4.18 and 4.19 stable
> > branches soon as distributions kernels are broken for machines with
> > these nvidia sata controllers.
> >=20
> > Anyway, what is that another case in sata_nv which needs to be fixed
> > too?
>=20
> Thanks for testing, I've applied this for 5.5 and marked it for stable.

It is this one?
https://git.kernel.dk/cgit/linux-block/commit/?h=3Dlibata-5.5&id=3Dd80f359d=
0ebddb3ab3e9cc3fe96f244827ae7b09

Because there is missing EXPORT_SYMBOL_GPL for ata_qc_get_active()
function as I wrote in previous email.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--uavokmfwgobx24dp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXgOsDwAKCRCL8Mk9A+RD
Ur2cAJ4uotJ5GOHvpyDmhcNG7VtbZ6NS+ACgnBe4SKSdgm/ikf17l0nZ+y4hGC8=
=oOQ9
-----END PGP SIGNATURE-----

--uavokmfwgobx24dp--
