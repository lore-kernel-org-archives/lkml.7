Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD500C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A80321874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565268484;
	bh=wyEVJEsBGC94RLV4HyI4Gad5qZWZuH10LrdeVre481M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=QPhM54QZI6fCzMRbSuBytjBT8poEEOz7pqq8Abz/Feg6S7ZFUkv4AcQ04rE5xAAZk
	 lSYGXUEOH7fRdkqtpAlydFqtIcSfnQOMo9Nx5SaxXV8txNNHAiNCAgeuQwO2hKEjm0
	 Kg/YxNl+vXpGtcn28eo3x+lE1bbzVIHlZ1gUlibU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732658AbfHHMsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:48:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:25787 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbfHHMsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:48:03 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 05:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="asc'?scan'208";a="326299253"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga004.jf.intel.com with ESMTP; 08 Aug 2019 05:47:58 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Roger Quadros <rogerq@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] usb: dwc3: remove generic PHYs forwarding for XHCI device
In-Reply-To: <20190719093037.16181-1-m.szyprowski@samsung.com>
References: <CGME20190719093045eucas1p1a1c6f26ae4103e9ed283fff2396beaef@eucas1p1.samsung.com> <20190719093037.16181-1-m.szyprowski@samsung.com>
Date:   Thu, 08 Aug 2019 15:47:54 +0300
Message-ID: <87h86rn7r9.fsf@gmail.com>
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

> Commit 08f871a3aca2 ("usb: dwc3: host: convey the PHYs to xhci") added
> forwarding of the generic PHYs from DWC3 core to the instantiated XHCI-pl=
at
> device. However XHCI(-plat) driver never gained support for generic PHYs,
> thus the lookup added by that commit is never used. In meantime the commit
> d64ff406e51e ("usb: dwc3: use bus->sysdev for DMA configuration")
> incorrectly changed the device used for creating lookup, making the lookup
> useless and generic PHYs inaccessible from XHCI device.
>
> However since commit 178a0bce05cb ("usb: core: hcd: integrate the PHY
> wrapper into the HCD core") USB HCD already handles generic PHYs acquired
> from the HCD's 'sysdev', which in this case is DWC3 core device. This mea=
ns
> that creating any custom lookup entries for XHCI driver is no longer need=
ed
> and can be simply removed.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/usb/dwc3/host.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> index f55947294f7c..8deea8c91e03 100644
> --- a/drivers/usb/dwc3/host.c
> +++ b/drivers/usb/dwc3/host.c
> @@ -85,7 +85,7 @@ int dwc3_host_init(struct dwc3 *dwc)
>  						DWC3_XHCI_RESOURCES_NUM);
>  	if (ret) {
>  		dev_err(dwc->dev, "couldn't add resources to xHCI device\n");
> -		goto err1;
> +		goto err;
>  	}
>=20=20
>  	memset(props, 0, sizeof(struct property_entry) * ARRAY_SIZE(props));
> @@ -112,37 +112,23 @@ int dwc3_host_init(struct dwc3 *dwc)
>  		ret =3D platform_device_add_properties(xhci, props);
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to add properties to xHCI\n");
> -			goto err1;
> +			goto err;
>  		}
>  	}
>=20=20
> -	phy_create_lookup(dwc->usb2_generic_phy, "usb2-phy",
> -			  dev_name(dwc->dev));
> -	phy_create_lookup(dwc->usb3_generic_phy, "usb3-phy",
> -			  dev_name(dwc->dev));
> -
>  	ret =3D platform_device_add(xhci);
>  	if (ret) {
>  		dev_err(dwc->dev, "failed to register xHCI device\n");
> -		goto err2;
> +		goto err;
>  	}
>=20=20
>  	return 0;
> -err2:
> -	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
> -			  dev_name(dwc->dev));
> -	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
> -			  dev_name(dwc->dev));
> -err1:
> +err:
>  	platform_device_put(xhci);
>  	return ret;
>  }
>=20=20
>  void dwc3_host_exit(struct dwc3 *dwc)
>  {
> -	phy_remove_lookup(dwc->usb2_generic_phy, "usb2-phy",
> -			  dev_name(dwc->dev));
> -	phy_remove_lookup(dwc->usb3_generic_phy, "usb3-phy",
> -			  dev_name(dwc->dev));
>  	platform_device_unregister(dwc->xhci);
>  }

Roger, could you verify that this doesn't regress any of your platforms?

Thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1MGfoACgkQzL64meEa
mQbikg//UH6PkjeKc14UABfn3WYRRhkmGCSIj4Jo8Fb+0VGwwnCwh6gynHnd/tF9
e92UjtzJvJaGadq+j9LPLvu1aL7P1RgAVSenk6e5FeDgfKg8AjH16y1Ds7YcG57K
rZYXp2EHn1JsdX9F2qb6h6aQIhU/QG2w6uZhuaC5ZSRHHbMPk3lUC9l2eEDtZIT7
VEtvx3yV5YatkOB3pVNIpYMsUncucQzQ9YWH7+GaAKuxek0lUBcSigsw8FWlpZUl
lEyNmjaY1WHGEtxc/ufFsQLKVRx9hdqQBiBU6ppVSLSYFHI3JrP1tyz3lWOd2pQL
7fKGqQxKxkTeniltiGfXzua30Qea/qNHN8OPA6MI7BESYrmzRvaX39ubb292NDvG
sY2riya0yZkJKZVPGTEU8E2yhJio7v0SdK+AT0UrQ6If3s+VD9HNKogqeshk6QPc
+ukerIHGlZHgohDg8Cn9/mk4rPASfgwf0x7MYBR/4FgcETusEOD5evAQjWydpWeY
TJ9YgW7bDjZf5SqgcZKzA1UkRZD+g1SY6rvoVMwdLiHaXF89NJn9o/zYSTZF9McS
p3EDSPpH159AyobnkQF2OSKKbqbrlf3wsGSKcQn3SDgjVt82owJ2Ch1a38GwI1Ki
0tuJigtq8gGexw6EbAj/U4iydtjYNG4tg+/g7oCmURXWTRGyxjg=
=Wqee
-----END PGP SIGNATURE-----
--=-=-=--
