Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E39C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 727B72077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 17:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575910834;
	bh=QTcljFFV059lJ91cMIeLQeJ+dUcLZ/OQ1eiKE24r7kY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jQ8KtCCLRTYv6oEODHISQcuTtgm9SkRw03U2OdMJNfVD+ie0Khmzq60edrkJW5aYO
	 peAHHXyXgs6peZR5eV6d4Ajv9tMLLSvMoACinZymHZlCWKYizcZjbqJts4CYghDHg2
	 udaVNNhQx/NqE9fWzmlH2m/MMM8TAXOOl51TCSME=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLIRAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:00:33 -0500
Received: from foss.arm.com ([217.140.110.172]:38564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfLIRAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 12:00:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 418FA1FB;
        Mon,  9 Dec 2019 09:00:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B39F33F6CF;
        Mon,  9 Dec 2019 09:00:31 -0800 (PST)
Date:   Mon, 9 Dec 2019 17:00:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Brian Austin <brian.austin@cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: cs42l42: add missed regulator_bulk_disable in
 remove and fix probe failure
Message-ID: <20191209170030.GH5483@sirena.org.uk>
References: <20191206075209.18068-1-hslester96@gmail.com>
 <20191209162417.GD5483@sirena.org.uk>
 <CANhBUQ0zwQG-=C12v02cf5kfvJba=5_=0JkZA45DDhxOzTBY6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIIRZ1HQ6FgrlPgb"
Content-Disposition: inline
In-Reply-To: <CANhBUQ0zwQG-=C12v02cf5kfvJba=5_=0JkZA45DDhxOzTBY6A@mail.gmail.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIIRZ1HQ6FgrlPgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 12:52:30AM +0800, Chuhong Yuan wrote:

> I have a question that what if CONFIG_PM is not defined?
> Since I have met runtime PM before in the patch
> a31eda65ba21 ("net: fec: fix clock count mis-match").
> I learned there that in some cases CONFIG_PM is not defined so runtime PM
> cannot take effect.
> Therefore, undo operations should still exist in remove functions.

There's also the case where runtime PM is there and the device is active
at suspend - it's not that there isn't a problem, it's that we can't
unconditionally do a disable because we don't know if there was a
matching enable.  It'll need to be conditional on the runtime PM state.

--WIIRZ1HQ6FgrlPgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3ufa0ACgkQJNaLcl1U
h9BFrgf+KMBI9l2Ruzln5WCg+/ELdsLj2dDgAlFZSOigICoPdgNnXzqk8gYIZxsb
5y5Q4mUcWncbjNq7PuWG/ddIonFPKyPhKb/h/xrdgbTPfqqEekryLHW93SS+sAiG
mLktyFWuPyvZOifDWfaFwYc1jzwsslgOweJOEoOw+fofsPlxe/3R8oom4zfpwdDV
KUUxIC5hEKjUfPTpOVdw+7Ud7JpFm7uR1qtd6LptcIOb+UO7FPm6EQhrkl0thiGd
fKGcPx/t3f/Xjn23+Nw3WmV+gSUX9t6wqsouwWB83Capsb4N3SMw7HFOPcy0S5vV
rB45x3AzVSeKCCSIKs1IywlYcsUO7w==
=feWL
-----END PGP SIGNATURE-----

--WIIRZ1HQ6FgrlPgb--
