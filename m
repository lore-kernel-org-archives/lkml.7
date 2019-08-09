Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61014C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D7C2171F
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565363479;
	bh=bIWTiMeUYnykHbNSF5Kxw8W8GsoGR8QuHVL9Nk+APwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=maoDHGOVt+/HshT0bZTgPIjne1lQPiFJvqihH+/TgFyXeA74JAta6xnsRIRCHbZIL
	 twWvFKFvjswHYHQGFHc9SdI+p8cQRgrU445jYa1pZCR7lNCJ6L05o4+1n5HliiTgOB
	 1EGTqpbrzr4ls+5hegmISWMm/fqgyDuA33m0pv1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407307AbfHIPLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 11:11:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44714 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406652AbfHIPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 11:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bIWTiMeUYnykHbNSF5Kxw8W8GsoGR8QuHVL9Nk+APwg=; b=Nb6IUUPzreGh345jUNoeNq8t0
        x4P7mzEyDG38v3zf2mB54dr8H9WxJs6O/sFjo4gRRpTpBmurxXEJwip0N/itBwRwfQPzu1G+CVFPN
        9lOimj0YunFhOgMZ6nTBwUmYNR0xfUQwelJ7xcS9eApRd7eOlFGURxleBwN76VsSLamt8=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hw6Xz-0006Ki-G6; Fri, 09 Aug 2019 15:11:15 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 37F48274303D; Fri,  9 Aug 2019 16:11:14 +0100 (BST)
Date:   Fri, 9 Aug 2019 16:11:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: core: Add devres versions of
 regulator_enable/disable
Message-ID: <20190809151114.GD3963@sirena.co.uk>
References: <20190809030352.8387-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline
In-Reply-To: <20190809030352.8387-1-hslester96@gmail.com>
X-Cookie: Klatu barada nikto.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 09, 2019 at 11:03:52AM +0800, Chuhong Yuan wrote:
> I wrote a coccinelle script to detect possible chances
> of utilizing devm_() APIs to simplify the driver.
> The script found 147 drivers in total and 22 of them
> have be patched.

> Within the 125 left ones, at least 31 of them (24.8%)
> are hindered from benefiting from devm_() APIs because
> of lack of a devres version of regulator_enable().

I'm not super keen on managed versions of these functions since they're
very likely to cause reference counting issues between the probe/remove
path and the suspend/resume path which aren't obvious from the code, I'm
especially worried about double frees on release.

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1NjREACgkQJNaLcl1U
h9BTwQf/eqfid6pFWWsC2XkcNrM+hxfvfGZELEmM6UU6BNiNRv5wbAWCDwfoW5ol
6NsV3LufKaBWz9ETFQGoDzXaUP6Vzfz+qz6/kcnRBT4CCt169NopcB4+92kPhO4s
lHlHczBN26rx9pQoEJNSYwXdNrhqgcjywUtWX4sTw2yzP+QSxMUcYIlGYkrh8LBl
laGfWsPWJJJxwcLqtP/iEVS1iBb5BJ9dvyfnWxpSLscg7QDxGQwgB/yiwTHE6lUY
C9ivrG/b0VUj4q8rY3kcRJZgRqNhLWYK0LtBJVvRPpulgeE66c1vtQ3IgTyAAlia
hd4LtLSWpAZ7r2s0Qe0jH2ol73qHmQ==
=HCBh
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
