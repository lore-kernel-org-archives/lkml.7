Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E8C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EACA8217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554892822;
	bh=tRhRu/K8dajfvku6n0OdjhRXuVlp1o66XXjHr1p/96U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FoTc2htTbnkbfMMGrUdUhkqEN03JY5ObpYm3AW+mHCvVQMFG276eKvox/JJQ+6d3n
	 jD2d+Wu+bRlfD0jRGoDdIa1QOT4qXV5QnpfIkAiSzkPbfoSQhPLwARnRfp9acnhJk9
	 fvV59r5uzfK/0GiInsfue5WnmIPDNWfcFzKukew0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfDJKkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:40:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53758 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730003AbfDJKkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HEx51tyNm/KKuDMzJyEV23nvOH993N6FZ0VSxqfZUDA=; b=B/ld574pSPkaDPJzsj8YOK4dF
        Zew7n1KBoYEvrZO3eBSDcWo/MajA0zY687koJ+1P2kpMJvurproyLy+kL9pYu1WKUb2PExNLqG6Pi
        7YQ0jY7a6h8SvakwFO02OV6nqtOfXP8TKhmdDj0SSpNeldIhkEiBpnwqdEbeaZy2Jj1iw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEAdw-0007mO-UU; Wed, 10 Apr 2019 10:39:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CF00F1128ED3; Wed, 10 Apr 2019 11:39:47 +0100 (BST)
Date:   Wed, 10 Apr 2019 11:39:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Viorel Suman <viorel.suman@nxp.com>
Cc:     Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Viorel Suman <viorel.suman@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: fsl,audmix: remove "model" attribute
Message-ID: <20190410103947.GH6106@sirena.org.uk>
References: <1554892629-17646-1-git-send-email-viorel.suman@nxp.com>
 <1554892629-17646-3-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hlh2aiwFLCZwGcpw"
Content-Disposition: inline
In-Reply-To: <1554892629-17646-3-git-send-email-viorel.suman@nxp.com>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hlh2aiwFLCZwGcpw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 10:37:30AM +0000, Viorel Suman wrote:
> Remove "model" attribute.
>=20
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--Hlh2aiwFLCZwGcpw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytx/MACgkQJNaLcl1U
h9DvXwf/ZeIIHmvAomjnHuuJMUPoTAbgbUldCg3l5vaAJESfKTc/zCNHpH3ENXOc
0faIgAzQrF1At/4fAY6pJkIKAEcR/ryaIwPDk7BHfMyfoW8V+6IBu1z33JqOAhYa
XPPz30TZC2X123j8SvKdULu0GxtRRCaaCnoYWVyKCeLsjeBbPJ08AUvQ8QsuGnDU
0tv7lTgds05v8WZ8zeN0hUWoEAz2yHy9Wm9kymOgaAoIZRZARWYQTnCZDoLp5AW7
B9G3ecNhiZu2M8/6TqFtlpeuo7mJTcNL5+N5wWhy5SgtqQjmZdq3uyfyQY3b1Xhk
QNON31ljdlbbQFw83Wf7AsodJUybAw==
=C5Bl
-----END PGP SIGNATURE-----

--Hlh2aiwFLCZwGcpw--
