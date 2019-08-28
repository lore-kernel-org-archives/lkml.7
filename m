Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6FEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3380217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 20:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567025532;
	bh=HxiqxTf8faD1msBLHz3HV/ABBmxYsPH3gN3BA6t7eIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PSivY+jzF4tSyCQ9JRel+6lvS1yzbQLEMxxbyQINEw+bk0j5mC2hUMidD+h2rUWPl
	 M6YV33vE5lrcjkCFKRK4/yzzqBBWR53+pJ3ojWSll84pAlrVysLhIF9BtQoBnYhbEs
	 G44mJjm2Snck8ANMO1QwQciIgSEm1WU8Iv2Lf4y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfH1UwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 16:52:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46126 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726616AbfH1UwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 16:52:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AVPMlOp8TwCm/B2SRGvb8TqqWHTIVFeNesWs0ES1bTo=; b=U0LY1DVwfDBtZbUe0Wc7XT4Ng
        eCRauOI5QxY0qSLsBU4KORFmyGsMTdxvGzuOU8RjfgSgx5S/hvbfapnWuWyfFc/D/gKB/EUS04bpr
        mrniz7hKRyE9sme4i34895JH8F21VNuwuXOR3UY5syKdXgblQp+mxa7l5JRhHKhwKbiPE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i34ux-0006c6-1Y; Wed, 28 Aug 2019 20:51:47 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 66E042742B61; Wed, 28 Aug 2019 21:51:44 +0100 (BST)
Date:   Wed, 28 Aug 2019 21:51:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2] vsprintf: introduce %dE for error constants
Message-ID: <20190828205144.GK4298@sirena.co.uk>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20190827211244.7210-1-uwe@kleine-koenig.org>
 <20190828113216.p2yiha4xyupkbcbs@pathway.suse.cz>
 <ebd9e2f6-a6f7-b3df-480d-cd6b818fb065@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J2pR2RtFp0tAjF3C"
Content-Disposition: inline
In-Reply-To: <ebd9e2f6-a6f7-b3df-480d-cd6b818fb065@kleine-koenig.org>
X-Cookie: Oatmeal raisin.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2pR2RtFp0tAjF3C
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 09:59:16PM +0200, Uwe Kleine-K=F6nig wrote:
> On 8/28/19 1:32 PM, Petr Mladek wrote:

> > Please, do the opposite. Add conversion of few subsystems into the
> > patchset and add more people into CC. We will see immediately whether
> > it makes sense to spend time on this.

> For now I asked in the arm linux irc channel and got two people replying
> (both added to Cc:):

> Mark Brown (maintainer of SPI, regmap, ASoC and regulator) said:

> 1567019926 < broonie> ukleinek: I think that's a great idea and have
> 	thought about trying to implement it in the past.
> 1567019937 < broonie> ukleinek: Making the logs more directly readable
> 	is enormously helpful.

In the past I've actually implemented error code decoders like this for
some other systems I've worked on due to annoyance with having to look
up codes, as far as I can tell they went over quite well with other
developers and I certainly found them helpful myself.  They're also
useful to end users looking at logs, they're not always aware of how to
find the relevant error code definitions so a slightly more descriptive
messages can help people figure things out.

It does also occur to me that this might be useful to the people who
want to work on making probe deferral quieter since it gives them an
annotation that the number going in is an error code.  There's a bunch
more work to do there though.

--J2pR2RtFp0tAjF3C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1m6V8ACgkQJNaLcl1U
h9ADqAf8DQNAwWvUmNzD11savIMgUa9QDovvhuNqbDJ68y+q3/MNqqtULyxlM9EU
ddDFK42VpctrmBRfQAKOxk+IuKGL3sPKFZhlSzc2Ilgbprj/A+4Jat91LxYZGZDZ
OZarYQg0PoIrdzHWNjuCstvvklJktdoZ7bG5JHTootFTCfHRRaahp60OPtHa9Fiv
BLee/u09Tk2bO8X9kfXs+EW6ETPYxlXffZxbbkU7jGVa9sS4/6YBjSFxI864k6b/
BfxgfFnV0H4Kva/dSYOEaP9Z37uScY4bs/0AY/eOeOJBodYMvAK+u3SJKPAZzIuG
JY6qO/tG/EcNAWFwnP+abgvmgahxNg==
=6V5A
-----END PGP SIGNATURE-----

--J2pR2RtFp0tAjF3C--
