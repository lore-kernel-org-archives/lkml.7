Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83262ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517B02067B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570715505;
	bh=V/JXwCim9xHgJaWTIMmCuENQjrQuhOHBfhhfchcy6xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2IjC4nO5JVtUObp9TG3Tl0VZiFlY530nSxCnUJPhQp6zaKqcpP2pYRzpbHJlK4ieW
	 mZuCiyX0+dw41KsDa3Jju8gxW6Y9i72QK3XPdHezy9RzJ0I22sFCcCP/+oA1Kf7kTP
	 EdXB9xPlmCuLPSsDVEf0a9ArIDytCwtzFJO8wePE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbfJJNvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:51:43 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48866 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfJJNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 09:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V/JXwCim9xHgJaWTIMmCuENQjrQuhOHBfhhfchcy6xI=; b=OLb5MxWlClMtaennmKs5dNMzk
        WKm8AfEJOMKoj2CQzV8gr+lnf5tOUXnAYmJ4c/gSwuc7iwu+YYKwIaGyUXrZT2x0srTY5W0rEcju2
        30C4X1niDQHVoFx8GdCfS/c7yRrOcBwAJ4bUh762OIwcaq1dEcH1t3Y3sbhZzwvuehp+0=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIYqs-0001Sb-Os; Thu, 10 Oct 2019 13:51:34 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 6041DD0003A; Thu, 10 Oct 2019 14:51:34 +0100 (BST)
Date:   Thu, 10 Oct 2019 14:51:34 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Message-ID: <20191010135134.GR2036@sirena.org.uk>
References: <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
 <99d35a9d-cbd8-f0da-4701-92ef650afe5a@linux.intel.com>
 <5e08f822-3507-6c69-5d83-4ce2a9f5c04f@linaro.org>
 <53bb3105-8e85-a972-fce8-a7911ae4d461@linux.intel.com>
 <95870089-25da-11ea-19fd-0504daa98994@linaro.org>
 <2326a155-332e-fda0-b7a2-b48f348e1911@linux.intel.com>
 <34e4cde8-f2e5-0943-115a-651d86f87c1a@linaro.org>
 <20191010120337.GB31391@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/o1eWYFqMAfOorY1"
Content-Disposition: inline
In-Reply-To: <20191010120337.GB31391@ediswmail.ad.cirrus.com>
X-Cookie: Be careful!  UGLY strikes 9 out of 10!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/o1eWYFqMAfOorY1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2019 at 12:03:37PM +0000, Charles Keepax wrote:

> Usually aux devices are used for things like analog amplifiers that
> clearly don't have a digital interface, thus it really makes no sense
> to have a DAI link connecting them. So I guess my question here
> would be what is the thinking on making the "smart amplifier" dailess?
> It feels like having a CODEC to CODEC DAI between the CODEC and
> the AMP would be a more obvious way to connect the two devices
> and would presumably avoid the issues being discussed around the
> patch.

Or is this a device where for some reason (consistency?) there
really is no DAI and someone has decided to make an analogue
amplifier with a soundwire control interface?

--/o1eWYFqMAfOorY1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2fN2MACgkQJNaLcl1U
h9BJVQf/VmhKdvjGO+iSItUddcgbReAtHb/ahdMnhBgNm54DlfDRuvW2kr32nZDa
6nV6JI0UShGgIrN50nZeXoOTJqJudBkKPeN3bA4qdH09K/3KoUUccKcWFF9XGUNi
C/Ej7gQs/QrIvb2Cs4khYDg3TTzBRQYZgS59UYO0cr/5wQml5uMYCRjwbPTQGkGE
Z12uk1POwiqB7/+PtYf7Il4yn+ijyQlVF51ZUGIRGMDGWQMHqXwGg/pc9VX6bAM1
SJ2IDQ6L+pMpu7Jwyq9ymbTRf94gt+yfjLbLR5lUzX1mAC8CSy9CeSb+d7c3jx61
m3I30E3ocl8sxR6JHqmUUqrsbEB9hg==
=QvNW
-----END PGP SIGNATURE-----

--/o1eWYFqMAfOorY1--
