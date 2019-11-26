Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9943C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D6220722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574788126;
	bh=7lVFbzhJh2zoE2B3dgEn9/Eh6L1BY1gOyCJeJ9Ml5xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kJFOzZHMlpLxQ03FyFyE8lb7LyPcRmgNirFSkDBfzKS/VV+AnMuspx4by50x4FDiq
	 CINVdjHSjIZQSNbWvZDsdPUT+udYjUVD3oAwqF61xRL7+1FRh+DuFKlA/oxWT3VG1c
	 ekPA74STItWdnV0Er4Ip/s/n97zkEPGdCFWOc29s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfKZRIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:08:45 -0500
Received: from foss.arm.com ([217.140.110.172]:37030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727309AbfKZRIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:08:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04A0130E;
        Tue, 26 Nov 2019 09:08:43 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 800953F68E;
        Tue, 26 Nov 2019 09:08:42 -0800 (PST)
Date:   Tue, 26 Nov 2019 17:08:41 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCHv2 6/6] ASoC: da7213: Add default clock handling
Message-ID: <20191126170841.GC4205@sirena.org.uk>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
 <20191120152406.2744-7-sebastian.reichel@collabora.com>
 <AM5PR1001MB0994720A0D615339A978E35C804E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <AM5PR1001MB0994E628439F021F97B872D480450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f+W+jCU1fRNres8c"
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB0994E628439F021F97B872D480450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: Where's SANDY DUNCAN?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--f+W+jCU1fRNres8c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 26, 2019 at 04:55:39PM +0000, Adam Thomson wrote:
> On 21 November 2019 21:49, Adam Thomson wrote:
> > On 20 November 2019 15:24, Sebastian Reichel wrote:

> > I've thought more about this and for the scenario where a machine driver
> > controls the PLL through a DAPM widget associated with this codec (like some
> > Intel boards do), then the PLL will be configured once here and then again
> > when the relevant widget is called. I don't think that will matter but I will
> > take a further look just in case this might cause some oddities.

> So I don't see any issues per say with the PLL function being called twice in
> the example I mentioned. However it still feels a bit clunky; You either live
> with it or you have something in the machine driver to call the codec's PLL
> function early doors to prevent the bias_level() code of the codec controlling
> the PLL automatically. Am wondering though if there would be some use in having
> an indicator that simple-card is being used so we can avoid this? I guess we

If we're special casing simple-card we're doing it wrong - there's
nothing stopping any other machine driver behaving in the same way.

--f+W+jCU1fRNres8c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3dXBgACgkQJNaLcl1U
h9CGSAf+LVy+9NSiyoXjsLLoc8cSA/mrUCloLSTGTbZmeYMjFxcMmLGZU83yPOT1
pbOynF8/SzqFJP0ILcAZ4WEAGePxP/6s33wOsw/PTyJcEH7Ito93TSlDurN3VkeS
/2PAlSBjzr9L65Kf5N6RnIeQsMTAVExjD/4wCtAkWFxisxBniStEhpyY/EArqYRq
NC8z+mwcYkwT8J1nzraxN+g9orGfymaB/YIy9eK2Y+nySshJMjeoj9KOlRSnbQup
xm5VspRQrvuxWQtv3sE0NQ91dJRon3pYUK1u8Ay3i9kVkpQmIQQDW9AHfBQXGPqP
+rD5yHvOs4/hcFBOCC/q8/5d7uZ/XQ==
=vlo0
-----END PGP SIGNATURE-----

--f+W+jCU1fRNres8c--
