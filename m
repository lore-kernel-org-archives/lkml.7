Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A5C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F897208C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565726288;
	bh=X82eQ3JesOlbLJhrRrufAi8tlKQch8wVXL6Dn+B2NqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uVKe/mLDZ3Z0uFaaiACL87hRwYivbEEFd21eyCe5krzqxuJ2xfY8dgUXcokUyZVzv
	 eCyHddO5kAbQRaAP/w3UMbDS2hwGvppq8ZkxkgiBrBTSusEI5drBjCp4d91TG8JYXf
	 1yUwsI3qkavjMuTVerfYxcSyiArak5zetAz8uepU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHMT6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:58:07 -0400
Received: from mail-wm1-f100.google.com ([209.85.128.100]:37663 "EHLO
        mail-wm1-f100.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfHMT6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:58:07 -0400
Received: by mail-wm1-f100.google.com with SMTP id z23so2486223wmf.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 12:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X82eQ3JesOlbLJhrRrufAi8tlKQch8wVXL6Dn+B2NqY=;
        b=Px4GBaIN5mg506MaggC/NsDMKTZQehrtOOMUGnDtsOrhO1yZ6DvAauMsHK7FBpK4QE
         PcwRY5DPxpl8hY+KIRc7sSoxPRaJdEmx2/GZ4fZ5Fp3lFDAm+HEGkg1ZzOK4uWCLdpcW
         ejzmepyG8wKJWQzdHV7hyBSBvbQJ8dObY2kttAD0RVKaMscaoZ2IA8PBok7JP6oJU3w2
         9wGGhL6CuxuwJcoQ3ZOivuP5czQctfL8X8vd0YPXo6D/Qw5O+QCx1jfseUyFQ4WO+bkH
         hgxX17mOSjmp0tScnSN4Fwtqkqeik/APC6nyy6xaBZrmMaPfDQxSkyCKslAYZPS9izST
         HRtQ==
X-Gm-Message-State: APjAAAVckReRW/aUijno/hLT/n+/ud6odZosUJxGx4LdNXEg0/mLnzY3
        IY6uj+drRhXlQ1HUcN8sxHIQPMAyz/VoQb1hLgIVPcXPcymxzWebRajKbUEXO/DjcA==
X-Google-Smtp-Source: APXvYqxon/uIKJW/6DSkZ8aDwhMWpVie1mmPg+IR6ytDM3UjTwfMbi1b1iVaauIXbL6K4CEGs+8TGRrQW6+T
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr4521112wmd.34.1565726285375;
        Tue, 13 Aug 2019 12:58:05 -0700 (PDT)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk. [2a01:7e01::f03c:91ff:fed4:a3b6])
        by smtp-relay.gmail.com with ESMTPS id q2sm1475349wre.51.2019.08.13.12.58.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 12:58:05 -0700 (PDT)
X-Relaying-Domain: sirena.org.uk
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1hxcvl-0001Al-5G; Tue, 13 Aug 2019 19:58:05 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id A97052742B44; Tue, 13 Aug 2019 20:58:04 +0100 (BST)
Date:   Tue, 13 Aug 2019 20:58:04 +0100
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
Message-ID: <20190813195804.GL5093@sirena.co.uk>
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-4-srinivas.kandagatla@linaro.org>
 <ba88e0f9-ae7d-c26e-d2dc-83bf910c2c01@linux.intel.com>
 <c2eecd44-f06a-7287-2862-0382bf697f8d@linaro.org>
 <d2b7773b-d52a-7769-aa5b-ef8c8845d447@linux.intel.com>
 <d7c1fdb2-602f-ecb1-9b32-91b893e7f408@linaro.org>
 <f0228cb4-0a6f-17f3-fe03-9be7f5f2e59d@linux.intel.com>
 <20190813191827.GI5093@sirena.co.uk>
 <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k1BdFSKqAqVdu8k/"
Content-Disposition: inline
In-Reply-To: <cc360858-571a-6a46-1789-1020bcbe4bca@linux.intel.com>
X-Cookie: Poverty begins at home.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k1BdFSKqAqVdu8k/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 13, 2019 at 02:38:53PM -0500, Pierre-Louis Bossart wrote:

> Indeed. I don't have a full understanding of that part to be honest, nor why
> we need something SoundWire-specific. We already abused the set_tdm_slot API
> to store an HDaudio stream, now we have a rather confusing stream
> information for SoundWire and I have about 3 other 'stream' contexts in
> SOF... I am still doing basic cleanups but this has been on my radar for a
> while.

There is something to be said for not abusing the TDM slot API if it can
make things clearer by using bus-idiomatic mechanisms, but it does mean
everything needs to know about each individual bus :/ .

--k1BdFSKqAqVdu8k/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1TFksACgkQJNaLcl1U
h9BHfQgAhhh0D7Hg5E7dHFAw9gfqCTOCQFEV16Tm0f23eAZ2yPanGpNNC0hohDnH
y77jzS/Zh0WxkcN5gH7rQI0bTrbDVeZpQd0+Wo1egQK9eqfVkjZi+gE2O8v/VjCW
Hcou9+7P7205uP/LB7vuMzVbhKpTF4fPpbhIuJ44MV39BO+sQ+nptMl4ialTd/Y2
kjLdoCl/v6TIAY3GztKKmOvUo58xPak85st45COal2f5bUIBbKxs1Ss/x8VMSPlE
OvPxl5aUzKuFFiVXGekHr+hR/INMri9LWuBQpqrTatdyS0P2p/Sc/r9oNzrl8z+7
PKRpKAk3EYaOsSo49DWaJw3wREGyqQ==
=REil
-----END PGP SIGNATURE-----

--k1BdFSKqAqVdu8k/--
