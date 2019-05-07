Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9565C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B467206BF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 12:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="imun+0WI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfEGMDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 08:03:16 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:56475 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfEGMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 08:03:15 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190507120312euoutp021ba9c5f72f707bc9830e555cf27c2e08~cZPk2wVqZ2677926779euoutp02f
        for <linux-kernel@vger.kernel.org>; Tue,  7 May 2019 12:03:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190507120312euoutp021ba9c5f72f707bc9830e555cf27c2e08~cZPk2wVqZ2677926779euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557230592;
        bh=8kLcfKH+niwO7hkNiGOlUKSyk1Qr4YP/GhaG3mTBKx4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=imun+0WIINAS9cxa+RE214IvCjIARZHkJU52rF4QBWV7YrOQNkDDE62pAjM/wAPXe
         ZVoiXj+uNOM6u0UvsJFXAuLo0o23T73YfEykuDC0qm8V95FZu6gs4tEeOgXQf1cadT
         r72wdBNVYnGEWFj3wMEAerogoal4jvnv+3LugeAo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190507120311eucas1p188f1f596262e009f5baca2227d617ccd~cZPkALRsY3002830028eucas1p1D;
        Tue,  7 May 2019 12:03:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E5.9B.04298.FF371DC5; Tue,  7
        May 2019 13:03:11 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190507120311eucas1p254f1eada26d02e226cad8991686a44ef~cZPjSCWxe2573225732eucas1p2p;
        Tue,  7 May 2019 12:03:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190507120310eusmtrp2851c924ebe86c140ed7a461eebb97dc1~cZPjEAUzu1448114481eusmtrp2C;
        Tue,  7 May 2019 12:03:10 +0000 (GMT)
X-AuditID: cbfec7f2-f2dff700000010ca-c3-5cd173ffd4e8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E7.91.04146.EF371DC5; Tue,  7
        May 2019 13:03:10 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190507120310eusmtip10cf57de3d79bf3f1cf919b884a95ae45~cZPief9Yi2992129921eusmtip1z;
        Tue,  7 May 2019 12:03:10 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc2: Force 8bit UTMI width for Samsung Exynos
 SoCs
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Markus Reichl <m.reichl@fivetechno.de>, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <26ff3deb-4b8d-7dd2-2418-d56f6dcea313@samsung.com>
Date:   Tue, 7 May 2019 14:03:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <eefff244-f311-e59e-d914-9a18b5a21620@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djPc7r/iy/GGLS+krfYOGM9q8X8m0kW
        jb/2slvMmnGa1eL8+Q3sFpd3zWGzmHF+H5PFomWtzBYvj/xgdOD0uHWn3uP0+puMHptWdbJ5
        zDsZ6NG3ZRWjx5b9nxk9Pm+SC2CP4rJJSc3JLEst0rdL4MpY0neCteCARMWtqbeZGhgPinQx
        cnJICJhINDRuYu5i5OIQEljBKLF04wYWCOcLo8S8y0+hMp8ZJTbuOssK03LpZzs7RGI5o8SG
        vvNQVW8ZJXZe/8cEUiUs4C9xbMcOZhCbTcBQouttFxtIkYhAB9Co9zvAljALPGSU+NrXxAJS
        xStgJzHj/lVGEJtFQEXiVO95oEkcHKICMRKLPrNBlAhKnJz5BKycU8BeovX/H7ByZgF5ieat
        s5khbHGJW0/mM4HMlxA4xS5x8vgFRoi7XSR+X/rLDmELS7w6vgXKlpH4vxOmoZlR4uG5tewQ
        Tg+jxOWmGVDd1hKHj19kBbmIWUBTYv0ufYiwo8Syhb2MIGEJAT6JG28FIY7gk5i0bTozRJhX
        oqNNCKJaTWLW8XVwaw9euMQ8gVFpFpLXZiF5ZxaSd2Yh7F3AyLKKUTy1tDg3PbXYMC+1XK84
        Mbe4NC9dLzk/dxMjMFWd/nf80w7Gr5eSDjEKcDAq8fC+KLgYI8SaWFZcmXuIUYKDWUmEN/HZ
        uRgh3pTEyqrUovz4otKc1OJDjNIcLErivNUMD6KFBNITS1KzU1MLUotgskwcnFINjN0TavWX
        LolV4mw9/cRMN2GpBjvrlNL2ia9fnmnPdMrXbZo+a39akmzBZKNLzJ5N0U0T9trMyzS/u69F
        5aOVi/CtN6rvv3G/zt13z++L48f+yOTQM1rVq7i31rNnrAvauswwX/yhlI2BW0Lby1dea+Wu
        vp+iHMl49kzaU0atv1tsJTsWC1VdUGIpzkg01GIuKk4EABhX+edRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7r/ii/GGCzcpmOxccZ6Vov5N5Ms
        Gn/tZbeYNeM0q8X58xvYLS7vmsNmMeP8PiaLRctamS1eHvnB6MDpcetOvcfp9TcZPTat6mTz
        mHcy0KNvyypGjy37PzN6fN4kF8AepWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtl
        ZKqkb2eTkpqTWZZapG+XoJexpO8Ea8EBiYpbU28zNTAeFOli5OSQEDCRuPSznb2LkYtDSGAp
        o8Tsu+uYIBIyEienNbBC2MISf651sUEUvWaUOD/7FFhCWMBXYnnPexYQm03AUKLrLUSRiEAH
        o8SZNUeZQRxmgYeMEheafkDtWMQk8fbHUUaQFl4BO4kZ96+C2SwCKhKnes+D7RYViJE4MXUL
        O0SNoMTJmU/AVnAK2Eu0/v8DVs8sYCYxb/NDZghbXqJ562woW1zi1pP5TBMYhWYhaZ+FpGUW
        kpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93ECIzObcd+bt7BeGlj8CFGAQ5GJR7e
        CXkXY4RYE8uKK3MPMUpwMCuJ8CY+OxcjxJuSWFmVWpQfX1Sak1p8iNEU6LmJzFKiyfnAxJFX
        Em9oamhuYWlobmxubGahJM7bIXAwRkggPbEkNTs1tSC1CKaPiYNTqoFRpLGcf8Evhm1O0rOa
        RH7+mRZWnP2+OmCb9o8jfyP3RtcK/pocwPfG91yajrDYkftSr+ImP1g0T1lzwpUruV2s9zqW
        PUs25pVpfLP0oyKz6At5jlO+fl//HvHjSD9bebxTr5D3+bS+d3/u7D9tt/3cSoPOAIfL3ulG
        7seTDhfIWGw+l6Z9ztVHiaU4I9FQi7moOBEAgdYl0OQCAAA=
X-CMS-MailID: 20190507120311eucas1p254f1eada26d02e226cad8991686a44ef
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea
References: <20190503204958.GA12532@kozik-lap>
        <CGME20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea@eucas1p2.samsung.com>
        <20190506130046.20898-1-m.szyprowski@samsung.com>
        <39c7b687-449e-5e89-4c70-527d4e779fd9@fivetechno.de>
        <eefff244-f311-e59e-d914-9a18b5a21620@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2019-05-07 11:17, Marek Szyprowski wrote:
> Hi Markus,
>
> On 2019-05-07 10:12, Markus Reichl wrote:
>> Hi Marek,
>>
>> your patch did not help on stable v5.1
>>
>> [    3.255963] samsung-usb2-phy 125b0000.exynos-usbphy: 
>> 125b0000.exynos-usbphy supply vbus not found, using dummy regulator
>> [    4.044547] usbcore: registered new interface driver smsc95xx
>> [    4.112261] usb usb1: New USB device found, idVendor=1d6b, 
>> idProduct=0002, bcdDevice= 5.01
>> [    4.120363] usb usb1: New USB device strings: Mfr=3, Product=2, 
>> SerialNumber=1
>> [    4.127560] usb usb1: Product: EHCI Host Controller
>> [    4.132415] usb usb1: Manufacturer: Linux 
>> 5.1.0-00005-geb4efae48eb5 ehci_hcd
>> [    4.139446] usb usb1: SerialNumber: 12580000.ehci
>> [    4.183056] usb3503 0-0008: switched to HUB mode
>> [    4.183121] usb3503 0-0008: usb3503_probe: probed in hub mode
>> [    4.488344] usb 1-2: new high-speed USB device number 2 using 
>> exynos-ehci
>> [    4.675605] usb 1-2: New USB device found, idVendor=0424, 
>> idProduct=3503, bcdDevice=a1.a0
>> [    4.678166] usb 1-2: New USB device strings: Mfr=0, Product=0, 
>> SerialNumber=0
>> [    4.686140] usb 1-2: skipping disabled interface 0
>>
>> root@odroid-x2:~# lsusb
>> Bus 001 Device 002: ID 0424:3503 Standard Microsystems Corp.
>> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>
> This patch fixes the issue introduced by "usb: dwc2: gadget: Replace 
> phyif with phy_utmi_width" commit, which is queued only to linux-next 
> so far. Stable v5.1 doesn't include it, so the fix doesn't change 
> anything on v5.1.
>
> I've checked and OdroidU3 works fine with v5.1 release, but X2 fails 
> to detect USB devices. I will investigate this in a few minutes...


Broken USB on X2 is caused by commit 
01fdf179f4b064d4c9d30b39aba178caf32649f4 ("usb: core: skip interfaces 
disabled in devicetree").

I looks that the mentioned commit conflicts with the Exynos EHCI and 
OHCI bindings and the way the PHY ports are defined for those drivers. 
It worked on U3 only by the pure coincidence. This is probably a 
"minimal" fix for this issue:

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 82239f27c4cc..cd455c4add25 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2007,6 +2007,7 @@ int usb_set_configuration(struct usb_device *dev, 
int configuration)
                 struct usb_interface *intf = cp->interface[i];

                 if (intf->dev.of_node &&
+                   of_device_is_compatible(intf->dev.of_node, NULL) &&
                     !of_device_is_available(intf->dev.of_node)) {
                         dev_info(&dev->dev, "skipping disabled 
interface %d\n",
intf->cur_altsetting->desc.bInterfaceNumber);

I will try to describe the problem in details and discuss it on the usb 
mailing list.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

