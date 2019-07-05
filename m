Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939B9C468A3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 17:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B922184C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562346998;
	bh=gnBLo26ryKDHx5o60E2DF0AJ9EW4sb5L2/P3zDW1ijQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hvbpepsH3lZ+IVbcKmK5rt1Gumzv8i17Rv9734Zwrb2M46vqpP0TnZUx83Sx37sef
	 rgZ0YqU2eje7dBrH81ZBqPXHdeXxM2cXdvie+MgLlC+7j7yIwvoZ6D/1tVJgnvoutY
	 gq+8k6uF73X2e5PAp4lOioaxM/5Yc9GJyCza805o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfGERQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 13:16:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50520 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfGERQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 13:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HKEyNx+1XrxknoW82kLLhbqysgbib6tL6sBEaXoa+FI=; b=itGBlD/HeUPpNoN4qsN1uixLm
        5X32bE/IGmQQdOgCnkMiPo9HFqoCesf3SYKUlSgC3ipJfsqtATXfgH7PXzc02kiKHWbJzoJ2VfyUq
        Wns8aGyFJFVoGcbTpZOYFd/9Nvcm7wcmJ/SSeg8Gt2ueIgE9wBd62k6dDPvJm++5xqVlE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hjRop-0004YR-Ea; Fri, 05 Jul 2019 17:16:19 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id C902F2742A29; Fri,  5 Jul 2019 18:16:18 +0100 (BST)
Date:   Fri, 5 Jul 2019 18:16:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     Jonas Karlman <jonas@kwiboo.se>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tzungbi@chromium.org" <tzungbi@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "dgreid@chromium.org" <dgreid@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH 2/4] drm: bridge: dw-hdmi: Report connector
 status using callback
Message-ID: <20190705171618.GA35842@sirena.org.uk>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-3-cychiang@chromium.org>
 <VI1PR06MB41425D1F24AC653F08AFA463ACF50@VI1PR06MB4142.eurprd06.prod.outlook.com>
 <CAFv8NwJXbJo=z_NDj+JQHD9LOmnbfM8v_N1uHn4sdBzF-FZQfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <CAFv8NwJXbJo=z_NDj+JQHD9LOmnbfM8v_N1uHn4sdBzF-FZQfA@mail.gmail.com>
X-Cookie: Haste makes waste.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 05, 2019 at 03:31:24PM +0800, Cheng-yi Chiang wrote:

> It was a long discussion.
> I think the conclusion was that if we are only talking about
> hdmi-codec, then we just need to extend the ops exposed in hdmi-codec
> and don't need to use
> hdmi-notifier or drm_audio_component.

What I'd picked up from the bits of that discussion that I
followed was that there was some desire to come up with a unified
approach to ELD notification rather than having to go through
this discussion repeatedly?  That would certianly seem more
sensible.  Admittedly it was a long thread with lots of enormous
mails so I didn't follow the whole thing.

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0fheEACgkQJNaLcl1U
h9BXfgf8Djh9t+tRCpOZtbD0eqLrC0mbgK6xvHKXz2Asdi73S29NTI0EsIjf8oZ3
Pz6/6L7lp75cOGU0EoQEzBtCuMIBCEXPI0gewu+FMjVlL3vhvV8svBfRuUZztzn9
12ImYdI/oGK5DDKw7UkhuSxjjoEdnStnEA7qmB/XjH5eH05C2P4xQBYLATEo52oh
jGMW1fSAh+dnQ8A3N9kAJLl9AF+f/eXzWfw3jfoelzQJPikX16xa5UE/U+ukQZ7F
B79Nr4Lp2n9ORhA+GXIk6HVSsoBDqUTOpjH4+zjgDXe9nYK+BBSJ5AX8aZlxBY7C
AP6VWjYU5x92p6hdgtNtqK0pmZ2SZA==
=5Rc/
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
