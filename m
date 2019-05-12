Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9F7C04AB6
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821F82173B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 17:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557680770;
	bh=HJ4Nz4QDJVMZVMlbWigp8sZVqeUNyUAymIfvJkhfYhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AMqnUWk0c4aIrQeesxD8IPJwAJ2GHvGEC/Jf9ZiY1zw5CPKb8GFJbKHEwUcmji71+
	 +InqkVlKrOmYNwU2gpn5TEeZq91GASVuDpkUEQvc+Vf9nySpFoDSjU8gp5x6r+Ilt9
	 gtcLHfuhxvUgPqpBvOeOiEBlz1M87z9WmtKlhi/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfELRGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 13:06:09 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49688 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfELRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 13:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HJ4Nz4QDJVMZVMlbWigp8sZVqeUNyUAymIfvJkhfYhg=; b=MeeeXWmIcL9hI62OLLfsjDsEv
        OhzhqSKfb9f8zaPhhToTB2o/4drYBReJW7ae1+HhKD08qSzQ2gXPbRX59ry13KVVU795DY3pwncQs
        N2u3P8qtI6yH0j8GM4HYNAHw7vZqiJpnxUqgYE7gHCgDUkMS5PK2EYsq0J2/gWtYZ7Lmg=;
Received: from [81.145.206.43] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hPrut-00044R-N7; Sun, 12 May 2019 17:05:39 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id EF71E44006A; Sun, 12 May 2019 10:17:22 +0100 (BST)
Date:   Sun, 12 May 2019 18:17:22 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 07/14] spi: imx: remove ERR009165 workaround on i.mx6ul
Message-ID: <20190512091722.GQ21483@sirena.org.uk>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-8-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cnBsrynPgIOyCJkL"
Content-Disposition: inline
In-Reply-To: <1557249513-4903-8-git-send-email-yibin.gong@nxp.com>
X-Cookie: HOST SYSTEM RESPONDING, PROBABLY UP...
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cnBsrynPgIOyCJkL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 09:16:19AM +0000, Robin Gong wrote:
> ERR009165 fixed on i.mx6ul/6ull/6sll. All other i.mx6/7 and
> i.mx8m/8mm still need this errata. Please refer to nxp official
> errata document from https://www.nxp.com/ .

Acked-by: Mark Brown <broonie@kernel.org>

--cnBsrynPgIOyCJkL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzX5KIACgkQJNaLcl1U
h9C8+gf+KmYRm2L5VEF3eL4ork1xvAFHJtXfOjV/B1DR0Gie2THR7U8Jq6RYoxM3
WiNuy0sL5QpNc6jpXplVGB0Zy2YS7FE5FEmNfcqk6WIqnN6oASqi6nUpe4J20w/2
SH0NVyn4dI3aQwMPtYVm283OZYYnTjK8TXvqUQ5pdONcY1ApcuBfqhw3A3yIySoW
CNafHUttb19MMiZg4A7OoGrNf8J1Xu8GNEESpYyKc7tFXb3pKnNx18mRPw4R8VLP
lKd5jBdm3TmuZskVn45y9hEr+R2T96Vr5v/SHpTaNmMzDhStNOFLuKHes888Pz/C
jyuAQnZRpNhrLu0wDPl/cIXRmGh4iw==
=ccm6
-----END PGP SIGNATURE-----

--cnBsrynPgIOyCJkL--
