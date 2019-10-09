Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4610C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878D821848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570630440;
	bh=Qi4PLv81q66n38J6ejNqiEYIPuUUxSxzgGAgibO/MIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qhb4pxATzrQO1PJTC1Yz5tz887l1Q8LGvYWvoYA30KNZImyi/qv//tbpBptKld5lz
	 ld3dR0XX/zS+3zbrRN4LwnIk30ZD6yNerydbnJvV1pewilH08j/e+dTY9k7eBa+28i
	 jPtmdrKydIuVPKJeJ9lP+jKK4npFebcsSROSCD64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731278AbfJION7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:13:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38506 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbfJION7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qi4PLv81q66n38J6ejNqiEYIPuUUxSxzgGAgibO/MIA=; b=XlsWNpaCBgOAMCQ6aVbxTyaZu
        NUC3bWBiTBT/J9H5Dmb7d8CXd2lKca+wVhWFcpX8x5VMRty4/pU668SQOq8yY9yKJE/8JJHu1eFT7
        eHJXP+euu8K6eDVnbpEsBW7+JgrB5fY3kT69pZ8SIl0Si9vZs/3c1LNawCgDq7W5b9VS4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iICiv-0004we-G1; Wed, 09 Oct 2019 14:13:53 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B00332741DF9; Wed,  9 Oct 2019 15:13:52 +0100 (BST)
Date:   Wed, 9 Oct 2019 15:13:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Kamil Konieczny <k.konieczny@samsung.com>
Subject: Re: [PATCH] regulator: core: Skip balancing of the enabled
 regulators in regulator_enable()
Message-ID: <20191009141352.GC3929@sirena.co.uk>
References: <20191008124736.GJ4382@sirena.co.uk>
 <86b9b4b5-cca5-9052-7c87-c5679dfffff4@samsung.com>
 <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
 <20191008161535.GN4382@sirena.co.uk>
 <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
 <20191008171747.GS4382@sirena.co.uk>
 <439154a4-1502-40af-7086-d4e3eb24025f@gmail.com>
 <CGME20191008180759epcas3p3c367142db499635c71d9601dd3e63956@epcas3p3.samsung.com>
 <20191008180750.GT4382@sirena.co.uk>
 <c9e3ff21-ec50-97c2-06cb-b2f44c70eac8@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JgQwtEuHJzHdouWu"
Content-Disposition: inline
In-Reply-To: <c9e3ff21-ec50-97c2-06cb-b2f44c70eac8@samsung.com>
X-Cookie: Every path has its puddle.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JgQwtEuHJzHdouWu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2019 at 12:29:00PM +0200, Marek Szyprowski wrote:

> Okay, then what is the conclusion, as I got lost a bit? How do you want=
=20
> this issue to be fixed?

We should revert the enable call, it shouldn't be required, and ideally
the default balancer could be updated to only make configuration changes
if they're actually required which would help avoid triggering any such
things in future if we don't absolutely have to.

--JgQwtEuHJzHdouWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2d6wkACgkQJNaLcl1U
h9BlRAf/YGiMG169n7MCXyjkc8bcLmLH7+9S3stdFllmTYuhOP/M1y/JQJmzzQwg
XDnAA2bX++oSN2E5ywHFEFnnEMStg5lUCHik0tZbf1SJNwS4O1XsuQaLS3tJajgQ
ForbctxszdR9Yb+PpwMsjeH1ke5L851Cxd6XjwIVhy8DMqY4vWhrriiojk6ZqniV
BLMMwT7B1fMwVqVqeLjOlwc7eZopT7cFim47sO1NfXizcuJ0eX9VthVh0HRnM294
92eCpqwgT1HTNmrkZgmnme9gWgbdB710n/G9w6Ez0/iC8fPp9S5OMyNA92ajbuMs
JpMjsKKdeYiEQe2ugez8CeAphm/pFg==
=ljBl
-----END PGP SIGNATURE-----

--JgQwtEuHJzHdouWu--
