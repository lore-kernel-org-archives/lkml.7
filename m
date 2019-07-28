Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879F0C433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 576DC2077C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 16:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfG1QID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 12:08:03 -0400
Received: from smtprelay03.ispgateway.de ([80.67.31.37]:15617 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1QID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 12:08:03 -0400
Received: from [91.248.2.20] (helo=localhost)
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <jochen@sprickerhof.de>)
        id 1hrlZZ-0005eA-9G; Sun, 28 Jul 2019 17:58:57 +0200
Date:   Sun, 28 Jul 2019 17:58:56 +0200
From:   Jochen Sprickerhof <jochen@sprickerhof.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 2/2] usb: dwc3: remove generic PHY calibrate() calls
Message-ID: <20190728155856.GF10770@vis>
References: <CGME20190719081334eucas1p1fd614e56c1ec0dfa654d0bb77f17ba5d@eucas1p1.samsung.com>
 <20190719081212.9249-1-m.szyprowski@samsung.com>
 <20190719081326.9347-1-m.szyprowski@samsung.com>
 <CANAwSgQSQLVy=E3uzDq_sdmBR7Rcg=S1Tfr24o3DozHSP2wKiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MJDoj6C08NHMgYyA"
Content-Disposition: inline
In-Reply-To: <CANAwSgQSQLVy=E3uzDq_sdmBR7Rcg=S1Tfr24o3DozHSP2wKiw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Df-Sender: NTc3MDAz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MJDoj6C08NHMgYyA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Marek,

Tested on my XU4
Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>

* Anand Moon <linux.amoon@gmail.com> [2019-07-23 00:30]:
>Hi Marek,
>
>On Fri, 19 Jul 2019 at 13:43, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>
>> Calls to USB2 generic PHY calibrate() method has been moved to HCD core,
>> which now successfully handles generic PHYs and their calibration after
>> every HCD reset. This fixes all the timing issues related to PHY
>> calibration done directly from DWC3 driver: incorrect operation after
>> system suspend/resume or USB3.0 detection failure when XHCI-plat driver
>> compiled as separate module.
>>
>
>Tested on my XU3 / XU4 / HC1
>Tested-by: Anand Moon <linux.amoon@gmail.com>
>
>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/usb/dwc3/core.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index c9bb93a2c81e..7dd6d419254d 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -168,7 +168,6 @@ static void __dwc3_set_mode(struct work_struct *work)
>>                                 otg_set_vbus(dwc->usb2_phy->otg, true);
>>                         phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
>>                         phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
>> -                       phy_calibrate(dwc->usb2_generic_phy);
>>                 }
>>                 break;
>>         case DWC3_GCTL_PRTCAP_DEVICE:
>> @@ -1166,7 +1165,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
>>                                 dev_err(dev, "failed to initialize host\n");
>>                         return ret;
>>                 }
>> -               phy_calibrate(dwc->usb2_generic_phy);
>>                 break;
>>         case USB_DR_MODE_OTG:
>>                 INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
>> --
>> 2.17.1
>>
>

--MJDoj6C08NHMgYyA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEc7KZy9TurdzAF+h6W//cwljmlDMFAl09xkAACgkQW//cwljm
lDMnZRAAnIh4il8D6hiJ8cG398UiqR+S3ylfk69quSj63ZERKAwNPGjDDuDxMSCe
JjEbbs6mTAYzgmt4JvYb6vBusRf1NbHTZbETCjIEu1arEtG/95uQJfZC0fkf1Oq5
28tXboWemV3heNwFEBWcgGNlXx0PWp7SxtGEZ/cMLaO9U0PGo8V1Y6bg/OyapppQ
8Gkd0WqZt3TIV4hhsUgw/uS/TSwHoWjrTUFcmc5aYsE7TgTnB9+hUC66w/Rbh8l1
bfnZ2K5qBEnsaIxaHhD37lWPAysh16Y29HE3bDwKzU1olJFYNSVYJA2fLVHrvcUH
v3RRZkJUKARoU/9Qnx7+qxIHB/nD4ffRG5B3nrQMBbEuSZhWbGyEiJGN/jntPlSh
fWIax1Krsls/UXAY376bQOmoamKMTmpMPrjT7j15KK3IOMCBv2CE14AnJ/9X470k
6GBq5lpog6XmH0V84w9HPnetaJb+CJr7mEZKZSoN4GEeItJEdXjDWb8H7jhOk8cm
AL2cpS7GnEzNpPc9G7boN3sXtW42N3RjXm7F8rOjkM4H5AhL+G6IHTwaCwY47bZB
YaPAKSki1SzDS3frHmiEowfUjtRurLRqMGLPn+JNaPxnrkoqxkX2FcfYNd0U4oqs
r641Xj3C3LkBklceGiSJVLvDWIxQGFEnxgpkQCdMUoYABTGoh2U=
=I49Z
-----END PGP SIGNATURE-----

--MJDoj6C08NHMgYyA--
