Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F4FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8386B2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554196636;
	bh=+Aaw473KhGYhZW8/nvJwRG2Bld2CMM3lBWWI6Rf/UVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V0S9qeEpn7OKVTyZThaHHrQUTRUDBOr/4p21PTWqLu8lVHIaZVIImzpAwjqm3yjsA
	 /iPhBaI8FDiwnBZJ5Pr2rDmeYX/rsGLoXGjF5PJ8DSyScCmf+8IfVeD0jJwjfW8kmb
	 WZXGEkFne053ohmxwUs7dqR3y5gasnWIG2nhQUAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbfDBJRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:17:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32796 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729156AbfDBJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wps/hBFjwdAfVBCM40y8FF9Q+Li//hikc0gC5/2ya1U=; b=hWGqE8U/B6O2lWWvNTMD0nuN1
        7GNMLPzfj6dzEZaBjpm3fXUFSTqx2uO/KIU3f98wsFCZtSZZrjhnj1rzMY2MGGKKa4avaqOIAzMWh
        V/VnuWo9y+srxq0T1N8fq3WYnLHoEkI5pv9b5E3WKAmExHMYl3JG/Kmnt2lquk50jpPJs=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBFXT-0006lv-2W; Tue, 02 Apr 2019 09:17:03 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 48BCF440082; Tue,  2 Apr 2019 10:16:59 +0100 (BST)
Date:   Tue, 2 Apr 2019 16:16:59 +0700
From:   Mark Brown <broonie@kernel.org>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        Wolfgang Ocker <weo@reccoware.de>,
        Jan Kotas <jank@cadence.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip
 select and whitens the GTA04 LCD panel
Message-ID: <20190402091659.GD2059@sirena.org.uk>
Mail-Followup-To: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        Wolfgang Ocker <weo@reccoware.de>, Jan Kotas <jank@cadence.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
 <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
 <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
 <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
 <CACRpkda4k_Vaoo1qEaZ3nv8bA4tcrPEN6oT-v+n9HRdA6=5Xvg@mail.gmail.com>
 <2D2D13C2-0D3E-47CD-946B-81DBBF3C43E6@goldelico.com>
 <20190402053143.GZ2059@sirena.org.uk>
 <F8ACE730-B498-41E2-A486-923C760807F8@goldelico.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1C2QhcYtVTlNtC1j"
Content-Disposition: inline
In-Reply-To: <F8ACE730-B498-41E2-A486-923C760807F8@goldelico.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1C2QhcYtVTlNtC1j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 08:37:23AM +0200, H. Nikolaus Schaller wrote:

> I have learned from Linus that the problem with legacy spi-cs-high are mostly embedded
> powerpc systems deployed between 2008 and 2013 where the boot-loader can't be
> changed. And where the dts is not maintained on kernel.org.

> IMHO it is very unlikely that they are running distro kernels. Or is there an example
> of such a system?

I used to work on embedded systems which were built by essentially
bolting expansion cards onto standard reference systems, for some of
them we shipped distro kernels with the extra hardware supported by
adding modules.  No idea if there's practical examples for specific
PowerPC systems though.

The burden when you're breaking things is more on showing that there
isn't a problem anyway...

--1C2QhcYtVTlNtC1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyjKIoACgkQJNaLcl1U
h9AdRQf+OjsrMPq6RrsYN5iuLoUXODLhFhHcW82so4UOC3CnkPulq7UpmK1V0ht9
7BF22zT0HFiyGMyUdbcPTFwBioXe0tdQDtsIE35K0BwAX63OncFc7dM1RYIIag8w
bWFQfBYRQtBxxyrhnsjxkZwKbfrfIUAXvBmu805zjo4bHt431tjJKEAY7tZ+5qjI
aoJM0D6Ubhp4/AEaYp+zxeNp3ifwsB41CjjGnQu5WcAXKZhUUKaLYA4H5ONS9kiM
jg3h3CkHlYzoAM5gmKs1qjh25SAlSZhF1pge65QNWXTl6GNQLk12Ar5IFZDnDT9o
Y6/GOyy7mfbK2xHNwmWMiYEGEEMPMQ==
=+mPR
-----END PGP SIGNATURE-----

--1C2QhcYtVTlNtC1j--
