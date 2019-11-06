Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C112C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6E72187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573059992;
	bh=uLRxmlc6d+JiTreFgL0aWOGSJ5DgAyY8ZplTzQiL7XQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p8UwVkzUXqPaokZ10b+seihbsqmSca1hUaueljSoTgVD6teyyBYFCMoP+uuSL6/32
	 3zRkk5M7s+Iqe2Rasku4H/CRVvICv2KIG22wHR/KlBh+pYR3ZRJO267cNPOepwYnxa
	 JtpuIiBK2GRzpXwF4nXIF4XtWAW1szSJdDGm34nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfKFRGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 12:06:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43524 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfKFRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 12:06:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ezCIO+lFqtUT0UzJR4NajfDokaUzH2Q2R0P2sNn9les=; b=c9wFz4hRgvRc99LLWN/T1GTg+
        LbpdvxRZK3g+vpD+YTqTSa+GJTHT5hVm86y3as1T4m2JOELIUK0FF8rw0VDuT3Iy+tgOIdR1jI5zl
        ZiqQOznz4ptyNKfqEwsUv9QGpUtlZcXmciI3WYAzPPNydQ/nNRw5NEG5GtSNfeRBf+z1s=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iSOl4-0001tA-Iy; Wed, 06 Nov 2019 17:06:14 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A3E9E2743035; Wed,  6 Nov 2019 17:06:13 +0000 (GMT)
Date:   Wed, 6 Nov 2019 17:06:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>,
        Maruthi Bayyavarapu <maruthi.bayyavarapu@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Akshu.Agrawal@amd.com,
        Sanju R Mehta <sanju.mehta@amd.com>, djkurtz@google.com,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [alsa-devel] [PATCH v2 3/7] ASoC: amd: Enabling I2S instance in
 DMA and DAI
Message-ID: <20191106170613.GE11849@sirena.co.uk>
References: <1573137364-5592-1-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <1573137364-5592-4-git-send-email-Vishnuvardhanrao.Ravulapati@amd.com>
 <99656586-8512-ed13-6174-12e0b1fbb3dd@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lteA1dqeVaWQ9QQl"
Content-Disposition: inline
In-Reply-To: <99656586-8512-ed13-6174-12e0b1fbb3dd@linux.intel.com>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lteA1dqeVaWQ9QQl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2019 at 10:34:54AM -0600, Pierre-Louis Bossart wrote:
>=20
>=20
> On 11/7/19 8:36 AM, Ravulapati Vishnu vardhan rao wrote:
> > This patch adds I2S SP support in ACP PCM DMA and DAI.
> > Added I2S support in DMA and DAI probe,its hw_params handling
> > its open and close functionalities.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--lteA1dqeVaWQ9QQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3C/YQACgkQJNaLcl1U
h9ArOQgAht7bgmnQJdpVp5l7IWMftkKi3ziKEPuoEkjW98IEYZ3al7FiJ/Eg+Cc8
AD8ry73ti7FFnGIgJrCiMZf/eDLbzcZxN+zWCjNmW2s0GozS0N9xw/dEJ97OH01/
fZNRjMjGmfloux+wZ3o/2OXnMBZEtYBmv62I6Qoc0uRH5boJZAh6RIovWyZgIxWe
qJ/UmfqFIqf9X+RqDfsgTdB3+qaGkGBWw0o1uMbZunkRHmlouS8tdFPPkP0pPfo2
wncn1Cmg0HK1iSnDuLghAHWQdxhVdfHn7h6v1ljN7Rr5lIbwVuh4bUYMW9Tdz1PX
Pz0X5ICSXHDtW7SkjpnACVQ0I/mU0g==
=2GZw
-----END PGP SIGNATURE-----

--lteA1dqeVaWQ9QQl--
