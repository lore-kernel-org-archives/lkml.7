Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65032CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D90E21929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572015312;
	bh=L91bKnoTW5eo06LqmKThOXlC7Ey89ugey2nzWU68avo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HWY8m8s6hjtoSup8DPKfHBlZKZ8x3g0dHURSWxp0IlSxxkIXOwN48xwpfvRKAH0XR
	 eN+bNMoVJxQLb0L8TnKFrWuBn7PT4F0dgEg5CzONqcxixhTLupqazXKTOgOqblSvDI
	 XSRl/F09ctP/wFTswr+o+uHY82VwdC1zDIzUaQ/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395389AbfJYOzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:55:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393570AbfJYOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hOMeQHT5QizvK4EdYa5Jsk3saKC1ABLJqlyHDkwtamA=; b=cd06RRWTLCnJ82Oij3Cbi97qI
        s9jk8yIG6bfewthiFa0Jf4CuURoUsjgkTDT+sgtMZzOnRXWdLOCJO8boxdfOgJ7ePdcKvWKwqf6KY
        ie8Atg24+yu3JUht3+/HEH6+cApDuQAwISfqITmksq1Ji00dS/a2/lh3+pNmnQAzglXeg=;
Received: from host86-174-61-171.range86-174.btcentralplus.com ([86.174.61.171] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iO0zW-00075E-49; Fri, 25 Oct 2019 14:55:02 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 7EEF7D020AD; Fri, 25 Oct 2019 15:55:01 +0100 (BST)
Date:   Fri, 25 Oct 2019 15:55:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     daniel.thompson@linaro.org, arnd@arndb.de,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, baohua@kernel.org,
        stephan@gerhold.net
Subject: Re: [PATCH v3 08/10] mfd: mfd-core: Protect against NULL call-back
 function pointer
Message-ID: <20191025145501.GG4568@sirena.org.uk>
References: <20191024163832.31326-1-lee.jones@linaro.org>
 <20191024163832.31326-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ls2Gy6y7jbHLe9Od"
Content-Disposition: inline
In-Reply-To: <20191024163832.31326-9-lee.jones@linaro.org>
X-Cookie: Keep out of the sunlight.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Ls2Gy6y7jbHLe9Od
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2019 at 05:38:30PM +0100, Lee Jones wrote:
> If a child device calls mfd_cell_{en,dis}able() without an appropriate
> call-back being set, we are likely to encounter a panic.  Avoid this
> by adding suitable checking.

Reviwed-by: Mark Brown <broonie@kernel.org>

--Ls2Gy6y7jbHLe9Od
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2zDMQACgkQJNaLcl1U
h9ABgQf9FLxe+CJ2ib38kOHsh+dWrewAHj3LPciwqrFUCQbdp/vtXpAjmCnHy0t6
5RbtY52V8l9ePzKffJ/H0KmmtEvXGEgosPbR/0i662aeVTmOyme7W4pZXMTTLMJ/
JIPMccu6ocWmYHsGy9QRE8ogdOQ6oC5Gmys1FDDj3iHI7MV+byj5tLco6eqGpH9+
8fsfGfwAzwJfDXyoyMpjrtsivvJfXGTgYr0ozd5dVliSkRwABpNoRXCxi5QAqCUt
Sm6unj7LOFcmt2GYtrNgg/utcd+A5coT55CCWA5Ib2/yB9KTj++tt2xr6C7FzQJG
38r3tEQ2oyzlkqLRc1Nl+oZDX7IcFw==
=WgfW
-----END PGP SIGNATURE-----

--Ls2Gy6y7jbHLe9Od--
