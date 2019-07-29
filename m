Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230C6C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20A120657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564431618;
	bh=faL9WznkOdwyDldS2bpVScupRoAe7/Grx6M6ZZ0qzpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0cggVkz97FwWQjIAU3XdsfkK1EmfZnhIbwwmwBxvTg9W+EMHyRfN7+Pf2l7OP/7WZ
	 Y5C0KNdhrl8gTaSK4KXjoNF1sEWX4w0sYMVeD2XHZlQZ8QYqEYZsPv4Cl1Wyv9H14q
	 XWaP80jPg7WXmj5dAU8Lkm/R0Ieo8c1OV+1OGkLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728730AbfG2UUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:20:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37558 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfG2UUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:20:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wwTzfyTq9xH2jVCB72SSD9pIFJfoUBESNUKZEPJQU/c=; b=nn7AqtlNX0eCysL+6//+UX/4T
        +AAPNROZ8E/00SYlmowzHnKikJN/2tuR5XgXgOdSAu891tr8GB/hO0snXfBkcCawN7AVTmMNAoFaA
        FS7E5u5xeF/skleakEMEGT2Lqrl7asvHfRWJavS0/NBOivAh5rdMDIKuJ9E8xW5U8VaZo=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hsC7m-0005MB-Uu; Mon, 29 Jul 2019 20:20:03 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 6B92C2742AAD; Mon, 29 Jul 2019 21:20:01 +0100 (BST)
Date:   Mon, 29 Jul 2019 21:20:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Timur Tabi <timur@kernel.org>, Rob Herring <robh@kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mihai Serban <mihai.serban@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [alsa-devel] [PATCH v2 1/7] ASoC: fsl_sai: Add registers
 definition for multiple datalines
Message-ID: <20190729202001.GC4787@sirena.org.uk>
References: <20190728192429.1514-1-daniel.baluta@nxp.com>
 <20190728192429.1514-2-daniel.baluta@nxp.com>
 <20190729194214.GA20594@Asurada-Nvidia.nvidia.com>
 <CAEnQRZDmnAmgUkRGv3V5S7b5EnYTd2BO5NFuME2CfGb1=nAHzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Content-Disposition: inline
In-Reply-To: <CAEnQRZDmnAmgUkRGv3V5S7b5EnYTd2BO5NFuME2CfGb1=nAHzQ@mail.gmail.com>
X-Cookie: A man's house is his hassle.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 29, 2019 at 10:57:43PM +0300, Daniel Baluta wrote:
> On Mon, Jul 29, 2019 at 10:42 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > On Sun, Jul 28, 2019 at 10:24:23PM +0300, Daniel Baluta wrote:

> > > @@ -704,7 +711,14 @@ static bool fsl_sai_readable_reg(struct device *dev, unsigned int reg)
> > >       case FSL_SAI_TCR3:
> > >       case FSL_SAI_TCR4:
> > >       case FSL_SAI_TCR5:
> > > -     case FSL_SAI_TFR:
> > > +     case FSL_SAI_TFR0:

> > A tricky thing here is that those SAI instances on older SoC don't
> > support multi data lines physically, while seemly having registers
> > pre-defined. So your change doesn't sound doing anything wrong to
> > them at all, I am still wondering if it is necessary to apply them
> > to newer compatible only though, as for older compatibles of SAI,
> > these registers would be useless and confusing if being exposed.

> > What do you think?

> Yes, I thought about this too. But, I tried to keep the code as short
> as possible and technically it is not wrong. When 1 data line is supported
> for example application will only care about TDR0, TFR0, etc.

So long as it's safe to read the registers (you don't get a bus error or
anything) I'd say it's more trouble than it's worth to have separate
regmap configuations just for this.  The main reasons for restricting
readability are where there's physical problems with doing the reads or
to keep the size of the debugfs files under control for usability and
performance reasons.

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0/VPAACgkQJNaLcl1U
h9DrPwf9F9mjf8fAHvxxejGLd/jN+TU84DVsVv13Qp3jhAgobbWx/oF2xmX3A+b6
uyfWch7Ud2SYvm2wXm/31JAXXi3aTlTq7niolXa7Hal3cLO4JAGCyFl6ex5knCHa
D6ddUZyPG8Rag+kjm/ef2DQpTGHxKcP9nV6OTsn3v6QfOtZZiyl0nzaZnuEpUoxW
Qz2WR2OxuRoA0Q/KaPiQCCP72GHZ5Vr2qDdteQXunE49dMnI6M0+e/WSbbJu+1tO
toN2vyGNnUtNZK9IKgLbes65ihBd0026Otqg+cQEehLspgy8pwSap7TyZ123sVhM
Z+xhfS+8ong2rDpferXo+La8/+Tx0Q==
=PIWO
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
