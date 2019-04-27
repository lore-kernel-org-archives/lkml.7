Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400D4C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF9A20693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556385618;
	bh=d5r/4JDMy5t371aJuAomq3i4BYz6Guz9fZGPH6xmM44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Xp8Btbf7lXXTiHZynzSW/PzlQyAebtRsNNoiwcezZJjCd769AQPrm3sLotTFkbK8w
	 XXGLlr0ffUfgIndDGQxPlXRcQcAkJT4Jd9gvE8+AZ9Pf+ycL21IHEZq8Vuh33mnnJl
	 AiIDzc1H/vdn7Rnk1bXw3tDlildByr6oQSZQCW1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfD0RUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:20:17 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44004 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0RUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cUFd9bBqyIjSpu2JKklR45l5xgM+O1Ph3GrnzX9A+Hs=; b=HhlKpnRorrYhQKhKHMcM8UqRt
        e5SnXivzM/nMrJF/15t7wGHt43oe3Xd+9aoNRk1MPbBFttn6lJ/Ac74as8RrkaGufMpv74VP0klZ1
        cR15IfjdqQxoZqWopcZPoQOu+XM0b6VKubm4WJJyvHR4DFQ2UsBVHl+QC/zIgTwFZykyk=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hKQzY-0004bi-I9; Sat, 27 Apr 2019 17:20:00 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 2A564441D3B; Sat, 27 Apr 2019 18:19:55 +0100 (BST)
Date:   Sun, 28 Apr 2019 02:19:55 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da7219: Use clk_round_rate to handle enabled
 bclk/wclk case
Message-ID: <20190427171955.GH14916@sirena.org.uk>
References: <20190426125925.04F3F3FB4A@swsrvapps-01.diasemi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="r5lq+205vWdkqwtk"
Content-Disposition: inline
In-Reply-To: <20190426125925.04F3F3FB4A@swsrvapps-01.diasemi.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r5lq+205vWdkqwtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 26, 2019 at 01:59:24PM +0100, Adam Thomson wrote:

> +		/*
> +		 * Rounding the rate here avoids failure trying to set a new
> +		 * rate on an already enabled wclk. In that instance this will
> +		 * just set the same rate as is currently in use, and so should
> +		 * continue without problem.
> +		 */
> +		sr = clk_round_rate(wclk, sr);
>  		ret = clk_set_rate(wclk, sr);
>  		if (ret) {
>  			dev_err(component->dev,

Don't we need to validate that the rounded rate is actually viable for
the parameters we're trying to set here?  If there's missing constraints
causing something to try to do something unsupportable then we should
return an error rather than silently accept.

--r5lq+205vWdkqwtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzEjzoACgkQJNaLcl1U
h9ALMQf+PNlF6FLSTdYpAXPOqsdtjPPZj8JtUbmOAWcn9I/uWpH1kt8CRbciXAzW
GkU6ykRQUDErfkyZzMEE//9l+OZ//LHMAJjq53SRUIMj21RCMc81bH4d5OGD5zms
2N+cAZUBqUN6xOPfQdaGTWpFoXgIjZ13lDiNnM0Jw5RkV+3CVWMPNJlnOWX8jdog
S1gdGvRGyZn0wZ8iqsTISJ+phqtlFxgsNLM5DXPs5o/4RdjhHRW1u+L4BtOz1f8H
Mso/GrYbrgPSvn/9vah4vbkkHrwAbuy68dejwyEQtAFU80BZj0sG3K4TrjBiivn5
Rlm43XIswMUKG8rx1G6jxRVYWs2y6A==
=65do
-----END PGP SIGNATURE-----

--r5lq+205vWdkqwtk--
