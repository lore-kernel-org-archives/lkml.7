Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B66C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC95206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 18:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566931285;
	bh=VI9BziTby39My6ZtKagU4aCpOut6dHrhBT3wZJ2E6J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b+6n9YabJkGcR2saouXkvGuykZUb/e4u618k+dLgbHPoTpGQDH8SbIg8D+Oq3Q6UG
	 BMkMfDJEHirJ+sn5v/2f/UnVUVF6zjfj7SbAFIlTbFp1p8NGCBm2GDTVczNXPjj7K7
	 2zRxvAleAr8rQHKzSySTkyOY5oQ3nMRKcFCFUyII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbfH0SlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 14:41:24 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59978 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbfH0SlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 14:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=epG1Jj0LZAm9JsQ4dirXtSr8T+ss8OxvKfoyO3+fm7o=; b=sM2g0hijUSswGlnHykjQw5vhb
        +nU6Ko6Hf8zMuJKHsKssVCeLZHvI91ek0A1SoM7ns98Ru2B23NI2E3movUEr8CrskL4MGyQItkPQt
        dpl5I24ouOTA5uIUuOnhN7xMJmnb+3/cWJw2OOcOVecSPVDRqugaUfYukM3421A8tu2H4=;
Received: from 92.41.142.151.threembb.co.uk ([92.41.142.151] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1i2gOa-0000xT-5B; Tue, 27 Aug 2019 18:40:45 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5ACE5D02CE6; Tue, 27 Aug 2019 19:40:39 +0100 (BST)
Date:   Tue, 27 Aug 2019 19:40:39 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        Anders Roxell <anders.roxell@linaro.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Nariman Poushin <npoushin@opensource.cirrus.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nikesh Oswal <nikesh@opensource.cirrus.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Piotr Stankiewicz <piotrs@opensource.cirrus.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] wm8904: adapt driver for use with audio-graph-card
Message-ID: <20190827184039.GJ23391@sirena.co.uk>
Mail-Followup-To: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allison Randal <allison@lohutok.net>,
        Anders Roxell <anders.roxell@linaro.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Nariman Poushin <npoushin@opensource.cirrus.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nikesh Oswal <nikesh@opensource.cirrus.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Piotr Stankiewicz <piotrs@opensource.cirrus.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        zhong jiang <zhongjiang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5PPnVwj6ulmYFu5t"
Content-Disposition: inline
In-Reply-To: <cover.1566734630.git.mirq-linux@rere.qmqm.pl>
X-Cookie: Don't SANFORIZE me!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5PPnVwj6ulmYFu5t
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 25, 2019 at 02:17:30PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> This series allows to use WM8904 codec as audio-graph-card component.
> It starts with rework of FLL handling in the codec's driver, and as an
> example includes (untested) rework for codec with similar FLL: WM8994.

Please make some effort to focus your CC list on only relevant
people, many upstream developers get a lot of e-mail and cutting
down on that helps everyone stay more productive, too many can
also set off anti-spam software.  You've sent this to a lot of
people and I'm struggling to figure out why most of them are on
the list.

--5PPnVwj6ulmYFu5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1leSYACgkQJNaLcl1U
h9D/qAf/aDKjsXpu3OV9W/YRcVKa/q4lkLirQXvzegtCjjtctGiFmmTa8hRGeaU2
sHHo5pU4H6EDQZubuS3bnNWzE0SRout2VquNd1ddjAQoVCmRv2rfaGFpI2SelVqL
2lAMUx2niskdB2f1YFRIBbuvwfok6C3qew9aM3DZIDhD+foqHLWuwWYNDjjbwopR
rqLgjwGRoCwQQh9/HfhdWB7b94NQ74aPsa0xETo+dsR4z1k1PEjoThjBkckOI/eF
8yFtAR6coVQ2DHbsAKTO7ajC43cumNyh4XhYRAxBVrCJ6wG17AQTT23HTpNaLCGy
tYANpAltXhi4j1vd/QkH9wh3MvDFww==
=GFP7
-----END PGP SIGNATURE-----

--5PPnVwj6ulmYFu5t--
