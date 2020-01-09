Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC45C33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1363C20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 20:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578602151;
	bh=Gl009jaqNrE0tOUbIIcGGEQrEezzGC/SotfPQvPhBM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jf8NtI52VeCDDxh+VHTWCkZ9JM8BoQsE+R6n45NXd29AQmEQS2kgEXGni3ESgMPzS
	 611HXpdfWITHVeoo8DE58Jlmuq0Jq7j3ysAF+38wIPXsuzyEn0JEzYAOY6lEQ+TouR
	 daggDIcNcjLn/0+54xXVvRB5Os9ycGql7nt3g64k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgAIUfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 15:35:50 -0500
Received: from foss.arm.com ([217.140.110.172]:36536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727738AbgAIUft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 15:35:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 782AD31B;
        Thu,  9 Jan 2020 12:35:49 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDF083F534;
        Thu,  9 Jan 2020 12:35:48 -0800 (PST)
Date:   Thu, 9 Jan 2020 20:35:47 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Peter Seiderer <ps.report@gmx.net>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Annaliese McDermond <nh6z@nh6z.net>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v1] ASoC: tlv320aic32x4: handle regmap_read error
 gracefully
Message-ID: <20200109203547.GF3702@sirena.org.uk>
References: <20191227152056.9903-1-ps.report@gmx.net>
 <20191227225204.GQ27497@sirena.org.uk>
 <20200106214534.39378927@gmx.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <20200106214534.39378927@gmx.net>
X-Cookie: Killing turkeys causes winter.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2020 at 09:45:34PM +0100, Peter Seiderer wrote:
> On Fri, 27 Dec 2019 22:52:04 +0000, Mark Brown <broonie@kernel.org> wrote:
> > On Fri, Dec 27, 2019 at 04:20:56PM +0100, Peter Seiderer wrote:

> > Please think hard before including complete backtraces in upstream
> > reports, they are very large and contain almost no useful information
> > relative to their size so often obscure the relevant content in your
> > message. If part of the backtrace is usefully illustrative then it's
> > usually better to pull out the relevant sections.

> Thanks for review..., but a little disagree here, do not know much which
> is more informative than a complete back trace for a division by zero (and
> which is the complete information/starting point for investigating the
> reason therefore) and it would be a pity to loose this valuable information?

Right, some backtrace is definitely often useful for understanding where
things broke and helping people search for problems - it's just
providing the *full* backtrace that can be an issue as a lot of it can
end up being redundant.  As a rule of thumb I'd tend to say that once
you get out of the driver or subsystem you're starting to loose
relevance.  For example with a probe failure like this once you get out
of the driver probe function it almost never matters exactly what the
stack in the device model core is, it's not adding anything and it's
usually more than a screenful that needs to be paged through.  Cutting
that out helps people focus on the bits that matter.

> Maybe I should have added more information about why and how the failing
> regmap_read() call leads to a division by zero?

Any analysis you've done about why things got confused and broken is
definitely good to include!

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4XjqIACgkQJNaLcl1U
h9Cp2wf/YJiRtkQvhbTHYFHL1Nxg5pueZnzeL+EEaSw+j+5E4OSX+sWbuf16NXYq
k+HWa02py4PZcKYQVmxf9b4PTjmpqcGiMWOtjDVj6/TafOEs0ovOwLQLAwuUb9By
oh/jsZ2VwIhBVTAKxmEOyFvy+eYBMonIv4QVAD9Mv8vLpuHGm9FUEPw3D2uy/33s
1PFU4BscfvDufOHEIe3afqutQNzPYb2KTZXqmYuEw5hUgf1h0vxBIAtO5YTwhvGT
cTCbYdzVq1cwTlzH3EpiQZGhXUJ11agI5gaNys662gzIvtq7kIpx20N2Kuy0+kif
9L3c5IlUHB3yAzpoowuDrrRqIKWI+g==
=VKVc
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
