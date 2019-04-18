Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6421C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA5B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555578571;
	bh=foXicEXuR6nFCA//9I9y9tnbKkzyudQrVa9w3ykFRxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mjiqm8sf47iH+aPhEa7sKcyb4vlFi1NF6CYBDTh9OIWhLRKDotGyS6FtH9v70ucii
	 SohCg9zZHJcOSX+y2oHFYobGMofhKcbkS1QEIKTeim/TdH89aJEBHX354z09ncseOO
	 TWYrh5N3EMKX+5vyNNPeWUA/ll8EwEBKoQfl71Rk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388558AbfDRJHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:07:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52998 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbfDRJHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=foXicEXuR6nFCA//9I9y9tnbKkzyudQrVa9w3ykFRxg=; b=Z4SuGOpnK9qbCwkP0N8IRMeNo
        2QRkwErKU7lZIMorqaCvci6tXTj4s/r3h+bZCaZa8njHhX9evmBDjjMsZL78hH/NvCBzvZSYEr4yO
        38KsGEWaiS57KsUkQNdY/Kvp8yCPsHbFFL0fRwMXkeuSt9rDL4Ql3DoF8QCyF4RCA9w5M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hH30l-00013T-Ba; Thu, 18 Apr 2019 09:07:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 86F211126DA9; Thu, 18 Apr 2019 10:07:14 +0100 (BST)
Date:   Thu, 18 Apr 2019 10:07:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Fletcher Woodruff <fletcherw@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 0/3] Fix jack detection for Chromebook Pixel
Message-ID: <20190418090714.GB6702@sirena.org.uk>
References: <20190405204257.87095-4-fletcherw@chromium.org>
 <20190415194557.9182-1-fletcherw@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline
In-Reply-To: <20190415194557.9182-1-fletcherw@chromium.org>
X-Cookie: A watched clock never boils.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 01:45:56PM -0600, Fletcher Woodruff wrote:
> Headphone/mic jack detection doesn't work on the Chromebook Pixel 2015.
>=20
> This patch changes the irq implementation to support polarity flipping
> and fixes the configuration code so that correct GPIO pins are read
> from ACPI.

I only have patch 1 here...

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly4PkEACgkQJNaLcl1U
h9AKBgf/d6flxv24JGmWelSWiY4bgbJoRjqeAQSiS+Vl86GgHlxJlsZ9GGS1okMX
JGvRgvtmaAVYSlyaCq/HPj6OBdDbxZkkzFgeVbP29akcS3l4zaDhwX04N9Ae5lHU
FzEUrhW/QkOrhFqxD6H8Y/K/gimOWH2Pt6vK6uRvbk58+VCCe6X3Vtq1dbagR8a9
zFMCOru7kGfrrcsl9VXnBkFVlivx36Mnakoh2RiVEPz5NHlGkURWpiHQY+B0qrtX
kx4Z2YF8QKrekCFUPzbu8gDYslAql/e8ngmjM268OqSGiFWXC73jT7rW1nijftaN
BG+679ghjWE0qX17Up/cjQLBbi0MAQ==
=vBBN
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--
