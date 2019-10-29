Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 373DECA9EC4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0228D2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572335413;
	bh=AkPGUGUQ7O22I++5egFOxpSLRIAUQwOIcbOTmbPzHKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bgx3aTkN8pfbqZFyRwDzIuePX3a7pYRi8NVBYoroM0CRGKxuDl+Jg81NFh7zQjcjI
	 RkzpvCQaRA+Xx+JgD338fXoavEN4kSxL3fw1+kHwp47KJucn+a0vZBr1mqQyvZoT4b
	 6B/rslB0Wi2AaeblCokR7xy7vLs5ot64/SuH0Q/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfJ2HuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 03:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfJ2HuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 03:50:11 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FB9420862;
        Tue, 29 Oct 2019 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572335410;
        bh=AkPGUGUQ7O22I++5egFOxpSLRIAUQwOIcbOTmbPzHKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sRKSF5K/AlN5GrAdeqvLE9SchQtrj4GYEsnLBDPbHIQSQguy+fQXaGLqUjlvzL9lf
         JgbRpztgCCHo/DRg11StqXpDwmhSuslAj7iGSiPsWGsNomMgtMkB47UrFYm8+DaBOD
         qp6ceIoXULz1mumBJkSp4AJ80UsxaoB7myQIDrQ8=
Date:   Tue, 29 Oct 2019 08:44:49 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: sun8i-a83t-tbs-a711: Fix WiFi resume from
 suspend
Message-ID: <20191029074449.jx2acknfds2idyjt@hendrix>
References: <20191028215859.3467317-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="52ug3nnncgfccqfd"
Content-Disposition: inline
In-Reply-To: <20191028215859.3467317-1-megous@megous.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--52ug3nnncgfccqfd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 28, 2019 at 10:58:58PM +0100, Ondrej Jirman wrote:
> Without enabling keep-power-in-suspend, we can't wake the device
> up using WOL packet, and the log is flooded with these messages
> on resume:
>
> sunxi-mmc 1c10000.mmc: send stop command failed
> sunxi-mmc 1c10000.mmc: data error, sending stop command
> sunxi-mmc 1c10000.mmc: send stop command failed
> sunxi-mmc 1c10000.mmc: data error, sending stop command
>
> So to make the WiFi really a wakeup-source, we need to keep it powered
> during suspend.
>
> Fixes: 0e23372080def7 ("arm: dts: sun8i: Add the TBS A711 tablet devicetree")
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks!

(I don't have my ssh key with me, so it might take a while before it's
pushed...)

Maxime

--52ug3nnncgfccqfd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbft8QAKCRDj7w1vZxhR
xYcyAP0WvrLuHa2aHuAm4rNH4xTo173mvgoO36v3gZZf8d3BUAD/YggPtA5vvV6x
KMIL0fCiPgWcqxx9dW2Qa+7cXZeLsgk=
=Ctt+
-----END PGP SIGNATURE-----

--52ug3nnncgfccqfd--
