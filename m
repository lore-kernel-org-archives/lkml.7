Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAA4C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3C0216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIEK0D0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfEUHrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:47:40 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44338 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfEUHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:47:40 -0400
Received: by mail-lf1-f66.google.com with SMTP id n134so12243863lfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 00:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=Dicc+T9IrDxp0fnR3m1/jrj3BxuxAv88P1pataligq0=;
        b=rIEK0D0ur9pEw2gBKsrNFfy61GB9tHacmVMuAxNZpTngVh7JPLrdVNYKTA9rxA5ayr
         hb4JurJ8TrB7dZDiYlfeXBKGMlx/QVxKEb3VjKV8UnJvHvmUptaVBoD9oBooruylq1xm
         llxuAUsftE7/kKnyzI4nn7+X12/qkltPGk7vKzRhIU+rN7l+5IqSV2inA8xmwF7p0bOA
         /QK+yMv7MTryf22K8dJK64z2b9ISQjqPY5WAII84EnFeLhquDC1/TOAWkPeMBl+hSVZj
         xjZO2rOehyEx4CAxsvcRUnZJc9GwTrZ13jr6ETfTtZRtlR4gG3uKwVn9WKkZzh6MlwGQ
         O9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=Dicc+T9IrDxp0fnR3m1/jrj3BxuxAv88P1pataligq0=;
        b=reu2lWBgZa8GMzY8oCShhJ00OWHjqPvEhlCSPmgp1ylq0FP1DtL10MCm/ZQAKQk0Tq
         TnZB8rLgbwyg4kCWx1dSRsn6N66QjnTJ8hL0s5zAwXvWpI2ERUk4PGX0SQdaAOMgLhFs
         V+/SWZsA4xtI5f/iBRpDo6noP5jqgXnOYmoyHNv8/HFBXqwbToErrJ/yb1xz1g2BhWjR
         35vSRzs8Wl3umsZsdKPanRwMUSNdr6JXmZT85S2YXfIbnFXcsJxly+pJCV+Mft9zy4+P
         DPLFxluNZ8vvEqb7OxXQVWQz277KKVbysdv8li/Dk7h/DE8LgCbkMBWco/62mp+xNHBB
         eeEw==
X-Gm-Message-State: APjAAAWGKDVH3ElyXemgx2qOvICu/2IfCmU4/clXjfuEMNtw27XhYOeI
        imu5IOAgJNqKJ6agvt8FSuo=
X-Google-Smtp-Source: APXvYqx3go6kPaFZQ3cGHhye5zwX3TDp0V0lC9ovkdIoqZbVs6B2OSdU0om6gVOq2Pj5Ewo4Ya60yw==
X-Received: by 2002:ac2:4428:: with SMTP id w8mr35404633lfl.99.1558424858066;
        Tue, 21 May 2019 00:47:38 -0700 (PDT)
Received: from eldfell.localdomain ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id n26sm5342617lfi.90.2019.05.21.00.47.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 00:47:37 -0700 (PDT)
Date:   Tue, 21 May 2019 10:47:34 +0300
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/doc: Document expectation that userspace review
 looks at kernel uAPI.
Message-ID: <20190521104734.2d8853ac@eldfell.localdomain>
In-Reply-To: <20190424193636.GU9857@phenom.ffwll.local>
References: <20190424185617.16865-1-eric@anholt.net>
        <20190424185617.16865-2-eric@anholt.net>
        <20190424193636.GU9857@phenom.ffwll.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OliU07hw75zzQ=tC8_AG_Hi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OliU07hw75zzQ=tC8_AG_Hi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Apr 2019 21:36:36 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Wed, Apr 24, 2019 at 11:56:17AM -0700, Eric Anholt wrote:
> > The point of this review process is that userspace using the new uAPI
> > can actually live with the uAPI being provided, and it's hard to know
> > that without having actually looked into a kernel patch yourself.
> >=20
> > Signed-off-by: Eric Anholt <eric@anholt.net>
> > Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > ---
> >  Documentation/gpu/drm-uapi.rst | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uap=
i.rst
> > index 8e5545dfbf82..298424b98d99 100644
> > --- a/Documentation/gpu/drm-uapi.rst
> > +++ b/Documentation/gpu/drm-uapi.rst
> > @@ -85,7 +85,9 @@ leads to a few additional requirements:
> >  - The userspace side must be fully reviewed and tested to the standard=
s of that
> >    userspace project. For e.g. mesa this means piglit testcases and rev=
iew on the
> >    mailing list. This is again to ensure that the new interface actuall=
y gets the
> > -  job done.
> > +  job done.  The userspace-side reviewer should also provide at least =
an
> > +  Acked-by on the kernel uAPI patch indicating that they've looked at =
how the
> > +  kernel side is implementing the new feature being used. =20
>=20
> Answers a question that just recently came up on merging new kms
> properties.
>=20
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Hi,

for the record, I personally will not be able to provide such Acked-by
tag according to kernel review rules, because I am completely unfamiliar
with kernel DRM internals and cannot review kernel code at all. This
might make people expecting Weston to prove their uAPI disappointed,
since there are very few Weston reviewers available.

If you meant something else, please word it to that you actually meant.


Thanks,
pq

--Sig_/OliU07hw75zzQ=tC8_AG_Hi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAlzjrRYACgkQI1/ltBGq
qqcAjA//e30nrMgcjuYTZipx7Pb25l9/mASh6SM6RkiQ/qsh3YZV9LTfG+EPXvoJ
xx3wpdCqTnrCgV4h4jo91a1C7TaKAfaSNwmN9cw1N1A2qi/bMNA5B84mT6Mgc+hD
LQF1qkEecc6czCOnrqubvH1xY+ApZTmYwktjGPLinpJA/TFa9QYggoRvJE76XuHi
Vs99hYkCHHQQVPzKMnOkFhIRsuvGOy14K/L3UAWyCT41qfTIMN43O6eBXMr6e31Q
RLo3051KHVq4+Rsdszyg870435Anf+efve1ihs1DEMB9I1olxZLbiAtvjGIh+V21
XMbeRfSYeVQg4ANfB+aIPRwwOIc5a6uJzto5UmVVJw3TFLPVS9BUWfsRBCG9q2m8
h6y5L+9f5XDlmxXELBAg5kpOkk/BQYUBmvhFH7kiMNDusv7sVeMYHXETlk7p5+FL
r3KpX74f4UiyzwjvxqHsN4GLW9rXjywTnPxzKXHnhtb4AYIxwQPb5BTiWoWxc+Nn
wK4oQI3Jucxwrk9vidHNfB5lz4uyVGqs9cUN810ZoW3JzGJOsvdoYtu7UlF423yX
SWIMZWA9AgiNUYGzQRbep+YjSCRPIMKXK7KOQopOK+WBxmp2/0cmxB1GeMbT2DLv
urtj+KzuU6p2hNVc1MDfM1W6Q6rCBk/z77dZQ3S2GJ3dZ4TMQI8=
=IAUN
-----END PGP SIGNATURE-----

--Sig_/OliU07hw75zzQ=tC8_AG_Hi--
