Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346C2C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03FB206A3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 04:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="d7gowslH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfDZEqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 00:46:45 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:46245 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZEqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 00:46:44 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190426044639epoutp049561b7df8e4316419a189301171e34f2~Y7MRqxzyV0709507095epoutp04o
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 04:46:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190426044639epoutp049561b7df8e4316419a189301171e34f2~Y7MRqxzyV0709507095epoutp04o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1556253999;
        bh=/piOUeH3GONBM3dfaMu8voP/jFMBl2AJNnjvA4NBslw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d7gowslHkCduz1RrP2ROvenPLl8ZYeeCKhaIdmQME+4fddVfcgPbn0KwegNDxkB+K
         e6/Z9ZfWK46PokxFl8hvUIQ3pG8DDqwyLllzqbLntcG/fZ0p6I9d/ku20RAVRtT1/a
         AQ8wLQ2WoATkBFzJdQCtKt3LhRsJybLhqZHJ0g8w=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20190426044638epcas5p2ecd8ebbc87ac53b2aeacebc62b63fdbb~Y7MQ4ohTl1506515065epcas5p2L;
        Fri, 26 Apr 2019 04:46:38 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.42.04071.E2D82CC5; Fri, 26 Apr 2019 13:46:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20190426044638epcas5p288657bc02d3d435aa1463cba22d27472~Y7MQRr2Oh1506515065epcas5p2K;
        Fri, 26 Apr 2019 04:46:38 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190426044638epsmtrp239e36311663f937a3eb6aba280ede4df~Y7MQQ4aHD0802008020epsmtrp2I;
        Fri, 26 Apr 2019 04:46:38 +0000 (GMT)
X-AuditID: b6c32a49-59fff70000000fe7-53-5cc28d2e2aa4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        B5.E7.03692.D2D82CC5; Fri, 26 Apr 2019 13:46:37 +0900 (KST)
Received: from [107.116.255.14] (unknown [107.116.255.14]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190426044636epsmtip2edeb2011bba56663dd6c3213f6549a1e~Y7MOopcxa3070630706epsmtip2E;
        Fri, 26 Apr 2019 04:46:36 +0000 (GMT)
Subject: Re: [PATCH] usb: xhci: inherit dma_mask from bus if set correctly
To:     Robin Murphy <robin.murphy@arm.com>,
        Sriram Dash <sriram.dash@samsung.com>, mathias.nyman@intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, mgautam@codeaurora.org,
        felipe.balbi@linux.intel.com
From:   Pankaj Dubey <pankaj.dubey@samsung.com>
Message-ID: <b421f3f3-394b-28ff-ea31-da80f8712816@samsung.com>
Date:   Fri, 26 Apr 2019 10:16:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6aadc726-9ab7-0d70-53fd-5845ac72ceca@arm.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRjl3b3bvVstXufCp9nnomKCrmHGhaRCCm5RkNEXZtTMm0rblE3T
        DMnSxD5cZf2o6SyS1FQwl9nH/JyFDCzJZZkRkk6ssOaalGVF3d0i/x3OOc9z3vPw0oTiiVhF
        p5kyObNJb1BLZGRzl0YTGVXiSlz56UEEc+1VElNQ2SBhaiavUkxv722K8TwslzA3qk4RTIHj
        spgJ+EslTOeEV8wMNFDrZWx9RT1iPdYSEfvA9oZiK1vei1hH7WkJW+GOZ9vt9RRrbapFbMCx
        cJs0QRabzBnSjnBm7doDstS+/GfijNGsnKK6i1Q+siadQVIa8Co4/bFYdAbJaAV2IuixuhEv
        KPBnBP3ntgvCFwSt/iny34Sv0CMWTK0InIWLBJMPQfmpZooXQvFm+DX8LrhJidNgxHWS5E0E
        foPAM+APTktwJHh9doLHcrwWHndNBjGJl8HQo+ngorl4D/hGnaTgCQH3Ve8fTNNSvAacL+U8
        TeBFUHC3jBBwGAx6rwXrAD5PQdd4PSG8egPU+UclAg6FD91NlIBVEPjU+pdPh6nKUkIYLkRw
        qdsuFoR10PG8PBhMYA00PNQKYXOgZNor4mnAciguUgju5fB1rOdv7Hx4W3BTJGAWvhXzN+GP
        9ZmAapuXvIAW22ZUs83oY5vRx/Y/+Toia9E8LsNiTOEsMRk6E5cdZdEbLVmmlKiD6UYHCn6y
        iE33ke3pFhfCNFLPltc0diYqxPojlqNGFwKaUCvlK2L+UPJk/dFczpy+35xl4CwuFE6T6jC5
        fYF9rwKn6DO5wxyXwZn/qSJaqspHCS9ij73QLa28l7s7LoabzjYMD+6batwV/Uo5b0i1cyzW
        nYPI18cvDGqvGEK+ta/WxLft2JNdrmzT9OKJ499Lz8X1R49YO/LKwjcOH/o59F3BRp64tc2Z
        aZhlSmswBUL6qnU72R+5Fd3qce2S1DtEVd6lrIqzCVsDubfIaqujJVxNWlL1ugjCbNH/BgFz
        4XRgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMIsWRmVeSWpSXmKPExsWy7bCSvK5e76EYg1Yei/k3kyyaF69ns1jx
        ZSa7xfnzG9gtLu+aw2axaFkrs0XzpimsFp8/TmKzOPjhCavFjfXsDlwea+atYfS43NfL5LFz
        1l12j8V7XjJ5bFrVyeYx72Sgx/65a9g9+rasYvT4vEkugDOKyyYlNSezLLVI3y6BK+NSw0XW
        gqelFW2rJ7I3MPYldTFyckgImEi8b7nM2sXIxSEksJtRou3lU3aIhIzE5NUrWCFsYYmV/56D
        xYUE3jJK3LoaB2ILC3hJ/Hv0ghHEFhHIlNg54QUzyCBmgbuMEj/7ljJBTP3ELNG0eiITSBWb
        gK7Ek/dzmUFsXgE7iaOHv4DZLAKqEveP/AbbICoQIXH34gsWiBpBiZMznwDZHBycAtYSu6/z
        goSZBcwk5m1+yAxhy0s0b50NZYtL3Hoyn2kCo9AsJN2zkLTMQtIyC0nLAkaWVYySqQXFuem5
        xYYFhnmp5XrFibnFpXnpesn5uZsYwVGnpbmD8fKS+EOMAhyMSjy8DFsOxgixJpYVV+YeYpTg
        YFYS4VU3BQrxpiRWVqUW5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXA
        WL9t7bquKdKfM5j8zWT+Le01WfDwxzrRlwzfewpvRhvv7tQp+Hgl0Vj0ZMuOZY2HdLd9iUu/
        ZcTx6boNp9iZX4GX+N4F7nwuXGm26pP/0o9m8yP5mya91pnLfEC3Tv5Ph3O8b86R18JZalaW
        fPYvl4vKq9y1EF9R4Xrw9tRUo3Ijqw2x78+KKLEUZyQaajEXFScCAHfQQka2AgAA
X-CMS-MailID: 20190426044638epcas5p288657bc02d3d435aa1463cba22d27472
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
        <d2bd55f4-c86f-8edc-2db6-5ec10a73c583@samsung.com>
        <6aadc726-9ab7-0d70-53fd-5845ac72ceca@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/24/19 4:28 PM, Robin Murphy wrote:
> On 24/04/2019 10:05, Pankaj Dubey wrote:
>>
>> On 4/10/19 4:32 AM, Robin Murphy wrote:
>>> On 2019-04-09 3:56 am, Sriram Dash wrote:
>>>> On Tue, Apr 2, 2019 at 9:53 PM Pankaj Dubey
>>>> <pankaj.dubey@samsung.com> wrote:
>>>>>
>>>>> On Tue, 2 Apr 2019 at 15:34, Robin Murphy <robin.murphy@arm.com> 
>>>>> wrote:
>>>>>>
>>>>>> On 02/04/2019 10:40, Pankaj Dubey wrote:
>>>>>>> From: Sriram Dash <sriram.dash@samsung.com>
>>>>>>>
>>>>>>> The xhci forcefully converts the dma_mask to either 64 or 32 and 
>>>>>>> the
>>>>>>> dma-mask set by the bus is somewhat ignored. If the platform  sets
>>>>>>> the
>>>>>>> correct dma_mask, then respect that.
>>>>>>
>>>>>> It's expected for dma_mask to be larger than bus_dma_mask if the
>>>>>> latter
>>>>>> is set - conceptually, the device mask represents what the device is
>>>>>> inherently capable of, while the bus mask represents external
>>>>>> interconnect restrictions which individual drivers should not 
>>>>>> have to
>>>>>> care about. The DMA API backend should take care of combining the
>>>>>> two to
>>>>>> find the intersection.
>>>>>
>>>>> Thanks for the review.
>>>>>
>>>>> We are dealing here with the xhci platform which inherits the dma 
>>>>> mask
>>>>> of the parent, which is from a controller device.
>>>>>
>>>>> When the controller dma mask is set by the platform in DT, what we
>>>>> observe is, its not getting inherited properly and the xhci bus is
>>>>> forcing the dma address to be either 32 bit or 64 bit.
>>>>>
>>>>> In "drivers/usb/host/xhci-plat.c" we have dma_mask setting as below:
>>>>>
>>>>>    /* Try to set 64-bit DMA first */
>>>>> if (WARN_ON(!sysdev->dma_mask))
>>>>>        /* Platform did not initialize dma_mask */
>>>>>        ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
>>>>> else
>>>>>        ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
>>>>>
>>>>> So even if the controller device has set the dma_mask as per it's
>>>>> configuration in DT, xhci-plat.c will override it here in else part.
>>>>>
>>>>> Next it goes to "drivers/usb/host/xhci.c" file, here we have code as:
>>>>>
>>>>> /* Set dma_mask and coherent_dma_mask to 64-bits,
>>>>>    * if xHC supports 64-bit addressing */
>>>>> if (HCC_64BIT_ADDR(xhci->hcc_params) &&
>>>>>                   !dma_set_mask(dev, DMA_BIT_MASK(64))) {
>>>>>           xhci_dbg(xhci, "Enabling 64-bit DMA addresses.\n");
>>>>>           dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
>>>>> } else {
>>>>>           /*
>>>>>            * This is to avoid error in cases where a 32-bit USB
>>>>>            * controller is used on a 64-bit capable system.
>>>>>            */
>>>>>           retval = dma_set_mask(dev, DMA_BIT_MASK(32));
>>>>>           if (retval)
>>>>>                   return retval;
>>>>>           xhci_dbg(xhci, "Enabling 32-bit DMA addresses.\n");
>>>>>           dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>>>> }
>>>>>
>>>>> So xhci will force the dma_mask to either DMA_BIT_MASK(32) or
>>>>> DMA_BIT_MASK(64), what if my device needs other than 32 bit or 64 bit
>>>>> dma_mask.
>>>>>
>>>>> The bus_dma_mask was introduced for a case when the bus from a
>>>>> device's dma interface may carry fewer address bits. But apparently,
>>>>> it is the only mask which retains the original dma addressing from 
>>>>> the
>>>>> parent. So basically what we observe is currently there is no way we
>>>>> can pass dma_mask greater than 32-bit, from DT via dev->dma_mask or
>>>>> dev->coherent_dma_mask due to below logic in
>>>>>
>>>>> from "drivers/of/platform.c" we have
>>>>> static struct platform_device *of_platform_device_create_pdata(
>>>>>                                           struct device_node *np,
>>>>>                                           const char *bus_id,
>>>>>                                           void *platform_data,
>>>>>                                           struct device *parent)
>>>>> {
>>>>>         struct platform_device *dev;
>>>>>         ...
>>>>>         dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>>>>>         if (!dev->dev.dma_mask)
>>>>>                dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>>>>>     ...
>>>>> }
>>>>>
>>>>> and then in of_dma_configure function in "drivers/of/device.c" we
>>>>> have..
>>>>>
>>>>> mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1); //This mask
>>>>> computation is going fine and gets mask greater than 32-bit if 
>>>>> defined
>>>>> in DT
>>>>> dev->coherent_dma_mask &= mask;  // Here the higher bit [63:32] will
>>>>> get truncated as coherent_dma_mask is initialized to DMA_BIT_MASK(32)
>>>>> in platform.c
>>>>>
>>>>> *dev->dma_mask &= mask; //Same here higher bits will get truncated
>>>>> /* ...but only set bus mask if we found valid dma-ranges earlier */
>>>>> if (!ret)
>>>>> dev->bus_dma_mask = mask; //Only bus_dma_mask can carry the original
>>>>> mask as specified in platform DT.
>>>>>
>>>>> To minimise the impact on existing code, we reused the bus_dma_mask
>>>>> for finding the dma addressing bits.
>>>>>
>>>>> Or other way we may need to initialise dma_mask/coherent_dma_mask as
>>>>> DMA_BIT_MASK(64) in "drivers/of/platform.c" and let all devices set
>>>>> dma_mask via DT using "dma-ranges" property or respective platform
>>>>> driver.
>>>>>
>>>>>> Are you seeing an actual problem here, and if so
>>>>>> on which platform? (If the bus mask is set at all then it wouldn't
>>>>>> seem
>>>>>> to be the DT PCI issue that I'm still trying to fix).
>>>>>>
>>>>>
>>>>>
>>>>> We are facing this issue in one of the Samsung's upcoming SoC 
>>>>> where we
>>>>> need dma_mask greater than 32-bit.
>>>>>
>>>>> Thanks,
>>>>> Pankaj
>>>>>> Robin.
>>>>>>
>>>>>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>>>>>> Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
>>>>>>> ---
>>>>>>>     drivers/usb/host/xhci.c | 10 ++++++++++
>>>>>>>     1 file changed, 10 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
>>>>>>> index 005e659..55cf89e 100644
>>>>>>> --- a/drivers/usb/host/xhci.c
>>>>>>> +++ b/drivers/usb/host/xhci.c
>>>>>>> @@ -5119,6 +5119,16 @@ int xhci_gen_setup(struct usb_hcd *hcd,
>>>>>>> xhci_get_quirks_t get_quirks)
>>>>>>>                 dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
>>>>>>>         }
>>>>>>>
>>>>>>> +     /*
>>>>>>> +      * A platform may require coherent masks other than 64/32
>>>>>>> bit, and we
>>>>>>> +      * should respect that. If the firmware has already
>>>>>>> requested for a
>>>>>>> +      * dma-range, we inherit the dma_mask presuming the platform
>>>>>>> knows
>>>>>>> +      * what it is doing.
>>>>>>> +      */
>>>>>>> +
>>>>>>> +     if (dev->bus_dma_mask)
>>>>>>> +             dma_set_mask_and_coherent(dev, dev->bus_dma_mask);
>>>>>>> +
>>>>>>>         xhci_dbg(xhci, "Calling HCD init\n");
>>>>>>>         /* Initialize HCD and host controller data structures. */
>>>>>>>         retval = xhci_init(hcd);
>>>>>>>
>>>>
>>>> Hello Robin,
>>>>
>>>> Hope you found the crux of the matter. Any comments on the same?
>>>
>>> Sorry, I never received either of these replies - I've just happened
>>> to notice this thread again by pure chance while looking at the
>>> linux-usb patchwork for something else entirely, and managed to dredge
>>> an mbox off lore.kernel.org to reply to. Mail is not my area of
>>> expertise, but looking at the headers of the initial patch in my inbox
>>> it seems that outlook.com is doing SPF negotiation with samsung.com,
>>> so sending via gmail (as those replies appear to be) may be failing
>>> that and getting silently discarded (they're not even in my spam
>>> quarantine).
>>>
>>>  From the snippets of code quoted above I don't see anything obviously
>>> wrong, but I'll take a closer look tomorrow. AFAICS though, if
>>> dev->bus_dma_mask is set then dev is probably the appropriate device
>>> for DMA, so I wouldn't expect a problem - XHCI is inherently a 64-bit
>>> device, so its driver *should* be setting a 64-bit mask in this case.
>>> To reiterate, what's the nature of the DMA issue? Do the mapping
>>> operations fail, or do you actually see transfers going wrong due to
>>> address truncation? Also, which arch is involved here - is it arm64
>>> (as I seem to have assumed), or something else?
>>>
>>> Robin.
>>>
>>
>> Regarding issue in above code snippet, current code sets
>> "dev->dev.coherent_dma_mask" as DMA_BIT_MASK(32) in platform.c
>> (irrespective of architecture) and when we parse "dma-ranges" property
>> and try to set coherent_dma_mask or dma_mask in of_dma_configure
>> function in "drivers/of/device.c", even if "dma-ranges" specified in DT
>> is more than 32-bit, 32-63 bits will be cleared to zero due to masking
>> done in platform.c.
>>
>> So effectively we are not able to set dma_mask or coherent_dma_mask
>> larger than 32-bit mask.
>
> For better or worse, that is the expected and intended behaviour for 
> the default device masks. Drivers these days are expected to 
> explicitly set their supported mask to replace the default, but there 
> are still some remaining legacy assumptions that the default masks are 
> 32-bit, so making them bigger risks subtle breakage, and that's why 
> of_dma_configure() does the weird things it does.
>
In that case, for systems supporting masks greater than 32-bit, IMO, 
they should be able to handle the mask properly via DT. Without 
disturbing legacy code, this is one solution that can be considered. 
Requesting you to give your opinion on this, if it is acceptable we will 
submit formal patch for this.

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 3717f2a..9cc7a28 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -151,10 +151,19 @@ int of_dma_configure(struct device *dev, struct 
device_node *np, bool force_dma)
         mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
         dev->coherent_dma_mask &= mask;
         *dev->dma_mask &= mask;
-       /* ...but only set bus mask if we found valid dma-ranges earlier */
-       if (!ret)
-               dev->bus_dma_mask = mask;

+       /*
+        * ...but only set bus mask if we found valid dma-ranges earlier
+        * and also, set the coherent_dma_mask and dma_mask properly
+        * for busses with size more than 32-bit
+        */
+       if (!ret) {
+               dev->bus_dma_mask = mask;
+               if (mask  >= (1ULL << 32)) {
+                       dev->coherent_dma_mask = mask;
+                       *dev->dma_mask = mask;
+               }
+       }
         coherent = of_dma_is_coherent(np);
         dev_dbg(dev, "device is%sdma coherent\n",
                 coherent ? " " : " not ");


>> For the SoC concerned here is based on arm64, the USB IP (64 bit
>> capable) is connected to a 36-bit Data bus and a 32-bit Control bus. The
>> 36-bit Data bus is connected to an IOMMU which translates the address
>> before they are passed on to other blocks. Here we have IOMMU is capable
>> of 40-bit addressing. But as data bus is only capable of 36-bit, we need
>> to ensure that IOMMU translates to address which does not exceed 36-bit.
>>
>> Without this fix we are observing context fault from IOMMU.
>
> Thanks for the clarification.
>
>> Now, to get a workaround to this problem, we are inheriting the
>> bus_dma_mask which is apparently the only one which contains the 36-bit
>> bus mask.
>
> If the bus mask is correctly set to 36 bits, but the DMA API 
> implementation is failing to take that into account and giving you 
> 40-bit DMA addresses, that is a bug in the DMA API implementation, and 
> it needs to be fixed in that DMA API code, not worked around in 
> individual drivers.

There are 2 issues here. First being, the 32-bit limitation for the 
device dma_mask during device registration. You have already suggested 
one approach for this to set from driver itself. IMO, this would require 
another DT node property addition for any individual IP. As same driver 
is being used in another SoC where, it may not need more than 
32-bit/64-bit dma_mask.

For the SoC concerned here, there are multiple IPs which are sharing the 
36-bit DATA bus. If of_dma_configure" takes care of assigning the 
dma_mask properly from "dma-ranges" DT property, it would solve this 
issue and driver's do not need to set this explicitly either via 
hard-coding or through another DT property. For this we suggest code 
snippet as given above.

The second problem is the XHCI overrides dma_mask to 32-bit or 64-bit. 
During the device registration, the DWC3 device get the default 32-bit 
dma_mask. This DWC3 serves as the parent device for XHCI device, which 
also gets 32-bit dma_mask from inception. There are 2 places for the 
xhci-device, where the dma_mask of the xhci-device is explicitly 
modified to either 32-bit or 64-bit.

1) In "drivers/usb/host/xhci-plat.c" we have dma_mask setting as below:

    ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));

2) In "drivers/usb/host/xhci.c" file, here we have code as:

    dma_set_coherent_mask(dev, DMA_BIT_MASK(64));

So, even if the platform sets the dma_mask properly to 36-bit, the xhci 
driver overrides it to 32-bit or 64-bit. This can be fixed in the xhci 
driver by checking if the dma_mask is already getting set in the parent 
driver. For this we have not yet submitted the change, as in this case 
of_dma_configure needs to be fixed first.

However, the proposed solution (current patch) is leveraging 
the dma_mask from bus_dma_mask, which is set from the dma-ranges 
properly, and this case we don't need any changes in of_dma_configure.

> Is this a 32-bit Arm system, by any chance?
>
For the SoC concerned here, it is a 64-bit ARM system, which has many 
IPs connected via the 36-bit DATA bus.

> Robin.
>
>> Or as alternate solution we need to change coherent_dma_mask default
>> mask as DMA_BIT_MASK(64) rather DMA_BIT_MASK(32) so that in
>> of_dma_configure, the dma_mask/coherent_dma_mask get populated from
>> "dma_ranges" DT property during device registration.
>>
>>
>
>
