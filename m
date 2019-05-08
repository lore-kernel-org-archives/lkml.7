Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A8CC04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC182214C6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ihrRChrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfEHKOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:14:25 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:41592 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfEHKOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:14:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190508101423euoutp01023dde7f984e6cb772cc650aa00bb7b6~crZ2rXPhm2010920109euoutp01t
        for <linux-kernel@vger.kernel.org>; Wed,  8 May 2019 10:14:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190508101423euoutp01023dde7f984e6cb772cc650aa00bb7b6~crZ2rXPhm2010920109euoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557310463;
        bh=utUVNhCfh+UPT/3azJ/XF/ssU5K7qOnuZqjcAxNV8sU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=ihrRChrticvdfYfGZ2RRP9c2tfL+MdFqM1B1qa5rJaLxTHaYNJJUfyAwWJbaSdTwd
         0NB1I+bQmckHc55s4h+fDUFDucOn6+t7C9m6CWne5MJv8+dhE3TklPIxHzJ5GX7PLT
         Rpuo3I+6ZrVwUJozZSHX5QO+XgkAe6BZua9Pb9ak=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190508101423eucas1p154c8776774ad781ca66341394812c82d~crZ2HWuv82646526465eucas1p1E;
        Wed,  8 May 2019 10:14:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id DB.30.04377.EFBA2DC5; Wed,  8
        May 2019 11:14:23 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190508101422eucas1p25503ff4d035742c0511fa03cae7b13f5~crZ1WxdkY3049830498eucas1p2k;
        Wed,  8 May 2019 10:14:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190508101422eusmtrp10a5da45f8b0cc9b389fbaf353b13ce1d~crZ1DuAx43037530375eusmtrp1N;
        Wed,  8 May 2019 10:14:22 +0000 (GMT)
X-AuditID: cbfec7f4-5632c9c000001119-86-5cd2abfea210
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B8.4D.04146.DFBA2DC5; Wed,  8
        May 2019 11:14:22 +0100 (BST)
Received: from [106.120.50.25] (unknown [106.120.50.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190508101421eusmtip271188177f3895bb5b18e3599d94da593~crZ0mVoxg0974009740eusmtip2B;
        Wed,  8 May 2019 10:14:21 +0000 (GMT)
Subject: Re: [PATCH] usb: core: verify devicetree nodes for disabled
 interfaces
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Krzysztof Kozlowski <krzk@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <106fc58c-1a4f-6605-41d7-b6031c5751a3@samsung.com>
Date:   Wed, 8 May 2019 12:14:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yw1xy33iv1lq.fsf@mansr.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87r/V1+KMbgbb7FxxnpWi+bF69ks
        zp/fwG5xedccNosZ5/cxWSxa1sps8fLID0aLHw+nMzlweNy6U++xaVUnm8f+uWvYPd6cPsXu
        0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBkH3sxgLpglWtF07SxrA+MxwS5GDg4JAROJTZeE
        uhi5OIQEVjBKvD97jA3C+cIoceTZb3YI5zOjxKO3nUAOJ1jH9d6zzBCJ5YwS/a/+QrW8ZZQ4
        d3IWE0iVsECgxIl/h1hBbBEBU4kdsy6CFTELzGGSeLt9KtgoNgFDia63XWwgNq+AncSFr1MY
        QWwWARWJHZfPM4EcKCoQI7HoM1SJoMTJmU9YQGxOAU2JF3sfg8WZBeQlmrfOZoawxSVuPZnP
        BHHpPnaJoy3CELaLxKRVB6A+EJZ4dXwLlC0jcXpyDwvIbRICzYwSD8+tZYdwehglLjfNYISo
        spY4fPwiK8hBzECb1+/Shwg7SjzZeY8dEpB8EjfeCkLcwCcxadt0Zogwr0RHmxBEtZrErOPr
        4NYevHCJeQKj0iwkn81C8s0sJN/MQti7gJFlFaN4amlxbnpqsVFearlecWJucWleul5yfu4m
        RmBKOv3v+JcdjLv+JB1iFOBgVOLhfVFwMUaINbGsuDL3EKMEB7OSCO/1iZdihHhTEiurUovy
        44tKc1KLDzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTBWLE1VUljO5Zc9/7jr80ql
        0zY5EbbpCT8X7rtzuPHkg8scHyUWZobIMJa0evQFqOQuP3L/T2WpuHTN3u2Oohu4fHarBn8p
        8DZ+VJF+LORy7renvW16yccE37XxiyhHq5kvSnpvVt21ba7ClKc8WoZJM7TP312e1V/xufrv
        b6cFos9cJl0X+qbEUpyRaKjFXFScCABb7tdMRQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsVy+t/xe7r/Vl+KMVj0hNFi44z1rBbNi9ez
        WZw/v4Hd4vKuOWwWM87vY7JYtKyV2eLlkR+MFj8eTmdy4PC4dafeY9OqTjaP/XPXsHu8OX2K
        3aNvyypGj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJz
        MstSi/TtEvQyDryZwVwwS7Si6dpZ1gbGY4JdjJwcEgImEtd7zzJ3MXJxCAksZZTYtnQVK0RC
        RuLktAYoW1jiz7UuNhBbSOA1o8Tsm6YgtrBAoMSJf4fAakQETCV2zLrIBjKIWWAOk8SP5pfs
        EFPXMkp0fZzHAlLFJmAo0fUWYhKvgJ3Eha9TGEFsFgEViR2XzzOB2KICMRInpm5hh6gRlDg5
        8wlYL6eApsSLvY/BepkFzCTmbX7IDGHLSzRvnQ1li0vcejKfaQKj0Cwk7bOQtMxC0jILScsC
        RpZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgZG47djPzTsYL20MPsQowMGoxMM7YdalGCHW
        xLLiytxDjBIczEoivNcnAoV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5gk8kriDU0NzS0s
        Dc2NzY3NLJTEeTsEDsYICaQnlqRmp6YWpBbB9DFxcEo1MLLyVGx+rWgiXMrYuswwtUZ3UuS6
        R0q3Ajr2JUks3nZiRqtp6HmXf9oPbJX+PlJbe2P68sB0cdebb1am8K2Zs6Rcc/8pv+fiFTp7
        NPxFvrMsFVd6ZzknfIVKoMkLo5P5V5vc/3G2LXjZE/5kKmvi2fJwr32Hn+axh4crP+BPjeyP
        FjjUFL12vRJLcUaioRZzUXEiABUqXUXaAgAA
X-CMS-MailID: 20190508101422eucas1p25503ff4d035742c0511fa03cae7b13f5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190507125630eucas1p1c5fd171a8dc2a6b8eb9dd317fe245f0c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190507125630eucas1p1c5fd171a8dc2a6b8eb9dd317fe245f0c
References: <CGME20190507125630eucas1p1c5fd171a8dc2a6b8eb9dd317fe245f0c@eucas1p1.samsung.com>
        <20190507125615.9381-1-m.szyprowski@samsung.com>
        <yw1xy33iv1lq.fsf@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 2019-05-07 15:24, Måns Rullgård wrote:
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
>> this issue without changing the devicetree bindings and the way the PHY
>> controllers are handled by Exynos EHCI/OHCI drivers.
>>
>> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
>> Fixes: 01fdf179f4b0 ("usb: core: skip interfaces disabled in devicetree")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/usb/core/message.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
>> index 82239f27c4cc..cd455c4add25 100644
>> --- a/drivers/usb/core/message.c
>> +++ b/drivers/usb/core/message.c
>> @@ -2007,6 +2007,7 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
>>   		struct usb_interface *intf = cp->interface[i];
>>
>>   		if (intf->dev.of_node &&
>> +		    of_device_is_compatible(intf->dev.of_node, NULL) &&
>>   		    !of_device_is_available(intf->dev.of_node)) {
>>   			dev_info(&dev->dev, "skipping disabled interface %d\n",
>>   				 intf->cur_altsetting->desc.bInterfaceNumber);
>> -- 
> This doesn't look right.  of_device_is_compatible() with a NULL compat
> argument always returns zero.

Right, my fault. I missed that. of_find_property(intf->dev.of_node, 
"compatible", NULL) is the correct check.


> There also seems to be a broader incompatibility between the generic USB
> bindings and the use of child nodes in the Exynos bindings.

True, but frankly I have no idea how to fix this in a better way.

Exynos EHCI/OHCI bindings predates the generic USB device bindings and 
now we can only mitigate the damage caused by this conflict.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

