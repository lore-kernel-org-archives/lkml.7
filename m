Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1431C32757
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95F2216F4
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565775082;
	bh=Ofl1/hWIcIRo42Djcva0NjoYhZONVyEtRwTIhIhIKWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=in57zkHm7tyYwSUq5e4azF95YMXoZAApZWkgP2CkmwN5KPxpG8Yw3L069UoTPZhd5
	 3dJDm4vvFOvDVyueu+xuYmnkbBJ8mbEfOWHziOCsTNWPc8pd2PXgE01GBB6Vl2Eu8q
	 dJw7Lgbgxiv0a5oGD1H0Znkq6jM9dQ+GYe4EQIfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfHNJbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:31:22 -0400
Received: from mail-wm1-f99.google.com ([209.85.128.99]:34908 "EHLO
        mail-wm1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfHNJbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:31:20 -0400
Received: by mail-wm1-f99.google.com with SMTP id l2so3832899wmg.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:31:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wMvy8Ab385VnpfhpoCL2ty54WiU3FzsQ1ortdbnfmco=;
        b=HhPmsNTAE8tfoMpLy32Jjl1Aq2v8IaxQThU3H4AbKhbrMvG8wuxPwmiAmmCKHPAZh7
         OJiieGRSockjtWY8bNUYe3ngoXBt+iEauMOy1tjj+dIdjMQ8dNhz5+3WNJFWh3zdWP3G
         o2BsReDMvw1EBGS1APqSjEdy8Exh7qrna3gaC+KAWiwiDVuxu69Sl3K+ahYj1hvyUk0K
         FdpDi4/kB4aAiDhpNBjHO51/serrLZDDnZSHMNR0krbjQjGQUkIv1tDKjJcwW7+vpEb1
         h5WfXnnGCm1KjYlH5czWjPT/ktWvPPaJWz4o+V/g6nKreodVQptc//wjWaqeTjBQgiS7
         8Ahg==
X-Gm-Message-State: APjAAAWSB7nRzz3VhahWeCdarIge5N5L/aChCjyvp0EzrDWuwCiVANbo
        AU9KKlY1dz0cBkrH0v+d9u+1uv+tjL4W1764wXNL1gIzcgouOGO0uE2veEk0jFNbtw==
X-Google-Smtp-Source: APXvYqzfrYnvfYIbwxiiUHzAwojyOsQOmwL/wLmnyo7FHmFQeAvkAbkqtmXlkt7RBYKZuSs/1aQeX+6ryJZY
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr7192816wmh.129.1565775078088;
        Wed, 14 Aug 2019 02:31:18 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id q187sm28085wma.20.2019.08.14.02.31.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 02:31:18 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxpcj-0004j0-N9; Wed, 14 Aug 2019 09:31:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 281932742B4F; Wed, 14 Aug 2019 10:31:17 +0100 (BST)
Date:   Wed, 14 Aug 2019 10:31:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     codekipper@gmail.com
Cc:     maxime.ripard@free-electrons.com, wens@csie.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v5 03/15] ASoC: sun4i-i2s: Correct divider calculations
Message-ID: <20190814093117.GE4640@sirena.co.uk>
References: <20190814060854.26345-1-codekipper@gmail.com>
 <20190814060854.26345-4-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline
In-Reply-To: <20190814060854.26345-4-codekipper@gmail.com>
X-Cookie: Bridge ahead.  Pay troll.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2019 at 08:08:42AM +0200, codekipper@gmail.com wrote:

> +	if (i2s->variant->has_fmt_set_lrck_period)
> +		bclk_div = sun4i_i2s_get_bclk_div(i2s, clk_rate / rate,
> +						  word_size,
> +						  sun8i_i2s_clk_div,
> +						  ARRAY_SIZE(sun8i_i2s_clk_div));
> +	else
> +		bclk_div = sun4i_i2s_get_bclk_div(i2s, oversample_rate,
> +						  word_size,
> +						  sun4i_i2s_bclk_div,
> +						  ARRAY_SIZE(sun4i_i2s_bclk_div));

Are we sure there'll never be any new variants which would make a switch
statement for the variant work better?

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1T1OQACgkQJNaLcl1U
h9BePQf8ClHCMDk1/0p2riVMF+Ce3UctBx33fUNPHKz6fXoWHx15dRPn8E0YssEp
QxGtyceUz/+pupjQSBf9ys8YmRmQNnJDMCWoPKcEYsTMQUC20p4lu2RJ2Hs6ZwZp
GK78akZH7ZTALargNyecrfgGpMRhP8sZUxpCSWeviFQZp4W4SbafvXy1jv4jGz9q
i4LfJo4I5I1K7oGjfmW6QWU01EZkYWDFPV/2ulZNPN9qnQk6SLBzE/WLJJQ5pg6z
xSipsQlxBbboOT+6v/mfMovpO2qBSUTL3wzSRNJzANTc4BnZ+32IK1MpssbQ3EBC
o4F3ZOw6kp4o8QdLfGAfvJ9lfbYyNg==
=/pEP
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--
