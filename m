Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF52C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7542021929
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 13:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389505AbfISNZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 09:25:46 -0400
Received: from foss.arm.com ([217.140.110.172]:58176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388601AbfISNZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 09:25:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11F27337;
        Thu, 19 Sep 2019 06:25:45 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE10C3F67D;
        Thu, 19 Sep 2019 06:25:40 -0700 (PDT)
Subject: Re: arm64 iommu groups issue
To:     John Garry <john.garry@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Cc:     iommu <iommu@lists.linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <4768c541-ebf4-61d5-0c5e-77dee83f8f94@arm.com>
Date:   Thu, 19 Sep 2019 14:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 19/09/2019 09:43, John Garry wrote:
> Hi all,
> 
> We have noticed a special behaviour on our arm64 D05 board when the SMMU 
> is enabled with regards PCI device iommu groups.
> 
> This platform does not support ACS, yet we find that all functions for a 
> PCI device are not grouped together:
> 
> root@ubuntu:/sys# dmesg | grep "Adding to iommu group"
> [    7.307539] hisi_sas_v2_hw HISI0162:01: Adding to iommu group 0
> [   12.590533] hns_dsaf HISI00B2:00: Adding to iommu group 1
> [   13.688527] mlx5_core 000a:11:00.0: Adding to iommu group 2
> [   14.324606] mlx5_core 000a:11:00.1: Adding to iommu group 3
> [   14.937090] ehci-platform PNP0D20:00: Adding to iommu group 4
> [   15.276637] pcieport 0002:f8:00.0: Adding to iommu group 5
> [   15.340845] pcieport 0004:88:00.0: Adding to iommu group 6
> [   15.392098] pcieport 0005:78:00.0: Adding to iommu group 7
> [   15.443356] pcieport 000a:10:00.0: Adding to iommu group 8
> [   15.484975] pcieport 000c:20:00.0: Adding to iommu group 9
> [   15.543647] pcieport 000d:30:00.0: Adding to iommu group 10
> [   15.599771] serial 0002:f9:00.0: Adding to iommu group 5
> [   15.690807] serial 0002:f9:00.1: Adding to iommu group 5
> [   84.322097] mlx5_core 000a:11:00.2: Adding to iommu group 8
> [   84.856408] mlx5_core 000a:11:00.3: Adding to iommu group 8
> 
> root@ubuntu:/sys#  lspci -tv
> lspci -tvv
> -+-[000d:30]---00.0-[31]--
>    +-[000c:20]---00.0-[21]----00.0  Huawei Technologies Co., Ltd.
>    +-[000a:10]---00.0-[11-12]--+-00.0  Mellanox [ConnectX-5]
>    |                           +-00.1  Mellanox [ConnectX-5]
>    |                           +-00.2  Mellanox [ConnectX-5 VF]
>    |                           \-00.3  Mellanox [ConnectX-5 VF]
>    +-[0007:90]---00.0-[91]----00.0  Huawei Technologies Co., ...
>    +-[0006:c0]---00.0-[c1]--
>    +-[0005:78]---00.0-[79]--
>    +-[0004:88]---00.0-[89]--
>    +-[0002:f8]---00.0-[f9]--+-00.0  MosChip Semiconductor Technology ...
>    |                        +-00.1  MosChip Semiconductor Technology ...
>    |                        \-00.2  MosChip Semiconductor Technology ...
>    \-[0000:00]-
> 
> For the PCI devices in question - on port 000a:10:00.0 - you will notice 
> that the port and VFs (000a:11:00.2, 3) are in one group, yet the 2 PFs 
> (000a:11:00.0, 000a:11:00.1) are in separate groups.
> 
> I also notice the same ordering nature on our D06 platform - the 
> pcieport is added to an iommu group after PF for that port. However this 
> platform supports ACS, so not such a problem.
> 
> After some checking, I find that when the pcieport driver probes, the 
> associated SMMU device had not registered yet with the IOMMU framework, 
> so we defer the probe for this device - in iort.c:iort_iommu_xlate(), 
> when no iommu ops are available, we defer.
> 
> Yet, when the mlx5 PF devices probe, the iommu ops are available at this 
> stage. So the probe continues and we get an iommu group for the device - 
> but not the same group as the parent port, as it has not yet been added 
> to a group. When the port eventually probes it gets a new, separate group.
> 
> This all seems to be as the built-in module init ordering is as follows: 
> pcieport drv, smmu drv, mlx5 drv
> 
> I notice that if I build the mlx5 drv as a ko and insert after boot, all 
> functions + pcieport are in the same group:
> 
> [   11.530046] hisi_sas_v2_hw HISI0162:01: Adding to iommu group 0
> [   17.301093] hns_dsaf HISI00B2:00: Adding to iommu group 1
> [   18.743600] ehci-platform PNP0D20:00: Adding to iommu group 2
> [   20.212284] pcieport 0002:f8:00.0: Adding to iommu group 3
> [   20.356303] pcieport 0004:88:00.0: Adding to iommu group 4
> [   20.493337] pcieport 0005:78:00.0: Adding to iommu group 5
> [   20.702999] pcieport 000a:10:00.0: Adding to iommu group 6
> [   20.859183] pcieport 000c:20:00.0: Adding to iommu group 7
> [   20.996140] pcieport 000d:30:00.0: Adding to iommu group 8
> [   21.152637] serial 0002:f9:00.0: Adding to iommu group 3
> [   21.346991] serial 0002:f9:00.1: Adding to iommu group 3
> [  100.754306] mlx5_core 000a:11:00.0: Adding to iommu group 6
> [  101.420156] mlx5_core 000a:11:00.1: Adding to iommu group 6
> [  292.481714] mlx5_core 000a:11:00.2: Adding to iommu group 6
> [  293.281061] mlx5_core 000a:11:00.3: Adding to iommu group 6
> 
> This does seem like a problem for arm64 platforms which don't support 
> ACS, yet enable an SMMU. Maybe also a problem even if they do support ACS.
> 
> Opinion?

Yeah, this is less than ideal. One way to bodge it might be to make 
pci_device_group() also walk downwards to see if any non-ACS-isolated 
children already have a group, rather than assuming that groups get 
allocated in hierarchical order, but that's far from ideal.

The underlying issue is that, for historical reasons, OF/IORT-based 
IOMMU drivers have ended up with group allocation being tied to endpoint 
driver probing via the dma_configure() mechanism (long story short, 
driver probe is the only thing which can be delayed in order to wait for 
a specific IOMMU instance to be ready). However, in the meantime, the 
IOMMU API internals have evolved sufficiently that I think there's a way 
to really put things right - I have the spark of an idea which I'll try 
to sketch out ASAP...

Robin.
