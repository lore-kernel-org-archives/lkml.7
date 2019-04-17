Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC3DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA76D20656
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555516009;
	bh=sCH6R7wLuUkghnPwdhkIax3yY8OO2FAe98G0Wvpcrzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tFkYQB3L9NJVi5fyCIQfEMeIVJYyVBiWUfgYq97K+fdd6cAkcvLiJ+Mn78FdpgzuX
	 ZzCSUXcdIky3s3pJ211iqNck1d/IUqpT6KsxmuMeq4xgnoDIcTsWGZMIBTWbJ4i1WS
	 lnOlTQlAlRWUIamKl/R98IhxH2SqyJYeWWSY03fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfDQPqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:46:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56730 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732305AbfDQPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ixmFY32LfJDoyWTdaCfYujDRLEHD7yXZvEQYzPMedEk=; b=eO5Hip9sEZ/Ris3RnYCcYAnIL
        ekWaSP4BvLXKI/etw3bQpHS5QICJa+AyL7IkAsfConaPWgwTgUcJLTQI+pV2JQLwU9I8JuIIO7AWH
        UseAl24l0HOB9JYj4IHvxtUhKo8ra3geRbBTIgFaLZBG5ecBAC1RcLVT3Nfwlokhecp/U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGmlj-0000dL-68; Wed, 17 Apr 2019 15:46:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 51C9E1128283; Wed, 17 Apr 2019 16:46:38 +0100 (BST)
Date:   Wed, 17 Apr 2019 16:46:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        khasim.mohammed@linaro.org
Subject: Re: [PATCH] regulator: core: do not report EPROBE_DEFER as error.
Message-ID: <20190417154638.GC5703@sirena.org.uk>
References: <20190417085411.14552-1-jorge.ramirez-ortiz@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <20190417085411.14552-1-jorge.ramirez-ortiz@linaro.org>
X-Cookie: Boy!  Eucalyptus!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 10:54:11AM +0200, Jorge Ramirez-Ortiz wrote:
> Do not log a temporary failure to get a regulator (EPROBE_DEFER) while
> the driver is requesting retries.

> -			dev_err(dev, "Failed to get supply '%s': %d\n",
> -				consumers[i].supply, ret);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(dev, "Failed to get supply '%s': %d\n",
> +					consumers[i].supply, ret);

Please leave at least a debug log in place, it's not good to just
silently fail - even if we will retry someone might still need some help
debugging (eg, figuring out that they need to enable whatever driver is
providing the supply in their config) so we should tell them why we're
deferring.

BTW does an e-mail address need updating somewhere here?

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly3Sl0ACgkQJNaLcl1U
h9CSpgf+NXPRp/QvJ5ozA3U8QPuDTm7eZHHlacZ4cK/9GDwxkWzDHqqQpvF59Nrp
v09pxwgHUzJ679E0f+atyuJj5drJpxmWnL1eFnZjirqv6oIbYzHFt4/9xpdblT/T
O/vH0nT/JQsYv8H7dmcRPzR9L22kxr0PcW+ZrbRFTn3Cf1mYcq8o2oQFNDiBTmyK
O9L0lT5VB2+wvQ46t0EbZP/L2QaCSzfslxy5I+k02dntnfw28dW36d31KxmzoHH9
ZpOMOd8O8z6UyYyHRL93L8qbKqfnGressJ3fbQgvPIvIvDQ3wLSBS+9KmZNPKMw0
zvorX87+nFmdGA0SFMwMwPqgBGdQ+g==
=M/ed
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
