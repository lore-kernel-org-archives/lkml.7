Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C061EC433FF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 16:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB42206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 16:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbfG1QDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 12:03:32 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:48332 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1QDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 12:03:31 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jul 2019 12:03:30 EDT
Received: from [91.248.2.20] (helo=localhost)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <jochen@sprickerhof.de>)
        id 1hrlYc-00070U-4O; Sun, 28 Jul 2019 17:57:58 +0200
Date:   Sun, 28 Jul 2019 17:57:57 +0200
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
Subject: Re: [PATCH v2 1/2] usb: core: phy: add support for PHY calibration
Message-ID: <20190728155757.GE10770@vis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dVWk8uzOCD9exnpL"
Content-Disposition: inline
In-Reply-To: <CANAwSgR3kdZsDn-x9FwynAPtVEf4ci0BfiGPr1NzJ-a1n5B_Ng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Df-Sender: NTc3MDAz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dVWk8uzOCD9exnpL
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hi Marek,

thanks for working on this!

Tested on my XU4
Tested-by: Jochen Sprickerhof <jochen@sprickerhof.de>

* Anand Moon <linux.amoon@gmail.com> [2019-07-23 00:30]:
>Hi Marek,
>
>On Fri, 19 Jul 2019 at 13:43, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>
>> Some PHYs (for example Exynos5 USB3.0 DRD PHY) require calibration to be
>> done after every USB HCD reset. Generic PHY framework has been already
>> extended with phy_calibrate() function in commit 36914111e682 ("drivers:
>> phy: add calibrate method"). This patch adds support for it to generic
>> PHY handling code in USB HCD core.
>>
>
>Tested on my XU3 / XU4 / HC1
>Tested-by: Anand Moon <linux.amoon@gmail.com>
>
>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>  drivers/usb/core/hcd.c |  7 +++++++
>>  drivers/usb/core/phy.c | 21 +++++++++++++++++++++
>>  drivers/usb/core/phy.h |  1 +
>>  3 files changed, 29 insertions(+)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index 88533938ce19..b89936c1df23 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -2291,6 +2291,9 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
>>         hcd->state = HC_STATE_RESUMING;
>>         status = hcd->driver->bus_resume(hcd);
>>         clear_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);
>> +       if (status == 0)
>> +               status = usb_phy_roothub_calibrate(hcd->phy_roothub);
>> +
>>         if (status == 0) {
>>                 struct usb_device *udev;
>>                 int port1;
>> @@ -2864,6 +2867,10 @@ int usb_add_hcd(struct usb_hcd *hcd,
>>         }
>>         hcd->rh_pollable = 1;
>>
>> +       retval = usb_phy_roothub_calibrate(hcd->phy_roothub);
>> +       if (retval)
>> +               goto err_hcd_driver_setup;
>> +
>>         /* NOTE: root hub and controller capabilities may not be the same */
>>         if (device_can_wakeup(hcd->self.controller)
>>                         && device_can_wakeup(&hcd->self.root_hub->dev))
>> diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
>> index 7580493b867a..fb1588e7c282 100644
>> --- a/drivers/usb/core/phy.c
>> +++ b/drivers/usb/core/phy.c
>> @@ -151,6 +151,27 @@ int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
>>  }
>>  EXPORT_SYMBOL_GPL(usb_phy_roothub_set_mode);
>>
>> +int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub)
>> +{
>> +       struct usb_phy_roothub *roothub_entry;
>> +       struct list_head *head;
>> +       int err;
>> +
>> +       if (!phy_roothub)
>> +               return 0;
>> +
>> +       head = &phy_roothub->list;
>> +
>> +       list_for_each_entry(roothub_entry, head, list) {
>> +               err = phy_calibrate(roothub_entry->phy);
>> +               if (err)
>> +                       return err;
>> +       }
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(usb_phy_roothub_calibrate);
>> +
>>  int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub)
>>  {
>>         struct usb_phy_roothub *roothub_entry;
>> diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
>> index dad564e2d2d4..20a267cd986b 100644
>> --- a/drivers/usb/core/phy.h
>> +++ b/drivers/usb/core/phy.h
>> @@ -18,6 +18,7 @@ int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
>>
>>  int usb_phy_roothub_set_mode(struct usb_phy_roothub *phy_roothub,
>>                              enum phy_mode mode);
>> +int usb_phy_roothub_calibrate(struct usb_phy_roothub *phy_roothub);
>>  int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
>>  void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
>>
>> --
>> 2.17.1
>>
>

--dVWk8uzOCD9exnpL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEc7KZy9TurdzAF+h6W//cwljmlDMFAl09xgEACgkQW//cwljm
lDPASA//a0c4bN2fqhttPuRzcuHRM5hwLmqcyyGi8X3juGKvrV9/AqocZI5dV4/q
yBORuACD84j2cqCkHjZ3Oy8FYPg0c64I6qcb973EEM9xfpCwL1xWNDnXeFu8+L7A
ig2yq4qKk4krmKAhFFd8x+O/Caqm16hiRQQqibGa5mW8jhfMyglOWA5WxPDpNt/x
HpeBsv7UXoBJrhZoMOAL+ycs+MDFXmybP7xGCMrN5cJqTTCHV+f184HMnGCnVXld
+r7E5SF0k4QsbV4jrfdH8cmiaVGPZhEHLrhbHlk5LAuJeTjquYxEeJTag9ZMV5/B
geDZF1RlDdIJppwWv2ChyskMmfzDHC8z7XeA5xRjKFspnJhba7iuZir3G3MO4c+G
Eehn/QLniT+kETjIvEDiUh0UOVm2ph//v3o3CVNs/ILWbEFQtVdfjgMBcoazeQXR
GfNi5z0+5s/q/d/sDZq6BQ0hGSOpxHd/54cdwbOUWoFd1H+sPC+MT2ubFHhnCKUC
Xm7p3GAND0bEqwbpaPr8zSvDQWySh5/XS7QF3+Rvutvn6MVq5jT8Dtn5OjfBCG+b
KOZ+ibf2JTPZ1EDKabfvWRzy9EmVVQ7Ep1iAz2esWmiYglCj/f18+4KRL7u9VSVa
CxoN1+3BT8wC+kRv2eCaRi73Yke5bZ0itcOoY5zkHZKj2PuUTN8=
=Hue+
-----END PGP SIGNATURE-----

--dVWk8uzOCD9exnpL--
