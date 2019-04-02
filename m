Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E022C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6852C20840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554183129;
	bh=tt1ZEX5aYowkcEBpL7o3e3R3tannM23xigYk7zPF8CU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lUAYvgD8LLGfvVgDQhWw7b3mNC2h7gdpby2OMulzaZSksT0TsDVimol6MtbbUTD2o
	 UkjVkV5pbEtmvp2cjyS2IpPNw7oVFB4OhcNq/nvSquocTymj6bcxJ/SxVI/wUUHhdF
	 lf3G8ncVSH9pCcdEChgCf2nYnh5fUVGXXt0JLweo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfDBFcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:32:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49848 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBFcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zpz5Uw0i9OT/UtCsKhlTvb1eMpOUq31Od04Lo1s5vWw=; b=NzRpZfWgzf+6pved93nQbihVg
        Se/5f1j44wrqCwgQoRNNu0YyCojp1uBZVl4v5YpiMd0dS2bknX7gb61Kq90epHljmXoHcDkCvaz6e
        kwbrwIxPcn3Q+gsFENQl7mO09G2SQlLhflB6ELUvSGaeIDENrkpJrVrCdmUR+uw8kUyyQ=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBC1T-0005vU-Gm; Tue, 02 Apr 2019 05:31:47 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id D9291440082; Tue,  2 Apr 2019 06:31:43 +0100 (BST)
Date:   Tue, 2 Apr 2019 12:31:43 +0700
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
Message-ID: <20190402053143.GZ2059@sirena.org.uk>
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
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f8lmXUvqnCdFQPaI"
Content-Disposition: inline
In-Reply-To: <2D2D13C2-0D3E-47CD-946B-81DBBF3C43E6@goldelico.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f8lmXUvqnCdFQPaI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 07:05:35AM +0200, H. Nikolaus Schaller wrote:
> > Am 02.04.2019 um 06:02 schrieb Linus Walleij <linus.walleij@linaro.org>:

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> >>> This does not work because there are devices that requires spi-cs-high to be
> >>> respected and the DTS second cell GPIO flag to be ignored.

> >> Then, those should be fixed...

> > This can't be done because some old systems (mostly powerpc)
> > added between 2008-2013 do not know about GPIO flags and
> > have DTBs deployed in firmware that need to keep working.
> > They cannot be fixed.

> The question is if it is even possible to deploy a new kernel
> for such devices and if anyone wants to do...

It's relatively common, especially with older devices, for people to be
perfectly happy to update the kernel and do so frequently but unwilling
to update the bootloader as the procedure for recovering a broken
bootloader is difficult or perhaps not even possible.

> This also gives another idea: make it depend on "powerpc".

That won't fly, the code has always been architecture neutral.

> > Dunno about this, it looks fragile, I would prefer to keep all working.
> > But I will listen to reason.

> Reason why I propose a CONFIG option is:

> if someone is able to compile and deploy a v5.1 kernel for some device which
> has (old) and problematic DTB in ROM he/she must have access to the .config.
> So it is easy to modify it to enable legacy handling of spi-cs-high. And keep
> it disabled for all others.

This assumes people aren't able to run a distro kernel...

--f8lmXUvqnCdFQPaI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi878ACgkQJNaLcl1U
h9Dr7gf7BfQONvr81GpZnUgSfuBnJyN72/vNn0cIcsziIvOgxrIzu9l6UlaBidZ/
Xin24wsVrTfpg4nw+cV3fEbZfWIWaymiWo6DqlMA/GF6VIzDm16a1DPVND/u9CU2
2FOFi8C5rWfmQ+GfkIjubFggPKG/VyVGteXgFb1Lqo3JB0OvzoOmThgioO6MaW6A
8F+d5eQiy/eSWg0sMobsQhkEb6z1e2M+XHK3btuQKDF8O4iwsTtoPO56yLrk0PIO
G3a7Uudgn7uN6vbSzT5Wknkjp2ksO6dvb9lydfXvSskfapkvyD/8xJ4I4dj8i/vo
8gUop6f64Uj+QE4x0kfobpnWzPMBqQ==
=Z6Hm
-----END PGP SIGNATURE-----

--f8lmXUvqnCdFQPaI--
