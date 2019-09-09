Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F95C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0700B2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 13:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568037295;
	bh=kcSnMIO+BqICrhEM1gLEDqbrH1+CV9MkH0tAAQUt44o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=go4zeOK8LMxR+Zdk4UGYpAPjcMEgHmEj/gPRKx32rrJwWqYNXPLub8nPJTZoryJgg
	 R8EYOnF9ZoQ5gXa9IZWClQfTPkP9f5HsTrI2EKQBil4gffDlnEFWLAkwc4NZOktpIP
	 EEGhjnCj3L7dkEv8q09WYsA4NkpAJ/gcuuj9fhp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405028AbfIINyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 09:54:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43284 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405012AbfIINyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 09:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Cm68PPNUL9hpa20Iuq3N78KfFV9ZNG1FxC3bFlrLNBo=; b=SfCG2GghXvnLx5hk7+p07alq7
        rAtpln77hLd/I2OhSW53ZOqioUNmYHSKcBbb8mqu7CPtaK7xrY8P/BZAFJBwcbiTIiUNImLxvpA9q
        IP7v7eZk/iX6XwTN/nXk4BeApdZCIIVXbmK2eaCvwgK/XZDmHpv2JXbcjR+Uqt4JyETi8=;
Received: from [148.69.85.38] (helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i7K71-0002ZE-GF; Mon, 09 Sep 2019 13:53:47 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id DB8BCD02D3E; Mon,  9 Sep 2019 14:53:46 +0100 (BST)
Date:   Mon, 9 Sep 2019 14:53:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Cheng-yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Douglas Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org,
        ALSA development <alsa-devel@alsa-project.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v5 0/5] Add HDMI jack support on RK3288
Message-ID: <20190909135346.GG2036@sirena.org.uk>
References: <20190717083327.47646-1-cychiang@chromium.org>
 <CA+Px+wX4gbntkd6y8NN8xwXpZLD4MH9rTeHcW9+Ndtw=3_mWBw@mail.gmail.com>
 <CAFv8NwLiY+ro0L4c5vjSOGN8jA-Qr4zm2OWvVHkiuoa7_4e2Fg@mail.gmail.com>
 <CAFv8NwJjG4mwfnYO=M3O9nZN48D6aY72nQuqEFpZL68dh5727w@mail.gmail.com>
 <7019a223-cc97-e1c6-907b-e6b3d626164f@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1XWsVB21DFCvn2e8"
Content-Disposition: inline
In-Reply-To: <7019a223-cc97-e1c6-907b-e6b3d626164f@baylibre.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1XWsVB21DFCvn2e8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2019 at 09:37:14AM +0200, Neil Armstrong wrote:

> I'd like some review from ASoC people and other drm bridge reviewers,
> Jernej, Jonas & Andrzej.

> Jonas could have some comments on the overall patchset.

The ASoC bits look basically fine, I've gone ahead and applied
patch 1 as is since we're just before the merge window and that
way we reduce potential cross tree issues.  I know there's a lot
of discussion on the DRM side about how they want to handle
things with jacks, I'm not 100% sure what the latest thinking is
there.

--1XWsVB21DFCvn2e8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl12WWoACgkQJNaLcl1U
h9B58gf/azL9m1nPkR4phZ6A1RIN6d+L25pbHNjtM6SvzmLQ2nOUKncgKEgrHCE5
mcWbRDcvUMGOQFMG4agAnXPvWxyTzLKs8YJ6inLI7FzsF9cGKN4eKz9wDl3QsikV
ObslZLrhqTPe29AtSfIKfC9A3GRt9L0E6gG/D6YYa+ZzPEcJOSRMSsPQ+GXeHh1x
uM7ntqIIEWytr2RkEDT+QJHAqgPWz9yI1L9ynlcZfp9OXt/sO2rWPkpFhNyyjeBs
YFUpXp0aMmVtolJYrljTBVJ+DZeTX5JifotTePHJYEpavbMXJ9lcyTIMGL0bB94R
o4rqAkYpM8kK2jGNg2ojes7W5qdjlA==
=a5GI
-----END PGP SIGNATURE-----

--1XWsVB21DFCvn2e8--
