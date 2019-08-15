Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFF6C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F642064A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 11:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565868380;
	bh=nXAyjVHn0p+4CAgtCNYorSwp/PP+/ZyXWDDK+y7KYL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ap6EACMemE2ooq6gZ/YVZpSOBmLLohUnfn7f1B0bzyoNbo6rJ4CAYl2FGaspnyHuE
	 2UyMb67DXZ/pyhHrgk6hFY1cqOJNqBUO0b4vO5F3cad0CJeksgeKU3rHSYge2WCEHx
	 8JVvHaFjOAJxIAqJTDLHUqyaEf2zTcPazeF8wO7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfHOL0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 07:26:19 -0400
Received: from mail-wr1-f98.google.com ([209.85.221.98]:43866 "EHLO
        mail-wr1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbfHOL0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 07:26:18 -0400
Received: by mail-wr1-f98.google.com with SMTP id y8so1892382wrn.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 04:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXAyjVHn0p+4CAgtCNYorSwp/PP+/ZyXWDDK+y7KYL4=;
        b=IawdMUW69SR11nfPfNbrOhfIPhS6hoc3hPZ++c/GO6RRqKsVHJh6eI8diwNTWu3M+5
         lzhGq7CczoPzBSnvS32q0B9J5ar6iMqdAqpvKEclHWIXR+ifCPl1/dHWavJT1laCUSF1
         tk4+Wj1l58AIAxKyx1rHrDN53ibzx2+VQkUzg5HopsZhzO5Og/CmF6qfD0YvfB28SYCY
         1ApqIUAX5Pumv/vrDyIjPpUYau0AvpvvJ0pQbPR2oCLTeGccGEBtYW4dErYW/pLQtD3h
         DFbgtjSCewhCyMmqUFE4LL2gUThsv50/mKtS0e7oGRSL3B7ZWkBUARW4xszwI1N2WoFt
         Ch3w==
X-Gm-Message-State: APjAAAVUhHKg0R6c7d1k8tqQYIG3mcGxhMuBpuR9db8z1YSjvr2cvxNy
        2yyhLV0lchCjbpimQ9k+INwGSqKnA/oSplAwNVD+d5fYqTU2f7PIJ11NLlfZ5ltKxg==
X-Google-Smtp-Source: APXvYqwE8AmkN+3MXDrwKQaFOiSfludhujVv2awbLexD+71rwuqfo/tkaDpNPzNDAfUOBE6TTmh7ETRU8D4R
X-Received: by 2002:a5d:5543:: with SMTP id g3mr5069751wrw.166.1565868376359;
        Thu, 15 Aug 2019 04:26:16 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id n3sm41979wru.48.2019.08.15.04.26.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 15 Aug 2019 04:26:16 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hyDtX-0003HY-Th; Thu, 15 Aug 2019 11:26:15 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 033DD2742A76; Thu, 15 Aug 2019 12:26:14 +0100 (BST)
Date:   Thu, 15 Aug 2019 12:26:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        enric.balletbo@collabora.com, guillaume.tucker@collabora.com,
        khilman@baylibre.com, matthew.hart@linaro.org,
        mgalka@collabora.com, tomeu.vizoso@collabora.com,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clk/clk-next boot bisection: v5.3-rc1-79-g31f58d2f58cb on
 sun8i-h3-libretech-all-h3-cc
Message-ID: <20190815112614.GA4841@sirena.co.uk>
References: <5d54d2fd.1c69fb81.e13e5.7422@mx.google.com>
 <20190815040221.DE28F2067D@mail.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20190815040221.DE28F2067D@mail.kernel.org>
X-Cookie: MIT:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2019 at 09:02:20PM -0700, Stephen Boyd wrote:
> Quoting kernelci.org bot (2019-08-14 20:35:25)

> > clk/clk-next boot bisection: v5.3-rc1-79-g31f58d2f58cb on sun8i-h3-libretech-all-h3-cc

> If this is the only board that failed, great! Must be something in a
> sun8i driver that uses the init structure after registration.

The infrastructure suppresses duplicate-seeming bisections so I'd not
count on it, check the reports on the web site.

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1VQVQACgkQJNaLcl1U
h9CXxggAhQAYqpIA036IQyAKgnQ2F/AJYfCXVuQIqvyJUzJcymafEwN1LN7ZCTGO
OYXotEHUAo0yWqEZHGYRT80yqKRDeaVSUYJ33xCHJEZXIuMULFRie3d5Qa62BejZ
kc1DtLpAWExTsK5KJA/vUAIFqiISlVFSU/XXQGx+nc1kEYMeobT6IkkZLxZhyEZ5
ft2eUwlXieQEtNHFQo2B8OmJMfjGeBTUkeSb/A8XYrAPmyvDxxBf01kyLSclZmvs
Q9ddNUKGQdhwsMlr216GOhBxtPDl6fXaKxvNaX37lzYKbTVZjYjcVfvhR1AeCJ7a
59WliRvBt6vgidBtATvY/5bgJaQY1Q==
=4B/b
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
