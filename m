Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B74C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E42F2173E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564766911;
	bh=FfoAIYI5Bu106nRSxv5dIVziKWKkTKGdoht5KbuPuqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qNF5xy61ewtjvtcGO92TpW9c8kKlwLa5fhiFqHkE7VeyJOEen+GXx5/zbPwB73TEv
	 Wp34GcSWVoc0I47QUOhL080xlKTZJtvxyAOt1K8HBZq+yNJxsHOtmTxtaMdC2iQ4JP
	 sbvtAP/L1DYDds4Gk2Q1VasOYJZTVk1RMTL9y86U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405089AbfHBR2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:28:30 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55224 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404771AbfHBR23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=19SYug1X49A7OlFCjT3NjS7tzEer+iU5emT8mMkyYto=; b=wiA5cjO8vCzDaLIC1P0dzbRa7
        Rk7kC51x8BNo8WA7vM0Xch+d3tG7JZSqG5p+v8h8C0Dw0J7/qn+B9D6hMGdWU7QX8ClO3GtsJHoak
        2NmuwXqYqSJma1EVrnxieTPDr+R/A+gPKCGjM+iS10Ud40Hkf0/aLil4k7Fmlw7ySGY0U=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1htbLR-0008U3-VA; Fri, 02 Aug 2019 17:27:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 7EE982742DA7; Fri,  2 Aug 2019 18:27:56 +0100 (BST)
Date:   Fri, 2 Aug 2019 18:27:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
 diagnostic routine
Message-ID: <20190802172756.GC5387@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
 <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
 <20190730155027.GJ4264@sirena.org.uk>
 <9b47a360-3b62-b968-b8d5-8639dc4b468d@codethink.co.uk>
 <20190801234241.GG5488@sirena.org.uk>
 <472cc4ee-2e80-8b08-d842-79c65df572f3@codethink.co.uk>
 <20190802111036.GB5387@sirena.org.uk>
 <ab0a2d14-90c0-6c28-2c80-351fccd85e68@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Content-Disposition: inline
In-Reply-To: <ab0a2d14-90c0-6c28-2c80-351fccd85e68@codethink.co.uk>
X-Cookie: She blinded me with science!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2019 at 03:51:09PM +0100, Thomas Preston wrote:
> On 02/08/2019 12:10, Mark Brown wrote:

> > You can use a read only control for the readback, or just have it be
> > triggered by overwriting the readback value.  You can cache the result.

> Keeping the trigger and result together like that would be better I think,
> although the routine isn't supposed to run mid way through playback. If
> we're mid playback the debugfs routine has to turn off AMP_ON, take the
> device back to a known state, run diagnostics, then restore. Which causes
> a gap in the audible sound.

Whatever method is used to do the triggering can always return -EBUSY
when you someone tries to do so during playback.

> >> Kirill Marinushkin mentioned this in the first review [0], it just did=
n't
> >> really sink in until now!

> > You could do that too, yeah.  Depends on what this is diagnosing and if
> > that'd be useful.

> The diagnostic status bits describe situations such as:
> - open load (no speaker connected)
> - short to GND
> - short to VCC
> - etc

> The intention is to test if all the speakers are connected. So, one might=
=20
> have a self test which runs the diagnostic and verifies it outputs:

=2E..

> I think the module parameter method is more appropriate for a
> "Turn-on diagnostic", even though I don't really like grepping dmesg
> for the result. I'll go ahead and implement that unless anyone has a
> particular preference for the kcontrol-trigger.

Right.  It's not ideal for use in production systems for example but
perhaps fine for support techs or whoever.  Up to you anyway.

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1EcpsACgkQJNaLcl1U
h9APwgf/Q4KWsYkJw+Dyy8wm8pDjOkyVsUY1B9NZLLVp7mVndWT2ywIcipH0hV+Q
DeDX02ZUjkRup/AwNN/Ptwcy4GHnREbe7g6sJPgAtPFtXcuzUCJdUJsLDt4oXl5f
Nk2TjjELzuKqFz1E1zkIl8h1CowLDljJRTgCOp7mOhmT+x6kCjvURDzhkcXYPiib
wj2Rcu4thxX+oVvl7YkOpd0Wv+ZNGyM+8gEpjI22sy2MVjpMLT9SmzMp4OdfgT0h
dRVXoXKFIDT5zDpQEteTsuJdIS+NlBGM6yfKQ1fRu/+2gSh78+c/4dfT79d/h2ui
1ZJ5R45/kE4lb4xqQ2+hfM6IeKQQZQ==
=kN6B
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
