Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983ABC432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DEF2073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 13:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575381454;
	bh=dMhjP/jievxghATJcetWe9ihqNrI1HEWKB+ljOEzpDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a8moiNxfhEDGRHXBWq4nhhmhS7tyqSUSM6b+LVIMytGa30AiqawNj3Wd1BxKlkSdH
	 i1KOq3qCepX9LWeQsMy7qnLb0mYuORkjbmc+6vN0j6o2pdU+g+5HexNV9jo7NbGhUi
	 wk3VJFN9TPkC0lF7BMmOTvKjG18ZhHCLlXmBOFtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbfLCN5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 08:57:33 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34166 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLCN5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 08:57:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dMhjP/jievxghATJcetWe9ihqNrI1HEWKB+ljOEzpDo=; b=qCGwg1s5egJ+XIcBGmbCeXgZw
        GkcvAIc1pnYNLUidCLIQZQ1rkCb3/AaNvfHaw2loeRf8KcobDk6Iffw3GKAPXozE/QTADJ6YLeO3E
        LBtKDhQD5iQ8Yb9teK9l63w1MuTBjRWc/IJrO/8QUvVY0i8/qsNLLSD9Mkq/rXPg1gbqQ=;
Received: from fw-tnat-cam1.arm.com ([217.140.106.49] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ic8g2-0002b9-0S; Tue, 03 Dec 2019 13:57:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 916A0D002FA; Tue,  3 Dec 2019 13:57:17 +0000 (GMT)
Date:   Tue, 3 Dec 2019 13:57:17 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Brent Lu <brent.lu@intel.com>
Cc:     alsa-devel@alsa-project.org,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: da7219: remove SRM lock check retry
Message-ID: <20191203135717.GH1998@sirena.org.uk>
References: <1575358265-17905-1-git-send-email-brent.lu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRdC2OsRnuV8iIl8"
Content-Disposition: inline
In-Reply-To: <1575358265-17905-1-git-send-email-brent.lu@intel.com>
X-Cookie: Cleanliness is next to impossible.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRdC2OsRnuV8iIl8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 03, 2019 at 03:31:05PM +0800, Brent Lu wrote:

> For platforms not able to provide WCLK in the PREPARED runtime state, it
> takes 400ms for codec driver to print the message "SRM failed to lock" in
> the da7219_dai_event() function which is called when DAPM widgets are
> powering up. The latency penalty to audio input/output is too much so the
> retry (8 times) and delay (50ms each retry) are removed.

> Another reason is current Cold output latency requirement in Android CDD is
> 500ms but will be reduced to 200ms for 2021 platforms. With the 400ms
> latency it would be difficult to pass the Android CTS test.

Adam pointed out some specific problems this causes here but at a
higher level this commit message isn't great since it just says
"I don't like these delays so I made them shorter" which doesn't
really explain what the delays are doing or why it's OK to make
them shorter - there are plenty of audio devices which require
longer ramp times than people would like out there but there's
usually good solid reasons why the delays have to be there.

--jRdC2OsRnuV8iIl8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3mabYACgkQJNaLcl1U
h9Alvgf+O6LAdo281NDSae5rpCvfsxmLKh9POrtFw+1BQ0Sj8NX6kAjrShi6x//G
pXpypd9N3ikWjox5Fakw7VK1jz5QWUSdGR2PooLz1l8yJiu8KS13BAzZ128+9wzx
xAHMDv4Y4bEAUF6etkVz+C4cjjrvpPoJls41Fkd+mgUf4YJoSI1/2vaveJsh3SFZ
MqqGaxVSJF6Y8NkCiCi1iuwMJ54NEj0StvAJs/DoaC9QAgCKMJBN3A3mbtDvZrWD
efAisKVDhkz+xa6BUV+jW57SnSmFWvTY5zWBLCJGgnCHh2NWURd3nmEuV4kwtDdC
Svgjke4iToZwagfrdJkWbA4FqfAuMQ==
=jUTM
-----END PGP SIGNATURE-----

--jRdC2OsRnuV8iIl8--
