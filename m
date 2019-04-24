Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC60C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74E421773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pleNrAi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbfDXJGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:06:05 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58831 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfDXJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:06:04 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190424090559epoutp038fea915ba1f42d151fc30362707fc01b~YXcItoYoL2999529995epoutp03r
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:05:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190424090559epoutp038fea915ba1f42d151fc30362707fc01b~YXcItoYoL2999529995epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556096759;
        bh=Ig+o2JbI186h2N9x+xAOei/7PDumNrr1IXnQCZQiZ+Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=pleNrAi9SoHdhZVpv3t296bElO8lx/qIR2AQeU9aWex8osXbPMI9zLkRmh8H0PmBV
         znWTMZwinvHGY3ASaSyoDr0ZgVTJKu1OpNQlh8wonEN8m5yN8ynIf2cNLJlGVzfBOP
         ZArfsAuZoG8SRtwYS+n/x2jc2AGMWZVkSLfpxMIQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20190424090559epcas5p1c76482dd8a4d5dc3d074c5c2b36c25b0~YXcIOOFzj2664426644epcas5p1Z;
        Wed, 24 Apr 2019 09:05:59 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.63.04066.7F620CC5; Wed, 24 Apr 2019 18:05:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20190424090558epcas5p23f972e4484cdb0e1760abfb4fb1c9eea~YXcHi-iIq1073010730epcas5p22;
        Wed, 24 Apr 2019 09:05:58 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190424090558epsmtrp1f12888f0886141ef3d8594d8152eedbe~YXcHiNcxN0913609136epsmtrp1v;
        Wed, 24 Apr 2019 09:05:58 +0000 (GMT)
X-AuditID: b6c32a4a-973ff70000000fe2-a9-5cc026f77a71
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.33.03662.6F620CC5; Wed, 24 Apr 2019 18:05:58 +0900 (KST)
Received: from [107.116.255.46] (unknown [107.116.255.46]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190424090556epsmtip1ed08efed1d1d25d57249857d7e8e996f~YXcGB-Wdp2161221612epsmtip1S;
        Wed, 24 Apr 2019 09:05:56 +0000 (GMT)
Subject: Re: [PATCH] usb: xhci: inherit dma_mask from bus if set correctly
To:     Robin Murphy <robin.murphy@arm.com>,
        Sriram Dash <sriram.dash@samsung.com>, mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, mgautam@codeaurora.org,
        felipe.balbi@linux.intel.com
From:   Pankaj Dubey <pankaj.dubey@samsung.com>
Message-ID: <d2bd55f4-c86f-8edc-2db6-5ec10a73c583@samsung.com>
Date:   Wed, 24 Apr 2019 14:35:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <da9f396c-c6e6-8ee7-b3b2-1202d00aa8d2@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAKsWRmVeSWpSXmKPExsWy7bCmlu53tQMxBj2n+S3m30yyaF68ns1i
        xZeZ7Bbnz29gt7i8aw6bxaJlrcwWzZumsFp8/jiJzeLghyesFjfWsztweayZt4bR43JfL5PH
        zll32T0W73nJ5LFpVSebx7yTgR77565h9+jbsorR4/MmuQDOKC6blNSczLLUIn27BK6MVbuO
        sRf89alomvaEvYHxln0XIyeHhICJxNVrJ5m6GLk4hAR2M0ocXHacBcL5xChxev8mNgjnG6PE
        5ebTzDAtS+c/Z4ZI7GWU2D5tNyOE855R4u/a6ewgVcICXhL/Hr1gBLFFBDIlHh9qApvLLHAX
        aNSNj6wgCTYBXYkn7+eCjeUVsJNY39zKBGKzCKhKTHt+iQXEFhWIkHj/dDcLRI2gxMmZT8Bs
        TgFridf7ZoL1MgvISzRvnQ1li0vcejIf7CMJgX52ifO3jrJC3O0ise7Sa3YIW1ji1fEtULaU
        xMv+Nig7X+LH4knMEM0tjBKTj8+FaraXOHBlDtBmDqANmhLrd+lDLOOT6P39hAkkLCHAK9HR
        JgRRrSbx/fkZaHDJSDxsXsoEYXtI/Ox4AQ2tHmaJbefWMk5gVJiF5LdZSP6ZheSfWQibFzCy
        rGKUTC0ozk1PLTYtMMpLLdcrTswtLs1L10vOz93ECE5nWl47GJed8znEKMDBqMTDG8CzP0aI
        NbGsuDL3EKMEB7OSCK/JdqAQb0piZVVqUX58UWlOavEhRmkOFiVx3rmyc6OFBNITS1KzU1ML
        UotgskwcnFINjEmLjMsTTrRKhDjyPD/hv0zZ7FYoS5fqpscXRBSvHOtxfZ7KfMXE4nr5sa8J
        qh27tvi0e6gdv3pZZ+k1gy0umcfPnvcTfLeYuTnoWLn37ndMuQ22kSx7nTmPWeuGFG77eGyi
        RbFXhvmvi1EffxhlnbW9sXzZ1tvC15rStin2uK0J3zBX0nZqqBJLcUaioRZzUXEiAHtslZtj
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsWy7bCSnO43tQMxBnvvylrMv5lk0bx4PZvF
        ii8z2S3On9/AbnF51xw2i0XLWpktmjdNYbX4/HESm8XBD09YLW6sZ3fg8lgzbw2jx+W+XiaP
        nbPusnss3vOSyWPTqk42j3knAz32z13D7tG3ZRWjx+dNcgGcUVw2Kak5mWWpRfp2CVwZq3Yd
        Yy/461PRNO0JewPjLfsuRk4OCQETiaXznzN3MXJxCAnsZpQ43fqWHSIhIzF59QpWCFtYYuW/
        5+wQRW8ZJe48PANWJCzgJfHv0QtGEFtEIFNi54QXYJOYBe4ySvzsW8oE0dHDLHH+zS82kCo2
        AV2JJ+/nMoPYvAJ2EuubW5lAbBYBVYlpzy+xgNiiAhESdy++YIGoEZQ4OfMJmM0pYC3xet9M
        sF5mATOJeZsfQtnyEs1bZ0PZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6x
        YYFRXmq5XnFibnFpXrpecn7uJkZw7Glp7WA8cSL+EKMAB6MSD28Az/4YIdbEsuLK3EOMEhzM
        SiK8JtuBQrwpiZVVqUX58UWlOanFhxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhgT
        n83yXW69t7zU1Y7l57z+HVcjlt1wcBWa+eteGEd5k81kg6vRnNM7ixL7dW8IP5u5i89HnjEv
        b3Xf2nqd+BuP9sXev/DzgMyctEcxDiYc8vtfvtjye4nfmfQQLWH7zqs8pTsb4jy3FvGsqdF2
        0DhZ4BuxL+kah4uAx1Rrs5zlxltPcSbdOajEUpyRaKjFXFScCADZQZruuQIAAA==
X-CMS-MailID: 20190424090558epcas5p23f972e4484cdb0e1760abfb4fb1c9eea
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20190402094246epcas1p1f43795d840b4c3a1f7efddc0523b2c89
References: <CGME20190402094246epcas1p1f43795d840b4c3a1f7efddc0523b2c89@epcas1p1.samsung.com>
        <1554198011-24342-1-git-send-email-pankaj.dubey@samsung.com>
        <0d3e8992-06e1-57e4-edd5-ba230caaa189@arm.com>
        <CAGcde9F1h31FQ7qLUdFTvZ_1vt67956=5r-Do6qU3Q0vSVe6=g@mail.gmail.com>
        <CAOD6=z69K9bBqUikwogJ2YH_OfxODfsy+uRb6dX9x9AOuP6Wpw@mail.gmail.com>
        <da9f396c-c6e6-8ee7-b3b2-1202d00aa8d2@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/10/19 4:32 AM, Robin Murphy wrote:
> On 2019-04-09 3:56 am, Sriram Dash wrote:
>> On Tue, Apr 2, 2019 at 9:53 PM Pankaj Dubey 
>> <pankaj.dubey@samsung.com> wrote:
>>>
>>> On Tue, 2 Apr 2019 at 15:34, Robin Murphy <robin.murphy@arm.com> wrote:
>>>>
>>>> On 02/04/2019 10:40, Pankaj Dubey wrote:
>>>>> From: Sriram Dash <sriram.dash@samsung.com>
>>>>>
>>>>> The xhci forcefully converts the dma_mask to either 64 or 32 and the
>>>>> dma-mask set by the bus is somewhat ignored. If the platform  sets 
>>>>> the
>>>>> correct dma_mask, then respect that.
>>>>
>>>> It's expected for dma_mask to be larger than bus_dma_mask if the 
>>>> latter
>>>> is set - conceptually, the device mask represents what the device is
>>>> inherently capable of, while the bus mask represents external
>>>> interconnect restrictions which individual drivers should not have to
>>>> care about. The DMA API backend should take care of combining the 
>>>> two to
>>>> find the intersection.
>>>
>>> Thanks for the review.
>>>
>>> We are dealing here with the xhci platform which inherits the dma mask
>>> of the parent, which is from a controller device.
>>>
>>> When the controller dma mask is set by the platform in DT, what we
>>> observe is, its not getting inherited properly and the xhci bus is
>>> forcing the dma address to be either 32 bit or 64 bit.
>>>
>>> In "drivers/usb/host/xhci-plat.c" we have dma_mask setting as below:
>>>
>>>   /* Try to set 64-bit DMA first */
>>> if (WARN_ON(!sysdev->dma_mask))
>>>       /* Platform did not initialize dma_mask */
>>>       ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
>>> else
>>>       ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
>>>
>>> So even if the controller device has set the dma_mask as per it's
>>> configuration in DT, xhci-plat.c will override it here in else part.
>>>
>>> Next it goes to "drivers/usb/host/xhci.c" file, here we have code as:
>>>
>>> /* Set dma_mask and coherent_dma_mask to 64-bits,
>>>   * if xHC supports 64-bit addressing */
>>> if (HCC_64BIT_ADDR(xhci->hcc_params) &&
>>>                  !dma_set_mask(dev, DMA_BIT_MASK(64))) {
>>>          xhci_dbg(xhci, "Enabling 64-bit DMA addresses.\n");
>>>          dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
>>> } else {
>>>          /*
>>>           * This is to avoid error in cases where a 32-bit USB
>>>           * controller is used on a 64-bit capable system.
>>>           */
>>>          retval = dma_set_mask(dev, DMA_BIT_MASK(32));
>>>          if (retval)
>>>                  return retval;
>>>          xhci_dbg(xhci, "Enabling 32-bit DMA addresses.\n");
>>>          dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>> }
>>>
>>> So xhci will force the dma_mask to either DMA_BIT_MASK(32) or
>>> DMA_BIT_MASK(64), what if my device needs other than 32 bit or 64 bit
>>> dma_mask.
>>>
>>> The bus_dma_mask was introduced for a case when the bus from a
>>> device's dma interface may carry fewer address bits. But apparently,
>>> it is the only mask which retains the original dma addressing from the
>>> parent. So basically what we observe is currently there is no way we
>>> can pass dma_mask greater than 32-bit, from DT via dev->dma_mask or
>>> dev->coherent_dma_mask due to below logic in
>>>
>>> from "drivers/of/platform.c" we have
>>> static struct platform_device *of_platform_device_create_pdata(
>>>                                          struct device_node *np,
>>>                                          const char *bus_id,
>>>                                          void *platform_data,
>>>                                          struct device *parent)
>>> {
>>>        struct platform_device *dev;
>>>        ...
>>>        dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>>>        if (!dev->dev.dma_mask)
>>>               dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>>>    ...
>>> }
>>>
>>> and then in of_dma_configure function in "drivers/of/device.c" we 
>>> have..
>>>
>>> mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1); //This mask
>>> computation is going fine and gets mask greater than 32-bit if defined
>>> in DT
>>> dev->coherent_dma_mask &= mask;  // Here the higher bit [63:32] will
>>> get truncated as coherent_dma_mask is initialized to DMA_BIT_MASK(32)
>>> in platform.c
>>>
>>> *dev->dma_mask &= mask; //Same here higher bits will get truncated
>>> /* ...but only set bus mask if we found valid dma-ranges earlier */
>>> if (!ret)
>>> dev->bus_dma_mask = mask; //Only bus_dma_mask can carry the original
>>> mask as specified in platform DT.
>>>
>>> To minimise the impact on existing code, we reused the bus_dma_mask
>>> for finding the dma addressing bits.
>>>
>>> Or other way we may need to initialise dma_mask/coherent_dma_mask as
>>> DMA_BIT_MASK(64) in "drivers/of/platform.c" and let all devices set
>>> dma_mask via DT using "dma-ranges" property or respective platform
>>> driver.
>>>
>>>> Are you seeing an actual problem here, and if so
>>>> on which platform? (If the bus mask is set at all then it wouldn't 
>>>> seem
>>>> to be the DT PCI issue that I'm still trying to fix).
>>>>
>>>
>>>
>>> We are facing this issue in one of the Samsung's upcoming SoC where we
>>> need dma_mask greater than 32-bit.
>>>
>>> Thanks,
>>> Pankaj
>>>> Robin.
>>>>
>>>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>>>> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
>>>>> ---
>>>>>    drivers/usb/host/xhci.c | 10 ++++++++++
>>>>>    1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>>>> index 005e659..55cf89e 100644
>>>>> --- a/drivers/usb/host/xhci.c
>>>>> +++ b/drivers/usb/host/xhci.c
>>>>> @@ -5119,6 +5119,16 @@ int xhci_gen_setup(struct usb_hcd *hcd, 
>>>>> xhci_get_quirks_t get_quirks)
>>>>>                dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>>>>        }
>>>>>
>>>>> +     /*
>>>>> +      * A platform may require coherent masks other than 64/32 
>>>>> bit, and we
>>>>> +      * should respect that. If the firmware has already 
>>>>> requested for a
>>>>> +      * dma-range, we inherit the dma_mask presuming the platform 
>>>>> knows
>>>>> +      * what it is doing.
>>>>> +      */
>>>>> +
>>>>> +     if (dev->bus_dma_mask)
>>>>> +             dma_set_mask_and_coherent(dev, dev->bus_dma_mask);
>>>>> +
>>>>>        xhci_dbg(xhci, "Calling HCD init\n");
>>>>>        /* Initialize HCD and host controller data structures. */
>>>>>        retval = xhci_init(hcd);
>>>>>
>>
>> Hello Robin,
>>
>> Hope you found the crux of the matter. Any comments on the same?
>
> Sorry, I never received either of these replies - I've just happened 
> to notice this thread again by pure chance while looking at the 
> linux-usb patchwork for something else entirely, and managed to dredge 
> an mbox off lore.kernel.org to reply to. Mail is not my area of 
> expertise, but looking at the headers of the initial patch in my inbox 
> it seems that outlook.com is doing SPF negotiation with samsung.com, 
> so sending via gmail (as those replies appear to be) may be failing 
> that and getting silently discarded (they're not even in my spam 
> quarantine).
>
> From the snippets of code quoted above I don't see anything obviously 
> wrong, but I'll take a closer look tomorrow. AFAICS though, if 
> dev->bus_dma_mask is set then dev is probably the appropriate device 
> for DMA, so I wouldn't expect a problem - XHCI is inherently a 64-bit 
> device, so its driver *should* be setting a 64-bit mask in this case. 
> To reiterate, what's the nature of the DMA issue? Do the mapping 
> operations fail, or do you actually see transfers going wrong due to 
> address truncation? Also, which arch is involved here - is it arm64 
> (as I seem to have assumed), or something else?
>
> Robin.
>

Regarding issue in above code snippet, current code sets 
"dev->dev.coherent_dma_mask" as DMA_BIT_MASK(32) in platform.c 
(irrespective of architecture) and when we parse "dma-ranges" property 
and try to set coherent_dma_mask or dma_mask in of_dma_configure 
function in "drivers/of/device.c", even if "dma-ranges" specified in DT 
is more than 32-bit, 32-63 bits will be cleared to zero due to masking 
done in platform.c.

So effectively we are not able to set dma_mask or coherent_dma_mask 
larger than 32-bit mask.

For the SoC concerned here is based on arm64, the USB IP (64 bit 
capable) is connected to a 36-bit Data bus and a 32-bit Control bus. The 
36-bit Data bus is connected to an IOMMU which translates the address 
before they are passed on to other blocks. Here we have IOMMU is capable 
of 40-bit addressing. But as data bus is only capable of 36-bit, we need 
to ensure that IOMMU translates to address which does not exceed 36-bit.

Without this fix we are observing context fault from IOMMU.

Now, to get a workaround to this problem, we are inheriting the 
bus_dma_mask which is apparently the only one which contains the 36-bit 
bus mask.

Or as alternate solution we need to change coherent_dma_mask default 
mask as DMA_BIT_MASK(64) rather DMA_BIT_MASK(32) so that in 
of_dma_configure, the dma_mask/coherent_dma_mask get populated from 
"dma_ranges" DT property during device registration.


