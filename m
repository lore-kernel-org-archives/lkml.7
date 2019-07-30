Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A46C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 154FA20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564497254;
	bh=HUIjubvJw6ZBXkD/nCiFywd/HIQkLGI0jwF9aj2IqTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mBIjba3SWTgJjCGW+svh0yYoD5dwsn/099DJ8KIBdwhqLZ1HZWuT4+ZsVE35H1xzK
	 E6o7p7vo2YZILqV5PwsUzPWwLeXhDxHoJNoXg3hzKk07DnEsPWWAca+ppgae2T6yjY
	 KTA5TPQBTNCVmhYWtwaIs63lL0XcprpuoCo9QBh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbfG3OeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:34:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41072 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbfG3OeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bnSwB9Iwevew2RMS+oCUNWcQXcWmO0icV8safm3Y+7k=; b=ABK7ohS20te6PnMvyuuZd28/i
        TAkwBE7yPSt13/jqJ6SNPDPP3lgrEmoMtDV9UHHsHPJhOh1xvle6oaupTJMQ05802ahdVKb2UB8+K
        YY0hfF+0oCFnz5IWGYJ+cIgCRN6hWP67y7J2CEy2IxvLOelH9ssjwuEUH8Vt7YJAZz2Q4=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsTC9-0007ku-23; Tue, 30 Jul 2019 14:33:41 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 093CD2742CB5; Tue, 30 Jul 2019 15:33:39 +0100 (BST)
Date:   Tue, 30 Jul 2019 15:33:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Rob Duncan <rduncan@tesla.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Nate Case <ncase@tesla.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Patrick Glaser <pglaser@tesla.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [PATCH v2 1/3] dt-bindings: ASoC: Add TDA7802
 amplifier
Message-ID: <20190730143339.GH4264@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-2-thomas.preston@codethink.co.uk>
 <20190730122748.GF54126@ediswmail.ad.cirrus.com>
 <20190730131209.rdv2kdlrpfeouh66@pengutronix.de>
 <16a99e45-fd5a-2878-acf9-63518f9ca527@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QwZB9vYiNIzNXIj"
Content-Disposition: inline
In-Reply-To: <16a99e45-fd5a-2878-acf9-63518f9ca527@codethink.co.uk>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QwZB9vYiNIzNXIj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2019 at 03:12:21PM +0100, Thomas Preston wrote:
> On 30/07/2019 14:12, Marco Felsch wrote:

> >>> +- compatible : "st,tda7802"
> >>> +- reg : the I2C address of the device
> >>> +- enable-supply : a regulator spec for the PLLen pin

> > Shouldn't that be a pin called 'pllen-gpios'? IMHO I would not use a
> > regulator for that.

> Hi Marco,
> We have multiple amplifiers hooked up in a chain, and all the PLLens
> are connected to one GPIO. So we need to use a regulator so that
> i2c-TDA7802:00 doesn't turn off the PLLen which i2c-TDA7802:01 still
> requires.

> This is why we use a regulator. Is there GPIO support for this?

If it's a GPIO not a regulator then it should be a GPIO not a regulator
in the device tree.  The device tree describes the hardware.  There was
some work on helping share GPIOs in the GPIO framework to accomodate
GPIOs for regulator enables, you should be able to do something similar
to what the regulator framework does.

--+QwZB9vYiNIzNXIj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AVUMACgkQJNaLcl1U
h9Cu4Qf+OOSeubUr69q1X65qxycxElWJauRAa8zN5ZCS6Corf1z/+hgxkei5GI7D
p242D+7O5/QHuGlsws3pHfiD3BUJbV+/D05v8DDX1GOEf54+8wv+dnX/1AZKtYzS
IU/5aki3+oYGj76dQKpAhuTJFnJGGmkMg+O5SWXocr3KZO5P740PKZG0+wVX+yQp
OdZbJOEfztfQ8AfQQ4vtSjun2grcmxeEyxPo7LiL+iNs2ifAOZW6TWNIl7Y/Xftg
UNGdYVAtOL9s9G364+UmdAbLbQtKDtLLnotRd98S8NGElOoOGoLss6/pwrW2BHd4
CgdgNotIdcr1q2Me8acJM2d8pxjKWA==
=aDlD
-----END PGP SIGNATURE-----

--+QwZB9vYiNIzNXIj--
