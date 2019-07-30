Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1B9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820E62089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564496435;
	bh=8TKN5XccligETEieRmOY0uvOdDLyhkX/2OICv01x9vo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lN13APeIobfYLHLN/uOeD8SLpQp5N/Wp7rTzeI/XII/cTA8cbXG5pm1BTHr87wJO2
	 Hsb2TKT6U7la6MDzD0rmeIA/QofDSL4tp/LGKSSP1NjtQNuOpjB1tpi33cyVe66uAe
	 3jZ4Ytzr3IJAh9GEoTeYBgXw1MpYs+0X7j2nmqmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfG3OUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:20:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46390 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfG3OUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8TKN5XccligETEieRmOY0uvOdDLyhkX/2OICv01x9vo=; b=t+j4Mj8FJicNpWJRqkQkRP2OJ
        Ugo7DZR2UEIA6W2yWIXmoySwvR+koae/Ch3yKZ00Ho0jmZqpVZbqv2BYyhhjO2mWBWi6QJxhNe/nl
        LNhhqycGI5O1NQ08xJG1O8whrq8WpRed0mg/AAmoNQ0fXHPYHqDBnYWjvzm524d7mNoTU=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsSz5-0007jD-Jf; Tue, 30 Jul 2019 14:20:11 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A007D2742CB5; Tue, 30 Jul 2019 15:20:10 +0100 (BST)
Date:   Tue, 30 Jul 2019 15:20:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Marco Felsch <m.felsch@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
 diagnostic routine
Message-ID: <20190730142010.GG4264@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730124158.GH54126@ediswmail.ad.cirrus.com>
 <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8S1fMsFYqgBC+BN/"
Content-Disposition: inline
In-Reply-To: <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8S1fMsFYqgBC+BN/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 03:04:19PM +0100, Thomas Preston wrote:
> On 30/07/2019 13:41, Charles Keepax wrote:

> > This could probably be removed using regmap_multi_reg_write.

> The problem is that I want to retain the state of the other bits in those
> registers. Maybe I should make a copy of the backed up state, set the bits
> I want to off-device, then either:

> 1. Write the changes with regmap_multi_reg_write
> 2. Write all six regs again (if my device doesn't support the multi_reg)

Or make this a regmap function, there's nothing device specific about
it.

--8S1fMsFYqgBC+BN/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AUhkACgkQJNaLcl1U
h9BETgf7BOzHBpbnhWhg2mabB09TWYhaMWdG7DZWPeU+jTPkgFJuIroIGpBf3h/c
WIE9G2Zy55KDP7yf1wM1Ad7N18JCMzX+enceVyJ4ZlHhpA3wLhTleyaIdn6JGSHB
++DqO5maWG0iL698Um5bPFI6lvOF9Ewd1KanKCW0hEH93m5C9D5jY4sqItVgEPb1
9vwdUdMo/MqfcwpS3rzXUC98OXCrnC8o0pPDFZT4U5i7X9gNqSSbKIhnBqmCOY+d
P6aoGUTv9ZwcZSj1cU1Ty5NKiKAu7asJyWzBvZFc6T9NcAbX3ascLBMWgP5BxYPG
LuOQqsFxOiOi3H8N4WlvJk3bvvY1mQ==
=0sPL
-----END PGP SIGNATURE-----

--8S1fMsFYqgBC+BN/--
