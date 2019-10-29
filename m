Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C1ACA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DA520717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572340446;
	bh=f+5tvZ1y+zrkiae4p/cZqKEGrbBnTAF/LeUAQY1AP+E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=iCHZZRqxVVDVYD4CDLQc7LUduhfW8yaCjYzFCIFLCavAwzGHpGHZkHIwsSl+IPj7i
	 2uzw8j1vLehglf7tVDkRTzeL28Pw9jaZf4OHbdispt3d3l6SFxKd0HEj8ep5eyXPlL
	 EmJL4bgo8TqI5lJAW9V1hsk60VrNBP8WCRu0cbmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfJ2JOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:14:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:21896 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729876AbfJ2JOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:14:04 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2019 02:14:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,243,1569308400"; 
   d="asc'?scan'208";a="198869249"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga007.fm.intel.com with ESMTP; 29 Oct 2019 02:14:00 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 5/9] usb: dwc3: Rework clock initialization to be more flexible
In-Reply-To: <20191028215919.83697-6-john.stultz@linaro.org>
References: <20191028215919.83697-1-john.stultz@linaro.org> <20191028215919.83697-6-john.stultz@linaro.org>
Date:   Tue, 29 Oct 2019 11:13:56 +0200
Message-ID: <87k18nj4mj.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

John Stultz <john.stultz@linaro.org> writes:

> The dwc3 core binding specifies three clocks:
>   ref, bus_early, and suspend
>
> which are all controlled in the driver together.
>
> However some variants of the hardware my not have all three clks
                                        ^^
                                        may

In fact *all* platforms have all three clocks. It's just that in some
cases clock pins are shorted together (or take input from same clock).

> So this patch reworks the reading of the clks from the dts to
> use devm_clk_bulk_get_all() will will fetch all the clocks
                              ^^^^
                              which?

> specified in the dts together.
>
> This patch was reccomended by Rob Herring <robh@kernel.org>
> as an alternative to creating multiple bindings for each variant
> of hardware when the only unique bits were clocks and resets.
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> CC: ShuFan Lee <shufan_lee@richtek.com>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Felipe Balbi <balbi@kernel.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Jun Li <lijun.kernel@gmail.com>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jack Pham <jackp@codeaurora.org>
> Cc: linux-usb@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v3: Rework dwc3 core rather then adding another dwc-of-simple
>     binding.
> ---
>  drivers/usb/dwc3/core.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index a039e35ec7ad..4d4f1836b62c 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -305,12 +305,6 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
>  	return 0;
>  }
>=20=20
> -static const struct clk_bulk_data dwc3_core_clks[] =3D {
> -	{ .id =3D "ref" },
> -	{ .id =3D "bus_early" },
> -	{ .id =3D "suspend" },
> -};

another option would be to pass three clocks with the same phandle. That
would even make sure that clock usage counts are correct, no?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl24AtQACgkQzL64meEa
mQYMmw//YiNtxgf2s0jGPGMK9XPPyt3B+0Hjw0tE4vsbyoykxXWmn49yB/JXmfnM
YaRY+9jYTLxlxC1wJJgxIew5Kf5parnlIpuD2XY8uB1L4AsI+ZrSuts1CF3tUiP6
V1CEgyJ4bPPJmi0sYDSI6MOdUcKmAb0KtBisgtMFS2Pe5RyFNAEOt1sXKrqUAj7d
Exl9UbtV4FqLWrTRVbwZJ4Un7+8g4dqXw6dAd1h9ETLwtY3e6es5MLASUu5oL6V0
bW2Vst+cT36Xodv9fxk5ndEk1sJk9of/oMazawBPlYhP7rBsd4rmcWzIKfK/nAYE
4YZVBvW/goLL7PCtp5FGp3WLs4j8MN/4ftMQhLFa8JcYhgBNrCHWlmvXEC3WELDn
yhh/2L/7AxPTcI+GbtjRs9dF0Hxe4NlPOtX7qxfHJevorYidcVRD3yYC/KQZxYWK
LTuGvW8HGb0wr5TIj1F+2iPl//H5Bh/pAqkik0StNOqOFX8ADSym6NW4wL7zfHLI
113wta5hk1VX2w3cpGWB4phNqD7RfouUTCj5aVX9DxhjtVqUk3X4gUVs5ixTxE7e
b88sYwz8sbEgHNtt9lCRRxmi2NjzVY0KjpRTacf9AodWokwwbhetgkboSo8gmunc
lV3vlfoWKWhR9Th5AWthrKJ/c7pKkqlOVhz7apzxa1k848RNmi0=
=Uxbt
-----END PGP SIGNATURE-----
--=-=-=--
