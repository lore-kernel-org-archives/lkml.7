Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7365C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96E2B21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570558076;
	bh=ifH1xoY5aKoXuRXG3gH0QddZRG71GBROpP6PUecmN8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AsWWTrvLEha4Kl+lOulbhAF5ClDjFVcjTDgSAdZr0ahfQ5CBF+8Iwvr7p3WUf0VPb
	 LAaAH9RqDV0DzNaQILErCsMaIMKVC9SLksJW5Way/bws1zVtZcpB5Eznrcg+1v8bom
	 BlkMu0haVZHU+pcZiP268E8eJtVtU8ZhfKkH/QuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfJHSHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:07:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44886 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfJHSHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ifH1xoY5aKoXuRXG3gH0QddZRG71GBROpP6PUecmN8M=; b=LO5OnZQavdDW3QqNkTCBV9T8G
        uTRd6/urqYwDgEFhMjC/6Rv/unPEtinTBKAMbD184rdl0Pt0PbTB5EXjJSCInQXeptMuG8EOzQU6I
        GB2WJV7lLXZFeGDS1ARdka96UcQy9jjF6DPZIj97CgkTqDh4NPLVa4GSIU0RRavUzSWlA=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHttn-0000oC-AW; Tue, 08 Oct 2019 18:07:51 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7C7FB2740D4A; Tue,  8 Oct 2019 19:07:50 +0100 (BST)
Date:   Tue, 8 Oct 2019 19:07:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
Message-ID: <20191008180750.GT4382@sirena.co.uk>
References: <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
 <20191008120611.GG4382@sirena.co.uk>
 <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
 <20191008124736.GJ4382@sirena.co.uk>
 <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
 <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
 <20191008161535.GN4382@sirena.co.uk>
 <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
 <20191008171747.GS4382@sirena.co.uk>
 <439154a4-1502-40af-7086-d4e3eb24025f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IQvoI1rdlCKiYEYW"
Content-Disposition: inline
In-Reply-To: <439154a4-1502-40af-7086-d4e3eb24025f@gmail.com>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IQvoI1rdlCKiYEYW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2019 at 09:00:29PM +0300, Dmitry Osipenko wrote:
> 08.10.2019 20:17, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, Oct 08, 2019 at 08:05:03PM +0300, Dmitry Osipenko wrote:

> >> Maybe it won't hurt to disallow a non always-on regulators to be coupl=
ed
> >> until there will be a real user for that case.

> > I thought that coupling with the CPU core and main SoC power regulators
> > was one of the main use cases for this feature?

> Properly handling case of a disabled coupled regulator certainly will be
> useful, but looks like there are no real users for that feature right
> now and thus no real testing is done.

Right, sorry - I missed the double negative there.

--IQvoI1rdlCKiYEYW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2c0HUACgkQJNaLcl1U
h9BXzAf/a3jMX/noo6ORXwZCbU0W+bEKFBdN0mIzQnIFx2Ztn/BAEBMPD7Lj/5dn
xIHLvwI1LkQri9I8YKdz6iZPiHIvzsyg64X4aAdU9D6WPXg26pPUHc23/Z30x67h
tXk27uWLLLoYY45UXNoO3puKiLDB6UAyrQwLs1O3GnykKtr1BxUELCOZDnv7CH+v
YrmK0uB/jMC+/VuWGVYdrCvjT67v5BJTdFFvM3e+1+ecI708d+04fauscefUHScL
zTqOh42idqE1gbm3M052pwJ07A0UPBQUBjL0olVLhc6uH9DcjRTp8NNxPo1EMBCG
1L8pkjVtrS51Fx4Z0m9fAfIuCYhWig==
=hJR4
-----END PGP SIGNATURE-----

--IQvoI1rdlCKiYEYW--
