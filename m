Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C1CDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F2F2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfKDMSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:18:04 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2069 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727454AbfKDMSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:18:04 -0500
Received: from lhreml703-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 10DD0AD4A230D753F85C;
        Mon,  4 Nov 2019 12:18:03 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml703-cah.china.huawei.com (10.201.108.44) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 4 Nov 2019 12:18:02 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Mon, 4 Nov 2019
 12:18:02 +0000
Subject: Re: arm64 iommu groups issue
From:   John Garry <john.garry@huawei.com>
To:     Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>,
        "Will Deacon" <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
CC:     iommu <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Saravana Kannan" <saravanak@google.com>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
 <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
 <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
Message-ID: <abea92b0-7e6c-a3c8-fef3-bc8aabe93436@huawei.com>
Date:   Mon, 4 Nov 2019 12:18:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a18b7f26-9713-a5c7-507e-ed70e40bc007@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+

On 19/09/2019 15:35, John Garry wrote:
> On 19/09/2019 14:25, Robin Murphy wrote:
>>> When the port eventually probes it gets a new, separate group.
>>>
>>> This all seems to be as the built-in module init ordering is as
>>> follows: pcieport drv, smmu drv, mlx5 drv
>>>
>>> I notice that if I build the mlx5 drv as a ko and insert after boot,
>>> all functions + pcieport are in the same group:
>>>
>>> [   11.530046] hisi_sas_v2_hw HISI0162:01: Adding to iommu group 0
>>> [   17.301093] hns_dsaf HISI00B2:00: Adding to iommu group 1
>>> [   18.743600] ehci-platform PNP0D20:00: Adding to iommu group 2
>>> [   20.212284] pcieport 0002:f8:00.0: Adding to iommu group 3
>>> [   20.356303] pcieport 0004:88:00.0: Adding to iommu group 4
>>> [   20.493337] pcieport 0005:78:00.0: Adding to iommu group 5
>>> [   20.702999] pcieport 000a:10:00.0: Adding to iommu group 6
>>> [   20.859183] pcieport 000c:20:00.0: Adding to iommu group 7
>>> [   20.996140] pcieport 000d:30:00.0: Adding to iommu group 8
>>> [   21.152637] serial 0002:f9:00.0: Adding to iommu group 3
>>> [   21.346991] serial 0002:f9:00.1: Adding to iommu group 3
>>> [  100.754306] mlx5_core 000a:11:00.0: Adding to iommu group 6
>>> [  101.420156] mlx5_core 000a:11:00.1: Adding to iommu group 6
>>> [  292.481714] mlx5_core 000a:11:00.2: Adding to iommu group 6
>>> [  293.281061] mlx5_core 000a:11:00.3: Adding to iommu group 6
>>>
>>> This does seem like a problem for arm64 platforms which don't support
>>> ACS, yet enable an SMMU. Maybe also a problem even if they do support
>>> ACS.
>>>
>>> Opinion?
>>
> 
> Hi Robin,
> 
>> Yeah, this is less than ideal.
> 
> For sure. Our production D05 boards don't ship with the SMMU enabled in 
> BIOS, but it would be slightly concerning in this regard if they did.
> 
>  > One way to bodge it might be to make
>> pci_device_group() also walk downwards to see if any non-ACS-isolated
>> children already have a group, rather than assuming that groups get
>> allocated in hierarchical order, but that's far from ideal.
> 
> Agree.
> 
> My own workaround was to hack the mentioned iort code to defer the PF 
> probe if the parent port had also yet to probe.
> 
>>
>> The underlying issue is that, for historical reasons, OF/IORT-based
>> IOMMU drivers have ended up with group allocation being tied to endpoint
>> driver probing via the dma_configure() mechanism (long story short,
>> driver probe is the only thing which can be delayed in order to wait for
>> a specific IOMMU instance to be ready).However, in the meantime, the
>> IOMMU API internals have evolved sufficiently that I think there's a way
>> to really put things right - I have the spark of an idea which I'll try
>> to sketch out ASAP...
>>
> 
> OK, great.
> 
> Thanks,
> John
> 
>> Robin.
> 

