Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A223AC33C9B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73EC4215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578300763;
	bh=b6Jis3RiiTkEdaovjFiMev+VfEAJ4NDUdWfvEPs7Izk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FhQ7h8QjNQbjZoOL0u0iYDHRH8zayF7dzh+3fdF+qljS1KXajrFtqNtnuEaJQYKvo
	 +cDzQeE6lhhKHCnP8lkYfnSotnbfRIVKhQbS8bXtozWKa+opWdP2wFi2olo77phW/E
	 hWNfU7Wt/rp3Hg6d5Bg3pRBAWKWM9M0q2MN79nfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgAFIwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:58400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgAFIwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:52:42 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3771A20848;
        Mon,  6 Jan 2020 08:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578300761;
        bh=b6Jis3RiiTkEdaovjFiMev+VfEAJ4NDUdWfvEPs7Izk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTDnnWHe5BMQnU1cBoXzYTmvaoDk/vche4AjdcYnWaVziDBfO8fcm0yi8nE35bAhd
         rQydGnEDNZbUSuPArT2zCGmx0+BnIbbalkc3Fo6GZQf3tkgaA0M7zwryjx2seDXC8y
         ZajiILbRR76q/JCxp99K1c6XXlfMztB1H3hwqLrQ=
Date:   Mon, 6 Jan 2020 09:52:39 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] media: sun4i-csi: A10/A20 CSI1 and R40 CSI0
 support
Message-ID: <20200106085239.6cpynhhnkr2sx7mt@gilmour.lan>
References: <20200106084240.1076-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="24s53jh5fxrslbfy"
Content-Disposition: inline
In-Reply-To: <20200106084240.1076-1-wens@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24s53jh5fxrslbfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2020 at 04:42:33PM +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
>
> Hi everyone,
>
> This is v2 of my A10/A20 CSI1 and R40 CSI0 series. v2 is simply the
> remaining patches rebased on top of linux-next 20200106, with the
> MBUS device tree binding changes converted to YAML format.
>
> This series adds basic support for CSI1 on Allwinner A10/A20 and CSI0 on
> Allwinner R40. The CSI1 block has the same structure and layout as the
> CSI0 block. Differences include:
>
>   - Only one channel in BT.656 instead of four in CSI0
>   - 10-bit raw data input vs 8-bit in CSI0
>   - 24-bit RGB888/YUV444 input vs 16-bit RGB565/YUV422 in CSI0
>   - No ISP hardware (CSI SCLK not needed)
>
> The CSI0 block in the Allwinner R40 SoC looks to be the same as the one
> in the A20. The register maps line up, and they support the same
> features. The R40 appears to support BT.1120 based on the feature
> overview, but it is not mentioned anywhere else. Also like the A20, the
> ISP is not mentioned, but the CSI special clock needs to be enabled for
> the hardware to function. The manual does state that the CSI special
> clock is the TOP clock for all CSI hardware, but currently no hardware
> exists for us to test if CSI1 also depends on it or not.
>
> Included are a couple of fixes for signal polarity and DRAM offset
> handling.
>
> Patches 1 and 2 add CSI1 to A10 (sun4i) and A20 (sun7i) dtsi files.
>
> Patch 3 adds a compatible string for the R40's MBUS (memory bus).
> This patch needs to go through Rob's tree as it now depends on
> the patch "dt-bindings: interconnect: Convert Allwinner MBUS
> controller to a schema" that was already merged.
>
> Patch 4 adds CSI0 to the R40 dtsi file
>
> Patches 5 through 7 are examples of cameras hooked up to boards.

Applied 1,2 and 4, thanks!
Maxime

--24s53jh5fxrslbfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXhL1VwAKCRDj7w1vZxhR
xfDyAQCkgCSqpGYC5RzFk6hId5gLqLdB/gJiXK0I0mFarhoq/gEAryLfeP9h5uAO
wCxioJw0iIMDgJfMOOHQz69VhQbrYQY=
=Gazn
-----END PGP SIGNATURE-----

--24s53jh5fxrslbfy--
