Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355C5C34985
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B05024721
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269389;
	bh=ViD1FRml6BgL1h2XOa1IZE2/53ae7s0loyDYVZNuIqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=owVUlPTuestfEU2Yy9wZ4UuZ1VNyRx3nvqFMsmOK/+lh3vP9zbThyFNyt19sb7/mm
	 5TnWI475TBtH4rlrOlpZWXnGf7wfJIbvewEZtcEVVoFSj2ilgVwP39UQNjNsbMrD4J
	 NtNDAvWqYvhcU7Fd7LVEbqTby7FxGVlepEk92QAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLMLll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 06:41:41 -0500
Received: from foss.arm.com ([217.140.110.172]:56068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfLMLll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 06:41:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA0301045;
        Fri, 13 Dec 2019 03:41:40 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2911E3F718;
        Fri, 13 Dec 2019 03:41:40 -0800 (PST)
Date:   Fri, 13 Dec 2019 11:41:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-spi@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: bcm2835: don't print error on clk_get() DEFER
Message-ID: <20191213114138.GB4644@sirena.org.uk>
References: <20191212231213.29061-1-jquinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20191212231213.29061-1-jquinlan@broadcom.com>
X-Cookie: Life exists for no known purpose.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 12, 2019 at 06:12:13PM -0500, Jim Quinlan wrote:
> Otherwise one may get multiple error messages for normal
> operation of a clock provider.

>  	if (IS_ERR(bs->clk)) {
>  		err = PTR_ERR(bs->clk);
> -		dev_err(&pdev->dev, "could not get clk: %d\n", err);
> +		if (err != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "could not get clk: %d\n", err);

On the other hand if the clock isn't there and never appears then there
won't be anything saying why the driver isn't loading which won't be
helpful when trying to figure out what's going on.

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3zePEACgkQJNaLcl1U
h9BHDQf+Kf+RYd7moLj8bCbIPnaZZ7Nsho3jFNQaB96HmWNc0rO3oRC2CHPcW7Az
EAw9GHh64sKQ+iLsXXIj5WhkBFfx0XsQ4uRSMCHwvpfnYaWw9a4ntAYr8Q6D7T5Y
RZQgixN7JobxgbUrL50FdhBJFz/Jjcc0a5N6xYrD8xNQDFlmnMtmqVpN9PBQlzp5
hdDU5eDqz0ncgiyJMsMUoEyoUtdjXJKWFcJtuEJ51bi/ken7MVU/m3CO806jkW9O
jk+OV2OMytB67pvLZyenL7pXLmkpP45Vpcb+elTkBBFiTDOsNsWkBxEhrQ1qxowF
Db335irZY42aFsjJkwvOx+C8Nc+qIA==
=EGVJ
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
