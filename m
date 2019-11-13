Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42DAC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9899A222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573655149;
	bh=pDH6eo76fm4Ww448YNgiv4t1zRqGCI1dzASDS0Ut32s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YfohlJNUE7JqtUPzv6eIkARiyLFRvkNl2fz3X+39XcWbrgOQo7PCqp8pbIfh0AGfA
	 qAxC45d6L1cXsfkYMqY0VsSeWAKCvr2CxKZjDKwhNLsoAh35mQYAsBk8e5q9uqcRKp
	 qb6HZqwWXe/zXIFYOKFV4val9B+IrzJ2YRJ4aGK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfKMOZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:25:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbfKMOZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:25:48 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CE3222D0;
        Wed, 13 Nov 2019 14:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573655147;
        bh=pDH6eo76fm4Ww448YNgiv4t1zRqGCI1dzASDS0Ut32s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aMNaZPiEEJym5GYKRS667x/n1xh4eOgDRzc8G/n/xIZSqmcZfunMA2jeGXdiGjEY4
         HRY+yYwDVebZoA/4q8nqOT0B2qH4Zkk81tILKQ4aBPMK8Iqh2ke8aSPoCbJKV3G40x
         8PUI9B5nmBKJgQ2QY/GP1Rm9aqfFYRh9YqPzMdn8=
Date:   Wed, 13 Nov 2019 15:25:44 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Tian Yunhao <t123yh@outlook.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/sun4i: tcon: Set min division of TCON0_DCLK to 1.
Message-ID: <20191113142544.GG4345@gilmour.lan>
References: <MN2PR08MB57905AD8A00C08DA219377C989760@MN2PR08MB5790.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6vu8ReRIjaA55nHT"
Content-Disposition: inline
In-Reply-To: <MN2PR08MB57905AD8A00C08DA219377C989760@MN2PR08MB5790.namprd08.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6vu8ReRIjaA55nHT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Wed, Nov 13, 2019 at 01:27:25PM +0000, Tian Yunhao wrote:
> The datasheet of V3s (and various other chips) wrote
> that TCON0_DCLK_DIV can be >= 1 if only dclk is used,
> and must >= 6 if dclk1 or dclk2 is used. As currently
> neither dclk1 nor dclk2 is used (no writes to these
> bits), let's set minimal division to 1.
>
> If this minimal division is 6, some common dot clock
> frequencies can't be produced (e.g. 30MHz will not be
> possible and will fallback to 25MHz), which is
> obviously not an expected behaviour.
>
> Signed-off-by: Yunhao Tian <t123yh@outlook.com>

Applied, thanks.

I had to update your author name to match the one in the
Signed-off-by. You probably want to check your git configuration to
remain consistent.

Maxime

--6vu8ReRIjaA55nHT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcwSaAAKCRDj7w1vZxhR
xU7XAP0fxqyNsoQ8ysyrGwSsWFp4AAWRd91NvKK8UgOJEivhHAEA9zIvnAoinYgK
QiNv766LtIfZTSaIm2fPqq3Ap46Q6QU=
=YtI3
-----END PGP SIGNATURE-----

--6vu8ReRIjaA55nHT--
