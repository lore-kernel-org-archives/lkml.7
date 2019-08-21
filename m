Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E431BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B706F233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566389292;
	bh=zjmvqrjsQv00HC5aaAd96gIHsgFrT6bN1XFDyQLh4ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kxoUWCb3BHR47IbNn+gOyn9ZSBP3OyN7lG3ATp3Gg5UbfUzx6zeUMU6dk4vRWAZgJ
	 8yTVQej3CgXKURk5G/SgQYuWKAguAExkL4O8jsGKOPNm9hv/nwTkRhMgm2ipEGaxqm
	 ZkhYO4T1hJocTpZwL0zTb+oZ1WEJF+P7BPCmQetA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbfHUMIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:08:11 -0400
Received: from mail-wm1-f99.google.com ([209.85.128.99]:53860 "EHLO
        mail-wm1-f99.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfHUMIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:08:11 -0400
Received: by mail-wm1-f99.google.com with SMTP id 10so1854472wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 05:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kCia8y54afQPSOKfbJ6YP0Hz0JmyKVXFLXw8vTgYgYA=;
        b=V+yV6OLh+exFoQ9YCNEk5neCd8B64dnonuTgqOF+ikPBOo7ad/riviABfg4hAIhinV
         nn34OWat5m50eAPq39ohAFSmhESzNdd1YPNuOOABm1Ab3mqvQdlsNMLxkq5H2bOkyLcG
         iEhBIB/1YMv42XroItP5MEeMcxyZf+IKTb/IesdTK11NSQg1jKkTjGay5tOuKqCYiIL2
         qF3tgWGu9iN68GAcgnTTXMZ9jaVm1Risc76JSl1Uk6BMmvk+XA7mckjFn9GsEwIO47lC
         K2Zye6DQGsyb5xmFuFyuj362HvwF5EXMnJxVGyXyeSRQib8C4mWsZOMgBtnbE1LhGegY
         OK4w==
X-Gm-Message-State: APjAAAUMP5Rcb3gvJ6M2bQqIE9vALN4SqyiJs4LblVaAT4pF4uH4d7sz
        5JFi8YHT2qzBcCDJlmmfyMhRlnW0pLt9TOYuD4RXM7xTYA9F9SiRlbZMosKAltARYg==
X-Google-Smtp-Source: APXvYqzuQ8bH+1TsxqU69uRaOBY2/y1+B6n2c5MTJ9/QfG2PsqZGzaDYCsMRsmkgt4FC5QflkDnHSyQCXkfS
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr5677124wmu.67.1566389289363;
        Wed, 21 Aug 2019 05:08:09 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id b193sm25529wme.10.2019.08.21.05.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 05:08:09 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i0PPN-00075k-2B; Wed, 21 Aug 2019 12:08:09 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 04C9E2742FCD; Wed, 21 Aug 2019 13:08:07 +0100 (BST)
Date:   Wed, 21 Aug 2019 13:08:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Sergey Suloev <ssuloev@orpaltech.com>,
        Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com,
        codekipper@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 20/21] ASoC: sun4i-i2s: Add support for TDM slots
Message-ID: <20190821120807.GG5128@sirena.co.uk>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
 <26392af30b3e7b31ee48d5b867d45be8675db046.1566242458.git-series.maxime.ripard@bootlin.com>
 <c311e88a-fdd2-8a01-275e-675d98dc90ba@orpaltech.com>
 <20190821120551.r4b3h4nnet357wem@flea>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NY6JkbSqL3W9mApi"
Content-Disposition: inline
In-Reply-To: <20190821120551.r4b3h4nnet357wem@flea>
X-Cookie: Sic transit gloria Monday!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NY6JkbSqL3W9mApi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2019 at 02:05:51PM +0200, Maxime Ripard wrote:
> On Tue, Aug 20, 2019 at 08:46:30AM +0300, Sergey Suloev wrote:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > >   	.set_sysclk	= sun4i_i2s_set_sysclk,
> > > +	.set_tdm_slot	= sun4i_i2s_set_tdm_slot,
> > >   	.trigger	= sun4i_i2s_trigger,
> > >   };

> > it seems like you forgot to implement sun4i_i2s_dai_ops.set_bclk_ratio
> > because, as I far as I understand, it should alter tdm slots functionality
> > indirectly.

> As far as I can see, while this indeed changes a few things on the TDM
> setup, it's optional, orthogonal and it has a single user in the tree
> (some intel platform card).

> So I'd say that if someone ever needs it, we can have it, but it's not
> a blocker.

Yes, that's a compltely orthogonal callback.

--NY6JkbSqL3W9mApi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1dNCcACgkQJNaLcl1U
h9Bl8Af/Xm2Xa9YOa6VFkbJ3jgkINICtBABTxYvKltNwmT5BP8nOJkVXFq1TtdMz
N5EyBg9dN2luySAos4G/tu/IoD8MDAenPS9xiljA5EGVzZFq+Alw8RwJLAOhEhip
0jt3BiI6CIRL286m17Eb2WIvebAqPZVT7gbqVNXzaQsQInq6AQ8xQRGsb6OAYunw
p7LOLWJ4LAYxGrwgO6dlnyeRyDSbg5lg0jdWYldy8C+2G7q3AZZ1E6KIo4n5+TJd
JjTrKX9kx5ABzsBJyu/hQ6Zn0MCdC11AJZRBSfYzO+fE/1l49SqVHoD6MxEtWM5g
Ica+0kC+/XGk7S294y0Hi2hz4cwrOw==
=B3Db
-----END PGP SIGNATURE-----

--NY6JkbSqL3W9mApi--
