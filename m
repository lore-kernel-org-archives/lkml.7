Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D46C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C61C218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbfCUAFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:05:07 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:53308 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUAFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:05:07 -0400
X-Greylist: delayed 21154 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 20:05:06 EDT
Received: from [91.97.111.15] (helo=localhost)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <jochen@sprickerhof.de>)
        id 1h6fhP-0001VQ-1C; Wed, 20 Mar 2019 19:12:23 +0100
Date:   Wed, 20 Mar 2019 19:12:25 +0100
From:   Jochen Sprickerhof <jochen@sprickerhof.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] usb: dwc3: Enable GBit Ethernet on Odroid XU4
Message-ID: <20190320181225.GA539@vis>
References: <20190121140204.GA2360@vis>
 <5C5A9DCB.8040507@ti.com>
 <20190206093830.GS26157@vis>
 <CGME20190206101740epcas2p131674b4b9733047711855ffb2e7a99a7@epcas2p1.samsung.com>
 <5C5AB41C.9080402@ti.com>
 <bdbce410-7f48-17a5-b58b-3ebd65ca6913@samsung.com>
 <20190208193505.GA5822@vis>
 <2b8d7801-26a5-201e-71d1-ccef3c99f728@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <2b8d7801-26a5-201e-71d1-ccef3c99f728@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Df-Sender: NTc3MDAz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marek,

* Marek Szyprowski <m.szyprowski@samsung.com> [2019-03-11 12:11]:
>Hi Jochen,
>
>On 2019-02-08 20:35, Jochen Sprickerhof wrote:
>> Hi Marek,
>>
>> * Marek Szyprowski <m.szyprowski@samsung.com> [2019-02-08 13:36]:
>>>>>> On 21/01/19 16:02, Jochen Sprickerhof wrote:
>>>>> [..]
>>>>>>> I'm not sure why this it only works with the driver compiled into
>>>>>>> the
>>>>>>> kernel nor why it needs a hard reset or why it was the line was
>>>>>>> dropped
>>>>>>> when the patch was accepted. Would be great to get some feedback
>>>>>>> of the
>>>>>>> authors.
>>>>>> When XHCI driver is compiled into the kernel are the relevant PHY
>>>>>> drivers
>>>>>> compiled in as well?
>>>>> Only CONFIG_USB_PHY=3Dy (I took the config from the
>>>>> linux-image-4.19.0-1-armmp_4.19.13-1_armhf.deb Debian package as a
>>>>> basis where this is the default).
>>>
>>> I confirm that on Odroid XU4 USB 3.0 works only when all related drivers
>>> (dwc3, xhci and exynos5 drd phy) are compiled into the kernel. If they
>>> are compiled as modules, USB 3.0 calibration doesn't work. The mentioned
>>> patch doesn't fix anything.
>>
>> I've just tried Linux v5.0-rc5 with the Debian config and
>> USB_XHCI_PLATFORM=3Dy and it works, thanks!
>>
>> Is there a way to make it work with xhci compiled as a module, so it
>> would work in Debian out of the box?
>
>One more comment - 5000M mode will also work with everything compiled as
>modules (dwc3, exynos5 drd phy and xhci-plat) too. Just make sure that
>xhci-plat is loaded before dwc3. This would require some manual
>configuration, because autoloading will load xhci-plat after dwc3 probe
>and switch to host mode.

Thanks so much for the hint, this made it working :). I opened a bug=20
with Debian:

https://bugs.debian.org/925167

Cheers Jochen

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEc7KZy9TurdzAF+h6W//cwljmlDMFAlySgoYACgkQW//cwljm
lDPI1A//ebiLYmfLq5FN5O2mFbdNpMa2iloBM2GSNkOqrjznoowJSvrJbJlj5OeB
PgJxANr2M1dMyf05EebUTnq2Nicm0bvvfMjFnHwo4I7TZ3IKukMpIgHNYZDYRuRH
26VJ9pcjPRElFHrIcKlw0HryCMHXCAoXVi4WDbxZf3PrgY1+dtf9k+r80sq3GiGZ
oR3rJbtEH85eZNAb6JIV7hMRBwQcgnog0rchOoZA5BZdj4x7dPfzMP5VYFNwyS7N
uXyMDqk33lscwt4aMLisA1EzBb8jGLvJ9NfXkOeZ/sePgAe4n3Fh5XQ2y8Aw2C0Q
0q6PnCzBSbXviqZngnKaz92gRZfiG/Gc1OSShzfCPODReSO6VfOiAngcHvNvNfLB
Z58qSX+qLhubg/XsB4GePqeoGRRIbXtXlpoVgMbx7rj4XGOTSIpXCYV13HAuCguj
oPyOOkq0iaYc0Vb9P5tnx6DJtNtTfs4y+KveT8oIjS2Vk6RgsW201TBmVm9CyHF8
qpvb5gupeVTQ2hwBAf5m8oWAOzjcA2gQmJDcA2MQsaH4gcqB7ce7UFVoqa9hXCrm
FpEfqu8IYw8+VkTwZI77wbWO8rmHmSnLOmnMXUvsxeRtwqsF8o6/a89ILyLPu1Yr
DMqx/yDP5OoDj+MmDQHd+sf5t5CaXuQEcOjfz474d0e8v2mWcjA=
=QyZs
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
