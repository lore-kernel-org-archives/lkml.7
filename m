Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD51C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C67821928
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731873AbfISIn5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:43:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36604 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbfISIn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:43:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9B68A7CD0F122A9A5390;
        Thu, 19 Sep 2019 16:43:51 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.179) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Thu, 19 Sep 2019
 16:43:44 +0800
From:   John Garry <john.garry@huawei.com>
Subject: arm64 iommu groups issue
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com>
Date:   Thu, 19 Sep 2019 09:43:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We have noticed a special behaviour on our arm64 D05 board when the SMMU 
is enabled with regards PCI device iommu groups.

This platform does not support ACS, yet we find that all functions for a 
PCI device are not grouped together:

root@ubuntu:/sys# dmesg | grep "Adding to iommu group"
[    7.307539] hisi_sas_v2_hw HISI0162:01: Adding to iommu group 0
[   12.590533] hns_dsaf HISI00B2:00: Adding to iommu group 1
[   13.688527] mlx5_core 000a:11:00.0: Adding to iommu group 2
[   14.324606] mlx5_core 000a:11:00.1: Adding to iommu group 3
[   14.937090] ehci-platform PNP0D20:00: Adding to iommu group 4
[   15.276637] pcieport 0002:f8:00.0: Adding to iommu group 5
[   15.340845] pcieport 0004:88:00.0: Adding to iommu group 6
[   15.392098] pcieport 0005:78:00.0: Adding to iommu group 7
[   15.443356] pcieport 000a:10:00.0: Adding to iommu group 8
[   15.484975] pcieport 000c:20:00.0: Adding to iommu group 9
[   15.543647] pcieport 000d:30:00.0: Adding to iommu group 10
[   15.599771] serial 0002:f9:00.0: Adding to iommu group 5
[   15.690807] serial 0002:f9:00.1: Adding to iommu group 5
[   84.322097] mlx5_core 000a:11:00.2: Adding to iommu group 8
[   84.856408] mlx5_core 000a:11:00.3: Adding to iommu group 8

root@ubuntu:/sys#  lspci -tv
lspci -tvv
-+-[000d:30]---00.0-[31]--
   +-[000c:20]---00.0-[21]----00.0  Huawei Technologies Co., Ltd.
   +-[000a:10]---00.0-[11-12]--+-00.0  Mellanox [ConnectX-5]
   |                           +-00.1  Mellanox [ConnectX-5]
   |                           +-00.2  Mellanox [ConnectX-5 VF]
   |                           \-00.3  Mellanox [ConnectX-5 VF]
   +-[0007:90]---00.0-[91]----00.0  Huawei Technologies Co., ...
   +-[0006:c0]---00.0-[c1]--
   +-[0005:78]---00.0-[79]--
   +-[0004:88]---00.0-[89]--
   +-[0002:f8]---00.0-[f9]--+-00.0  MosChip Semiconductor Technology ...
   |                        +-00.1  MosChip Semiconductor Technology ...
   |                        \-00.2  MosChip Semiconductor Technology ...
   \-[0000:00]-

For the PCI devices in question - on port 000a:10:00.0 - you will notice 
that the port and VFs (000a:11:00.2, 3) are in one group, yet the 2 PFs 
(000a:11:00.0, 000a:11:00.1) are in separate groups.

I also notice the same ordering nature on our D06 platform - the 
pcieport is added to an iommu group after PF for that port. However this 
platform supports ACS, so not such a problem.

After some checking, I find that when the pcieport driver probes, the 
associated SMMU device had not registered yet with the IOMMU framework, 
so we defer the probe for this device - in iort.c:iort_iommu_xlate(), 
when no iommu ops are available, we defer.

Yet, when the mlx5 PF devices probe, the iommu ops are available at this 
stage. So the probe continues and we get an iommu group for the device - 
but not the same group as the parent port, as it has not yet been added 
to a group. When the port eventually probes it gets a new, separate group.

This all seems to be as the built-in module init ordering is as follows: 
pcieport drv, smmu drv, mlx5 drv

I notice that if I build the mlx5 drv as a ko and insert after boot, all 
functions + pcieport are in the same group:

[   11.530046] hisi_sas_v2_hw HISI0162:01: Adding to iommu group 0
[   17.301093] hns_dsaf HISI00B2:00: Adding to iommu group 1
[   18.743600] ehci-platform PNP0D20:00: Adding to iommu group 2
[   20.212284] pcieport 0002:f8:00.0: Adding to iommu group 3
[   20.356303] pcieport 0004:88:00.0: Adding to iommu group 4
[   20.493337] pcieport 0005:78:00.0: Adding to iommu group 5
[   20.702999] pcieport 000a:10:00.0: Adding to iommu group 6
[   20.859183] pcieport 000c:20:00.0: Adding to iommu group 7
[   20.996140] pcieport 000d:30:00.0: Adding to iommu group 8
[   21.152637] serial 0002:f9:00.0: Adding to iommu group 3
[   21.346991] serial 0002:f9:00.1: Adding to iommu group 3
[  100.754306] mlx5_core 000a:11:00.0: Adding to iommu group 6
[  101.420156] mlx5_core 000a:11:00.1: Adding to iommu group 6
[  292.481714] mlx5_core 000a:11:00.2: Adding to iommu group 6
[  293.281061] mlx5_core 000a:11:00.3: Adding to iommu group 6

This does seem like a problem for arm64 platforms which don't support 
ACS, yet enable an SMMU. Maybe also a problem even if they do support ACS.

Opinion?

Thanks,
John

