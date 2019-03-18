Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C0BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA026205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 16:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqy2CcDO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfCRQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 12:59:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42772 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCRQ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 12:59:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so13812386wrr.9;
        Mon, 18 Mar 2019 09:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tIkCbUbQrbYd1sL06GRw5t0q5hZowRyKGfFCyoIw5x4=;
        b=Mqy2CcDOxUGpZrDAaSKGNQ1Lar3lBBfHvuAP4K6xW4F/rfYJUqfenSbfvTqhGZsD6O
         YjvdKHJM9/qR9A1ppz1VzHf9zscJohKxvkl9QDqw5aKpn7iGyhb5JfxBfjNp4NtUk+OT
         Ay2+oZX7B3uDNoJbIYehMFE7vstrJ3ACygqQDvfeffE7CWVWJycz+71nbkxEvlTFvNAU
         FdUru9S7lfhzPjvtKOVH0Q1qw/DcplSRyyB1fsb3OqNxDLKJv1URNJexZ/Sw0eXtjXNH
         xVJMK0IDQjtc0951hdkZxsa6lGZDzc3pTy0djZMIAeHVHCzUZkES+0OuCdbmjXIHhXdJ
         R5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tIkCbUbQrbYd1sL06GRw5t0q5hZowRyKGfFCyoIw5x4=;
        b=bafKi4YECN9pTGCJ1MrfnQAuacCy99nwdVgeIVwcNc5TMakevirCvJ/LldXALYeFjv
         bB6Lb2iJSvelCbTnpJe98e8fHbkp9ge/k78ftNe1jRXYpDNsA0tAQr5MvMZo0oClNen2
         LynQoSy8UpaRofbft2EU/rrgkFdmXXPYscKs0SMKu/mdZn6I0xX6JS5vN9imYkYNNl8b
         mbjgYzWX2qz3gl+TUXPsElXQc6/ou6fxxn7kswwKpyd5WNh3VZ5aVAHEN794D6u6CYvS
         HIrAvcIwQcJjRmCTApY4oIodO8vnX4eMhlV3v5E0ExCBD6MRXlggDq26bkG5G8Fu0oHa
         9rnw==
X-Gm-Message-State: APjAAAUXTPWF9i3K2cfeRFV7riBTwBTqAtVBvvusWrAL9Qpw6t5L/+xE
        gZjMR1IeGZazheD+qaqNbeE=
X-Google-Smtp-Source: APXvYqyrgvwdnqpVqWeIrrIwntvJg9j0d/GNWIvEQQaH4PasTusSamQKr86YqCdgKqd/VaK3W/DGmA==
X-Received: by 2002:adf:f70c:: with SMTP id r12mr13943721wrp.54.1552928367920;
        Mon, 18 Mar 2019 09:59:27 -0700 (PDT)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id c17sm10098407wrs.17.2019.03.18.09.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 09:59:27 -0700 (PDT)
Date:   Mon, 18 Mar 2019 17:59:26 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] reset: add acquired/released state for exclusive
 reset controls
Message-ID: <20190318165926.GA30394@ulmo>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
 <20190221152858.GA8652@ulmo>
 <20190318091216.GB14465@ulmo>
 <1552927250.7558.10.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
In-Reply-To: <1552927250.7558.10.camel@pengutronix.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2019 at 05:40:50PM +0100, Philipp Zabel wrote:
> Hi Thierry,
>=20
> On Mon, 2019-03-18 at 10:12 +0100, Thierry Reding wrote:
> > On Thu, Feb 21, 2019 at 04:28:58PM +0100, Thierry Reding wrote:
> > > On Thu, Feb 21, 2019 at 04:25:53PM +0100, Thierry Reding wrote:
> > > > From: Philipp Zabel <p.zabel@pengutronix.de>
> > > >=20
> > > > There are cases where a driver needs explicit control over a reset =
line
> > > > that is exclusively conneted to its device, but this control has to=
 be
> > > > temporarily handed over to the power domain controller to handle re=
set
> > > > requirements during power transitions.
> > > > Allow multiple exclusive reset controls to be requested in 'release=
d'
> > > > state for the same physical reset line, only one of which can be
> > > > acquired at the same time.
> > > >=20
> > > > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > > > ---
> > > >  drivers/reset/core.c  | 139 ++++++++++++++++++++++++++++++++++++++=
----
> > > >  include/linux/reset.h |  93 ++++++++++++++++++++++------
> > > >  2 files changed, 200 insertions(+), 32 deletions(-)
> > >=20
> > > Hi Philipp,
> > >=20
> > > the bulk of this is unchanged relative to what you had posted
> > > originally. I squashed in the few things that we had already discussed
> > > earlier (EINVAL -> EPERM) and a couple of minor fixes for issues that=
 I
> > > found while working with this.
> > >=20
> > > Attached is my fixup patch which contains all the changes I made on t=
op
> > > of your version and that I squashed into this.
> > >=20
> > > Thierry
> >=20
> > Hi Philipp,
> >=20
> > do you have any further comments on this series?
>=20
> Sorry for the delay, I'll have a closer look tomorrow. I obviously don't
> disagree on the implementation and I appreciate the added documentation.
>=20
> As for how to merge this, would you be fine with me providing a stable
> branch that contains the first three patches? That could then go into
> both reset/next and tegra trees.

Yeah, that's fine with me.

Thanks,
Thierry

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyPzmsACgkQ3SOs138+
s6E60Q/8C+YV1bw2+WoXIgMelxZWByBTkvnpFMiJvB+DtpmqPo04j1H+NJjzYlNn
1NMw/YPhjh4W5153Z1RrtOIHPyzvqs+lpm+rt8i8aT4e2AJGl7x1YcZE7Q8kuBIn
JUpZ2Sth34ErfKemoPCWxd+rDD6YpKjGFEY4FFAlrmLyDXdfNvadbvy/FCMM6vx8
GiX1Z1TKSf0BPvRISGJTO8iOcdZLSzn9xIzTPzcOExZI2Bdx0tsSTrnQU2fcQPbA
/NAdRkBL+cQCnm4QTtmEPbh+ndTop2a3MUHZLkoZVnd13gGYI8kRs4VmxR9ZG/cb
ajsLMZvs/R4xiLJ2OU30EDSLDCoSzzTFt3bhlQY04hV5cH02dwfWZCCMhfkd8WXc
3eM9nC0pyE7PtzsT4jRu9apalWwoCLikSnB8rwAO0KjPKoLh7/jrCqpBPm7TS2/f
FokVAh4QiCpGic3NSUbb9Ndfth1lrpPphrc+qn1sF13OH00fLNNxeqyFzalS7gd9
CJ8b0FRjImsIOJ+c+qhUwP03bnyMdO18KcHnEmGGWo/ODguZuefeOfEanH+tlTCK
8HHr7haJOMJ9vaBT1ZjISikUyyJ3UAzeLpeJp7P/4DjwU61ZrY7SY988QqGGbc6t
PhpH87PXRE40ciezZhyCDPQxVTE4UErE4zUPX3qzOif5oSUj8zE=
=kGHE
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
