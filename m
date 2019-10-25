Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10777CA9EBC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62BF21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572015354;
	bh=3HY5xkcL3waNdiUvo8bc+2axOP3x1E6Q2gmPgBlTWHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jc8SgdO2G/ZrgR6sOtl5tWC8GAFaAB3hLRHSXzAEaalkuNgYiT9sS1sRSP9vdYJbb
	 lpZMxv9U5uA5ooDtgq71OKXVP2AnGOVAmtAEIJhyM7cIp268ur9Gp0GOQTnR64LS0z
	 +SxIxAbV3A8tTaNA5U3QTjWQmLCEqATCZSLU0g5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440501AbfJYOzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:55:53 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34370 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440053AbfJYOzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3HY5xkcL3waNdiUvo8bc+2axOP3x1E6Q2gmPgBlTWHg=; b=s13hcb4t+DXbrOebPbiMbu91j
        vCZJfiMajGWWOkIVIzG8h+qC2UsqCBhYg/prDJkcHYu+EGlht746lN4fivIdI+dzQiWoNd2jGt0xk
        K3LfAID8AgVKG15xkf51l6ExQcI6NuF6pqUaQqBVrk/N/4YPV7IwETAjNhMA7yr0oaPQk=;
Received: from host86-174-61-171.range86-174.btcentralplus.com ([86.174.61.171] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iO10H-00075N-Kz; Fri, 25 Oct 2019 14:55:49 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 25A0BD020AD; Fri, 25 Oct 2019 15:55:49 +0100 (BST)
Date:   Fri, 25 Oct 2019 15:55:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     daniel.thompson@linaro.org, arnd@arndb.de,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baohua@kernel.org,
        stephan@gerhold.net
Subject: Re: [PATCH v3 09/10] mfd: mfd-core: Remove usage counting for
 .{en,dis}able() call-backs
Message-ID: <20191025145549.GH4568@sirena.org.uk>
References: <20191024163832.31326-1-lee.jones@linaro.org>
 <20191024163832.31326-10-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L1c6L/cjZjI9d0Eq"
Content-Disposition: inline
In-Reply-To: <20191024163832.31326-10-lee.jones@linaro.org>
X-Cookie: Keep out of the sunlight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L1c6L/cjZjI9d0Eq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:38:31PM +0100, Lee Jones wrote:
> The MFD implementation for reference counting was complex and unnecessary.
> There was only one bona fide user which has now been converted to handle
> the process in a different way. Any future resource protection, shared
> enablement functions should be handed by the parent device, rather than
> through the MFD subsystem API.

Reviewed-by: Mark Brown <broonie@kernel.org>

--L1c6L/cjZjI9d0Eq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2zDPQACgkQJNaLcl1U
h9BdFQf9GRV0LJ9WwJAY7S57aFYatmIivP/nKOJ+/qqiSdu4nth9m8QtWh/XPk3b
8xpWSlntb1FKMtJoVSrdakR32vhFOIGFlKwZFnUoVPHypyoIyTbDsCZjS3+XO22I
w6kBayy5K+lX0YE9SUrOqBEZetfTvXtH6KW6WPaWZ5P6Qlducmhc+L1MYQeL7yAL
6Ap0l4pN60335m1X/uKkBXvcd5xU/OI/aCi/iq2i9/ZyLAYFpM/uelCNPKqkzD9t
92hhcIM1JZmrjHM9mciYunPDVkcx0lUAs1p0s1Zv3og1nGB/TtK6N6dO/urW4NYR
djYghBL9CB2Y18aYWhUG9pvedllWNQ==
=wgPo
-----END PGP SIGNATURE-----

--L1c6L/cjZjI9d0Eq--
