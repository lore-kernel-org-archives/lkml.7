Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA96C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F03218A2
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732431AbfHHMki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:40:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:55832 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbfHHMki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:40:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 05:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,361,1559545200"; 
   d="asc'?scan'208";a="374132098"
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2019 05:40:35 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v6 46/57] usb: Remove dev_err() usage after platform_get_irq()
In-Reply-To: <20190730181557.90391-47-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org> <20190730181557.90391-47-swboyd@chromium.org>
Date:   Thu, 08 Aug 2019 15:40:31 +0300
Message-ID: <87mugjn83k.fsf@gmail.com>
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

Stephen Boyd <swboyd@chromium.org> writes:
> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
>
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
>
> ret =3D
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
>
> if ( \( ret < 0 \| ret <=3D 0 \) )
> {
> (
> -if (ret !=3D -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
>
> While we're here, remove braces on if statements that only have one
> statement (manually).
>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Please apply directly to subsystem trees
>
>  drivers/usb/chipidea/core.c               |  1 -
>  drivers/usb/dwc2/platform.c               |  4 +---
>  drivers/usb/dwc3/dwc3-keystone.c          |  1 -
>  drivers/usb/dwc3/dwc3-omap.c              |  4 +---
>  drivers/usb/gadget/udc/aspeed-vhub/core.c |  1 -
>  drivers/usb/gadget/udc/bcm63xx_udc.c      |  8 ++------
>  drivers/usb/gadget/udc/bdc/bdc_core.c     |  4 +---
>  drivers/usb/gadget/udc/gr_udc.c           |  8 ++------
>  drivers/usb/gadget/udc/lpc32xx_udc.c      |  5 +----
>  drivers/usb/gadget/udc/renesas_usb3.c     |  4 +---
>  drivers/usb/gadget/udc/s3c-hsudc.c        |  4 +---
>  drivers/usb/gadget/udc/udc-xilinx.c       |  4 +---

For dwc2, dwc3, gadget and usb/phy:

Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl1MGD8ACgkQzL64meEa
mQbQ8g//RR3don4FjgIJ4062cadK0o06VKQO5F2i6I92KEdhdCs4DPY8x1AxeLWL
zmzIDYZP8Q+9eBcwf2nkO0BGD6TUf2/55K6T3IxX7CxYx8Nb6DtLfLTMrprTYbMr
8SKkNEH+lW/ky51zLLfNUPNY8Wm4d3x8bUh05r9ZyGkA6wv0zFlaaDXceuntF1F0
WBbRHcsyII+y2M6jLPtbopGqkFHYRMj73UAs5gMI9aQYDwVx2OolR2Gr3yavU1pB
ss7Z+0ukYHk1aTr1wosMY6eQLw8THCWcqhSr2TdZZvaPkAleCMWPSvXN3NReSZKD
AHQeBvhqbCypwLeTTPLJmHbRHln7OZ6pxw03GruwcvsOzOwOuW3zlfZEm6lUFCMH
yF5mmGZU/OPrhbKiKakwvucN4GF/ZHhwHWDLKlx4fHNpSMc+rCerStu2gnPrQqoT
FVVxWvX/PcSZcOGlAaLPF3RIl7EqlP8PLb0+SOnwVXo6YIYXXXTFrtAviqzol0DS
3ocPWX55vJEV9nL9F2oKVr8yaRY2fFK8dxmhsmf/PBR4Ue8fmRKDnpE0n8RVdsJD
qjs5KXhU/5KfoiUcVW33wHaLsY4zYDBbbX/BNUTuFUDg2cYtEGzHtqkhhdwn9DX/
CQZGUWLLbHV415dL/6tmzaxHinnIuEU4mnpP9SGc9fxJFhcKma8=
=oNnV
-----END PGP SIGNATURE-----
--=-=-=--
