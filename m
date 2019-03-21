Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9DCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B5A21902
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 00:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCVAFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 20:05:49 -0400
Received: from smtprelay04.ispgateway.de ([80.67.29.8]:35908 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfCVAFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 20:05:48 -0400
X-Greylist: delayed 4865 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 20:05:47 EDT
Received: from [95.33.77.149] (helo=localhost)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <git@jochen.sprickerhof.de>)
        id 1h74DR-0006Sy-Ua; Thu, 21 Mar 2019 21:23:06 +0100
Date:   Thu, 21 Mar 2019 21:23:03 +0100
From:   Jochen Sprickerhof <git@jochen.sprickerhof.de>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] usb: dwc3: Softdep for GBit Ethernet on Odroid XU4
Message-ID: <20190321202303.GA1399@vis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Df-Sender: NTc3MDAz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This adds a soft dependency to the dwc3 module to load it after
xhci-plat as proposed in:

https://marc.info/?l=3Dlinux-usb&m=3D155230272022603&w=3D2

Old behaviour:

$ lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
/:  Bus 05.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 480M
   |__ Port 1: Dev 2, If 0, Class=3DVendor Specific Class, Driver=3Dr8152, =
480M

New behaviour:

$ lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
   |__ Port 1: Dev 2, If 0, Class=3DVendor Specific Class, Driver=3Dr8152, =
5000M

Tested on Debian unstable using Linux 4.19.29.

Note, this needs a hard reset when coming from an unpatched kernel.

Signed-off-by: Jochen Sprickerhof <git@jochen.sprickerhof.de>
---
 drivers/usb/dwc3/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 103807587dc6..9017e4ed9d99 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1746,3 +1746,4 @@ MODULE_ALIAS("platform:dwc3");
 MODULE_AUTHOR("Felipe Balbi <balbi@ti.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("DesignWare USB3 DRD Controller Driver");
+MODULE_SOFTDEP("pre: xhci_plat_hcd");
--=20
2.11.0


--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEc7KZy9TurdzAF+h6W//cwljmlDMFAlyT8qQACgkQW//cwljm
lDM4sw/+PEfruRK0G/l82TiAYEWuL/Cq9U6r99sWkfvz9eSVZXFsK72/DvgvwoID
7WbSDRVMSq6pNe8yWW62T28DTPiNMFjU6rBMsiTWUI1LDMArdc0cadY5EgufTE4K
08eEGrHqxLo8uWhD+qrD847354flPE8f1DsuyB2Un6jODYiu9uQPISfwqekxq5Qm
s9rVnzjWZyYEH28vWNf5ycHav5fopfeeQwpsysjfv00ZGh6912PuE0R9HKuLz3n4
wmBO88X8soLVoC+wlGorCLzFS1HkrXHuvqvuLA2DD9F36PnMugmckp8K9hEd6oD+
aq/4dj9o8nBnmWVvD8sYCN8oiLcLkHqybWZ9NPcRelPTHItIg2vW3jACzCFbQbf3
3Hn1oqCSvSWLwFj19NJvJbXH6GN9CW320LIqb2OUgFQmN767vmB5Gblb8rYIcDze
PNxn1cqcT1UYtjukb+fCE3BsrLpjND3nvOYF1TmiPk0XspN/H5BwIElbKSrX6sXq
cJ8mEZkU0FCYFxC3Q5lDFcL1xGE39sEq6ZBXrpk2XVplRl3E7o3NOSCdG0T5JVc1
3aKLX5BWRzPps9hMBPtmjot7v68TB3xaMIEiuAE+GL3mKAiCKgJwmEFLGZ+ciTZt
84JoLiR1jpIOfTX80NdliYLMthAmuuT3xJgr7dG3Tjl/xUJFNCw=
=wug8
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
