Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C05C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E38A20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vd+mQzVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbfEGJRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:17:38 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:33784 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbfEGJRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:17:37 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190507091735euoutp01e884c1096c8e1f525cbc4a2463211935~cW__Kr4Nu1941919419euoutp01j
        for <linux-kernel@vger.kernel.org>; Tue,  7 May 2019 09:17:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190507091735euoutp01e884c1096c8e1f525cbc4a2463211935~cW__Kr4Nu1941919419euoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557220655;
        bh=eC9RKKUhFBEdPO3sH6QeAj7KbWtJ/CGboccWZibZgX8=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=vd+mQzVNEUXzScrjvvZm4pnl6yphua3RRpQ0rNUFT5DZQhQSVmjA/ma6U1JG1TBHV
         94BM9r+ojyoIPuKNYgFI78X8Nxyf6eSj7h7nc2N1GbyLck4DcHaxNp1q34t8OMpemg
         c3rW9PM94c9oe75axl6/lmmoEu8JLFH2gxA86LXA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190507091734eucas1p22e5ac264e405a085172e7e99cf7e69e3~cW_9YScXm1524515245eucas1p2S;
        Tue,  7 May 2019 09:17:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 0D.82.04325.E2D41DC5; Tue,  7
        May 2019 10:17:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190507091733eucas1p22eb2b950569e82bc947d628292c2e0e4~cW_8ZVmns1522515225eucas1p2P;
        Tue,  7 May 2019 09:17:33 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190507091733eusmtrp274614b2df408d26303169fd1a9db22a3~cW_8LTpdq1581815818eusmtrp2d;
        Tue,  7 May 2019 09:17:33 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-c2-5cd14d2e2169
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E0.39.04146.D2D41DC5; Tue,  7
        May 2019 10:17:33 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190507091732eusmtip177e46be4523d9745c5be7c7caeb63838~cW_7wRE993014030140eusmtip1j;
        Tue,  7 May 2019 09:17:32 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc2: Force 8bit UTMI width for Samsung Exynos
 SoCs
To:     Markus Reichl <m.reichl@fivetechno.de>, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <eefff244-f311-e59e-d914-9a18b5a21620@samsung.com>
Date:   Tue, 7 May 2019 11:17:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <39c7b687-449e-5e89-4c70-527d4e779fd9@fivetechno.de>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDKsWRmVeSWpSXmKPExsWy7djP87p6vhdjDKa8ErfYOGM9q8X8m0kW
        jb/2slvMmnGa1eL8+Q3sFpd3zWGzmHF+H5PFomWtzBYvj/xgdOD0uHWn3uP0+puMHptWdbJ5
        zDsZ6NG3ZRWjx5b9nxk9Pm+SC2CP4rJJSc3JLEst0rdL4MroWPOSreAsb8X1w5NZGhi/c3Ux
        cnJICJhIHNqyiaWLkYtDSGAFo8Sn9r3sEM4XRolpi+4yglQJCXxmlNgz3Ram4/apFqii5YwS
        l7v/M0M4bxkl3nx4ywRSJSzgL3Fsxw6whIhAB6PExvc7wJYwCzxklPja18QCUsUmYCjR9baL
        DcTmFbCTWP8RZC4nB4uAisSF6Y+Bujk4RAViJBZ9hioRlDg58wlYK6eAo8Tdp39YQWxmAXmJ
        7W/nMEPY4hK3nsxnAtklIXCJXWLiqSWsIHMkBFwkPn7MgnhBWOLV8S3sELaMxP+dMPXNjBIP
        z61lh3B6gH5rmsEIUWUtcfj4RbBBzAKaEut36UOEHSWWLexlhJjPJ3HjrSDEDXwSk7ZNZ4YI
        80p0tAlBVKtJzDq+Dm7twQuXmCcwKs1C8tksJN/MQvLNLIS9CxhZVjGKp5YW56anFhvnpZbr
        FSfmFpfmpesl5+duYgSmqdP/jn/dwbjvT9IhRgEORiUe3glOF2KEWBPLiitzDzFKcDArifAm
        PjsXI8SbklhZlVqUH19UmpNafIhRmoNFSZy3muFBtJBAemJJanZqakFqEUyWiYNTqoHxXJ2S
        u4ZldcukzvpFp95+vZTVdqnC9tlC8242pQlXGyTFum/2dddzLuvsTN18f5PYHKcr2/dvEvAL
        P69V88hyy9O3j+bU+vRU7fx/SyfkmMqGE686ucuv3LrXp3KjSC9IuCPu3U2R4PeH2l32sK58
        qpjPmJSoo/LOcn6X6fHPQWU3J69M/z5NiaU4I9FQi7moOBEASH/kU08DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7q6vhdjDE6/FrfYOGM9q8X8m0kW
        jb/2slvMmnGa1eL8+Q3sFpd3zWGzmHF+H5PFomWtzBYvj/xgdOD0uHWn3uP0+puMHptWdbJ5
        zDsZ6NG3ZRWjx5b9nxk9Pm+SC2CP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHUMzQ2j7Uy
        MlXSt7NJSc3JLEst0rdL0MvoWPOSreAsb8X1w5NZGhi/c3UxcnJICJhI3D7Vwt7FyMUhJLCU
        UeLlvklsEAkZiZPTGlghbGGJP9e62CCKXjNKnH7/gAUkISzgK7G85z0LSEJEoINR4syao8wg
        DrPAQ0aJC00/oOa+ZZRomryEHaSFTcBQouttF9gOXgE7ifUfW8DiLAIqEhemP2YGsUUFYiRO
        TN3CDlEjKHFy5hOwdZwCjhJ3n/4Bu4lZwExi3uaHzBC2vMT2t3OgbHGJW0/mM01gFJqFpH0W
        kpZZSFpmIWlZwMiyilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzA6tx37uXkH46WNwYcYBTgY
        lXh4H9heiBFiTSwrrsw9xCjBwawkwpv47FyMEG9KYmVValF+fFFpTmrxIUZToOcmMkuJJucD
        E0deSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS1OzU1ILUIpg+Jg5OqQZGledn5KOljm0r
        860S3nvs0ZO1U3nqpRf/iP42dfKRqad4JD7PWW6uPCF7klGzqM3lpy3++rc2775sYPeSt0j+
        4b5VHT3vLhz9fWjaRpHbb1/2M/X8eiq9q4KtW1ClZFbL4/jvDi8clu7v2ia978lSkxm+oitX
        n52qnToz9JfQz0txk1+db3nj/UKJpTgj0VCLuag4EQBk1dOw5AIAAA==
X-CMS-MailID: 20190507091733eucas1p22eb2b950569e82bc947d628292c2e0e4
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

On 2019-05-07 10:12, Markus Reichl wrote:
> Hi Marek,
>
> your patch did not help on stable v5.1
>
> [    3.255963] samsung-usb2-phy 125b0000.exynos-usbphy: 125b0000.exynos-usbphy supply vbus not found, using dummy regulator
> [    4.044547] usbcore: registered new interface driver smsc95xx
> [    4.112261] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.01
> [    4.120363] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    4.127560] usb usb1: Product: EHCI Host Controller
> [    4.132415] usb usb1: Manufacturer: Linux 5.1.0-00005-geb4efae48eb5 ehci_hcd
> [    4.139446] usb usb1: SerialNumber: 12580000.ehci
> [    4.183056] usb3503 0-0008: switched to HUB mode
> [    4.183121] usb3503 0-0008: usb3503_probe: probed in hub mode
> [    4.488344] usb 1-2: new high-speed USB device number 2 using exynos-ehci
> [    4.675605] usb 1-2: New USB device found, idVendor=0424, idProduct=3503, bcdDevice=a1.a0
> [    4.678166] usb 1-2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> [    4.686140] usb 1-2: skipping disabled interface 0
>
> root@odroid-x2:~# lsusb
> Bus 001 Device 002: ID 0424:3503 Standard Microsystems Corp.
> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

This patch fixes the issue introduced by "usb: dwc2: gadget: Replace 
phyif with phy_utmi_width" commit, which is queued only to linux-next so 
far. Stable v5.1 doesn't include it, so the fix doesn't change anything 
on v5.1.

I've checked and OdroidU3 works fine with v5.1 release, but X2 fails to 
detect USB devices. I will investigate this in a few minutes...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

