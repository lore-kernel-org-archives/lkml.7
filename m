Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805DFC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ABE72133F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfGDHFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:05:33 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8139 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726199AbfGDHFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:05:32 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 72B0FF963BC358DAD446;
        Thu,  4 Jul 2019 15:05:30 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.137) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 4 Jul 2019
 15:05:29 +0800
Subject: Re: [PATCH] percpu: Make pcpu_setup_first_chunk() void function
To:     Dennis Zhou <dennis@kernel.org>
CC:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Andrey Ryabinin <a.ryabinin@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190703082552.69951-1-wangkefeng.wang@huawei.com>
 <20190704042053.GA29349@dennisz-mbp.dhcp.thefacebook.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <bcc00d6f-6258-aaf6-023b-fb4fb1f55ed9@huawei.com>
Date:   Thu, 4 Jul 2019 15:05:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704042053.GA29349@dennisz-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.217.137]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/7/4 12:20, Dennis Zhou wrote:
> On Wed, Jul 03, 2019 at 04:25:52PM +0800, Kefeng Wang wrote:
>> pcpu_setup_first_chunk() will panic or BUG_ON if the are some
>> error and doesn't return any error, hence it can be defined to
>> return void.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> ---
...
>>
> 
> Hi Kefeng,
> 
> This makes sense to me. I've applied this to for-5.4.

Hi Dennis and all,

There is an issue when with percpu_alloc=page + KASAN.

The system boot successfully with defconfig when using percpu_alloc=embed(default configuration),
but when enabled KASAN(CONFIG_KASAN=y/CONFIG_KASAN_GENERIC=y/CONFIG_KASAN_OUTLINE=y), it triggers
"PANIC: double fault, error_code: 0x0", and I try some different kernel version, eg, 4.14/4.19/5.0,
all of them won't boot, I can't find any clue, could you or anyone provide some advice, thanks.

Here is log,

Booting the kernel.
[    0.000000] Linux version 5.2.0-rc7+ (root@ubuntu) (gcc version 7.4.0 (Ubuntu 7.4.0-1ubuntu1~18.04.1)) #10 SMP Thu Jul 4 11:58:45 HKT 2019
[    0.000000] Command line: kmemleak=off console=ttyS0 root=/dev/sda  earlyprintk=serial  percpu_alloc=page
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bffdefff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bffdf000-0x00000000bfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000043fffffff] usable
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[    0.000000] last_pfn = 0x440000 max_arch_pfn = 0x400000000
[    0.000000] x86/PAT: PAT not supported by CPU.
[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
[    0.000000] last_pfn = 0xbffdf max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000f6a10-0x000f6a1f]
[    0.000000] check: Scanning 1 areas for low memory corruption
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F69C0 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x00000000BFFE169F 000034 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x00000000BFFE1323 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x00000000BFFDFC80 0016A3 (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACS 0x00000000BFFDFC40 000040
[    0.000000] ACPI: APIC 0x00000000BFFE1417 0000B0 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x00000000BFFE14C7 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.000000] ACPI: SRAT 0x00000000BFFE14FF 0001A0 (v01 BOCHS  BXPCSRAT 00000001 BXPC 00000001)
[    0.000000] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x02 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x03 -> Node 1
[    0.000000] SRAT: PXM 2 -> APIC 0x04 -> Node 2
[    0.000000] SRAT: PXM 2 -> APIC 0x05 -> Node 2
[    0.000000] SRAT: PXM 3 -> APIC 0x06 -> Node 3
[    0.000000] SRAT: PXM 3 -> APIC 0x07 -> Node 3
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x13fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x140000000-0x23fffffff]
[    0.000000] ACPI: SRAT: Node 2 PXM 2 [mem 0x240000000-0x33fffffff]
[    0.000000] ACPI: SRAT: Node 3 PXM 3 [mem 0x340000000-0x43fffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000-0xbfffffff] -> [mem 0x00000000-0xbfffffff]
[    0.000000] NUMA: Node 0 [mem 0x00000000-0xbfffffff] + [mem 0x100000000-0x13fffffff] -> [mem 0x00000000-0x13fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x13fffc000-0x13fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x23fffc000-0x23fffffff]
[    0.000000] NODE_DATA(2) allocated [mem 0x33fffc000-0x33fffffff]
[    0.000000] NODE_DATA(3) allocated [mem 0x43fff5000-0x43fff8fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000043fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bffdefff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000013fffffff]
[    0.000000]   node   1: [mem 0x0000000140000000-0x000000023fffffff]
[    0.000000]   node   2: [mem 0x0000000240000000-0x000000033fffffff]
[    0.000000]   node   3: [mem 0x0000000340000000-0x000000043fffffff]
[    0.000000] Zeroed struct page in unavailable ranges: 131 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000013fffffff]
[    0.000000] Initmem setup node 1 [mem 0x0000000140000000-0x000000023fffffff]
[    0.000000] Initmem setup node 2 [mem 0x0000000240000000-0x000000033fffffff]
[    0.000000] Initmem setup node 3 [mem 0x0000000340000000-0x000000043fffffff]
[    0.000000] kasan: KernelAddressSanitizer initialized
[    0.000000] ACPI: PM-Timer IO Port: 0x608
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbffdf000-0xbfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xc0000000-0xfeffbfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfeffc000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xfffbffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfffc0000-0xffffffff]
[    0.000000] [mem 0xc0000000-0xfeffbfff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:8 nr_node_ids:4
[    0.000000] percpu: 56 4K pages/cpu s208152 r8192 d13032
[    0.000000] Built 4 zonelists, mobility grouping on.  Total pages: 4128616
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: kmemleak=off console=ttyS0 root=/dev/sda  earlyprintk=serial  percpu_alloc=page
[    0.000000] Memory: 14289792K/16776692K available (20484K kernel code, 5398K rwdata, 5824K rodata, 1620K init, 9432K bss, 2486900K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=8, Nodes=4
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=8.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
[    0.000000] NR_IRQS: 4352, nr_irqs: 488, preallocated irqs: 16
[    0.000000] random: get_random_bytes called from start_kernel+0x322/0x595 with crng_init=0
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] printk: console [ttyS0] enabled
[    0.000000] printk: console [ttyS0] enabled
[    0.000000] printk: bootconsole [earlyser0] disabled
[    0.000000] printk: bootconsole [earlyser0] disabled
[    0.000000] ACPI: Core revision 20190509
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.000000] PANIC: double fault, error_code: 0x0
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc7+ #10
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[    0.000000] RIP: 0010:no_context+0x33/0x6f0
[    0.000000] Code: 00 00 fc ff df 41 55 41 54 4c 8d bf 88 00 00 00 55 53 48 89 fd 4c 89 ff 49 89 f4 49 89 d6 48 81 ec 50 01 00 00 48 8d 5c 24 30 <89> 0c 24 44 89 44 24 08 48 c7 44 24 30 b3 8a b5 41 48 c7 44 24 38
[    0.000000] RSP: 0000:ffffc8ffffffff50 EFLAGS: 00010086
[    0.000000] RAX: dffffc0000000000 RBX: ffffc8ffffffff80 RCX: 000000000000000b
[    0.000000] RDX: fffff52000000036 RSI: 0000000000000003 RDI: ffffc90000000160
[    0.000000] RBP: ffffc900000000d8 R08: 0000000000000001 R09: 0000000000000000
[    0.000000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[    0.000000] R13: 0000000000000000 R14: fffff52000000036 R15: ffffc90000000160
[    0.000000] FS:  0000000000000000(0000) GS:ffffc90000000000(0000) knlGS:0000000000000000
[    0.000000] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.000000] CR2: ffffc8ffffffff48 CR3: 000000042580e000 CR4: 00000000000006b0
[    0.000000] Call Trace:
[    0.000000] Kernel panic - not syncing: Machine halted.
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.2.0-rc7+ #10
[    0.000000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
[    0.000000] Call Trace:
[    0.000000]  <#DF>
[    0.000000]  dump_stack+0x5b/0x8b
[    0.000000]  panic+0x183/0x384
[    0.000000]  ? refcount_error_report+0x11c/0x11c
[    0.000000]  df_debug+0x29/0x30
[    0.000000]  do_double_fault+0xb6/0x160
[    0.000000]  double_fault+0x1e/0x30
[    0.000000] RIP: 0010:no_context+0x33/0x6f0
[    0.000000] Code: 00 00 fc ff df 41 55 41 54 4c 8d bf 88 00 00 00 55 53 48 89 fd 4c 89 ff 49 89 f4 49 89 d6 48 81 ec 50 01 00 00 48 8d 5c 24 30 <89> 0c 24 44 89 44 24 08 48 c7 44 24 30 b3 8a b5 41 48 c7 44 24 38
[    0.000000] RSP: 0000:ffffc8ffffffff50 EFLAGS: 00010086
[    0.000000] RAX: dffffc0000000000 RBX: ffffc8ffffffff80 RCX: 000000000000000b
[    0.000000] RDX: fffff52000000036 RSI: 0000000000000003 RDI: ffffc90000000160
[    0.000000] RBP: ffffc900000000d8 R08: 0000000000000001 R09: 0000000000000000
[    0.000000] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[    0.000000] R13: 0000000000000000 R14: fffff52000000036 R15: ffffc90000000160
[    0.000000]  </#DF>
[    0.000000] ---[ end Kernel panic - not syncing: Machine halted. ]---




> 
> Thanks,
> Dennis
> 
> .
> 

