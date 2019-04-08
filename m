Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB49C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EE42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 12:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSfD8/5L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfDHM53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 08:57:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47101 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfDHM53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 08:57:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so16224189wrw.13;
        Mon, 08 Apr 2019 05:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RG4KSOrY/SdVG3PP97/1DBK8meGbkopeXRAfG50XFAE=;
        b=mSfD8/5Lqcyz7zh1PO6YrEe8Mgmt5t7sZxCPcBqrfBULgXB0yCj0O6LUziicEkhEpp
         yMCvcAUA4hHwxz/7yZ6/ANDuJyaAPJfKBI3UP61DlKWTNSFQV9qA7wInYG+ou725c2A0
         qMsRpVX6qVxsu6xP2GvubqvNyJv1LoApr7CcuqjHqNrOhFhvZSj9buHZXLXquK1uzxlL
         M5S5KC1j+v+byFlek3NutufMbAFmGg81gW9P/MCnmfLL/l/xCF20NoUYNHXfFv+inxsn
         EEe+gYJffrBjEvwkhRxFPqUllW4BaTGNGpj8/kLfS02iXfP6qZXelDD9an264G3vp7S9
         AJBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RG4KSOrY/SdVG3PP97/1DBK8meGbkopeXRAfG50XFAE=;
        b=gZsNXV2XaqpmLDvZ9doKRp2SyLHrhtsdLZnLqE4UtqMxFj3HEqA7kGM4kddeozoOPa
         oO+iTqqMHferLdDE2mdhxgLcBg8+OO6TDzh20GlfIAUddt6J5Bs7O37cQJQnOF22+2p6
         nb3ORWrDhSwuZZlHMDhtrY7LHwj+3qz2VFeTY9Lrs/IQKoH1q4JzR8wJVujtJ5Jp9pl1
         h+RvFTR0+HCD/Gl8b85uxlJj1cymmdqc2NWpQXRqo+24Pomtfx1hpqper3ZiX1s6aRhH
         IjP8QE3MXuQ4uvdHOKM7Wy7YACzmRTeNOslZaLLOzHBmZJIfZ1oMxMsaAoTxO9R8T6UW
         FVCQ==
X-Gm-Message-State: APjAAAWyw8hY00WszQKosIoEgRbGhC1onr6Muicv1YxOrCX+0zFaCHoy
        oQJjis4cicDCtuImJiObS4Y=
X-Google-Smtp-Source: APXvYqzlLG3ffGSrg0AVD6B83+9GQD5wUlp2cc4BT3d4vSwUAWAyT3dOXGhEsNDVfsI3US/tbEBERQ==
X-Received: by 2002:a05:6000:1111:: with SMTP id z17mr16540138wrw.103.1554728247112;
        Mon, 08 Apr 2019 05:57:27 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id u17sm10523100wmj.1.2019.04.08.05.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 05:57:26 -0700 (PDT)
Date:   Mon, 8 Apr 2019 14:57:20 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rtc: tegra: set range
Message-ID: <20190408125720.GG6644@ulmo>
References: <20190407211646.14962-1-alexandre.belloni@bootlin.com>
 <20190408102249.GC6644@ulmo>
 <20190408115406.GJ7480@piout.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
In-Reply-To: <20190408115406.GJ7480@piout.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 01:54:06PM +0200, Alexandre Belloni wrote:
> On 08/04/2019 12:22:49+0200, Thierry Reding wrote:
> > On Sun, Apr 07, 2019 at 11:16:44PM +0200, Alexandre Belloni wrote:
> > > The Tegra 20 RTC is a 32bit seconds counter (with an unused milliseco=
nd
> > > counter).
> > >=20
> > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > ---
> > >  drivers/rtc/rtc-tegra.c | 24 ++++++++++++++----------
> > >  1 file changed, 14 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/rtc/rtc-tegra.c b/drivers/rtc/rtc-tegra.c
> > > index c6b0a99aa3a9..3f93a1f7abb5 100644
> > > --- a/drivers/rtc/rtc-tegra.c
> > > +++ b/drivers/rtc/rtc-tegra.c
> > > @@ -306,6 +306,13 @@ static int __init tegra_rtc_probe(struct platfor=
m_device *pdev)
> > > =20
> > >  	info->tegra_rtc_irq =3D ret;
> > > =20
> > > +	info->rtc_dev =3D devm_rtc_allocate_device(&pdev->dev);
> > > +	if (IS_ERR(info->rtc_dev))
> > > +		return PTR_ERR(info->rtc_dev);
> > > +
> > > +	info->rtc_dev->ops =3D &tegra_rtc_ops;
> > > +	info->rtc_dev->range_max =3D U32_MAX;
> >=20
> > The placement of this new block seems somewhat arbitrary, but either
> > way:
> >=20
>=20
> Well, I needed it to be before the clk_prepare_enable call so it can
> just return and I thought it would be better to leave devm_clk_get close
> to that clk_prepare_enable call. I don't mind, I can respin with it
> placed somewhere else.

Don't bother. It's really just a cosmetic change and I couldn't tell you
a much better place without moving some other pieces around either. If
somebody really cares a lot, this can be done in a separate follow-up.

Thierry

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlyrRSwACgkQ3SOs138+
s6HzEQ/9ExhdNimQvOmx53R3w1xJ1Wk536aT0GLQDRqlWjzLPyUbvlZyzRfJ541s
uFOPMRmTyKrK8ovCzZBYJwXuUxOnErCdhU6zfRln6D6LWkf8Cufv89WcJzYMzOHn
EBJIm5+mhzOgZJKfk/fzYeZ+837PS9m+ngEWEG2suv6O3VE4//5gfM0ti4+31TyL
WcD1LOFMPW2YueYfQ1gsdnl+OOcOjahks3H+tSgfHyrJtHN/DlaKVT4NWvtMLWQ/
AcwaxECeb6REOeAgDMynYJgsX1blx+1ei7m1F0oRL5UIu4buDMVk4Pnimr+Iva41
+mprBE+AKrDKYwFU18lajbaj682asJSpraUxqC71rV9pf5Wx6Svg5UojvqxktE9G
dgQ+GDnsDX9TDwneRTwCK0CGQixlyPOEddiouO6NuLtLCO99jLnPTdQag9qk4T15
Ol3i0rQT8vJlW+VhOTsvzO9n5qgnOPxz0cP3fYrvM3cv1XFT4nax1/f1n1DJ4PbG
E7rfBQz+eAD4JE5bbh73zaCgmGQb7Y+kG0NSfwubId80wxO2bT4EMUlbQ2YQsLi3
CAw2P4QlSj5aO+sOlRFis8e9EE35x3Y+rRQk/xyFVM1+vRGUQmd15cYkBioueSZB
SQivmru56TP/JghItz6/pfCJNAGc/4j1GeTIJI3x7lMktDkL/HQ=
=sXSP
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--
