Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F9EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B8822CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 10:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbfIEKgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:36:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726137AbfIEKgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 06:36:19 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8B0E47E360BAA0758C54;
        Thu,  5 Sep 2019 18:36:14 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 18:36:04 +0800
Subject: Re: PCI/kernel msi code vs GIC ITS driver conflict?
To:     Marc Zyngier <maz@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>
References: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
 <5fd4c1cf-76c1-4054-3754-549317509310@kernel.org>
 <ef258ec7-877c-406a-3d88-80ff79b823f2@huawei.com>
 <20190904102537.GV9720@e119886-lin.cambridge.arm.com>
 <8f1c1fe6-c0d4-1805-b119-6a48a4900e6d@kernel.org>
 <84f6756f-79f2-2e46-fe44-9a46be69f99d@huawei.com>
 <651b4d5f-2d86-65dc-1232-580445852752@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8ac8e372-15a0-2f95-089c-c189b619ea62@huawei.com>
Date:   Thu, 5 Sep 2019 11:35:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <651b4d5f-2d86-65dc-1232-580445852752@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Hi Marc,
>>
>> As requested, I enabled debug for that driver and here are some kernel
>> log snippets:
>>
>> [    8.435707] hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 0
>> [    8.461467] scsi host0: hisi_sas_v3_hw
>> [    9.683463] ITS: alloc 9920:32
>> [    9.686509] ITT 32 entries, 5 bits
>> [    9.690044] ID:0 pID:9920 vID:23
>> [    9.693263] ID:1 pID:9921 vID:24
>> [    9.696480] ID:2 pID:9922 vID:25
>> [    9.699696] ID:3 pID:9923 vID:26
>> [    9.702911] ID:4 pID:9924 vID:27
>> [    9.706128] ID:5 pID:9925 vID:28
>> [    9.709344] ID:6 pID:9926 vID:29
>> [    9.712560] ID:7 pID:9927 vID:30
>> [    9.715776] ID:8 pID:9928 vID:31
>> [    9.718990] ID:9 pID:9929 vID:32
>> [    9.722207] ID:10 pID:9930 vID:33
>> [    9.725510] ID:11 pID:9931 vID:34
>> [    9.728813] ID:12 pID:9932 vID:35
>> [    9.732116] ID:13 pID:9933 vID:36
>> [    9.735419] ID:14 pID:9934 vID:37
>> [    9.738721] ID:15 pID:9935 vID:38
>> [    9.742024] ID:16 pID:9936 vID:39
>>
>> <snip>
>>
>> (none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind
>>
>> <snip>
>>
>> root@(none)$
>> $ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/bind
>> [   41.110557] scsi host0: hisi_sas_v3_hw
>> [   42.335455] Reusing ITT for devID 7410
>> [   42.359151] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2
>> sh: echo: write error: No such device
>> root@(none)$
>
> Very interesting. Somehow, we think that this is a *new* device that
> aliases with itself. Needless to say, that's unexpected. My hunch is
> that something goes wrong when freeing the device. Can you try adding
> the patch below and report what is happening on unbind?
>

Hi Marc,

Here's the new snippet for unbind + bind:

(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind

<snip>

[  102.189618] Freed devid 7410 LPI 0
[  102.193019] Freed devid 7410 LPI 0
[  102.196420] Freed devid 7410 LPI 0
[  102.199854] Freed devid 7410 LPI 0
[  102.203242] Freed devid 7410 LPI 0
[  102.206640] Freed devid 7410 LPI 0
[  102.210036] Freed devid 7410 LPI 0
[  102.213426] Freed devid 7410 LPI 0
[  102.216816] Freed devid 7410 LPI 0
[  102.220206] Freed devid 7410 LPI 0
[  102.223596] Freed devid 7410 LPI 0
[  102.226984] Freed devid 7410 LPI 0
[  102.230373] Freed devid 7410 LPI 0
[  102.233763] Freed devid 7410 LPI 0
[  102.237152] Freed devid 7410 LPI 0
[  102.240542] Freed devid 7410 LPI 0
[  102.243931] Freed devid 7410 LPI 0
root@(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/bind
[  111.662451] scsi host0: hisi_sas_v3_hw
[  112.887353] Reusing ITT for devID 7410
[  112.911275] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2

Again, full dmesg at the bottom.

John

> Thanks,
>
> 	M.
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 1b5c3672aea2..3fed87e551d9 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -2651,6 +2651,8 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>
>  		/* Nuke the entry in the domain */
>  		irq_domain_reset_irq_data(data);
> +
> +		pr_debug("Freed devid %x LPI %ld\n", its_dev->device_id, data->hwirq);
>  	}
>
>  	mutex_lock(&its->dev_alloc_lock);
> @@ -2667,6 +2669,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>  			     its_dev->event_map.nr_lpis);
>  		kfree(its_dev->event_map.col_map);
>
> +		pr_debug("Unmap devid %x\n", its_dev->device_id);
>  		/* Unmap device/itt */
>  		its_send_mapd(its_dev, 0);
>  		its_free_device(its_dev);
>




   Booting `Minilinux D06 acpi'

Loading driver at 0x0001AC96000 EntryPoint=0x0001BDEB810
Loading driver at 0x0001AC96000 EntryPoint=0x0001BDEB810
EFI stub: Booting Linux Kernel...
SmiGraphicsOutputQueryMode +
SmiGraphicsOutputQueryMode -
SmiGraphicsOutputQueryMode +
SmiGraphicsOutputQueryMode -
EFI stub: EFI_RNG_PROTOCOL unavailable, no randomness supplied
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
WriteBackInvalidateDataCacheRange start
WriteBackInvalidateDataCacheRange end
IPMI ExitBootService Event
[SAL_ClearAffiliationSMP,325]it is going to hard reset 
dev:0x500E004AAAAAAA1F Father:500E004AAAAAAA1F
[    0.000000] Booting Linux on physical CPU 0x0000010000 [0x480fd010]
[    0.000000] Linux version 5.3.0-rc7-dirty 
(john@john-ThinkCentre-M93p) (gcc version 7.3.1 20180425 
[linaro-7.3-2018.05-rc1 revision 
38aec9a676236eaa42ca03ccb3a6c1dd0182c29f] (Linaro GCC 7.3-2018.05-rc1)) 
#870 SMP PREEMPT Thu Sep 5 11:05:52 BST 2019
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi:  ACPI 2.0=0x39db0000  SMBIOS 3.0=0x3f150000 
MEMATTR=0x3bafb118  ESRT=0x3e2e2a18  MEMRESERVE=0x3a160e98
[    0.000000] esrt: Reserving ESRT space from 0x000000003e2e2a18 to 
0x000000003e2e2a50.
[    0.000000] crashkernel reserved: 0x0000000002000000 - 
0x0000000012000000 (256 MB)
[    0.000000] cma: Reserved 32 MiB at 0x000000007e000000
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x0000000039DB0000 000024 (v02 HISI  )
[    0.000000] ACPI: XSDT 0x0000000039DA0000 0000AC (v01 HISI   HIP08 
00000000      01000013)
[    0.000000] ACPI: FACP 0x0000000039750000 000114 (v06 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: DSDT 0x00000000396D0000 0066BF (v02 HISI   HIP08 
00000000 INTL 20181003)
[    0.000000] ACPI: PCCT 0x0000000039D90000 00008A (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SSDT 0x0000000039D80000 00ABB8 (v02 HISI   HIP08 
00000000 INTL 20181003)
[    0.000000] ACPI: BERT 0x0000000039C60000 000030 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: HEST 0x0000000039C40000 00013C (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: ERST 0x0000000039C00000 000230 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: EINJ 0x0000000039BF0000 000170 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: GTDT 0x0000000039740000 00007C (v02 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: DBG2 0x0000000039730000 00005E (v00 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: MCFG 0x0000000039720000 00003C (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SLIT 0x0000000039710000 00003C (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SRAT 0x00000000396F0000 00074C (v03 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: APIC 0x00000000396E0000 001E58 (v04 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: IORT 0x00000000396C0000 0010F8 (v00 HISI   HIP08 
00000000 INTL 20181003)
[    0.000000] ACPI: PPTT 0x0000000031500000 002A30 (v01 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: SPMI 0x00000000314F0000 000041 (v05 HISI   HIP08 
00000000 HISI 20151124)
[    0.000000] ACPI: iBFT 0x0000000039700000 000800 (v01 HISI   HIP08 
00000000      00000000)
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x2080000000-0x23ffffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x23fdff0840-0x23fdff1fff]
[    0.000000] NUMA: Initmem setup node 1 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0x23fdfef080-0x23fdff083f]
[    0.000000] NUMA: NODE_DATA(1) on node 0
[    0.000000] NUMA: Initmem setup node 2 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0x23fdfed8c0-0x23fdfef07f]
[    0.000000] NUMA: NODE_DATA(2) on node 0
[    0.000000] NUMA: Initmem setup node 3 [<memory-less node>]
[    0.000000] NUMA: NODE_DATA [mem 0x23fdfec100-0x23fdfed8bf]
[    0.000000] NUMA: NODE_DATA(3) on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000023ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000030f93fff]
[    0.000000]   node   0: [mem 0x0000000030f94000-0x00000000314effff]
[    0.000000]   node   0: [mem 0x00000000314f0000-0x000000003975ffff]
[    0.000000]   node   0: [mem 0x0000000039760000-0x000000003977ffff]
[    0.000000]   node   0: [mem 0x0000000039780000-0x000000003978ffff]
[    0.000000]   node   0: [mem 0x000de   0: [mem 
0x0000000039890000-0x0000000039a6ffff]
[    0.000000]   node   0: [mem 0x0000000039a70000-0x0000000039a9ffff]
[    0.000000]   node   0: [mem 0x0000000039aa0000-0x0000000039b3ffff]
[    0.000000]   node   0: [mem 0x0000000039b40000-0x0000000039c0ffff]
[    0.000000]   node   0: [mem 0x0000000039c10000-0x0000000039c11fff]
[    0.000000]   node   0: [mem 0x0000000039c12000-0x0000000039c1ffff]
[    0.000000]   node   0: [mem 0x0000000039c20000-0x0000000039c20fff]
[    0.000000]   node   0: [mem 0x0000000039c21000-0x0000000039c2ffff]
[    0.000000]   node   0: [mem 0x0000000039c30000-0x0000000039c31fff]
[    0.000000]   node   0: [mem 0x0000000039c32000-0x0000000039c4ffff]
[    0.000000]   node   0: [mem 0x0000000039c50000-0x0000000039c51fff]
[    0.000000]   node   0: [mem 0x0000000039c52000-0x0000000039c6ffff]
[    0.000000]   node   0: [mem 0x0000000039c70000-0x0000000039c70fff]
[    0.000000]   node   0: [mem 0x0000000039c71000-0x0000000039caffff]
[    0.000000]   node   0: [mem 0x0000000039cb0000-0x0000000039cbffff]
[    0.000000]   node   0: [mem 0x0000000039cc0000-0x0000000039ccffff]
[    0.000000]   node   0: [mem 0x0000000039cd0000-0x0000000039cdffff]
[    0.000000]   node   0: [mem 0x0000000039ce0000-0x0000000039ceffff]
[    0.000000]   node   0: [mem 0x0000000039cf0000-0x0000000039d7ffff]
[    0.000000]   node   0: [mem 0x0000000039d80000-0x0000000039dbffff]
[    0.000000]   node   0: [mem 0x0000000039dc0000-0x000000003a15ffff]
[    0.000000]   node   0: [mem 0x000000003a160000-0x000000003a160fff]
[    0.000000]   node   0: [mem 0x000000003a161000-0x000000003a161fff]
[    0.000000]   node   0: [mem 0x000000003a162000-0x000000003f14ffff]
[    0.000000]   node   0: [mem 0x000000003f150000-0x000000003f17ffff]
[    0.000000]   node   0: [mem 0x000000003f180000-0x000000003fbfffff]
[    0.000000]   node   0: [mem 0x0000000040000000-0x0000000043ffffff]
[    0.000000]   node   0: [mem 0x0000000044020000-0x000000007fffffff]
[    0.000000]   node   0: [mem 0x0000002080000000-0x00000023ffffffff]
[    0.000000] Zeroed struct page in unavailable ranges: 548 pages
[    0.000000] Initmem setup node 0 [mem 
0x0000000000000000-0x00000023ffffffff]
[    0.000000] On node 0 totalpages: 4193248
[    0.000000]   DMA32 zone: 8176 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 523232 pages, LIFO batch:63
[    0.000000]   Normal zone: 57344 pages used for memmap
[    0.000000]   Normal zone: 3670016 pages, LIFO batch:63
[    0.000000] Could not find start_pfn for node 1
[    0.000000] Initmem setup node 1 [mem 
0x0000000000000000-0x0000000000000000]
[    0.000000] On node 1 totalpages: 0
[    0.000000] Could not find start_pfn for node 2
[    0.000000] Initmem setup node 2 [mem 
0x0000000000000000-0x0000000000000000]
[    0.000000] On node 2 totalpages: 0
[    0.000000] Could not find start_pfn for node 3
[    0.000000] Initmem setup node 3 [mem 
0x0000000000000000-0x0000000000000000]
[    0.000000] On node 3 totalpages: 0
[    0.000000] psci: probing for conduit method from ACPI.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: MIGRATE_INFO_TYPE not supported.
[    0.000000] psci: SMC Calling Convention v1.1
[    0.000000] ACPI: NUMA: SRAT: PXM 0 -> MPIDR 0x10000 -> Node 0
[    0.000000] Number of cores (96) exceeds configured maximum of 1 - 
clipping
[    0.000000] percpu: Embedded 23 pages/cpu s56728 r8192 d29288 u94208
[    0.000000] pcpu-alloc: s56728 r8192 d29288 u94208 alloc=23*4096
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: GIC system register CPU interface
[    0.000000] CPU features: detected: Virtualization Host Extensions
[    0.000000] CPU features: detected: Hardware dirty bit management
[    0.000000] alternatives: patching kernel code
[    0.000000] Built 4 zonelists, mobility grouping on.  Total pages: 
4127728
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/john/Image rdinit=/init 
crashkernel=256M@32M console=ttyAMA0,115200 earlycon acpi=force 
pcie_aspm=off scsi_mod.use_blk_mq=y no_console_suspend nr_cpus=1 loglevel=8
[    0.000000] PCIe ASPM is disabled
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 
16777216 bytes, linear)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 
8388608 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x7a000000-0x7e000000] (64MB)
[    0.000000] Memory: 15758676K/16772992K available (11644K kernel 
code, 1792K rwdata, 6008K rodata, 4992K init, 450K bss, 981548K 
reserved, 32768K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=4
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=256 to 
nr_cpu_ids=1.
[    0.000000]  Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay 
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: VLPI support, direct LPI support
[    0.000000] GICv3: CPU0: found redistributor 10000 region 
0:0x00000000ae100000
[    0.000000] SRAT: PXM 0 -> ITS 0 -> Node 0
[    0.000000] ITS [mem 0x202100000-0x20211ffff]
[    0.000000] ITS@0x0000000202100000: Using ITS number 0
[    0.000000] ITS@0x0000000202100000: allocated 8192 Devices 
@23ec050000 (indirect, esz 8, psz 16K, shr 1)
[    0.000000] ITS@0x0000000202100000: allocated 2048 Virtual CPUs 
@23ec038000 (indirect, esz 16, psz 4K, shr 1)
[    0.000000] ITS@0x0000000202100000: allocated 256 Interrupt 
Collections @23ec037000 (flat, esz 16, psz 4K, shr 1)
[    0.000000] GICv3: using LPI property table @0x00000023ec060000
[    0.000000] ITS: Allocator initialized for 57344 LPIs
[    0.000000] ITS: Using DirectLPI for VPE invalidation
[    0.000000] ITS: Enabling GICv4 support
[    0.000000] GICv4: CPU0: Init IDbits to 0xf for GICR_VPROPBASER
[    0.000000] GICv3: CPU0: using allocated LPI pending table 
@0x00000023ec070000
[    0.000000] random: get_random_bytes called from 
start_kernel+0x300/0x4a0 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 100.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff 
max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
[    0.000001] sched_clock: 56 bits at 100MHz, resolution 10ns, wraps 
every 4398046511100ns
[    0.000028] Console: colour dummy device 80x25
[    0.000050] mempolicy: Enabling automatic NUMA balancing. Configure 
with numa_balancing= or the kernel.numa_balancing sysctl
[    0.000064] ACPI: Core revision 20190703
[    0.000222] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.000225] pid_max: default: 32768 minimum: 301
[    0.000243] LSM: Security Framework initializing
[    0.000275] Mount-cache hash table entries: 32768 (order: 6, 262144 
bytes, linear)
[    0.000293] Mountpoint-cache hash table entries: 32768 (order: 6, 
262144 bytes, linear)
[    0.024018] ASID allocator initialised with 32768 entries
[    0.032015] rcu: Hierarchical SRCU implementation.
[    0.040028] Platform MSI: ITS@0x202100000 domain created
[    0.040035] PCI/MSI: ITS@0x202100000 domain created
[    0.040045] Remapping and enabling EFI services.
[    0.048022] smp: Bringing up secondary CPUs ...
[    0.048024] smp: Brought up 4 nodes, 1 CPU
[    0.048026] SMP: Total of 1 processors activated.
[    0.048028] CPU features: detected: Privileged Access Never
[    0.048030] CPU features: detected: LSE atomic instructions
[    0.048031] CPU features: detected: User Access Override
[    0.048033] CPU features: detected: Common not Private translations
[    0.048034] CPU features: detected: RAS Extension Support
[    0.048036] CPU features: detected: CRC32 instructions
[    0.049254] CPU: All CPU(s) started at EL2
[    0.050943] devtmpfs: initialized
[    0.052136] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.052141] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.052426] pinctrl core: initialized pinctrl subsystem
[    0.052765] SMBIOS 3.1.1 present.
[    0.052771] DMI: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 - 
V1.12.01 01/29/2019
[    0.053028] NET: Registered protocol family 16
[    0.053120] audit: initializing netlink subsys (disabled)
[    0.053365] audit: type=2000 audit(0.052:1): state=initialized 
audit_enabled=0 res=1
[    0.056038] cpuidle: using governor menu
[    0.056046] Detected 1 PCC Subspaces
[    0.056077] Registering PCC driver as Mailbox controller
[    0.056158] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.056458] DMA: preallocated 256 KiB pool for atomic allocations
[    0.056609] ACPI: bus type PCI registered
[    0.056611] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.056703] Serial: AMBA PL011 UART driver
[    0.060098] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.060101] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.060103] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.060104] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.068066] cryptd: max_cpu_qlen set to 1000
[    0.080170] ACPI: Added _OSI(Module Device)
[    0.080173] ACPI: Added _OSI(Processor Device)
[    0.080175] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.080177] ACPI: Added _OSI(Processor Aggregator Device)
[    0.080179] ACPI: Added _OSI(Linux-Dell-Video)
[    0.080181] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.080183] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.092364] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.095669] ACPI: Interpreter enabled
[    0.095672] ACPI: Using GIC for interrupt routing
[    0.095687] ACPI: MCFG table detected, 1 entries
[    0.095691] ACPI: IORT: SMMU-v3[148000000] Mapped to Proximity domain 0
[    0.095743] ACPI: IORT: SMMU-v3[100000000] Mapped to Proximity domain 0
[    0.095780] ACPI: IORT: SMMU-v3[140000000] Mapped to Proximity domain 0
[    0.095816] ACPI: IORT: SMMU-v3[400148000000] Mapped to Proximity 
domain 2
[    0.095851] ACPI: IORT: SMMU-v3[400100000000] Mapped to Proximity 
domain 2
[    0.095885] ACPI: IORT: SMMU-v3[400140000000] Mapped to Proximity 
domain 2
[    0.096030] HEST: Table parsing has been initialized.
[    0.107433] ARMH0011:00: ttyAMA0 at MMIO 0x94080000 (irq = 5, 
base_baud = 0) is a SBSA
[    1.434670] printk: console [ttyAMA0] enabled
0000-0xffff window]
[    1.491766] PCI host bridge to bus 0000:00
[    1.495852] pci_bus 0000:00: root bus resource [mem 
0x80000000000-0x83fffffffff pref window]
[    1.504277] pci_bus 0000:00: root bus resource [mem 
0xe0000000-0xeffeffff window]
[    1.511746] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[    1.518522] pci_bus 0000:00: root bus resource [bus 00-3f]
[ rted from D0 D1 D2 D3hot D3cold
[    1.549485] pci 0000:00:08.0: [19e5:a120] type 01 class 0x060400
[    1.555548] pci 0000:00:08.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.562219] pci 0000:00:0c.0: [19e5:a120] type 01 class 0x060400
[    1.568283] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.574952] pci 0000:00:10.0: [19e5:a120] type 01 class 0x060400
[    1.581014] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.587681] pci 0000:00:12.0: [19e5:a120] type 01 class 0x060400
[    1.593743] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.600444] pci 0000:01:00.0: [8086:10fb] type 00 class 0x020000
[    1.606455] pci 0000:01:00.0: reg 0x10: [mem 
0x80000080000-0x800000fffff 64bit pref]
[    1.614189] pci 0000:01:00.0: reg 0x18: [io  0x0020-0x003f]
[    1.619759] pci 0000:01:00.0: reg 0x20: [mem 
0x80000104000-0x80000107fff 64bit pref]
[    1.627492] pci 0000:01:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    1.634260] pci 0000:01:00.0: PME# supported from D0 D3hot
[    1.639757] pci 0000:01:00.0: reg 0x184: [mem 0x00000000-0x00003fff 
64bit pref]
[    1.647054] pci 0000:01:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[    1.657311] pci 0000:01:00.0: reg 0x190: [mem 0x00000000-0x00003fff 
64bit pref]
[    1.664607] pci 0000:01:00.0: VF(n) BAR3 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[    1.675070] pci 0000:01:00.1: [8086:10fb] type 00 class 0x020000
[    1.681081] pci 0000:01:00.1: reg 0x10: [mem 
0x80000000000-0x8000007ffff 64bit pref]
[    1.688815] pci 0000:01:00.1: reg 0x18: [io  0x0000-0x001f]
[    1.694385] pci 0000:01:00.1: reg 0x20: [mem 
0x80000100000-0x80000103fff 64bit pref]
[    1.702119] pci 0000:01:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    1.708884] pci 0000:01:00.1: PME# supported from D0 D3hot
[    1.714378] pci 0000:01:00.1: reg 0x184: [mem 0x00000000-0x00003fff 
64bit pref]
[    1.721674] pci 0000:01:00.1: VF(n) BAR0 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[    1.731931] pci 0000:01:00.1: reg 0x190: [mem 0x00000000-0x00003fff 
64bit pref]
[    1.739228] pci 0000:01:00.1: VF(n) BAR3 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[    1.749809] pci 0000:05:00.0: [19e5:1711] type 00 class 0x030000
[    1.755832] pci 0000:05:00.0: reg 0x10: [mem 0xe0000000-0xe1ffffff pref]
[    1.762531] pci 0000:05:00.0: reg 0x14: [mem 0xe2000000-0xe21fffff]
[    1.768953] pci 0000:05:00.0: supports D1
[    1.772951] pci 0000:05:00.0: PME# supported from D0 D1 D3hot
[    1.778822] pci_bus 0000:00: on NUMA node 0
[    1.782999] pci 0000:00:00.0: bridge window [mem 
0x00100000-0x002fffff 64bit pref] to [bus 01] add_size 400000 add_align 
100000
[    1.794467] pci 0000:00:10.0: BAR 14: assigned [mem 
0xe0000000-0xe2ffffff]
[    1.801329] pci 0000:00:00.0: BAR 14: assigned [mem 
0xe3000000-0xe30fffff]
[    1.808191] pci 0000:00:00.0: BAR 15: assigned [mem 
0x80000000000-0x800005fffff 64bit pref]
[    1.816529] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    1.822700] pci 0000:01:00.0: BAR 0: assigned [mem 
0x80000000000-0x8000007ffff 64bit pref]
[    1.830956] pci 0000:01:00.0: BAR 6: assigned [mem 
0xe3000000-0xe307ffff pref]
[    1.838166] pci 0000:01:00.1: BAR 0: assigned [mem 
0x80000080000-0x800000fffff 64bit pref]
[    1.846422] pci 0000:01:00.1: BAR 6: assigned [mem 
0xe3080000-0xe30fffff pref]
[    1.853631] pci 0000:01:00.0: BAR 4: assigned [mem 
0x80000100000-0x80000103fff 64bit pref]
[    1.861886] pci 0000:01:00.0: BAR 7: assigned [mem 
0x80000104000-0x80000203fff 64bit pref]
[    1.870140] pci 0000:01:00.0: BAR 10: assigned [mem 
0x80000204000-0x80000303fff 64bit pref]
[    1.878479] pci 0000:01:00.1: BAR 4: assigned [mem 
0x80000304000-0x80000307fff 64bit pref]
[    1.886735] pci 0000:01:00.1: BAR 7: assigned [mem 
0x80000308000-0x80000407fff 64bit pref]
[    1.894988] pci 0000:01:00.1: BAR 10: assigned [mem 
0x80000408000-0x80000507fff 64bit pref]
[    1.903328] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    1.909410] pci 0000:01:00.1: BAR 2: assigned [io  0x1020-0x103f]
[    1.915494] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.920446] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.926527] pci 0000:00:00.0:   bridge window [mem 0xe3000000-0xe30fffff]
[    1.933303] pci 0000:00:00.0:   bridge window [mem 
0x80000000000-0x800005fffff 64bit pref]
[    1.941555] pci 0000:00:04.0: PCI bridge to [bus 02]
[    1.946511] pci 0000:00:08.0: PCI bridge to [bus 03]
[    1.951466] pci 0000:00:0c.0: PCI bridge to [bus 04]
[    1.956423] pci 0000:05:00.0: BAR 0: assigned [mem 
0xe0000000-0xe1ffffff pref]
[    1.963636] pci 0000:05:00.0: BAR 1: assigned [mem 0xe2000000-0xe21fffff]
[    1.970414] pci 0000:00:10.0: PCI bridge to [bus 05]
[    1.975367] pci 0000:00:10.0:   bridge window [mem 0xe0000000-0xe2ffffff]
[    1.982145] pci 0000:00:12.0: PCI bridge to [bus 06]
[    1.987100] pci_bus 0000:00: resource 4 [mem 
0x80000000000-0x83fffffffff pref window]
[    1.994917] pci_bus 0000:00: resource 5 [mem 0xe0000000-0xeffeffff 
window]
[    2.001779] pci_bus 0000:00: resource 6 [io  0x0000-0xffff window]
[    2.007947] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    2.013507] pci_bus 0000:01: resource 1 [mem 0xe3000000-0xe30fffff]
[    2.019761] pci_bus 0000:01: resource 2 [mem 
0x80000000000-0x800005fffff 64bit pref]
[    2.027492] pci_bus 0000:05: resource 1 [mem 0xe0000000-0xe2ffffff]
[    2.033784] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 7b])
[    2.039694] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.047655] acpi PNP0A08:01: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.057729] acpi PNP0A08:01: ECAM area [mem 0xd7b00000-0xd7bfffff] 
reserved by PNP0C02:00
[    2.065906] acpi PNP0A08:01: ECAM at [mem 0xd7b00000-0xd7bfffff] for 
[bus 7b]
[    2.073083] PCI host bridge to bus 0000:7b
[    2.077169] pci_bus 0000:7b: root bus resource [mem 
0x148800000-0x148ffffff pref window]
[    2.085247] pci_bus 0000:7b: root bus resource [bus 7b]
[    2.090474] pci_bus 0000:7b: on NUMA node 0
[    2.094646] pci_bus 0000:7b: resource 4 [mem 0x148800000-0x148ffffff 
pref window]
[    2.102138] ACPI: PCI Root Bridge [PCI2] (domain 0000 [bus 7a])
[    2.108048] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.116005] acpi PNP0A08:02: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.126075] acpi PNP0A08:02: ECAM area [mem 0xd7a00000-0xd7afffff] 
reserved by PNP0C02:00
[    2.134250] acpi PNP0A08:02: ECAM at [mem 0xd7a00000-0xd7afffff] for 
[bus 7a]
[    2.141433] PCI host bridge to bus 0000:7a
[    2.145519] pci_bus 0000:7a: root bus resource [mem 
0x20c000000-0x20c1fffff pref window]
[    2.153597] pci_bus 0000:7a: root bus resource [bus 7a]
[    2.158816] pci 0000:7a:00.0: [19e5:a239] type 00 class 0x0c0310
[    2.164814] pci 0000:7a:00.0: reg 0x10: [mem 0x20c100000-0x20c100fff 
64bit pref]
[    2.172258] pci 0000:7a:01.0: [19e5:a239] type 00 class 0x0c0320
[    2.178257] pci 0000:7a:01.0: reg 0x10: [mem 0x20c101000-0x20c101fff 
64bit pref]
[    2.185701] pci 0000:7a:02.0: [19e5:a238] type 00 class 0x0c0330
[    2.191700] pci 0000:7a:02.0: reg 0x10: [mem 0x20c000000-0x20c0fffff 
64bit pref]
[    2.199145] pci_bus 0000:7a: on NUMA node 0
[    2.203319] pci 0000:7a:02.0: BAR 0: assigned [mem 
0x20c000000-0x20c0fffff 64bit pref]
[    2.211225] pci 0000:7a:00.0: BAR 0: assigned [mem 
0x20c100000-0x20c100fff 64bit pref]
[    2.219130] pci 0000:7a:01.0: BAR 0: assigned [mem 
0x20c101000-0x20c101fff 64bit pref]
[    2.227036] pci_bus 0000:7a: resource 4 [mem 0x20c000000-0x20c1fffff 
pref window]
[    2.234534] ACPI: PCI Root Bridge [PCI3] (domain 0000 [bus 78-79])
[    2.240704] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.248661] acpi PNP0A08:03: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.258733] acpi PNP0A08:03: ECAM area [mem 0xd7800000-0xd79fffff] 
reserved by PNP0C02:00
[    2.266902] acpi PNP0A08:03: ECAM at [mem 0xd7800000-0xd79fffff] for 
[bus 78-79]
[    2.274341] PCI host bridge to bus 0000:78
[    2.278427] pci_bus 0000:78: root bus resource [mem 
0x208000000-0x208ffffff pref window]
[    2.286505] pci_bus 0000:78: root bus resource [bus 78-79]
[    2.291983] pci 0000:78:00.0: [19e5:a258] type 00 class 0x100000
[    2.297983] pci 0000:78:00.0: reg 0x18: [mem 0x00000000-0x001fffff 
64bit pref]
[    2.305254] pci_bus 0000:78: on NUMA node 0
[    2.309427] pci 0000:78:00.0: BAR 2: assigned [mem 
0x208000000-0x2081fffff 64bit pref]
[    2.317333] pci_bus 0000:78: resource 4 [mem 0x208000000-0x208ffffff 
pref window]
[    2.324827] ACPI: PCI Root Bridge [PCI4] (domain 0000 [bus 7c-7d])
[    2.330997] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.338954] acpi PNP0A08:04: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.349022] acpi PNP0A08:04: ECAM area [mem 0xd7c00000-0xd7dfffff] 
reserved by PNP0C02:00
[    2.357192] acpi PNP0A08:04: ECAM at [mem 0xd7c00000-0xd7dfffff] for 
[bus 7c-7d]
[    2.364629] PCI host bridge to bus 0000:7c
[    2.368715] pci_bus 0000:7c: root bus resource [mem 
0x120000000-0x13fffffff pref window]
[    2.376792] pci_bus 0000:7c: root bus resource [bus 7c-7d]
[    2.382271] pci 0000:7c:00.0: [19e5:a121] type 01 class 0x060400
[    2.388273] pci 0000:7c:00.0: enabling Extended Tags
[    2.393314] pci 0000:7d:00.0: [19e5:a222] type 00 class 0x020000
[    2.399314] pci 0000:7d:00.0: reg 0x10: [mem 0x120430000-0x12043ffff 
64bit pref]
[    2.406699] pci 0000:7d:00.0: reg 0x18: [mem 0x120300000-0x1203fffff 
64bit pref]
[    2.414105] pci 0000:7d:00.0: reg 0x224: [mem 0x00000000-0x0000ffff 
64bit pref]
[    2.421402] pci 0000:7d:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x000dffff 64bit pref] (contains BAR0 for 14 VFs)
[    2.431651] pci 0000:7d:00.0: reg 0x22c: [mem 0x00000000-0x000fffff 
64bit pref]
[    2.438947] pci 0000:7d:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x00dfffff 64bit pref] (contains BAR2 for 14 VFs)
[    2.449253] pci 0000:7d:00.1: [19e5:a222] type 00 class 0x020000
[    2.455252] pci 0000:7d:00.1: reg 0x10: [mem 0x120420000-0x12042ffff 
64bit pref]
[    2.462637] pci 0000:7d:00.1: reg 0x18: [mem 0x120200000-0x1202fffff 
64bit pref]
[    2.470041] pci 0000:7d:00.1: reg 0x224: [mem 0x00000000-0x0000ffff 
64bit pref]
[    2.477338] pci 0000:7d:00.1: VF(n) BAR0 space: [mem 
0x00000000-0x000dffff 64bit pref] (contains BAR0 for 14 VFs)
[    2.487587] pci 0000:7d:00.1: reg 0x22c: [mem 0x00000000-0x000fffff 
64bit pref]
[    2.494884] pci 0000:7d:00.1: VF(n) BAR2 space: [mem 
0x00000000-0x00dfffff 64bit pref] (contains BAR2 for 14 VFs)
[    2.505189] pci 0000:7d:00.2: [19e5:a222] type 00 class 0x020000
[    2.511188] pci 0000:7d:00.2: reg 0x10: [mem 0x120410000-0x12041ffff 
64bit pref]
[    2.518573] pci 0000:7d:00.2: reg 0x18: [mem 0x120100000-0x1201fffff 
64bit pref]
[    2.526016] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
[    2.532016] pci 0000:7d:00.3: reg 0x10: [mem 0x120400000-0x12040ffff 
64bit pref]
[    2.539401] pci 0000:7d:00.3: reg 0x18: [mem 0x120000000-0x1200fffff 
64bit pref]
[    2.546845] pci_bus 0000:7c: on NUMA node 0
[    2.551019] pci 0000:7c:00.0: bridge window [mem 
0x00100000-0x005fffff 64bit pref] to [bus 7d] add_size 1d00000 add_align 
100000
[    2.562570] pci 0000:7c:00.0: BAR 15: assigned [mem 
0x120000000-0x1221fffff 64bit pref]
[    2.570564] pci 0000:7d:00.0: BAR 2: assigned [mem 
0x120000000-0x1200fffff 64bit pref]
[    2.578470] pci 0000:7d:00.0: BAR 9: assigned [mem 
0x120100000-0x120efffff 64bit pref]
[    2.586374] pci 0000:7d:00.1: BAR 2: assign0.3: BAR 2: assigned [mem 
0x121f00000-0x121ffffff 64bit pref]
[    2.617993] pci 0000:7d:00.0: BAR 0: assigned [mem 
0x122000000-0x12200ffff 64bit pref]
[    2.625898] pci 0000:7d:00.0: BAR 7: assigned [mem 
0x122010000-0x1220effff 64bit pref]
[    2.633802] pci 0000:7d:00.1: BAR 0: assigned [mem 
0x1220f0000-0x1220fffff 64bit pref]
[    2.641706] pci 0000:7d:00.1: BAR 7: assigned [mem 
0x122100000-0x1221dffff 64bit pref]
[    2.649611] pci 0000:7d:00.2: BAR 0: assigned [mem 
0x1221e0000-0x1221effff 64bit pref]
[    2.657516] pci 0000:7d:00.3: BAR 0: assigned [mem 
0x1221f0000-0x1221fffff 64bit pref]
[    2.665422] pci 0000:7c:00.0: PCI bridge to [bus 7d]
[    2.670376] pci 0000:7c:00.0:   bridge window [mem 
0x120000000-0x1221fffff 64bit pref]
[    2.678280] pci_bus 0000:7c: resource 4 [mem 0x120000000-0x13fffffff 
pref window]
[    2.685750] pci_bus 0000:7d: resource 2 [mem 0x120000000-0x1221fffff 
64bit pref]
[    2.693165] ACPI: PCI Root Bridge [PCI5] (domain 0000 [bus 74-76])
[    2.699336] acpi PNP0A08:05: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.707293] acpi PNP0A08:05: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.717364] acpi PNP0A08:05: ECAM area [mem 0xd7400000-0xd76fffff] 
reserved by PNP0C02:00
[    2.725539] acpi PNP0A08:05: ECAM at [mem 0xd7400000-0xd76fffff] for 
[bus 74-76]
[    2.732986] PCI host bridge to bus 0000:74
[    2.737072] pci_bus 0000:74: root bus resource [mem 
0x144000000-0x147ffffff pref window]
[    2.745149] pci_bus 0000:74: root bus resource [mem 
0xa2000000-0xa2ffffff window]
[    2.752619] pci_bus 0000:74: root bus resource [bus 74-76]
[    2.758097] pci 0000:74:00.0: [19e5:a121] type 01 class 0x060400
[    2.764100] pci 0000:74:00.0: enabling Extended Tags
[    2.769112] pci 0000:74:02.0: [19e5:a230] type 00 class 0x010700
[    2.775118] pci 0000:74:02.0: reg 0x24: [mem 0xa2000000-0xa2007fff]
[    2.781435] pci 0000:74:03.0: [19e5:a235] type 00 class 0x010601
[    2.787440] pci 0000:74:03.0: reg 0x24: [mem 0xa2008000-0xa2008fff]
[    2.793779] pci 0000:75:00.0: [19e5:a250] type 00 class 0x120000
[    2.799780] pci 0000:75:00.0: reg 0x18: [mem 0x144000000-0x1443fffff 
64bit pref]
[    2.807189] pci 0000:75:00.0: reg 0x22c: [mem 0x00000000-0x0000ffff 
64bit pref]
[    2.814486] pci 0000:75:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x003effff 64bit pref] (contains BAR2 for 63 VFs)
[    2.824823] pci_bus 0000:74: on NUMA node 0
[    2.828996] pci 0000:74:00.0: bridge window [mem 
0x00400000-0x007fffff 64bit pref] to [bus 75] add_size 400000 add_align 
400000
[    2.840461] pci 0000:74:00.0: BAR 15: assigned [mem 
0x144000000-0x1447fffff 64bit pref]
[    2.848452] pci 0000:74:02.0: BAR 5: assigned [mem 0xa2000000-0xa2007fff]
[    2.855228] pci 0000:74:03.0: BAR 5: assigned [mem 0xa2008000-0xa2008fff]
[    2.862004] pci 0000:75:00.0: BAR 2: assigned [mem 
0x144000000-0x1443fffff 64bit pref]
[    2.869909] pci 0000:75:00.0: BAR 9: assigned [mem 
0x144400000-0x1447effff 64bit pref]
[    2.877814] pci 0000:74:00.0: PCI bridge to [bus 75]
[    2.882767] pci 0000:74:00.0:   bridge window [mem 
0x144000000-0x1447fffff 64bit pref]
[    2.890672] pci_bus 0000:74: resource 4 [mem 0x144000000-0x147ffffff 
pref window]
[    2.898142] pci_bus 0000:74: resource 5 [mem 0xa2000000-0xa2ffffff 
window]
[    2.905004] pci_bus 0000:75: resource 2 [mem 0x144000000-0x1447fffff 
64bit pref]
[    2.912419] ACPI: PCI Root Bridge [PCI6] (domain 0000 [bus 80-9f])
[    2.918590] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.926548] acpi PNP0A08:06: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.936620] acpi PNP0A08:06: ECAM area [mem 0xd8000000-0xd9ffffff] 
reserved by PNP0C02:00
[    2.944789] acpi PNP0A08:06: ECAM at [mem 0xd8000000-0xd9ffffff] for 
[bus 80-9f]
[    2.952189] Remapped I/O 0x00000000ffff0000 to [io  0x10000-0x1ffff 
window]
[    2.959177] PCI host bridge to bus 0000:80
[    2.963263] pci_bus 0000:80: root bus resource [mem 
0x480000000000-0x483fffffffff pref window]
[    2.971861] pci_bus 0000:80: root bus resource [mem 
0xf0000000-0xfffeffff window]
[    2.979331] pci_bus 0000:80: root bus resource [io  0x10000-0x1ffff 
window] (bus address [0x0000-0xffff])
[    2.988884] pci_bus 0000:80: root bus resource [bus 80-9f]
[    2.994365] pci 0000:80:00.0: [19e5:a120] type 01 class 0x060400
[    3.000436] pci 0000:80:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.007111] pci 0000:80:08.0: [19e5:a120] type 01 class 0x060400
[    3.013183] pci 0000:80:08.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.019858] pci 0000:80:0c.0: [19e5:a120] type 01 class 0x060400
[    3.025930] pci 0000:80:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.032605] pci 0000:80:10.0: [19e5:a120] type 01 class 0x060400
[    3.038677] pci 0000:80:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.045385] pci 0000:81:00.0: [19e5:0123] type 00 class 0x010802
[    3.051395] pci 0000:81:00.0: reg 0x10: [mem 0xf0000000-0xf003ffff 64bit]
[    3.058192] pci 0000:81:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    3.064948] pci 0000:81:00.0: supports D1 D2
[    3.069207] pci 0000:81:00.0: PME# supported from D3hot
[    3.074596] pci_bus 0000:80: on NUMA node 2
[    3.078771] pci 0000:80:00.0: BAR 14: assigned [mem 
0xf0000000-0xf00fffff]
[    3.085634] pci 0000:81:00.0: BAR 0: assigned [mem 
0xf0000000-0xf003ffff 64bit]
[    3.092958] pci 0000:81:00.0: BAR 6: assigned [mem 
0xf0040000-0xf005ffff pref]
[    3.100167] pci 0000:80:00.0: PCI bridge to [bus 81]
[    3.105121] pci 0000:80:00.0:   bridge window [mem 0xf0000000-0xf00fffff]
[    3.111898] pci 0000:80:08.0: PCI bridge to [bus 82]
[    3.116854] pci 0000:80:0c.0: PCI bridge to [bus 83]
[    3.121810] pci 0000:80:10.0: PCI bridge to [bus 84]
[    3.126766] pci_bus 0000:80: resource 4 [mem 
0x480000000000-0x483fffffffff pref window]
[    3.134756] pci_bus 0000:80: resource 5 [mem 0xf0000000-0xfffeffff 
window]
[    3.141618] pci_bus 0000:80: resource 6 [io  0x10000-0x1ffff window]
[    3.147959] pci_bus 0000:81: resource 1 [mem 0xf0000000-0xf00fffff]
[    3.154246] ACPI: PCI Root Bridge [PCI7] (domain 0000 [bus bb])
[    3.160156] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    3.168115] acpi PNP0A08:07: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    3.178190] acpi PNP0A08:07: ECAM area [mem 0xdbb00000-0xdbbfffff] 
reserved by PNP0C02:00
[    3.186366] acpi PNP0A08:07: ECAM at [mem 0xdbb00000-0xdbbfffff] for 
[bus bb]
[    3.193547] PCI host bridge to bus 0000:bb
[    3.197633] pci_bus 0000:bb: root bus resource [mem 
0x400148800000-0x400148ffffff pref window]
[    3.206231] pci_bus 0000:bb: root bus resource [bus bb]
[    3.211459] pci_bus 0000:bb: on NUMA node 2
[    3.215631] pci_bus 0000:bb: resource 4 [mem 
0x400148800000-0x400148ffffff pref window]
[    3.223645] ACPI: PCI Root Bridge [PCI8] (domain 0000 [bus ba])
[    3.229554] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    3.237510] acpi PNP0A08:08: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    3.247579] acpi PNP0A08:08: ECAM area [mem 0xdba00000-0xdbafffff] 
reserved by PNP0C02:00
[    3.255754] acpi PNP0A08:08: ECAM at [mem 0xdba00000-0xdbafffff] for 
[bus ba]
[    3.262934] PCI host bridge to bus 0000:ba
[    3.267020] pci_bus 0000:ba: root bus resource [mem 
0x40020c000000-0x40020c1fffff pref window]
[    3.275618] pci_bus 0000:ba: root bus resource [bus ba]
[    3.280837] pci 0000:ba:00.0: [19e5:a239] type 00 class 0x0c0310
[    3.286837] pci 0000:ba:00.0: reg 0x10: [mem 
0x40020c100000-0x40020c100fff 64bit pref]
[    3.294805] pci 0000:ba:01.0: [19e5:a239] type 00 class 0x0c0320
[    3.300806] pci 0000:ba:01.0: reg 0x10: [mem 
0x40020c101000-0x40020c101fff 64bit pref]
[    3.308775] pci 0000:ba:02.0: [19e5:a238] type 00 class 0x0c0330
[    3.314775] pci 0000:ba:02.0: reg 0x10: [mem 
0x40020c000000-0x40020c0fffff 64bit pref]
[    3.322749] pci_bus 0000:ba: on NUMA node 2
[    3.326923] pci 0000:ba:02.0: BAR 0: assigned [mem 
0x40020c000000-0x40020c0fffff 64bit pref]
[    3.335350] pci 0000:ba:00.0: BAR 0: assigned [mem 
0x40020c100000-0x40020c100fff 64bit pref]
[    3.343776] pci 0000:ba:01.0: BAR 0: assigned [mem 
0x40020c101000-0x40020c101fff 64bit pref]
[    3.352203] pci_bus 0000:ba: resource 4 [mem 
0x40020c000000-0x40020c1fffff pref window]
[    3.360221] ACPI: PCI Root Bridge [PCI9] (domain 0000 [bus b8-b9])
[    3.366391] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    3.374347] acpi PNP0A08:09: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    3.384417] acpi PNP0A08:09: ECAM area [mem 0xdb800000-0xdb9fffff] 
reserved by PNP0C02:00
[    3.392585] acpi PNP0A08:09: ECAM at [mem 0xdb800000-0xdb9fffff] for 
[bus b8-b9]
[    3.400024] PCI host bridge to bus 0000:b8
[    3.404110] pci_bus 0000:b8: root bus resource [mem 
0x400208000000-0x400208ffffff pref window]
[    3.412708] pci_bus 0000:b8: root bus resource [bus b8-b9]
[    3.418188] pci 0000:b8:00.0: [19e5:a258] type 00 class 0x100000
[    3.424190] pci 0000:b8:00.0: reg 0x18: [mem 0x00000000-0x001fffff 
64bit pref]
[    3.431468] pci_bus 0000:b8: on NUMA node 2
[    3.435641] pci 0000:b8:00.0: BAR 2: assigned [mem 
0x400208000000-0x4002081fffff 64bit pref]
[    3.444068] pci_bus 0000:b8: resource 4 [mem 
0x400208000000-0x400208ffffff pref window]
[    3.452083] ACPI: PCI Root Bridge [PCIA] (domain 0000 [bus bc-bd])
[    3.458254] acpi PNP0A08:0a: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    3.466210] acpi PNP0A08:0a: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    3.476278] acpi PNP0A08:0a: ECAM area [mem 0xdbc00000-0xdbdfffff] 
reserved by PNP0C02:00
[    3.484446] acpi PNP0A08:0a: ECAM at [mem 0xdbc00000-0xdbdfffff] for 
[bus bc-bd]
[    3.491885] PCI host bridge to bus 0000:bc
[    3.495971] pci_bus 0000:bc: root bus resource [mem 
0x400120000000-0x40013fffffff pref window]
[    3.504570] pci_bus 0000:bc: root bus resource [bus bc-bd]
[    3.510050] pci 0000:bc:00.0: [19e5:a121] type 01 class 0x060400
[    3.516055] pci 0000:bc:00.0: enabling Extended Tags
[    3.521100] pci 0000:bd:00.0: [19e5:a226] type 00 class 0x020000
[    3.527102] pci 0000:bd:00.0: reg 0x10: [mem 
0x400120100000-0x40012010ffff 64bit pref]
[    3.535008] pci 0000:bd:00.0: reg 0x18: [mem 
0x400120000000-0x4001200fffff 64bit pref]
[    3.542943] pci 0000:bd:00.0: reg 0x224: [mem 0x00000000-0x0000ffff 
64bit pref]
[    3.550240] pci 0000:bd:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x001effff 64bit pref] (contains BAR0 for 31 VFs)
[    3.560490] pci 0000:bd:00.0: reg 0x22c: [mem 0x00000000-0x000fffff 
64bit pref]
[    3.567786] pci 0000:bd:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x01efffff 64bit pref] (contains BAR2 for 31 VFs)
[    3.578113] pci_bus 0000:bc: on NUMA node 2
[    3.582287] pci 0000:bc:00.0: bridge window [mem 
0x00100000-0x002fffff 64bit pref] to [bus bd] add_size 2000000 add_align 
100000
[    3.593837] pci 0000:bc:00.0: BAR 15: assigned [mem 
0x400120000000-0x4001221fffff 64bit pref]
[    3.602350] pci 0000:bd:00.0: BAR 2: assigned [mem 
0x400120000000-0x4001200fffff 64bit pref]
[    3.610776] pci 0000:bd:00.0: BAR 9: assigned [mem 
0x400120100000-0x400121ffffff 64bit pref]
[    3.619202] pci 0000:bd:00.0: BAR 0: assigned [mem 
0x400122000000-0x40012200ffff 64bit pref]
[    3.627628] pci 0000:bd:00.0: BAR 7: assigned [mem 
0x400122010000-0x4001221fffff 64bit pref]
[    3.636053] pci 0000:bc:00.0: PCI bridge to [bus bd]
[    3.641007] pci 0000:bc:00.0:   bridge window [mem 
0x400120000000-0x4001221fffff 64bit pref]
[    3.649433] pci_bus 0000:bc: resource 4 [mem 
0x400120000000-0x40013fffffff pref window]
[    3.657423] pci_bus 0000:bd: resource 2 [mem 
0x400120000000-0x4001221fffff 64bit pref]
[    3.665356] ACPI: PCI Root Bridge [PCIB] (domain 0000 [bus b4-b6])
[    3.671526] acpi PNP0A08:0b: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    3.679483] acpi PNP0A08:0b: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    3.689551] acpi PNP0A08:0b: ECAM area [mem 0xdb400000-0xdb6fffff] 
reserved by PNP0C02:00
[    3.697726] acpi PNP0A08:0b: ECAM at [mem 0xdb400000-0xdb6fffff] for 
[bus b4-b6]
[    3.705168] PCI host bridge to bus 0000:b4
[    3.709254] pci_bus 0000:b4: root bus resource [mem 
0x400144000000-0x400147ffffff pref window]
[    3.717852] pci_bus 0000:b4: root bus resource [mem 
0xa3000000-0xa3ffffff window]
[    3.725322] pci_bus 0000:b4: root bus resource [bus b4-b6]
[    3.730801] pci 0000:b4:00.0: [19e5:a121] type 01 class 0x060400
[    3.736806] pci 0000:b4:00.0: enabling Extended Tags
[    3.741851] pci 0000:b5:00.0: [19e5:a250] type 00 class 0x120000
[    3.747854] pci 0000:b5:00.0: reg 0x18: [mem 
0x400144000000-0x4001443fffff 64bit pref]
[    3.755790] pci 0000:b5:00.0: reg 0x22c: [mem 0x00000000-0x0000ffff 
64bit pref]
[    3.763087] pci 0000:b5:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x003effff 64bit pref] (contains BAR2 for 63 VFs)
[    3.773441] pci_bus 0000:b4: on NUMA node 2
[    3.777614] pci 0000:b4:00.0: bridge window [mem 
0x00400000-0x007fffff 64bit pref] to [bus b5] add_size 400000 add_align 
400000
[    3.789078] pci 0000:b4:00.0: BAR 15: assigned [mem 
0x400144000000-0x4001447fffff 64bit pref]
[    3.797591] pci 0000:b5:00.0: BAR 2: assigned [mem 
0x400144000000-0x4001443fffff 64bit pref]
[    3.806017] pci 0000:b5:00.0: BAR 9: assigned [mem 
0x400144400000-0x4001447effff 64bit pref]
[    3.814442] pci 0000:b4:00.0: PCI bridge to [bus b5]
[    3.819396] pci 0000:b4:00.0:   bridge window [mem 
0x400144000000-0x4001447fffff 64bit pref]
[    3.827821] pci_bus 0000:b4: resource 4 [mem 
0x400144000000-0x400147ffffff pref window]
[    3.835812] pci_bus 0000:b4: resource 5 [mem 0xa3000000-0xa3ffffff 
window]
[    3.842674] pci_bus 0000:b5: resource 2 [mem 
0x400144000000-0x4001447fffff 64bit pref]
[    3.858683] pci 0000:05:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[    3.867041] pci 0000:05:00.0: vgaarb: bridge control possible
[    3.872776] pci 0000:05:00.0: vgaarb: setting as boot device (VGA 
legacy resources not available)
[    3.881634] vgaarb: loaded
[    3.884418] SCSI subsystem initialized
[    3.892175] libata version 3.00 loaded.
[    3.896044] ACPI: bus type USB registered
[    3.900074] usbcore: registered new interface driver usbfs
[    3.905559] usbcore: registered new interface driver hub
[    3.910870] usbcore: registered new device driver usb
[    3.916240] pps_core: LinuxPPS API ver. 1 registered
[    3.921196] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    3.930319] PTP clock support registered
[    3.934283] EDAC MC: Ver: 3.0.0
[    3.941503] Registered efivars operations
[    3.949568] FPGA manager framework
[    3.952979] Advanced Linux Sound Architecture Driver Initialized.
[    3.959288] clocksource: Switched to clocksource arch_sys_counter
[    3.965434] VFS: Disk quotas dquot_6.6.0
[    3.969361] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    3.976282] pnp: PnP ACPI init
[    3.979659] system 00:00: [mem 0xd0000000-0xdfffffff] could not be 
reserved
[    3.986615] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.993485] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    4.000098] pnp: PnP ACPI: found 2 devices
[    4.005773] thermal_sys: Registered thermal governor 'step_wise'
[    4.005774] thermal_sys: Registered thermal governor 'power_allocator'
[    4.011818] NET: Registered protocol family 2
[    4.022789] tcp_listen_portaddr_hash hash table entries: 8192 (order: 
5, 131072 bytes, linear)
[    4.031433] TCP established hash table entries: 131072 (order: 8, 
1048576 bytes, linear)
[    4.039707] TCP bind hash table entries: 65536 (order: 8, 1048576 
bytes, linear)
[    4.047308] TCP: Hash tables configured (established 131072 bind 65536)
[    4.053936] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    4.060745] UDP-Lite hash table entries: 8192 (order: 6, 262144 
bytes, linear)
[    4.068018] NET: Registered protocol family 1
[    4.084488] RPC: Registered named UNIX socket transport module.
[    4.090404] RPC: Registered udp transport module.
[    4.095096] RPC: Registered tcp transport module.
[    4.099788] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    4.106241] pci 0000:7a:00.0: enabling device (0000 -> 0002)
[    4.111909] pci 0000:7a:02.0: enabling device (0000 -> 0002)
[    4.117600] pci 0000:ba:00.0: enabling device (0000 -> 0002)
[    4.123263] pci 0000:ba:02.0: enabling device (0000 -> 0002)
[    4.128934] PCI: CLS 32 bytes, default 64
[    4.132972] Unpacking initramfs...
[    7.614661] Freeing initrd memory: 293960K
[    7.618846] hw perfevents: enabled with armv8_pmuv3_0 PMU driver, 13 
counters available
[    7.626845] kvm [1]: IPA Size Limit: 48bits
[    7.631019] kvm [1]: GICv4 support disabled
[    7.635191] kvm [1]: GICv3: no GICV resource entry
[    7.639969] kvm [1]: disabling GICv2 emulation
[    7.644416] kvm [1]: GIC system register CPU interface enabled
[    7.650248] kvm [1]: vgic interrupt IRQ1
[    7.654188] kvm [1]: VHE mode initialized successfully
[    7.682859] Initialise system trusted keyrings
[    7.687436] workingset: timestamp_bits=44 max_order=22 bucket_order=0
[    7.696322] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.706395] NFS: Registering the id_resolver key type
[    7.711446] Key type id_resolver registered
[    7.715618] Key type id_legacy registered
[    7.719618] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    7.726347] 9p: Installing v9fs 9p2000 file system support
[    7.738435] Key type asymmetric registered
[    7.742533] Asymmetric key parser 'x509' registered
[    7.747420] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 245)
[    7.754824] io scheduler mq-deadline registered
[    7.759348] io scheduler kyber registered
[    7.763642] ITS: alloc 8192:32
[    7.766686] ITT 32 entries, 5 bits
[    7.770101] ITS: alloc 8224:32
[    7.773147] ITT 32 entries, 5 bits
[    7.776555] ITS: alloc 8256:32
[    7.779601] ITT 32 entries, 5 bits
[    7.783008] ITS: alloc 8288:32
[    7.786054] ITT 32 entries, 5 bits
[    7.789462] ITS: alloc 8320:32
[    7.792508] ITT 32 entries, 5 bits
[    7.795921] ITS: alloc 8352:32
[    7.798963] ITT 32 entries, 5 bits
[    7.802372] ITS: alloc 8384:32
[    7.805418] ITT 32 entries, 5 bits
[    7.808827] ITS: alloc 8416:32
[    7.811872] ITT 32 entries, 5 bits
[    7.815280] ITS: alloc 8448:32
[    7.818326] ITT 32 entries, 5 bits
[    7.821734] ITS: alloc 8480:32
[    7.824779] ITT 32 entries, 5 bits
[    7.828189] ITS: alloc 8512:32
[    7.831231] ITT 32 entries, 5 bits
[    7.834642] ITS: alloc 8544:32
[    7.837687] ITT 32 entries, 5 bits
[    7.841098] ITS: alloc 8576:32
[    7.844143] ITT 32 entries, 5 bits
[    7.847554] ITS: alloc 8608:32
[    7.850596] ITT 32 entries, 5 bits
[    7.854007] ITS: alloc 8640:32
[    7.857053] ITT 32 entries, 5 bits
[    7.860464] ITS: alloc 8672:32
[    7.863509] ITT 32 entries, 5 bits
[    7.866919] ITS: alloc 8704:32
[    7.869964] ITT 32 entries, 5 bits
[    7.873376] ITS: alloc 8736:32
[    7.876421] ITT 32 entries, 5 bits
[    7.879833] ITS: alloc 8768:32
[    7.882875] ITT 32 entries, 5 bits
[    7.886288] ITS: alloc 8800:32
[    7.889333] ITT 32 entries, 5 bits
[    7.892745] ITS: alloc 8832:32
[    7.895790] ITT 32 entries, 5 bits
[    7.899205] ITS: alloc 8864:32
[    7.902249] ITT 32 entries, 5 bits
[    7.905662] ITS: alloc 8896:32
[    7.908707] ITT 32 entries, 5 bits
[    7.912122] ITS: alloc 8928:32
[    7.915164] ITT 32 entries, 5 bits
[    7.918581] ITS: alloc 8960:32
[    7.921626] ITT 32 entries, 5 bits
[    7.925041] ITS: alloc 8992:32
[    7.928086] ITT 32 entries, 5 bits
[    7.931501] ITS: alloc 9024:32
[    7.934544] ITT 32 entries, 5 bits
[    7.937959] ITS: alloc 9056:32
[    7.941004] ITT 32 entries, 5 bits
[    7.944419] ITS: alloc 9088:32
[    7.947463] ITT 32 entries, 5 bits
[    7.950880] ITS: alloc 9120:32
[    7.953926] ITT 32 entries, 5 bits
[    7.957342] ITS: alloc 9152:32
[    7.960388] ITT 32 entries, 5 bits
[    7.963804] ITS: alloc 9184:32
[    7.966847] ITT 32 entries, 5 bits
[    7.970266] ITS: alloc 9216:32
[    7.973310] ITT 32 entries, 5 bits
[    7.976727] ITS: alloc 9248:32
[    7.979772] ITT 32 entries, 5 bits
[    7.983188] ITS: alloc 9280:32
[    7.986233] ITT 32 entries, 5 bits
[    7.989653] ITS: alloc 9312:32
[    7.992697] ITT 32 entries, 5 bits
[    7.996116] ITS: alloc 9344:32
[    7.999159] ITT 32 entries, 5 bits
[    8.002578] ITS: alloc 9376:32
[    8.005622] ITT 32 entries, 5 bits
[    8.009040] ITS: alloc 9408:32
[    8.012085] ITT 32 entries, 5 bits
[    8.015505] ITS: alloc 9440:32
[    8.018548] ITT 32 entries, 5 bits
[    8.021970] ITS: alloc 9472:32
[    8.025015] ITT 32 entries, 5 bits
[    8.028434] ITS: alloc 9504:32
[    8.031479] ITT 32 entries, 5 bits
[    8.034898] ITS: alloc 9536:32
[    8.037943] ITT 32 entries, 5 bits
[    8.041363] ITS: alloc 9568:32
[    8.044407] ITT 32 entries, 5 bits
[    8.047830] ITS: alloc 9600:32
[    8.050872] ITT 32 entries, 5 bits
[    8.054295] ITS: alloc 9632:32
[    8.057340] ITT 32 entries, 5 bits
[    8.060762] ITS: alloc 9664:32
[    8.063807] ITT 32 entries, 5 bits
[    8.067227] ITS: alloc 9696:32
[    8.070272] ITT 32 entries, 5 bits
[    8.084052] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    8.092414] ACPI: Power Button [PWRB]
[    8.100739] [Firmware Bug]: APEI: Invalid bit width + offset in GAR 
[0x94110034/64/0/3/0]
[    8.109050] EDAC MC0: Giving out device to module ghes_edac.c 
controller ghes_edac: DEV ghes (INTERRUPT)
[    8.118721] GHES: APEI firmware first mode is enabled by APEI bit and 
WHEA _OSC.
[    8.126155] EINJ: Error INJection is initialized.
[    8.130965] ACPI GTDT: found 1 SBSA generic Watchdog(s).
[    8.145041] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.171838] 00:01: ttyS0 at MMIO 0x3f00003f8 (irq = 6, base_baud = 
115200) is a 16550A
[    8.180997] SuperH (H)SCI(F) driver initialized
[    8.185888] msm_serial: driver initialized
[    8.190477] arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
[    8.196053] arm-smmu-v3 arm-smmu-v3.0.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.204290] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 65536 entries 
for cmdq
[    8.211477] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 32768 entries 
for evtq
[    8.218528] ITS: alloc 9728:32
[    8.221573] ITT 32 entries, 5 bits
[    8.224978] ID:0 pID:9728 vID:11
[    8.228212] ID:1 pID:9729 vID:12
[    8.231637] arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x0
[    8.237208] arm-smmu-v3 arm-smmu-v3.1.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.245384] arm-smmu-v3 arm-smmu-v3.1.auto: allocated 65536 entries 
for cmdq
[    8.252689] arm-smmu-v3 arm-smmu-v3.1.auto: allocated 32768 entries 
for evtq
[    8.259737] ITS: alloc 9760:32
[    8.262780] ITT 32 entries, 5 bits
[    8.266182] ID:0 pID:9760 vID:13
[    8.269410] ID:1 pID:9761 vID:14
[    8.272715] arm-smmu-v3 arm-smmu-v3.2.auto: option mask 0x0
[    8.278283] arm-smmu-v3 arm-smmu-v3.2.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.286450] arm-smmu-v3 arm-smmu-v3.2.auto: allocated 65536 entries 
for cmdq
[    8.293639] arm-smmu-v3 arm-smmu-v3.2.auto: allocated 32768 entries 
for evtq
[    8.300687] ITS: alloc 9792:32
[    8.303732] ITT 32 entries, 5 bits
[    8.307129] ID:0 pID:9792 vID:15
[    8.310357] ID:1 pID:9793 vID:16
[    8.313656] arm-smmu-v3 arm-smmu-v3.3.auto: option mask 0x0
[    8.319229] arm-smmu-v3 arm-smmu-v3.3.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.327410] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries 
for cmdq
[    8.334716] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 32768 entries 
for evtq
[    8.341766] ITS: alloc 9824:32
[    8.344811] ITT 32 entries, 5 bits
[    8.348213] ID:0 pID:9824 vID:17
[    8.351444] ID:1 pID:9825 vID:18
[    8.354742] arm-smmu-v3 arm-smmu-v3.4.auto: option mask 0x0
[    8.360312] arm-smmu-v3 arm-smmu-v3.4.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.368479] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 65536 entries 
for cmdq
[    8.375667] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 32768 entries 
for evtq
[    8.382716] ITS: alloc 9856:32
[    8.385761] ITT 32 entries, 5 bits
[    8.389163] ID:0 pID:9856 vID:19
[    8.392397] ID:1 pID:9857 vID:20
[    8.395695] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x0
[    8.401263] arm-smmu-v3 arm-smmu-v3.5.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.409446] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 65536 entries 
for cmdq
[    8.416750] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 32768 entries 
for evtq
[    8.423799] ITS: alloc 9888:32
[    8.426842] ITT 32 entries, 5 bits
[    8.430246] ID:0 pID:9888 vID:21
[    8.433477] ID:1 pID:9889 vID:22
[    8.439005] loop: module loaded
[    8.443175] hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 0
[    8.468725] scsi host0: hisi_sas_v3_hw
[    9.691363] ITS: alloc 9920:32
[    9.694409] ITT 32 entries, 5 bits
[    9.697936] ID:0 pID:9920 vID:23
[    9.701155] ID:1 pID:9921 vID:24
[    9.704372] ID:2 pID:9922 vID:25
[    9.707588] ID:3 pID:9923 vID:26
[    9.710803] ID:4 pID:9924 vID:27
[    9.714019] ID:5 pID:9925 vID:28
[    9.717235] ID:6 pID:9926 vID:29
[    9.720451] ID:7 pID:9927 vID:30
[    9.723667] ID:8 pID:9928 vID:31
[    9.726881] ID:9 pID:9929 vID:32
[    9.730097] ID:10 pID:9930 vID:33
[    9.733401] ID:11 pID:9931 vID:34
[    9.736704] ID:12 pID:9932 vID:35
[    9.740007] ID:13 pID:9933 vID:36
[    9.743310] ID:14 pID:9934 vID:37
[    9.746611] ID:15 pID:9935 vID:38
[    9.749914] ID:16 pID:9936 vID:39
[    9.830405] hisi_sas_v3_hw 0000:74:02.0: phyup: phy7 link_rate=11
[    9.836490] hisi_sas_v3_hw 0000:74:02.0: phyup: phy0 link_rate=11
[    9.842571] hisi_sas_v3_hw 0000:74:02.0: phyup: phy1 link_rate=11
[    9.848652] hisi_sas_v3_hw 0000:74:02.0: phyup: phy2 link_rate=11
[    9.854732] hisi_sas_v3_hw 0000:74:02.0: phyup: phy3 link_rate=11
[    9.860813] hisi_sas_v3_hw 0000:74:02.0: phyup: phy4 link_rate=11
[    9.866893] hisi_sas_v3_hw 0000:74:02.0: phyup: phy5 link_rate=11
[    9.872973] hisi_sas_v3_hw 0000:74:02.0: phyup: phy6 link_rate=11
[    9.879095] sas: phy-0:7 added to port-0:0, phy_mask:0x80 
(500e004aaaaaaa1f)
[    9.890175] sas: DOING DISCOVERY on port 0, pid:24
[    9.895101] hisi_sas_v3_hw 0000:74:02.0: dev[1:2] found
[    9.900828] sas: ex 500e004aaaaaaa1f phy00:U:0 attached: 
0000000000000000 (no device)
[    9.908806] sas: ex 500e004aaaaaaa1f phy01:U:0 attached: 
0000000000000000 (no device)
[    9.916799] sas: ex 500e004aaaaaaa1f phy02:U:B attached: 
5000c500a7b95a49 (ssp)
[    9.924240] sas: ex 500e004aaaaaaa1f phy03:U:0 attached: 
0000000000000000 (no device)
[    9.932227] sas: ex 500e004aaaaaaa1f phy04:U:0 attached: 
0000000000000000 (no device)
[    9.940155] sas: ex 500e004aaaaaaa1f phy05:U:B attached: 
5000c500a7babc61 (ssp)
[    9.947619] sas: ex 500e004aaaaaaa1f phy06:U:0 attached: 
0000000000000000 (no device)
[    9.955590] sas: ex 500e004aaaaaaa1f phy07:U:0 attached: 
0000000000000000 (no device)
[    9.963569] sas: ex 500e004aaaaaaa1f phy08:U:8 attached: 
500e004aaaaaaa08 (stp)
[    9.970977] sas: ex 500e004aaaaaaa1f phy09:U:0 attached: 
0000000000000000 (no device)
[    9.978967] sas: ex 500e004aaaaaaa1f phy10:U:0 attached: 
0000000000000000 (no device)
[    9.986943] sas: ex 500e004aaaaaaa1f phy11:U:A attached: 
5000c50085ff5559 (ssp)
[    9.994400] sas: ex 500e004aaaaaaa1f phy12:U:0 attached: 
0000000000000000 (no device)
[   10.002375] sas: ex 500e004aaaaaaa1f phy13:U:0 attached: 
0000000000000000 (no device)
[   10.010327] sas: ex 500e004aaaaaaa1f phy14:U:0 attached: 
0000000000000000 (no device)
[   10.018307] sas: ex 500e004aaaaaaa1f phy15:U:0 attached: 
0000000000000000 (no device)
[   10.026318] sas: ex 500e004aaaaaaa1f phy16:U:B attached: 
00188600001c9098 (host)
[   10.033853] sas: ex 500e004aaaaaaa1f phy17:U:B attached: 
00188600001c9098 (host)
[   10.041376] sas: ex 500e004aaaaaaa1f phy18:U:B attached: 
00188600001c9098 (host)
[   10.048923] sas: ex 500e004aaaaaaa1f phy19:U:B attached: 
00188600001c9098 (host)
[   10.056481] sas: ex 500e004aaaaaaa1f phy20:U:B attached: 
00188600001c9098 (host)
[   10.064017] sas: ex 500e004aaaaaaa1f phy21:U:B attached: 
00188600001c9098 (host)
[   10.071567] sas: ex 500e004aaaaaaa1f phy22:U:B attached: 
00188600001c9098 (host)
[   10.079106] sas: ex 500e004aaaaaaa1f phy23:U:B attached: 
00188600001c9098 (host)
[   10.086629] sas: ex 500e004aaaaaaa1f phy24:D:B attached: 
500e004aaaaaaa1e (host+target)
[   10.094660] hisi_sas_v3_hw 0000:74:02.0: dev[2:1] found
[   10.099961] hisi_sas_v3_hw 0000:74:02.0: dev[3:1] found
[   10.105476] hisi_sas_v3_hw 0000:74:02.0: dev[4:5] found
[   10.267943] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] found
[   10.273303] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] found
[   10.278680] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[   10.284509] sas: ata1: end_device-0:0:8: dev error handler
[   12.465009] ata1.00: ATA-8: SAMSUNG HM320JI, 2SS00_01, max UDMA7
[   12.471005] ata1.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 32)
[   12.482997] ata1.00: configured for UDMA/133
[   12.487263] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 
tries: 1
[   12.509528] scsi 0:0:0:0: Direct-Access     SEAGATE  ST2000NM0045 
N004 PQ: 0 ANSI: 6
[   12.521516] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[   12.535028] scsi 0:0:1:0: Direct-Access     SEAGATE  ST2000NM0045 
N004 PQ: 0 ANSI: 6
[   12.545577] scsi 0:0:2:0: Direct-Access     ATA      SAMSUNG HM320JI 
0_01 PQ: 0 ANSI: 5
[   12.554327] sd 0:0:0:0: [sda] Write Protect is off
[   12.559170] scsi 0:0:3:0: Direct-Access     SEAGATE  ST1000NM0023 
0006 PQ: 0 ANSI: 6
[   12.567292] sd 0:0:2:0: [sdc] 625142448 512-byte logical blocks: (320 
GB/298 GiB)
[   12.574766] sd 0:0:0:0: [sda] Mode Sense: db 00 10 08
[   12.579815] sd 0:0:2:0: [sdc] Write Protect is off
[   12.584609] sd 0:0:2:0: [sdc] Mode Sense: 00 3a 00 00
[   12.589694] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   12.598745] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[   12.608239] sd 0:0:1:0: [sdb] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[   12.616727] sd 0:0:1:0: [sdb] Write Protect is off
[   12.621522] sd 0:0:1:0: [sdb] Mode Sense: db 00 10 08
[   12.627833] scsi 0:0:4:0: Enclosure         HUAWEI   Expander 12Gx16 
128  PQ: 0 ANSI: 6
[   12.635978] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[   12.644518]  sdc: sdc1 sdc2 sdc3
[   12.648099] sd 0:0:2:0: [sdc] Attached SCSI disk
[   12.653291] sd 0:0:3:0: [sdd] 1953525168 512-byte logical blocks: 
(1.00 TB/932 GiB)
[   12.661130] sas: DONE DISCOVERY on port 0, pid:24, result:0
[   12.666851] sd 0:0:3:0: [sdd] Write Protect is off
[   12.671673] sas: phy0 matched wide port0
[   12.675623] sas: phy-0:0 added to port-0:0, phy_mask:0x81 
(500e004aaaaaaa1f)
[   12.682693] sd 0:0:3:0: [sdd] Mode Sense: db 00 10 08
[   12.687781] sas: REVALIDATING DOMAIN on port 0, pid:24
[   12.693235] sd 0:0:3:0: [sdd] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[   12.701787]  sda: sda1
[   12.704472] sas: ex 500e004aaaaaaa1f phy08 change count has changed
[   12.711277] sas: ex 500e004aaaaaaa1f phy08 originated BROADCAST(CHANGE)
[   12.717918] sas: ex 500e004aaaaaaa1f rediscovering phy08
[   12.723422] sas: ex 500e004aaaaaaa1f phy08 broadcast flutter
[   12.729560]  sdb: sdb1
[   12.732507] sas: done REVALIDATING DOMAIN on port 0, pid:24, res 0x0
[   12.738889] sas: phy1 matched wide port0
[   12.742840] sas: phy-0:1 added to port-0:0, phy_mask:0x83 
(500e004aaaaaaa1f)
[   12.749936] sas: REVALIDATING DOMAIN on port 0, pid:24
[   12.755435] sd 0:0:0:0: [sda] Attached SCSI disk
[   12.760520]  sdd: sdd1 sdd2
[   12.763852] random: fast init done
[   12.767367] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.772693] sas: done REVALIDATING DOMAIN on port 0, pid:24, res 0x0
[   12.779066] sas: phy2 matched wide port0
[   12.782991] sd 0:0:1:0: [sdb] Attached SCSI disk
[   12.787608] sas: phy-0:2 added to port-0:0, phy_mask:0x87 
(500e004aaaaaaa1f)
[   12.794670] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.801029] sd 0:0:3:0: [sdd] Attached SCSI disk
[   12.805864] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.811164] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.817596] sas: phy3 matched wide port0
[   12.821512] sas: phy-0:3 added to port-0:0, phy_mask:0x8f 
(500e004aaaaaaa1f)
[   12.828552] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.835014] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.840314] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.846745] sas: phy4 matched wide port0
[   12.850661] sas: phy-0:4 added to port-0:0, phy_mask:0x9f 
(500e004aaaaaaa1f)
[   12.857701] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.864148] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.869448] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.875879] sas: phy5 matched wide port0
[   12.879795] sas: phy-0:5 added to port-0:0, phy_mask:0xbf 
(500e004aaaaaaa1f)
[   12.886834] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.893285] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.898585] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.905016] sas: phy6 matched wide port0
[   12.908932] sas: phy-0:6 added to port-0:0, phy_mask:0xff 
(500e004aaaaaaa1f)
[   12.915971] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.922405] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.927706] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.934137] sas: broadcast received: 0
[   12.937877] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.944316] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.949616] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.956046] sas: broadcast received: 0
[   12.959787] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.966232] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.971531] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.977962] sas: broadcast received: 0
[   12.981703] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.988157] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.993457] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.999888] sas: broadcast received: 0
[   13.003628] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.010081] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.015381] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.021811] sas: broadcast received: 0
[   13.025551] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.032007] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.037307] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.043737] sas: broadcast received: 0
[   13.047477] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.053945] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.059245] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.065676] sas: broadcast received: 0
[   13.069416] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.075870] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.081169] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.087600] sas: broadcast received: 0
[   13.091340] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.097790] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.103090] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.109521] sas: broadcast received: 0
[   13.113261] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.119716] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.125016] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.131447] sas: broadcast received: 0
[   13.135184] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.141640] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.146939] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.153370] sas: broadcast received: 0
[   13.157111] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.163567] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.168867] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.175297] sas: broadcast received: 0
[   13.179034] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.185486] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.190786] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.197217] sas: broadcast received: 0
[   13.200958] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.207408] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.212707] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.219138] sas: broadcast received: 0
[   13.222878] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.229313] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.234613] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.241043] sas: broadcast received: 0
[   13.244784] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.251266] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.256566] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.262996] sas: broadcast received: 0
[   13.266737] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.273208] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.278508] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.284938] sas: broadcast received: 0
[   13.288678] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.295130] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.300430] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.306860] sas: broadcast received: 0
[   13.310601] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.317053] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.322353] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.328784] sas: broadcast received: 0
[   13.332524] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.338977] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.344276] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.350707] sas: broadcast received: 0
[   13.354447] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.360916] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.366216] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.372646] sas: broadcast received: 0
[   13.376387] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.382843] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.388143] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.394574] sas: broadcast received: 0
[   13.398315] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.404769] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.410069] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.416499] sas: broadcast received: 0
[   13.420240] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.426691] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.431991] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.438421] sas: broadcast received: 0
[   13.442161] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.448611] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.453911] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.460341] sas: broadcast received: 0
[   13.464082] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.470546] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.475846] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.482277] sas: broadcast received: 0
[   13.486031] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.492486] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.497785] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.504216] sas: broadcast received: 0
[   13.507957] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.514409] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.519709] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.526139] sas: broadcast received: 0
[   13.529880] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.536339] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.541639] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.548069] sas: broadcast received: 0
[   13.551810] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.558255] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.563554] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.569985] sas: broadcast received: 0
[   13.573725] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.580197] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.585497] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.591927] sas: broadcast received: 0
[   13.595668] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.602120] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.607420] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.613851] sas: broadcast received: 0
[   13.617591] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.624047] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.629347] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.635917] ahci 0000:74:03.0: Adding to iommu group 1
[   13.641118] ahci 0000:74:03.0: version 3.0
[   13.645241] ITS: alloc 9952:2
[   13.648201] ITT 2 entries, 1 bits
[   13.651528] ID:0 pID:9952 vID:41
[   13.654742] ID:1 pID:9953 vID:42
[   13.657971] ahci 0000:74:03.0: SSS flag set, parallel bus scan disabled
[   13.664581] ahci 0000:74:03.0: AHCI 0001.0300 32 slots 2 ports 6 Gbps 
0x3 impl SATA mode
[   13.672660] ahci 0000:74:03.0: flags: 64bit ncq sntf stag pm led clo 
only pmp fbs slum part ccc sxs boh
[   13.686443] scsi host1: ahci
[   13.693429] scsi host2: ahci
[   13.696360] ata2: SATA max UDMA/133 abar m4096@0xa2008000 port 
0xa2008100 irq 41
[   13.703748] ata3: SATA max UDMA/133 abar m4096@0xa2008000 port 
0xa2008180 irq 42
[   13.714013] libphy: Fixed MDIO Bus: probed
[   13.718222] tun: Universal TUN/TAP device driver, 1.6
[   13.723867] thunder_xcv, ver 1.0
[   13.727108] thunder_bgx, ver 1.0
[   13.730363] nicpf, ver 1.0
[   13.733758] hclge is initializing
[   13.737073] hns3: Hisilicon Ethernet Network Driver for Hip08 Family 
- version
[   149] hns3 0000:7d:00.0: The firmware version is b0620130
[   13.760904] ITS: alloc 9954:256
[   13.764038] ITT 256 entries, 8 bits
[   13.767529] ID:0 pID:9954 vID:43
[   13.770754] ID:1 pID:9955 vID:44
[   13.773980] ID:2 pID:9956 vID:45
[   13.777206] ID:3 pID:9957 vID:46
[   13.780431] ID:4 pID:9958 vID:47
[   13.783656] ID:5 pID:9959 vID:48
[   13.786880] ID:6 pID:9960 vID:49
[   13.790106] ID:7 pID:9961 vID:50
[   13.793331] ID:8 pID:9962 vID:51
[   13.796556] ID:9 pID:9963 vID:52
[   13.799782] ID:10 pID:9964 vID:53
[   13.803091] ID:11 pID:9965 vID:54
[   13.806403] ID:12 pID:9966 vID:55
[   13.809716] ID:13 pID:9967 vID:56
[   13.813027] ID:14 pID:9968 vID:57
[   13.816340] ID:15 pID:9969 vID:58
[   13.819651] ID:16 pID:9970 vID:59
[   13.822961] ID:17 pID:9971 vID:60
[   13.826273] ID:18 pID:9972 vID:61
[   13.829584] ID:19 pID:9973 vID:62
[   13.832896] ID:20 pID:9974 vID:63
[   13.836210] ID:21 pID:9975 vID:64
[   13.839521] ID:22 pID:9976 vID:65
[   13.842832] ID:23 pID:9977 vID:66
[   13.846144] ID:24 pID:9978 vID:67
[   13.849456] ID:25 pID:9979 vID:68
[   13.852768] ID:26 pID:9980 vID:69
[   13.856079] ID:27 pID:9981 vID:70
[   13.859391] ID:28 pID:9982 vID:71
[   13.862701] ID:29 pID:9983 vID:72
[   13.866013] ID:30 pID:9984 vID:73
[   13.869326] ID:31 pID:9985 vID:74
[   13.872639] ID:32 pID:9986 vID:75
[   13.875951] ID:33 pID:9987 vID:76
[   13.879260] ID:34 pID:9988 vID:77
[   13.882572] ID:35 pID:9989 vID:78
[   13.885884] ID:36 pID:9990 vID:79
[   13.889195] ID:37 pID:9991 vID:80
[   13.892507] ID:38 pID:9992 vID:81
[   13.895819] ID:39 pID:9993 vID:82
[   13.899129] ID:40 pID:9994 vID:83
[   13.902441] ID:41 pID:9995 vID:84
[   13.905756] ID:42 pID:9996 vID:85
[   13.909068] ID:43 pID:9997 vID:86
[   13.912379] ID:44 pID:9998 vID:87
[   13.915691] ID:45 pID:9999 vID:88
[   13.919000] ID:46 pID:10000 vID:89
[   13.922407] ID:47 pID:10001 vID:90
[   13.925806] ID:48 pID:10002 vID:91
[   13.929208] ID:49 pID:10003 vID:92
[   13.932607] ID:50 pID:10004 vID:93
[   13.936010] ID:51 pID:10005 vID:94
[   13.939409] ID:52 pID:10006 vID:95
[   13.942809] ID:53 pID:10007 vID:96
[   13.946207] ID:54 pID:10008 vID:97
[   13.949611] ID:55 pID:10009 vID:98
[   13.953009] ID:56 pID:10010 vID:99
[   13.956411] ID:57 pID:10011 vID:100
[   13.959897] ID:58 pID:10012 vID:101
[   13.963385] ID:59 pID:10013 vID:102
[   13.966868] ID:60 pID:10014 vID:103
[   13.970357] ID:61 pID:10015 vID:104
[   13.973843] ID:62 pID:10016 vID:105
[   13.977332] ID:63 pID:10017 vID:106
[   13.980817] ID:64 pID:10018 vID:107
[   13.984305] ID:65 pID:10019 vID:108
[   13.987792] ID:66 pID:10020 vID:109
[   13.991278] ID:67 pID:10021 vID:110
[   13.994764] ID:68 pID:10022 vID:111
[   13.998252] ID:69 pID:10023 vID:112
[   14.001738] ID:70 pID:10024 vID:113
[   14.005228] ID:71 pID:10025 vID:114
[   14.008713] ID:72 pID:10026 vID:115
[   14.012202] ID:73 pID:10027 vID:116
[   14.015688] ID:74 pID:10028 vID:117
[   14.019175] ID:75 pID:10029 vID:118
[   14.022661] ID:76 pID:10030 vID:119
[   14.026144] ata2: SATA link down (SStatus 0 SControl 300)
[   14.031542] ID:77 pID:10031 vID:120
[   14.035025] ID:78 pID:10032 vID:121
[   14.038523] ID:79 pID:10033 vID:122
[   14.042009] ID:80 pID:10034 vID:123
[   14.045496] ID:81 pID:10035 vID:124
[   14.048998] ID:82 pID:10036 vID:125
[   14.052488] ID:83 pID:10037 vID:126
[   14.055974] ID:84 pID:10038 vID:127
[   14.059460] ID:85 pID:10039 vID:128
[   14.062944] ID:86 pID:10040 vID:129
[   14.066432] ID:87 pID:10041 vID:130
[   14.069919] ID:88 pID:10042 vID:131
[   14.073405] ID:89 pID:10043 vID:132
[   14.076891] ID:90 pID:10044 vID:133
[   14.080376] ID:91 pID:10045 vID:134
[   14.083864] ID:92 pID:10046 vID:135
[   14.087349] ID:93 pID:10047 vID:136
[   14.090832] ID:94 pID:10048 vID:137
[   14.094320] ID:95 pID:10049 vID:138
[   14.097807] ID:96 pID:10050 vID:139
[   14.101292] ID:97 pID:10051 vID:140
[   14.104778] ID:98 pID:10052 vID:141
[   14.108264] ID:99 pID:10053 vID:142
[   14.111750] ID:100 pID:10054 vID:143
[   14.115323] ID:101 pID:10055 vID:144
[   14.118893] ID:102 pID:10056 vID:145
[   14.122468] ID:103 pID:10057 vID:146
[   14.126040] ID:104 pID:10058 vID:147
[   14.129613] ID:105 pID:10059 vID:148
[   14.133185] ID:106 pID:10060 vID:149
[   14.136759] ID:107 pID:10061 vID:150
[   14.140332] ID:108 pID:10062 vID:151
[   14.143905] ID:109 pID:10063 vID:152
[   14.147477] ID:110 pID:10064 vID:153
[   14.151050] ID:111 pID:10065 vID:154
[   14.154622] ID:112 pID:10066 vID:155
[   14.158195] ID:113 pID:10067 vID:156
[   14.161768] ID:114 pID:10068 vID:157
[   14.165341] ID:115 pID:10069 vID:158
[   14.168915] ID:116 pID:10070 vID:159
[   14.172488] ID:117 pID:10071 vID:160
[   14.176061] ID:118 pID:10072 vID:161
[   14.179637] ID:119 pID:10073 vID:162
[   14.183207] ID:120 pID:10074 vID:163
[   14.186780] ID:121 pID:10075 vID:164
[   14.190357] ID:122 pID:10076 vID:165
[   14.193930] ID:123 pID:10077 vID:166
[   14.197502] ID:124 pID:10078 vID:167
[   14.201075] ID:125 pID:10079 vID:168
[   14.204649] ID:126 pID:10080 vID:169
[   14.208223] ID:127 pID:10081 vID:170
[   14.211796] ID:128 pID:10082 vID:171
[   14.215368] ID:129 pID:10083 vID:172
[   14.218939] ID:130 pID:10084 vID:173
[   14.222512] ID:131 pID:10085 vID:174
[   14.226085] ID:132 pID:10086 vID:175
[   14.229658] ID:133 pID:10087 vID:176
[   14.233231] ID:134 pID:10088 vID:177
[   14.236805] ID:135 pID:10089 vID:178
[   14.240378] ID:136 pID:10090 vID:179
[   14.243951] ID:137 pID:10091 vID:180
[   14.247524] ID:138 pID:10092 vID:181
[   14.251094] ID:139 pID:10093 vID:182
[   14.254667] ID:140 pID:10094 vID:183
[   14.258240] ID:141 pID:10095 vID:184
[   14.261816] ID:142 pID:10096 vID:185
[   14.265391] ID:143 pID:10097 vID:186
[   14.268966] ID:144 pID:10098 vID:187
[   14.272540] ID:145 pID:10099 vID:188
[   14.276116] ID:146 pID:10100 vID:189
[   14.279689] ID:147 pID:10101 vID:190
[   14.283263] ID:148 pID:10102 vID:191
[   14.286837] ID:149 pID:10103 vID:192
[   14.290413] ID:150 pID:10104 vID:193
[   14.293987] ID:151 pID:10105 vID:194
[   14.297563] ID:152 pID:10106 vID:195
[   14.301136] ID:153 pID:10107 vID:196
[   14.304711] ID:154 pID:10108 vID:197
[   14.308284] ID:155 pID:10109 vID:198
[   14.311860] ID:156 pID:10110 vID:199
[   14.315433] ID:157 pID:10111 vID:200
[   14.319007] ID:158 pID:10112 vID:201
[   14.322582] ID:159 pID:10113 vID:202
[   14.326159] ID:160 pID:10114 vID:203
[   14.336190] hclge driver initialization finished.
[   14.366174] ata3: SATA link down (SStatus 0 SControl 300)
[   14.372573] hns3 0000:7d:00.1: Adding to iommu group 3
[   14.377836] hns3 0000:7d:00.1: The firmware version is b0620130
[   14.383793] ITS: alloc 10210:256
[   14.387010] ITT 256 entries, 8 bits
[   14.390511] ID:0 pID:10210 vID:204
[   14.393912] ID:1 pID:10211 vID:205
[   14.397312] ID:2 pID:10212 vID:206
[   14.400712] ID:3 pID:10213 vID:207
[   14.404112] ID:4 pID:10214 vID:208
[   14.407512] ID:5 pID:10215 vID:209
[   14.410910] ID:6 pID:10216 vID:210
[   14.414310] ID:7 pID:10217 vID:211
[   14.417709] ID:8 pID:10218 vID:212
[   14.421107] ID:9 pID:10219 vID:213
[   14.424506] ID:10 pID:10220 vID:214
[   14.427992] ID:11 pID:10221 vID:215
[   14.431478] ID:12 pID:10222 vID:216
[   14.434962] ID:13 pID:10223 vID:217
[   14.438448] ID:14 pID:10224 vID:218
[   14.441933] ID:15 pID:10225 vID:219
[   14.445419] ID:16 pID:10226 vID:220
[   14.448905] ID:17 pID:10227 vID:221
[   14.452391] ID:18 pID:10228 vID:222
[   14.455876] ID:19 pID:10229 vID:223
[   14.459362] ID:20 pID:10230 vID:224
[   14.462847] ID:21 pID:10231 vID:225
[   14.466333] ID:22 pID:10232 vID:226
[   14.469819] ID:23 pID:10233 vID:227
[   14.473304] ID:24 pID:10234 vID:228
[   14.476792] ID:25 pID:10235 vID:229
[   14.480277] ID:26 pID:10236 vID:230
[   14.483763] ID:27 pID:10237 vID:231
[   14.487247] ID:28 pID:10238 vID:232
[   14.490734] ID:29 pID:10239 v
[   14.504680] ID:33 pID:10243 vID:237
[   14.508165] ID:34 pID:10244 vID:238
[   14.511650] ID:35 pID:10245 vID:239
[   14.515135] ID:36 pID:10246 vID:240
[   14.518622] ID:37 pID:10247 vID:241
[   14.522107] ID:38 pID:10248 vID:242
[   14.525D:42 pID:10252 vID:246
[   14.539534] ID:43 pID:10253 vID:247
[   14.543019] ID:44 pID:10254 vID:248
[   14.546505] ID:45 pID:10255 vID:249
[   14.549990] ID:46 pID:10256 vID:250
[   14.553476] ID:47 pID:10257 vID:251
[   14.556962] ID:48 pID:10258 vID:252
[   14.560447] ID:49 pID:10259 vID:253
[   14.563932] ID:50 pID:10260 vID:254
[   14.567419] ID:51 pID:10261 vID:255
[   14.570903] ID:52 pID:10262 vID:256
[   14.574389] ID:53 pID:10263 vID:257
[   14.577875] ID:54 pID:10264 vID:258
[   14.581361] ID:55 pID:10265 vID:259
[   14.584846] ID:56 pID:10266 vID:260
[   14.588331] ID:57 pID:10267 vID:261
[   14.591816] ID:58 pID:10268 vID:262
[   14.595303] ID:59 pID:10269 vID:263
[   14.598787] ID:60 pID:10270 vID:264
[   14.602273] ID:61 pID:10271 vID:265
[   14.605759] ID:62 pID:10272 vID:266
[   14.609245] ID:63 pID:10273 vID:267
[   14.612731] ID:64 pID:10274 vID:268
[   14.616216] ID:65 pID:10275 vID:269
[   14.619702] ID:66 pID:10276 vID:270
[   14.623185] ID:67 pID:10277 vID:271
[   14.626671] ID:68 pID:10278 vID:272
[   14.630157] ID:69 pID:10279 vID:273
[   14.633643] ID:70 pID:10280 vID:274
[   14.637128] ID:71 pID:10281 vID:275
[   14.640614] ID:72 pID:10282 vID:276
[   14.644100] ID:73 pID:10283 vID:277
[   14.647586] ID:74 pID:10284 vID:278
[   14.651069] ID:75 pID:10285 vID:279
[   14.654555] ID:76 pID:10286 vID:280
[   14.658041] ID:77 pID:10287 vID:281
[   14.661527] ID:78 pID:10288 vID:282
[   14.665013] ID:79 pID:10289 vID:283
[   14.668498] ID:80 pID:10290 vID:284
[   14.671984] ID:81 pID:10291 vID:285
[   14.675469] ID:82 pID:10292 vID:286
[   14.678952] ID:83 pID:10293 vID:287
[   14.682438] ID:84 pID:10294 vID:288
[   14.685925] ID:85 pID:10295 vID:289
[   14.689411] ID:86 pID:10296 vID:290
[   14.692896] ID:87 pID:10297 vID:291
[   14.696382] ID:88 pID:10298 vID:292
[   14.699868] ID:89 pID:10299 vID:293
[   14.703354] ID:90 pID:10300 vID:294
[   14.706836] ID:91 pID:10301 vID:295
[   14.710322] ID:92 pID:10302 vID:296
[   14.713810] ID:93 pID:10303 vID:297
[   14.717295] ID:94 pID:10304 vID:298
[   14.720783] ID:95 pID:10305 vID:299
[   14.724270] ID:96 pID:10306 vID:300
[   14.727756] ID:97 pID:10307 vID:301
[   14.731239] ID:98 pID:10308 vID:302
[   14.734724] ID:99 pID:10309 vID:303
[   14.738213] ID:100 pID:10310 vID:304
[   14.741786] ID:101 pID:10311 vID:305
[   14.745359] ID:102 pID:10312 vID:306
[   14.748931] ID:103 pID:10313 vID:307
[   14.752504] ID:104 pID:10314 vID:308
[   14.756077] ID:105 pID:10315 vID:309
[   14.759649] ID:106 pID:10316 vID:310
[   14.763219] ID:107 pID:10317 vID:311
[   14.766793] ID:108 pID:10318 vID:312
[   14.770365] ID:109 pID:10319 vID:313
[   14.773937] ID:110 pID:10320 vID:314
[   14.777511] ID:111 pID:10321 vID:315
[   14.781083] ID:112 pID:10322 vID:316
[   14.784655] ID:113 pID:10323 vID:317
[   14.788228] ID:114 pID:10324 vID:318
[   14.791802] ID:115 pID:10325 vID:319
[   14.795375] ID:116 pID:10326 vID:320
[   14.798946] ID:117 pID:10327 vID:321
[   14.802519] ID:118 pID:10328 vID:322
[   14.806092] ID:119 pID:10329 vID:323
[   14.809666] ID:120 pID:10330 vID:324
[   14.813239] ID:121 pID:10331 vID:325
[   14.816812] ID:122 pID:10332 vID:326
[   14.820385] ID:123 pID:10333 vID:327
[   14.823958] ID:124 pID:10334 vID:328
[   14.827532] ID:125 pID:10335 vID:329
[   14.831103] ID:126 pID:10336 vID:330
[   14.834676] ID:127 pID:10337 vID:331
[   14.838249] ID:128 pID:10338 vID:332
[   14.841822] ID:129 pID:10339 vID:333
[   14.845395] ID:130 pID:10340 vID:334
[   14.848968] ID:131 pID:10341 vID:335
[   14.852541] ID:132 pID:10342 vID:336
[   14.856115] ID:133 pID:10343 vID:337
[   14.859688] ID:134 pID:10344 vID:338
[   14.863258] ID:135 pID:10345 vID:339
[   14.866832] ID:136 pID:10346 vID:340
[   14.870404] ID:137 pID:10347 vID:341
[   14.873978] ID:138 pID:10348 vID:342
[   14.877550] ID:139 pID:10349 vID:343
[   14.881124] ID:140 pID:10350 vID:344
[   14.884699] ID:141 pID:10351 vID:345
[   14.888271] ID:142 pID:10352 vID:346
[   14.891845] ID:143 pID:10353 vID:347
[   14.895418] ID:144 pID:10354 vID:348
[   14.898989] ID:145 pID:10355 vID:349
[   14.902562] ID:146 pID:10356 vID:350
[   14.906135] ID:147 pID:10357 vID:351
[   14.909708] ID:148 pID:10358 vID:352
[   14.913283] ID:149 pID:10359 vID:353
[   14.916856] ID:150 pID:10360 vID:354
[   14.920429] ID:151 pID:10361 vID:355
[   14.924002] ID:152 pID:10362 vID:356
[   14.927575] ID:153 pID:10363 vID:357
[   14.931146] ID:154 pID:10364 vID:358
[   14.934718] ID:155 pID:10365 vID:359
[   14.938292] ID:156 pID:10366 vID:360
[   14.941866] ID:157 pID:10367 vID:361
[   14.945438] ID:158 pID:10368 vID:362
[   14.949011] ID:159 pID:10369 vID:363
[   14.952586] ID:160 pID:10370 vID:364
[   14.962628] hclge driver initialization finished.
[   14.993671] hns3 0000:7d:00.2: Adding to iommu group 4
[   14.998945] hns3 0000:7d:00.2: The firmware version is b0620130
[   15.004900] ITS: alloc 10466:256
[   15.008120] ITT 256 entries, 8 bits
[   15.011614] ID:0 pID:10466 vID:365
[   15.015014] ID:1 pID:10467 vID:366
[   15.018415] ID:2 pID:10468 vID:367
[   15.021816] ID:3 pID:10469 vID:368
[   15.025220] ID:4 pID:10470 vID:369
[   15.028619] ID:5 pID:10471 vID:370
[   15.032018] ID:6 pID:10472 vID:371
[   15.035418] ID:7 pID:10473 vID:372
[   15.038814] ID:8 pID:10474 vID:373
[   15.042214] ID:9 pID:10475 vID:374
[   15.045615] ID:10 pID:10476 vID:375
[   15.049101] ID:11 pID:10477 vID:376
[   15.052587] ID:12 pID:10478 vID:377
[   15.056072] ID:13 pID:10479 vID:378
[   15.059559] ID:14 pID:10480 vID:379
[   15.063042] ID:15 pID:10481 vID:380
[   15.066527] ID:16 pID:10482 vID:381
[   15.070013] ID:17 pID:10483 vID:382
[   15.073501] ID:18 pID:10484 vID:383
[   15.076987] ID:19 pID:10485 vID:384
[   15.080472] ID:20 pID:10486 vID:385
[   15.083958] ID:21 pID:10487 vID:386
[   15.087444] ID:22 pID:10488 vID:387
[   15.090927] ID:23 pID:10489 vID:388
[   15.094413] ID:24 pID:10490 vID:389
[   15.097900] ID:25 pID:10491 vID:390
[   15.101386] ID:26 pID:10492 vID:391
[   15.104871] ID:27 pID:10493 vID:392
[   15.108357] ID:28 pID:10494 vID:393
[   15.111844] ID:29 pID:10495 vID:394
[   15.115329] ID:30 pID:10496 vID:395
[   15.118812] ID:31 pID:10497 vID:396
[   15.122298] ID:32 pID:10498 vID:397
[   15.125785] ID:33 pID:10499 vID:398
[   15.129272] ID:34 pID:10500 vID:399
[   15.132758] ID:35 pID:10501 vID:400
[   15.136243] ID:36 pID:10502 vID:401
[   15.139729] ID:37 pID:10503 vID:402
[   15.143212] ID:38 pID:10504 vID:403
[   15.146698] ID:39 pID:10505 vID:404
[   15.150184] ID:40 pID:10506 vID:405
[   15.153670] ID:41 pID:10507 vID:406
[   15.157157] ID:42 pID:10508 vID:407
[   15.160643] ID:43 pID:10509 vID:408
[   15.164129] ID:44 pID:10510 vID:409
[   15.167615] ID:45 pID:10511 vID:410
[   15.171098] ID:46 pID:10512 vID:411
[   15.174583] ID:47 pID:10513 vID:412
[   15.178069] ID:48 pID:10514 vID:413
[   15.181555] ID:49 pID:10515 vID:414
[   15.185041] ID:50 pID:10516 vID:415
[   15.188526] ID:51 pID:10517 vID:416
[   15.192012] ID:52 pID:10518 vID:417
[   15.195498] ID:53 pID:10519 vID:418
[   15.198981] ID:54 pID:10520 vID:419
[   15.202467] ID:55 pID:10521 vID:420
[   15.205952] ID:56 pID:10522 vID:421
[   15.209438] ID:57 pID:10523 vID:422
[   15.212924] ID:58 pID:10524 vID:423
[   15.216410] ID:59 pID:10525 vID:424
[   15.219896] ID:60 pID:10526 vID:425
[   15.223381] ID:61 pID:10527 vID:426
[   15.226864] ID:62 pID:10528 vID:427
[   15.230350] ID:63 pID:10529 vID:428
[   15.233836] ID:64 pID:10530 vID:429
[   15.237322] ID:65 pID:10531 vID:430
[   15.240808] ID:66 pID:10532 vID:431
[   15.244295] ID:67 pID:10533 vID:432
[   15.247780] ID:68 pID:10534 vID:433
[   15.251263] ID:69 pID:10535 vID:434
[   15.254750] ID:70 pID:10536 vID:435
[   15.258235] ID:71 pID:10537 vID:436
[   15.261720] ID:72 pID:10538 vID:437
[   15.265206] ID:73 pID:10539 vID:438
[   15.268693] ID:74 pID:10540 vID:439
[   15.272178] ID:75 pID:10541 vID:440
[   15.275664] ID:76 pID:10542 vID:441
[   15.279147] ID:77 pID:10543 vID:442
[   15.282635] ID:78 pID:10544 vID:443
[   15.286121] ID:79 pID:10545 vID:444
[   15.289607] ID:80 pID:10546 vID:445
[   15.293093] ID:81 pID:10547 vID:446
[   15.296580] ID:82 pID:10548 vID:447
[   15.300069] ID:83 pID:10549 vID:448
[   15.303555] ID:84 pID:10550 vID:449
[   15.307039] ID:85 pID:10551 vID:450
[   15.310525] ID:86 pID:10552 vID:451
[   15.314010] ID:87 pID:10553 vID:452
[   15.317496] ID:88 pID:10554 vID:453
[   15.320983] ID:89 pID:10555 vID:454
[   15.324469] ID:90 pID:10556 vID:455
[   15.327955] ID:91 pID:10557 vID:456
[   15.331441] ID:92 pID:10558 vID:457
[   15.334925] ID:93 pID:10559 vID:458
[   15.338411] ID:94 pID:10560 vID:459
[   15.341897] ID:95 pID:10561 vID:460
[   15.345383] ID:96 pID:10562 vID:461
[   15.348870] ID:97 pID:10563 vID:462
[   15.352357] ID:98 pID:10564 vID:463
[   15.355842] ID:99 pID:10565 vID:464
[   15.359329] ID:100 pID:10566 vID:465
[   15.362899] ID:101 pID:10567 vID:466
[   15.366472] ID:102 pID:10568 vID:467
[   15.370044] ID:103 pID:10569 vID:468
[   15.373618] ID:104 pID:10570 vID:469
[   15.377190] ID:105 pID:10571 vID:470
[   15.380764] ID:106 pID:10572 vID:471
[   15.384336] ID:107 pID:10573 vID:472
[   15.387910] ID:108 pID:10574 vID:473
[   15.391482] ID:109 pID:10575 vID:474
[   15.395052] ID:110 pID:10576 vID:475
[   15.398625] ID:111 pID:10577 vID:476
[   15.402198] ID:112 pID:10578 vID:477
[   15.405771] ID:113 pID:10579 vID:478
[   15.409344] ID:114 pID:10580 vID:479
[   15.412917] ID:115 pID:10581 vID:480
[   15.416490] ID:116 pID:10582 vID:481
[   15.420062] ID:117 pID:10583 vID:482
[   15.423635] ID:118 pID:10584 vID:483
[   15.427206] ID:119 pID:10585 vID:484
[   15.430779] ID:120 pID:10586 vID:485
[   15.434352] ID:121 pID:10587 vID:486
[   15.437925] ID:122 pID:10588 vID:487
[   15.441499] ID:123 pID:10589 vID:488
[   15.445071] ID:124 pID:10590 vID:489
[   15.448643] ID:125 pID:10591 vID:490
[   15.452216] ID:126 pID:10592 vID:491
[   15.455789] ID:127 pID:10593 vID:492
[   15.459361] ID:128 pID:10594 vID:493
[   15.462932] ID:129 pID:10595 vID:494
[   15.466507] ID:130 pID:10596 vID:495
[   15.470079] ID:131 pID:10597 vID:496
[   15.473651] ID:132 pID:10598 vID:497
[   15.477224] ID:133 pID:10599 vID:498
[   15.480797] ID:134 pID:10600 vID:499
[   15.484370] ID:135 pID:10601 vID:500
[   15.487942] ID:136 pID:10602 vID:501
[   15.491515] ID:137 pID:10603 vID:502
[   15.495087] ID:138 pID:10604 vID:503
[   15.498660] ID:139 pID:10605 vID:504
[   15.502232] ID:140 pID:10606 vID:505
[   15.505804] ID:141 pID:10607 vID:506
[   15.509378] ID:142 pID:10608 vID:507
[   15.512950] ID:143 pID:10609 vID:508
[   15.516522] ID:144 pID:10610 vID:509
[   15.520096] ID:145 pID:10611 vID:510
[   15.523670] ID:146 pID:10612 vID:511
[   15.527240] ID:147 pID:10613 vID:512
[   15.530813] ID:148 pID:10614 vID:513
[   15.534386] ID:149 pID:10615 vID:514
[   15.537958] ID:150 pID:10616 vID:515
[   15.541531] ID:151 pID:10617 vID:516
[   15.545103] ID:152 pID:10618 vID:517
[   15.548677] ID:153 pID:10619 vID:518
[   15.552250] ID:154 pID:10620 vID:519
[   15.555823] ID:155 pID:10621 vID:520
[   15.559399] ID:156 pID:10622 vID:521
[   15.562971] ID:157 pID:10623 vID:522
[   15.566544] ID:158 pID:10624 vID:523
[   15.570116] ID:159 pID:10625 vID:524
[   15.573690] ID:160 pID:10626 vID:525
[   15.578983] libphy: hisilicon MII bus: probed
[   15.583964] hclge driver initialization finished.
[   15.595205] hns3 0000:7d:00.3: Adding to iommu group 5
[   15.600447] hns3 0000:7d:00.3: The firmware version is b0620130
[   15.606401] ITS: alloc 10722:128
[   15.609626] ITT 128 entries, 7 bits
[   15.613125] ID:0 pID:10722 vID:526
[   15.616531] ID:1 pID:10723 vID:527
[   15.619934] ID:2 pID:10724 vID:528
[   15.623335] ID:3 pID:10725 vID:529
[   15.626733] ID:4 pID:10726 vID:530
[   15.630133] ID:5 pID:10727 vID:531
[   15.633533] ID:6 pID:10728 vID:532
[   15.636933] ID:7 pID:10729 vID:533
[   15.640332] ID:8 pID:10730 vID:534
[   15.643732] ID:9 pID:10731 vID:535
[   15.647129] ID:10 pID:10732 vID:536
[   15.650616] ID:11 pID:10733 vID:537
[   15.654101] ID:12 pID:10734 vID:538
[   15.657588] ID:13 pID:10735 vID:539
[   15.661075] ID:14 pID:10736 vID:540
[   15.664561] ID:15 pID:10737 vID:541
[   15.668047] ID:16 pID:10738 vID:542
[   15.671533] ID:17 pID:10739 vID:543
[   15.675016] ID:18 pID:10740 vID:544
[   15.678506] ID:19 pID:10741 vID:545
[   15.681993] ID:20 pID:10742 vID:546
[   15.685479] ID:21 pID:10743 vID:547
[   15.688966] ID:22 pID:10744 vID:548
[   15.692452] ID:23 pID:10745 vID:549
[   15.695937] ID:24 pID:10746 vID:550
[   15.699423] ID:25 pID:10747 vID:551
[   15.702907] ID:26 pID:10748 vID:552
[   15.706393] ID:27 pID:10749 vID:553
[   15.709878] ID:28 pID:10750 vID:554
[   15.713365] ID:29 pID:10751 vID:555
[   15.716852] ID:30 pID:10752 vID:556
[   15.720338] ID:31 pID:10753 vID:557
[   15.723824] ID:32 pID:10754 vID:558
[   15.727309] ID:33 pID:10755 vID:559
[   15.730794] ID:34 pID:10756 vID:560
[   15.734280] ID:35 pID:10757 vID:561
[   15.737765] ID:36 pID:10758 vID:562
[   15.741253] ID:37 pID:10759 vID:563
[   15.744739] ID:38 pID:10760 vID:564
[   15.748226] ID:39 pID:10761 vID:565
[   15.751711] ID:40 pID:10762 vID:566
[   15.755196] ID:41 pID:10763 vID:567
[   15.758682] ID:42 pID:10764 vID:568
[   15.762167] ID:43 pID:10765 vID:569
[   15.765654] ID:44 pID:10766 vID:570
[   15.769141] ID:45 pID:10767 vID:571
[   15.772627] ID:46 pID:10768 vID:572
[   15.776113] ID:47 pID:10769 vID:573
[   15.779599] ID:48 pID:10770 vID:574
[   15.783084] ID:49 pID:10771 vID:575
[   15.786569] ID:50 pID:10772 vID:576
[   15.790055] ID:51 pID:10773 vID:577
[   15.793542] ID:52 pID:10774 vID:578
[   15.797028] ID:53 pID:10775 vID:579
[   15.800515] ID:54 pID:10776 vID:580
[   15.804000] ID:55 pID:10777 vID:581
[   15.807487] ID:56 pID:10778 vID:582
[   15.810970] ID:57 pID:10779 vID:583
[   15.814455] ID:58 pID:10780 vID:584
[   15.817942] ID:59 pID:10781 vID:585
[   15.821428] ID:60 pID:10782 vID:586
[   15.824914] ID:61 pID:10783 vID:587
[   15.828400] ID:62 pID:10784 vID:588
[   15.831886] ID:63 pID:10785 vID:589
[   15.835372] ID:64 pID:10786 vID:590
[   15.840232] libphy: hisilicon MII bus: probed
[   15.845024] hclge driver initialization finished.
[   15.856231] hns3 0000:bd:00.0: Adding to iommu group 6
[   15.861477] hns3 0000:bd:00.0: The firmware version is b0620130
[   15.867439] ITS: alloc 10850:256
[   15.870656] ITT 256 entries, 8 bits
[   15.874159] ID:0 pID:10850 vID:591
[   15.877569] ID:1 pID:10851 vID:592
[   15.880976] ID:2 pID:10852 vID:593
[   15.884383] ID:3 pID:10853 vID:594
[   15.887788] ID:4 pID:10854 vID:595
[   15.891191] ID:5 pID:10855 vID:596
[   15.894594] ID:6 pID:10856 vID:597
[   15.897998] ID:7 pID:10857 vID:598
[   15.901401] ID:8 pID:10858 vID:599
[   15.904804] ID:9 pID:10859 vID:600
[   15.908209] ID:10 pID:10860 vID:601
[   15.911700] ID:11 pID:10861 vID:602
[   15.915187] ID:12 pID:10862 vID:603
[   15.918677] ID:13 pID:10863 vID:604
[   15.922167] ID:14 pID:10864 vID:605
[   15.925657] ID:15 pID:10865 vID:606
[   15.929147] ID:16 pID:10866 vID:607
[   15.932637] ID:17 pID:10867 vID:608
[   15.936126] ID:18 pID:10868 vID:609
[   15.939617] ID:19 pID:10869 vID:610
[   15.943105] ID:20 pID:10870 vID:611
[   15.946594] ID:21 pID:10871 vID:612
[   15.950085] ID:22 pID:10872 vID:613
[   15.953575] ID:23 pID:10873 vID:614
[   15.957066] ID:24 pID:10874 vID:615
[   15.960555] ID:25 pID:10875 vID:616
[   15.964046] ID:26 pID:10876 vID:617
[   15.967536] ID:27 pID:10877 vID:618
[   15.971023] ID:28 pID:10878 vID:619
[   15.974513] ID:29 pID:10879 vID:620
[   15.978003] ID:30 pID:10880 vID:621
[   15.981494] ID:31 pID:10881 vID:622
[   15.984983] ID:32 pID:10882 vID:623
[   15.988473] ID:33 pID:10883 vID:624
[   15.991963] ID:34 pID:10884 vID:625
[   15.995453] ID:35 pID:10885 vID:626
[   15.998940] ID:36 pID:10886 vID:627
[   16.002434] ID:37 pID:10887 vID:628
[   16.005925] ID:38 pID:10888 vID:629
[   16.009415] ID:39 pID:10889 vID:630
[   16.012905] ID:40 pID:10890 vID:631
[   16.016395] ID:41 pID:10891 vID:632
[   16.019885] ID:42 pID:10892 vID:633
[   16.023377] ID:43 pID:10893 vID:634
[   16.026864] ID:44 pID:10894 vID:635
[   16.030355] ID:45 pID:10895 vID:636
[   16.033846] ID:46 pID:10896 vID:637
[   16.037336] ID:47 pID:10897 vID:638
[   16.040827] ID:48 pID:10898 vID:639
[   16.044319] ID:49 pID:10899 vID:640
[   16.047809] ID:50 pID:10900 vID:641
[   16.051298] ID:51 pID:10901 vID:642
[   16.054787] ID:52 pID:10902 vID:643
[   16.058277] ID:53 pID:10903 vID:644
[   16.061767] ID:54 pID:10904 vID:645
[   16.065257] ID:55 pID:10905 vID:646
[   16.068748] ID:56 pID:10906 vID:647
[   16.072238] ID:57 pID:10907 vID:648
[   16.075728] ID:58 pID:10908 vID:649
[   16.079216] ID:59 pID:10909 vID:650
[   16.082707] ID:60 pID:10910 vID:651
[   16.086197] ID:61 pID:10911 vID:652
[   16.089688] ID:62 pID:10912 vID:653
[   16.093179] ID:63 pID:10913 vID:654
[   16.096670] ID:64 pID:10914 vID:655
[   16.100161] ID:65 pID:10915 vID:656
[   16.103651] ID:66 pID:10916 vID:657
[   16.107140] ID:67 pID:10917 vID:658
[   16.110630] ID:68 pID:10918 vID:659
[   16.114120] ID:69 pID:10919 vID:660
[   16.117611] ID:70 pID:10920 vID:661
[   16.121103] ID:71 pID:10921 vID:662
[   16.124593] ID:72 pID:10922 vID:663
[   16.128084] ID:73 pID:10923 vID:664
[   16.131574] ID:74 pID:10924 vID:665
[   16.135062] ID:75 pID:10925 vID:666
[   16.138553] ID:76 pID:10926 vID:667
[   16.142043] ID:77 pID:10927 vID:668
[   16.145533] ID:78 pID:10928 vID:669
[   16.149024] ID:79 pID:10929 vID:670
[   16.152514] ID:80 pID:10930 vID:671
[   16.156004] ID:81 pID:10931 vID:672
[   16.159497] ID:82 pID:10932 vID:673
[   16.162985] ID:83 pID:10933 vID:674
[   16.166475] ID:84 pID:10934 vID:675
[   16.169964] ID:85 pID:10935 vID:676
[   16.173455] ID:86 pID:10936 vID:677
[   16.176946] ID:87 pID:10937 vID:678
[   16.180436] ID:88 pID:10938 vID:679
[   16.183927] ID:89 pID:10939 vID:680
[   16.187417] ID:90 pID:10940 vID:681
[   16.190905] ID:91 pID:10941 vID:682
[   16.194396] ID:92 pID:10942 vID:683
[   16.197886] ID:93 pID:10943 vID:684
[   16.201377] ID:94 pID:10944 vID:685
[   16.204867] ID:95 pID:10945 vID:686
[   16.208358] ID:96 pID:10946 vID:687
[   16.211849] ID:97 pID:10947 vID:688
[   16.215338] ID:98 pID:10948 vID:689
[   16.218826] ID:99 pID:10949 vID:690
[   16.222317] ID:100 pID:10950 vID:691
[   16.225897] ID:101 pID:10951 vID:692
[   16.229474] ID:102 pID:10952 vID:693
[   16.233051] ID:103 pID:10953 vID:694
[   16.236628] ID:104 pID:10954 vID:695
[   16.240206] ID:105 pID:10955 vID:696
[   16.243783] ID:106 pID:10956 vID:697
[   16.247360] ID:107 pID:10957 vID:698
[   16.250934] ID:108 pID:10958 vID:699
[   16.254512] ID:109 pID:10959 vID:700
[   16.258089] ID:110 pID:10960 vID:701
[   16.261667] ID:111 pID:10961 vID:702
[   16.265245] ID:112 pID:10962 vID:703
[   16.268825] ID:113 pID:10963 vID:704
[   16.272403] ID:114 pID:10964 vID:705
[   16.275980] ID:115 pID:10965 vID:706
[   16.279558] ID:116 pID:10966 vID:707
[   16.283133] ID:117 pID:10967 vID:708
[   16.286710] ID:118 pID:10968 vID:709
[   16.290287] ID:119 pID:10969 vID:710
[   16.293867] ID:120 pID:10970 vID:711
[   16.297444] ID:121 pID:10971 vID:712
[   16.301021] ID:122 pID:10972 vID:713
[   16.304597] ID:123 pID:10973 vID:714
[   16.308175] ID:124 pID:10974 vID:715
[   16.311753] ID:125 pID:10975 vID:716
[   16.315330] ID:126 pID:10976 vID:717
[   16.318906] ID:127 pID:10977 vID:718
[   16.322484] ID:128 pID:10978 vID:719
[   16.326061] ID:129 pID:10979 vID:720
[   16.329639] ID:130 pID:10980 vID:721
[   16.333217] ID:131 pID:10981 vID:722
[   16.336795] ID:132 pID:10982 vID:723
[   16.340371] ID:133 pID:10983 vID:724
[   16.343949] ID:134 pID:10984 vID:725
[   16.347527] ID:135 pID:10985 vID:726
[   16.351102] ID:136 pID:10986 vID:727
[   16.354679] ID:137 pID:10987 vID:728
[   16.358256] ID:138 pID:10988 vID:729
[   16.361834] ID:139 pID:10989 vID:730
[   16.365414] ID:140 pID:10990 vID:731
[   16.368991] ID:141 pID:10991 vID:732
[   16.372569] ID:142 pID:10992 vID:733
[   16.376146] ID:143 pID:10993 vID:734
[   16.379723] ID:144 pID:10994 vID:735
[   16.383301] ID:145 pID:10995 vID:736
[   16.386876] ID:146 pID:10996 vID:737
[   16.390453] ID:147 pID:10997 vID:738
[   16.394031] ID:148 pID:10998 vID:739
[   16.397608] ID:149 pID:10999 vID:740
[   16.401186] ID:150 pID:11000 vID:741
[   16.404764] ID:151 pID:11001 vID:742
[   16.408341] ID:152 pID:11002 vID:743
[   16.411918] ID:153 pID:11003 vID:744
[   16.415496] ID:154 pID:11004 vID:745
[   16.419072] ID:155 pID:11005 vID:746
[   16.422649] ID:156 pID:11006 vID:747
[   16.426228] ID:157 pID:11007 vID:748
[   16.429806] ID:158 pID:11008 vID:749
[   16.433385] ID:159 pID:11009 vID:750
[   16.436962] ID:160 pID:11010 vID:751
[   16.454145] hclge driver initialization finished.
[   16.485422] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   16.491259] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   16.497239] igb: Intel(R) Gigabit Ethernet Network Driver - version 
5.6.0-k
[   16.504189] igb: Copyright (c) 2007-2014 Intel Corporation.
[   16.509778] igbvf: Intel(R) Gigabit Virtual Function Network Driver - 
version 2.4.0-k
[   16.517595] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[   16.523942] sky2: driver version 1.30
[   16.528352] VFIO - User Level meta-driver version: 0.3
[   16.538641] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   16.545172] ehci-pci: EHCI PCI platform driver
[   16.549765] ehci-pci 0000:7a:01.0: EHCI Host Controller
[   16.554991] ehci-pci 0000:7a:01.0: new USB bus registered, assigned 
bus number 1
[   16.562412] ehci-pci 0000:7a:01.0: irq 40, io mem 0x20c101000
[   16.583292] ehci-pci 0000:7a:01.0: USB 0.0 started, EHCI 1.00
[   16.589191] hub 1-0:1.0: USB hub found
[   16.592941] hub 1-0:1.0: 2 ports detected
[   16.597166] ehci-pci 0000:ba:01.0: EHCI Host Controller
[   16.602401] ehci-pci 0000:ba:01.0: new USB bus registered, assigned 
bus number 2
[   16.609809] ehci-pci 0000:ba:01.0: irq 40, io mem 0x40020c101000
[   16.631291] ehci-pci 0000:ba:01.0: USB 0.0 started, EHCI 1.00
[   16.637175] hub 2-0:1.0: USB hub found
[   16.640923] hub 2-0:1.0: 2 ports detected
[   16.645068] ehci-platform: EHCI generic platform driver
[   16.650464] ehci-orion: EHCI orion driver
[   16.654566] ehci-exynos: EHCI EXYNOS driver
[   16.658837] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   16.665010] ohci-pci: OHCI PCI platform driver
[   16.669505] ohci-pci 0000:7a:00.0: OHCI PCI host controller
[   16.675075] ohci-pci 0000:7a:00.0: new USB bus registered, assigned 
bus number 3
[   16.682483] ohci-pci 0000:7a:00.0: irq 40, io mem 0x20c100000
ci-pci 0000:ba:00.0: irq 40, io mem 0x40020c100000
[   16.839446] hub 4-0:1.0: USB hub found
[   16.843187] hub 4-0:1.0: 2 ports detected
[   16.847334] ohci-platform: OHCI generic platform driver
[   16.852660] ohci-exynos: OHCI EXYNOS driver
[   16.857011] xhci_hcd 0000:7a:02.0: xHCI Host Controller
[   16.862234] xhci_hcd 0000:7a:02.0: new USB bus registered, assigned 
bus number 5
[   16.869685] xhci_hcd 0000:7a:02.0: hcc params 0x0220f66d hci version 
0x100 quirks 0x0000000000000010
[   16.879046] ITS: alloc 11106:1
[   16.882092] ITT 1 entries, 0 bits
[   16.885411] ID:0 pID:11106 vID:752
[   16.889020] hub 5-0:1.0: USB hub found
[   16.892769] hub 5-0:1.0: 1 port detected
[   16.896785] xhci_hcd 0000:7a:02.0: xHCI Host Controller
[   16.902006] xhci_hcd 0000:7a:02.0: new USB bus registered, assigned 
bus number 6
[   16.909391] xhci_hcd 0000:7a:02.0: Host supports USB 3.0 SuperSpeed
[   16.915657] usb usb6: We don't know the algorithms for LPM for this 
host, disabling LPM.
[   16.923864] hub 6-0:1.0: USB hub found
[   16.927612] hub 6-0:1.0: 1 port detected
[   16.931666] xhci_hcd 0000:ba:02.0: xHCI Host Controller
[   16.936886] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   16.943416] xhci_hcd 0000:ba:02.0: new USB bus registered, assigned 
bus number 7
[   16.950970] xhci_hcd 0000:ba:02.0: hcc params 0x0220f66d hci version 
0x100 quirks 0x0000000000000010
[   16.960110] ITS: alloc 11107:1
[   16.963157] ITT 1 entries, 0 bits
[   16.966483] ID:0 pID:11107 vID:753
[   16.970084] hub 7-0:1.0: USB hub found
[   16.973833] hub 7-0:1.0: 1 port detected
[   16.977856] xhci_hcd 0000:ba:02.0: xHCI Host Controller
[   16.983082] xhci_hcd 0000:ba:02.0: new USB bus registered, assigned 
bus number 8
[   16.990468] xhci_hcd 0000:ba:02.0: Host supports USB 3.0 SuperSpeed
[   16.996735] usb usb8: We don't know the algorithms for LPM for this 
host, disabling LPM.
[   17.004964] hub 8-0:1.0: USB hub found
[   17.008712] hub 8-0:1.0: 1 port detected
[   17.013035] usbcore: registered new interface driver usb-storage
[   17.061618] rtc-efi rtc-efi: registered as rtc0
[   17.066743] i2c /dev entries driver
[   17.074498] sdhci: Secure Digital Host Controller Interface driver
[   17.080704] sdhci: Copyright(c) Pierre Ossman
[   17.085621] Synopsys Designware Multimedia Card Interface Driver
[   17.092389] sdhci-pltfm: SDHCI platform and OF driver helper
[   17.099261] ledtrig-cpu: registered to indicate activity on CPUs
[   17.106236] usbcore: registered new interface driver usbhid
[   17.111811] usbhid: USB HID core driver
[   17.116068] hub 1-1:1.0: USB hub found
[   17.120768] ID:0 pID:8192 vID:754
[   17.124159] hub 1-1:1.0: 4 ports detected
[   17.128208] ID:0 pID:8224 vID:755
[   17.131614] ID:0 pID:8256 vID:756
[   17.135046] ID:0 pID:8288 vID:757
[   17.138535] ID:0 pID:8320 vID:758
[   17.141943] ID:0 pID:8352 vID:759
[   17.145406] ID:0 pID:8576 vID:760
[   17.148804] ID:0 pID:8608 vID:761
[   17.152200] ID:0 pID:8640 vID:762
[   17.155595] ID:0 pID:8672 vID:763
[   17.158979] ID:0 pID:8704 vID:764
[   17.162370] ID:0 pID:8736 vID:765
[   17.165770] ID:0 pID:8960 vID:766
[   17.169161] ID:0 pID:8992 vID:767
[   17.172551] ID:0 pID:9024 vID:768
[   17.175945] ID:0 pID:9056 vID:769
[   17.179336] ID:0 pID:9088 vID:770
[   17.182730] ID:0 pID:9120 vID:771
[   17.186125] ID:0 pID:9344 vID:772
[   17.189514] ID:0 pID:9376 vID:773
[   17.192906] ID:0 pID:9408 vID:774
[   17.196292] ID:0 pID:9440 vID:775
[   17.199685] ID:0 pID:9472 vID:776
[   17.203080] ID:0 pID:9504 vID:777
[   17.206639] ID:0 pID:8512 vID:778
[   17.210046] ID:0 pID:8544 vID:779
[   17.213640] ID:0 pID:8896 vID:780
[   17.217044] ID:0 pID:8928 vID:781
[   17.220450] ID:0 pID:9280 vID:782
[   17.223852] ID:0 pID:9312 vID:783
[   17.227254] ID:0 pID:9664 vID:784
[   17.230661] ID:0 pID:9696 vID:785
[   17.234213] ID:0 pID:8384 vID:786
[   17.237603] ID:0 pID:8416 vID:787
[   17.240989] ID:0 pID:8448 vID:788
[   17.244371] ID:0 pID:8480 vID:789
[   17.247770] ID:0 pID:8768 vID:790
[   17.251182] ID:0 pID:8800 vID:791
[   17.254575] ID:0 pID:8832 vID:792
[   17.257989] ID:0 pID:8864 vID:793
[   17.261392] ID:0 pID:9152 vID:794
[   17.264795] ID:0 pID:9184 vID:795
[   17.268180] ID:0 pID:9216 vID:796
[   17.271490] usb 1-2: new high-speed USB device number 3 using ehci-pci
[   17.278092] ID:0 pID:9248 vID:797
[   17.281486] ID:0 pID:9536 vID:798
[   17.284889] ID:0 pID:9568 vID:799
[   17.288291] ID:0 pID:9600 vID:800
[   17.291680] ID:0 pID:9632 vID:801
[   17.296742] NET: Registered protocol family 17
[   17.301244] 9pnet: Installing 9P2000 support
[   17.305530] Key type dns_resolver registered
[   17.309977] registered taskstats version 1
[   17.314065] Loading compiled-in X.509 certificates
[   17.319230] pcieport 0000:00:00.0: Adding to iommu group 7
[   17.324838] ITS: alloc 11108:32
[   17.327978] ITT 32 entries, 5 bits
[   17.331625] ID:0 pID:11108 vID:802
[   17.335014] ID:1 pID:11109 vID:803
[   17.338406] ID:2 pID:11110 vID:804
[   17.341796] ID:3 pID:11111 vID:805
[   17.345186] ID:4 pID:11112 vID:806
[   17.348577] ID:5 pID:11113 vID:807
[   17.351967] ID:6 pID:11114 vID:808
[   17.355536] ID:7 pID:11115 vID:809
[   17.358925] ID:8 pID:11116 vID:810
[   17.362315] ID:9 pID:11117 vID:811
[   17.365705] ID:10 pID:11118 vID:812
[   17.369181] ID:11 pID:11119 vID:813
[   17.372659] ID:12 pID:11120 vID:814
[   17.376135] ID:13 pID:11121 vID:815
[   17.379612] ID:14 pID:11122 vID:816
[   17.383087] ID:15 pID:11123 vID:817
[   17.386564] ID:16 pID:11124 vID:818
[   17.390041] ID:17 pID:11125 vID:819
[   17.393518] ID:18 pID:11126 vID:820
[   17.396995] ID:19 pID:11127 vID:821
[   17.400471] ID:20 pID:11128 vID:822
[   17.403948] ID:21 pID:11129 vID:823
[   17.407425] ID:22 pID:11130 vID:824
[   17.410900] ID:23 pID:11131 vID:825
[   17.414377] ID:24 pID:11132 vID:826
[   17.417860] ID:25 pID:11133 vID:827
[   17.421347] ID:26 pID:11134 vID:828
[   17.424827] ID:27 pID:11135 vID:829
[   17.428311] ID:28 pID:11136 vID:830
[   17.431788] ID:29 pID:11137 vID:831
[   17.435263] ID:30 pID:11138 vID:832
[   17.438740] ID:31 pID:11139 vID:833
[   17.442313] Freed devid 0 LPI 0
[   17.445448] Freed devid 0 LPI 0
[   17.448586] Freed devid 0 LPI 0
[   17.451734] Freed devid 0 LPI 0
[   17.454870] Freed devid 0 LPI 0
[   17.458087] Freed devid 0 LPI 0
[   17.461259] hub 1-2:1.0: USB hub found
[   17.464998] Freed devid 0 LPI 0
[   17.468132] Freed devid 0 LPI 0
[   17.471266] hub 1-2:1.0: 4 ports detected
[   17.475265] Freed devid 0 LPI 0
[   17.478398] Freed devid 0 LPI 0
[   17.481554] Freed devid 0 LPI 0
[   17.484693] Freed devid 0 LPI 0
[   17.487892] Freed devid 0 LPI 0
[   17.491028] Freed devid 0 LPI 0
[   17.494166] Freed devid 0 LPI 0
[   17.497303] Freed devid 0 LPI 0
[   17.500476] Freed devid 0 LPI 0
[   17.503606] Freed devid 0 LPI 0
[   17.506733] Freed devid 0 LPI 0
[   17.509863] Freed devid 0 LPI 0
[   17.512996] Freed devid 0 LPI 0
[   17.516128] Freed devid 0 LPI 0
[   17.519255] Freed devid 0 LPI 0
[   17.522384] Freed devid 0 LPI 0
[   17.525514] Freed devid 0 LPI 0
[   17.528643] Freed devid 0 LPI 0
[   17.531773] Freed devid 0 LPI 0
[   17.534900] Freed devid 0 LPI 0
[   17.538029] Freed devid 0 LPI 0
[   17.541158] Freed devid 0 LPI 0
[   17.544287] Freed devid 0 LPI 0
[   17.547416] Freed devid 0 LPI 0
[   17.550545] Unmap devid 0
[   17.553403] ITS: alloc 11108:32
[   17.556541] ITT 32 entries, 5 bits
[   17.559946] ID:0 pID:11108 vID:802
[   17.563473] pcieport 0000:00:04.0: Adding to iommu group 8
[   17.569074] ITS: alloc 11140:32
[   17.572208] ITT 32 entries, 5 bits
[   17.575831] ID:0 pID:11140 vID:803
[   17.579219] ID:1 pID:11141 vID:804
[   17.582611] ID:2 pID:11142 vID:805
[   17.586001] ID:3 pID:11143 vID:806
[   17.589390] ID:4 pID:11144 vID:807
[   17.592781] ID:5 pID:11145 vID:808
[   17.596171] ID:6 pID:11146 vID:809
[   17.599561] ID:7 pID:11147 vID:810
[   17.602949] ID:8 pID:11148 vID:811
[   17.606348] ID:9 pID:11149 vID:812
[   17.609748] ID:10 pID:11150 vID:813
[   17.613233] ID:11 pID:11151 vID:814
[   17.616719] ID:12 pID:11152 vID:815
[   17.620204] ID:13 pID:11153 vID:816
[   17.623689] ID:14 pID:11154 vID:817
[   17.627164] ID:15 pID:11155 vID:818
[   17.630642] ID:16 pID:11156 vID:819
[   17.634122] ID:17 pID:11157 vID:820
[   17.637602] ID:18 pID:11158 vID:821
[   17.641078] ID:19 pID:11159 vID:822
[   17.644556] ID:20 pID:11160 vID:823
[   17.648032] ID:21 pID:11161 vID:824
[   17.651509] ID:22 pID:11162 vID:825
[   17.654986] ID:23 pID:11163 vID:826
[   17.658462] ID:24 pID:11164 vID:827
[   17.661939] ID:25 pID:11165 vID:828
[   17.665415] ID:26 pID:11166 vID:829
[   17.668892] ID:27 pID:11167 vID:830
[   17.672369] ID:28 pID:11168 vID:831
[   17.675846] ID:29 pID:11169 vID:832
[   17.679323] ID:30 pID:11170 vID:833
[   17.682798] ID:31 pID:11171 vID:834
[   17.686363] Freed devid 20 LPI 0
[   17.689585] Freed devid 20 LPI 0
[   17.692804] Freed devid 20 LPI 0
[   17.696024] Freed devid 20 LPI 0
[   17.699238] Freed devid 20 LPI 0
[   17.702454] Freed devid 20 LPI 0
[   17.705671] Freed devid 20 LPI 0
[   17.708887] Freed devid 20 LPI 0
[   17.712103] Freed devid 20 LPI 0
[   17.715319] Freed devid 20 LPI 0
[   17.718533] Freed devid 20 LPI 0
[   17.721748] Freed devid 20 LPI 0
[   17.724964] Freed devid 20 LPI 0
[   17.728189] Freed devid 20 LPI 0
[   17.731405] Freed devid 20 LPI 0
[   17.734619] Freed devid 20 LPI 0
[   17.737834] Freed devid 20 LPI 0
[   17.741050] Freed devid 20 LPI 0
[   17.744266] Freed devid 20 LPI 0
[   17.747482] Freed devid 20 LPI 0
[   17.750696] Freed devid 20 LPI 0
[   17.753912] Freed devid 20 LPI 0
[   17.757128] Freed devid 20 LPI 0
[   17.760344] Freed devid 20 LPI 0
[   17.763560] Freed devid 20 LPI 0
[   17.766774] Freed devid 20 LPI 0
[   17.769989] Freed devid 20 LPI 0
[   17.773205] Freed devid 20 LPI 0
[   17.776421] Freed devid 20 LPI 0
[   17.779637] Freed devid 20 LPI 0
[   17.782851] Freed devid 20 LPI 0
[   17.786067] Freed devid 20 LPI 0
[   17.789283] Unmap devid 20
[   17.792229] ITS: alloc 11140:1
[   17.795272] ITT 1 entries, 0 bits
[   17.798590] ID:0 pID:11140 vID:803
[   17.802094] pcieport 0000:00:08.0: Adding to iommu group 9
[   17.807707] ITS: alloc 11141:32
[   17.810853] ITT 32 entries, 5 bits
[   17.814476] ID:0 pID:11141 vID:804
[   17.817869] ID:1 pID:11142 vID:805
[   17.821259] ID:2 pID:11143 vID:806
[   17.824650] ID:3 pID:11144 vID:807
[   17.828044] ID:4 pID:11145 vID:808
[   17.831442] ID:5 pID:11146 vID:809
[   17.834840] ID:6 pID:11147 vID:810
[   17.838236] ID:7 pID:11148 vID:811
[   17.841627] ID:8 pID:11149 vID:812
[   17.845017] ID:9 pID:11150 vID:813
[   17.848408] ID:10 pID:11151 vID:814
[   17.851888] ID:11 pID:11152 vID:815
[   17.855367] ID:12 pID:11153 vID:816
[   17.858842] ID:13 pID:11154 vID:817
[   17.862319] ID:14 pID:11155 vID:818
[   17.865795] ID:15 pID:11156 vID:819
[   17.869272] ID:16 pID:11157 vID:820
[   17.872750] ID:17 pID:11158 vID:821
[   17.876227] ID:18 pID:11159 vID:822
[   17.879703] ID:19 pID:11160 vID:823
[   17.883178] ID:20 pID:11161 vID:824
[   17.886655] ID:21 pID:11162 vID:825
[   17.890132] ID:22 pID:11163 vID:826
[   17.893609] ID:23 pID:11164 vID:827
[   17.897088] usb 1-2.1: new full-speed USB device number 4 using ehci-pci
[   17.903777] ID:24 pID:11165 vID:828
[   17.907252] ID:25 pID:11166 vID:829
[   17.910733] ID:26 pID:11167 vID:830
[   17.914214] ID:27 pID:11168 vID:831
[   17.917691] ID:28 pID:11169 vID:832
[   17.921168] ID:29 pID:11170 vID:833
[   17.924645] ID:30 pID:11171 vID:834
[   17.928122] ID:31 pID:11172 vID:835
[   17.931696] Freed devid 40 LPI 0
[   17.934910] Freed devid 40 LPI 0
[   17.938131] Freed devid 40 LPI 0
[   17.941351] Freed devid 40 LPI 0
[   17.944571] Freed devid 40 LPI 0
[   17.947787] Freed devid 40 LPI 0
[   17.951001] Freed devid 40 LPI 0
[   17.954216] Freed devid 40 LPI 0
[   17.957432] Freed devid 40 LPI 0
[   17.960648] Freed devid 40 LPI 0
[   17.963864] Freed devid 40 LPI 0
[   17.967078] Freed devid 40 LPI 0
[   17.970294] Freed devid 40 LPI 0
[   17.973510] Freed devid 40 LPI 0
[   17.976726] Freed devid 40 LPI 0
[   17.979942] Freed devid 40 LPI 0
[   17.983156] Freed devid 40 LPI 0
[   17.986371] Freed devid 40 LPI 0
[   17.989587] Freed devid 40 LPI 0
[   17.992803] Freed devid 40 LPI 0
[   17.996019] Freed devid 40 LPI 0
[   17.999233] Freed devid 40 LPI 0
[   18.002449] Freed devid 40 LPI 0
[   18.005665] Freed devid 40 LPI 0
[   18.008881] Freed devid 40 LPI 0
[   18.012097] Freed devid 40 LPI 0
[   18.015313] Freed devid 40 LPI 0
[   18.018527] Freed devid 40 LPI 0
[   18.021742] Freed devid 40 LPI 0
[   18.024958] Freed devid 40 LPI 0
[   18.028174] Freed devid 40 LPI 0
[   18.031390] Freed devid 40 LPI 0
[   18.034605] Unmap devid 40
[   18.037533] ITS: alloc 11141:1
[   18.040582] ITT 1 entries, 0 bits
[   18.043899] ID:0 pID:11141 vID:804
[   18.047420] pcieport 0000:00:0c.0: Adding to iommu group 10
[   18.057157] ITS: alloc 11142:32
[   18.060293] ITT 32 entries, 5 bits
[   18.063917] ID:0 pID:11142 vID:805
[   18.067309] ID:1 pID:11143 vID:806
[   18.070697] ID:2 pID:11144 vID:807
[   18.074092] ID:3 pID:11145 vID:808
[   18.077483] ID:4 pID:11146 vID:809
[   18.080873] ID:5 pID:11147 vID:810
[   18.084263] ID:6 pID:11148 vID:811
[   18.087653] ID:7 pID:11149 vID:812
[   18.091041] ID:8 pID:11150 vID:813
[   18.094431] ID:9 pID:11151 vID:814
[   18.097821] ID:10 pID:11152 vID:815
[   18.101298] ID:11 pID:11153 vID:816
[   18.104775] ID:12 pID:11154 vID:817
[   18.108252] ID:13 pID:11155 vID:818
[   18.111728] ID:14 pID:11156 vID:819
[   18.115203] ID:15 pID:11157 vID:820
[   18.118679] ID:16 pID:11158 vID:821
[   18.122156] ID:17 pID:11159 vID:822
[   18.125633] ID:18 pID:11160 vID:823
[   18.129110] ID:19 pID:11161 vID:824
[   18.132587] ID:20 pID:11162 vID:825
[   18.136064] ID:21 pID:11163 vID:826
[   18.139540] ID:22 pID:11164 vID:827
[   18.143015] ID:23 pID:11165 vID:828
[   18.146492] ID:24 pID:11166 vID:829
[   18.149970] ID:25 pID:11167 vID:830
[   18.153447] ID:26 pID:11168 vID:831
[   18.156924] ID:27 pID:11169 vID:832
[   18.160401] ID:28 pID:11170 vID:833
[   18.163877] ID:29 pID:11171 vID:834
[   18.167354] ID:30 pID:11172 vID:835
[   18.170829] ID:31 pID:11173 vID:836
[   18.174395] Freed devid 60 LPI 0
[   18.177616] Freed devid 60 LPI 0
[   18.180835] Freed devid 60 LPI 0
[   18.184054] Freed devid 60 LPI 0
[   18.187268] Freed devid 60 LPI 0
[   18.190484] Freed devid 60 LPI 0
[   18.193700] Freed devid 60 LPI 0
[   18.196916] Freed devid 60 LPI 0
[   18.200132] Freed devid 60 LPI 0
[   18.203347] Freed devid 60 LPI 0
[   18.206562] Freed devid 60 LPI 0
[   18.209777] Freed devid 60 LPI 0
[   18.212993] Freed devid 60 LPI 0
[   18.216209] Freed devid 60 LPI 0
[   18.219425] Freed devid 60 LPI 0
[   18.222639] Freed devid 60 LPI 0
[   18.225855] Freed devid 60 LPI 0
[   18.229071] Freed devid 60 LPI 0
[   18.232287] Freed devid 60 LPI 0
[   18.235503] Freed devid 60 LPI 0
[   18.238717] Freed devid 60 LPI 0
[   18.241932] Freed devid 60 LPI 0
[   18.245148] Freed devid 60 LPI 0
[   18.248364] Freed devid 60 LPI 0
[   18.251581] Freed devid 60 LPI 0
[   18.254795] Freed devid 60 LPI 0
[   18.258011] Freed devid 60 LPI 0
[   18.261227] Freed devid 60 LPI 0
[   18.264443] Freed devid 60 LPI 0
[   18.267659] Freed devid 60 LPI 0
[   18.270873] Freed devid 60 LPI 0
[   18.274088] Freed devid 60 LPI 0
[   18.277305] Unmap devid 60
[   18.280248] ITS: alloc 11142:1
[   18.283297] ITT 1 entries, 0 bits
[   18.286608] ID:0 pID:11142 vID:805
[   18.290112] pcieport 0000:00:10.0: Adding to iommu group 11
[   18.295826] ITS: alloc 11143:32
[   18.298956] ITT 32 entries, 5 bits
[   18.302579] ID:0 pID:11143 vID:806
[   18.305971] ID:1 pID:11144 vID:807
[   18.309361] ID:2 pID:11145 vID:808
[   18.312751] ID:3 pID:11146 vID:809
[   18.316146] ID:4 pID:11147 vID:810
[   18.319536] ID:5 pID:11148 vID:811
[   18.322924] ID:6 pID:11149 vID:812
[   18.326315] ID:7 pID:11150 vID:813
[   18.329704] ID:8 pID:11151 vID:814
[   18.333094] ID:9 pID:11152 vID:815
[   18.336484] ID:10 pID:11153 vID:816
[   18.339961] ID:11 pID:11154 vID:817
[   18.343438] ID:12 pID:11155 vID:818
[   18.346913] ID:13 pID:11156 vID:819
[   18.350389] ID:14 pID:11157 vID:820
[   18.353867] ID:15 pID:11158 vID:821
[   18.357344] ID:16 pID:11159 vID:822
[   18.360820] ID:17 pID:11160 vID:823
[   18.364297] ID:18 pID:11161 vID:824
[   18.367774] ID:19 pID:11162 vID:825
[   18.371249] ID:20 pID:11163 vID:826
[   18.374726] ID:21 pID:11164 vID:827
[   18.378202] ID:22 pID:11165 vID:828
[   18.381679] ID:23 pID:11166 vID:829
[   18.385156] ID:24 pID:11167 vID:830
[   18.388633] ID:25 pID:11168 vID:831
[   18.392110] ID:26 pID:11169 vID:832
[   18.395587] ID:27 pID:11170 vID:833
[   18.399061] ID:28 pID:11171 vID:834
[   18.402538] ID:29 pID:11172 vID:835
[   18.406015] ID:30 pID:11173 vID:836
[   18.409491] ID:31 pID:11174 vID:837
[   18.413056] Freed devid 80 LPI 0
[   18.416277] Freed devid 80 LPI 0
[   18.419497] Freed devid 80 LPI 0
[   18.422711] Freed devid 80 LPI 0
[   18.425930] Freed devid 80 LPI 0
[   18.429147] Freed devid 80 LPI 0
[   18.432362] Freed devid 80 LPI 0
[   18.435578] Freed devid 80 LPI 0
[   18.438792] Freed devid 80 LPI 0
[   18.442008] Freed devid 80 LPI 0
[   18.445224] Freed devid 80 LPI 0
[   18.448440] Freed devid 80 LPI 0
[   18.451656] Freed devid 80 LPI 0
[   18.454871] Freed devid 80 LPI 0
[   18.458087] Freed devid 80 LPI 0
[   18.461303] Freed devid 80 LPI 0
[   18.464519] Freed devid 80 LPI 0
[   18.467735] Freed devid 80 LPI 0
[   18.470949] Freed devid 80 LPI 0
[   18.474165] Freed devid 80 LPI 0
[   18.477381] Freed devid 80 LPI 0
[   18.480597] Freed devid 80 LPI 0
[   18.483813] Freed devid 80 LPI 0
[   18.487027] Freed devid 80 LPI 0
[   18.490243] Freed devid 80 LPI 0
[   18.493459] Freed devid 80 LPI 0
[   18.496675] Freed devid 80 LPI 0
[   18.499890] Freed devid 80 LPI 0
[   18.503105] Freed devid 80 LPI 0
[   18.506320] Freed devid 80 LPI 0
[   18.509552] Freed devid 80 LPI 0
[   18.512769] Freed devid 80 LPI 0
[   18.515985] Unmap devid 80
[   18.518924] ITS: alloc 11143:1
[   18.521973] ITT 1 entries, 0 bits
[   18.525290] ID:0 pID:11143 vID:806
[   18.528810] pcieport 0000:00:12.0: Adding to iommu group 12
[   18.534514] ITS: alloc 11144:32
[   18.537648] ITT 32 entries, 5 bits
[   18.541269] ID:0 pID:11144 vID:807
[   18.544660] ID:1 pID:11145 vID:808
[   18.548051] ID:2 pID:11146 vID:809
[   18.551445] ID:3 pID:11147 vID:810
[   18.554834] ID:4 pID:11148 vID:811
[   18.558225] ID:5 pID:11149 vID:812
[   18.561615] ID:6 pID:11150 vID:813
[   18.565005] ID:7 pID:11151 vID:814
[   18.568395] ID:8 pID:11152 vID:815
[   18.571785] ID:9 pID:11153 vID:816
[   18.575174] ID:10 pID:11154 vID:817
[   18.578650] ID:11 pID:11155 vID:818
[   18.582127] ID:12 pID:11156 vID:819
[   18.585604] ID:13 pID:11157 vID:820
[   18.589081] ID:14 pID:11158 vID:821
[   18.592557] ID:15 pID:11159 vID:822
[   18.596035] ID:16 pID:11160 vID:823
[   18.599511] ID:17 pID:11161 vID:824
[   18.602986] ID:18 pID:11162 vID:825
[   18.606463] ID:19 pID:11163 vID:826
[   18.609940] ID:20 pID:11164 vID:827
[   18.613416] ID:21 pID:11165 vID:828
[   18.616893] ID:22 pID:11166 vID:829
[   18.620370] ID:23 pID:11167 vID:830
[   18.623847] ID:24 pID:11168 vID:831
[   18.627324] ID:25 pID:11169 vID:832
[   18.630799] ID:26 pID:11170 vID:833
[   18.634275] ID:27 pID:11171 vID:834
[   18.637752] ID:28 pID:11172 vID:835
[   18.641229] ID:29 pID:11173 vID:836
[   18.644706] ID:30 pID:11174 vID:837
[   18.648183] ID:31 pID:11175 vID:838
[   18.651751] Freed devid 90 LPI 0
[   18.654965] Freed devid 90 LPI 0
[   18.658186] Freed devid 90 LPI 0
[   18.661406] Freed devid 90 LPI 0
[   18.664625] Freed devid 90 LPI 0
[   18.667841] Freed devid 90 LPI 0
[   18.671055] Freed devid 90 LPI 0
[   18.674271] Freed devid 90 LPI 0
[   18.677487] Freed devid 90 LPI 0
[   18.680702] Freed devid 90 LPI 0
[   18.683918] Freed devid 90 LPI 0
[   18.687132] Freed devid 90 LPI 0
[   18.690348] Freed devid 90 LPI 0
[   18.693564] Freed devid 90 LPI 0
[   18.696780] Freed devid 90 LPI 0
[   18.699996] Freed devid 90 LPI 0
[   18.703210] Freed devid 90 LPI 0
[   18.706426] Freed devid 90 LPI 0
[   18.709642] Freed devid 90 LPI 0
[   18.712858] Freed devid 90 LPI 0
[   18.716073] Freed devid 90 LPI 0
[   18.719290] Freed devid 90 LPI 0
[   18.722503] Freed devid 90 LPI 0
[   18.725719] Freed devid 90 LPI 0
[   18.728935] Freed devid 90 LPI 0
[   18.732151] Freed devid 90 LPI 0
[   18.735367] Freed devid 90 LPI 0
[   18.738581] Freed devid 90 LPI 0
[   18.741797] Freed devid 90 LPI 0
[   18.745013] Freed devid 90 LPI 0
[   18.748229] Freed devid 90 LPI 0
[   18.751444] Freed devid 90 LPI 0
[   18.754659] Unmap devid 90
[   18.757594] ITS: alloc 11144:1
[   18.760643] ITT 1 entries, 0 bits
[   18.763961] ID:0 pID:11144 vID:807
[   18.767537] pcieport 0000:7c:00.0: Adding to iommu group 13
[   18.773213] pcieport 0000:74:00.0: Adding to iommu group 14
[   18.778918] pcieport 0000:80:00.0: Adding to iommu group 15
[   18.784589] ITS: alloc 11145:32
[   18.787722] ITT 32 entries, 5 bits
[   18.791482] ID:0 pID:11145 vID:808
[   18.794870] ID:1 pID:11146 vID:809
[   18.798261] ID:2 pID:11147 vID:810
[   18.801651] ID:3 pID:11148 vID:811
[   18.805041] ID:4 pID:11149 vID:812
[   18.808431] ID:5 pID:11150 vID:813
[   18.811821] ID:6 pID:11151 vID:814
[   18.815210] ID:7 pID:11152 vID:815
[   18.818599] ID:8 pID:11153 vID:816
[   18.821989] ID:9 pID:11154 vID:817
[   18.825380] ID:10 pID:11155 vID:818
[   18.828856] ID:11 pID:11156 vID:819
[   18.832333] ID:12 pID:11157 vID:820
[   18.835810] ID:13 pID:11158 vID:821
[   18.839287] ID:14 pID:11159 vID:822
[   18.842762] ID:15 pID:11160 vID:823
[   18.846239] ID:16 pID:11161 vID:824
[   18.849716] ID:17 pID:11162 vID:825
[   18.853192] ID:18 pID:11163 vID:826
[   18.856669] ID:19 pID:11164 vID:827
[   18.860146] ID:20 pID:11165 vID:828
[   18.863623] ID:21 pID:11166 vID:829
[   18.867100] ID:22 pID:11167 vID:830
[   18.870576] ID:23 pID:11168 vID:831
[   18.874053] ID:24 pID:11169 vID:832
[   18.877530] ID:25 pID:11170 vID:833
[   18.881007] ID:26 pID:11171 vID:834
[   18.884484] ID:27 pID:11172 vID:835
[   18.887961] ID:28 pID:11173 vID:836
[   18.891439] ID:29 pID:11174 vID:837
[   18.894914] ID:30 pID:11175 vID:838
[   18.898391] ID:31 pID:11176 vID:839
[   18.901974] Freed devid 8000 LPI 0
[   18.905371] Freed devid 8000 LPI 0
[   18.908764] Freed devid 8000 LPI 0
[   18.912157] Freed devid 8000 LPI 0
[   18.915547] Freed devid 8000 LPI 0
[   18.918935] Freed devid 8000 LPI 0
[   18.922324] Freed devid 8000 LPI 0
[   18.925713] Freed devid 8000 LPI 0
[   18.929103] Freed devid 8000 LPI 0
[   18.932492] Freed devid 8000 LPI 0
[   18.935882] Freed devid 8000 LPI 0
[   18.939270] Freed devid 8000 LPI 0
[   18.942659] Freed devid 8000 LPI 0
[   18.946049] Freed devid 8000 LPI 0
[   18.949438] Freed devid 8000 LPI 0
[   18.952828] Freed devid 8000 LPI 0
[   18.956217] Freed devid 8000 LPI 0
[   18.959607] Freed devid 8000 LPI 0
[   18.962994] Freed devid 8000 LPI 0
[   18.966384] Freed devid 8000 LPI 0
[   18.969774] Freed devid 8000 LPI 0
[   18.973164] Freed devid 8000 LPI 0
[   18.976553] Freed devid 8000 LPI 0
[   18.979943] Freed devid 8000 LPI 0
[   18.983332] Freed devid 8000 LPI 0
[   18.986720] Freed devid 8000 LPI 0
[   18.990109] Freed devid 8000 LPI 0
[   18.993499] Freed devid 8000 LPI 0
[   18.996888] Freed devid 8000 LPI 0
[   19.000278] Freed devid 8000 LPI 0
[   19.003667] Freed devid 8000 LPI 0
[   19.007055] Freed devid 8000 LPI 0
[   19.010445] Unmap devid 8000
[   19.013567] ITS: alloc 11145:1
[   19.016617] ITT 1 entries, 0 bits
[   19.019939] ID:0 pID:11145 vID:808
[   19.023475] pcieport 0000:80:08.0: Adding to iommu group 16
[   19.029143] ITS: alloc 11146:32
[   19.032275] ITT 32 entries, 5 bits
[   19.036025] ID:0 pID:11146 vID:809
[   19.039416] ID:1 pID:11147 vID:810
[   19.042804] ID:2 pID:11148 vID:811
[   19.046195] ID:3 pID:11149 vID:812
[   19.049584] ID:4 pID:11150 vID:813
[   19.052975] ID:5 pID:11151 vID:814
[   19.056365] ID:6 pID:11152 vID:815
[   19.059755] ID:7 pID:11153 vID:816
[   19.063142] ID:8 pID:11154 vID:817
[   19.066532] ID:9 pID:11155 vID:818
[   19.069923] ID:10 pID:11156 vID:819
[   19.073400] ID:11 pID:11157 vID:820
[   19.076877] ID:12 pID:11158 vID:821
[   19.080353] ID:13 pID:11159 vID:822
[   19.083831] ID:14 pID:11160 vID:823
[   19.087308] ID:15 pID:11161 vID:824
[   19.090783] ID:16 pID:11162 vID:825
[   19.094259] ID:17 pID:11163 vID:826
[   19.097736] ID:18 pID:11164 vID:827
[   19.101213] ID:19 pID:11165 vID:828
[   19.104690] ID:20 pID:11166 vID:829
[   19.108167] ID:21 pID:11167 vID:830
[   19.111644] ID:22 pID:11168 vID:831
[   19.115119] ID:23 pID:11169 vID:832
[   19.118595] ID:24 pID:11170 vID:833
[   19.122072] ID:25 pID:11171 vID:834
[   19.125549] ID:26 pID:11172 vID:835
[   19.129026] ID:27 pID:11173 vID:836
[   19.132503] ID:28 pID:11174 vID:837
[   19.135980] ID:29 pID:11175 vID:838
[   19.139457] ID:30 pID:11176 vID:839
[   19.142931] ID:31 pID:11177 vID:840
[   19.146516] Freed devid 8040 LPI 0
[   19.149913] Freed devid 8040 LPI 0
[   19.153306] Freed devid 8040 LPI 0
[   19.156699] Freed devid 8040 LPI 0
[   19.160088] Freed devid 8040 LPI 0
[   19.163478] Freed devid 8040 LPI 0
[   19.166865] Freed devid 8040 LPI 0
[   19.170255] Freed devid 8040 LPI 0
[   19.173645] Freed devid 8040 LPI 0
[   19.177034] Freed devid 8040 LPI 0
[   19.180424] Freed devid 8040 LPI 0
[   19.183813] Freed devid 8040 LPI 0
[   19.187201] Freed devid 8040 LPI 0
[   19.190590] Freed devid 8040 LPI 0
[   19.193980] Freed devid 8040 LPI 0
[   19.197369] Freed devid 8040 LPI 0
[   19.200759] Freed devid 8040 LPI 0
[   19.204148] Freed devid 8040 LPI 0
[   19.207538] Freed devid 8040 LPI 0
[   19.210925] Freed devid 8040 LPI 0
[   19.214315] Freed devid 8040 LPI 0
[   19.217704] Freed devid 8040 LPI 0
[   19.221094] Freed devid 8040 LPI 0
[   19.224483] Freed devid 8040 LPI 0
[   19.227873] Freed devid 8040 LPI 0
[   19.231260] Freed devid 8040 LPI 0
[   19.234650] Freed devid 8040 LPI 0
[   19.238039] Freed devid 8040 LPI 0
[   19.241429] Freed devid 8040 LPI 0
[   19.244818] Freed devid 8040 LPI 0
[   19.248208] Freed devid 8040 LPI 0
[   19.251597] Freed devid 8040 LPI 0
[   19.254986] Unmap devid 8040
[   19.258118] ITS: alloc 11146:1
[   19.261168] ITT 1 entries, 0 bits
[   19.264490] ID:0 pID:11146 vID:809
[   19.268025] pcieport 0000:80:0c.0: Adding to iommu group 17
[   19.273693] ITS: alloc 11147:32
[   19.276826] ITT 32 entries, 5 bits
[   19.280576] ID:0 pID:11147 vID:810
[   19.283967] ID:1 pID:11148 vID:811
[   19.287357] ID:2 pID:11149 vID:812
[   19.290745] ID:3 pID:11150 vID:813
[   19.294135] ID:4 pID:11151 vID:814
[   19.297525] ID:5 pID:11152 vID:815
[   19.300915] ID:6 pID:11153 vID:816
[   19.304305] ID:7 pID:11154 vID:817
[   19.307695] ID:8 pID:11155 vID:818
[   19.311083] ID:9 pID:11156 vID:819
[   19.314473] ID:10 pID:11157 vID:820
[   19.317949] ID:11 pID:11158 vID:821
[   19.321427] ID:12 pID:11159 vID:822
[   19.324903] ID:13 pID:11160 vID:823
[   19.328380] ID:14 pID:11161 vID:824
[   19.331857] ID:15 pID:11162 vID:825
[   19.335334] ID:16 pID:11163 vID:826
[   19.338809] ID:17 pID:11164 vID:827
[   19.342285] ID:18 pID:11165 vID:828
[   19.345762] ID:19 pID:11166 vID:829
[   19.349240] ID:20 pID:11167 vID:830
[   19.352716] ID:21 pID:11168 vID:831
[   19.356193] ID:22 pID:11169 vID:832
[   19.359670] ID:23 pID:11170 vID:833
[   19.363145] ID:24 pID:11171 vID:834
[   19.366621] ID:25 pID:11172 vID:835
[   19.370098] ID:26 pID:11173 vID:836
[   19.373575] ID:27 pID:11174 vID:837
[   19.377053] ID:28 pID:11175 vID:838
[   19.380529] ID:29 pID:11176 vID:839
[   19.384006] ID:30 pID:11177 vID:840
[   19.387483] ID:31 pID:11178 vID:841
[   19.391059] Freed devid 8060 LPI 0
[   19.394456] Freed devid 8060 LPI 0
[   19.397849] Freed devid 8060 LPI 0
[   19.401241] Freed devid 8060 LPI 0
[   19.404631] Freed devid 8060 LPI 0
[   19.408020] Freed devid 8060 LPI 0
[   19.411410] Freed devid 8060 LPI 0
[   19.414798] Freed devid 8060 LPI 0
[   19.418187] Freed devid 8060 LPI 0
[   19.421576] Freed devid 8060 LPI 0
[   19.424966] Freed devid 8060 LPI 0
[   19.428356] Freed devid 8060 LPI 0
[   19.431745] Freed devid 8060 LPI 0
[   19.435133] Freed devid 8060 LPI 0
[   19.438522] Freed devid 8060 LPI 0
[   19.441911] Freed devid 8060 LPI 0
[   19.445301] Freed devid 8060 LPI 0
[   19.448690] Freed devid 8060 LPI 0
[   19.452080] Freed devid 8060 LPI 0
[   19.455470] Freed devid 8060 LPI 0
[   19.458857] Freed devid 8060 LPI 0
[   19.462247] Freed devid 8060 LPI 0
[   19.465636] Freed devid 8060 LPI 0
[   19.469026] Freed devid 8060 LPI 0
[   19.472416] Freed devid 8060 LPI 0
[   19.475806] Freed devid 8060 LPI 0
[   19.479195] Freed devid 8060 LPI 0
[   19.482584] Freed devid 8060 LPI 0
[   19.485974] Freed devid 8060 LPI 0
[   19.489363] Freed devid 8060 LPI 0
[   19.492753] Freed devid 8060 LPI 0
[   19.496142] Freed devid 8060 LPI 0
[   19.499533] Unmap devid 8060
[   19.502669] ITS: alloc 11147:1
[   19.505718] ITT 1 entries, 0 bits
[   19.509039] ID:0 pID:11147 vID:810
[   19.512576] pcieport 0000:80:10.0: Adding to iommu group 18
[   19.518241] ITS: alloc 11148:32
[   19.521374] ITT 32 entries, 5 bits
[   19.525131] ID:0 pID:11148 vID:811
[   19.528522] ID:1 pID:11149 vID:812
[   19.531912] ID:2 pID:11150 vID:813
[   19.535302] ID:3 pID:11151 vID:814
[   19.538690] ID:4 pID:11152 vID:815
[   19.542080] ID:5 pID:11153 vID:816
[   19.545470] ID:6 pID:11154 vID:817
[   19.548860] ID:7 pID:11155 vID:818
[   19.552250] ID:8 pID:11156 vID:819
[   19.555640] ID:9 pID:11157 vID:820
[   19.559029] ID:10 pID:11158 vID:821
[   19.562505] ID:11 pID:11159 vID:822
[   19.565982] ID:12 pID:11160 vID:823
[   19.569459] ID:13 pID:11161 vID:824
[   19.572936] ID:14 pID:11162 vID:825
[   19.576413] ID:15 pID:11163 vID:826
[   19.579891] ID:16 pID:11164 vID:827
[   19.583368] ID:17 pID:11165 vID:828
[   19.586842] ID:18 pID:11166 vID:829
[   19.590319] ID:19 pID:11167 vID:830
[   19.593795] ID:20 pID:11168 vID:831
[   19.597272] ID:21 pID:11169 vID:832
[   19.600749] ID:22 pID:11170 vID:833
[   19.604226] ID:23 pID:11171 vID:834
[   19.607703] ID:24 pID:11172 vID:835
[   19.611177] ID:25 pID:11173 vID:836
[   19.614654] ID:26 pID:11174 vID:837
[   19.618130] ID:27 pID:11175 vID:838
[   19.621607] ID:28 pID:11176 vID:839
[   19.625084] ID:29 pID:11177 vID:840
[   19.628561] ID:30 pID:11178 vID:841
[   19.632037] ID:31 pID:11179 vID:842
[   19.635617] Freed devid 8080 LPI 0
[   19.639004] Freed devid 8080 LPI 0
[   19.642400] Freed devid 8080 LPI 0
[   19.645794] Freed devid 8080 LPI 0
[   19.649187] Freed devid 8080 LPI 0
[   19.652576] Freed devid 8080 LPI 0
[   19.655966] Freed devid 8080 LPI 0
[   19.659355] Freed devid 8080 LPI 0
[   19.662743] Freed devid 8080 LPI 0
[   19.666132] Freed devid 8080 LPI 0
[   19.669522] Freed devid 8080 LPI 0
[   19.672911] Freed devid 8080 LPI 0
[   19.676301] Freed devid 8080 LPI 0
[   19.679690] Freed devid 8080 LPI 0
[   19.683079] Freed devid 8080 LPI 0
[   19.686469] Freed devid 8080 LPI 0
[   19.689858] Freed devid 8080 LPI 0
[   19.693248] Freed devid 8080 LPI 0
[   19.696637] Freed devid 8080 LPI 0
[   19.700027] Freed devid 8080 LPI 0
[   19.703417] Freed devid 8080 LPI 0
[   19.706804] Freed devid 8080 LPI 0
[   19.710193] Freed devid 8080 LPI 0
[   19.713583] Freed devid 8080 LPI 0
[   19.716972] Freed devid 8080 LPI 0
[   19.720362] Freed devid 8080 LPI 0
[   19.723752] Freed devid 8080 LPI 0
[   19.727139] Freed devid 8080 LPI 0
[   19.730528] Freed devid 8080 LPI 0
[   19.733918] Freed devid 8080 LPI 0
[   19.737307] Freed devid 8080 LPI 0
[   19.740697] Freed devid 8080 LPI 0
[   19.744087] Unmap devid 8080
[   19.747227] ITS: alloc 11148:1
[   19.750276] ITT 1 entries, 0 bits
[   19.753598] ID:0 pID:11148 vID:811
[   19.757180] pcieport 0000:bc:00.0: Adding to iommu group 19
[   19.762888] pcieport 0000:b4:00.0: Adding to iommu group 20
[   19.878802] rtc-efi rtc-efi: setting system clock to 
2019-09-05T10:17:35 UTC (1567678655)
[   19.887018] ALSA device list:
[   19.889982]   No soundcards found.
[   19.894732] Freeing unused kernel memory: 4992K
[   19.899406] Run /init as init process
root@(none)$ [   23.227675] input: Keyboard/Mouse KVM 1.1.0 as 
/devices/pci0000:7a/0000:7a:01.0/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input1
[   23.299424] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10 
Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-0000:7a:01.0-2.1/input0
[   23.312114] input: Keyboard/Mouse KVM 1.1.0 as 
/devices/pci0000:7a/0000:7a:01.0/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input2
[   23.324485] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 
Mouse [Keyboard/Mouse KVM 1.1.0] on usb-0000:7a:01.0-2.1/input1
unbind
[  101.391386] sas: REVALIDATING DOMAIN on port 0, pid:156i_sas_v3_hw/
[  101.397896] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  101.403197] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[  101.409638] sas: REVALIDATING DOMAIN on port 0, pid:156
[  101.416089] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  101.421390] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[  101.427828] sas: REVALIDATING DOMAIN on port 0, pid:156
[  101.434296] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  101.439597] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[  101.446034] sas: REVALIDATING DOMAIN on port 0, pid:156
[  101.452499] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  101.457799] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[  101.464235] sas: REVALIDATING DOMAIN on port 0, pid:156
[  101.470679] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  101.475978] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[  101.482415] sas: REVALIDATING DOMAIN on port 0, pid:156
[  101.488902] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  101.494202] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[  101.500639] sas: REVALIDATING DOMAIN on port 0, pid:156
[  101.507090] sas: ex 500e004aaaaaaa1f phys DID NOT change
[  101.512390] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[  101.519229] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] is gone
[  101.525112] sd 0:0:3:0: [sdd] Synchronizing SCSI cache
[  101.583650] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] is gone
[  101.589543] sd 0:0:2:0: [sdc] Synchronizing SCSI cache
[  101.594755] sd 0:0:2:0: [sdc] Stopping disk
[  102.079643] hisi_sas_v3_hw 0000:74:02.0: dev[4:5] is gone
[  102.085614] sd 0:0:1:0: [sdb] Synchronizing SCSI cache
[  102.139642] hisi_sas_v3_hw 0000:74:02.0: dev[3:1] is gone
[  102.145456] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  102.175631] hisi_sas_v3_hw 0000:74:02.0: dev[2:1] is gone
[  102.183285] hisi_sas_v3_hw 0000:74:02.0: dev[1:2] is gone
[  102.189618] Freed devid 7410 LPI 0
[  102.193019] Freed devid 7410 LPI 0
[  102.196420] Freed devid 7410 LPI 0
[  102.199854] Freed devid 7410 LPI 0
[  102.203242] Freed devid 7410 LPI 0
[  102.206640] Freed devid 7410 LPI 0
[  102.210036] Freed devid 7410 LPI 0
[  102.213426] Freed devid 7410 LPI 0
[  102.216816] Freed devid 7410 LPI 0
[  102.220206] Freed devid 7410 LPI 0
[  102.223596] Freed devid 7410 LPI 0
[  102.226984] Freed devid 7410 LPI 0
[  102.230373] Freed devid 7410 LPI 0
[  102.233763] Freed devid 7410 LPI 0
[  102.237152] Freed devid 7410 LPI 0
[  102.240542] Freed devid 7410 LPI 0
[  102.243931] Freed devid 7410 LPI 0
bind one)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/u
[  111.662451] scsi host0: hisi_sas_v3_hw
[  112.887353] Reusing ITT for devID 7410
[  112.911275] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2
sh: echo: write error: No such device


