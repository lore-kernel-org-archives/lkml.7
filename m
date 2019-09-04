Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD801C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868FD206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567583677;
	bh=rhMUEjPXy+iiT52ohIfHS1rvBJVyxfMA+dv9BFyZ0IE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=RXyjjhHfQS9wXhU6AtLE551PI8aiTU4RqfdUCuRuS1eXBfxBaeGa0CNQQKyRiCeta
	 PTjbIP2nriyHlB4685kwOAYzwlUotcAtiayWHIgT/ExjjqdGFgU0L+ifHjkT8k0J6r
	 LVrHRm50/yWvaXsBzPssw0bMzQa/RmSnr7EPGvOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfIDHyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:54:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:20282 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728526AbfIDHyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:54:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 00:54:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="asc'?scan'208";a="185033564"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by orsmga003.jf.intel.com with ESMTP; 04 Sep 2019 00:54:32 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Jacky.Cao@sony.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Kento.A.Kobayashi@sony.com, Jacky.Cao@sony.com
Subject: Re: [PATCH] USB: dummy-hcd: fix power budget for SuperSpeed mode
In-Reply-To: <16EA1F625E922C43B00B9D82250220500871C862@APYOKXMS108.ap.sony.com>
References: <16EA1F625E922C43B00B9D82250220500871C862@APYOKXMS108.ap.sony.com>
Date:   Wed, 04 Sep 2019 10:54:28 +0300
Message-ID: <87sgpcmr7v.fsf@gmail.com>
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

<Jacky.Cao@sony.com> writes:

> The power budget for SuperSpeed mode should be 900 mA
> according to USB3.0 specification, so set the power
> budget to 900 mA for dummy_start_ss which is only used
> for SuperSpeed mode.
>
> If the max power consumption of SuperSpeed device is
> larger than 500 mA, insufficient available bus power
> error happens in usb_choose_configuration function
> when the device connects to dummy hcd.
>
> Signed-off-by: Jacky Cao <Jacky.Cao@sony.com>
> ---
> drivers/usb/gadget/udc/dummy_hcd.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/=
dummy_hcd.c
> index 8414fac..52f2cf5 100644
> --- a/drivers/usb/gadget/udc/dummy_hcd.c
> +++ b/drivers/usb/gadget/udc/dummy_hcd.c
> @@ -48,6 +48,7 @@
> #define DRIVER_VERSION "02 May 2005"
>
>  #define POWER_BUDGET  500  /* in mA; use 8 for low-power port testing */
> +#define POWER_BUDGET_3_0  900  /* in mA */
>
>  static const char  driver_name[] =3D "dummy_hcd";
> static const char  driver_desc[] =3D "USB Host+Gadget Emulator";
> @@ -2432,7 +2433,7 @@ static int dummy_start_ss(struct dummy_hcd *dum_hcd)
>      dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
>      dum_hcd->stream_en_ep =3D 0;
>      INIT_LIST_HEAD(&dum_hcd->urbp_list);
> -     dummy_hcd_to_hcd(dum_hcd)->power_budget =3D POWER_BUDGET;
> +     dummy_hcd_to_hcd(dum_hcd)->power_budget =3D POWER_BUDGET_3_0;
>      dummy_hcd_to_hcd(dum_hcd)->state =3D HC_STATE_RUNNING;
>      dummy_hcd_to_hcd(dum_hcd)->uses_new_polling =3D 1;
> #ifdef CONFIG_USB_OTG

Alan, I suppose you're okay with this change?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1vbbQACgkQzL64meEa
mQYEag/8CNh1XxPX+xromrb3wEL2ptcSNpiSoaTbtGEGO0NrebNOWnfyQIJGP9OR
p9eEMlQuTSulxCi+bsDORBhxZ+f/hlEK/ix/7U6g+BzeW0ex8U0DIpOFXa3Q0riS
f7h5vPDYGy+HZMBiGZQc4J4A8ejh5XCRLo7fOf9RgL7tUOoT1ud9vi0J/unIsFmc
zoz3Bt3SVMtKJf86L1x5/EP7U5V2QM/dZhYzW6Ux+++zqYlYm3IEocHYLeZ2OmYc
b81z9yePo1xjavtZ1wX39xhdJpV4GqDVnJkqjPeut9sJQSntsSQcVsXh49Vk9s5l
lTalG0+BwIAqvHKkQAoT8kXnSYQbShGF7qIlGoO7sHDs0btvcBQAE+PKPcm1M5W4
iryECIsp2T5DowXbw3eukXS3EoMT+fIbVuNn41I4owwRDlgeP7FFUnDdqwINjHBu
I0Fg37W9x2FLqJx+5cETMlUo11BgDkd0wo/QOG0t5kqL/c4zyKpyJxtAjLM2jxkU
/al2yuL0okMNS23cZxNdjGIeVA5wsAsjzWbYHIGa9ZAfUCyQpdtkoIL0NSDDeOXm
PRc3LYXNRshYawW1pTx917u2iFz/gKl8VrECgXiOd1tuzd+uIU6wCiZRGnVyEPe1
HGBvfsMl9E76IbGkNCYd+W+uBsG0Diq7NQ9uMGnEgiI+eZVn/gw=
=NvCb
-----END PGP SIGNATURE-----
--=-=-=--
