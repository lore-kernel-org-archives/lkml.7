Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE9EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B71920823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732026AbfCZRhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:37:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726207AbfCZRhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:37:05 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6DBC2A5CFFC6013A8D75;
        Wed, 27 Mar 2019 01:37:01 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.408.0; Wed, 27 Mar 2019
 01:36:50 +0800
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
To:     Geert Uytterhoeven <geert@linux-m68k.org>
References: <20190207193653.18221-1-geert+renesas@glider.be>
 <9966a420-b081-a8ed-7f7b-20d97c9f7996@huawei.com>
 <CAMuHMdUTkPoCoL7jRz2MRRSjLVSrzE4kPx2uMKCKMGfmVayT6A@mail.gmail.com>
CC:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        chenxiang <chenxiang66@hisilicon.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Rob Herring <robh@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <28a3473d-7f80-8b2e-5560-5890359d4b4c@huawei.com>
Date:   Tue, 26 Mar 2019 17:36:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUTkPoCoL7jRz2MRRSjLVSrzE4kPx2uMKCKMGfmVayT6A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2019 12:31, Geert Uytterhoeven wrote:
> Hi John,
>
> CC robh
>
> On Tue, Mar 26, 2019 at 12:42 PM John Garry <john.garry@huawei.com> wrote:
>>> Memory is incorrectly freed using the direct ops, as dma_map_ops = NULL.
>>> Oops...
>>>
>>> After reversing the order of the calls to arch_teardown_dma_ops() and
>>> devres_release_all(), dma_map_ops is still valid, and the DMA memory is
>>> now released using __iommu_free_attrs():
>>>
>>>     +sata_rcar ee300000.sata: dmam_release:32: size 2048 vaddr ffffff8012145000 dma_handle 0x0x00000000fffff000 attrs 0x0
>>>     +sata_rcar ee300000.sata: dma_free_attrs:289: size 2048, ops = iommu_dma_ops
>>>     +sata_rcar ee300000.sata: dma_free_attrs:311: calling __iommu_free_attrs()
>>> ---
>>>  drivers/base/dd.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>>> index 8ac10af17c0043a3..d62487d024559620 100644
>>> --- a/drivers/base/dd.c
>>> +++ b/drivers/base/dd.c
>>> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>>>                       drv->remove(dev);
>>>
>>>               device_links_driver_cleanup(dev);
>>> -             arch_teardown_dma_ops(dev);
>>>
>>>               devres_release_all(dev);
>>> +             arch_teardown_dma_ops(dev);
>>>               dev->driver = NULL;
>>
>> Hi guys,
>>
>> Could there still be the same problem in the error path of really_probe():
>>
>> static int really_probe(struct device *dev, struct device_driver *drv)
>> {
>>
>>         [...]
>>
>>         goto done;
>>
>> probe_failed:
>>         arch_teardown_dma_ops(dev);
>> dma_failed:
>>         if (dev->bus)
>>                 blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>>                                      BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
>> pinctrl_bind_failed:
>>         device_links_no_driver(dev);
>>         devres_release_all(dev);
>>         driver_sysfs_remove(dev);
>>         dev->driver = NULL;
>>         dev_set_drvdata(dev, NULL);
>>
>> We seem to be able to call arch_teardown_dma_ops() prior to
>> devres_release_all() if we reach probe_failed label.
>
> Yes, this looks like another instance of the same problem.
> And test_remove doesn't expose this, as it doesn't exercise the full cycle.
>

Hi Geert,

OK, thanks.

There is another devres_release_all() call in device_release(). Not sure 
if there is another potential problem there also...

As for this issue, I'll look to fix unless anyone else doing it.

Cheers,
John

> Gr{oetje,eeting}s,
>
>                         Geert
>


