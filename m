Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F37C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D299B2067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570715716;
	bh=pLQj4V3i63vFUYd0g5ePUI+/Ipp4Xi+oTg6pYl6S8c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qljNaQ4HmP1xSoBELU2i21o/5GjzACh+wFQeREAH8/rYED8jGrpjU5242PSUHPD9S
	 Wo/0txEgcKycNXYksViS3rdNlI9p2wLbFXkRZJ+83Ewr9SKveYI8xhK551P8Gp+Juy
	 kHee09N07zGHql18YhQzsy7xVsy0qiwEz0YRCKqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfJJNzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:55:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54786 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJJNzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=pLQj4V3i63vFUYd0g5ePUI+/Ipp4Xi+oTg6pYl6S8c8=; b=DbKkj97yxH1WOlu4FqZ00/kBc
        6avPtx+noy7lr7yBDs0bM+B8502RI4Q6khSJL4sWkbCDeL5sJIgPiFTTTf/1L3bKK/2I9DvBE4zDQ
        i91t0R4KxxlAizdAguwuOpfGsmzR8ZIfLKwnAosipeNYxbSKgLDC8NY8dqJaeO2DN75ZY=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIYuK-0001TV-Jl; Thu, 10 Oct 2019 13:55:08 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 8E981D0003A; Thu, 10 Oct 2019 14:55:07 +0100 (BST)
Date:   Thu, 10 Oct 2019 14:55:07 +0100
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
Message-ID: <20191010135507.GS2036@sirena.org.uk>
References: <be8d3280-9855-ed18-b2ab-d7fb28d80b82@gmail.com>
 <20191008161535.GN4382@sirena.co.uk>
 <4ad890b7-705e-94f9-2e61-1f3a60984c91@gmail.com>
 <20191008171747.GS4382@sirena.co.uk>
 <439154a4-1502-40af-7086-d4e3eb24025f@gmail.com>
 <CGME20191008180759epcas3p3c367142db499635c71d9601dd3e63956@epcas3p3.samsung.com>
 <20191008180750.GT4382@sirena.co.uk>
 <c9e3ff21-ec50-97c2-06cb-b2f44c70eac8@samsung.com>
 <20191009141352.GC3929@sirena.co.uk>
 <c1a50291-5260-357d-1701-47526dbcd62c@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m2KU9Mr9JJKQaAoQ"
Content-Disposition: inline
In-Reply-To: <c1a50291-5260-357d-1701-47526dbcd62c@samsung.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m2KU9Mr9JJKQaAoQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 12:19:55PM +0200, Marek Szyprowski wrote:
> On 09.10.2019 16:13, Mark Brown wrote:

> > We should revert the enable call, it shouldn't be required, and ideally
> > the default balancer could be updated to only make configuration changes
> > if they're actually required which would help avoid triggering any such
> > things in future if we don't absolutely have to.

> Okay, Then in case of regulator core - do you accept the initial patch=20
> as it indeed forces the default balancer to avoid unnecessary changes,=20
> or do you want me to rewrite it to assume min_uV =3D current_uV for the=
=20
> already enabled regulators during the initial balancing, like suggested=
=20
> by Dmitry?

Neither, I'm suggesting you make the change above.

--m2KU9Mr9JJKQaAoQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2fODoACgkQJNaLcl1U
h9CH9Af/a7DbnGwYMp29eLd4J6U14L9PHlZEslj/46R5/OmCgxVycQejbXAZRHwg
CLPcrsFx/1JnedK9CoxYw2Qo1WJvE5K0pxwnZ5zJLFfT4MZFofI468OHQcYqHAXX
ZyJw5iZAqJ9ATGInZoCvaBL3Tde2uXqazxPAOZRull7BdSgmc5noRIOOdqV8a1mv
n+tGJNiauaP7qAa7ZJtEdsJzPHjbNdtOWruKQxgPSE9KRLbq2fIQRG2ZtUo7fds7
+YzwfQtXOoX1XVD7aoqbWYyNAkl6taMDRzy7UhUbUiol7/knCoG4elvuMRRPAKrK
V7mXpb9I4a9jtCf5FW4akaeiqqkOmg==
=e3x+
-----END PGP SIGNATURE-----

--m2KU9Mr9JJKQaAoQ--
