Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5907DC4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2956420815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570551683;
	bh=f8LtTLcSLuwcW0QEx0gKm4OdVi730CGRB5XVZy9gLQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rL9q5eAbU0vbICbsN5QIWndDIuVDY0vz/r4c+XvXm7FUM6RIJlGmEZliK4W8WwwIH
	 lBiHkEWpXx/SeW4QdwEmMK98SfzRYY7DJW2/Xdu7c5/n0d17ONk87bTAOds8u7yOHo
	 zjKSnpmiFFV4cUD0rcGj2DvJ14BFll1jgYCqRroU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfJHQVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 12:21:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35280 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfJHQVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 12:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f8LtTLcSLuwcW0QEx0gKm4OdVi730CGRB5XVZy9gLQg=; b=FEHW7M9ozNSp3kKRM635g6370
        0YtqMtXSvk/FaKyKfYAg2Za2hL9Fx/PwVWU0ur2/MykL+au7adCUWYFYuO0uxFtMDJqG+UdQxhmOB
        GKAYV3MMPncHmVlvddxXnQ+u7X9UgiBHC2wUtslHeaOFRCG6Lk7rvsa2yeWDikRHdCNFw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHsEe-0000SG-1u; Tue, 08 Oct 2019 16:21:16 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 41A2C2740D4A; Tue,  8 Oct 2019 17:21:15 +0100 (BST)
Date:   Tue, 8 Oct 2019 17:21:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
Message-ID: <20191008162115.GO4382@sirena.co.uk>
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
 <20191008101709.13827-1-m.szyprowski@samsung.com>
 <20191008115025.GF4382@sirena.co.uk>
 <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
 <20191008120611.GG4382@sirena.co.uk>
 <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
 <20191008124736.GJ4382@sirena.co.uk>
 <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
 <20191008154844.GM4382@sirena.co.uk>
 <86eb668d-7bcf-798b-dabb-95071d16cbb6@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w6U88vdWm8UqIXvc"
Content-Disposition: inline
In-Reply-To: <86eb668d-7bcf-798b-dabb-95071d16cbb6@samsung.com>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w6U88vdWm8UqIXvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 06:02:08PM +0200, Bartlomiej Zolnierkiewicz wrote:

> Taking into account your remark about enable operation on coupled
> regulators and Dmitry's mail about cpufreq issue I think now that just
> dropping opp change is the most straightforward fix.

It's certainly the most straightforward thing for the immediate problem.
I do think we probably need to improve how we're handling the coupling
though, we've got some fragility here that needs addressing.

--w6U88vdWm8UqIXvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2ct3oACgkQJNaLcl1U
h9Dj8gf/am+aDjhH0XOJytk0p4raEeJSTiqQjIosjRjvn4bWBbFEjKG4sA7Y4Lic
TbeAtFH9Gufpb9nzkff0yT8dH/rxZAb5VL3fPH59Q/4J7GyokfRg4j/0TX1+3V2x
DzPoSUY0fWgomFr/FoKPZaV3lxCFKuaCxfGSXkwoz8S+yr9rC2TrnehWsCux3F5V
wlLQzyjlno+RZRZV57Xgo/zSNNIWjHAEiLP71xABACYhQNSCSQ7iyotrOD8br5je
Fj7YEPNg0Z8qJrPxqjMbOhUJzQFxNuBbGbzHWj8+07YYAnKXYY5ItMcdmJSkC743
8QYm7pCKTBVlAP1hU2AgmJjOOvbfHg==
=hr4I
-----END PGP SIGNATURE-----

--w6U88vdWm8UqIXvc--
