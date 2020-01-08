Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88EEC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7411A2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578489785;
	bh=cTUeJMrPuAapMRQ3yHGUc1ITEIgv9Zm9prsnYmYx4vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=orlL0uPBsqMO5NMhcoGmHJfFRRRS9Or978qZb1h1WQ9vbutzn6CvrpoThKmpBMVVM
	 aLWFIJfjUDK1Mswdftb5b/iypbo5fFUf41XzhsP3Ab0yo67RBTNGvlmD6gSMGIV4KW
	 0DIxaqqMWTlFcfvHa7+BTwfrJwBnYof+8F9IUfuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgAHNXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:23:04 -0500
Received: from foss.arm.com ([217.140.110.172]:44500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgAHNXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:23:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A8B431B;
        Wed,  8 Jan 2020 05:23:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99F2B3F703;
        Wed,  8 Jan 2020 05:23:03 -0800 (PST)
Date:   Wed, 8 Jan 2020 13:23:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: Re: [PATCH v2 4/7] drm/panfrost: Add support for a second regulator
 for the GPU
Message-ID: <20200108132302.GA3817@sirena.org.uk>
References: <20200108052337.65916-1-drinkcat@chromium.org>
 <20200108052337.65916-5-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <20200108052337.65916-5-drinkcat@chromium.org>
X-Cookie: Trouble always comes at the wrong time.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2020 at 01:23:34PM +0800, Nicolas Boichat wrote:

> Some GPUs, namely, the bifrost/g72 part on MT8183, have a second
> regulator for their SRAM, let's add support for that.

> +	pfdev->regulator_sram = devm_regulator_get_optional(pfdev->dev, "sram");
> +	if (IS_ERR(pfdev->regulator_sram)) {

This supply is required for the devices that need it so I'd therefore
expect the driver to request the supply non-optionally based on the
compatible string rather than just hoping that a missing regulator isn't
important.  Though I do have to wonder given the lack of any active
management of the supply if this is *really* part of the GPU or if it's
more of a SoC thing, it's not clear what exactly adding this code is
achieving.

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4V17MACgkQJNaLcl1U
h9B1Tgf9F6myo+YZUDZcDAsE1tQHONaZ147hS3g2NDCgQf79b/fWyNVelAPRvxg+
wz+J0q2LmDX9K0ldimkt+BEitrL5aVQsPjw/WOXbOk/n4FBP11uDMxk9i586GGfO
EXHDmfUQh8D+wEjZBKck8+yaa0NYCFoHdlxc3rPILim9fGRiJKa18EdbPRfb7lNm
86k2Nkicmd8gkBfk7GlJ8MgGabr1ezpiza+F/vhTkEm+WHCcDwy+BadJG5whNnC0
GmKn0ieyraLxmVUjC4BpkJbeG/ye5VPCOcLn4ZjGrRU209STb45MyFAlAaYFNzX0
0wWQAm/aPa23vn2QhxYUW1RALdueLQ==
=UhEZ
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
