Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767AAC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDB6216B7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VzquYJvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfEHNt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:49:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56614 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfEHNt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:49:27 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190508134926euoutp017e5e4f719993687778eab059719d7cb5~cuVmxUWnJ0482904829euoutp01O
        for <linux-kernel@vger.kernel.org>; Wed,  8 May 2019 13:49:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190508134926euoutp017e5e4f719993687778eab059719d7cb5~cuVmxUWnJ0482904829euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557323366;
        bh=q+nK4iPzFi5yb1QN5xDIbg4tVHfLGHmSjPZiJvo6CYs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VzquYJvMzGKvmdn0vmFFNEpyCtIQe+trQ053DttbpS1+4dJ3ooGpM13LS6eUgkfk8
         cWRgXcpqamVi2gMjUTsfsoCkzae6hWbd+DAAxp0jZZg4vm+ycsyxp4UxIT59P4+kGO
         Xyui70Xa4HSa42w3r/IPtxSVuTrDaard4YJC3jzk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190508134925eucas1p16b1c30b44a8ffc746b81d4edb6feb966~cuVmX7ebV2880828808eucas1p1J;
        Wed,  8 May 2019 13:49:25 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 61.AA.04325.56ED2DC5; Wed,  8
        May 2019 14:49:25 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190508134924eucas1p2a2d309e35f15ff66eefa56849b5c9171~cuVlrg-Xa0640406404eucas1p21;
        Wed,  8 May 2019 13:49:24 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190508134924eusmtrp1eec54a4b59c653d1bc69b5dbf2eb62f7~cuVldYR4_2980329803eusmtrp1Z;
        Wed,  8 May 2019 13:49:24 +0000 (GMT)
X-AuditID: cbfec7f5-b8fff700000010e5-90-5cd2de657b5d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 84.E7.04146.46ED2DC5; Wed,  8
        May 2019 14:49:24 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190508134924eusmtip2162b8c5f14913ae4dbfea5a4ae796dbd~cuVk6ofOR0200002000eusmtip24;
        Wed,  8 May 2019 13:49:24 +0000 (GMT)
Subject: Re: [PATCH v2] usb: core: verify devicetree nodes for disabled
 interfaces
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e7f32280-57ec-6298-1a5d-8d2d4dc26667@samsung.com>
Date:   Wed, 8 May 2019 15:49:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yw1xtve5uq1y.fsf@mansr.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTcRjG/Z+znZ1Js+NUfL0ljYgKvGXBohILP+xDYEhfMtFmnjbJqWzO
        W5GXaday6ILN1rKcZTKaS7ElCstMHU1pXjLLIqboB01FWIHWuux4tPz2+z/v8/C8L/xJXNjG
        DSWzcwtoZa40R0T4cqwDq84o+stoWux7j1DcVm/hijVNFkLsdD7jice6DIS43mnDxMbmalw8
        17eCxCtTOiyRlEx+LpO0m64Qkpf3n/IkC4MOnuR6hwlJ3O3bjhOpvoey6JzsQloZk3DaV16n
        TcpfDil+NOThlqOmIC3ik0Dtgx9tlYQW+ZJCqgVBTeNjghkIqW8I5qxKlt0IbI6IjUD3qms9
        8ATBkMPJZR+LCDqG5nHGFUCdgNZqHcZwILUfOvUjawmcMmCw+KKOxwwIKg60i9q1OgGVABXW
        ca9OkhxqBxgmTjIYRKWB0b3u8Ic3d2c4DPOp3aDtWUIM41QkaJ7fw1kOhsmZBxhTBZSNB4aq
        EYzdOgkWjKs4ywEwb+/gsRwOg7drOWxAg2DqrZnHPmoRjFXWI9Z1EF7bR7jMRri32tIVw8pH
        YLrBQzAyUH7wYdGfXcIPbll1OCsL4PIlIeveCXp767/aV8Oj+A0k0m86Tb/pHP2mc/T/ex8i
        jgkF02qVQkar4nPpomiVVKFS58qiz+Qp2pH3Iw3+tn/vRDZPZi+iSCTaIpD3jqYJudJCVYmi
        FwGJiwIFEze9kiBLWlJKK/MylOocWtWLwkiOKFhw3sd1SkjJpAX0OZrOp5UbU4zkh5YjzCr8
        c2xv92B4QooxPHa6eXnSMpxekVjaEzZgdnxSR6zwfaLUB4b7oPhXsm50NgqLza5JGVj5mpzk
        PlsVGaK15ScJ+hu3Xi3Wu/ybM80+F8rstGvcdLQ0qGj7tYyLVrm8peaOrSHeYMGX0o26yI+H
        fxr7YXZXaKompvSdzCziqOTSuD24UiX9CwVdUSxEAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7op9y7FGHx/qGqxccZ6VovmxevZ
        LM6f38BucXnXHDaLGef3MVksWtbKbPHyyA9Gix8PpzM5cHjculPvsWlVJ5vH/rlr2D3enD7F
        7tG3ZRWjx+dNcgFsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5
        mWWpRfp2CXoZU7tcCj5IViw584e1gXGxaBcjJ4eEgInE7p8P2LoYuTiEBJYyShy6MIcNIiEj
        cXJaAyuELSzx51oXVNFrRomdW+aAJYQFQiTWtU5nArFFBEwldsy6CFbELDCHSeJH80t2kISQ
        wCNGie/Xq0BsNgFDia63XWAbeAXsJBq3XQWq4eBgEVCRmHM9EiQsKhAjcWLqFnaIEkGJkzOf
        sIDYnAKaEl0H3jGC2MwCZhLzNj9khrDlJZq3zoayxSVuPZnPNIFRaBaS9llIWmYhaZmFpGUB
        I8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2MwCjcduzn5h2MlzYGH2IU4GBU4uHNOHQpRog1
        say4MvcQowQHs5II7/WJQCHelMTKqtSi/Pii0pzU4kOMpkC/TWSWEk3OByaIvJJ4Q1NDcwtL
        Q3Njc2MzCyVx3g6BgzFCAumJJanZqakFqUUwfUwcnFINjJ6G1U/LH0pd0/3v6Hx+Tbha6JHp
        cWt8vSuLsvLS/jdOnhueZcBQtX1X3c3ZhSHu8xaskjE0U6zbfuwBt9Edh4p5p/s+O6zRZAjK
        1YxwOhkkED+9hkng8f7y2LgXuT6rI9zN9tTo7jMT6T9nIVP29cXH7dbyH24Hywe8Xn7WabHh
        Aw6rnCdcSizFGYmGWsxFxYkAS7B3ttgCAAA=
X-CMS-MailID: 20190508134924eucas1p2a2d309e35f15ff66eefa56849b5c9171
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190508104442eucas1p2ebdffa348465f2c28177601014614853
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190508104442eucas1p2ebdffa348465f2c28177601014614853
References: <106fc58c-1a4f-6605-41d7-b6031c5751a3@samsung.com>
        <CGME20190508104442eucas1p2ebdffa348465f2c28177601014614853@eucas1p2.samsung.com>
        <20190508104434.3409-1-m.szyprowski@samsung.com>
        <yw1xtve5uq1y.fsf@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2019-05-08 13:46, Måns Rullgård wrote:
> Marek Szyprowski <m.szyprowski@samsung.com> writes:
>> Commit 01fdf179f4b0 ("usb: core: skip interfaces disabled in devicetree")
>> add support for disabling given USB device interface by adding nodes to
>> the USB host controller device. The mentioned commit however identifies
>> the given USB interface node only by the 'reg' property in the host
>> controller children nodes and then checks for their the 'status'. The USB
>> device interface nodes however also has to have a 'compatible' property as
>> described in Documentation/devicetree/bindings/usb/usb-device.txt. This is
>> important, because USB host controller might have child-nodes for other
>> purposes. For example, Exynos EHCI and OHCI drivers already define
>> child-nodes for each physical root hub port and assigns respective PHY
>> controller and parameters for them. This conflicts with the proposed
>> approach and verifying for the presence of the compatible property fixes
>> this issue without changing the bindings and the way the PHY controllers
>> are handled by Exynos EHCI/OHCI drivers.
>>
>> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
>> Fixes: 01fdf179f4b0 ("usb: core: skip interfaces disabled in devicetree")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/usb/core/message.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
>> index e844bb7b5676..6f7d047392bd 100644
>> --- a/drivers/usb/core/message.c
>> +++ b/drivers/usb/core/message.c
>> @@ -2009,6 +2009,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>>   		struct usb_interface *intf = cp->interface[i];
>>
>>   		if (intf->dev.of_node &&
>> +		    of_find_property(intf->dev.of_node, "compatible", NULL) &&
>>   		    !of_device_is_available(intf->dev.of_node)) {
>>   			dev_info(&dev->dev, "skipping disabled interface %d\n",
>>   				 intf->cur_altsetting->desc.bInterfaceNumber);
>> -- 
> I don't think this is the right approach.  We don't want to be adding
> such checks everywhere the of_node is used.  A better way might be to
> not set of_node at all in the absence of a proper "compatible" string.

Right, this will be a better approach. I've just checked the code and a 
simple check for 'compatible' property presence can be easily added in 
drivers/usb/core/of.c in usb_of_get_device_node() and 
usb_of_get_interface_node() functions.

The second check could be added in drivers/usb/core/hub.c in 
usb_new_device() - to ensure that the device's vid/pid matches of_node 
compatible string.

Is this okay? Or just add a latter one?

> Then there's the problem of how to resolve the incompatibility between
> the generic USB and Exynos bindings.  One possible fix could be to use
> a child node of the controller node to represent the root hub.  Since
> the driver currently doesn't work at all if a devicetree has nodes for
> USB devices, there should be no compatibility concerns.

So far we don't have any use case for adding devicetree nodes for usb 
devices under Exynos EHCI/OHCI hcd, so this shouldn't be a problem for now.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

