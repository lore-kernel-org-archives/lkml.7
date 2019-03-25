Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEF8C10F03
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA7FD20850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553515341;
	bh=BbaDHuCIjHwVA5COxU8wmejBxP5gbahV6kfZi/s8e78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=raN1Z6j/rhgNo4/ALkdQ5jWhDiKYLPdvlE3Up/ABzx+FNQmm5s4e8QjCBLsIWnrns
	 WJcOM7vgZPDpligOpGeNjn6byUJpw3NsF4O22y/n65vF53POKd8l9iEC4a+89NR84i
	 HJTTTl7qG1CfCPVfa1JDwe4jl1e2TyUcTFFsC4KI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbfCYMCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:02:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59020 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730917AbfCYMCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=9w2Bbs9+ekSlIlBp8qIOgTdmVVPDYvUGgXHwpgsR5Us=; b=vpWVzpzmnJd8q0zuPFlohCSS+
        dYiPHeLd1bYF2FQR6NJFzeBGvThUSboZTwRSV/8YYiTmR81IYpuDV678jsHG4iqOxnZ2P6Hoel+m/
        z76c88i/bKO6vUPrzNYPNdwi7YPdyD+uMo2f2ga7uQMujSphi0wjACklwbSv//fA5fhiI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h8OIu-00020m-OX; Mon, 25 Mar 2019 12:02:12 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 11E3811288F1; Mon, 25 Mar 2019 12:02:12 +0000 (GMT)
Date:   Mon, 25 Mar 2019 12:02:12 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>
Subject: Re: [PATCH] ASoC: intel: Fix crash at suspend/resume after failed
 codec registration
Message-ID: <20190325120212.GD7284@sirena.org.uk>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Content-Disposition: inline
In-Reply-To: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
X-Cookie: Short people get rained on last.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 22, 2019 at 03:39:48PM -0700, Guenter Roeck wrote:

> general protection fault: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 2811 Comm: cat Tainted: G        W         4.19.30 #15
> Hardware name: GOOGLE Clapper, BIOS Google_Clapper.5216.199.7 08/22/2014
> RIP: 0010:snd_soc_suspend+0x5a/0xd21
> Code: 03 80 3c 10 00 49 89 d7 74 0b 48 89 df e8 71 72 c4 fe 4c 89
> fa 48 8b 03 48 89 45 d0 48 8d 98 a0 01 00 00 48 89 d8 48 c1 e8 03
> <8a> 04 10 84 c0 0f 85 85 0c 00 00 80 3b 00 0f 84 6b 0c 00 00 48 8b

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyYw0MACgkQJNaLcl1U
h9BpXQf/XfEhm9WgqLCoQ+xlQVQEw2hewJ8Wk1PV54Fj6bBmRWT+tth9k6itaC31
DZzkoO6uBFN7Oke8ca1GiIhZGMjunhdPw1/qz0XWAlxdTog8HxkQTUKnbBCPJ7NR
3ju+/14lNBj8/mwmmVMnSquEwpdbLqzNkRhvi2bIwVggirTkzPSYDWa+lJkhVIUm
fonPORs/dNw2AZL4l4ZsjSdfAg1CDF+U7BwoiWqwahCSWFYmx8xk1k721idiFBwg
emR8gaozeE2TVTxUuUWrjbL7jbfuqcI27z4M6LoLLWCqgQa+QGkv0VwfSCfvCuMk
lR9K+ideBQjls3GBiMawPDqyNvyWFQ==
=ggRp
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
