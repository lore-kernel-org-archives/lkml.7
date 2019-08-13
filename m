Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70834C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FBD20665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565723912;
	bh=3gNGjIIX5OSATJPrjiaqC4tEdgA2GhEQ3ri4YNXQssg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sk5lWVfm5v/+K4xCA7yZOB1qQBBEaoJGwhjpbjjmjStO1LmYyRKFPqfgaeuaVA6lk
	 45mJyZDlKGOh9857koPXVCdXsMffyT/8kznEFSeaV8XjopQxf9j/T4xeu6IuSyOwTf
	 a7urF/8mBkjwKNfFDpK3i9ivH0xcW9o+2IdXybsw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfHMTSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:18:31 -0400
Received: from mail-ed1-f97.google.com ([209.85.208.97]:39191 "EHLO
        mail-ed1-f97.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfHMTSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:18:30 -0400
Received: by mail-ed1-f97.google.com with SMTP id e16so14610989edv.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 12:18:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3gNGjIIX5OSATJPrjiaqC4tEdgA2GhEQ3ri4YNXQssg=;
        b=a14pmDg1Eno5af+a+uQRzFaCRJhfBN+e/9a7KrVoY0fu3vaNYHfiPqcuoxagtGBM5D
         gzf3jU6K2dhy+CKVtstycSNXgEZkXmj/oFeR7tRzzv/7u+RS3BeCEnvjrAyw6oJcKw8E
         tzIa/gHSAmTQ7br04o0mVuMvR58O3Zqpu8EmDPbPyQo6Sgz1ifIoE1J5LSZcDkkqJl1K
         uxt9sE3aSjuJ9gf0yOF3JN80c8/CYoT+otSdhidRssS/ZzUBRB+GcGcfSqz2LL4UNBw5
         /EVNHlOqAnFJ6xM+/cgZrD4WTh/HG6g8lAIzgomIR3nqinygRvZdzYXZ0jEFjdO5sC/Z
         DGaA==
X-Gm-Message-State: APjAAAVhtFuBeZ5z7C8xQwb7gmIx1u84joDJ5HFJXfISzOVX1KjTuzZd
        bg8Q/jYWR/zSeFQxZ1sg/otBudllNCZYgipSM8D26W2jrImR+yqgKLxs69/JACG9Jg==
X-Google-Smtp-Source: APXvYqzPp/ymDwWktq8B8E6XaZXfCAkoCr3WIjSRc5pM5s28AxJsFOmyeNi4na33mOqrHTC1+Y0Rn13p5+DJ
X-Received: by 2002:a17:906:3c7:: with SMTP id c7mr27689622eja.187.1565723908955;
        Tue, 13 Aug 2019 12:18:28 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id l50sm29867edc.15.2019.08.13.12.18.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 12:18:28 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxcJQ-0000z1-E5; Tue, 13 Aug 2019 19:18:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 896132742B44; Tue, 13 Aug 2019 20:18:27 +0100 (BST)
Date:   Tue, 13 Aug 2019 20:18:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        plai@codeaurora.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 3/5] ASoC: core: add support to
 snd_soc_dai_get_sdw_stream()
Message-ID: <20190813191827.GI5093@sirena.co.uk>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2019 at 02:15:18PM -0500, Pierre-Louis Bossart wrote:
> On 8/13/19 1:06 PM, Srinivas Kandagatla wrote:

> > sorry for the confusion. It was too quick reply. :-)
> > I was suppose to say sdw_stream_add_slave() instead of set_sdw_stream().

> ok, so get_sdw_stream() and set_sdw_stream() are not meant to be mirrors or
> both implemented. It's just a helper to respectively get a context or set a
> context but a get-modify-set type of operation is not expected.

> Do I get this right?

This seems like it's going to be confusing...

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1TDQIACgkQJNaLcl1U
h9CEJgf/WNOBdWoFpepTAzRC/SOiL/VJjBnXIPHLxH3lof4Yx/1pbBvUPjYOwCHy
bBVUntfQnRhu7zgAjp1M5uC97VkFZbrj9s+32Tvcb43ye0dto5d63K3c3edekkjQ
ngfPnOA+yWL1BcfMLOAGY3OmTBIuUknyiMWfiLUVIDozt5dTHB0f9W02Qclp7J5I
BtoyMIUdvCVbUMc0KnQkZ19K/IZqBvqNQ6ca9T8gn3K50X30ab0jBgsbm1IXckpH
zmV/b4T553l8j47i/CyXS6K4trYVQ06tUcqyIRWzJZrPHQ/Ji/N62kTq2SOQV56w
nL8ZqN1yL7MUwJM3Qu7yx1MpwPJYYA==
=Xi1X
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
