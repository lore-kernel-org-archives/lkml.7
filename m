Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD7EA20850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894806;
	bh=S46QOiAcJv13P0vx1gZ8jYhqhE3xFm/f6fZCmiCtIPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YXOcm4VLUwSFbjVuUDLBNiiohjoJqnnNAz1jDADr9rxQkDXYG2v64URHNHXviW3d6
	 rrFbyU1zsT+PF1o487B4eSpjl1DiyWS/fXhzuZepfaYBryEyAQqejAdAdP3WdrhQPL
	 3NISkYSf8lox66oNQfiB/0VAiIBDC74I0L0Q4zk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfDJLNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:13:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53084 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbfDJLNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uEPgs07wAvANBUnRzE5ezosnYqWGzwyUUd8p6lScjt0=; b=sCXP4EKHX8L0o3bM1aJqOBzDS
        I72JZ3Lzs52C/edc8kycc1ZXIze7YTrw+/ke6QhyYIvl7KIhUIDuBMeycvgpBBp9RtM5JCVXYASZE
        Ec0MFP7H19IkUWm8eNDhG5zaALKNByx6L3jpbQs+Tr4WIePU0U3SFBD68MgywHcywDbDc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEB9s-00080u-UB; Wed, 10 Apr 2019 11:12:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 911C21128ED3; Wed, 10 Apr 2019 12:12:42 +0100 (BST)
Date:   Wed, 10 Apr 2019 12:12:42 +0100
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
Subject: Re: [PATCH v4 0/4] ASoC: fsl: audmix: remove "model" attribute and
 fix ref leaks
Message-ID: <20190410111242.GK6106@sirena.org.uk>
References: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8tUgZ4IE8L4vmMyh"
Content-Disposition: inline
In-Reply-To: <1554894380-25153-1-git-send-email-viorel.suman@nxp.com>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8tUgZ4IE8L4vmMyh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 11:06:35AM +0000, Viorel Suman wrote:
> The latest audmix patch-set (v5) had the "model" attribute removed as
> requested by Nicolin Chen, but looks like (v4) version of DAI driver
> reached "for-next" branch - fix this by removing "model" attribute.
> Asside of this fix object reference leaks in machine probe reported by
> Julia Lawall.

This is the second version sent out in the past hour or so :(  Please
allow a bit more time for review and comments, people might still be
looking at the earlier versions so any additional changes they spot will
result in yet another resend and more noise in people's inboxes.

--8tUgZ4IE8L4vmMyh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytz6kACgkQJNaLcl1U
h9CQWAf/d6PbLwI/eE3Z3GqFktngflv/Hvwe+3XW8M8gaoXqCol86/BusJ0fGnQL
S/cqap0+yT+My2oovt3KCTAqtA/CssjrlYvqyEbsC8pMGvewtVAMzUFaMbrLUnOu
aJEp7Fq9wCAT0Q/mM5TiFGrVBpmQlIpthIOP1wLejUesGpQLlPM0bNXhbCeBc1u/
rjB07FvCZrnEdVtO5ohtB6HPsD71lUqejGrxMr56T5tU6nAhT7ksfXyD4uRv8Wrh
/l/DGCYxBqKdHNEw5Fi2mj/2+9f5vS4uO6oJ6xa/RGfJKrXqrZupqn+OPQZ084OA
BEA0nh6cJQ2V9rnxrtcp3sVwHxTPHw==
=9K0N
-----END PGP SIGNATURE-----

--8tUgZ4IE8L4vmMyh--
