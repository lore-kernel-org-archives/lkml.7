Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE2BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBC220882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 14:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732587AbfISOf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 10:35:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36086 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732009AbfISOf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 10:35:27 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D07CF8849E71097B62BE;
        Thu, 19 Sep 2019 22:35:25 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Sep 2019
 22:35:16 +0800
From:   John Garry <john.garry@huawei.com>
Subject: Re: arm64 iommu groups issue
To:     Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        "Will Deacon" <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
 <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
CC:     iommu <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
Date:   Thu, 19 Sep 2019 15:35:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/09/2019 14:25, Robin Murphy wrote:
>> When the port eventually probes it gets a new, separate group.
>>
>> This all seems to be as the built-in module init ordering is as
>> follows: pcieport drv, smmu drv, mlx5 drv
>>
>> I notice that if I build the mlx5 drv as a ko and insert after boot,
>> all functions + pcieport are in the same group:
>>
>> [   11.530046] hisi_sas_v2_hw HISI0162:01: Adding to iommu group 0
>> [   17.301093] hns_dsaf HISI00B2:00: Adding to iommu group 1
>> [   18.743600] ehci-platform PNP0D20:00: Adding to iommu group 2
>> [   20.212284] pcieport 0002:f8:00.0: Adding to iommu group 3
>> [   20.356303] pcieport 0004:88:00.0: Adding to iommu group 4
>> [   20.493337] pcieport 0005:78:00.0: Adding to iommu group 5
>> [   20.702999] pcieport 000a:10:00.0: Adding to iommu group 6
>> [   20.859183] pcieport 000c:20:00.0: Adding to iommu group 7
>> [   20.996140] pcieport 000d:30:00.0: Adding to iommu group 8
>> [   21.152637] serial 0002:f9:00.0: Adding to iommu group 3
>> [   21.346991] serial 0002:f9:00.1: Adding to iommu group 3
>> [  100.754306] mlx5_core 000a:11:00.0: Adding to iommu group 6
>> [  101.420156] mlx5_core 000a:11:00.1: Adding to iommu group 6
>> [  292.481714] mlx5_core 000a:11:00.2: Adding to iommu group 6
>> [  293.281061] mlx5_core 000a:11:00.3: Adding to iommu group 6
>>
>> This does seem like a problem for arm64 platforms which don't support
>> ACS, yet enable an SMMU. Maybe also a problem even if they do support
>> ACS.
>>
>> Opinion?
>

Hi Robin,

> Yeah, this is less than ideal.

For sure. Our production D05 boards don't ship with the SMMU enabled in 
BIOS, but it would be slightly concerning in this regard if they did.

 > One way to bodge it might be to make
> pci_device_group() also walk downwards to see if any non-ACS-isolated
> children already have a group, rather than assuming that groups get
> allocated in hierarchical order, but that's far from ideal.

Agree.

My own workaround was to hack the mentioned iort code to defer the PF 
probe if the parent port had also yet to probe.

>
> The underlying issue is that, for historical reasons, OF/IORT-based
> IOMMU drivers have ended up with group allocation being tied to endpoint
> driver probing via the dma_configure() mechanism (long story short,
> driver probe is the only thing which can be delayed in order to wait for
> a specific IOMMU instance to be ready).However, in the meantime, the
> IOMMU API internals have evolved sufficiently that I think there's a way
> to really put things right - I have the spark of an idea which I'll try
> to sketch out ASAP...
>

OK, great.

Thanks,
John

> Robin.


