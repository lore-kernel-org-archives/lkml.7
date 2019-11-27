Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C738C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E085020665
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574869234;
	bh=JgooOjiS6IV2t6X2/X5K7xFX5h4OjHlHLGww9DuNNtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OPVqxwmV4CVVkY52zmcSm77ZIa2XMazMKLmohSk8cGypzxPzv13PYcDJEInAHKfhY
	 ndSmzv4JNNNTOWGKBk9kA0l4GaLO1VhljIzExWt2kWDoAz8BrcUJdMYEQOahbwI2ha
	 6XOtCuhdpMXQbY6tCbU/GtZeFa4ammZh4nxGePVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbfK0Pkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:40:33 -0500
Received: from foss.arm.com ([217.140.110.172]:49258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbfK0Pkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:40:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4A7630E;
        Wed, 27 Nov 2019 07:40:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4305C3F68E;
        Wed, 27 Nov 2019 07:40:32 -0800 (PST)
Date:   Wed, 27 Nov 2019 15:40:30 +0000
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
Message-ID: <20191127154030.GD4879@sirena.org.uk>
References: <20191120152406.2744-1-sebastian.reichel@collabora.com>
 <20191120152406.2744-7-sebastian.reichel@collabora.com>
 <AM5PR1001MB0994720A0D615339A978E35C804E0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <AM5PR1001MB0994E628439F021F97B872D480450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126170841.GC4205@sirena.org.uk>
 <AM5PR1001MB09949D557742E8817545637F80450@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191126175040.GD4205@sirena.org.uk>
 <AM5PR1001MB09940CF764711F1F13A6B37E80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191127123317.GA4879@sirena.org.uk>
 <AM5PR1001MB0994D842A2D7051F81A7765B80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TybLhxa8M7aNoW+V"
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB0994D842A2D7051F81A7765B80440@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
X-Cookie: In the war of wits, he's unarmed.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TybLhxa8M7aNoW+V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 27, 2019 at 01:42:54PM +0000, Adam Thomson wrote:

> nicest solution here though. I guess we're stuck with people having to manually
> configure the PLL for bypass when a non-generic machine driver inits, to avoid
> the initial double config, as I don't see other options unless you have
> something to specify at init that it's auto or manual, and this doesn't feel
> like a DT device specific property thing as it's more software than hardware.
> At least Sebastian's patch has a good comment block to highlight this.

Not sure I follow here - if we're configuring the PLL explicitly then
I'd expect the PLL to be configured first, then the SYSCLK, so I'd
expect that the automatic PLL configuration wouldn't kick in.

--TybLhxa8M7aNoW+V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3emO0ACgkQJNaLcl1U
h9BAnQf/Q4HBT+E0Q86c5T5kw3hIEfvjSfcdzKbqvPYBoxeiJPWz6BgtIYowJOk/
VIMobVK2PGfli24WdMYQtG8lwdNCUo5ff2DmOFSEc5U90CRHfaaHh1agqu8g+xX0
XENPmJDKQNV+T5AhrkNyulGeIwPqn2sOssOTTBzIRlQ5TeD8PvqDFmbNwQ1ty/wh
pJijH+imJpNcTVQtey9tEP29W2HUqqEURJK6n7QVOFseFXQKLv+KpQaMmsx0Jqrd
Js/kclZ1np41N3D15cACh/ANKG6RNaT5i03P9imE+ujeWPWFW92Z6P70vf5uzUug
Q/qbBvhCvX6qIgrcOnsmLYLAlZfXyw==
=bhaa
-----END PGP SIGNATURE-----

--TybLhxa8M7aNoW+V--
