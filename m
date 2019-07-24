Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC56C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942F521951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563983228;
	bh=FwmPRKllAzntjK5E9t+ZYLyC2Q8gDB0GdefvEaM/FgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zi3I/aOFxN+YCZwKQN9Fu8kUJVWP0K1mzIHmHDcHhCH5ttIQyVa4FG/nxyyJW/BKj
	 S+kmZKNetrgeoNZYG42frregGZRn4xpy3pJ0L7vBg+OQUiEj0ToRqZed9f4O6zpREU
	 EDnX34wnd21klxPI3NR7JW2BVkecyVjlbyVXcQUc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfGXPrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:47:07 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46810 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfGXPrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Lc0mkWPof9czpbEXb7cNSa0n2Wy9n9hEIeQ5R+nh1pA=; b=SZDJlr4XdZYqHrB4X38XGVkwL
        ZdAtC7LvQC3zPXdxpHzoV2Qjr9g43GBFgkLxW0jKb6irlxrDYbH4Rj58dsKF8Te5kxVbh6n2Y10X2
        Aip6ne8WDMDRPwMb4/Zto3ZR/a6n5o6+KQaT60VHroPJz6JvqoOV8hL1A0+KGlisMKBaU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqJTr-000843-6B; Wed, 24 Jul 2019 15:47:03 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id EE34B2742B5D; Wed, 24 Jul 2019 16:47:01 +0100 (BST)
Date:   Wed, 24 Jul 2019 16:47:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: of: Add of_node_put() before return in
 function
Message-ID: <20190724154701.GA4524@sirena.org.uk>
References: <20190724083231.10276-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20190724083231.10276-1-nishkadg.linux@gmail.com>
X-Cookie: Matrimony is the root of all evil.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2019 at 02:02:31PM +0530, Nishka Dasgupta wrote:
> The local variable search in regulator_of_get_init_node takes the value
> returned by either of_get_child_by_name or of_node_get, both of which
> get a node. If this node is not put before returning, it could cause a
> memory leak. Hence put search before a mid-loop return statement.
> Issue found with Coccinelle.

> -		if (!strcmp(desc->of_match, name))
> +		if (!strcmp(desc->of_match, name)) {
> +			of_node_put(search);
>  			return of_node_get(child);
> +		}

Why not just remove the extra of_node_get() and a comment explaining why
it's not needed?

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl04fXIACgkQJNaLcl1U
h9BzAQf/ZfWikyCjkNyf2y3H8tRh9hTsozRRPTDoKv5OA0kXowXCRiDKEAethice
kw8J6gLF/zAM7fUi6I/ykCaUH1dZyj3a1y9CzA+Evr3GGd2YmzrgWWtdXlozaW1V
lCz0csOupoL+snIKL1tC91H44TSha1DFUNPP7Uup358cR3kTrZMItdtU6fuUVxG1
QsIdMw4b5ug4tzvZCvt/ZVytb32z4KA3Uq3o2i0LeSvJ9HlhNgzoLD8ii62kt9v0
Y5owkpGEZx/4BuEuz+nWtElBr81jNnUASu3mmwCfUDY3520yteS12/y1wAY/s19/
u2AucDlyR4q5gq5UuuxoCYD8f/oh3w==
=2N6g
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
