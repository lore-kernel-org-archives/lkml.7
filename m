Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B05C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A678218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 20:49:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfCVUtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 16:49:22 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.97]:5806 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbfCVUtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 16:49:22 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Mar 2019 16:49:21 EDT
Received: from [85.16.173.3] (helo=localhost)
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jochen@sprickerhof.de>)
        id 1h7QzF-0004II-TN; Fri, 22 Mar 2019 21:41:57 +0100
Date:   Fri, 22 Mar 2019 21:41:57 +0100
From:   Jochen Sprickerhof <jochen@sprickerhof.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] usb: dwc3: Softdep for GBit Ethernet on Odroid XU4
Message-ID: <20190322204157.GB474@vis>
References: <20190321202303.GA1399@vis>
 <20190322053742.GB31708@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <20190322053742.GB31708@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Df-Sender: NTc3MDAz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> [2019-03-22 06:37]:
>On Thu, Mar 21, 2019 at 09:23:03PM +0100, Jochen Sprickerhof wrote:
>> This adds a soft dependency to the dwc3 module to load it after
>> xhci-plat as proposed in:
>>
>> https://marc.info/?l=3Dlinux-usb&m=3D155230272022603&w=3D2
>>
>> Old behaviour:
>>
>> $ lsusb -t
>> /:  Bus 06.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
>> /:  Bus 05.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 480M
>>   |__ Port 1: Dev 2, If 0, Class=3DVendor Specific Class, Driver=3Dr8152=
, 480M
>>
>> New behaviour:
>>
>> $ lsusb -t
>> /:  Bus 06.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
>>   |__ Port 1: Dev 2, If 0, Class=3DVendor Specific Class, Driver=3Dr8152=
, 5000M
>>
>> Tested on Debian unstable using Linux 4.19.29.
>>
>> Note, this needs a hard reset when coming from an unpatched kernel.
>>
>> Signed-off-by: Jochen Sprickerhof <git@jochen.sprickerhof.de>
>> ---
>> drivers/usb/dwc3/core.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 103807587dc6..9017e4ed9d99 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
>> @@ -1746,3 +1746,4 @@ MODULE_ALIAS("platform:dwc3");
>> MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
>> MODULE_LICENSE("GPL v2");
>> MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
>> +MODULE_SOFTDEP("pre: xhci_plat_hcd");
>
>
>Your patch is corrupted and can not be applied :(


I'm sorry to hear that. For me this works:

git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
cd linux
curl "https://lore.kernel.org/lkml/20190321202303.GA1399@vis/raw" | git am -

But I found some archives that seems to have fiddled with the=20
Content-Type of my signed mail, making it fail. Can you send more=20
information about the corruption?

Thanks

Jochen

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEc7KZy9TurdzAF+h6W//cwljmlDMFAlyVSJEACgkQW//cwljm
lDPhwA/7B4MFc/nKr+bo9k8E183nEgmJY5mDLuuEzSiJstzn839+RMs/Iri4ppPP
G/1r/WGHR6JXVJLWsXcd7CzJDk+jBCK+tUSSIpCwF1XJIX4nIoJQ1pDzh24YpW+3
S5hQLt9WqQtkqpnrX8wHL2KQ31A7YUKfm17Q9Stq8K6lqkHgW/iWixCLm3COWOUX
1Rl9OlUuWs/GIRs8tWEFlbsB40ydB9pr18Hma0/Gs6M14K4PQO2MvAUNdltyhfKs
p/gX1z2l0ecHVK08Vt90uJktbC9JnTvnRE6OoT8MSA2cqhAUZT5MbmtM8f9SxiFs
NLSdlSPfXG0qxskZiYKai/r0cA/zIEEr6upDk++bypzSVs/nGfUOFBi7cwqYAl58
RveQDiVfQYbCHXcRqOeUgA/eDjbej72CuZDi+GNWp5rIXk4vXYxNHcAsX/XU3q/T
weYkXtSpnGLn2GZ5CCjdedBdqthsyOZnMTzqXSw9ZO1x7TFiZnUlZP+wZ3jKVT0H
Wi1U2rX4VbmwsaWCE86kKJ1UhGk59sxthZTUIHyODwpx316LQl2NYFAOnJLEPAPz
UFj0bV+v3fnKmEbyFg/Wras2XZNo0rrtBndENTWsHEOzbu0Uqc2rFSevcCOwnUe/
tmZjavu3A9Bljfe7OHdCgKqUQQTPpg8ysoNCMXKleqnxqfZNICA=
=r7gU
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
