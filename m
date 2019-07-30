Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B2C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7455204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 15:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564501916;
	bh=Satq2eEMXIbB0aB+E4vC0WoAtw8SMBMHI0WXpWtRuYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TOjnQcb/QejF3KAf84imXVKDQNtVBijHyWfWq3SPQ7uZVbh0KlGXeSB/EJ22FB3Nb
	 pOyh7JqjWiCPLlm35mnNRVQsthCchqZjxf+lQ7uSZgtX8i1JatDdnaBWe8dVa84e3j
	 UhqHGFystRSsQWY73K44Ok23BvcroxYQ4XMQe9NY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732674AbfG3Pvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 11:51:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58752 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfG3Pvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 11:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Satq2eEMXIbB0aB+E4vC0WoAtw8SMBMHI0WXpWtRuYs=; b=J1ZC52QIsMjMi5k2i2Fvr0+nV
        AuizVSMIB5ohxsLuqMXvxPDnGN3s7Ru76VojFpPcd5fQqygq3HMaOXKDD0VEBrs7Btv2YSwqH73rL
        2gC9VPKgK6bIMpJY5oFm8wW8bzuPYLpVtZ+MBg74aqkS+Q2G++Vy42i1p1GAoxDhc9XAc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsUOT-0007rr-3R; Tue, 30 Jul 2019 15:50:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E52FC2742CB5; Tue, 30 Jul 2019 16:50:27 +0100 (BST)
Date:   Tue, 30 Jul 2019 16:50:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Takashi Iwai <tiwai@suse.com>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
 diagnostic routine
Message-ID: <20190730155027.GJ4264@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
 <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DesjdUuHQDwS2t4N"
Content-Disposition: inline
In-Reply-To: <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
X-Cookie: Times approximate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DesjdUuHQDwS2t4N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2019 at 04:25:56PM +0100, Thomas Preston wrote:
> On 30/07/2019 15:19, Mark Brown wrote:

> > It is unclear what this mutex usefully protects, it only gets taken when
> > writing to the debugfs file to trigger this diagnostic mode but doesn't
> > do anything to control interactions with any other code path in the
> > driver.

> If another process reads the debugfs node "diagnostic" while the turn-on=
=20
> diagnostic mode is running, this mutex prevents the second process
> restarting the diagnostics.

> This is redundant if debugfs reads are atomic, but I don't think they are.

Like I say it's not just debugfs though, there's the standard driver
interface too.

--DesjdUuHQDwS2t4N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1AZ0MACgkQJNaLcl1U
h9A+KQgAgi4HkmsbIandzuTrFA6N2E9Zrc7WMisuFB9GE/OnLiU559yFfrABha81
2AJ4vwv4WOwP6Cl48kFT7W90WgsJljB6F0d/SaiwvhNmwf2ifUVANo+tkNv8L2kn
W/7p0/OQ1tuFhU9OI98e1YbqSI/TEcgQx3CEp0diUdcmv1C55X6cn1tjj5Mn0+hz
Mf2IV9Q1KMJQBeHqm6PvdWjzxbnQ7iUEPQ6SoP6PwTjEvpWN/+Cv7q/wo1FCs1hb
1nYLoWrVYhOaQyzAxxJ/S2bRl5TybnmgSJOpj1ZNMRcHdED93sk3GMNSqqAOD68L
nQQV16tM/EvyPsbQE+AMJFrAKfZLdg==
=H0id
-----END PGP SIGNATURE-----

--DesjdUuHQDwS2t4N--
