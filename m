Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5831FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A86E2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 11:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RgPU1d60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCKLL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:11:56 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:53889 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfCKLL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 07:11:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190311111154euoutp011f3ba0fb225dcc86ee450726afef724f~K4xgmLRyz1519015190euoutp01E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 11:11:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190311111154euoutp011f3ba0fb225dcc86ee450726afef724f~K4xgmLRyz1519015190euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552302714;
        bh=mzxYUn0ytxFcevjXFEuBbLes4bQPYcWUj8djM0HpR0Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RgPU1d60yrlppo9bbDFRML5SZKmva5xjzNe6YlYazvAMCCveB4yk+7GLcYt2fFaxB
         o2XJQCKzJaVWWhSkKMhDa7+lAeBldajUyppqCA6Rq+hmhEGvHPJDW3sXsG7JK+7/EH
         3m23o13VZXjAMPU4pl4HnMLyAKwpt/a0PcVC+YUE=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190311111153eucas1p234981ad3a1ce55a3aef38900bcbe1655~K4xf0zH4B1033410334eucas1p2b;
        Mon, 11 Mar 2019 11:11:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E6.BE.04294.972468C5; Mon, 11
        Mar 2019 11:11:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190311111152eucas1p11b309165ccdb9bfdc9c39ada5ae34fd6~K4xe2Wlxz1249712497eucas1p11;
        Mon, 11 Mar 2019 11:11:52 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190311111152eusmtrp2c5fc5658654eeef5730b13214b83dfe1~K4xen__7R1776717767eusmtrp2W;
        Mon, 11 Mar 2019 11:11:52 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-86-5c864279039a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A5.C3.04128.872468C5; Mon, 11
        Mar 2019 11:11:52 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190311111151eusmtip290e834cfdfbbd9f1a61afa3d14aac989~K4xePid9n0954409544eusmtip2S;
        Mon, 11 Mar 2019 11:11:51 +0000 (GMT)
Subject: Re: [PATCH] usb: dwc3: Enable GBit Ethernet on Odroid XU4
To:     Jochen Sprickerhof <jochen@sprickerhof.de>
Cc:     Roger Quadros <rogerq@ti.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <2b8d7801-26a5-201e-71d1-ccef3c99f728@samsung.com>
Date:   Mon, 11 Mar 2019 12:11:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190208193505.GA5822@vis>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djP87qVTm0xBs/bRS2OtT1ht2hevJ7N
        Yunfe4wWF572sFlc3jWHzWLRslZmi55HWg7sHptWdbJ57J+7ht1jw5Z/LB7Hb2xn8vi8SS6A
        NYrLJiU1J7MstUjfLoErY+rxtYwFn3kq/nRpNzBu5Opi5OSQEDCRmH7pH3MXIxeHkMAKRol9
        +9awQThfGCVebbjHCOF8ZpQ4ems1C0zLtcO9UInljBKTrvVDOe8ZJRo7Z7CBVAkLOEkcfrIY
        rENEQE/idctfVpAiZoEbjBLvvveAJdgEDCW63naBNfAK2Em0PzjGCmKzCKhKrLrzh72LkYND
        VCBG4tDiMogSQYmTM5+wgIQ5BTQkVrUYg4SZBeQltr+dwwxhi0vcejKfCWSVhMAmdonly+dD
        Xe0iMbVxMxuELSzx6vgWdghbRuL/TpiGZkaJ9hmz2CGcHkaJrXN2QHVYSxw+fpEVZDOzgKbE
        +l36EGFHiQlXzzKChCUE+CRuvBWEOIJPYtK26cwQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZ
        SD6bheSdWUjemYWwdwEjyypG8dTS4tz01GKjvNRyveLE3OLSvHS95PzcTYzABHT63/EvOxh3
        /Uk6xCjAwajEw5uQ3BojxJpYVlyZe4hRgoNZSYQ3QbYtRog3JbGyKrUoP76oNCe1+BCjNAeL
        kjhvNcODaCGB9MSS1OzU1ILUIpgsEwenVANj31zvYtOF3+eeXuTbPn2y0tSJX5PZV75ODZ72
        eU1dzJsfTQHij9ZLRao2yKppv/v1V/NSZ3xO9Cy7g1+ET2YaOmdxTVbdw7h2/tKu2yWfFtxi
        c3W6KCzzT8GbrV4ngFd2y92jLK9qF3fGWrLOumXoUrV0WdwangMhOhe3/3s9c8YH+cc/F7ul
        KbEUZyQaajEXFScCACCIbtA8AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xe7oVTm0xBtsWC1kca3vCbtG8eD2b
        xdK/9xgtLjztYbO4vGsOm8WiZa3MFj2PtBzYPTat6mTz2D93DbvHhi3/WDyO39jO5PF5k1wA
        a5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJextTj
        axkLPvNU/OnSbmDcyNXFyMkhIWAice1wL2MXIxeHkMBSRolDB5ewQiRkJE5Oa4CyhSX+XOti
        gyh6yyix5XgTE0hCWMBJ4vCTxSwgtoiAnsTrlr+sIEXMAjcYJT6f/g3VsZBJYs6Tn2Cj2AQM
        Jbregozi5OAVsJNof3AMLM4ioCqx6s4fdhBbVCBG4sPdG0wQNYISJ2c+AdrAwcEpoCGxqsUY
        JMwsoC7xZ94lZghbXmL72zlQtrjErSfzmSYwCs1C0j0LScssJC2zkLQsYGRZxSiSWlqcm55b
        bKRXnJhbXJqXrpecn7uJERhz24793LKDsetd8CFGAQ5GJR5ejsTWGCHWxLLiytxDjBIczEoi
        vAmybTFCvCmJlVWpRfnxRaU5qcWHGE2BfpvILCWanA9MB3kl8YamhuYWlobmxubGZhZK4rzn
        DSqjhATSE0tSs1NTC1KLYPqYODilGhgbt7zpFV+u+NzxYr2SePHJH2vN1yWundd97r5J6v2f
        LuIWWW1vxRVYzwrJCLdFr+OwTPvJcPSJp2Xb6TP754lcn3hq5Y9Y9z5DgcUs92Q0ZmxoOmhn
        s/bcFr28wj9dsg8PW3Q939gbzcT10yfn9uNU7asMXhMmhmo786p/ms3ZfEFs7tOT25KUWIoz
        Eg21mIuKEwHGStjjzwIAAA==
X-CMS-MailID: 20190311111152eucas1p11b309165ccdb9bfdc9c39ada5ae34fd6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190206101740epcas2p131674b4b9733047711855ffb2e7a99a7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190206101740epcas2p131674b4b9733047711855ffb2e7a99a7
References: <20190121140204.GA2360@vis> <5C5A9DCB.8040507@ti.com>
        <20190206093830.GS26157@vis>
        <CGME20190206101740epcas2p131674b4b9733047711855ffb2e7a99a7@epcas2p1.samsung.com>
        <5C5AB41C.9080402@ti.com> <bdbce410-7f48-17a5-b58b-3ebd65ca6913@samsung.com>
        <20190208193505.GA5822@vis>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jochen,

On 2019-02-08 20:35, Jochen Sprickerhof wrote:
> Hi Marek,
>
> * Marek Szyprowski <m.szyprowski@samsung.com> [2019-02-08 13:36]:
>>>>> On 21/01/19 16:02, Jochen Sprickerhof wrote:
>>>> [..]
>>>>>> I'm not sure why this it only works with the driver compiled into
>>>>>> the
>>>>>> kernel nor why it needs a hard reset or why it was the line was
>>>>>> dropped
>>>>>> when the patch was accepted. Would be great to get some feedback
>>>>>> of the
>>>>>> authors.
>>>>> When XHCI driver is compiled into the kernel are the relevant PHY
>>>>> drivers
>>>>> compiled in as well?
>>>> Only CONFIG_USB_PHY=y (I took the config from the
>>>> linux-image-4.19.0-1-armmp_4.19.13-1_armhf.deb Debian package as a
>>>> basis where this is the default).
>>
>> I confirm that on Odroid XU4 USB 3.0 works only when all related drivers
>> (dwc3, xhci and exynos5 drd phy) are compiled into the kernel. If they
>> are compiled as modules, USB 3.0 calibration doesn't work. The mentioned
>> patch doesn't fix anything.
>
> I've just tried Linux v5.0-rc5 with the Debian config and
> USB_XHCI_PLATFORM=y and it works, thanks!
>
> Is there a way to make it work with xhci compiled as a module, so it
> would work in Debian out of the box?

One more comment - 5000M mode will also work with everything compiled as
modules (dwc3, exynos5 drd phy and xhci-plat) too. Just make sure that
xhci-plat is loaded before dwc3. This would require some manual
configuration, because autoloading will load xhci-plat after dwc3 probe
and switch to host mode.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

