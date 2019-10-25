Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F9FACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1187321929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 09:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571997357;
	bh=ODPZ0B8QcACz9iU//RW/5fZJOr6PxCo2bGYxQ6t9jgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QikBvQErFjnXqcwEIcrfBI/jAag++hZaTvCkN4c9w9tO++JUJQX35WgrpjRenYKXB
	 jt3r3kJZVXddNMK7hziwRbnx6ixc+nJKPGlCDUfi1ynL3anazwQTSCm0maDHSOZg5M
	 H5o+IWVYGinYdVPdaeOX3B4jOvGXucKf9L+rE/5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408972AbfJYJz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:55:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38020 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408923AbfJYJzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:55:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Q43EHgrQ37XLYLMbydJx8zVprEj7FoK+fTwNtZOM/Y=; b=slcb1nAzCdIMLaTfciUUpmtL3
        UtW/UtgdkrOEMOD4V8k5X59TpPHtK83Z9BbIavVhsYLtLLNTcH1kOv93zoz4b6zFeIuKCOs21zbm3
        N0PWYo7RE9p5HvAXdtViv1AWSPufgvAdvxSuvIdly5H/8g7yaFPcxEET2W/DMCeS3qhJw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNwJm-0006bs-G2; Fri, 25 Oct 2019 09:55:38 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 73CAA274326E; Fri, 25 Oct 2019 10:55:37 +0100 (BST)
Date:   Fri, 25 Oct 2019 10:55:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     vishnu <vravulap@amd.com>
Cc:     "RAVULAPATI, VISHNU VARDHAN RAO" 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "Mehta, Sanju" <Sanju.Mehta@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] ASoC: amd: Enabling I2S instance in DMA and DAI
Message-ID: <20191025095537.GB4209@sirena.co.uk>
References: <1571432760-3008-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1571432760-3008-3-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <20191024114015.GG5207@sirena.co.uk>
 <3aed0c75-80e7-cc9d-59f9-6ef29b665efc@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <3aed0c75-80e7-cc9d-59f9-6ef29b665efc@amd.com>
X-Cookie: Power is poison.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2019 at 06:53:16AM +0000, vishnu wrote:
> On 24/10/19 5:10 PM, Mark Brown wrote:
> > On Sat, Oct 19, 2019 at 02:35:41AM +0530, Ravulapati Vishnu vardhan rao=
 wrote:

> >> +		case I2S_BT_INSTANCE:
> >> +			val =3D rv_readl(rtd->acp3x_base + mmACP_BTTDM_ITER);
> >> +			val =3D val | (rtd->xfer_resolution  << 3);
> >> +			rv_writel(val, rtd->acp3x_base + mmACP_BTTDM_ITER);
> >> +		break;

> > For some reason the break; isn't indented with the rest of the block.
> > I'm fairly sure I've mentioned this before...

> Sorry for this but I am not able to find indentation.I have tested with=
=20
> scripts/checkpatch.pl. It shows no warnings.

The break should be aligned with the rest of the block like I said, an
extra tab in - you can see lots of examples of break statements in the
kernel.

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2yxpgACgkQJNaLcl1U
h9D2EAf/WSOT4sEicM8hxRm4Afv0zc8QzmWWpk3kpMbsbHCyqGcZi3zLh98kr8lD
u47RPeWzylVb9VRl9y+sPxFSijyTtzN/QAbhGjEkK4hqE+q6mqsawKdKljlMdFUR
tx8E1yWONkYobWTs94EYAwP2gg6fsQs6qaUTqQWaZB2E5yvxjFsJWNoIpICxVYOR
oGFZzwW/ly8/taJtA5Q5310KIsLxmnl+HcJXQmZpRnZj3pdSUTKj3z9ukwgy9I9U
v1yBS4ghFDjZod4vkFjPEJZpScJLabIrgXFgGI/PCHvy7fkvB8Wz9IabAyfWMmVr
3kT2BFuIxxgXp2xDYxHDxFeahLzuMg==
=fpuJ
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
