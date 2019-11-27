Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319C9C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33B82071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfK0LlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:41:17 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726526AbfK0LlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:41:16 -0500
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id F1E2FAE9F64A5FC6087E;
        Wed, 27 Nov 2019 11:41:13 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 27 Nov 2019 11:41:10 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 11:41:11 +0000
Subject: Re: [PATCH v3 09/14] iommu/arm-smmu: Prevent forced unbinding of Arm
 SMMU drivers
From:   John Garry <john.garry@huawei.com>
To:     Saravana Kannan <saravanak@google.com>
CC:     <iommu@lists.linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Will Deacon <will@kernel.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20191121114918.2293-1-will@kernel.org>
 <20191121114918.2293-10-will@kernel.org>
 <5c91d467-5e59-482b-8f4f-e0cfa3db9028@huawei.com>
 <CAGETcx8Hkta6scFdiG=eQypsQ--jrR1YisaOQATCbMiu+aG8sg@mail.gmail.com>
 <af1dc92a-ca98-fb22-835f-5ceb85e86b1b@huawei.com>
Message-ID: <c8eb97b1-dab5-cc25-7669-2819f64a885d@huawei.com>
Date:   Wed, 27 Nov 2019 11:41:10 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <af1dc92a-ca98-fb22-835f-5ceb85e86b1b@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2019 11:04, John Garry wrote:
> On 26/11/2019 20:27, Saravana Kannan wrote:
>> On Tue, Nov 26, 2019 at 1:13 AM John Garry <john.garry@huawei.com> wrote:
>>>
>>> On 21/11/2019 11:49, Will Deacon wrote:
>>>> Forcefully unbinding the Arm SMMU drivers is a pretty dangerous 
>>>> operation,
>>>> since it will likely lead to catastrophic failure for any DMA devices
>>>> mastering through the SMMU being unbound. When the driver then attempts
>>>> to "handle" the fatal faults, it's very easy to trip over dead data
>>>> structures, leading to use-after-free.
>>>>
>>>> On John's machine, he reports that the machine was "unusable" due to
>>>> loss of the storage controller following a forced unbind of the SMMUv3
>>>> driver:
>>>>
>>>>     | # cd ./bus/platform/drivers/arm-smmu-v3
>>>>     | # echo arm-smmu-v3.0.auto > unbind
>>>>     | hisi_sas_v2_hw HISI0162:01: CQE_AXI_W_ERR (0x800) found!
>>>>     | platform arm-smmu-v3.0.auto: CMD_SYNC timeout at 0x00000146
>>>>     | [hwprod 0x00000146, hwcons 0x00000000]
>>>>
>>>> Prevent this forced unbinding of the drivers by setting 
>>>> "suppress_bind_attrs"
>>>> to true.
>>>
>>> This seems a reasonable approach for now.
>>>
>>> BTW, I'll give this series a spin this week, which again looks to be
>>> your iommu/module branch, excluding the new IORT patch.
>>
> 
> Hi Saravana,
> 
>> Is this on a platform where of_devlink creates device links between
>> the iommu device and its suppliers?I'm guessing no? Because device
>> links should for unbinding of all the consumers before unbinding the
>> supplier.
> 
> I'm only really interested in ACPI, TBH.
> 
>>
>> Looks like it'll still allow the supplier to unbind if the consumers
>> don't allow unbinding. Is that the case here?
> 
> So just unbinding the driver from a device does not delete the device 
> nor exit the device from it's IOMMU group - so we keep the reference to 
> the SMMU ko. As such, I don't know how to realistically test unloading 
> the SMMU ko when we have platform devices involved. Maybe someone can 
> enlighten me...

But I could do it on our D06 dev board, where all devices behind the 
SMMUs are PCI based:

--- Initial state ---

root@(none)$ dmesg | grep Adding
[   30.271801] pcieport 0000:00:00.0: Adding to iommu group 0
[   30.296088] pcieport 0000:00:04.0: Adding to iommu group 1
[   30.322234] pcieport 0000:00:08.0: Adding to iommu group 2
[   30.335641] pcieport 0000:00:0c.0: Adding to iommu group 3
[   30.343114] pcieport 0000:00:10.0: Adding to iommu group 4
[   30.355650] pcieport 0000:00:12.0: Adding to iommu group 5
[   30.366794] pcieport 0000:7c:00.0: Adding to iommu group 6
[   30.377993] hns3 0000:7d:00.0: Adding to iommu group 7
[   31.861957] hns3 0000:7d:00.1: Adding to iommu group 8
[   33.313967] hns3 0000:7d:00.2: Adding to iommu group 9
[   33.436029] hns3 0000:7d:00.3: Adding to iommu group 10
[   33.555935] hns3 0000:bd:00.0: Adding to iommu group 11
[   35.143851] pcieport 0000:74:00.0: Adding to iommu group 12
[   35.150736] pcieport 0000:80:00.0: Adding to iommu group 13
[   35.158910] pcieport 0000:80:08.0: Adding to iommu group 14
[   35.166860] pcieport 0000:80:0c.0: Adding to iommu group 15
[   35.174813] pcieport 0000:80:10.0: Adding to iommu group 16
[   35.182854] pcieport 0000:bc:00.0: Adding to iommu group 17
[   35.189702] pcieport 0000:b4:00.0: Adding to iommu group 18
[   35.196445] hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 19
[   39.410693] ahci 0000:74:03.0: Adding to iommu group 20
root@(none)$ lsmod
     Not tainted
arm_smmu_v3 40960 21 - Live 0xffff800008c60000

--- Start removing devices ---

root@(none)$  echo 1 > ./sys/devices/pci0000:00/0000:00:00.0/remove
[   55.567808] pci_bus 0000:01: busn_res: [bus 01] is released
[   55.573514] pci 0000:00:00.0: Removing from iommu group 0
root@(none)$  echo 1 > ./sys/devices/pci0000:00/0000:00:04.0/remove
[   61.767425] pci_bus 0000:02: busn_res: [bus 02] is released
[   61.773132] pci 0000:00:04.0: Removing from iommu group 1
root@(none)$ echo 1 > ./sys/devices/pci0000:00/0000:00:04.0/remove
sh: ./sys/devices/pci0000:00/0000:00:04.0/remove: No such file or directory
root@(none)$  echo 1 > ./sys/devices/pci0000:00/0000:00:08.0/remove
[   75.635417] pci_bus 0000:03: busn_res: [bus 03] is released
[   75.641124] pci 0000:00:08.0: Removing from iommu group 2
root@(none)$ echo 1 > ./sys/devices/pci0000:00/0000:00:0c.0/remove
[   81.587419] pci_bus 0000:04: busn_res: [bus 04] is released
[   81.593110] pci 0000:00:0c.0: Removing from iommu group 3
root@(none)$  echo 1 > ./sys/devices/pci0000:00/0000:00:10.0/remove
[   85.607605] pci_bus 0000:05: busn_res: [bus 05] is released
[   85.613300] pci 0000:00:10.0: Removing from iommu group 4
root@(none)$ echo 1 > ./sys/devices/pci0000:00/0000:00:12.0/remove
[   92.731421] pci_bus 0000:06: busn_res: [bus 06] is released
[   92.737125] pci 0000:00:12.0: Removing from iommu group 5
root@(none)$ echo 1 > ./sys/devices/pci0000:7c/0000:7c:00.0/remove
[  102.286726] pci 0000:7d:00.0: Removing from iommu group 7
[  102.294157] pci 0000:7d:00.1: Removing from iommu group 8
[  102.301634] pci 0000:7d:00.2: Removing from iommu group 9
[  102.308973] pci 0000:7d:00.3: Removing from iommu group 10
[  102.316578] pci_bus 0000:7d: busn_res: [bus 7d] is released
[  102.322282] pci 0000:7c:00.0: Removing from iommu group 6
root@(none)$ echo 1 > ./sys/devices/pci0000:74/0000:74:00.0/remove
[  108.047590] pci_bus 0000:75: busn_res: [bus 75] is released
[  108.053278] pci 0000:74:00.0: Removing from iommu group 12
root@(none)$ echo 1 > ./sys/devices/pci0000:80/0000:80:00.0/remove
[  112.283590] pci_bus 0000:81: busn_res: [bus 81] is released
[  112.289293] pci 0000:80:00.0: Removing from iommu group 13
root@(none)$ echo 1 > ./sys/devices/pci0000:80/0000:80:0c.0/remove
[  117.975427] pci_bus 0000:83: busn_res: [bus 83] is released
[  117.981126] pci 0000:80:0c.0: Removing from iommu group 15
root@(none)$ echo 1 > ./sys/devices/pci0000:80/0000:80:10.0/remove
[  123.935417] pci_bus 0000:84: busn_res: [bus 84] is released
[  123.941115] pci 0000:80:10.0: Removing from iommu group 16
root@(none)$ echo 1 > ./sys/devices/pci0000:bc/0000:bc:00.0/remove
[  129.855959] pci 0000:bd:00.0: Removing from iommu group 11
[  129.863316] pci_bus 0000:bd: busn_res: [bus bd] is released
[  129.869345] pci 0000:bc:00.0: Removing from iommu group 17
root@(none)$ echo 1 > ./sys/devices/pci0000:b4/0000:b4:00.0/remove
[  137.235535] pci_bus 0000:b5: busn_res: [bus b5] is released
[  137.241222] pci 0000:b4:00.0: Removing from iommu group 18
root@(none)$ echo 1 > ./sys/devices/pci0000:74/0000:74:02.0/remove
[  145.984795] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  145.991313] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  145.997853] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  146.004364] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  146.010921] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  146.017455] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  146.023921] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  146.029948] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] is gone
[  146.036768] sd 0:0:3:0: [sdd] Synchronizing SCSI cache
[  146.112158] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] is gone
[  146.118977] sd 0:0:2:0: [sdc] Synchronizing SCSI cache
[  146.124208] sd 0:0:2:0: [sdc] Stopping disk
[  146.660144] hisi_sas_v3_hw 0000:74:02.0: dev[4:5] is gone
[  146.666978] sd 0:0:1:0: [sdb] Synchronizing SCSI cache
[  146.744078] hisi_sas_v3_hw 0000:74:02.0: dev[3:1] is gone
[  146.750762] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  146.808170] hisi_sas_v3_hw 0000:74:02.0: dev[2:1] is gone
[  146.816723] hisi_sas_v3_hw 0000:74:02.0: dev[1:2] is gone
[  146.887746] pci 0000:74:02.0: Removing from iommu group 19
root@(none)$ echo 1 > ./sys/bus/pci/devices/0000:74:03.0/remove
[  156.443637] pci 0000:74:03.0: Removing from iommu group 20
root@(none)$ echo 1 > ./sys/bus/pci/devices/0000:80:08.0/remove
[  165.199447] pci_bus 0000:82: busn_res: [bus 82] is released
[  165.205166] pci 0000:80:08.0: Removing from iommu group 14

--- All devices removed, so can unload ko ---

root@(none)$ lsmod
     Not tainted
arm_smmu_v3 40960 0 - Live 0xffff800008c60000
root@(none)$ rmmod arm_smmu_v3
root@(none)$ lsmod
     Not tainted

--- Bring it back to life ---

root@(none)$ echo 1 > sys/bus/pci/rescan
[  257.639436] pci 0000:00:00.0: [19e5:a120] type 01 class 0x060400
[  257.645608] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[  257.652419] pci 0000:00:04.0: [19e5:a120] type 01 class 0x060400
[  257.658505] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[  257.665228] pci 0000:00:08.0: [19e5:a120] type 01 class 0x060400
[  257.671316] pci 0000:00:08.0: PME# supported from D0 D1 D2 D3hot D3cold
[  257.678030] pci 0000:00:0c.0: [19e5:a120] type 01 class 0x060400
[  257.684113] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[  257.690833] pci 0000:00:10.0: [19e5:a120] type 01 class 0x060400
[  257.696915] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[  257.703623] pci 0000:00:12.0: [19e5:a120] type 01 class 0x060400
[  257.709704] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
[  257.716473] pci 0000:01:00.0: [8086:10fb] type 00 class 0x020000
[  257.722489] pci 0000:01:00.0: reg 0x10: [mem 
0x80000000000-0x8000007ffff 64bit pref]
[  257.730224] pci 0000:01:00.0: reg 0x18: [io  0x1000-0x101f]
[  257.735796] pci 0000:01:00.0: reg 0x20: [mem 
0x80000100000-0x80000103fff 64bit pref]
[  257.743531] pci 0000:01:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[  257.750311] pci 0000:01:00.0: PME# supported from D0 D3hot
[  257.755813] pci 0000:01:00.0: reg 0x184: [mem 
0x80000104000-0x80000107fff 64bit pref]
[  257.763636] pci 0000:01:00.0: VF(n) BAR0 space: [mem 
0x80000104000-0x80000203fff 64bit pref] (contains BAR0 for 64 VFs)
[  257.774416] pci 0000:01:00.0: reg 0x190: [mem 
0x80000204000-0x80000207fff 64bit pref]
[  257.782234] pci 0000:01:00.0: VF(n) BAR3 space: [mem 
0x80000204000-0x80000303fff 64bit pref] (contains BAR3 for 64 VFs)
[  257.793278] pci 0000:01:00.1: [8086:10fb] type 00 class 0x020000
[  257.799293] pci 0000:01:00.1: reg 0x10: [mem 
0x80000080000-0x800000fffff 64bit pref]
[  257.807028] pci 0000:01:00.1: reg 0x18: [io  0x1020-0x103f]
[  257.812600] pci 0000:01:00.1: reg 0x20: [mem 
0x80000304000-0x80000307fff 64bit pref]
[  257.820335] pci 0000:01:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[  257.827114] pci 0000:01:00.1: PME# supported from D0 D3hot
[  257.832612] pci 0000:01:00.1: reg 0x184: [mem 
0x80000308000-0x8000030bfff 64bit pref]
[  257.840431] pci 0000:01:00.1: VF(n) BAR0 space: [mem 
0x80000308000-0x80000407fff 64bit pref] (contains BAR0 for 64 VFs)
[  257.851211] pci 0000:01:00.1: reg 0x190: [mem 
0x80000408000-0x8000040bfff 64bit pref]
[  257.859030] pci 0000:01:00.1: VF(n) BAR3 space: [mem 
0x80000408000-0x80000507fff 64bit pref] (contains BAR3 for 64 VFs)
[  257.870270] pci 0000:05:00.0: [19e5:1711] type 00 class 0x030000
[  257.876296] pci 0000:05:00.0: reg 0x10: [mem 0xe0000000-0xe1ffffff pref]
[  257.882997] pci 0000:05:00.0: reg 0x14: [mem 0xe2000000-0xe21fffff]
[  257.889436] pci 0000:05:00.0: supports D1
[  257.893435] pci 0000:05:00.0: PME# supported from D0 D1 D3hot
[  257.899282] pci 0000:05:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[  257.907716] pci 0000:00:00.0: bridge window [mem 
0x00100000-0x002fffff 64bit pref] to [bus 01] add_size 400000 add_align 
100000
[  257.919192] pci 0000:00:10.0: BAR 14: assigned [mem 
0xe0000000-0xe2ffffff]
[  257.926056] pci 0000:00:00.0: BAR 14: assigned [mem 
0xe3000000-0xe30fffff]
[  257.932920] pci 0000:00:00.0: BAR 15: assigned [mem 
0x80000000000-0x800005fffff 64bit pref]
[  257.941259] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[  257.947438] pci 0000:01:00.0: BAR 0: assigned [mem 
0x80000000000-0x8000007ffff 64bit pref]
[  257.955697] pci 0000:01:00.0: BAR 6: assigned [mem 
0xe3000000-0xe307ffff pref]
[  257.962911] pci 0000:01:00.1: BAR 0: assigned [mem 
0x80000080000-0x800000fffff 64bit pref]
[  257.971168] pci 0000:01:00.1: BAR 6: assigned [mem 
0xe3080000-0xe30fffff pref]
[  257.978378] pci 0000:01:00.0: BAR 4: assigned [mem 
0x80000100000-0x80000103fff 64bit pref]
[  257.986636] pci 0000:01:00.0: BAR 7: assigned [mem 
0x80000104000-0x80000203fff 64bit pref]
[  257.994891] pci 0000:01:00.0: BAR 10: assigned [mem 
0x80000204000-0x80000303fff 64bit pref]
[  258.003232] pci 0000:01:00.1: BAR 4: assigned [mem 
0x80000304000-0x80000307fff 64bit pref]
[  258.011490] pci 0000:01:00.1: BAR 7: assigned [mem 
0x80000308000-0x80000407fff 64bit pref]
[  258.019744] pci 0000:01:00.1: BAR 10: assigned [mem 
0x80000408000-0x80000507fff 64bit pref]
[  258.028085] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[  258.034169] pci 0000:01:00.1: BAR 2: assigned [io  0x1020-0x103f]
[  258.040254] pci 0000:00:00.0: PCI bridge to [bus 01]
[  258.045208] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[  258.051291] pci 0000:00:00.0:   bridge window [mem 0xe3000000-0xe30fffff]
[  258.058068] pci 0000:00:00.0:   bridge window [mem 
0x80000000000-0x800005fffff 64bit pref]
[  258.066326] pci 0000:00:04.0: PCI bridge to [bus 02]
[  258.071284] pci 0000:00:08.0: PCI bridge to [bus 03]
[  258.076241] pci 0000:00:0c.0: PCI bridge to [bus 04]
[  258.081199] pci 0000:05:00.0: BAR 0: assigned [mem 
0xe0000000-0xe1ffffff pref]
[  258.088413] pci 0000:05:00.0: BAR 1: assigned [mem 0xe2000000-0xe21fffff]
[  258.095193] pci 0000:00:10.0: PCI bridge to [bus 05]
[  258.100148] pci 0000:00:10.0:   bridge window [mem 0xe0000000-0xe2ffffff]
[  258.106927] pci 0000:00:12.0: PCI bridge to [bus 06]
[  258.112271] pci 0000:7c:00.0: [19e5:a121] type 01 class 0x060400
[  258.118281] pci 0000:7c:00.0: enabling Extended Tags
[  258.123394] pci 0000:7d:00.0: [19e5:a222] type 00 class 0x020000
[  258.129397] pci 0000:7d:00.0: reg 0x10: [mem 0x122000000-0x12200ffff 
64bit pref]
[  258.136784] pci 0000:7d:00.0: reg 0x18: [mem 0x120000000-0x1200fffff 
64bit pref]
[  258.144202] pci 0000:7d:00.0: reg 0x224: [mem 0x122010000-0x12201ffff 
64bit pref]
[  258.151674] pci 0000:7d:00.0: VF(n) BAR0 space: [mem 
0x122010000-0x1220effff 64bit pref] (contains BAR0 for 14 VFs)
[  258.162100] pci 0000:7d:00.0: reg 0x22c: [mem 0x120100000-0x1201fffff 
64bit pref]
[  258.169575] pci 0000:7d:00.0: VF(n) BAR2 space: [mem 
0x120100000-0x120efffff 64bit pref] (contains BAR2 for 14 VFs)
[  258.180089] pci 0000:7d:00.1: [19e5:a222] type 00 class 0x020000
[  258.186091] pci 0000:7d:00.1: reg 0x10: [mem 0x1220f0000-0x1220fffff 
64bit pref]
[  258.193478] pci 0000:7d:00.1: reg 0x18: [mem 0x120f00000-0x120ffffff 
64bit pref]
[  258.200891] pci 0000:7d:00.1: reg 0x224: [mem 0x122100000-0x12210ffff 
64bit pref]
[  258.208362] pci 0000:7d:00.1: VF(n) BAR0 space: [mem 
0x122100000-0x1221dffff 64bit pref] (contains BAR0 for 14 VFs)
[  258.218787] pci 0000:7d:00.1: reg 0x22c: [mem 0x121000000-0x1210fffff 
64bit pref]
[  258.226257] pci 0000:7d:00.1: VF(n) BAR2 space: [mem 
0x121000000-0x121dfffff 64bit pref] (contains BAR2 for 14 VFs)
[  258.236777] pci 0000:7d:00.2: [19e5:a222] type 00 class 0x020000
[  258.242780] pci 0000:7d:00.2: reg 0x10: [mem 0x1221e0000-0x1221effff 
64bit pref]
[  258.250167] pci 0000:7d:00.2: reg 0x18: [mem 0x121e00000-0x121efffff 
64bit pref]
[  258.257638] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
[  258.263644] pci 0000:7d:00.3: reg 0x10: [mem 0x1221f0000-0x1221fffff 
64bit pref]
[  258.271031] pci 0000:7d:00.3: reg 0x18: [mem 0x121f00000-0x121ffffff 
64bit pref]
[  258.278506] pci 0000:7c:00.0: bridge window [mem 
0x00100000-0x005fffff 64bit pref] to [bus 7d] add_size 1d00000 add_align 
100000
[  258.290060] pci 0000:7c:00.0: BAR 15: assigned [mem 
0x120000000-0x1221fffff 64bit pref]
[  258.298062] pci 0000:7d:00.0: BAR 2: assigned [mem 
0x120000000-0x1200fffff 64bit pref]
[  258.305969] pci 0000:7d:00.0: BAR 9: assigned [mem 
0x120100000-0x120efffff 64bit pref]
[  258.313874] pci 0000:7d:00.1: BAR 2: assigned [mem 
0x120f00000-0x120ffffff 64bit pref]
[  258.321781] pci 0000:7d:00.1: BAR 9: assigned [mem 
0x121000000-0x121dfffff 64bit pref]
[  258.329687] pci 0000:7d:00.2: BAR 2: assigned [mem 
0x121e00000-0x121efffff 64bit pref]
[  258.337594] pci 0000:7d:00.3: BAR 2: assigned [mem 
0x121f00000-0x121ffffff 64bit pref]
[  258.345500] pci 0000:7d:00.0: BAR 0: assigned [mem 
0x122000000-0x12200ffff 64bit pref]
[  258.353407] pci 0000:7d:00.0: BAR 7: assigned [mem 
0x122010000-0x1220effff 64bit pref]
[  258.361313] pci 0000:7d:00.1: BAR 0: assigned [mem 
0x1220f0000-0x1220fffff 64bit pref]
[  258.369222] pci 0000:7d:00.1: BAR 7: assigned [mem 
0x122100000-0x1221dffff 64bit pref]
[  258.377128] pci 0000:7d:00.2: BAR 0: assigned [mem 
0x1221e0000-0x1221effff 64bit pref]
[  258.385035] pci 0000:7d:00.3: BAR 0: assigned [mem 
0x1221f0000-0x1221fffff 64bit pref]
[  258.392948] pci 0000:7c:00.0: PCI bridge to [bus 7d]
[  258.397903] pci 0000:7c:00.0:   bridge window [mem 
0x120000000-0x1221fffff 64bit pref]
[  258.405964] pci 0000:74:00.0: [19e5:a121] type 01 class 0x060400
[  258.411974] pci 0000:74:00.0: enabling Extended Tags
[  258.417017] pci 0000:74:02.0: [19e5:a230] type 00 class 0x010700
[  258.423029] pci 0000:74:02.0: reg 0x24: [mem 0xa2000000-0xa2007fff]
[  258.429477] pci 0000:74:03.0: [19e5:a235] type 00 class 0x010601
[  258.435489] pci 0000:74:03.0: reg 0x24: [mem 0xa2008000-0xa2008fff]
[  258.441881] pci 0000:75:00.0: [19e5:a250] type 00 class 0x120000
[  258.447887] pci 0000:75:00.0: reg 0x18: [mem 0x144000000-0x1443fffff 
64bit pref]
[  258.455307] pci 0000:75:00.0: reg 0x22c: [mem 0x144400000-0x14440ffff 
64bit pref]
[  258.462779] pci 0000:75:00.0: VF(n) BAR2 space: [mem 
0x144400000-0x1447effff 64bit pref] (contains BAR2 for 63 VFs)
[  258.473330] pci 0000:74:00.0: bridge window [mem 
0x00400000-0x007fffff 64bit pref] to [bus 75] add_size 400000 add_align 
400000
[  258.484800] pci 0000:74:00.0: BAR 15: assigned [mem 
0x144000000-0x1447fffff 64bit pref]
[  258.492795] pci 0000:74:02.0: BAR 5: assigned [mem 0xa2000000-0xa2007fff]
[  258.499576] pci 0000:74:03.0: BAR 5: assigned [mem 0xa2008000-0xa2008fff]
[  258.506356] pci 0000:75:00.0: BAR 2: assigned [mem 
0x144000000-0x1443fffff 64bit pref]
[  258.514263] pci 0000:75:00.0: BAR 9: assigned [mem 
0x144400000-0x1447effff 64bit pref]
[  258.522169] pci 0000:74:00.0: PCI bridge to [bus 75]
[  258.527124] pci 0000:74:00.0:   bridge window [mem 
0x144000000-0x1447fffff 64bit pref]
[  258.535182] pci 0000:80:00.0: [19e5:a120] type 01 class 0x060400
[  258.541278] pci 0000:80:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[  258.547972] pci 0000:80:08.0: [19e5:a120] type 01 class 0x060400
[  258.554069] pci 0000:80:08.0: PME# supported from D0 D1 D2 D3hot D3cold
[  258.560759] pci 0000:80:0c.0: [19e5:a120] type 01 class 0x060400
[  258.566858] pci 0000:80:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[  258.573549] pci 0000:80:10.0: [19e5:a120] type 01 class 0x060400
[  258.579644] pci 0000:80:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[  258.586377] pci 0000:81:00.0: [19e5:0123] type 00 class 0x010802
[  258.592387] pci 0000:81:00.0: reg 0x10: [mem 0xf0000000-0xf003ffff 64bit]
[  258.599184] pci 0000:81:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[  258.605965] pc[  258.629823] pci 0000:81:00.0: BAR 6: assigned [mem 
0xf0040000-0xf005ffff pref]
[  258.637033] pci 0000:80:00.0: PCI bridge to [bus 81]
[  258.641988] pci 0000:80:00.0:   bridge window [mem 0xf0000000-0xf00fffff]
[  258.648766] pci 0000:80:08.0: PCI bridge to [bus 82]
[  258.653722] pci 0000:80:0c.0: PCI bridge to [bus 83]
[  258.658679] pci 0000:80:10.0: PCI bridge to [bus 84]
[  258.663865] pci 0000:bc:00.0: [19e5:a121] type 01 class 0x060400
[  258.669874] pci 0000:bc:00.0: enabling Extended Tags
[  258.674960] pci 0000:bd:00.0: [19e5:a226] type 00 class 0x020000
[  258.680962] pci 0000:bd:00.0: reg 0x10: [mem 
0x400122000000-0x40012200ffff 64bit pref]
[  258.688869] pci 0000:bd:00.0: reg 0x18: [mem 
0x400120000000-0x4001200fffff 64bit pref]
[  258.696799] pci 0000:bd:00.0: reg 0x224: [mem 
0x400122010000-0x40012201ffff 64bit pref]
[  258.704791] pci 0000:bd:00.0: VF(n) BAR0 space: [mem 
0x400122010000-0x4001221fffff 64bit pref] (contains BAR0 for 31 VFs)
[  258.715736] pci 0000:bd:00.0: reg 0x22c: [mem 
0x400120100000-0x4001201fffff 64bit pref]
[  258.723728] pci 0000:bd:00.0: VF(n) BAR2 space: [mem 
0x400120100000-0x400121ffffff 64bit pref] (contains BAR2 for 31 VFs)
[  258.734762] pci 0000:bc:00.0: bridge window [mem 
0x00100000-0x002fffff 64bit pref] to [bus bd] add_size 2000000 add_align 
100000
[  258.746317] pci 0000:bc:00.0: BAR 15: assigned [mem 
0x400120000000-0x4001221fffff 64bit pref]
[  258.754831] pci 0000:bd:00.0: BAR 2: assigned [mem 
0x400120000000-0x4001200fffff 64bit pref]
[  258.763258] pci 0000:bd:00.0: BAR 9: assigned [mem 
0x400120100000-0x400121ffffff 64bit pref]
[  258.771688] pci 0000:bd:00.0: BAR 0: assigned [mem 
0x400122000000-0x40012200ffff 64bit pref]
[  258.780115] pci 0000:bd:00.0: BAR 7: assigned [mem 
0x400122010000-0x4001221fffff 64bit pref]
[  258.788542] pci 0000:bc:00.0: PCI bridge to [bus bd]
[  258.793497] pci 0000:bc:00.0:   bridge window [mem 
0x400120000000-0x4001221fffff 64bit pref]
[  258.801992] pci 0000:b4:00.0: [19e5:a121] type 01 class 0x060400
[  258.807998] pci 0000:b4:00.0: enabling Extended Tags
[  258.813076] pci 0000:b5:00.0: [19e5:a250] type 00 class 0x120000
[  258.819080] pci 0000:b5:00.0: reg 0x18: [mem 
0x400144000000-0x4001443fffff 64bit pref]
[  258.827012] pci 0000:b5:00.0: reg 0x22c: [mem 
0x400144400000-0x40014440ffff 64bit pref]
[  258.835003] pci 0000:b5:00.0: VF(n) BAR2 space: [mem 
0x400144400000-0x4001447effff 64bit pref] (contains BAR2 for 63 VFs)
[  258.846053] pci 0000:b4:00.0: bridge window [mem 
0x00400000-0x007fffff 64bit pref] to [bus b5] add_size 400000 add_align 
400000
[  258.857521] pci 0000:b4:00.0: BAR 15: assigned [mem 
0x400144000000-0x4001447fffff 64bit pref]
[  258.866034] pci 0000:b5:00.0: BAR 2: assigned [mem 
0x400144000000-0x4001443fffff 64bit pref]
[  258.874466] pci 0000:b5:00.0: BAR 9: assigned [mem 
0x400144400000-0x4001447effff 64bit pref]

--- Insert ko again ---

root@(none)$ !1
insmod lib/modules/arm-smmu-v3.ko
[  282.751387] arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
[  282.756992] arm-smmu-v3 arm-smmu-v3.0.auto: IRQ combined not found
[  282.763163] arm-smmu-v3 arm-smmu-v3.0.auto: IRQ eventq not found
[  282.769161] arm-smmu-v3 arm-smmu-v3.0.auto: IRQ priq not found
[  282.774986] arm-smmu-v3 arm-smmu-v3.0.auto: IRQ gerror not found
[  282.780989] arm-smmu-v3 arm-smmu-v3.0.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[  282.789378] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 65536 entries 
for cmdq
[  282.796648] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 32768 entries 
for evtq
[  282.804513] pcieport 0000:00:00.0: Adding to iommu group 0
[  282.807369] arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x0
[  282.812284] pcieport 0000:00:04.0: Adding to iommu group 1
[  282.815609] arm-smmu-v3 arm-smmu-v3.1.auto: IRQ combined not found
[  282.823242] pcieport 0000:00:08.0: Adding to iommu group 2
[  282.827210] arm-smmu-v3 arm-smmu-v3.1.auto: IRQ eventq not found
[  282.827212] arm-smmu-v3 arm-smmu-v3.1.auto: IRQ priq not found
[  282.827213] arm-smmu-v3 arm-smmu-v3.1.auto: IRQ gerror not found
[  282.827216] arm-smmu-v3 arm-smmu-v3.1.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[  282.827364] arm-smmu-v3 arm-smmu-v3.1.auto: allocated 65536 entries 
for cmdq
[  282.834808] pcieport 0000:00:0c.0: Adding to iommu group 3
[  282.838981] arm-smmu-v3 arm-smmu-v3.1.auto: allocated 32768 entries 
for evtq
[  282.846646] pcieport 0000:00:10.0: Adding to iommu group 4
[  282.850726] arm-smmu-v3 arm-smmu-v3.2.auto: option mask 0x0
[  282.860722] pcieport 0000:00:12.0: Adding to iommu group 5
[  282.865657] arm-smmu-v3 arm-smmu-v3.2.auto: IRQ combined not found
[  282.873349] pcieport 0000:7c:00.0: Adding to iommu group 6
[  282.878160] arm-smmu-v3 arm-smmu-v3.2.auto: IRQ eventq not found
[  282.878162] arm-smmu-v3 arm-smmu-v3.2.auto: IRQ priq not found
[  282.878163] arm-smmu-v3 arm-smmu-v3.2.auto: IRQ gerror not found
[  282.878166] arm-smmu-v3 arm-smmu-v3.2.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[  282.878290] arm-smmu-v3 arm-smmu-v3.2.auto: allocated 65536 entries 
for cmdq
[  282.885133] hns3 0000:7d:00.0: Adding to iommu group 7
[  282.889379] arm-smmu-v3 arm-smmu-v3.2.auto: allocated 32768 entries 
for evtq
[  282.895943] hns3 0000:7d:00.0: The firmware version is 176.98.1.48
[  282.901035] arm-smmu-v3 arm-smmu-v3.3.auto: option mask 0x0
[  282.910767] hns3 0000:7d:00.0: Firmware compatible features not 
enabled(-95).
[  282.912348] arm-smmu-v3 arm-smmu-v3.3.auto: IRQ combined not found
[  282.976427] arm-smmu-v3 arm-smmu-v3.3.auto: IRQ eventq not found
[  282.982421] arm-smmu-v3 arm-smmu-v3.3.auto: IRQ priq not found
[  282.988241] arm-smmu-v3 arm-smmu-v3.3.auto: IRQ gerror not found
[  282.994236] arm-smmu-v3 arm-smmu-v3.3.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[  283.002437] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries 
for cmdq
[  283.009756] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 32768 entries 
for evtq
[  283.016982] arm-smmu-v3 arm-smmu-v3.4.auto: option mask 0x0
[  283.022559] arm-smmu-v3 arm-smmu-v3.4.auto: IRQ combined not found
[  283.028728] arm-smmu-v3 arm-smmu-v3.4.auto: IRQ eventq not found
[  283.034722] arm-smmu-v3 arm-smmu-v3.4.auto: IRQ priq not found
[  283.040542] arm-smmu-v3 arm-smmu-v3.4.auto: IRQ gerror not found
[  283.046537] arm-smmu-v3 arm-smmu-v3.4.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[  283.054732] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 65536 entries 
for cmdq
[  283.061936] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 32768 entries 
for evtq
[  283.069129] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x0
[  283.074703] arm-smmu-v3 arm-smmu-v3.5.auto: IRQ combined not found
[  283.080871] arm-smmu-v3 arm-smmu-v3.5.auto: IRQ eventq not found
[  283.086867] arm-smmu-v3 arm-smmu-v3.5.auto: IRQ priq not found
[  283.092687] arm-smmu-v3 arm-smmu-v3.5.auto: IRQ gerror not found
[  283.098682] arm-smmu-v3 arm-smmu-v3.5.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[  283.106878] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 65536 entries 
for cmdq
[  283.114191] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 32768 entries 
for evtq
root@(none)$ [  284.294657] hns3 0000:7d:00.0: hclge driver 
initialization finished.
[  284.326277] hns3 0000:7d:00.1: Adding to iommu group 8
[  284.332691] hns3 0000:7d:00.1: The firmware version is 176.98.1.48
[  284.343297] hns3 0000:7d:00.1: Firmware compatible features not 
enabled(-95).
[  285.706654] hns3 0000:7d:00.1: hclge driver initialization finished.
[  285.737930] hns3 0000:7d:00.2: Adding to iommu group 9
[  285.744325] hns3 0000:7d:00.2: The firmware version is 176.98.1.48
[  285.754931] hns3 0000:7d:00.2: Firmware compatible features not 
enabled(-95).
[  285.765990] libphy: hisilicon MII bus: probed
[  285.835882] hns3 0000:7d:00.2: hclge driver initialization finished.
[  285.848083] Generic PHY mii-0000:7d:00.2:00: attached PHY driver 
[Generic PHY] (mii_bus:phy_addr=mii-0000:7d:00.2:00, irq=POLL)
[  285.860042] hns3 0000:7d:00.3: Adding to iommu group 10
[  285.866529] hns3 0000:7d:00.3: The firmware version is 176.98.1.48
[  285.877130] hns3 0000:7d:00.3: Firmware compatible features not 
enabled(-95).
[  285.886386] libphy: hisilicon MII bus: probed
[  285.955696] hns3 0000:7d:00.3: hclge driver initialization finished.
[  285.967919] Generic PHY mii-0000:7d:00.3:01: attached PHY driver 
[Generic PHY] (mii_bus:phy_addr=mii-0000:7d:00.3:01, irq=POLL)
[  285.979982] pcieport 0000:74:00.0: Adding to iommu group 11
[  285.986863] hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 12
[  286.008195] scsi host0: hisi_sas_v3_hw
[  287.298893] hisi_sas_v3_hw 0000:74:02.0: phyup: phy2 link_rate=11
[  287.304978] hisi_sas_v3_hw 0000:74:02.0: phyup: phy0 link_rate=11
[  287.311061] hisi_sas_v3_hw 0000:74:02.0: phyup: phy1 link_rate=11
[  287.311066] hisi_sas_v3_hw 0000:74:02.0: phyup: phy3 link_rate=11
[  287.323224] hisi_sas_v3_hw 0000:74:02.0: phyup: phy4 link_rate=11
[  287.323230] hisi_sas_v3_hw 0000:74:02.0: phyup: phy5 link_rate=11
[  287.323235] hisi_sas_v3_hw 0000:74:02.0: phyup: phy6 link_rate=11
[  287.323268] hisi_sas_v3_hw 0000:74:02.0: phyup: phy7 link_rate=11
[  287.329634] hisi_sas_v3_hw 0000:74:02.0: dev[1:2] found
[  287.356200] hisi_sas_v3_hw 0000:74:02.0: dev[2:1] found
[  287.361593] hisi_sas_v3_hw 0000:74:02.0: dev[3:1] found
[  287.367180] hisi_sas_v3_hw 0000:74:02.0: dev[4:5] found
[  287.532058] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] found
[  287.537456] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] found
[  287.542868] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  289.729042] ata4.00: ATA-8: SAMSUNG HM320JI, 2SS00_01, max UDMA7
[  289.735039] ata4.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 32)
[  289.747065] ata4.00: configured for UDMA/133
[  289.751338] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 
tries: 1
[  289.762761] scsi 0:0:0:0: Direct-Access     SEAGATE  ST2000NM0045 
N004 PQ: 0 ANSI: 6
[  289.774757] scsi 0:0:1:0: Direct-Access     SEAGATE  ST2000NM0045 
N004 PQ: 0 ANSI: 6
[  289.775005] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[  289.785688] scsi 0:0:2:0: Direct-Access     ATA      SAMSUNG HM320JI 
0_01 PQ: 0 ANSI: 5
[  289.786940] sd 0:0:1:0: [sdb] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[  289.787612] sd 0:0:1:0: [sdb] Write Protect is off
[  289.788816] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[  289.791242] sd 0:0:0:0: [sda] Write Protect is off
[  289.799026] sd 0:0:2:0: [sdc] 625142448 512-byte logical blocks: (320 
GB/298 GiB)
[  289.799865] scsi 0:0:3:0: Direct-Access     SEAGATE  ST1000NM0023 
0006 PQ: 0 ANSI: 6
[  289.807642] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[  289.811219] sd 0:0:2:0: [sdc] Write Protect is off
[  289.828112]  sdb: sdb1
[  289.831969] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[  289.832627] scsi 0:0:4:0: Enclosure         HUAWEI   Expander 12Gx16 
128  PQ: 0 ANSI: 6
[  289.832952] sd 0:0:3:0: [sdd] 1953525168 512-byte logical blocks: 
(1.00 TB/932 GiB)
[  289.833296] sd 0:0:3:0: [sdd] Write Protect is off
[  289.833942] sd 0:0:3:0: [sdd] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[  289.834261] sas: ex 500e004aaaaaaa1f phy08 change count has changed
[  289.837361] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.838882] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.840403] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.845988] sd 0:0:1:0: [sdb] Attached SCSI disk
[  289.922155] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.929063] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.935167]  sdd: sdd1 sdd2
[  289.936001] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.937042]  sda: sda1
[  289.942356] sd 0:0:3:0: [sdd] Attached SCSI disk
[  289.943134] sd 0:0:0:0: [sda] Attached SCSI disk
[  289.956420] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.963228] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.970139] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.977068] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.983892] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.990796] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  289.997676] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.004530] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.011413] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.018326] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.025153] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.032032] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.038952] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.045032] random: crng init done
[  290.049356] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.056228] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.063116] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.070028] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.076864] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.083766] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.090642] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.097469] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.104334] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.111231] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.118077] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.124972] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.131892] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.138701] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.145628] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.152511] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.159352] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.166244] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.173134] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  290.178616] ahci 0000:74:03.0: Adding to iommu group 13
[  290.185204] ahci 0000:74:03.0: SSS flag set, parallel bus scan disabled
[  290.191824] ahci 0000:74:03.0: AHCI 0001.0300 32 slots 2 ports 6 Gbps 
0x3 impl SATA mode
[  290.199903] ahci 0000:74:03.0: flags: 64bit ncq sntf stag pm led clo 
only pmp fbs slum part ccc sxs boh
[  290.209768] scsi host1: ahci
[  290.212787] scsi host2: ahci
[  290.215729] ata5: SATA max UDMA/133 abar m4096@0xa2008000 port 
0xa2008100 irq 660
[  290.223201] ata6: SATA max UDMA/133 abar m4096@0xa2008000 port 
0xa2008180 irq 661
[  290.230933] pcieport 0000:80:00.0: Adding to iommu group 14
[  290.239292] pcieport 0000:80:08.0: Adding to iommu group 15
[  290.247396] pcieport 0000:80:0c.0: Adding to iommu group 16
[  290.255453] pcieport 0000:80:10.0: Adding to iommu group 17
[  290.263638] pcieport 0000:bc:00.0: Adding to iommu group 18
[  290.270632] hns3 0000:bd:00.0: Adding to iommu group 19
[  290.277182] hns3 0000:bd:00.0: The firmware version is 176.98.1.48
[  290.287847] hns3 0000:bd:00.0: Firmware compatible features not 
enabled(-95).
[  290.545421] ata5: SATA link down (SStatus 0 SControl 300)
[  291.699895] hns3 0000:bd:00.0: hclge driver initialization finished.
[  291.736307] pcieport 0000:b4:00.0: Adding to iommu group 20
[  292.155588]  sdc: sdc1 sdc2 sdc3
[  292.160569] sd 0:0:2:0: [sdc] Attached SCSI disk
[  292.477420] ata6: SATA link down (SStatus 0 SControl 300)


John
