Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDDAC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C7821874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565267841;
	bh=RlvW9Wv+MIlOASbRjtR5LL6dLXw82RjwJEpDYsnv2gM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=ywoFNlb88VvCy0epVESUKPWiDO4GMGzdFckLgr9qAfjbIkfYNDtijwMwfLVfLQNZ+
	 L/8USfKdm2ZVEm88x5OLTHhbFCMcSEL7AEESYanlQcVzZ2SIawppvSEZMzXouCMQKQ
	 UpPv+nsQ7HkN+yNkSvuZ2csJNTF08fIhR4zkPzOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfHHMhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:37:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:63147 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfHHMhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:37:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 05:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="asc'?scan'208";a="374131273"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2019 05:37:14 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jochen Sprickerhof <jochen@sprickerhof.de>,
        Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v2 2/2 RESEND] usb: dwc3: remove generic PHY calibrate() calls
In-Reply-To: <e489412b-ce5d-7625-34e6-1af06b834620@samsung.com>
References: <20190808094128.27213-1-m.szyprowski@samsung.com> <CGME20190808094146eucas1p27c673846a5a9be0c55f1f87c89af4adf@eucas1p2.samsung.com> <20190808094128.27213-3-m.szyprowski@samsung.com> <875zn8t27b.fsf@gmail.com> <e489412b-ce5d-7625-34e6-1af06b834620@samsung.com>
Date:   Thu, 08 Aug 2019 15:37:10 +0300
Message-ID: <87pnlfn895.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi,

Marek Szyprowski <m.szyprowski@samsung.com> writes:
> On 2019-08-08 11:51, Felipe Balbi wrote:
>> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>>> Calls to USB2 generic PHY calibrate() method has been moved to HCD core,
>>> which now successfully handles generic PHYs and their calibration after
>>> every HCD reset. This fixes all the timing issues related to PHY
>>> calibration done directly from DWC3 driver: incorrect operation after
>>> system suspend/resume or USB3.0 detection failure when XHCI-plat driver
>>> compiled as separate module.
>>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>>> Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>
>>> ---
>>>   drivers/usb/dwc3/core.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>>> index c9bb93a2c81e..7dd6d419254d 100644
>>> --- a/drivers/usb/dwc3/core.c
>>> +++ b/drivers/usb/dwc3/core.c
>>> @@ -168,7 +168,6 @@ static void __dwc3_set_mode(struct work_struct *wor=
k)
>>>   				otg_set_vbus(dwc->usb2_phy->otg, true);
>>>   			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>>   			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>>> -			phy_calibrate(dwc->usb2_generic_phy);
>> are you sure you're the only one using phy_calibrate()? I don't want any
>> regressions because of this :-p
>
> Yes I've checked. In case of USB PHYs, the .calibrate method is only=20
> implemented by Exynos DRDUSB3 PHY driver:
>
> # git grep \\\.calibrate drivers/phy
> drivers/phy/broadcom/phy-brcm-sata.c:=C2=A0=C2=A0 .calibrate=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D=20
> brcm_sata_phy_calibrate,
> drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c: .calibrate=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=20
> ufs_qcom_phy_qmp_14nm_phy_calibrate,
> drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c: .calibrate=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=20
> ufs_qcom_phy_qmp_20nm_phy_calibrate,
> drivers/phy/samsung/phy-exynos5-usbdrd.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 .calibrate=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=20
> exynos5_usbdrd_phy_calibrate,
>
> (the other PHY drivers are for SATA or UFS).
>
> To avoid the regression on Exynos it is enough to apply the 2 patches=20
> from this patchset together.

We should, certainly, apply them together. But my concern is that
someone has been depending on this. If you've checked all other PHY
drivers, then I'm okay with removing the call.

As $subject should be applied together with the previous patch, here's
my Ack:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

@Greg, if you prefer that I queue both patches and send you in a pull
request, let me know. Works either way for me. I can just rebase my
testing/next on top of your tree once you apply these patches.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1MF3YACgkQzL64meEa
mQaGUw//YxVpprTED/ZEuIgfjI5GhNRrA08wBUj0As7UXSPoNyMp1wt+qGPMYxZb
F595WdmW5+zKplVxOYy/IkRTDAGXAiAcMBvq3xYl8/RzaUbGk+ORUQyh22HZ0E5/
ESS+FG8Gl1x6KBhDsyYNwKUDOjQRbnfypP01xEK4Paknz5DVvjxZHRWCRBWLfpa9
eR1WTJylWgj1G0ULmAlBALHRr4m50V4ny1Vii3OYCZZSf/Bzo6wGdxRk42MYN1kV
SUSeKK7BddWhIpsldvTc4u0Q5eL3s4pilykW4sap9UyuIKgRZVZBV2G4cMXhTpX8
YK5SLTy8NkL+SbjrLaMzWrYyC3xaTa07x73bhtz6Iliv7sl70inEKdNS4nkzTR3z
t6p/T4aNlSJeR5UmoLG9UJcHFSK3lnDSrn7NkTXtiedVt0qhCESMpEqX45TLEPie
Lg4rf3Xx8XzL/8nAMy/kdHRVjb8m6xn5RWjY7tc1IGeW++xXKDNJZbCX7RRkX5Sm
29VK6USNOe3Qfhckrb8SBWLAS2RZ2kswp4vz/lpXDLyR0GYy17PprU+1JrJ69L9U
abaXLBNs64+tAl9KDegZqBe7sFKFRwwuaGm0r78li7GCtdO5WKHlwejbIjYEDix8
V/gBPmPtgk4dQk43p5hrvIt8ADSoH0q+7CcLiKmXf/tZ09ZJXFQ=
=BpTg
-----END PGP SIGNATURE-----
--=-=-=--
