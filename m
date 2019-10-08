Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FA0C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDAD0206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570549731;
	bh=JNzbLzDcXc87xmnkelg6rQOjzITocqo5lp2MvM726Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vsP4sjA26bC1U99CGI5kmw557R5dZ+Jlxvwjus71tD8KNqObqIwifBOmwuw23pOYF
	 IoVeSLPwit8PlcBK/+U9xxLnv96uZHUtSyK8kuttytSGvaF5pLShrp44D8veyy4gzd
	 uaPCXb3+NbtTg7s3sE3TuHrZIcmGmwtEfRymBiyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbfJHPsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:48:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37120 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PIZUg0Oa3MGso9tzbx/nd/Wklht6uzJyalmMLQer1VM=; b=Codb8f6MisVNUD3PDeMFVLQOO
        jdDVcgPSoU0iOm4HdH7fuMB+WVIsNjgGBzRkCrHNuHmxut1tkioFIq1oiudG8ZCEnm/ndws24EUhW
        U2+EVALOZmrFqtGQkmuMMCjuqvngazjL8DyjA2OPkwXBypBM3vrKltAHG/EA8KSSNuXL4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iHrjB-0000O0-Mx; Tue, 08 Oct 2019 15:48:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AF19A2740D4A; Tue,  8 Oct 2019 16:48:44 +0100 (BST)
Date:   Tue, 8 Oct 2019 16:48:44 +0100
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
Message-ID: <20191008154844.GM4382@sirena.co.uk>
References: <CGME20191008101720eucas1p2e0d1bca6e696848bf689067e05620679@eucas1p2.samsung.com>
 <20191008101709.13827-1-m.szyprowski@samsung.com>
 <20191008115025.GF4382@sirena.co.uk>
 <0e222fdd-4407-51ea-b75c-a62621cbe622@samsung.com>
 <20191008120611.GG4382@sirena.co.uk>
 <9268b455-ec66-97e1-909d-f964ac31c0ef@samsung.com>
 <20191008124736.GJ4382@sirena.co.uk>
 <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QqzFzR/RUlLahzby"
Content-Disposition: inline
In-Reply-To: <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
X-Cookie: Do not disturb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QqzFzR/RUlLahzby
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 08, 2019 at 03:24:17PM +0200, Bartlomiej Zolnierkiewicz wrote:

> Commit 7f93ff73f7c8 ("opp: core: add regulators enable and disable")
> currently can be safely reverted as all affected users use always-on
> regulators. However IMHO it should be possible to enable always-on
> regulator without side-effects.

With coupled regulators you might have something kicking in because a
change was made on a completely different regulator...  If we don't take
account of coupling requirements we'd doubtless have issues with that at
some point.

> When it comes to setting regulator constraints before doing enable
> operation, it also seems to be possible solution but would require
> splitting regulator_set_voltage() operation on two functions:

> - one for setting constraints (before regulator_enable() operation)

> - the other one actually setting voltage (after enable operation)

I don't follow?  What would a "constraint" be in this context and how
would it be different to the voltage range you'd set in normal operation?

--QqzFzR/RUlLahzby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2cr9sACgkQJNaLcl1U
h9BXUAf/RIbUmUSu6zGVv3srXuV8KnuydZCjPiPMkIelBiSu7RSvLATKLqNqlwBY
x1g4Juy1G+35SyaWtq/xZLRG+ZuPkM/LVhIgS1Um3fwnmtAVzV0LfJwwYcGrBQgu
r+/jh59o7qvEwIJb96cbQZLAaEEnKgK2IbbUknyVVa/YMLKKK/uivkFAeVP/t4Rc
fnG9lsDLZYkK8IdyJjFnZf96l1ONZVPUQ8GgI52bxl6szXy588MSzhERreQ8h9kg
BDsxxlGGPYG8vM17fFbzQ4E1SUwEZmWHo7otFKIJSl2ctuurcGpJpp/mCfYl0wl7
qVOA1l/WDyWdvk6L+gCNfkhWmtgSKQ==
=KF++
-----END PGP SIGNATURE-----

--QqzFzR/RUlLahzby--
