Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1D3C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFBA20843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565773743;
	bh=nm3AZYQqg9bViUcvgRl1pV30pLA1C+5Glu61dF/KaxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qNpUTa4W0FYFOyR8krOyJoJ4VZehS+iDyfNvA9JSsV0GN5SiMR68vVxhcjSiUKATb
	 usZ49xYWyQnWdRE69UtIFBOPl1Odwf0JfrGcd+/Oz4T6hE85POfOc/l2y+fHvMq51R
	 nYvLmjxWxPMtdB8cmBUwgPtX2WRnyjDsehHbpxFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfHNJJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 05:09:02 -0400
Received: from mail-wr1-f98.google.com ([209.85.221.98]:43922 "EHLO
        mail-wr1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfHNJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 05:09:01 -0400
Received: by mail-wr1-f98.google.com with SMTP id y8so4413189wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 02:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nm3AZYQqg9bViUcvgRl1pV30pLA1C+5Glu61dF/KaxE=;
        b=BGeZYxVWy2R58sArMqTJsQqhVtaw7rbDgpysr3RKmWMfm63FauzUo6IbXOQsae5aqv
         /NGUpeZ3fw42zG/D88fKd/dIE5ViYHfndrPMTIescBsEEiKOLktIr9LP76L1eYDUf9Zw
         VFl0AUL8P9crJozqcCVSb6Zl6mO/AnyurY3BlwvDue3/KG35Q1pkdIKmLCTybE0Op5aU
         8In+SQ9DLPPV91bhSZ1l4RwIhtLymrzEYfZ8USgN5bSnsLcFunjZOamCCqlxepr4bbqc
         ma7dfH7/CKMnPfkTUJc8OdDi7CS8tna3DQ3Ebqcb4fz6+esIasn4aA5OsjOwS3ila6zE
         YT4Q==
X-Gm-Message-State: APjAAAVIsJ5ykOE//u+hl19y2oHkty6omdWLxMC/CwwAiJzwOyONS+pk
        n6jQDNuI+ixNotWqkyvvyMoxlt9x881a4WYOyKyeXakhywLJKJystkRQiyavvuW/jw==
X-Google-Smtp-Source: APXvYqx09Vp6TVCKEOGeRGp2vPm76Veya96vzaDAvRDLPlwS7Ifbhnu0U5u4Sf7upuzG27awVEJE32T0GmlR
X-Received: by 2002:adf:e2c1:: with SMTP id d1mr53838825wrj.283.1565773738885;
        Wed, 14 Aug 2019 02:08:58 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id y196sm36316wmd.41.2019.08.14.02.08.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 02:08:58 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxpH8-0004cl-7R; Wed, 14 Aug 2019 09:08:58 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D9C112742B4F; Wed, 14 Aug 2019 10:08:56 +0100 (BST)
Date:   Wed, 14 Aug 2019 10:08:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, plai@codeaurora.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Message-ID: <20190814090856.GA4640@sirena.co.uk>
References: <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
 <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
 <20190813195804.GL5093@sirena.co.uk>
 <20190814041142.GU12733@vkoul-mobl.Dlink>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <20190814041142.GU12733@vkoul-mobl.Dlink>
X-Cookie: Bridge ahead.  Pay troll.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 14, 2019 at 09:41:42AM +0530, Vinod Koul wrote:
> On 13-08-19, 20:58, Mark Brown wrote:

> > There is something to be said for not abusing the TDM slot API if it can
> > make things clearer by using bus-idiomatic mechanisms, but it does mean
> > everything needs to know about each individual bus :/ .

> Here ASoC doesn't need to know about sdw bus. As Srini explained, this
> helps in the case for him to get the stream context and set the stream
> context from the machine driver.

Other drivers interoperating with the Soundwire DAI might want to do
something, it looks like that's the case for SOF.

> Nothing else is expected to be done from this API. We already do a set
> using snd_soc_dai_set_sdw_stream(). Here we add the snd_soc_dai_get_sdw_stream() to query

Well, if the API is not expected to do anything we can optimize it and
just remove it!

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1Tz6UACgkQJNaLcl1U
h9B7fgf+PvYlFGtuBj37wZOpu/dVlS5vmQbNkNVdhUbDbjO5oYTemRTIB5PukA4R
tO6idhVUsIlMWCvN6MZKJXPGgZfB7Heu84YAn3GvBmIFmY3J4c3QwsD1pIf1gmGH
X+xV//bbiewRLrA7LvbQalQanUpCVVlCrjsJ8FeDg+PFs4wPO9gE2N7pevVhzknu
tIaB6HO88+eAx0FfUUvXjWKo5qov/1LjhsI8Z2DJuKfpi9zfBatUz+/Q75d2WEJS
0G8ATi/5aZueU+YB1T6xdQtkS/lPIFRYN7dyMZrLyidtwkttiii8UzStBh64F6QO
MSoasP9IToaTUPdzqxcH3bIYBg2R3Q==
=pxWA
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
