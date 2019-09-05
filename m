Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91837C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3477020825
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 09:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387567AbfIEJkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 05:40:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6224 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731058AbfIEJkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 05:40:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CB123BB72BA3E83842E5;
        Thu,  5 Sep 2019 17:39:57 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 17:39:49 +0800
Subject: Re: PCI/kernel msi code vs GIC ITS driver conflict?
To:     Marc Zyngier <maz@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>
References: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
 <5fd4c1cf-76c1-4054-3754-549317509310@kernel.org>
 <ef258ec7-877c-406a-3d88-80ff79b823f2@huawei.com>
 <20190904102537.GV9720@e119886-lin.cambridge.arm.com>
 <8f1c1fe6-c0d4-1805-b119-6a48a4900e6d@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <84f6756f-79f2-2e46-fe44-9a46be69f99d@huawei.com>
Date:   Thu, 5 Sep 2019 10:39:43 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <8f1c1fe6-c0d4-1805-b119-6a48a4900e6d@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> That's a "feature" of the architecture. The ITT is sized by the number
> of bits used to index the table, meaning that you can only describe a
> power of two >= 2.
>
> John, could you stick a "#define DEBUG 1" at the top of irq-gic-v3-its.c
> and report the LPI allocations for this device?
>

Hi Marc,

As requested, I enabled debug for that driver and here are some kernel 
log snippets:

[    8.435707] hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 0
[    8.461467] scsi host0: hisi_sas_v3_hw
[    9.683463] ITS: alloc 9920:32
[    9.686509] ITT 32 entries, 5 bits
[    9.690044] ID:0 pID:9920 vID:23
[    9.693263] ID:1 pID:9921 vID:24
[    9.696480] ID:2 pID:9922 vID:25
[    9.699696] ID:3 pID:9923 vID:26
[    9.702911] ID:4 pID:9924 vID:27
[    9.706128] ID:5 pID:9925 vID:28
[    9.709344] ID:6 pID:9926 vID:29
[    9.712560] ID:7 pID:9927 vID:30
[    9.715776] ID:8 pID:9928 vID:31
[    9.718990] ID:9 pID:9929 vID:32
[    9.722207] ID:10 pID:9930 vID:33
[    9.725510] ID:11 pID:9931 vID:34
[    9.728813] ID:12 pID:9932 vID:35
[    9.732116] ID:13 pID:9933 vID:36
[    9.735419] ID:14 pID:9934 vID:37
[    9.738721] ID:15 pID:9935 vID:38
[    9.742024] ID:16 pID:9936 vID:39

<snip>

(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind

<snip>

root@(none)$
$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/bind
[   41.110557] scsi host0: hisi_sas_v3_hw
[   42.335455] Reusing ITT for devID 7410
[   42.359151] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2
sh: echo: write error: No such device
root@(none)$

Full kernel log below.

Cheers,
John


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
#869 SMP PREEMPT Thu Sep 5 10:10:51 BST 2019
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.70 by EDK II
[    0.000000] efi:  ACPI 2.0=0x39db0000  SMBIOS 3.0=0x3f150000 
MEMATTR=0x3b45b018  ESRT=0x3e2e1a98  MEMRESERVE=0x3a160e98
[    0.000000] esrt: Reserving ESRT space from 0x000000003e2e1a98 to 
0x000000003e2e1ad0.
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
[    0.000000]   node   0: [mem 0x0000000000000000-0x0000000030f7ffff]
[    0.000000]   node   0: [mem 0x0000000030f80000-0x00000000314effff]
[    0.000000]   node   0: [mem 0x00000000314f0000-0x000000003975ffff]
[    0.000000]   node   0: [mem 0x0000000039760000-0x000000003977ffff]
[    0.000000]   node   0: [mem 0x0000000039780000-0x000000003978ffff]
[    0.000000]   node   0: [mem 0x0000000039790000-0x000000003982ffff]
[    0.000000]   node   0: [mem 0x0000000039830000-0x000000003988ffff]
[    0.000000]   node   0: [mem 0x0000000039890000-0x0000000039a6ffff]
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
[    0.000000] Zeroed struct page in unavailable ranges: 568 pages
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
[    0.000000] Built 4 zonelists, mobility grouping on.r_cpus=1 loglevel=8
[    0.000000] PCIe ASPM is disabled
[    0.000000] Dentry cache hash table entries: 2097152 (order: 12, 
16777216 bytes, linear)
[    0.000000] Inode-cache hash table entries: 1048576 (order: 11, 
8388608 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x7a000000-0x7e000000] (64MB)
[    0.000000] Memory: 15758596K/16772992K available (11644K kernel 
code, 1792K rwdata, 6012K rodata, 4992K init, 450K bss, 981628K 
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
[    0.000219] Calibrating delay loop (skipped), value calculated using 
timer frequency.. 200.00 BogoMIPS (lpj=400000)
[    0.000222] pid_max: default: 32768 minimum: 301
[    0.000239] LSM: Security Framework initializing
[    0.000271] Mount-cache hash table entries: 32768 (order: 6, 262144 
bytes, linear)
[    0.000289] Mountpoint-cache hash table entries: 32768 (order: 6, 
262144 bytes, linear)
[    0.024020] ASID allocator initialised with 32768 entries
[    0.032017] rcu: Hierarchical SRCU implementation.
[    0.040030] Platform MSI: ITS@0x202100000 domain created
[    0.040037] PCI/MSI: ITS@0x202100000 domain created
[    0.040048] Remapping and enabling EFI services.
[    0.048023] smp: Bringing up secondary CPUs ...
[    0.048025] smp: Brought up 4 nodes, 1 CPU
[    0.048027] SMP: Total of 1 processors activated.
[    0.048029] CPU features: detected: Privileged Access Never
[    0.048031] CPU features: detected: LSE atomic instructions
[    0.048032] CPU features: detected: User Access Override
[    0.048034] CPU features: detected: Common not Private translations
[    0.048036] CPU features: detected: RAS Extension Support
[    0.048037] CPU features: detected: CRC32 instructions
[    0.049249] CPU: All CPU(s) started at EL2
[    0.050965] devtmpfs: initialized
[    0.052140] clocksource: jiffies: mask: 0xffffffff max_cycles: 
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.052145] futex hash table entries: 256 (order: 2, 16384 bytes, linear)
[    0.052429] pinctrl core: initialized pinctrl subsystem
[    0.052767] SMBIOS 3.1.1 present.
[    0.052773] DMI: Huawei D06/D06, BIOS Hisilicon D06 UEFI RC0 - 
V1.12.01 01/29/2019
[    0.053031] NET: Registered protocol family 16
[    0.053123] audit: initializing netlink subsys (disabled)
[    0.053371] audit: type=2000 audit(0.052:1): state=initialized 
audit_enabled=0 res=1
[    0.056039] cpuidle: using governor menu
[    0.056047] Detected 1 PCC Subspaces
[    0.056078] Registering PCC driver as Mailbox controller
[    0.056159] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.056459] DMA: preallocated 256 KiB pool for atomic allocations
[    0.056602] ACPI: bus type PCI registered
[    0.056605] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.056694] Serial: AMBA PL011 UART driver
[    0.060102] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.060105] HugeTLB registered 32.0 MiB page size, pre-allocated 0 pages
[    0.060107] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.060109] HugeTLB registered 64.0 KiB page size, pre-allocated 0 pages
[    0.068069] cryptd: max_cpu_qlen set to 1000
[    0.080175] ACPI: Added _OSI(Module Device)
[    0.080178] ACPI: Added _OSI(Processor Device)
[    0.080180] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.080182] ACPI: Added _OSI(Processor Aggregator Device)
[    0.080184] ACPI: Added _OSI(Linux-Dell-Video)
[    0.080186] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.080188] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.085455] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.087825] ACPI: Interpreter enabled
[    0.087827] ACPI: Using GIC for interrupt routing
[    0.087841] ACPI: MCFG table detected, 1 entries
[    0.087846] ACPI: IORT: SMMU-v3[148000000] Mapped to Proximity domain 0
[    0.087895] ACPI: IORT: SMMU-v3[100000000] Mapped to Proximity domain 0
[    0.087931] ACPI: IORT: SMMU-v3[140000000] Mapped to Proximity domain 0
[    0.087965] ACPI: IORT: SMMU-v3[400148000000] Mapped to Proximity 
domain 2
[    0.087997] ACPI: IORT: SMMU-v3[400100000000] Mapped to Proximity 
domain 2
[    0.088029] ACPI: IORT: SMMU-v3[400140000000] Mapped to Proximity 
domain 2
[    0.088174] HEST: Table parsing has been initialized.
[    0.099534] ARMH0011:00: ttyAMA0 at MMIO 0x94080000 (irq = 5, 
base_baud = 0) is a SBSA
[    1.426773] printk: console [ttyAMA0] enabled
[    1.437116] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3f])
[    1.443293] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    1.451260] acpi PNP0A08:00: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    1.461344] acpi PNP0A08:00: ECAM area [mem 0xd0000000-0xd3ffffff] 
reserved by PNP0C02:00
[    1.469517] acpi PNP0A08:00: ECAM at [mem 0xd0000000-0xd3ffffff] for 
[bus 00-3f]
[    1.476923] Remapped I/O 0x00000000efff0000 to [io  0x0000-0xffff window]
[    1.483746] PCI host bridge to bus 0000:00
[    1.487832] pci_bus 0000:00: root bus resource [mem 
0x80000000000-0x83fffffffff pref window]
[    1.496257] pci_bus 0000:00: root bus resource [mem 
0xe0000000-0xeffeffff window]
[    1.503726] pci_bus 0000:00: root bus resource [io  0x0000-0xffff window]
[    1.510501] pci_bus 0000:00: root bus resource [bus 00-3f]
[    1.515986] pci 0000:00:00.0: [19e5:a120] type 01 class 0x060400
[    1.522052] pci 0000:00:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.528734] pci 0000:00:04.0: [19e5:a120] type 01 class 0x060400
[    1.534797] pci 0000:00:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.541469] pci 0000:00:08.0: [19e5:a120] type 01 class 0x060400
[    1.547533] pci 0000:00:08.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.554207] pci 0000:00:0c.0: [19e5:a120] type 01 class 0x060400
[    1.560273] pci 0000:00:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.566944] pci 0000:00:10.0: [19e5:a120] type 01 class 0x060400
[    1.573008] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.579677] pci 0000:00:12.0: [19e5:a120] type 01 class 0x060400
[    1.585740] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.592444] pci 0000:01:00.0: [8086:10fb] type 00 class 0x020000
[    1.598456] pci 0000:01:00.0: reg 0x10: [mem 
0x80000080000-0x800000fffff 64bit pref]
[    1.606190] pci 0000:01:00.0: reg 0x18: [io  0x0020-0x003f]
[    1.611760] pci 0000:01:00.0: reg 0x20: [mem 
0x80000104000-0x80000107fff 64bit pref]
[    1.619493] pci 0000:01:00.0: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    1.626261] pci 0000:01:00.0: PME# supported from D0 D3hot
[    1.631759] pci 0000:01:00.0: reg 0x184: [mem 0x00000000-0x00003fff 
64bit pref]
[    1.639056] pci 0000:01:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[    1.649313] pci 0000:01:00.0: reg 0x190: [mem 0x00000000-0x00003fff 
64bit pref]
[    1.656610] pci 0000:01:00.0: VF(n) BAR3 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[    1.667073] pci 0000:01:00.1: [8086:10fb] type 00 class 0x020000
[    1.673084] pci 0000:01:00.1: reg 0x10: [mem 
0x80000000000-0x8000007ffff 64bit pref]
[    1.680817] pci 0000:01:00.1: reg 0x18: [io  0x0000-0x001f]
[    1.686388] pci 0000:01:00.1: reg 0x20: [mem 
0x80000100000-0x80000103fff 64bit pref]
[    1.694121] pci 0000:01:00.1: reg 0x30: [mem 0xfff80000-0xffffffff pref]
[    1.700888] pci 0000:01:00.1: PME# supported from D0 D3hot
[    1.706382] pci 0000:01:00.1: reg 0x184: [mem 0x00000000-0x00003fff 
64bit pref]
[    1.713678] pci 0000:01:00.1: VF(n) BAR0 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[    1.723935] pci 0000:01:00.1: reg 0x190: [mem 0x00000000-0x00003fff 
64bit pref]
[    1.731232] pci 0000:01:00.1: VF(n) BAR3 space: [mem 
0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[    1.741812] pci 0000:05:00.0: [19e5:1711] type 00 class 0x030000
[    1.747835] pci 0000:05:00.0: reg 0x10: [mem 0xe0000000-0xe1ffffff pref]
[    1.754534] pci 0000:05:00.0: reg 0x14: [mem 0xe2000000-0xe21fffff]
[    1.760957] pci 0000:05:00.0: supports D1
[    1.764955] pci 0000:05:00.0: PME# supported from D0 D1 D3hot
[    1.770827] pci_bus 0000:00: on NUMA node 0
[    1.775004] pci 0000:00:00.0: bridge window [mem 
0x00100000-0x002fffff 64bit pref] to [bus 01] add_size 400000 add_align 
100000
[    1.786472] pci 0000:00:10.0: BAR 14: assigned [mem 
0xe0000000-0xe2ffffff]
[    1.793335] pci 0000:00:00.0: BAR 14: assigned [mem 
0xe3000000-0xe30fffff]
[    1.800197] pci 0000:00:00.0: BAR 15: assigned [mem 
0x80000000000-0x800005fffff 64bit pref]
[    1.808535] pci 0000:00:00.0: BAR 13: assigned [io  0x1000-0x1fff]
[    1.814706] pci 0000:01:00.0: BAR 0: assigned [mem 
0x80000000000-0x8000007ffff 64bit pref]
[    1.822963] pci 0000:01:00.0: BAR 6: assigned [mem 
0xe3000000-0xe307ffff pref]
[    1.830172] pci 0000:01:00.1: BAR 0: assigned [mem 
0x80000080000-0x800000fffff 64bit pref]
[    1.838428] pci 0000:01:00.1: BAR 6: assigned [mem 
0xe3080000-0xe30fffff pref]
[    1.845637] pci 0000:01:00.0: BAR 4: assigned [mem 
0x80000100000-0x80000103fff 64bit pref]
[    1.853893] pci 0000:01:00.0: BAR 7: assigned [mem 
0x80000104000-0x80000203fff 64bit pref]
[    1.862146] pci 0000:01:00.0: BAR 10: assigned [mem 
0x80000204000-0x80000303fff 64bit pref]
[    1.870485] pci 0000:01:00.1: BAR 4: assigned [mem 
0x80000304000-0x80000307fff 64bit pref]
[    1.878741] pci 0000:01:00.1: BAR 7: assigned [mem 
0x80000308000-0x80000407fff 64bit pref]
[    1.886994] pci 0000:01:00.1: BAR 10: assigned [mem 
0x80000408000-0x80000507fff 64bit pref]
[    1.895334] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[    1.901417] pci 0000:01:00.1: BAR 2: assigned [io  0x1020-0x103f]
[    1.907501] pci 0000:00:00.0: PCI bridge to [bus 01]
[    1.912454] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    1.918535] pci 0000:00:00.0:   bridge window [mem 0xe3000000-0xe30fffff]
[    1.925311] pci 0000:00:00.0:   bridge window [mem 
0x80000000000-0x800005fffff 64bit pref]
[    1.933563] pci 0000:00:04.0: PCI bridge to [bus 02]
[    1.938518] pci 0000:00:08.0: PCI bridge to [bus 03]
[    1.943474] pci 0000:00:0c.0: PCI bridge to [bus 04]
[    1.948430] pci 0000:05:00.0: BAR 0: assigned [mem 
0xe0000000-0xe1ffffff pref]
[    1.955643] pci 0000:05:00.0: BAR 1: assigned [mem 0xe2000000-0xe21fffff]
[    1.962421] pci 0000:00:10.0: PCI bridge to [bus 05]
[    1.967375] pci 0000:00:10.0:   bridge window [mem 0xe0000000-0xe2ffffff]
[    1.974152] pci 0000:00:12.0: PCI bridge to [bus 06]
[    1.979108] pci_bus 0000:00: resource 4 [mem 
0x80000000000-0x83fffffffff pref window]
[    1.986924] pci_bus 0000:00: resource 5 [mem 0xe0000000-0xeffeffff 
window]
[    1.993786] pci_bus 0000:00: resource 6 [io  0x0000-0xffff window]
[    1.999954] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    2.005514] pci_bus 0000:01: resource 1 [mem 0xe3000000-0xe30fffff]
[    2.011769] pci_bus 0000:01: resource 2 [mem 
0x80000000000-0x800005fffff 64bit pref]
[    2.019499] pci_bus 0000:05: resource 1 [mem 0xe0000000-0xe2ffffff]
[    2.025791] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 7b])
[    2.031701] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.039662] acpi PNP0A08:01: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.049742] acpi PNP0A08:01: ECAM area [mem 0xd7b00000-0xd7bfffff] 
reserved by PNP0C02:00
[    2.057920] acpi PNP0A08:01: ECAM at [mem 0xd7b00000-0xd7bfffff] for 
[bus 7b]
[    2.065098] PCI host bridge to bus 0000:7b
[    2.069184] pci_bus 0000:7b: root bus resource [mem 
0x148800000-0x148ffffff pref window]
[    2.077262] pci_bus 0000:7b: root bus resource [bus 7b]
[    2.082489] pci_bus 0000:7b: on NUMA node 0
[    2.086661] pci_bus 0000:7b: resource 4 [mem 0x148800000-0x148ffffff 
pref window]
[    2.094155] ACPI: PCI Root Bridge [PCI2] (domain 0000 [bus 7a])
[    2.100065] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.108022] acpi PNP0A08:02: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.118095] acpi PNP0A08:02: ECAM area [mem 0xd7a00000-0xd7afffff] 
reserved by PNP0C02:00
[    2.126271] acpi PNP0A08:02: ECAM at [mem 0xd7a00000-0xd7afffff] for 
[bus 7a]
[    2.133455] PCI host bridge to bus 0000:7a
[    2.137541] pci_bus 0000:7a: root bus resource [mem 
0x20c000000-0x20c1fffff pref window]
[    2.145618] pci_bus 0000:7a: root bus resource [bus 7a]
[    2.150838] pci 0000:7a:00.0: [19e5:a239] type 00 class 0x0c0310
[    2.156837] pci 0000:7a:00.0: reg 0x10: [mem 0x20c100000-0x20c100fff 
64bit pref]
[    2.164281] pci 0000:7a:01.0: [19e5:a239] type 00 class 0x0c0320
[    2.170281] pci 0000:7a:01.0: reg 0x10: [mem 0x20c101000-0x20c101fff 
64bit pref]
[    2.177728] pci 0000:7a:02.0: [19e5:a238] type 00 class 0x0c0330
[    2.183727] pci 0000:7a:02.0: reg 0x10: [mem 0x20c000000-0x20c0fffff 
64bit pref]
[    2.191173] pci_bus 0000:7a: on NUMA node 0
[    2.195347] pci 0000:7a:02.0: BAR 0: assigned [mem 
0x20c000000-0x20c0fffff 64bit pref]
[    2.203253] pci 0000:7a:00.0: BAR 0: assigned [mem 
0x20c100000-0x20c100fff 64bit pref]
[    2.211158] pci 0000:7a:01.0: BAR 0: assigned [mem 
0x20c101000-0x20c101fff 64bit pref]
[    2.219064] pci_bus 0000:7a: resource 4 [mem 0x20c000000-0x20c1fffff 
pref window]
[    2.226563] ACPI: PCI Root Bridge [PCI3] (domain 0000 [bus 78-79])
[    2.232734] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.240691] acpi PNP0A08:03: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.250765] acpi PNP0A08:03: ECAM area [mem 0xd7800000-0xd79fffff] 
reserved by PNP0C02:00
[    2.258935] acpi PNP0A08:03: ECAM at [mem 0xd7800000-0xd79fffff] for 
[bus 78-79]
[    2.266374] PCI host bridge to bus 0000:78
[    2.270460] pci_bus 0000:78: root bus resource [mem 
0x208000000-0x208ffffff pref window]
[    2.278538] pci_bus 0000:78: root bus resource [bus 78-79]
[    2.284017] pci 0000:78:00.0: [19e5:a258] type 00 class 0x100000
[    2.290017] pci 0000:78:00.0: reg 0x18: [mem 0x00000000-0x001fffff 
64bit pref]
[    2.297290] pci_bus 0000:78: on NUMA node 0
[    2.301464] pci 0000:78:00.0: BAR 2: assigned [mem 
0x208000000-0x2081fffff 64bit pref]
[    2.309370] pci_bus 0000:78: resource 4 [mem 0x208000000-0x208ffffff 
pref window]
[    2.316866] ACPI: PCI Root Bridge [PCI4] (domain 0000 [bus 7c-7d])
[    2.323035] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.330992] acpi PNP0A08:04: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.341063] acpi PNP0A08:04: ECAM area [mem 0xd7c00000-0xd7dfffff] 
reserved by PNP0C02:00
[    2.349234] acpi PNP0A08:04: ECAM at [mem 0xd7c00000-0xd7dfffff] for 
[bus 7c-7d]
[    2.356671] PCI host bridge to bus 0000:7c
[    2.360758] pci_bus 0000:7c: root bus resource [mem 
0x120000000-0x13fffffff pref window]
[    2.368835] pci_bus 0000:7c: root bus resource [bus 7c-7d]
[    2.374314] pci 0000:7c:00.0: [19e5:a121] type 01 class 0x060400
[    2.380316] pci 0000:7c:00.0: enabling Extended Tags
[    2.385360] pci 0000:7d:00.0: [19e5:a222] type 00 class 0x020000
[    2.391360] pci 0000:7d:00.0: reg 0x10: [mem 0x120430000-0x12043ffff 
64bit pref]
[    2.398745] pci 0000:7d:00.0: reg 0x18: [mem 0x120300000-0x1203fffff 
64bit pref]
[    2.406151] pci 0000:7d:00.0: reg 0x224: [mem 0x00000000-0x0000ffff 
64bit pref]
[    2.413448] pci 0000:7d:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x000dffff 64bit pref] (contains BAR0 for 14 VFs)
[    2.423698] pci 0000:7d:00.0: reg 0x22c: [mem 0x00000000-0x000fffff 
64bit pref]
[    2.430994] pci 0000:7d:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x00dfffff 64bit pref] (contains BAR2 for 14 VFs)
[    2.441299] pci 0000:7d:00.1: [19e5:a222] type 00 class 0x020000
[    2.447299] pci 0000:7d:00.1: reg 0x10: [mem 0x120420000-0x12042ffff 
64bit pref]
[    2.454684] pci 0000:7d:00.1: reg 0x18: [mem 0x120200000-0x1202fffff 
64bit pref]
[    2.462089] pci 0000:7d:00.1: reg 0x224: [mem 0x00000000-0x0000ffff 
64bit pref]
[    2.469385] pci 0000:7d:00.1: VF(n) BAR0 space: [mem 
0x00000000-0x000dffff 64bit pref] (contains BAR0 for 14 VFs)
[    2.479635] pci 0000:7d:00.1: reg 0x22c: [mem 0x00000000-0x000fffff 
64bit pref]
[    2.486931] pci 0000:7d:00.1: VF(n) BAR2 space: [mem 
0x00000000-0x00dfffff 64bit pref] (contains BAR2 for 14 VFs)
[    2.497237] pci 0000:7d:00.2: [19e5:a222] type 00 class 0x020000
[    2.503236] pci 0000:7d:00.2: reg 0x10: [mem 0x120410000-0x12041ffff 
64bit pref]
[    2.510621] pci 0000:7d:00.2: reg 0x18: [mem 0x120100000-0x1201fffff 
64bit pref]
[    2.518065] pci 0000:7d:00.3: [19e5:a221] type 00 class 0x020000
[    2.524064] pci 0000:7d:00.3: reg 0x10: [mem 0x120400000-0x12040ffff 
64bit pref]
[    2.531450] pci 0000:7d:00.3: reg 0x18: [mem 0x120000000-0x1200fffff 
64bit pref]
[    2.538894] pci_bus 0000:7c: on NUMA node 0
[    2.543069] pci 0000:7c:00.0: bridge window [mem 
0x00100000-0x005fffff 64bit pref] to [bus 7d] add_size 1d00000 add_align 
100000
[    2.554620] pci 0000:7c:00.0: BAR 15: assigned [mem 
0x120000000-0x1221fffff 64bit pref]
[    2.562614] pci 0000:7d:00.0: BAR 2: assigned [mem 
0x120000000-0x1200fffff 64bit pref]
[    2.570520] pci 0000:7d:00.0: BAR 9: assigned [mem 
0x120100000-0x120efffff 64bit pref]
[    2.578425] pci 0000:7d:00.1: BAR 2: assigned [mem 
0x120f00000-0x120ffffff 64bit pref]
[    2.586330] pci 0000:7d:00.1: BAR 9: assigned [mem 
0x121000000-0x121dfffff 64bit pref]
[    2.594234] pci 0000:7d:00.2: BAR 2: assigned [mem 
0x121e00000-0x121efffff 64bit pref]
[    2.602140] pci 0000:7d:00.3: BAR 2: assigned [mem 
0x121f00000-0x121ffffff 64bit pref]
[    2.610045] pci 0000:7d:00.0: BAR 0: assigned [mem 
0x122000000-0x12200ffff 64bit pref]
[    2.617951] pci 0000:7d:00.0: BAR 7: assigned [mem 
0x122010000-0x1220effff 64bit pref]
[    2.625855] pci 0000:7d:00.1: BAR 0: assigned [mem 
0x1220f0000-0x1220fffff 64bit pref]
[    2.633761] pci 0000:7d:00.1: BAR 7: assigned [mem 
0x122100000-0x1221dffff 64bit pref]
[    2.641665] pci 0000:7d:00.2: BAR 0: assigned [mem 
0x1221e0000-0x1221effff 64bit pref]
[    2.649570] pci 0000:7d:00.3: BAR 0: assigned [mem 
0x1221f0000-0x1221fffff 64bit pref]
[    2.657477] pci 0000:7c:00.0: PCI bridge to [bus 7d]
[    2.662430] pci 0000:7c:00.0:   bridge window [mem 
0x120000000-0x1221fffff 64bit pref]
[    2.670335] pci_bus 0000:7c: resource 4 [mem 0x120000000-0x13fffffff 
pref window]
[    2.677805] pci_bus 0000:7d: resource 2 [mem 0x120000000-0x1221fffff 
64bit pref]
[    2.685220] ACPI: PCI Root Bridge [PCI5] (domain 0000 [bus 74-76])
[    2.691390] acpi PNP0A08:05: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.699347] acpi PNP0A08:05: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.709421] acpi PNP0A08:05: ECAM area [mem 0xd7400000-0xd76fffff] 
reserved by PNP0C02:00
[    2.717597] acpi PNP0A08:05: ECAM at [mem 0xd7400000-0xd76fffff] for 
[bus 74-76]
[    2.725043] PCI host bridge to bus 0000:74
[    2.729130] pci_bus 0000:74: root bus resource [mem 
0x144000000-0x147ffffff pref window]
[    2.737207] pci_bus 0000:74: root bus resource [mem 
0xa2000000-0xa2ffffff window]
[    2.744677] pci_bus 0000:74: root bus resource [bus 74-76]
[    2.750155] pci 0000:74:00.0: [19e5:a121] type 01 class 0x060400
[    2.756158] pci 0000:74:00.0: enabling Extended Tags
[    2.761172] pci 0000:74:02.0: [19e5:a230] type 00 class 0x010700
[    2.767178] pci 0000:74:02.0: reg 0x24: [mem 0xa2000000-0xa2007fff]
[    2.773496] pci 0000:74:03.0: [19e5:a235] type 00 class 0x010601
[    2.779501] pci 0000:74:03.0: reg 0x24: [mem 0xa2008000-0xa2008fff]
[    2.785841] pci 0000:75:00.0: [19e5:a250] type 00 class 0x120000
[    2.791843] pci 0000:75:00.0: reg 0x18: [mem 0x144000000-0x1443fffff 
64bit pref]
[    2.799251] pci 0000:75:00.0: reg 0x22c: [mem 0x00000000-0x0000ffff 
64bit pref]
[    2.806548] pci 0000:75:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x003effff 64bit pref] (contains BAR2 for 63 VFs)
[    2.816886] pci_bus 0000:74: on NUMA node 0
[    2.821060] pci 0000:74:00.0: bridge window [mem 
0x00400000-0x007fffff 64bit pref] to [bus 75] add_size 400000 add_align 
400000
[    2.832524] pci 0000:74:00.0: BAR 15: assigned [mem 
0x144000000-0x1447fffff 64bit pref]
[    2.840515] pci 0000:74:02.0: BAR 5: assigned [mem 0xa2000000-0xa2007fff]
[    2.847291] pci 0000:74:03.0: BAR 5: assigned [mem 0xa2008000-0xa2008fff]
[    2.854068] pci 0000:75:00.0: BAR 2: assigned [mem 
0x144000000-0x1443fffff 64bit pref]
[    2.861973] pci 0000:75:00.0: BAR 9: assigned [mem 
0x144400000-0x1447effff 64bit pref]
[    2.869877] pci 0000:74:00.0: PCI bridge to [bus 75]
[    2.874831] pci 0000:74:00.0:   bridge window [mem 
0x144000000-0x1447fffff 64bit pref]
[    2.882736] pci_bus 0000:74: resource 4 [mem 0x144000000-0x147ffffff 
pref window]
[    2.890205] pci_bus 0000:74: resource 5 [mem 0xa2000000-0xa2ffffff 
window]
[    2.897067] pci_bus 0000:75: resource 2 [mem 0x144000000-0x1447fffff 
64bit pref]
[    2.904484] ACPI: PCI Root Bridge [PCI6] (domain 0000 [bus 80-9f])
[    2.910654] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    2.918611] acpi PNP0A08:06: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    2.928686] acpi PNP0A08:06: ECAM area [mem 0xd8000000-0xd9ffffff] 
reserved by PNP0C02:00
[    2.936855] acpi PNP0A08:06: ECAM at [mem 0xd8000000-0xd9ffffff] for 
[bus 80-9f]
[    2.944256] Remapped I/O 0x00000000ffff0000 to [io  0x10000-0x1ffff 
window]
[    2.951245] PCI host bridge to bus 0000:80
[    2.955331] pci_bus 0000:80: root bus resource [mem 
0x480000000000-0x483fffffffff pref window]
[    2.963929] pci_bus 0000:80: root bus resource [mem 
0xf0000000-0xfffeffff window]
[    2.971399] pci_bus 0000:80: root bus resource [io  0x10000-0x1ffff 
window] (bus address [0x0000-0xffff])
[    2.980952] pci_bus 0000:80: root bus resource [bus 80-9f]
[    2.986433] pci 0000:80:00.0: [19e5:a120] type 01 class 0x060400
[    2.992503] pci 0000:80:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    2.999182] pci 0000:80:08.0: [19e5:a120] type 01 class 0x060400
[    3.005256] pci 0000:80:08.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.011933] pci 0000:80:0c.0: [19e5:a120] type 01 class 0x060400
[    3.018006] pci 0000:80:0c.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.024683] pci 0000:80:10.0: [19e5:a120] type 01 class 0x060400
[    3.030756] pci 0000:80:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.037467] pci 0000:81:00.0: [19e5:0123] type 00 class 0x010802
[    3.043477] pci 0000:81:00.0: reg 0x10: [mem 0xf0000000-0xf003ffff 64bit]
[    3.050273] pci 0000:81:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    3.057031] pci 0000:81:00.0: supports D1 D2
[    3.061290] pci 0000:81:00.0: PME# supported from D3hot
[    3.066681] pci_bus 0000:80: on NUMA node 2
[    3.070857] pci 0000:80:00.0: BAR 14: assigned [mem 
0xf0000000-0xf00fffff]
[    3.077721] pci 0000:81:00.0: BAR 0: assigned [mem 
0xf0000000-0xf003ffff 64bit]
[    3.085022] pci 0000:81:00.0: BAR 6: assigned [mem 
0xf0040000-0xf005ffff pref]
[    3.092231] pci 0000:80:00.0: PCI bridge to [bus 81]
[    3.097207] pci 0000:80:00.0:   bridge window [mem 0xf0000000-0xf00fffff]
[    3.103984] pci 0000:80:08.0: PCI bridge to [bus 82]
[    3.108941] pci 0000:80:0c.0: PCI bridge to [bus 83]
[    3.113896] pci 0000:80:10.0: PCI bridge to [bus 84]
[    3.118852] pci_bus 0000:80: resource 4 [mem 
0x480000000000-0x483fffffffff pref window]
[    3.126843] pci_bus 0000:80: resource 5 [mem 0xf0000000-0xfffeffff 
window]
[    3.133705] pci_bus 0000:80: resource 6 [io  0x10000-0x1ffff window]
[    3.140046] pci_bus 0000:81: resource 1 [mem 0xf0000000-0xf00fffff]
[    3.146334] ACPI: PCI Root Bridge [PCI7] (domain 0000 [bus bb])
[    3.152244] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    3.160203] acpi PNP0A08:07: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    3.170279] acpi PNP0A08:07: ECAM area [mem 0xdbb00000-0xdbbfffff] 
reserved by PNP0C02:00
[    3.178456] acpi PNP0A08:07: ECAM at [mem 0xdbb00000-0xdbbfffff] for 
[bus bb]
[    3.185637] PCI host bridge to bus 0000:bb
[    3.189724] pci_bus 0000:bb: root bus resource [mem 
0x400148800000-0x400148ffffff pref window]
[    3.198322] pci_bus 0000:bb: root bus resource [bus bb]
[    3.203551] pci_bus 0000:bb: on NUMA node 2
[    3.207723] pci_bus 0000:bb: resource 4 [mem 
0x400148800000-0x400148ffffff pref window]
[    3.215737] ACPI: PCI Root Bridge [PCI8] (domain 0000 [bus ba])
[    3.221647] acpi PNP0A08:08: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    3.229603] acpi PNP0A08:08: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    3.239675] acpi PNP0A08:08: ECAM area [mem 0xdba00000-0xdbafffff] 
reserved by PNP0C02:00
[    3.247850] acpi PNP0A08:08: ECAM at [mem 0xdba00000-0xdbafffff] for 
[bus ba]
[    3.255030] PCI host bridge to bus 0000:ba
[    3.259116] pci_bus 0000:ba: root bus resource [mem 
0x40020c000000-0x40020c1fffff pref window]
[    3.267715] pci_bus 0000:ba: root bus resource [bus ba]
[    3.272934] pci 0000:ba:00.0: [19e5:a239] type 00 class 0x0c0310
[    3.278934] pci 0000:ba:00.0: reg 0x10: [mem 
0x40020c100000-0x40020c100fff 64bit pref]
[    3.286904] pci 0000:ba:01.0: [19e5:a239] type 00 class 0x0c0320
[    3.292905] pci 0000:ba:01.0: reg 0x10: [mem 
0x40020c101000-0x40020c101fff 64bit pref]
[    3.300875] pci 0000:ba:02.0: [19e5:a238] type 00 class 0x0c0330
[    3.306875] pci 0000:ba:02.0: reg 0x10: [mem 
0x40020c000000-0x40020c0fffff 64bit pref]
[    3.314850] pci_bus 0000:ba: on NUMA node 2
[    3.319024] pci 0000:ba:02.0: BAR 0: assigned [mem 
0x40020c000000-0x40020c0fffff 64bit pref]
[    3.327452] pci 0000:ba:00.0: BAR 0: assigned [mem 
0x40020c100000-0x40020c100fff 64bit pref]
[    3.335878] pci 0000:ba:01.0: BAR 0: assigned [mem 
0x40020c101000-0x40020c101fff 64bit pref]
[    3.344305] pci_bus 0000:ba: resource 4 [mem 
0x40020c000000-0x40020c1fffff pref window]
[    3.352324] ACPI: PCI Root Bridge [PCI9] (domain 0000 [bus b8-b9])
[    3.358494] acpi PNP0A08:09: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    3.366449] acpi PNP0A08:09: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    3.376524] acpi PNP0A08:09: ECAM area [mem 0xdb800000-0xdb9fffff] 
reserved by PNP0C02:00
[    3.384692] acpi PNP0A08:09: ECAM at [mem 0xdb800000-0xdb9fffff] for 
[bus b8-b9]
[    3.392132] PCI host bridge to bus 0000:b8
[    3.396219] pci_bus 0000:b8: root bus resource [mem 
0x400208000000-0x400208ffffff pref window]
[    3.404817] pci_bus 0000:b8: root bus resource [bus b8-b9]
[    3.410297] pci 0000:b8:00.0: [19e5:a258] type 00 class 0x100000
[    3.416299] pci 0000:b8:00.0: reg 0x18: [mem 0x00000000-0x001fffff 
64bit pref]
[    3.423578] pci_bus 0000:b8: on NUMA node 2
[    3.427751] pci 0000:b8:00.0: BAR 2: assigned [mem 
0x400208000000-0x4002081fffff 64bit pref]
[    3.436178] pci_bus 0000:b8: resource 4 [mem 
0x400208000000-0x400208ffffff pref window]
[    3.444194] ACPI: PCI Root Bridge [PCIA] (domain 0000 [bus bc-bd])
[    3.450365] acpi PNP0A08:0a: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    3.458321] acpi PNP0A08:0a: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    3.468392] acpi PNP0A08:0a: ECAM area [mem 0xdbc00000-0xdbdfffff] 
reserved by PNP0C02:00
[    3.476561] acpi PNP0A08:0a: ECAM at [mem 0xdbc00000-0xdbdfffff] for 
[bus bc-bd]
[    3.483999] PCI host bridge to bus 0000:bc
[    3.488086] pci_bus 0000:bc: root bus resource [mem 
0x400120000000-0x40013fffffff pref window]
[    3.496684] pci_bus 0000:bc: root bus resource [bus bc-bd]
[    3.502165] pci 0000:bc:00.0: [19e5:a121] type 01 class 0x060400
[    3.508171] pci 0000:bc:00.0: enabling Extended Tags
[    3.513219] pci 0000:bd:00.0: [19e5:a226] type 00 class 0x020000
[    3.519221] pci 0000:bd:00.0: reg 0x10: [mem 
0x400120100000-0x40012010ffff 64bit pref]
[    3.527127] pci 0000:bd:00.0: reg 0x18: [mem 
0x400120000000-0x4001200fffff 64bit pref]
[    3.535062] pci 0000:bd:00.0: reg 0x224: [mem 0x00000000-0x0000ffff 
64bit pref]
[    3.542359] pci 0000:bd:00.0: VF(n) BAR0 space: [mem 
0x00000000-0x001effff 64bit pref] (contains BAR0 for 31 VFs)
[    3.552609] pci 0000:bd:00.0: reg 0x22c: [mem 0x00000000-0x000fffff 
64bit pref]
[    3.559906] pci 0000:bd:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x01efffff 64bit pref] (contains BAR2 for 31 VFs)
[    3.570233] pci_bus 0000:bc: on NUMA node 2
[    3.574407] pci 0000:bc:00.0: bridge window [mem 
0x00100000-0x002fffff 64bit pref] to [bus bd] add_size 2000000 add_align 
100000
[    3.585958] pci 0000:bc:00.0: BAR 15: assigned [mem 
0x400120000000-0x4001221fffff 64bit pref]
[    3.594470] pci 0000:bd:00.0: BAR 2: assigned [mem 
0x400120000000-0x4001200fffff 64bit pref]
[    3.602897] pci 0000:bd:00.0: BAR 9: assigned [mem 
0x400120100000-0x400121ffffff 64bit pref]
[    3.611323] pci 0000:bd:00.0: BAR 0: assigned [mem 
0x400122000000-0x40012200ffff 64bit pref]
[    3.619749] pci 0000:bd:00.0: BAR 7: assigned [mem 
0x400122010000-0x4001221fffff 64bit pref]
[    3.628175] pci 0000:bc:00.0: PCI bridge to [bus bd]
[    3.633129] pci 0000:bc:00.0:   bridge window [mem 
0x400120000000-0x4001221fffff 64bit pref]
[    3.641555] pci_bus 0000:bc: resource 4 [mem 
0x400120000000-0x40013fffffff pref window]
[    3.649545] pci_bus 0000:bd: resource 2 [mem 
0x400120000000-0x4001221fffff 64bit pref]
[    3.657478] ACPI: PCI Root Bridge [PCIB] (domain 0000 [bus b4-b6])
[    3.663649] acpi PNP0A08:0b: _OSC: OS supports [ExtendedConfig 
Segments MSI HPX-Type3]
[    3.671606] acpi PNP0A08:0b: _OSC: not requesting OS control; OS 
requires [ExtendedConfig ASPM ClockPM MSI]
[    3.681678] acpi PNP0A08:0b: ECAM area [mem 0xdb400000-0xdb6fffff] 
reserved by PNP0C02:00
[    3.689854] acpi PNP0A08:0b: ECAM at [mem 0xdb400000-0xdb6fffff] for 
[bus b4-b6]
[    3.697295] PCI host bridge to bus 0000:b4
[    3.701381] pci_bus 0000:b4: root bus resource [mem 
0x400144000000-0x400147ffffff pref window]
[    3.709979] pci_bus 0000:b4: root bus resource [mem 
0xa3000000-0xa3ffffff window]
[    3.717449] pci_bus 0000:b4: root bus resource [bus b4-b6]
[    3.722928] pci 0000:b4:00.0: [19e5:a121] type 01 class 0x060400
[    3.728934] pci 0000:b4:00.0: enabling Extended Tags
[    3.733981] pci 0000:b5:00.0: [19e5:a250] type 00 class 0x120000
[    3.739985] pci 0000:b5:00.0: reg 0x18: [mem 
0x400144000000-0x4001443fffff 64bit pref]
[    3.747921] pci 0000:b5:00.0: reg 0x22c: [mem 0x00000000-0x0000ffff 
64bit pref]
[    3.755218] pci 0000:b5:00.0: VF(n) BAR2 space: [mem 
0x00000000-0x003effff 64bit pref] (contains BAR2 for 63 VFs)
[    3.765572] pci_bus 0000:b4: on NUMA node 2
[    3.769745] pci 0000:b4:00.0: bridge window [mem 
0x00400000-0x007fffff 64bit pref] to [bus b5] add_size 400000 add_align 
400000
[    3.781209] pci 0000:b4:00.0: BAR 15: assigned [mem 
0x400144000000-0x4001447fffff 64bit pref]
[    3.789722] pci 0000:b5:00.0: BAR 2: assigned [mem 
0x400144000000-0x4001443fffff 64bit pref]
[    3.798149] pci 0000:b5:00.0: BAR 9: assigned [mem 
0x400144400000-0x4001447effff 64bit pref]
[    3.806574] pci 0000:b4:00.0: PCI bridge to [bus b5]
[    3.811528] pci 0000:b4:00.0:   bridge window [mem 
0x400144000000-0x4001447fffff 64bit pref]
[    3.819954] pci_bus 0000:b4: resource 4 [mem 
0x400144000000-0x400147ffffff pref window]
[    3.827944] pci_bus 0000:b4: resource 5 [mem 0xa3000000-0xa3ffffff 
window]
[    3.834806] pci_bus 0000:b5: resource 2 [mem 
0x400144000000-0x4001447fffff 64bit pref]
[    3.850812] pci 0000:05:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[    3.859169] pci 0000:05:00.0: vgaarb: bridge control possible
[    3.864904] pci 0000:05:00.0: vgaarb: setting as boot device (VGA 
legacy resources not available)
[    3.873763] vgaarb: loaded
[    3.876544] SCSI subsystem initialized
[    3.884302] libata version 3.00 loaded.
[    3.888172] ACPI: bus type USB registered
[    3.892205] usbcore: registered new interface driver usbfs
[    3.897689] usbcore: registered new interface driver hub
[    3.903001] usbcore: registered new device driver usb
[    3.908351] pps_core: LinuxPPS API ver. 1 registered
[    3.913306] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 
Rodolfo Giometti <giometti@linux.it>
[    3.922430] PTP clock support registered
[    3.926390] EDAC MC: Ver: 3.0.0
[    3.933605] Registered efivars operations
[    3.941669] FPGA manager framework
[    3.945080] Advanced Linux Sound Architecture Driver Initialized.
[    3.951389] clocksource: Switched to clocksource arch_sys_counter
[    3.957536] VFS: Disk quotas dquot_6.6.0
[    3.961464] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 
bytes)
[    3.968382] pnp: PnP ACPI init
[    3.971740] system 00:00: [mem 0xd0000000-0xdfffffff] could not be 
reserved
[    3.978696] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.985568] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    3.992173] pnp: PnP ACPI: found 2 devices
[    3.997860] thermal_sys: Registered thermal governor 'step_wise'
[    3.997862] thermal_sys: Registered thermal governor 'power_allocator'
[    4.003904] NET: Registered protocol family 2
[    4.014881] tcp_listen_portaddr_hash hash table entries: 8192 (order: 
5, 131072 bytes, linear)
[    4.023527] TCP established hash table entries: 131072 (order: 8, 
1048576 bytes, linear)
[    4.031801] TCP bind hash table entries: 65536 (order: 8, 1048576 
bytes, linear)
[    4.039411] TCP: Hash tables configured (established 131072 bind 65536)
[    4.046038] UDP hash table entries: 8192 (order: 6, 262144 bytes, linear)
[    4.052847] UDP-Lite hash table entries: 8192 (order: 6, 262144 
bytes, linear)
[    4.060120] NET: Registered protocol family 1
[    4.076590] RPC: Registered named UNIX socket transport module.
[    4.082506] RPC: Registered udp transport module.
[    4.087198] RPC: Registered tcp transport module.
[    4.091890] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    4.098344] pci 0000:7a:00.0: enabling device (0000 -> 0002)
[    4.104013] pci 0000:7a:02.0: enabling device (0000 -> 0002)
[    4.109703] pci 0000:ba:00.0: enabling device (0000 -> 0002)
[    4.115366] pci 0000:ba:02.0: enabling device (0000 -> 0002)
[    4.121037] PCI: CLS 32 bytes, default 64
[    4.125075] Unpacking initramfs...
[    7.608285] Freeing initrd memory: 293960K
[    7.612470] hw perfevents: enabled with armv8_pmuv3_0 PMU driver, 13 
counters available
[    7.620469] kvm [1]: IPA Size Limit: 48bits
[    7.624644] kvm [1]: GICv4 support disabled
[    7.628815] kvm [1]: GICv3: no GICV resource entry
[    7.633594] kvm [1]: disabling GICv2 emulation
[    7.638040] kvm [1]: GIC system register CPU interface enabled
[    7.643871] kvm [1]: vgic interrupt IRQ1
[    7.647811] kvm [1]: VHE mode initialized successfully
[    7.675953] Initialise system trusted keyrings
[    7.680506] workingset: timestamp_bits=44 max_order=22 bucket_order=0
[    7.689344] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    7.699406] NFS: Registering the id_resolver key type
[    7.704456] Key type id_resolver registered
[    7.708627] Key type id_legacy registered
[    7.712627] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    7.719355] 9p: Installing v9fs 9p2000 file system support
[    7.731052] Key type asymmetric registered
[    7.735151] Asymmetric key parser 'x509' registered
[    7.740038] Block layer SCSI generic (bsg) driver version 0.4 loaded 
(major 245)
[    7.747442] io scheduler mq-deadline registered
[    7.751965] io scheduler kyber registered
[    7.756254] ITS: alloc 8192:32
[    7.759298] ITT 32 entries, 5 bits
[    7.762712] ITS: alloc 8224:32
[    7.765758] ITT 32 entries, 5 bits
[    7.769166] ITS: alloc 8256:32
[    7.772212] ITT 32 entries, 5 bits
[    7.775621] ITS: alloc 8288:32
[    7.778663] ITT 32 entries, 5 bits
[    7.782071] ITS: alloc 8320:32
[    7.785116] ITT 32 entries, 5 bits
[    7.788530] ITS: alloc 8352:32
[    7.791575] ITT 32 entries, 5 bits
[    7.794982] ITS: alloc 8384:32
[    7.798028] ITT 32 entries, 5 bits
[    7.801438] ITS: alloc 8416:32
[    7.804483] ITT 32 entries, 5 bits
[    7.807894] ITS: alloc 8448:32
[    7.810937] ITT 32 entries, 5 bits
[    7.814346] ITS: alloc 8480:32
[    7.817391] ITT 32 entries, 5 bits
[    7.820802] ITS: alloc 8512:32
[    7.823846] ITT 32 entries, 5 bits
[    7.827254] ITS: alloc 8544:32
[    7.830299] ITT 32 entries, 5 bits
[    7.833710] ITS: alloc 8576:32
[    7.836755] ITT 32 entries, 5 bits
[    7.840166] ITS: alloc 8608:32
[    7.843209] ITT 32 entries, 5 bits
[    7.846620] ITS: alloc 8640:32
[    7.849665] ITT 32 entries, 5 bits
[    7.853077] ITS: alloc 8672:32
[    7.856122] ITT 32 entries, 5 bits
[    7.859534] ITS: alloc 8704:32
[    7.862577] ITT 32 entries, 5 bits
[    7.865989] ITS: alloc 8736:32
[    7.869035] ITT 32 entries, 5 bits
[    7.872447] ITS: alloc 8768:32
[    7.875492] ITT 32 entries, 5 bits
[    7.878903] ITS: alloc 8800:32
[    7.881949] ITT 32 entries, 5 bits
[    7.885361] ITS: alloc 8832:32
[    7.888406] ITT 32 entries, 5 bits
[    7.891822] ITS: alloc 8864:32
[    7.894865] ITT 32 entries, 5 bits
[    7.898279] ITS: alloc 8896:32
[    7.901324] ITT 32 entries, 5 bits
[    7.904739] ITS: alloc 8928:32
[    7.907784] ITT 32 entries, 5 bits
[    7.911198] ITS: alloc 8960:32
[    7.914243] ITT 32 entries, 5 bits
[    7.917658] ITS: alloc 8992:32
[    7.920703] ITT 32 entries, 5 bits
[    7.924120] ITS: alloc 9024:32
[    7.927163] ITT 32 entries, 5 bits
[    7.930578] ITS: alloc 9056:32
[    7.933623] ITT 32 entries, 5 bits
[    7.937038] ITS: alloc 9088:32
[    7.940084] ITT 32 entries, 5 bits
[    7.943502] ITS: alloc 9120:32
[    7.946545] ITT 32 entries, 5 bits
[    7.949962] ITS: alloc 9152:32
[    7.953008] ITT 32 entries, 5 bits
[    7.956424] ITS: alloc 9184:32
[    7.959469] ITT 32 entries, 5 bits
[    7.962885] ITS: alloc 9216:32
[    7.965930] ITT 32 entries, 5 bits
[    7.969347] ITS: alloc 9248:32
[    7.972392] ITT 32 entries, 5 bits
[    7.975810] ITS: alloc 9280:32
[    7.978853] ITT 32 entries, 5 bits
[    7.982272] ITS: alloc 9312:32
[    7.985318] ITT 32 entries, 5 bits
[    7.988737] ITS: alloc 9344:32
[    7.991782] ITT 32 entries, 5 bits
[    7.995199] ITS: alloc 9376:32
[    7.998244] ITT 32 entries, 5 bits
[    8.001662] ITS: alloc 9408:32
[    8.004707] ITT 32 entries, 5 bits
[    8.008128] ITS: alloc 9440:32
[    8.011171] ITT 32 entries, 5 bits
[    8.014592] ITS: alloc 9472:32
[    8.017638] ITT 32 entries, 5 bits
[    8.021057] ITS: alloc 9504:32
[    8.024102] ITT 32 entries, 5 bits
[    8.027523] ITS: alloc 9536:32
[    8.030565] ITT 32 entries, 5 bits
[    8.033985] ITS: alloc 9568:32
[    8.037030] ITT 32 entries, 5 bits
[    8.040454] ITS: alloc 9600:32
[    8.043499] ITT 32 entries, 5 bits
[    8.046920] ITS: alloc 9632:32
[    8.049966] ITT 32 entries, 5 bits
[    8.053387] ITS: alloc 9664:32
[    8.056432] ITT 32 entries, 5 bits
[    8.059855] ITS: alloc 9696:32
[    8.062897] ITT 32 entries, 5 bits
[    8.076633] input: Power Button as 
/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input0
[    8.084995] ACPI: Power Button [PWRB]
[    8.093322] [Firmware Bug]: APEI: Invalid bit width + offset in GAR 
[0x94110034/64/0/3/0]
[    8.101629] EDAC MC0: Giving out device to module ghes_edac.c 
controller ghes_edac: DEV ghes (INTERRUPT)
[    8.111298] GHES: APEI firmware first mode is enabled by APEI bit and 
WHEA _OSC.
[    8.118731] EINJ: Error INJection is initialized.
[    8.123538] ACPI GTDT: found 1 SBSA generic Watchdog(s).
[    8.137530] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    8.164377] 00:01: ttyS0 at MMIO 0x3f00003f8 (irq = 6, base_baud = 
115200) is a 16550A
[    8.173517] SuperH (H)SCI(F) driver initialized
[    8.178402] msm_serial: driver initialized
[    8.182981] arm-smmu-v3 arm-smmu-v3.0.auto: option mask 0x0
[    8.188555] arm-smmu-v3 arm-smmu-v3.0.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.196787] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 65536 entries 
for cmdq
[    8.203971] arm-smmu-v3 arm-smmu-v3.0.auto: allocated 32768 entries 
for evtq
[    8.211023] ITS: alloc 9728:32
[    8.214069] ITT 32 entries, 5 bits
[    8.217474] ID:0 pID:9728 vID:11
[    8.220708] ID:1 pID:9729 vID:12
[    8.224128] arm-smmu-v3 arm-smmu-v3.1.auto: option mask 0x0
[    8.229699] arm-smmu-v3 arm-smmu-v3.1.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.237875] arm-smmu-v3 arm-smmu-v3.1.auto: allocated 65536 entries 
for cmdq
[    8.245181] arm-smmu-v3 arm-smmu-v3.1.auto: allocated 32768 entries 
for evtq
[    8.252229] ITS: alloc 9760:32
[    8.255272] ITT 32 entries, 5 bits
[    8.258673] ID:0 pID:9760 vID:13
[    8.261901] ID:1 pID:9761 vID:14
[    8.265207] arm-smmu-v3 arm-smmu-v3.2.auto: option mask 0x0
[    8.270777] arm-smmu-v3 arm-smmu-v3.2.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.278944] arm-smmu-v3 arm-smmu-v3.2.auto: allocated 65536 entries 
for cmdq
[    8.286134] arm-smmu-v3 arm-smmu-v3.2.auto: allocated 32768 entries 
for evtq
[    8.293181] ITS: alloc 9792:32
[    8.296227] ITT 32 entries, 5 bits
[    8.299626] ID:0 pID:9792 vID:15
[    8.302851] ID:1 pID:9793 vID:16
[    8.306150] arm-smmu-v3 arm-smmu-v3.3.auto: option mask 0x0
[    8.311723] arm-smmu-v3 arm-smmu-v3.3.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.319904] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 65536 entries 
for cmdq
[    8.327209] arm-smmu-v3 arm-smmu-v3.3.auto: allocated 32768 entries 
for evtq
[    8.334260] ITS: alloc 9824:32
[    8.337305] ITT 32 entries, 5 bits
[    8.340708] ID:0 pID:9824 vID:17
[    8.343940] ID:1 pID:9825 vID:18
[    8.347237] arm-smmu-v3 arm-smmu-v3.4.auto: option mask 0x0
[    8.352808] arm-smmu-v3 arm-smmu-v3.4.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.360975] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 65536 entries 
for cmdq
[    8.368165] arm-smmu-v3 arm-smmu-v3.4.auto: allocated 32768 entries 
for evtq
[    8.375214] ITS: alloc 9856:32
[    8.378259] ITT 32 entries, 5 bits
[    8.381662] ID:0 pID:9856 vID:19
[    8.384896] ID:1 pID:9857 vID:20
[    8.388196] arm-smmu-v3 arm-smmu-v3.5.auto: option mask 0x0
[    8.393765] arm-smmu-v3 arm-smmu-v3.5.auto: ias 48-bit, oas 48-bit 
(features 0x00000fef)
[    8.401947] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 65536 entries 
for cmdq
[    8.409253] arm-smmu-v3 arm-smmu-v3.5.auto: allocated 32768 entries 
for evtq
[    8.416302] ITS: alloc 9888:32
[    8.419345] ITT 32 entries, 5 bits
[    8.422749] ID:0 pID:9888 vID:21
[    8.425980] ID:1 pID:9889 vID:22
[    8.431546] loop: module loaded
[    8.435707] hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 0
[    8.461467] scsi host0: hisi_sas_v3_hw
[    9.683463] ITS: alloc 9920:32
[    9.686509] ITT 32 entries, 5 bits
[    9.690044] ID:0 pID:9920 vID:23
[    9.693263] ID:1 pID:9921 vID:24
[    9.696480] ID:2 pID:9922 vID:25
[    9.699696] ID:3 pID:9923 vID:26
[    9.702911] ID:4 pID:9924 vID:27
[    9.706128] ID:5 pID:9925 vID:28
[    9.709344] ID:6 pID:9926 vID:29
[    9.712560] ID:7 pID:9927 vID:30
[    9.715776] ID:8 pID:9928 vID:31
[    9.718990] ID:9 pID:9929 vID:32
[    9.722207] ID:10 pID:9930 vID:33
[    9.725510] ID:11 pID:9931 vID:34
[    9.728813] ID:12 pID:9932 vID:35
[    9.732116] ID:13 pID:9933 vID:36
[    9.735419] ID:14 pID:9934 vID:37
[    9.738721] ID:15 pID:9935 vID:38
[    9.742024] ID:16 pID:9936 vID:39
[    9.820439] hisi_sas_v3_hw 0000:74:02.0: phyup: phy7 link_rate=11
[    9.826524] hisi_sas_v3_hw 0000:74:02.0: phyup: phy0 link_rate=11
[    9.832605] hisi_sas_v3_hw 0000:74:02.0: phyup: phy2 link_rate=11
[    9.838685] hisi_sas_v3_hw 0000:74:02.0: phyup: phy3 link_rate=11
[    9.844766] hisi_sas_v3_hw 0000:74:02.0: phyup: phy4 link_rate=11
[    9.850846] hisi_sas_v3_hw 0000:74:02.0: phyup: phy5 link_rate=11
[    9.856927] hisi_sas_v3_hw 0000:74:02.0: phyup: phy6 link_rate=11
[    9.863009] hisi_sas_v3_hw 0000:74:02.0: phyup: phy1 link_rate=11
[    9.869132] sas: phy-0:7 added to port-0:0, phy_mask:0x80 
(500e004aaaaaaa1f)
[    9.880210] sas: DOING DISCOVERY on port 0, pid:24
[    9.885139] hisi_sas_v3_hw 0000:74:02.0: dev[1:2] found
[    9.890870] sas: ex 500e004aaaaaaa1f phy00:U:0 attached: 
0000000000000000 (no device)
[    9.898861] sas: ex 500e004aaaaaaa1f phy01:U:0 attached: 
0000000000000000 (no device)
[    9.906843] sas: ex 500e004aaaaaaa1f phy02:U:B attached: 
5000c500a7b95a49 (ssp)
[    9.914300] sas: ex 500e004aaaaaaa1f phy03:U:0 attached: 
0000000000000000 (no device)
[    9.922256] sas: ex 500e004aaaaaaa1f phy04:U:0 attached: 
0000000000000000 (no device)
[    9.930252] sas: ex 500e004aaaaaaa1f phy05:U:B attached: 
5000c500a7babc61 (ssp)
[    9.937706] sas: ex 500e004aaaaaaa1f phy06:U:0 attached: 
0000000000000000 (no device)
[    9.945679] sas: ex 500e004aaaaaaa1f phy07:U:0 attached: 
0000000000000000 (no device)
[    9.953658] sas: ex 500e004aaaaaaa1f phy08:U:8 attached: 
500e004aaaaaaa08 (stp)
[    9.961073] sas: ex 500e004aaaaaaa1f phy09:U:0 attached: 
0000000000000000 (no device)
[    9.969049] sas: ex 500e004aaaaaaa1f phy10:U:0 attached: 
0000000000000000 (no device)
[    9.977039] sas: ex 500e004aaaaaaa1f phy11:U:A attached: 
5000c50085ff5559 (ssp)
[    9.984481] sas: ex 500e004aaaaaaa1f phy12:U:0 attached: 
0000000000000000 (no device)
[    9.992462] sas: ex 500e004aaaaaaa1f phy13:U:0 attached: 
0000000000000000 (no device)
[   10.000429] sas: ex 500e004aaaaaaa1f phy14:U:0 attached: 
0000000000000000 (no device)
[   10.008417] sas: ex 500e004aaaaaaa1f phy15:U:0 attached: 
0000000000000000 (no device)
[   10.016398] sas: ex 500e004aaaaaaa1f phy16:U:B attached: 
00188600001c9098 (host)
[   10.023952] sas: ex 500e004aaaaaaa1f phy17:U:B attached: 
00188600001c9098 (host)
[   10.031444] sas: ex 500e004aaaaaaa1f phy18:U:B attached: 
00188600001c9098 (host)
[   10.039006] sas: ex 500e004aaaaaaa1f phy19:U:B attached: 
00188600001c9098 (host)
[   10.046550] sas: ex 500e004aaaaaaa1f phy20:U:B attached: 
00188600001c9098 (host)
[   10.054110] sas: ex 500e004aaaaaaa1f phy21:U:B attached: 
00188600001c9098 (host)
[   10.061605] sas: ex 500e004aaaaaaa1f phy22:U:B attached: 
00188600001c9098 (host)
[   10.069166] sas: ex 500e004aaaaaaa1f phy23:U:B attached: 
00188600001c9098 (host)
[   10.076687] sas: ex 500e004aaaaaaa1f phy24:D:B attached: 
500e004aaaaaaa1e (host+target)
[   10.084718] hisi_sas_v3_hw 0000:74:02.0: dev[2:1] found
[   10.091152] hisi_sas_v3_hw 0000:74:02.0: dev[3:1] found
[   10.096675] hisi_sas_v3_hw 0000:74:02.0: dev[4:5] found
[   10.260080] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] found
[   10.265444] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] found
[   10.270818] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[   10.276647] sas: ata1: end_device-0:0:8: dev error handler
[   12.465109] ata1.00: ATA-8: SAMSUNG HM320JI, 2SS00_01, max UDMA7
[   12.471104] ata1.00: 625142448 sectors, multi 0: LBA48 NCQ (depth 32)
[   12.483097] ata1.00: configured for UDMA/133
[   12.487363] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 
tries: 1
[   12.506097] scsi 0:0:0:0: Direct-Access     SEAGATE  ST2000NM0045 
N004 PQ: 0 ANSI: 6
[   12.518067] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[   12.527207] scsi 0:0:1:0: Direct-Access     SEAGATE  ST2000NM0045 
N004 PQ: 0 ANSI: 6
[   12.537748] scsi 0:0:2:0: Direct-Access     ATA      SAMSUNG HM320JI 
0_01 PQ: 0 ANSI: 5
[   12.546650] scsi 0:0:3:0: Direct-Access     SEAGATE  ST1000NM0023 
0006 PQ: 0 ANSI: 6
[   12.554790] sd 0:0:0:0: [sda] Write Protect is off
[   12.559611] sd 0:0:2:0: [sdc] 625142448 512-byte logical blocks: (320 
GB/298 GiB)
[   12.567092] sd 0:0:0:0: [sda] Mode Sense: db 00 10 08
[   12.572157] sd 0:0:2:0: [sdc] Write Protect is off
[   12.576956] sd 0:0:2:0: [sdc] Mode Sense: 00 3a 00 00
[   12.582033] sd 0:0:2:0: [sdc] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[   12.591085] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[   12.600265] sd 0:0:1:0: [sdb] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[   12.608696] sd 0:0:1:0: [sdb] Write Protect is off
[   12.613759] sd 0:0:1:0: [sdb] Mode Sense: db 00 10 08
[   12.618960] scsi 0:0:4:0: Enclosure         HUAWEI   Expander 12Gx16 
128  PQ: 0 ANSI: 6
[   12.627087]  sdc: sdc1 sdc2 sdc3
[   12.630329] sd 0:0:1:0: [sdb] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[   12.639237] sd 0:0:3:0: [sdd] 1953525168 512-byte logical blocks: 
(1.00 TB/932 GiB)
[   12.646937] sd 0:0:2:0: [sdc] Attached SCSI disk
[   12.651815] sas: DONE DISCOVERY on port 0, pid:24, result:0
[   12.657401] sd 0:0:3:0: [sdd] Write Protect is off
[   12.662203] sas: phy0 matched wide port0
[   12.666141] sas: phy-0:0 added to port-0:0, phy_mask:0x81 
(500e004aaaaaaa1f)
[   12.673273] sd 0:0:3:0: [sdd] Mode Sense: db 00 10 08
[   12.678373] sas: REVALIDATING DOMAIN on port 0, pid:24
[   12.683838] sd 0:0:3:0: [sdd] Write cache: enabled, read cache: 
enabled, supports DPO and FUA
[   12.692817] sas: ex 500e004aaaaaaa1f phy08 change count has changed
[   12.699103]  sda: sda1
[   12.702292] sas: ex 500e004aaaaaaa1f phy08 originated BROADCAST(CHANGE)
[   12.708933] sas: ex 500e004aaaaaaa1f rediscovering phy08
[   12.714451] sas: ex 500e004aaaaaaa1f phy08 broadcast flutter
[   12.720932]  sdb: sdb1
[   12.723538] sas: done REVALIDATING DOMAIN on port 0, pid:24, res 0x0
[   12.729937] sas: phy2 matched wide port0
[   12.733900] sas: phy-0:2 added to port-0:0, phy_mask:0x85 
(500e004aaaaaaa1f)
[   12.740983] sas: REVALIDATING DOMAIN on port 0, pid:24
[   12.746473] sd 0:0:0:0: [sda] Attached SCSI disk
[   12.751287]  sdd: sdd1 sdd2
[   12.754829] random: fast init done
[   12.758407] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.763733] sas: done REVALIDATING DOMAIN on port 0, pid:24, res 0x0
[   12.770105] sas: phy3 matched wide port0
[   12.774030] sd 0:0:1:0: [sdb] Attached SCSI disk
[   12.778648] sas: phy-0:3 added to port-0:0, phy_mask:0x8d 
(500e004aaaaaaa1f)
[   12.785710] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.791820] sd 0:0:3:0: [sdd] Attached SCSI disk
[   12.796927] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.802227] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.808659] sas: phy4 matched wide port0
[   12.812575] sas: phy-0:4 added to port-0:0, phy_mask:0x9d 
(500e004aaaaaaa1f)
[   12.819615] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.826067] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.831367] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.837798] sas: phy5 matched wide port0
[   12.841714] sas: phy-0:5 added to port-0:0, phy_mask:0xbd 
(500e004aaaaaaa1f)
[   12.848754] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.855197] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.860498] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.866928] sas: phy6 matched wide port0
[   12.870844] sas: phy-0:6 added to port-0:0, phy_mask:0xfd 
(500e004aaaaaaa1f)
[   12.877884] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.884339] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.889639] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.896070] sas: phy1 matched wide port0
[   12.899985] sas: phy-0:1 added to port-0:0, phy_mask:0xff 
(500e004aaaaaaa1f)
[   12.907024] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.913462] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.918761] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.925191] sas: broadcast received: 0
[   12.928932] sas: REVALIDATING DOMAIN on port 0, pid:156
res 0x0
[   12.947112] sas: broadcast received: 0
[   12.950852] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.957278] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.962577] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.969008] sas: broadcast received: 0
[   12.972748] sas: REVALIDATING DOMAIN on port 0, pid:156
[   12.979191] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   12.984491] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   12.990922] sas: broadcast received: 0
[   12.994662] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.001132] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.006433] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.012863] sas: broadcast received: 0
[   13.016603] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.023053] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.028353] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.034783] sas: broadcast received: 0
[   13.038523] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.044984] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.050284] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.056714] sas: broadcast received: 0
[   13.060454] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.066906] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.072206] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.078637] sas: broadcast received: 0
[   13.082377] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.088834] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.094134] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.100565] sas: broadcast received: 0
[   13.104305] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.110757] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.116057] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.122487] sas: broadcast received: 0
[   13.126227] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.132677] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.137977] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.144407] sas: broadcast received: 0
[   13.148147] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.154579] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.159879] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.166309] sas: broadcast received: 0
[   13.170050] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.176501] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.181801] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.188232] sas: broadcast received: 0
[   13.191972] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.198423] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.203722] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.210153] sas: broadcast received: 0
[   13.213893] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.220342] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.225642] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.232072] sas: broadcast received: 0
[   13.235813] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.242263] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.247563] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.253993] sas: broadcast received: 0
[   13.257733] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.264212] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.269512] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.275942] sas: broadcast received: 0
[   13.279682] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.286137] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.291437] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.297867] sas: broadcast received: 0
[   13.301608] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.308054] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.313354] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.319784] sas: broadcast received: 0
[   13.323525] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.329978] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.335277] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.341708] sas: broadcast received: 0
[   13.345448] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.351918] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.357218] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.363648] sas: broadcast received: 0
[   13.367386] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.373838] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.379138] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.385568] sas: broadcast received: 0
[   13.389309] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.395763] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.401063] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.407494] sas: broadcast received: 0
[   13.411231] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.417687] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.422987] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.429418] sas: broadcast received: 0
[   13.433158] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.439612] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.444912] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.451342] sas: broadcast received: 0
[   13.455083] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.461551] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.466851] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.473281] sas: broadcast received: 0
[   13.477022] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.483478] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.488793] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.495224] sas: broadcast received: 0
[   13.498965] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.505403] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.510703] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.517133] sas: broadcast received: 0
[   13.520874] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.527328] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.532628] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.539058] sas: broadcast received: 0
[   13.542798] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.549232] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.554532] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.560962] sas: broadcast received: 0
[   13.564703] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.571180] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.576480] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.582911] sas: broadcast received: 0
[   13.586651] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.593103] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.598402] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.604833] sas: broadcast received: 0
[   13.608573] sas: REVALIDATING DOMAIN on port 0, pid:156
[   13.615033] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   13.620333] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   13.626900] ahci 0000:74:03.0: Adding to iommu group 1
[   13.632108] ahci 0000:74:03.0: version 3.0
[   13.636229] ITS: alloc 9952:2
[   13.639186] ITT 2 entries, 1 bits
[   13.642514] ID:0 pID:9952 vID:41
[   13.645732] ID:1 pID:9953 vID:42
[   13.648961] ahci 0000:74:03.0: SSS flag set, parallel bus scan disabled
[   13.655572] ahci 0000:74:03.0: AHCI 0001.0300 32 slots 2 ports 6 Gbps 
0x3 impl SATA mode
[   13.663651] ahci 0000:74:03.0: flags: 64bit ncq sntf stag pm led clo 
only pmp fbs slum part ccc sxs boh
[   13.677432] scsi host1: ahci
[   13.684420] scsi host2: ahci
[   13.687348] ata2: SATA max UDMA/133 abar m4096@0xa2008000 port 
0xa2008100 irq 41
[   13.694737] ata3: SATA max UDMA/133 abar m4096@0xa2008000 port 
0xa2008180 irq 42
[   13.704957] libphy: Fixed MDIO Bus: probed
[   13.709163] tun: Universal TUN/TAP device driver, 1.6
[   13.714794] thunder_xcv, ver 1.0
[   13.718049] thunder_bgx, ver 1.0
[   13.721298] nicpf, ver 1.0
[   13.724684] hclge is initializing
[   13.727991] hns3: Hisilicon Ethernet Network Driver for Hip08 Family 
- version
[   13.735200] hns3: Copyright (c) 2017 Huawei Corporation.
[   13.740634] hns3 0000:7d:00.0: Adding to iommu group 2
[   13.745869] hns3 0000:7d:00.0: The firmware version is b0620130
[   13.751821] ITS: alloc 9954:256
[   13.754952] ITT 256 entries, 8 bits
[   13.758445] ID:0 pID:9954 vID:43
[   13.761672] ID:1 pID:9955 vID:44
[   13.764900] ID:2 pID:9956 vID:45
[   13.768127] ID:3 pID:9957 vID:46
[   13.771350] ID:4 pID:9958 vID:47
[   13.774577] ID:5 pID:9959 vID:48
[   13.777807] ID:6 pID:9960 vID:49
[   13.781034] ID:7 pID:9961 vID:50
[   13.784260] ID:8 pID:9962 vID:51
[   13.787485] ID:9 pID:9963 vID:52
[   13.790710] ID:10 pID:9964 vID:53
[   13.794022] ID:11 pID:9965 vID:54
[   13.797335] ID:12 pID:9966 vID:55
[   13.800648] ID:13 pID:9967 vID:56
[   13.803962] ID:14 pID:9968 vID:57
[   13.807272] ID:15 pID:9969 vID:58
[   13.810585] ID:16 pID:9970 vID:59
[   13.813898] ID:17 pID:9971 vID:60
[   13.817210] ID:18 pID:9972 vID:61
[   13.820523] ID:19 pID:9973 vID:62
[   13.823835] ID:20 pID:9974 vID:63
[   13.827146] ID:21 pID:9975 vID:64
[   13.830459] ID:22 pID:9976 vID:65
[   13.833772] ID:23 pID:9977 vID:66
[   13.837084] ID:24 pID:9978 vID:67
[   13.840398] ID:25 pID:9979 vID:68
[   13.843710] ID:26 pID:9980 vID:69
[   13.847020] ID:27 pID:9981 vID:70
[   13.850333] ID:28 pID:9982 vID:71
[   13.853645] ID:29 pID:9983 vID:72
[   13.856958] ID:30 pID:9984 vID:73
[   13.860271] ID:31 pID:9985 vID:74
[   13.863584] ID:32 pID:9986 vID:75
[   13.866894] ID:33 pID:9987 vID:76
[   13.870206] ID:34 pID:9988 vID:77
[   13.873519] ID:35 pID:9989 vID:78
[   13.876832] ID:36 pID:9990 vID:79
[   13.880144] ID:37 pID:9991 vID:80
[   13.883457] ID:38 pID:9992 vID:81
[   13.886768] ID:39 pID:9993 vID:82
[   13.890081] ID:40 pID:9994 vID:83
[   13.893393] ID:41 pID:9995 vID:84
[   13.896709] ID:42 pID:9996 vID:85
[   13.900022] ID:43 pID:9997 vID:86
[   13.903332] ID:44 pID:9998 vID:87
[   13.906644] ID:45 pID:9999 vID:88
[   13.909965] ID:46 pID:10000 vID:89
[   13.913366] ID:47 pID:10001 vID:90
[   13.916770] ID:48 pID:10002 vID:91
[   13.920169] ID:49 pID:10003 vID:92
[   13.923572] ID:50 pID:10004 vID:93
[   13.926969] ID:51 pID:10005 vID:94
[   13.930372] ID:52 pID:10006 vID:95
[   13.933772] ID:53 pID:10007 vID:96
[   13.937175] ID:54 pID:10008 vID:97
[   13.940576] ID:55 pID:10009 vID:98
[   13.943978] ID:56 pID:10010 vID:99
[   13.947375] ID:57 pID:10011 vID:100
[   13.950866] ID:58 pID:10012 vID:101
[   13.954353] ID:59 pID:10013 vID:102
[   13.957842] ID:60 pID:10014 vID:103
[   13.961328] ID:61 pID:10015 vID:104
[   13.964819] ID:62 pID:10016 vID:105
[   13.968306] ID:63 pID:10017 vID:106
[   13.971796] ID:64 pID:10018 vID:107
[   13.975279] ID:65 pID:10019 vID:108
[   13.978769] ID:66 pID:10020 vID:109
[   13.982255] ID:67 pID:10021 vID:110
[   13.985744] ID:68 pID:10022 vID:111
[   13.989230] ID:69 pID:10023 vID:112
[   13.992721] ID:70 pID:10024 vID:113
[   13.996208] ID:71 pID:10025 vID:114
[   13.999697] ID:72 pID:10026 vID:115
[   14.003182] ID:73 pID:10027 vID:116
[   14.006672] ID:74 pID:10028 vID:117
[   14.010158] ID:75 pID:10029 vID:118
[   14.013641] ata2: SATA link down (SStatus 0 SControl 300)
[   14.019038] ID:76 pID:10030 vID:119
[   14.022537] ID:77 pID:10031 vID:120
[   14.026024] ID:78 pID:10032 vID:121
[   14.029512] ID:79 pID:10033 vID:122
[   14.033013] ID:80 pID:10034 vID:123
[   14.036504] ID:81 pID:10035 vID:124
[   14.039990] ID:82 pID:10036 vID:125
[   14.043477] ID:83 pID:10037 vID:126
[   14.046961] ID:84 pID:10038 vID:127
[   14.050448] ID:85 pID:10039 vID:128
[   14.053935] ID:86 pID:10040 vID:129
[   14.057421] ID:87 pID:10041 vID:130
[   14.060909] ID:88 pID:10042 vID:131
[   14.064395] ID:89 pID:10043 vID:132
[   14.067881] ID:90 pID:10044 vID:133
[   14.071365] ID:91 pID:10045 vID:134
[   14.074853] ID:92 pID:10046 vID:135
[   14.078340] ID:93 pID:10047 vID:136
[   14.081827] ID:94 pID:10048 vID:137
[   14.085314] ID:95 pID:10049 vID:138
[   14.088802] ID:96 pID:10050 vID:139
[   14.092288] ID:97 pID:10051 vID:140
[   14.095774] ID:98 pID:10052 vID:141
[   14.099258] ID:99 pID:10053 vID:142
[   14.102745] ID:100 pID:10054 vID:143
[   14.106319] ID:101 pID:10055 vID:144
[   14.109893] ID:102 pID:10056 vID:145
[   14.113467] ID:103 pID:10057 vID:146
[   14.117041] ID:104 pID:10058 vID:147
[   14.120613] ID:105 pID:10059 vID:148
[   14.124187] ID:106 pID:10060 vID:149
[   14.127761] ID:107 pID:10061 vID:150
[   14.131332] ID:108 pID:10062 vID:151
[   14.134904] ID:109 pID:10063 vID:152
[   14.138478] ID:110 pID:10064 vID:153
[   14.142053] ID:111 pID:10065 vID:154
[   14.145626] ID:112 pID:10066 vID:155
[   14.149199] ID:113 pID:10067 vID:156
[   14.152773] ID:114 pID:10068 vID:157
[   14.156347] ID:115 pID:10069 vID:158
[   14.159920] ID:116 pID:10070 vID:159
[   14.163493] ID:117 pID:10071 vID:160
[   14.167065] ID:118 pID:10072 vID:161
[   14.170639] ID:119 pID:10073 vID:162
[   14.174212] ID:120 pID:10074 vID:163
[   14.177785] ID:121 pID:10075 vID:164
[   14.181363] ID:122 pID:10076 vID:165
[   14.184936] ID:123 pID:10077 vID:166
[   14.188509] ID:124 pID:10078 vID:167
[   14.192082] ID:125 pID:10079 vID:168
[   14.195658] ID:126 pID:10080 vID:169
[   14.199230] ID:127 pID:10081 vID:170
[   14.202803] ID:128 pID:10082 vID:171
[   14.206376] ID:129 pID:10083 vID:172
[   14.209950] ID:130 pID:10084 vID:173
[   14.213523] ID:131 pID:10085 vID:174
[   14.217096] ID:132 pID:10086 vID:175
[   14.220670] ID:133 pID:10087 vID:176
[   14.224244] ID:134 pID:10088 vID:177
[   14.227817] ID:135 pID:10089 vID:178
[   14.231390] ID:136 pID:10090 vID:179
[   14.234962] ID:137 pID:10091 vID:180
[   14.238536] ID:138 pID:10092 vID:181
[   14.242109] ID:139 pID:10093 vID:182
[   14.245686] ID:140 pID:10094 vID:183
[   14.249260] ID:141 pID:10095 vID:184
[   14.252837] ID:142 pID:10096 vID:185
[   14.256412] ID:143 pID:10097 vID:186
[   14.259988] ID:144 pID:10098 vID:187
[   14.263562] ID:145 pID:10099 vID:188
[   14.267137] ID:146 pID:10100 vID:189
[   14.270710] ID:147 pID:10101 vID:190
[   14.274287] ID:148 pID:10102 vID:191
[   14.277860] ID:149 pID:10103 vID:192
[   14.281437] ID:150 pID:10104 vID:193
[   14.285011] ID:151 pID:10105 vID:194
[   14.288589] ID:152 pID:10106 vID:195
[   14.292162] ID:153 pID:10107 vID:196
[   14.295738] ID:154 pID:10108 vID:197
[   14.299309] ID:155 pID:10109 vID:198
[   14.302885] ID:156 pID:10110 vID:199
[   14.306458] ID:157 pID:10111 vID:200
[   14.310035] ID:158 pID:10112 vID:201
[   14.313609] ID:159 pID:10113 vID:202
[   14.317186] ID:160 pID:10114 vID:203
[   14.327226] hclge driver initialization finished.
[   14.352153] ata3: SATA link down (SStatus 0 SControl 300)
[   14.363468] hns3 0000:7d:00.1: Adding to iommu group 3
[   14.368724] hns3 0000:7d:00.1: The firmware version is b0620130
[   14.374679] ITS: alloc 10210:256
[   14.377900] ITT 256 entries, 8 bits
[   14.381401] ID:0 pID:10210 vID:204
[   14.384803] ID:1 pID:10211 vID:205
[   14.388203] ID:2 pID:10212 vID:206
[   14.391604] ID:3 pID:10213 vID:207
[   14.395003] ID:4 pID:10214 vID:208
[   14.398403] ID:5 pID:10215 vID:209
[   14.401803] ID:6 pID:10216 vID:210
[   14.405203] ID:7 pID:10217 vID:211
[   14.408602] ID:8 pID:10218 vID:212
[   14.412001] ID:9 pID:10219 vID:213
[   14.415401] ID:10 pID:10220 vID:214
[   14.418885] ID:11 pID:10221 vID:215
[   14.422373] ID:12 pID:10222 vID:216
[   14.425859] ID:13 pID:10223 vID:217
[   14.429345] ID:14 pID:10224 vID:218
[   14.432831] ID:15 pID:10225 vID:219
[   14.436318] ID:16 pID:10226 vID:220
[   14.439803] ID:17 pID:10227 vID:221
[   14.443288] ID:18 pID:10228 vID:222
[   14.446774] ID:19 pID:10229 vID:223
[   14.450262] ID:20 pID:10230 vID:224
[   14.453749] ID:21 pID:10231 vID:225
[   14.457235] ID:22 pID:10232 vID:226
[   14.460721] ID:23 pID:10233 vID:227
[   14.464207] ID:24 pID:10234 vID:228
[   14.467694] ID:25 pID:10235 vID:229
[   14.471178] ID:26 pID:10236 vID:230
[   14.474664] ID:27 pID:10237 vID:231
[   14.478154] ID:28 pID:10238 vID:232
[   14.481641] ID:29 pID:10239 vID:233
[   14.485126] ID:30 pID:10240 vID:234
[   14.488616] ID:31 pID:10241 vID:235
[   14.492103] ID:32 pID:10242 vID:236
[   14.495591] ID:33 pID:10243 vID:237
[   14.499074] ID:34 pID:10244 vID:238
[   14.502561] ID:35 pID:10245 vID:239
[   14.506049] ID:36 pID:10246 vID:240
[   14.509535] ID:37 pID:10247 vID:241
[   14.513022] ID:38 pID:10248 vID:242
[   14.516D:42 pID:10252 vID:246
[   14.530450] ID:43 pID:10253 vID:247
[   14.533939] ID:44 pID:10254 vID:248
[   14.537425] ID:45 pID:10255 vID:249
[   14.540911] ID:46 pID:10256 vID:250
[   14.544397] ID:47 pID:10257 vID:251
[   14.547884] ID:48 pID:10258 vID:252
[   14.551367] ID:49 pID:10259 vID:253
[   14.554854] ID:50 pID:10260 vID:254
[   14.558341] ID:51 pID:10261 vID:255
[   14.561828] ID:52 pID:10262 vID:256
[   14.565314] ID:53 pID:10263 vID:257
[   14.568801] ID:54 pID:10264 vID:258
[   14.572288] ID:55 pID:10265 vID:259
[   14.575774] ID:56 pID:10266 vID:260
[   14.579258] ID:57 pID:10267 vID:261
[   14.582744] ID:58 pID:10268 vID:262
[   14.586231] ID:59 pID:10269 vID:263
[   14.589719] ID:60 pID:10270 vID:264
[   14.593205] ID:61 pID:10271 vID:265
[   14.596691] ID:62 pID:10272 vID:266
[   14.600178] ID:63 pID:10273 vID:267
[   14.603665] ID:64 pID:10274 vID:268
[   14.607148] ID:65 pID:10275 vID:269
[   14.610636] ID:66 pID:10276 vID:270
[   14.614122] ID:67 pID:10277 vID:271
[   14.617609] ID:68 pID:10278 vID:272
[   14.621095] ID:69 pID:10279 vID:273
[   14.624582] ID:70 pID:10280 vID:274
[   14.628068] ID:71 pID:10281 vID:275
[   14.631554] ID:72 pID:10282 vID:276
[   14.635037] ID:73 pID:10283 vID:277
[   14.638525] ID:74 pID:10284 vID:278
[   14.642011] ID:75 pID:10285 vID:279
[   14.645499] ID:76 pID:10286 vID:280
[   14.648986] ID:77 pID:10287 vID:281
[   14.652473] ID:78 pID:10288 vID:282
[   14.655959] ID:79 pID:10289 vID:283
[   14.659445] ID:80 pID:10290 vID:284
[   14.662930] ID:81 pID:10291 vID:285
[   14.666416] ID:82 pID:10292 vID:286
[   14.669902] ID:83 pID:10293 vID:287
[   14.673390] ID:84 pID:10294 vID:288
[   14.676877] ID:85 pID:10295 vID:289
[   14.680363] ID:86 pID:10296 vID:290
[   14.683849] ID:87 pID:10297 vID:291
[   14.687333] ID:88 pID:10298 vID:292
[   14.690821] ID:89 pID:10299 vID:293
[   14.694308] ID:90 pID:10300 vID:294
[   14.697794] ID:91 pID:10301 vID:295
[   14.701282] ID:92 pID:10302 vID:296
[   14.704769] ID:93 pID:10303 vID:297
[   14.708255] ID:94 pID:10304 vID:298
[   14.711745] ID:95 pID:10305 vID:299
[   14.715229] ID:96 pID:10306 vID:300
[   14.718716] ID:97 pID:10307 vID:301
[   14.722202] ID:98 pID:10308 vID:302
[   14.725688] ID:99 pID:10309 vID:303
[   14.729178] ID:100 pID:10310 vID:304
[   14.732752] ID:101 pID:10311 vID:305
[   14.736325] ID:102 pID:10312 vID:306
[   14.739898] ID:103 pID:10313 vID:307
[   14.743472] ID:104 pID:10314 vID:308
[   14.747043] ID:105 pID:10315 vID:309
[   14.750616] ID:106 pID:10316 vID:310
[   14.754188] ID:107 pID:10317 vID:311
[   14.757764] ID:108 pID:10318 vID:312
[   14.761337] ID:109 pID:10319 vID:313
[   14.764910] ID:110 pID:10320 vID:314
[   14.768484] ID:111 pID:10321 vID:315
[   14.772058] ID:112 pID:10322 vID:316
[   14.775631] ID:113 pID:10323 vID:317
[   14.779201] ID:114 pID:10324 vID:318
[   14.782775] ID:115 pID:10325 vID:319
[   14.786350] ID:116 pID:10326 vID:320
[   14.789924] ID:117 pID:10327 vID:321
[   14.793497] ID:118 pID:10328 vID:322
[   14.797071] ID:119 pID:10329 vID:323
[   14.800644] ID:120 pID:10330 vID:324
[   14.804217] ID:121 pID:10331 vID:325
[   14.807790] ID:122 pID:10332 vID:326
[   14.811362] ID:123 pID:10333 vID:327
[   14.814937] ID:124 pID:10334 vID:328
[   14.818510] ID:125 pID:10335 vID:329
[   14.822084] ID:126 pID:10336 vID:330
[   14.825657] ID:127 pID:10337 vID:331
[   14.829230] ID:128 pID:10338 vID:332
[   14.832803] ID:129 pID:10339 vID:333
[   14.836377] ID:130 pID:10340 vID:334
[   14.839950] ID:131 pID:10341 vID:335
[   14.843524] ID:132 pID:10342 vID:336
[   14.847095] ID:133 pID:10343 vID:337
[   14.850669] ID:134 pID:10344 vID:338
[   14.854242] ID:135 pID:10345 vID:339
[   14.857815] ID:136 pID:10346 vID:340
[   14.861388] ID:137 pID:10347 vID:341
[   14.864963] ID:138 pID:10348 vID:342
[   14.868536] ID:139 pID:10349 vID:343
[   14.872110] ID:140 pID:10350 vID:344
[   14.875684] ID:141 pID:10351 vID:345
[   14.879255] ID:142 pID:10352 vID:346
[   14.882828] ID:143 pID:10353 vID:347
[   14.886401] ID:144 pID:10354 vID:348
[   14.889975] ID:145 pID:10355 vID:349
[   14.893549] ID:146 pID:10356 vID:350
[   14.897122] ID:147 pID:10357 vID:351
[   14.900696] ID:148 pID:10358 vID:352
[   14.904270] ID:149 pID:10359 vID:353
[   14.907843] ID:150 pID:10360 vID:354
[   14.911416] ID:151 pID:10361 vID:355
[   14.914987] ID:152 pID:10362 vID:356
[   14.918560] ID:153 pID:10363 vID:357
[   14.922133] ID:154 pID:10364 vID:358
[   14.925707] ID:155 pID:10365 vID:359
[   14.929282] ID:156 pID:10366 vID:360
[   14.932856] ID:157D:10370 vID:364
[   14.953623] hclge driver initialization finished.
[   14.984663] hns3 0000:7d:00.2: Adding to iommu group 4
[   14.989936] hns3 0000:7d:00.2: The firmware version is b0620130
[   14.995895] ITS: alloc 10466:256
[   14.999112] ITT 256 entries, 8 bits
[   15.002608] ID:0 pID:10466 vID:365
[   15.006011] ID:1 pID:10467 vID:366
[   15.009413] ID:2 pID:10468 vID:367
[   15.012815] ID:3 pID:10469 vID:368
[   15.016219] ID:4 pID:10470 vID:369
[   15.019620] ID:5 pID:10471 vID:370
[   15.023017] ID:6 pID:10472 vID:371
[   15.026419] ID:7 pID:10473 vID:372
[   15.029818] ID:8 pID:10474 vID:373
[   15.033218] ID:9 pID:10475 vID:374
[   15.036619] ID:10 pID:10476 vID:375
[   15.040106] ID:11 pID:10477 vID:376
[   15.043592] ID:12 pID:10478 vID:377
[   15.047076] ID:13 pID:10479 vID:378
[   15.050564] ID:14 pID:10480 vID:379
[   15.054051] ID:15 pID:10481 vID:380
[   15.057536] ID:16 pID:10482 vID:381
[   15.061024] ID:17 pID:10483 vID:382
[   15.064513] ID:18 pID:10484 vID:383
[   15.067999] ID:19 pID:10485 vID:384
[   15.071486] ID:20 pID:10486 vID:385
[   15.074970] ID:21 pID:10487 vID:386
[   15.078457] ID:22 pID:10488 vID:387
[   15.081944] ID:23 pID:10489 vID:388
[   15.085430] ID:24 pID:10490 vID:389
[   15.088918] ID:25 pID:10491 vID:390
[   15.092406] ID:26 pID:10492 vID:391
[   15.095892] ID:27 pID:10493 vID:392
[   15.099376] ID:28 pID:10494 vID:393
[   15.102863] ID:29 pID:10495 vID:394
[   15.106350] ID:30 pID:10496 vID:395
[   15.109836] ID:31 pID:10497 vID:396
[   15.113321] ID:32 pID:10498 vID:397
[   15.116809] ID:33 pID:10499 vID:398
[   15.120296] ID:34 pID:10500 vID:399
[   15.123783] ID:35 pID:10501 vID:400
[   15.127267] ID:36 pID:10502 vID:401
[   15.130754] ID:37 pID:10503 vID:402
[   15.134240] ID:38 pID:10504 vID:403
[   15.137726] ID:39 pID:10505 vID:404
[   15.141214] ID:40 pID:10506 vID:405
[   15.144701] ID:41 pID:10507 vID:406
[   15.148188] ID:42 pID:10508 vID:407
[   15.151674] ID:43 pID:10509 vID:408
[   15.155159] ID:44 pID:10510 vID:409
[   15.158645] ID:45 pID:10511 vID:410
[   15.162132] ID:46 pID:10512 vID:411
[   15.165617] ID:47 pID:10513 vID:412
[   15.169104] ID:48 pID:10514 vID:413
[   15.172591] ID:49 pID:10515 vID:414
[   15.176079] ID:50 pID:10516 vID:415
[   15.179565] ID:51 pID:10517 vID:416
[   15.183050] ID:52 pID:10518 vID:417
[   15.186537] ID:53 pID:10519 vID:418
[   15.190023] ID:54 pID:10520 vID:419
[   15.193510] ID:55 pID:10521 vID:420
[   15.196996] ID:56 pID:10522 vID:421
[   15.200483] ID:57 pID:10523 vID:422
[   15.203970] ID:58 pID:10524 vID:423
[   15.207457] ID:59 pID:10525 vID:424
[   15.210941] ID:60 pID:10526 vID:425
[   15.214428] ID:61 pID:10527 vID:426
[   15.217914] ID:62 pID:10528 vID:427
[   15.221401] ID:63 pID:10529 vID:428
[   15.224887] ID:64 pID:10530 vID:429
[   15.228374] ID:65 pID:10531 vID:430
[   15.231861] ID:66 pID:10532 vID:431
[   15.235346] ID:67 pID:10533 vID:432
[   15.238832] ID:68 pID:10534 vID:433
[   15.242319] ID:69 pID:10535 vID:434
[   15.245806] ID:70 pID:10536 vID:435
[   15.249292] ID:71 pID:10537 vID:436
[   15.252778] ID:72 pID:10538 vID:437
[   15.256265] ID:73 pID:10539 vID:438
[   15.259753] ID:74 pID:10540 vID:439
[   15.263237] ID:75 pID:10541 vID:440
[   15.266723] ID:76 pID:10542 vID:441
[   15.270209] ID:77 pID:10543 vID:442
[   15.273696] ID:78 pID:10544 vID:443
[   15.277183] ID:79 pID:10545 vID:444
[   15.280669] ID:80 pID:10546 vID:445
[   15.284156] ID:81 pID:10547 vID:446
[   15.287647] ID:82 pID:10548 vID:447
[   15.291134] ID:83 pID:10549 vID:448
[   15.294620] ID:84 pID:10550 vID:449
[   15.298108] ID:85 pID:10551 vID:450
[   15.301594] ID:86 pID:10552 vID:451
[   15.305081] ID:87 pID:10553 vID:452
[   15.308568] ID:88 pID:10554 vID:453
[   15.312055] ID:89 pID:10555 vID:454
[   15.315542] ID:90 pID:10556 vID:455
[   15.319026] ID:91 pID:10557 vID:456
[   15.322513] ID:92 pID:10558 vID:457
[   15.326000] ID:93 pID:10559 vID:458
[   15.329486] ID:94 pID:10560 vID:459
[   15.332973] ID:95 pID:10561 vID:460
[   15.336459] ID:96 pID:10562 vID:461
[   15.339948] ID:97 pID:10563 vID:462
[   15.343435] ID:98 pID:10564 vID:463
[   15.346919] ID:99 pID:10565 vID:464
[   15.350406] ID:100 pID:10566 vID:465
[   15.353980] ID:101 pID:10567 vID:466
[   15.357553] ID:102 pID:10568 vID:467
[   15.361125] ID:103 pID:10569 vID:468
[   15.364699] ID:104 pID:10570 vID:469
[   15.368273] ID:105 pID:10571 vID:470
[   15.371847] ID:106 pID:10572 vID:471
[   15.375421] ID:107 pID:10573 vID:472
[   15.378993] ID:108 pID:10574 vID:473
[   15.382566] ID:109 pID:10575 vID:474
[   15.386138] ID:110 pID:10576 vID:475
[   15.389712] ID:111 pID:10577 vID:476
[   15.393285] ID:112 pID:10578 vID:477
[   15.396859] ID:113 pID:10579 vID:478
[   15.400433] ID:114 pID:10580 vID:479
[   15.404007] ID:115 pID:10581 vID:480
[   15.407581] ID:116 pID:10582 vID:481
[   15.411152] ID:117 pID:10583 vID:482
[   15.414724] ID:118 pID:10584 vID:483
[   15.418298] ID:119 pID:10585 vID:484
[   15.421872] ID:120 pID:10586 vID:485
[   15.425446] ID:121 pID:10587 vID:486
[   15.429019] ID:122 pID:10588 vID:487
[   15.432593] ID:123 pID:10589 vID:488
[   15.436167] ID:124 pID:10590 vID:489
[   15.439740] ID:125 pID:10591 vID:490
[   15.443311] ID:126 pID:10592 vID:491
[   15.446884] ID:127 pID:10593 vID:492
[   15.450458] ID:128 pID:10594 vID:493
[   15.454031] ID:129 pID:10595 vID:494
[   15.457606] ID:130 pID:10596 vID:495
[   15.461178] ID:131 pID:10597 vID:496
[   15.464751] ID:132 pID:10598 vID:497
[   15.468324] ID:133 pID:10599 vID:498
[   15.471898] ID:134 pID:10600 vID:499
[   15.475471] ID:135 pID:10601 vID:500
[   15.479042] ID:136 pID:10602 vID:501
[   15.482616] ID:137 pID:10603 vID:502
[   15.486191] ID:138 pID:10604 vID:503
[   15.489764] ID:139 pID:10605 vID:504
[   15.493337] ID:140 pID:10606 vID:505
[   15.496910] ID:141 pID:10607 vID:506
[   15.500483] ID:142 pID:10608 vID:507
[   15.504056] ID:143 pID:10609 vID:508
[   15.507629] ID:144 pID:10610 vID:509
[   15.511202] ID:145 pID:10611 vID:510
[   15.514776] ID:146 pID:10612 vID:511
[   15.518349] ID:147 pID:10613 vID:512
[   15.521922] ID:148 pID:10614 vID:513
[   15.525496] ID:149 pID:10615 vID:514
[   15.529070] ID:150 pID:10616 vID:515
[   15.532642] ID:151 pID:10617 vID:516
[   15.536215] ID:152 pID:10618 vID:517
[   15.539790] ID:153 pID:10619 vID:518
[   15.543362] ID:154 pID:10620 vID:519
[   15.546935] ID:155 pID:10621 vID:520
[   15.550512] ID:156 pID:10622 vID:521
[   15.554086] ID:157 pID:10623 vID:522
[   15.557659] ID:158 pID:10624 vID:523
[   15.561233] ID:159 pID:10625 vID:524
[   15.564807] ID:160 pID:10626 vID:525
[   15.570151] libphy: hisilicon MII bus: probed
[   15.575132] hclge driver initialization finished.
[   15.586344] hns3 0000:7d:00.3: Adding to iommu group 5
[   15.591587] hns3 0000:7d:00.3: The firmware version is b0620130
[   15.597541] ITS: alloc 10722:128
[   15.600766] ITT 128 entries, 7 bits
[   15.604268] ID:0 pID:10722 vID:526
[   15.607674] ID:1 pID:10723 vID:527
[   15.611071] ID:2 pID:10724 vID:528
[   15.614475] ID:3 pID:10725 vID:529
[   15.617876] ID:4 pID:10726 vID:530
[   15.621277] ID:5 pID:10727 vID:531
[   15.624678] ID:6 pID:10728 vID:532
[   15.628079] ID:7 pID:10729 vID:533
[   15.631479] ID:8 pID:10730 vID:534
[   15.634876] ID:9 pID:10731 vID:535
[   15.638276] ID:10 pID:10732 vID:536
[   15.641763] ID:11 pID:10733 vID:537
[   15.645249] ID:12 pID:10734 vID:538
[   15.648737] ID:13 pID:10735 vID:539
[   15.652224] ID:14 pID:10736 vID:540
[   15.655711] ID:15 pID:10737 vID:541
[   15.659195] ID:16 pID:10738 vID:542
[   15.662682] ID:17 pID:10739 vID:543
[   15.666168] ID:18 pID:10740 vID:544
[   15.669660] ID:19 pID:10741 vID:545
[   15.673147] ID:20 pID:10742 vID:546
[   15.676634] ID:21 pID:10743 vID:547
[   15.680122] ID:22 pID:10744 vID:548
[   15.683609] ID:23 pID:10745 vID:549
[   15.687092] ID:24 pID:10746 vID:550
[   15.690578] ID:25 pID:10747 vID:551
[   15.694065] ID:26 pID:10748 vID:552
[   15.697551] ID:27 pID:10749 vID:553
[   15.701037] ID:28 pID:10750 vID:554
[   15.704524] ID:29 pID:10751 vID:555
[   15.708012] ID:30 pID:10752 vID:556
[   15.711498] ID:31 pID:10753 vID:557
[   15.714982] ID:32 pID:10754 vID:558
[   15.718469] ID:33 pID:10755 vID:559
[   15.721956] ID:34 pID:10756 vID:560
[   15.725442] ID:35 pID:10757 vID:561
[   15.728928] ID:36 pID:10758 vID:562
[   15.732416] ID:37 pID:10759 vID:563
[   15.735903] ID:38 pID:10760 vID:564
[   15.739389] ID:39 pID:10761 vID:565
[   15.742873] ID:40 pID:10762 vID:566
[   15.746360] ID:41 pID:10763 vID:567
[   15.749846] ID:42 pID:10764 vID:568
[   15.753333] ID:43 pID:10765 vID:569
[   15.756820] ID:44 pID:10766 vID:570
[   15.760307] ID:45 pID:10767 vID:571
[   15.763794] ID:46 pID:10768 vID:572
[   15.767277] ID:47 pID:10769 vID:573
[   15.770763] ID:48 pID:10770 vID:574
[   15.774251] ID:49 pID:10771 vID:575
[   15.777737] ID:50 pID:10772 vID:576
[   15.781223] ID:51 pID:10773 vID:577
[   15.784710] ID:52 pID:10774 vID:578
[   15.788197] ID:53 pID:10775 vID:579
[   15.791684] ID:54 pID:10776 vID:580
[   15.795168] ID:55 pID:10777 vID:581
[   15.798655] ID:56 pID:10778 vID:582
[   15.802140] ID:57 pID:10779 vID:583
[   15.805626] ID:58 pID:10780 vID:584
[   15.809113] ID:59 pID:10781 vID:585
[   15.812600] ID:60 pID:10782 vID:586
[   15.816087] ID:61 pID:10783 vID:587
[   15.819574] ID:62 pID:10784 vID:588
[   15.823058] ID:63 pID:10785 vID:589
[   15.826544] ID:64 pID:10786 vID:590
[   15.831411] libphy: hisilicon MII bus: probed
[   15.836198] hclge driver initialization finished.
[   15.847526] hns3 0000:bd:00.0: Adding to iommu group 6
[   15.852769] hns3 0000:bd:00.0: The firmware version is b0620130
[   15.858728] ITS: alloc 10850:256
[   15.861954] ITT 256 entries, 8 bits
[   15.865457] ID:0 pID:10850 vID:591
[   15.868867] ID:1 pID:10851 vID:592
[   15.872275] ID:2 pID:10852 vID:593
[   15.875679] ID:3 pID:10853 vID:594
[   15.879081] ID:4 pID:10854 vID:595
[   15.882485] ID:5 pID:10855 vID:596
[   15.885892] ID:6 pID:10856 vID:597
[   15.889297] ID:7 pID:10857 vID:598
[   15.892700] ID:8 pID:10858 vID:599
[   15.896103] ID:9 pID:10859 vID:600
[   15.899508] ID:10 pID:10860 vID:601
[   15.902997] ID:11 pID:10861 vID:602
[   15.906487] ID:12 pID:10862 vID:603
[   15.909978] ID:13 pID:10863 vID:604
[   15.913468] ID:14 pID:10864 vID:605
[   15.916960] ID:15 pID:10865 vID:606
[   15.920450] ID:16 pID:10866 vID:607
[   15.923941] ID:17 pID:10867 vID:608
[   15.927432] ID:18 pID:10868 vID:609
[   15.930920] ID:19 pID:10869 vID:610
[   15.934411] ID:20 pID:10870 vID:611
[   15.937902] ID:21 pID:10871 vID:612
[   15.941393] ID:22 pID:10872 vID:613
[   15.944884] ID:23 pID:10873 vID:614
[   15.948374] ID:24 pID:10874 vID:615
[   15.951866] ID:25 pID:10875 vID:616
[   15.955355] ID:26 pID:10876 vID:617
[   15.958846] ID:27 pID:10877 vID:618
[   15.962336] ID:28 pID:10878 vID:619
[   15.965827] ID:29 pID:10879 vID:620
[   15.969318] ID:30 pID:10880 vID:621
[   15.972809] ID:31 pID:10881 vID:622
[   15.976300] ID:32 pID:10882 vID:623
[   15.979790] ID:33 pID:10883 vID:624
[   15.983279] ID:34 pID:10884 vID:625
[   15.986769] ID:35 pID:10885 vID:626
[   15.990259] ID:36 pID:10886 vID:627
[   15.993755] ID:37 pID:10887 vID:628
[   15.997246] ID:38 pID:10888 vID:629
[   16.000737] ID:39 pID:10889 vID:630
[   16.004228] ID:40 pID:10890 vID:631
[   16.007719] ID:41 pID:10891 vID:632
[   16.011208] ID:42 pID:10892 vID:633
[   16.014698] ID:43 pID:10893 vID:634
[   16.018190] ID:44 pID:10894 vID:635
[   16.021682] ID:45 pID:10895 vID:636
[   16.025174] ID:46 pID:10896 vID:637
[   16.028664] ID:47 pID:10897 vID:638
[   16.032154] ID:48 pID:10898 vID:639
[   16.035646] ID:49 pID:10899 vID:640
[   16.039134] ID:50 pID:10900 vID:641
[   16.042625] ID:51 pID:10901 vID:642
[   16.046116] ID:52 pID:10902 vID:643
[   16.049608] ID:53 pID:10903 vID:644
[   16.053099] ID:54 pID:10904 vID:645
[   16.056589] ID:55 pID:10905 vID:646
[   16.060080] ID:56 pID:10906 vID:647
[   16.063571] ID:57 pID:10907 vID:648
[   16.067059] ID:58 pID:10908 vID:649
[   16.070549] ID:59 pID:10909 vID:650
[   16.074040] ID:60 pID:10910 vID:651
[   16.077531] ID:61 pID:10911 vID:652
[   16.081021] ID:62 pID:10912 vID:653
[   16.084512] ID:63 pID:10913 vID:654
[   16.088005] ID:64 pID:10914 vID:655
[   16.091496] ID:65 pID:10915 vID:656
[   16.094984] ID:66 pID:10916 vID:657
[   16.098475] ID:67 pID:10917 vID:658
[   16.101966] ID:68 pID:10918 vID:659
[   16.105456] ID:69 pID:10919 vID:660
[   16.108947] ID:70 pID:10920 vID:661
[   16.112437] ID:71 pID:10921 vID:662
[   16.115928] ID:72 pID:10922 vID:663
[   16.119418] ID:73 pID:10923 vID:664
[   16.122906] ID:74 pID:10924 vID:665
[   16.126398] ID:75 pID:10925 vID:666
[   16.129889] ID:76 pID:10926 vID:667
[   16.133379] ID:77 pID:10927 vID:668
[   16.136869] ID:78 pID:10928 vID:669
[   16.140361] ID:79 pID:10929 vID:670
[   16.143851] ID:80 pID:10930 vID:671
[   16.147339] ID:81 pID:10931 vID:672
[   16.150830] ID:82 pID:10932 vID:673
[   16.154323] ID:83 pID:10933 vID:674
[   16.157814] ID:84 pID:10934 vID:675
[   16.161304] ID:85 pID:10935 vID:676
[   16.164795] ID:86 pID:10936 vID:677
[   16.168286] ID:87 pID:10937 vID:678
[   16.171777] ID:88 pID:10938 vID:679
[   16.175265] ID:89 pID:10939 vID:680
[   16.178756] ID:90 pID:10940 vID:681
[   16.182247] ID:91 pID:10941 vID:682
[   16.185737] ID:92 pID:10942 vID:683
[   16.189228] ID:93 pID:10943 vID:684
[   16.192720] ID:94 pID:10944 vID:685
[   16.196211] ID:95 pID:10945 vID:686
[   16.199701] ID:96 pID:10946 vID:687
[   16.203190] ID:97 pID:10947 vID:688
[   16.206680] ID:98 pID:10948 vID:689
[   16.210171] ID:99 pID:10949 vID:690
[   16.213661] ID:100 pID:10950 vID:691
[   16.217240] ID:101 pID:10951 vID:692
[   16.2 ID:108 pID:10958 vID:699
[   16.245862] ID:109 pID:10959 vID:700
[   16.249439] ID:110 pID:10960 vID:701
[   16.253016] ID:111 pID:10961 vID:702
[   16.256594] ID:112 pID:10962 vID:703
[   16.260175] ID:113 pID:10963 vID:704
[   16.263753] ID:114 pID:10964 vID:705
[   16.267329] ID:115 pID:10965 vID:706
[   16.270908] ID:116 pID:10966 vID:707
[   16.274485] ID:117 pID:10967 vID:708
[   16.278062] ID:118 pID:10968 vID:709
[   16.281640] ID:119 pID:10969 vID:710
[   16.285218] ID:120 pID:10970 vID:711
[   16.288797] ID:121 pID:10971 vID:712
[   16.292375] ID:122 pID:10972 vID:713
[   16.295952] ID:123 pID:10973 vID:714
[   16.299530] ID:124 pID:10974 vID:715
[   16.303106] ID:125 pID:10975 vID:716
[   16.306684] ID:126 pID:10976 vID:717
[   16.310263] ID:127 pID:10977 vID:718
[   16.313841] ID:128 pID:10978 vID:719
[   16.317418] ID:129 pID:10979 vID:720
[   16.320996] ID:130 pID:10980 vID:721
[   16.324575] ID:131 pID:10981 vID:722
[   16.328153] ID:132 pID:10982 vID:723
[   16.331731] ID:133 pID:10983 vID:724
[   16.335306] ID:134 pID:10984 vID:725
[   16.338885] ID:135 pID:10985 vID:726
[   16.342462] ID:136 pID:10986 vID:727
[   16.346039] ID:137 pID:10987 vID:728
[   16.349617] ID:138 pID:10988 vID:729
[   16.353195] ID:139 pID:10989 vID:730
[   16.356773] ID:140 pID:10990 vID:731
[   16.360353] ID:141 pID:10991 vID:732
[   16.363932] ID:142 pID:10992 vID:733
[   16.367509] ID:143 pID:10993 vID:734
[   16.371084] ID:144 pID:10994 vID:735
[   16.374662] ID:145 pID:10995 vID:736
[   16.378241] ID:146 pID:10996 vID:737
[   16.381819] ID:147 pID:10997 vID:738
[   16.385397] ID:148 pID:10998 vID:739
[   16.388974] ID:149 pID:10999 vID:740
[   16.392553] ID:150 pID:11000 vID:741
[   16.396131] ID:151 pID:11001 vID:742
[   16.399708] ID:152 pID:11002 vID:743
[   16.403284] ID:153 pID:11003 vID:744
[   16.406863] ID:154 pID:11004 vID:745
[   16.410440] ID:155 pID:11005 vID:746
[   16.414018] ID:156 pID:11006 vID:747
[   16.417597] ID:157 pID:11007 vID:748
[   16.421174] ID:158 pID:11008 vID:749
[   16.424752] ID:159 pID:11009 vID:750
[   16.428332] ID:160 pID:11010 vID:751
[   16.445517] hclge driver initialization finished.
[   16.476952] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   16.482789] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   16.488735] igb: Intel(R) Gigabit Ethernet Network Driver - version 
5.6.0-k
[   16.495719] igb: Copyright (c) 2007-2014 Intel Corporation.
[   16.501310] igbvf: Intel(R) Gigabit Virtual Function Network Driver - 
version 2.4.0-k
[   16.509128] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[   16.515467] sky2: driver version 1.30
[   16.519884] VFIO - User Level meta-driver version: 0.3
[   16.530163] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[   16.536693] ehci-pci: EHCI PCI platform driver
[   16.541282] ehci-pci 0000:7a:01.0: EHCI Host Controller
[   16.546508] ehci-pci 0000:7a:01.0: new USB bus registered, assigned 
bus number 1
[   16.553928] ehci-pci 0000:7a:01.0: irq 40, io mem 0x20c101000
[   16.575393] ehci-pci 0000:7a:01.0: USB 0.0 started, EHCI 1.00
[   16.581299] hub 1-0:1.0: USB hub found
[   16.585048] hub 1-0:1.0: 2 ports detected
[   16.589277] ehci-pci 0000:ba:01.0: EHCI Host Controller
[   16.594513] ehci-pci 0000:ba:01.0: new USB bus registered, assigned 
bus number 2
[   16.601921] ehci-pci 0000:ba:01.0: irq 40, io mem 0x40020c101000
[   16.623392] ehci-pci 0000:ba:01.0: USB 0.0 started, EHCI 1.00
[   16.629280] hub 2-0:1.0: USB hub found
[   16.633028] hub 2-0:1.0: 2 ports detected
[   16.637176] ehci-platform: EHCI generic platform driver
[   16.642569] ehci-orion: EHCI orion driver
[   16.646671] ehci-exynos: EHCI EXYNOS driver
[   16.650939] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   16.657113] ohci-pci: OHCI PCI platform driver
[   16.661608] ohci-pci 0000:7a:00.0: OHCI PCI host controller
[   16.667179] ohci-pci 0000:7a:00.0: new USB bus registered, assigned 
bus number 3
[   16.674587] ohci-pci 0000:7a:00.0: irq 40, io mem 0x20c100000
[   16.744129] hub 3-0:1.0: USB hub found
[   16.747878] hub 3-0:1.0: 2 ports detected
[   16.752056] ohci-pci 0000:ba:00.0: OHCI PCI host controller
[   16.757635] ohci-pci 0000:ba:00.0: new USB bus registered, assigned 
bus number 4
[   16.765042] ohci-pci 0000:ba:00.0: irq 40, io mem 0x40020c100000
[   16.831597] hub 4-0:1.0: USB hub found
[   16.835338] hub 4-0:1.0: 2 ports detected
[   16.839485] ohci-platform: OHCI generic platform driver
[   16.844811] ohci-exynos: OHCI EXYNOS driver
[   16.849156] xhci_hcd 0000:7a:02.0: xHCI Host Controller
[   16.854379] xhci_hcd 0000:7a:02.0: new USB bus registered, assigned 
bus number 5
[   16.861831] xhci_hcd 0000:7a:02.0: hcc params 0x0220f66d hci version 
0x100 quirks 0x0000000000000010
[   16.871187] ITS: alloc 11106:1
[   16.874233] ITT 1 entries, 0 bits
[   16.877553] ID:0 pID:11106 vID:752
[   16.881160] hub 5-0:1.0: USB hub found
[   16.884909] hub 5-0:1.0: 1 port detected
[   16.888926] xhci_hcd 0000:7a:02.0: xHCI Host Controller
[   16.894147] xhci_hcd 0000:7a:02.0: new USB bus registered, assigned 
bus number 6
[   16.901533] xhci_hcd 0000:7a:02.0: Host supports USB 3.0 SuperSpeed
[   16.907800] usb usb6: We don't know the algorithms for LPM for this 
host, disabling LPM.
[   16.916013] hub 6-0:1.0: USB hub found
[   16.919762] hub 6-0:1.0: 1 port detected
[   16.923818] xhci_hcd 0000:ba:02.0: xHCI Host Controller
[   16.929038] usb 1-1: new high-speed USB device number 2 using ehci-pci
[   16.935568] xhci_hcd 0000:ba:02.0: new USB bus registered, assigned 
bus number 7
[   16.943083] xhci_hcd 0000:ba:02.0: hcc params 0x0220f66d hci version 
0x100 quirks 0x0000000000000010
[   16.952243] ITS: alloc 11107:1
[   16.955290] ITT 1 entries, 0 bits
[   16.958615] ID:0 pID:11107 vID:753
[   16.962214] hub 7-0:1.0: USB hub found
[   16.965964] hub 7-0:1.0: 1 port detected
[   16.969986] xhci_hcd 0000:ba:02.0: xHCI Host Controller
[   16.975215] xhci_hcd 0000:ba:02.0: new USB bus registered, assigned 
bus number 8
[   16.982601] xhci_hcd 0000:ba:02.0: Host supports USB 3.0 SuperSpeed
[   16.988869] usb usb8: We don't know the algorithms for LPM for this 
host, disabling LPM.
[   16.997100] hub 8-0:1.0: USB hub found
[   17.000848] hub 8-0:1.0: 1 port detected
[   17.005168] usbcore: registered new interface driver usb-storage
[   17.053617] rtc-efi rtc-efi: registered as rtc0
[   17.058736] i2c /dev entries driver
[   17.066451] sdhci: Secure Digital Host Controller Interface driver
[   17.072658] sdhci: Copyright(c) Pierre Ossman
[   17.077570] Synopsys Designware Multimedia Card Interface Driver
[   17.084331] sdhci-pltfm: SDHCI platform and OF driver helper
[   17.091194] ledtrig-cpu: registered to indicate activity on CPUs
[   17.098159] usbcore: registered new interface driver usbhid
[   17.103734] usbhid: USB HID core driver
[   17.107955] hub 1-1:1.0: USB hub found
[   17.112664] ID:0 pID:8192 vID:754
[   17.116050] hub 1-1:1.0: 4 ports detected
[   17.120103] ID:0 pID:8224 vID:755
[   17.123511] ID:0 pID:8256 vID:756
[   17.126945] ID:0 pID:8288 vID:757
[   17.130435] ID:0 pID:8320 vID:758
[   17.133845] ID:0 pID:8352 vID:759
[   17.137312] ID:0 pID:8576 vID:760
[   17.140710] ID:0 pID:8608 vID:761
[   17.144105] ID:0 pID:8640 vID:762
[   17.147505] ID:0 pID:8672 vID:763
[   17.150895] ID:0 pID:8704 vID:764
[   17.154287] ID:0 pID:8736 vID:765
[   17.157689] ID:0 pID:8960 vID:766
[   17.161082] ID:0 pID:8992 vID:767
[   17.164472] ID:0 pID:9024 vID:768
[   17.167868] ID:0 pID:9056 vID:769
[   17.171253] ID:0 pID:9088 vID:770
[   17.174651] ID:0 pID:9120 vID:771
[   17.178048] ID:0 pID:9344 vID:772
[   17.181438] ID:0 pID:9376 vID:773
[   17.184833] ID:0 pID:9408 vID:774
[   17.188221] ID:0 pID:9440 vID:775
[   17.191614] ID:0 pID:9472 vID:776
[   17.195012] ID:0 pID:9504 vID:777
[   17.198570] ID:0 pID:8512 vID:778
[   17.201976] ID:0 pID:8544 vID:779
[   17.205658] ID:0 pID:8896 vID:780
[   17.209061] ID:0 pID:8928 vID:781
[   17.212467] ID:0 pID:9280 vID:782
[   17.215873] ID:0 pID:9312 vID:783
[   17.219275] ID:0 pID:9664 vID:784
[   17.222680] ID:0 pID:9696 vID:785
[   17.226229] ID:0 pID:8384 vID:786
[   17.229621] ID:0 pID:8416 vID:787
[   17.233012] ID:0 pID:8448 vID:788
[   17.236395] ID:0 pID:8480 vID:789
[   17.239812] ID:0 pID:8768 vID:790
[   17.243218] ID:0 pID:8800 vID:791
[   17.246629] ID:0 pID:8832 vID:792
[   17.250030] ID:0 pID:8864 vID:793
[   17.253443] ID:0 pID:9152 vID:794
[   17.256830] ID:0 pID:9184 vID:795
[   17.260223] ID:0 pID:9216 vID:796
[   17.263537] usb 1-2: new high-speed USB device number 3 using ehci-pci
[   17.270136] ID:0 pID:9248 vID:797
[   17.273535] ID:0 pID:9536 vID:798
[   17.276952] ID:0 pID:9568 vID:799
[   17.280339] ID:0 pID:9600 vID:800
[   17.283733] ID:0 pID:9632 vID:801
[   17.288757] NET: Registered protocol family 17
[   17.293260] 9pnet: Installing 9P2000 support
[   17.297544] Key type dns_resolver registered
[   17.301989] registered taskstats version 1
[   17.306076] Loading compiled-in X.509 certificates
[   17.315288] pcieport 0000:00:00.0: Adding to iommu group 7
[   17.320881] ITS: alloc 11108:32
[   17.324019] ITT 32 entries, 5 bits
[   17.327665] ID:0 pID:11108 vID:802
[   17.331053] ID:1 pID:11109 vID:803
[   17.334445] ID:2 pID:11110 vID:804
[   17.337835] ID:3 pID:11111 vID:805
[   17.341226] ID:4 pID:11112 vID:806
[   17.344802] ID:5 pID:11113 vID:807
[   17.348193] ID:6 pID:11114 vID:808
[   17.351583] ID:7 pID:11115 vID:809
[   17.354972] ID:8 pID:11116 vID:810
[   17.358362] ID:9 pID:11117 vID:811
[   17.361752] ID:10 pID:11118 vID:812
[   17.365229] ID:11 pID:11119 vID:813
[   17.368706] ID:12 pID:11120 vID:814
[   17.372183] ID:13 pID:11121 vID:815
[   17.375659] ID:14 pID:11122 vID:816
[   17.379135] ID:15 pID:11123 vID:817
[   17.382612] ID:16 pID:11124 vID:818
[   17.386088] ID:17 pID:11125 vID:819
[   17.389565] ID:18 pID:11126 vID:820
[   17.393042] ID:19 pID:11127 vID:821
[   17.396519] ID:20 pID:11128 vID:822
[   17.399996] ID:21 pID:11129 vID:823
[   17.403480] ID:22 pID:11130 vID:824
[   17.406966] ID:23 pID:11131 vID:825
[   17.410446] ID:24 pID:11132 vID:826
[   17.413931] ID:25 pID:11133 vID:827
[   17.417408] ID:26 pID:11134 vID:828
[   17.420886] ID:27 pID:11135 vID:829
[   17.424362] ID:28 pID:11136 vID:830
[   17.427839] ID:29 pID:11137 vID:831
[   17.431315] ID:30 pID:11138 vID:832
[   17.434797] ID:31 pID:11139 vID:833
[   17.438700] hub 1-2:1.0: USB hub found
[   17.442460] ITS: alloc 11108:32
[   17.445601] ITT 32 entries, 5 bits
[   17.449020] hub 1-2:1.0: 4 ports detected
[   17.453032] ID:0 pID:11108 vID:802
[   17.456553] pcieport 0000:00:04.0: Adding to iommu group 8
[   17.462159] ITS: alloc 11140:32
[   17.465303] ITT 32 entries, 5 bits
[   17.469019] ID:0 pID:11140 vID:803
[   17.472422] ID:1 pID:11141 vID:804
[   17.475821] ID:2 pID:11142 vID:805
[   17.479255] ID:3 pID:11143 vID:806
[   17.482646] ID:4 pID:11144 vID:807
[   17.486037] ID:5 pID:11145 vID:808
[   17.489428] ID:6 pID:11146 vID:809
[   17.492822] ID:7 pID:11147 vID:810
[   17.496215] ID:8 pID:11148 vID:811
[   17.499605] ID:9 pID:11149 vID:812
[   17.502993] ID:10 pID:11150 vID:813
[   17.506470] ID:11 pID:11151 vID:814
[   17.509947] ID:12 pID:11152 vID:815
[   17.513425] ID:13 pID:11153 vID:816
[   17.516902] ID:14 pID:11154 vID:817
[   17.520378] ID:15 pID:11155 vID:818
[   17.523855] ID:16 pID:11156 vID:819
[   17.527330] ID:17 pID:11157 vID:820
[   17.530807] ID:18 pID:11158 vID:821
[   17.534284] ID:19 pID:11159 vID:822
[   17.537761] ID:20 pID:11160 vID:823
[   17.541237] ID:21 pID:11161 vID:824
[   17.544714] ID:22 pID:11162 vID:825
[   17.548191] ID:23 pID:11163 vID:826
[   17.551667] ID:24 pID:11164 vID:827
[   17.555142] ID:25 pID:11165 vID:828
[   17.558619] ID:26 pID:11166 vID:829
[   17.562095] ID:27 pID:11167 vID:830
[   17.565572] ID:28 pID:11168 vID:831
[   17.569049] ID:29 pID:11169 vID:832
[   17.572526] ID:30 pID:11170 vID:833
[   17.576002] ID:31 pID:11171 vID:834
[   17.579852] ITS: alloc 11140:1
[   17.582905] ITT 1 entries, 0 bits
[   17.586234] ID:0 pID:11140 vID:803
[   17.589747] pcieport 0000:00:08.0: Adding to iommu group 9
[   17.595375] ITS: alloc 11141:32
[   17.598512] ITT 32 entries, 5 bits
[   17.602130] ID:0 pID:11141 vID:804
[   17.605522] ID:1 pID:11142 vID:805
[   17.608912] ID:2 pID:11143 vID:806
[   17.612303] ID:3 pID:11144 vID:807
[   17.615694] ID:4 pID:11145 vID:808
[   17.619082] ID:5 pID:11146 vID:809
[   17.622472] ID:6 pID:11147 vID:810
[   17.625862] ID:7 pID:11148 vID:811
[   17.629252] ID:8 pID:11149 vID:812
[   17.632643] ID:9 pID:11150 vID:813
[   17.636033] ID:10 pID:11151 vID:814
[   17.639509] ID:11 pID:11152 vID:815
[   17.642985] ID:12 pID:11153 vID:816
[   17.646462] ID:13 pID:11154 vID:817
[   17.649938] ID:14 pID:11155 vID:818
[   17.653415] ID:15 pID:11156 vID:819
[   17.656892] ID:16 pID:11157 vID:820
[   17.660369] ID:17 pID:11158 vID:821
[   17.663846] ID:18 pID:11159 vID:822
[   17.667321] ID:19 pID:11160 vID:823
[   17.670798] ID:20 pID:11161 vID:824
[   17.674275] ID:21 pID:11162 vID:825
[   17.677752] ID:22 pID:11163 vID:826
[   17.681229] ID:23 pID:11164 vID:827
[   17.684706] ID:24 pID:11165 vID:828
[   17.688192] ID:25 pID:11166 vID:829
[   17.691669] ID:26 pID:11167 vID:830
[   17.695144] ID:27 pID:11168 vID:831
[   17.698621] ID:28 pID:11169 vID:832
[   17.702097] ID:29 pID:11170 vID:833
[   17.705574] ID:30 pID:11171 vID:834
[   17.709051] ID:31 pID:11172 vID:835
[   17.712855] ITS: alloc 11141:1
[   17.715906] ITT 1 entries, 0 bits
[   17.719218] ID:0 pID:11141 vID:804
[   17.722724] pcieport 0000:00:0c.0: Adding to iommu group 10
[   17.732481] ITS: alloc 11142:32
[   17.735618] ITT 32 entries, 5 bits
[   17.739241] ID:0 pID:11142 vID:805
[   17.742634] ID:1 pID:11143 vID:806
[   17.746029] ID:2 pID:11144 vID:807
[   17.749432] ID:3 pID:11145 vID:808
[   17.752832] ID:4 pID:11146 vID:809
[   17.756229] ID:5 pID:11147 vID:810
[   17.759620] ID:6 pID:11148 vID:811
[   17.763008] ID:7 pID:11149 vID:812
[   17.766399] ID:8 pID:11150 vID:813
[   17.769792] ID:9 pID:11151 vID:814
[   17.773185] ID:10 pID:11152 vID:815
[   17.776662] ID:11 pID:11153 vID:816
[   17.780139] ID:12 pID:11154 vID:817
[   17.783616] ID:13 pID:11155 vID:818
[   17.787091] ID:14 pID:11156 vID:819
[   17.790569] ID:15 pID:11157 vID:820
[   17.794045] ID:16 pID:11158 vID:821
[   17.797522] ID:17 pID:11159 vID:822
[   17.800999] ID:18 pID:11160 vID:823
[   17.804476] ID:19 pID:11161 vID:824
[   17.807953] ID:20 pID:11162 vID:825
[   17.811430] ID:21 pID:11163 vID:826
[   17.814905] ID:22 pID:11164 vID:827
[   17.818385] usb 1-2.1: new full-speed USB device number 4 using ehci-pci
[   17.825075] ID:23 pID:11165 vID:828
[   17.828552] ID:24 pID:11166 vID:829
[   17.832034] ID:25 pID:11167 vID:830
[   17.835514] ID:26 pID:11168 vID:831
[   17.838990] ID:27 pID:11169 vID:832
[   17.842466] ID:28 pID:11170 vID:833
[   17.845943] ID:29 pID:11171 vID:834
[   17.849421] ID:30 pID:11172 vID:835
[   17.852897] ID:31 pID:11173 vID:836
[   17.856715] ITS: alloc 11142:1
[   17.859766] ITT 1 entries, 0 bits
[   17.863078] ID:0 pID:11142 vID:805
[   17.866586] pcieport 0000:00:10.0: Adding to iommu group 11
[   17.872303] ITS: alloc 11143:32
[   17.875437] ITT 32 entries, 5 bits
[   17.879057] ID:0 pID:11143 vID:806
[   17.882449] ID:1 pID:11144 vID:807
[   17.885839] ID:2 pID:11145 vID:808
[   17.889229] ID:3 pID:11146 vID:809
[   17.892625] ID:4 pID:11147 vID:810
[   17.896016] ID:5 pID:11148 vID:811
[   17.899406] ID:6 pID:11149 vID:812
[   17.902794] ID:7 pID:11150 vID:813
[   17.906184] ID:8 pID:11151 vID:814
[   17.909574] ID:9 pID:11152 vID:815
[   17.912964] ID:10 pID:11153 vID:816
[   17.916441] ID:11 pID:11154 vID:817
[   17.919918] ID:12 pID:11155 vID:818
[   17.923394] ID:13 pID:11156 vID:819
[   17.926870] ID:14 pID:11157 vID:820
[   17.930347] ID:15 pID:11158 vID:821
[   17.933824] ID:16 pID:11159 vID:822
[   17.937300] ID:17 pID:11160 vID:823
[   17.940777] ID:18 pID:11161 vID:824
[   17.944254] ID:19 pID:11162 vID:825
[   17.947731] ID:20 pID:11163 vID:826
[   17.951206] ID:21 pID:11164 vID:827
[   17.954683] ID:22 pID:11165 vID:828
[   17.958159] ID:23 pID:11166 vID:829
[   17.961636] ID:24 pID:11167 vID:830
[   17.965113] ID:25 pID:11168 vID:831
[   17.968590] ID:26 pID:11169 vID:832
[   17.972066] ID:27 pID:11170 vID:833
[   17.975543] ID:28 pID:11171 vID:834
[   17.979018] ID:29 pID:11172 vID:835
[   17.982495] ID:30 pID:11173 vID:836
[   17.985971] ID:31 pID:11174 vID:837
[   17.989788] ITS: alloc 11143:1
[   17.992841] ITT 1 entries, 0 bits
[   17.996159] ID:0 pID:11143 vID:806
[   17.999679] pcieport 0000:00:12.0: Adding to iommu group 12
[   18.005373] ITS: alloc 11144:32
[   18.008507] ITT 32 entries, 5 bits
[   18.012129] ID:0 pID:11144 vID:807
[   18.015521] ID:1 pID:11145 vID:808
[   18.018910] ID:2 pID:11146 vID:809
[   18.022299] ID:3 pID:11147 vID:810
[   18.025694] ID:4 pID:11148 vID:811
[   18.029085] ID:5 pID:11149 vID:812
[   18.032475] ID:6 pID:11150 vID:813
[   18.035865] ID:7 pID:11151 vID:814
[   18.039253] ID:8 pID:11152 vID:815
[   18.042643] ID:9 pID:11153 vID:816
[   18.046033] ID:10 pID:11154 vID:817
[   18.049510] ID:11 pID:11155 vID:818
[   18.052987] ID:12 pID:11156 vID:819
[   18.056464] ID:13 pID:11157 vID:820
[   18.059941] ID:14 pID:11158 vID:821
[   18.063418] ID:15 pID:11159 vID:822
[   18.066893] ID:16 pID:11160 vID:823
[   18.070369] ID:17 pID:11161 vID:824
[   18.073846] ID:18 pID:11162 vID:825
[   18.077323] ID:19 pID:11163 vID:826
[   18.080800] ID:20 pID:11164 vID:827
[   18.084277] ID:21 pID:11165 vID:828
[   18.087754] ID:22 pID:11166 vID:829
[   18.091229] ID:23 pID:11167 vID:830
[   18.094707] ID:24 pID:11168 vID:831
[   18.098184] ID:25 pID:11169 vID:832
[   18.101661] ID:26 pID:11170 vID:833
[   18.105137] ID:27 pID:11171 vID:834
[   18.108614] ID:28 pID:11172 vID:835
[   18.112091] ID:29 pID:11173 vID:836
[   18.115568] ID:30 pID:11174 vID:837
[   18.119043] ID:31 pID:11175 vID:838
[   18.122857] ITS: alloc 11144:1
[   18.125908] ITT 1 entries, 0 bits
[   18.129226] ID:0 pID:11144 vID:807
[   18.132803] pcieport 0000:7c:00.0: Adding to iommu group 13
[   18.138478] pcieport 0000:74:00.0: Adding to iommu group 14
[   18.144182] pcieport 0000:80:00.0: Adding to iommu group 15
[   18.149854] ITS: alloc 11145:32
[   18.152988] ITT 32 entries, 5 bits
[   18.156768] ID:0 pID:11145 vID:808
[   18.160160] ID:1 pID:11146 vID:809
[   18.163550] ID:2 pID:11147 vID:810
[   18.166938] ID:3 pID:11148 vID:811
[   18.170328] ID:4 pID:11149 vID:812
[   18.173718] ID:5 pID:11150 vID:813
[   18.177108] ID:6 pID:11151 vID:814
[   18.180498] ID:7 pID:11152 vID:815
[   18.183888] ID:8 pID:11153 vID:816
[   18.187277] ID:9 pID:11154 vID:817
[   18.190666] ID:10 pID:11155 vID:818
[   18.194143] ID:11 pID:11156 vID:819
[   18.197621] ID:12 pID:11157 vID:820
[   18.201098] ID:13 pID:11158 vID:821
[   18.204575] ID:14 pID:11159 vID:822
[   18.208052] ID:15 pID:11160 vID:823
[   18.211529] ID:16 pID:11161 vID:824
[   18.215004] ID:17 pID:11162 vID:825
[   18.218480] ID:18 pID:11163 vID:826
[   18.221957] ID:19 pID:11164 vID:827
[   18.225434] ID:20 pID:11165 vID:828
[   18.228910] ID:21 pID:11166 vID:829
[   18.232387] ID:22 pID:11167 vID:830
[   18.235864] ID:23 pID:11168 vID:831
[   18.239339] ID:24 pID:11169 vID:832
[   18.242816] ID:25 pID:11170 vID:833
[   18.246293] ID:26 pID:11171 vID:834
[   18.249770] ID:27 pID:11172 vID:835
[   18.253247] ID:28 pID:11173 vID:836
[   18.256725] ID:29 pID:11174 vID:837
[   18.260202] ID:30 pID:11175 vID:838
[   18.263678] ID:31 pID:11176 vID:839
[   18.267539] ITS: alloc 11145:1
[   18.270582] ITT 1 entries, 0 bits
[   18.273908] ID:0 pID:11145 vID:808
[   18.277445] pcieport 0000:80:08.0: Adding to iommu group 16
[   18.283114] ITS: alloc 11146:32
[   18.286247] ITT 32 entries, 5 bits
[   18.289999] ID:0 pID:11146 vID:809
[   18.293391] ID:1 pID:11147 vID:810
[   18.296782] ID:2 pID:11148 vID:811
[   18.300173] ID:3 pID:11149 vID:812
[   18.303563] ID:4 pID:11150 vID:813
[   18.306951] ID:5 pID:11151 vID:814
[   18.310341] ID:6 pID:11152 vID:815
[   18.313731] ID:7 pID:11153 vID:816
[   18.317121] ID:8 pID:11154 vID:817
[   18.320511] ID:9 pID:11155 vID:818
[   18.323901] ID:10 pID:11156 vID:819
[   18.327376] ID:11 pID:11157 vID:820
[   18.330853] ID:12 pID:11158 vID:821
[   18.334330] ID:13 pID:11159 vID:822
[   18.337807] ID:14 pID:11160 vID:823
[   18.341283] ID:15 pID:11161 vID:824
[   18.344760] ID:16 pID:11162 vID:825
[   18.348237] ID:17 pID:11163 vID:826
[   18.351714] ID:18 pID:11164 vID:827
[   18.355189] ID:19 pID:11165 vID:828
[   18.358666] ID:20 pID:11166 vID:829
[   18.362143] ID:21 pID:11167 vID:830
[   18.365619] ID:22 pID:11168 vID:831
[   18.369096] ID:23 pID:11169 vID:832
[   18.372573] ID:24 pID:11170 vID:833
[   18.376050] ID:25 pID:11171 vID:834
[   18.379527] ID:26 pID:11172 vID:835
[   18.383002] ID:27 pID:11173 vID:836
[   18.386479] ID:28 pID:11174 vID:837
[   18.389956] ID:29 pID:11175 vID:838
[   18.393432] ID:30 pID:11176 vID:839
[   18.396909] ID:31 pID:11177 vID:840
[   18.400756] ITS: alloc 11146:1
[   18.403808] ITT 1 entries, 0 bits
[   18.407125] ID:0 pID:11146 vID:809
[   18.410628] pcieport 0000:80:0c.0: Adding to iommu group 17
[   18.416330] ITS: alloc 11147:32
[   18.419463] ITT 32 entries, 5 bits
[   18.423214] ID:0 pID:11147 vID:810
[   18.426606] ID:1 pID:11148 vID:811
[   18.429996] ID:2 pID:11149 vID:812
[   18.433386] ID:3 pID:11150 vID:813
[   18.436776] ID:4 pID:11151 vID:814
[   18.440167] ID:5 pID:11152 vID:815
[   18.443557] ID:6 pID:11153 vID:816
[   18.446945] ID:7 pID:11154 vID:817
[   18.450335] ID:8 pID:11155 vID:818
[   18.453725] ID:9 pID:11156 vID:819
[   18.457115] ID:10 pID:11157 vID:820
[   18.460592] ID:11 pID:11158 vID:821
[   18.464069] ID:12 pID:11159 vID:822
[   18.467545] ID:13 pID:11160 vID:823
[   18.471020] ID:14 pID:11161 vID:824
[   18.474497] ID:15 pID:11162 vID:825
[   18.477975] ID:16 pID:11163 vID:826
[   18.481451] ID:17 pID:11164 vID:827
[   18.484928] ID:18 pID:11165 vID:828
[   18.488405] ID:19 pID:11166 vID:829
[   18.491882] ID:20 pID:11167 vID:830
[   18.495357] ID:21 pID:11168 vID:831
[   18.498834] ID:22 pID:11169 vID:832
[   18.502312] ID:23 pID:11170 vID:833
[   18.505788] ID:24 pID:11171 vID:834
[   18.509283] ID:25 pID:11172 vID:835
[   18.512760] ID:26 pID:11173 vID:836
[   18.516236] ID:27 pID:11174 vID:837
[   18.519713] ID:28 pID:11175 vID:838
[   18.523188] ID:29 pID:11176 vID:839
[   18.526665] ID:30 pID:11177 vID:840
[   18.530142] ID:31 pID:11178 vID:841
[   18.533993] ITS: alloc 11147:1
[   18.537044] ITT 1 entries, 0 bits
[   18.540371] ID:0 pID:11147 vID:810
[   18.543904] pcieport 0000:80:10.0: Adding to iommu group 18
[   18.549572] ITS: alloc 11148:32
[   18.552706] ITT 32 entries, 5 bits
[   18.556459] ID:0 pID:11148 vID:811
[   18.559850] ID:1 pID:11149 vID:812
[   18.563238] ID:2 pID:11150 vID:813
[   18.566628] ID:3 pID:11151 vID:814
[   18.570018] ID:4 pID:11152 vID:815
[   18.573408] ID:5 pID:11153 vID:816
[   18.576798] ID:6 pID:11154 vID:817
[   18.580188] ID:7 pID:11155 vID:818
[   18.583578] ID:8 pID:11156 vID:819
[   18.586966] ID:9 pID:11157 vID:820
[   18.590356] ID:10 pID:11158 vID:821
[   18.593833] ID:11 pID:11159 vID:822
[   18.597310] ID:12 pID:11160 vID:823
[   18.600787] ID:13 pID:11161 vID:824
[   18.604265] ID:14 pID:11162 vID:825
[   18.607742] ID:15 pID:11163 vID:826
[   18.611217] ID:16 pID:11164 vID:827
[   18.614693] ID:17 pID:11165 vID:828
[   18.618170] ID:18 pID:11166 vID:829
[   18.621647] ID:19 pID:11167 vID:830
[   18.625124] ID:20 pID:11168 vID:831
[   18.628601] ID:21 pID:11169 vID:832
[   18.632077] ID:22 pID:11170 vID:833
[   18.635554] ID:23 pID:11171 vID:834
[   18.639029] ID:24 pID:11172 vID:835
[   18.642506] ID:25 pID:11173 vID:836
[   18.645983] ID:26 pID:11174 vID:837
[   18.649460] ID:27 pID:11175 vID:838
[   18.652937] ID:28 pID:11176 vID:839
[   18.656413] ID:29 pID:11177 vID:840
[   18.659890] ID:30 pID:11178 vID:841
[   18.663365] ID:31 pID:11179 vID:842
[   18.667215] ITS: alloc 11148:1
[   18.670267] ITT 1 entries, 0 bits
[   18.673590] ID:0 pID:11148 vID:811
[   18.677169] pcieport 0000:bc:00.0: Adding to iommu group 19
[   18.682875] pcieport 0000:b4:00.0: Adding to iommu group 20
[   18.708785] rtc-efi rtc-efi: setting system clock to 
2019-09-05T09:29:04 UTC (1567675744)
[   18.716978] ALSA device list:
[   18.719942]   No soundcards found.
[   18.724662] Freeing unused kernel memory: 4992K
[   18.729329] Run /init as init process
root@(none)$ [   22.971811] input: Keyboard/Mouse KVM 1.1.0 as 
/devices/pci0000:7a/0000:7a:01.0/usb1/1-2/1-2.1/1-2.1:1.0/0003:12D1:0003.0001/input/input1
[   23.043528] hid-generic 0003:12D1:0003.0001: input: USB HID v1.10 
Keyboard [Keyboard/Mouse KVM 1.1.0] on usb-0000:7a:01.0-2.1/input0
[   23.056251] input: Keyboard/Mouse KVM 1.1.0 as 
/devices/pci0000:7a/0000:7a:01.0/usb1/1-2/1-2.1/1-2.1:1.1/0003:12D1:0003.0002/input/input2
[   23.068621] hid-generic 0003:12D1:0003.0002: input: USB HID v1.10 
Mouse [Keyboard/Mouse KVM 1.1.0] on usb-0000:7a:01.0-2.1/input1

unbindnone)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/
[   35.711506] sas: REVALIDATING DOMAIN on port 0, pid:156
[   35.718016] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   35.723318] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   35.729758] sas: REVALIDATING DOMAIN on port 0, pid:156
[   35.736212] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   35.741518] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   35.747955] sas: REVALIDATING DOMAIN on port 0, pid:156
[   35.754415] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   35.759715] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   35.766155] sas: REVALIDATING DOMAIN on port 0, pid:156
[   35.772596] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   35.777897] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   35.784334] sas: REVALIDATING DOMAIN on port 0, pid:156
[   35.790803] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   35.796103] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   35.802539] sas: REVALIDATING DOMAIN on port 0, pid:156
[   35.808986] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   35.814286] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   35.820723] sas: REVALIDATING DOMAIN on port 0, pid:156
[   35.827174] sas: ex 500e004aaaaaaa1f phys DID NOT change
[   35.832475] sas: done REVALIDATING DOMAIN on port 0, pid:156, res 0x0
[   35.839308] hisi_sas_v3_hw 0000:74:02.0: dev[6:1] is gone
[   35.845201] sd 0:0:3:0: [sdd] Synchronizing SCSI cache
[   35.903748] hisi_sas_v3_hw 0000:74:02.0: dev[5:1] is gone
[   35.909641] sd 0:0:2:0: [sdc] Synchronizing SCSI cache
[   35.914855] sd 0:0:2:0: [sdc] Stopping disk
[   36.431750] hisi_sas_v3_hw 0000:74:02.0: dev[4:5] is gone
[   36.437723] sd 0:0:1:0: [sdb] Synchronizing SCSI cache
[   36.483740] hisi_sas_v3_hw 0000:74:02.0: dev[3:1] is gone
[   36.489552] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   36.523726] hisi_sas_v3_hw 0000:74:02.0: dev[2:1] is gone
[   36.531410] hisi_sas_v3_hw 0000:74:02.0: dev[1:2] is gone
root@(none)$
bindnone)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/u
[   41.110557] scsi host0: hisi_sas_v3_hw
[   42.335455] Reusing ITT for devID 7410
[   42.359151] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2
sh: echo: write error: No such device
root@(none)$


