Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0730C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBB0214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565257889;
	bh=dLeNrbhglPmP5eQndFCqbFYNEEzyxn2RfC8vqpOm/zs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=cUE5M9HSeiJsnA2CwocCNvPlUPqnJLP0AC0WHMk33tAak1PrHLWPU8yDQv/xcIB21
	 GXgnadTwdzYFIPdGLqfTaZ2Cq2NkWG2xY2DeZ4ICjs4I8Wcu23ObmM1/FP295HccSl
	 zCngEr1ZKacs+MjRak86lAYYhKO42lYpLbFwr8y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfHHJv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:51:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:12452 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730678AbfHHJv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:51:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:51:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="asc'?scan'208";a="182547457"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2019 02:51:24 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v2 2/2 RESEND] usb: dwc3: remove generic PHY calibrate() calls
In-Reply-To: <20190808094128.27213-3-m.szyprowski@samsung.com>
References: <20190808094128.27213-1-m.szyprowski@samsung.com> <CGME20190808094146eucas1p27c673846a5a9be0c55f1f87c89af4adf@eucas1p2.samsung.com> <20190808094128.27213-3-m.szyprowski@samsung.com>
Date:   Thu, 08 Aug 2019 12:51:20 +0300
Message-ID: <875zn8t27b.fsf@gmail.com>
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

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> Calls to USB2 generic PHY calibrate() method has been moved to HCD core,
> which now successfully handles generic PHYs and their calibration after
> every HCD reset. This fixes all the timing issues related to PHY
> calibration done directly from DWC3 driver: incorrect operation after
> system suspend/resume or USB3.0 detection failure when XHCI-plat driver
> compiled as separate module.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
> ---
>  drivers/usb/dwc3/core.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index c9bb93a2c81e..7dd6d419254d 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -168,7 +168,6 @@ static void __dwc3_set_mode(struct work_struct *work)
>  				otg_set_vbus(dwc->usb2_phy->otg, true);
>  			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>  			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
> -			phy_calibrate(dwc->usb2_generic_phy);

are you sure you're the only one using phy_calibrate()? I don't want any
regressions because of this :-p

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1L8JgACgkQzL64meEa
mQZ7thAAwR1OAvfMJAot8JikjKsEFvKPVpdjj/HSpjbWs/0OwTfFHHSVY7Hm3ljp
vuTrSexoEo/zL4oqsqcyFHdELmeVjBVVvOCLGD1cW1XrvHj5zGqMXvcSq7NAq2UD
MhzmFZgfiMmQ0QCW8RmY4QRXmVDxYrsNDC43lCkQbtOze7j/w9ND9AA15duSdgnb
5zha4wVp9f2p6m3xEucHMsfI3AMyEfqiy6Q+hFnF+WQDgkIsKk5oaVuTo9cD9NzP
rACEXoWr9k8qhoasg0nuUvE1Zosen4x/WWZ0T7XzoiuPi6o7XJ+yXVEF6TuNU9Hr
5vj6WlEqobwoysqvHJxyN8WvdJhZGBhpfx7mmXCbTYrgZeCSck7E1+9gUTIgPZS0
nk/Cbrk4PiYYMoSZ5Q6nYx8/zfS7XTSwedT2+TkMaiqap4PAvOhD4xUuLURQLrOo
KNUOGcFGh5/3w5rf/gqJflnUQosNfo7EdqeuJTjo2IPe3a8oc18HKzjD3CLBhJgp
orkX2jKiDxJXUC62Bg0CjZn9IQJ3l/W0N80KHBI/dK++iGiNPPPGKvwCM1urWRjO
ijbZ4c2ApVGhcQVnprF8NtadLSr2DvK8MRLP1/EtmL05wVkCDazQ1gc/wI9D1iss
mWp/l63sykyltWn4whn+Hd+dnQwy/FuaFESWt/H/kkMtUDBBYGA=
=9rzr
-----END PGP SIGNATURE-----
--=-=-=--
