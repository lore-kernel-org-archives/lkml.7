Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AFFDC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5279B2077A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 19:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563219542;
	bh=AlW6HkTDyi9y78GOHB4XOb2nGkPZNzF4LHvHjb5p0fc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v1px9I7PB8fufmTqkzOD3w1rjcvEpB23fdfyb2pYo/xsgH7F5syoREMrS+oBy9VA9
	 xlRlyl2f5Hpoi2oGljr278fCXSb4xTdQUq6ODEAJSdIL/lw5nBAHHrGM3FzPj1tGFP
	 8jt3NJToK/XDsTT2XsopRjKrUGLUoWEoQIfBsYFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbfGOTjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 15:39:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33948 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730362AbfGOTjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 15:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uEtSh3X6xQ1lITiuNz9x5IdXNtqfNQ17vMJkyrNs1LY=; b=xhH0p1EXjiOkPBx2ciKgSWD71
        u82dCi2hbyODuxO1uD0AIUppV8S/kASktp6GzA0pvZVBIBRjSO0Y0JF7eT/71rL66NWAZSpUCPURZ
        Fn4rq67eYTNi5AjqGx17ZndeOaQtXV3j/YS/R78oQwOof/eNXxXEHD+jPULJP+irjSSCI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hn6o6-0002Mz-PI; Mon, 15 Jul 2019 19:38:42 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 3C51B2742A1F; Mon, 15 Jul 2019 20:38:42 +0100 (BST)
Date:   Mon, 15 Jul 2019 20:38:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 0/7] Allwinner H6 SPDIF support
Message-ID: <20190715193842.GC4503@sirena.org.uk>
References: <20190527200627.8635-1-peron.clem@gmail.com>
 <CAJiuCcfUhBxEr=o7VVpPROQZadQh7z1QC0SkWSYt-53Sj3H2qw@mail.gmail.com>
 <CAJiuCcc3_1jZWV7G3+fFQYRZ8b6qcAbnH+K6pkRvww6_D=OMAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aT9PWwzfKXlsBJM1"
Content-Disposition: inline
In-Reply-To: <CAJiuCcc3_1jZWV7G3+fFQYRZ8b6qcAbnH+K6pkRvww6_D=OMAw@mail.gmail.com>
X-Cookie: Fremen add life to spice!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aT9PWwzfKXlsBJM1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2019 at 09:21:01PM +0200, Cl=E9ment P=E9ron wrote:
> Hi,
>=20
> I'm missing ACK from ASoC Maintainers patch 2-3-4.
>=20
> It's really small paches, if you could have a look at it.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--aT9PWwzfKXlsBJM1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0s1kEACgkQJNaLcl1U
h9Cw6Af+Lg1FCdunvHuQWgM9lkfW1yDRebhjo8R5qhgUtQE295gHjgjdqQ8xh6eM
ZK1py52Bhvt7DJsJFZfrEBSzhkvLbYMENjj17tSpW3A6H7wHzkyGUOKq3FRIzG6m
WciJzBWDsDtHEO6OUcrPDjvDJWOPeF8h2O+TOgsqOAGMDUPYG3l1iBozqVsFhwGA
b79wc9pIIKvVsp71cE9ZF/m9Y9JTsIyf6Omq4m0zx7KD7nEP0oqnmtg+8AI+lkrC
VEvioUOv9swbYdTsuPP+lwPqI/Wun1n4XDmppLD81iaZn8oHhW0FlU35PjoPRgGK
oPWiRnOfQWTiKTZ5PFdwsicKK9ZQYg==
=tPgX
-----END PGP SIGNATURE-----

--aT9PWwzfKXlsBJM1--
