Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642E5C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B322068E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfLIUqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:46:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:35364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726602AbfLIUqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:46:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EEF32AC69;
        Mon,  9 Dec 2019 20:46:33 +0000 (UTC)
Date:   Mon, 9 Dec 2019 21:46:32 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christopher Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: lockdep warns: cpu_hotplug_lock.rw_sem --> slab_mutex -->
 kn->count#39
Message-ID: <20191209204632.y6vgxedbrzcjkv2i@beryllium.lan>
References: <20191209182418.7vxer6vmre67ewvt@beryllium.lan>
 <alpine.DEB.2.21.1912092029080.6020@www.lameter.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1912092029080.6020@www.lameter.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 08:33:13PM +0000, Christopher Lameter wrote:
> On Mon, 9 Dec 2019, Daniel Wagner wrote:
> 
> > [    5.038862]
> > [    5.038862] -> #2 (kn->count#39){++++}:
> > [    5.039329]        __kernfs_remove+0x240/0x2e0
> > [    5.039717]        kernfs_remove_by_name_ns+0x3c/0x80
> > [    5.040159]        sysfs_slab_add+0x184/0x250
> 
> sysfs_slab_add should not be called under any lock. But it happens during
> an initcall (sysfs_slab_init) when the kmalloc slab array is being set up.
> 
> And the problems results from a hotplug event?

I don't think there was an hotplug event except the boot process.

> During system bringup when the slab caches have not been setup yet?

Let me attach the full log below.

> Is this really something that can happen?

I really don't know. There is one comment in the code which ponders
about the same issue:


static ssize_t show_slab_objects(struct kmem_cache *s,
			    char *buf, unsigned long flags)
{
[...]
	/*
	 * It is impossible to take "mem_hotplug_lock" here with "kernfs_mutex"
	 * already held which will conflict with an existing lock order:
	 *
	 * mem_hotplug_lock->slab_mutex->kernfs_mutex
	 *
	 * We don't really need mem_hotplug_lock (to hold off
	 * slab_mem_going_offline_callback) here because slab's memory hot
	 * unplug code doesn't destroy the kmem_cache->node[] data.
	 */
[...]
}


$ start-qemu -i ../buildroot/output/images/rootfs.cpio -a slub_debug=FZ arch/x86_64/boot/bzImage 
Wrong EFI loader signature.
early console in extract_kernel
input_data: 0x00000000032523b1
input_len: 0x00000000009a01b1
output: 0x0000000001000000
output_len: 0x00000000024020f4
kernel_total_size: 0x0000000002c2c000
needed_size: 0x0000000002e00000
trampoline_32bit: 0x000000000009d000


KASLR disabled: 'nokaslr' on cmdline.


Decompressing Linux... Parsing ELF... No relocation needed... done.
Booting the kernel.
[    0.000000] Linux version 5.5.0-rc1 (wagi@beryllium) (gcc version 9.2.1 20190903 [gcc-9-branch revision 275330] (SUSE Linux)) #20 SMP Mon Dec 9 21:42:33 CET 2019
[    0.000000] Command line: earlyprintk=ttyS0,115200n8 console=ttyS0,115200n8 rw nokaslr debug=1 loglevel=7 slub_debug=FZ
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000003ffdffff] usable
[    0.000000] BIOS-e820: [mem 0x000000003ffe0000-0x000000003fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[    0.000000] Hypervisor detected: KVM
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 2f69001, primary cpu clock
[    0.000000] kvm-clock: using sched offset of 202057759 cycles
[    0.000407] clocksource: kvm-clock: mask: 0xffffffffffffffff max_cycles: 0x1cd42e4dffb, max_idle_ns: 881590591483 ns
[    0.001580] tsc: Detected 3593.248 MHz processor
[    0.002817] last_pfn = 0x3ffe0 max_arch_pfn = 0x400000000
[    0.003253] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.005416] found SMP MP-table at [mem 0x000f5c90-0x000f5c9f]
[    0.005873] check: Scanning 1 areas for low memory corruption
[    0.006449] RAMDISK: [mem 0x3f8a9000-0x3ffdffff]
[    0.006851] ACPI: Early table checksum verification disabled
[    0.007275] ACPI: RSDP 0x00000000000F5A70 000014 (v00 BOCHS )
[    0.007689] ACPI: RSDT 0x000000003FFE15C9 000030 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.008318] ACPI: FACP 0x000000003FFE149D 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.008937] ACPI: DSDT 0x000000003FFE0040 00145D (v01 BOCHS  BXPCDSDT 00000001 BXPC 00000001)
[    0.009551] ACPI: FACS 0x000000003FFE0000 000040
[    0.009885] ACPI: APIC 0x000000003FFE1511 000080 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.010504] ACPI: HPET 0x000000003FFE1591 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.011355] No NUMA configuration found
[    0.011632] Faking a node at [mem 0x0000000000000000-0x000000003ffdffff]
[    0.012114] NODE_DATA(0) allocated [mem 0x3f8a5000-0x3f8a8fff]
[    0.012548] Zone ranges:
[    0.012735]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.013179]   DMA32    [mem 0x0000000001000000-0x000000003ffdffff]
[    0.013624]   Normal   empty
[    0.013830] Movable zone start for each node
[    0.014144] Early memory node ranges
[    0.014408]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.014864]   node   0: [mem 0x0000000000100000-0x000000003ffdffff]
[    0.016782] Zeroed struct page in unavailable ranges: 98 pages
[    0.016784] Initmem setup node 0 [mem 0x0000000000001000-0x000000003ffdffff]
[    0.031239] ACPI: PM-Timer IO Port: 0x608
[    0.031578] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.032030] IOAPIC[0]: apic_id 0, version 17, address 0xfec00000, GSI 0-23
[    0.032535] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.032998] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.033478] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.033962] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.034470] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
[    0.034969] Using ACPI (MADT) for SMP configuration information
[    0.035431] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.035837] smpboot: Allowing 2 CPUs, 0 hotplug CPUs
[    0.036250] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.036752] PM: Registered nosave memory: [mem 0x0009f000-0x0009ffff]
[    0.037257] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.037723] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.038204] [mem 0x40000000-0xfeffbfff] available for PCI devices
[    0.038669] Booting paravirtualized kernel on KVM
[    0.039033] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.112003] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:2 nr_node_ids:1
[    0.165424] percpu: Embedded 502 pages/cpu s2019224 r8192 d28776 u2097152
[    0.166097] KVM setup async PF for cpu 0
[    0.166427] kvm-stealtime: cpu 0, msr 3e418b80
[    0.166842] Built 1 zonelists, mobility grouping on.  Total pages: 257897
[    0.167446] Policy zone: DMA32
[    0.167718] Kernel command line: earlyprintk=ttyS0,115200n8 console=ttyS0,115200n8 rw nokaslr debug=1 loglevel=7 slub_debug=FZ
[    0.169840] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.170573] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
[    0.171266] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.173561] Memory: 973476K/1048056K available (14340K kernel code, 1674K rwdata, 4596K rodata, 3148K init, 13008K bss, 74580K reserved, 0K cma-reserved)
[    0.175193] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.176238] Running RCU self tests
[    0.176525] rcu: Hierarchical RCU implementation.
[    0.176908] rcu:     RCU event tracing is enabled.
[    0.177278] rcu:     RCU lockdep checking is enabled.
[    0.177669] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
[    0.178217] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    0.178846] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
[    0.180270] NR_IRQS: 4352, nr_irqs: 440, preallocated irqs: 16
[    0.181125] random: get_random_bytes called from start_kernel+0x31d/0x4f4 with crng_init=0
[    0.187148] Console: colour VGA+ 80x25
[    0.187505] printk: console [ttyS0] enabled
[    0.187505] printk: console [ttyS0] enabled
[    0.188205] printk: bootconsole [earlyser0] disabled
[    0.188205] printk: bootconsole [earlyser0] disabled
[    0.189033] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.189685] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.190029] ... MAX_LOCK_DEPTH:          48
[    0.190362] ... MAX_LOCKDEP_KEYS:        8192
[    0.190707] ... CLASSHASH_SIZE:          4096
[    0.191053] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.191409] ... MAX_LOCKDEP_CHAINS:      65536
[    0.191762] ... CHAINHASH_SIZE:          32768
[    0.192113]  memory used by lock dependency info: 6749 kB
[    0.192539]  memory used for stack traces: 4224 kB
[    0.192918]  per task-struct memory footprint: 2688 bytes
[    0.193370] ACPI: Core revision 20191018
[    0.193843] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604467 ns
[    0.194672] APIC: Switch to symmetric I/O mode setup
[    0.195792] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.196278] tsc: Marking TSC unstable due to TSCs unsynchronized
[    0.196779] Calibrating delay loop (skipped) preset value.. 7186.49 BogoMIPS (lpj=3593248)
[    0.197425] pid_max: default: 32768 minimum: 301
[    0.197831] LSM: Security Framework initializing
[    0.198229] SELinux:  Initializing.
[    0.198591] Mount-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
[    0.198785] Mountpoint-cache hash table entries: 2048 (order: 2, 16384 bytes, linear)
Poking KASLR using RDRAND RDTSC...
[    0.201167] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.201619] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.201778] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.202775] Spectre V2 : Mitigation: Full AMD retpoline
[    0.203184] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.203775] Speculative Store Bypass: Vulnerable
[    0.204565] Freeing SMP alternatives memory: 40K
[    0.205095] smpboot: CPU0: AMD Intel Core Processor (Haswell) (family: 0x6, model: 0x3c, stepping: 0x4)
[    0.205865] Performance Events: AMD PMU driver.
[    0.206262] ... version:                0
[    0.206601] ... bit width:              48
[    0.206777] ... generic registers:      4
[    0.207118] ... value mask:             0000ffffffffffff
[    0.207565] ... max period:             00007fffffffffff
[    0.207776] ... fixed-purpose events:   0
[    0.208116] ... event mask:             000000000000000f
[    0.208795] rcu: Hierarchical SRCU implementation.
[    0.209359] Huh? What family is it: 0x6?!
[    0.209851] smp: Bringing up secondary CPUs ...
[    0.210590] x86: Booting SMP configuration:
[    0.210786] .... node  #0, CPUs:      #1
[    0.014799] kvm-clock: cpu 1, msr 2f69041, secondary cpu clock
[    0.014799] smpboot: CPU 1 Converting physical 0 to logical die 1
[    0.224903] KVM setup async PF for cpu 1
[    0.225571] kvm-stealtime: cpu 1, msr 3e618b80
[    0.226671] smp: Brought up 1 node, 2 CPUs
[    0.226781] smpboot: Max logical packages: 2
[    0.227130] smpboot: Total of 2 processors activated (14372.99 BogoMIPS)
[    0.228914] devtmpfs: initialized
[    0.230113] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    0.230788] futex hash table entries: 512 (order: 4, 65536 bytes, linear)
[    0.231588] PM: RTC time: 20:42:50, date: 2019-12-09
[    0.231790] thermal_sys: Registered thermal governor 'step_wise'
[    0.231791] thermal_sys: Registered thermal governor 'user_space'
[    0.232623] NET: Registered protocol family 16
[    0.233483] audit: initializing netlink subsys (disabled)
[    0.233859] audit: type=2000 audit(1575924170.761:1): state=initialized audit_enabled=0 res=1
[    0.235119] cpuidle: using governor menu
[    0.235270] ACPI: bus type PCI registered
[    0.235950] PCI: Using configuration type 1 for base access
[    0.244239] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.244907] cryptomgr_test (25) used greatest stack depth: 14952 bytes left
[    0.246237] kworker/u4:0 (27) used greatest stack depth: 13632 bytes left
[    0.246918] kworker/u4:0 (35) used greatest stack depth: 13376 bytes left
[    0.251320] ACPI: Added _OSI(Module Device)
[    0.251796] ACPI: Added _OSI(Processor Device)
[    0.252177] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.252581] ACPI: Added _OSI(Processor Aggregator Device)
[    0.252783] ACPI: Added _OSI(Linux-Dell-Video)
[    0.253176] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.253633] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.258069] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.260138] ACPI: Interpreter enabled
[    0.260511] ACPI: (supports S0 S3 S4 S5)
[    0.260784] ACPI: Using IOAPIC for interrupt routing
[    0.261241] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.262093] ACPI: Enabled 2 GPEs in block 00 to 0F
[    0.272153] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.272659] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI HPX-Type3]
[    0.272835] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.273851] PCI host bridge to bus 0000:00
[    0.274182] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.274714] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.274778] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.275366] pci_bus 0000:00: root bus resource [mem 0x40000000-0xfebfffff window]
[    0.275777] pci_bus 0000:00: root bus resource [mem 0x100000000-0x17fffffff window]
[    0.276452] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.276839] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.278025] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.279266] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.280666] pci 0000:00:01.1: reg 0x20: [io  0xc000-0xc00f]
[    0.281212] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.281778] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.282322] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.282777] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.283611] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.284118] pci 0000:00:01.3: quirk: [io  0x0600-0x063f] claimed by PIIX4 ACPI
[    0.284691] pci 0000:00:01.3: quirk: [io  0x0700-0x070f] claimed by PIIX4 SMB
[    0.285199] pci 0000:00:02.0: [1234:1111] type 00 class 0x030000
[    0.286108] pci 0000:00:02.0: reg 0x10: [mem 0xfd000000-0xfdffffff pref]
[    0.287662] pci 0000:00:02.0: reg 0x18: [mem 0xfebf0000-0xfebf0fff]
[    0.290084] pci 0000:00:02.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.293047] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.293778] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.294495] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.295037] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.295597] ACPI: PCI Interrupt Link [LNKS] (IRQs *9)
[    0.296575] iommu: Default domain type: Translated 
[    0.297147] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    0.297308] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.297778] pci 0000:00:02.0: vgaarb: bridge control possible
[    0.298224] vgaarb: loaded
[    0.298852] SCSI subsystem initialized
[    0.299329] ACPI: bus type USB registered
[    0.299867] usbcore: registered new interface driver usbfs
[    0.300326] usbcore: registered new interface driver hub
[    0.300769] usbcore: registered new device driver usb
[    0.300824] pps_core: LinuxPPS API ver. 1 registered
[    0.301220] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.301785] PTP clock support registered
[    0.302208] EDAC MC: Ver: 3.0.0
[    0.302912] Advanced Linux Sound Architecture Driver Initialized.
[    0.303453] PCI: Using ACPI for IRQ routing
[    0.304391] NetLabel: Initializing
[    0.304690] NetLabel:  domain hash size = 128
[    0.304778] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    0.305342] NetLabel:  unlabeled traffic allowed by default
[    0.305969] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.306387] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.311838] clocksource: Switched to clocksource kvm-clock
[    0.421388] VFS: Disk quotas dquot_6.6.0
[    0.421764] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.422513] pnp: PnP ACPI init
[    0.424058] pnp: PnP ACPI: found 6 devices
[    0.436181] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.436901] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.437386] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.437882] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.438419] pci_bus 0000:00: resource 7 [mem 0x40000000-0xfebfffff window]
[    0.438966] pci_bus 0000:00: resource 8 [mem 0x100000000-0x17fffffff window]
[    0.439692] NET: Registered protocol family 2
[    0.440521] tcp_listen_portaddr_hash hash table entries: 512 (order: 3, 45056 bytes, linear)
[    0.441244] TCP established hash table entries: 8192 (order: 4, 65536 bytes, linear)
[    0.441899] TCP bind hash table entries: 8192 (order: 7, 655360 bytes, linear)
[    0.443053] TCP: Hash tables configured (established 8192 bind 8192)
[    0.443675] UDP hash table entries: 512 (order: 4, 98304 bytes, linear)
[    0.444264] UDP-Lite hash table entries: 512 (order: 4, 98304 bytes, linear)
[    0.444978] NET: Registered protocol family 1
[    0.445815] RPC: Registered named UNIX socket transport module.
[    0.446293] RPC: Registered udp transport module.
[    0.446665] RPC: Registered tcp transport module.
[    0.447045] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.447760] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.448248] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.448721] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.449263] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.449933] PCI: CLS 0 bytes, default 64
[    0.450409] Unpacking initramfs...
[    0.467160] Freeing initrd memory: 7388K
[    0.468524] check: Scanning for low memory corruption every 60 seconds
[    0.469943] Initialise system trusted keyrings
[    0.470511] workingset: timestamp_bits=56 max_order=18 bucket_order=0
[    0.488133] NFS: Registering the id_resolver key type
[    0.488588] Key type id_resolver registered
[    0.488963] Key type id_legacy registered
[    0.489474] 9p: Installing v9fs 9p2000 file system support
[    0.492445] Key type asymmetric registered
[    0.492810] Asymmetric key parser 'x509' registered
[    0.493220] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.493816] io scheduler mq-deadline registered
[    0.494176] io scheduler kyber registered
[    0.495274] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.496124] ACPI: Power Button [PWRF]
[    0.497007] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.519613] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.521676] Non-volatile memory driver v1.3
[    0.522118] Linux agpgart interface v0.103
[    0.530380] loop: module loaded
[    0.532165] scsi host0: ata_piix
[    0.532846] scsi host1: ata_piix
[    0.533232] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc000 irq 14
[    0.533767] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc008 irq 15
[    0.534631] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    0.535175] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.535660] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
[    0.536274] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.536761] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    0.537269] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    0.537839] sky2: driver version 1.30
[    0.538424] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.538978] ehci-pci: EHCI PCI platform driver
[    0.539350] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.539873] ohci-pci: OHCI PCI platform driver
[    0.540258] uhci_hcd: USB Universal Host Controller Interface driver
[    0.540954] usbcore: registered new interface driver usblp
[    0.541435] usbcore: registered new interface driver usb-storage
[    0.541994] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.543266] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.543706] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.544894] rtc_cmos 00:00: RTC can wake from S4
[    0.545588] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.548137] rtc_cmos 00:00: registered as rtc0
[    0.548569] rtc_cmos 00:00: alarms up to one day, y3k, 114 bytes nvram, hpet irqs
[    0.549737] device-mapper: ioctl: 4.41.0-ioctl (2019-09-16) initialised: dm-devel@redhat.com
[    0.550493] hid: raw HID events driver (C) Jiri Kosina
[    0.551282] usbcore: registered new interface driver usbhid
[    0.551720] usbhid: USB HID core driver
[    0.553641] Initializing XFRM netlink socket
[    0.554695] NET: Registered protocol family 10
[    0.555856] Segment Routing with IPv6
[    0.556439] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    0.557255] NET: Registered protocol family 17
[    0.557763] 9pnet: Installing 9P2000 support
[    0.558174] Key type dns_resolver registered
[    0.559073] IPI shorthand broadcast: enabled
[    0.559463] sched_clock: Marking stable (545213158, 13799008)->(573181544, -14169378)
[    0.560512] registered taskstats version 1
[    0.560893] Loading compiled-in X.509 certificates
[    0.562454] PM:   Magic number: 15:519:750
[    0.562856] ata_link link1: hash matches
[    0.563212]  link1: hash matches
[    0.563496] tty ttyS1: hash matches
[    0.563900] printk: console [netcon0] enabled
[    0.564276] netconsole: network logging started
[    0.565004] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    0.568095] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    0.568702] ALSA device list:
[    0.569003]   No soundcards found.
[    0.569813] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[    0.570565] cfg80211: failed to load regulatory.db
[    0.691130] ata2.00: ATAPI: QEMU DVD-ROM, 2.5+, max UDMA/100
[    0.693755] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     2.5+ PQ: 0 ANSI: 5
[    0.714644] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    0.715837] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.718610] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    0.721543] Freeing unused kernel image (initmem) memory: 3148K
[    0.726834] Write protecting the kernel read-only data: 22528k
[    0.729453] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    0.731382] Freeing unused kernel image (rodata/data gap) memory: 1548K
[    0.732236] Run /init as init process
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
Saving random seed: [    0.771559] random: dd: uninitialized urandom read (512 bytes read)
OK
Starting network: [    0.777696] ip (137) used greatest stack depth: 13152 bytes left
OK

Welcome to Buildroot
buildroot login: [    1.171331] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input3
root
# slabinfo -d
Acpi-Namespace not empty cannot disable sanity checks
Acpi-Namespace not empty cannot disable redzoning
Acpi-Operand not empty cannot disable sanity checks
Acpi-Operand not empty cannot disable redzoning
[    4.585539] 
[    4.585683] ======================================================
[    4.586211] WARNING: possible circular locking dependency detected
[    4.586723] 5.5.0-rc1 #20 Not tainted
[    4.587028] ------------------------------------------------------
[    4.587537] slabinfo/142 is trying to acquire lock:
[    4.587966] ffffffff8265eff0 (cpu_hotplug_lock.rw_sem){++++}, at: kmem_cache_shrink_all+0x9/0x20
[    4.588728] 
[    4.588728] but task is already holding lock:
[    4.589236] ffff88803c01eee8 (kn->count#60){++++}, at: kernfs_fop_write+0x9b/0x1b0
[    4.589901] 
[    4.589901] which lock already depends on the new lock.
[    4.589901] 
[    4.590614] 
[    4.590614] the existing dependency chain (in reverse order) is:
[    4.591223] 
[    4.591223] -> #2 (kn->count#60){++++}:
[    4.591662]        __kernfs_remove+0x240/0x2e0
[    4.592038]        kernfs_remove_by_name_ns+0x3c/0x80
[    4.592488]        sysfs_slab_add+0x184/0x250
[    4.592868]        __kmem_cache_create+0x37c/0x410
[    4.593286]        kmem_cache_create_usercopy+0x150/0x270
[    4.593747]        kmem_cache_create+0xd/0x10
[    4.594119]        i915_global_scheduler_init+0x1e/0x7c
[    4.594557]        i915_globals_init+0xf/0x95
[    4.594916]        i915_init+0x8/0x5d
[    4.595222]        do_one_initcall+0x58/0x29f
[    4.595588]        kernel_init_freeable+0x1ae/0x238
[    4.595999]        kernel_init+0x5/0xf7
[    4.596317]        ret_from_fork+0x27/0x50
[    4.596679] 
[    4.596679] -> #1 (slab_mutex){+.+.}:
[    4.597103]        __mutex_lock+0x86/0x900
[    4.597442]        kmem_cache_create_usercopy+0x32/0x270
[    4.597883]        kmem_cache_create+0xd/0x10
[    4.598243]        ptlock_cache_init+0x1b/0x23
[    4.598612]        start_kernel+0x21f/0x4f4
[    4.598957]        secondary_startup_64+0xb6/0xc0
[    4.599343] 
[    4.599343] -> #0 (cpu_hotplug_lock.rw_sem){++++}:
[    4.599872]        __lock_acquire+0xe2f/0x19f0
[    4.600256]        lock_acquire+0x95/0x180
[    4.600602]        cpus_read_lock+0x26/0x90
[    4.600959]        kmem_cache_shrink_all+0x9/0x20
[    4.601346]        shrink_store+0xe/0x20
[    4.601671]        slab_attr_store+0x1b/0x30
[    4.602021]        kernfs_fop_write+0xca/0x1b0
[    4.602387]        vfs_write+0xb4/0x1a0
[    4.602706]        ksys_write+0x63/0xe0
[    4.603022]        do_syscall_64+0x4b/0x1e0
[    4.603367]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    4.603831] 
[    4.603831] other info that might help us debug this:
[    4.603831] 
[    4.604484] Chain exists of:
[    4.604484]   cpu_hotplug_lock.rw_sem --> slab_mutex --> kn->count#60
[    4.604484] 
[    4.605369]  Possible unsafe locking scenario:
[    4.605369] 
[    4.605852]        CPU0                    CPU1
[    4.606228]        ----                    ----
[    4.606602]   lock(kn->count#60);
[    4.606880]                                lock(slab_mutex);
[    4.607346]                                lock(kn->count#60);
[    4.607832]   lock(cpu_hotplug_lock.rw_sem);
[    4.608200] 
[    4.608200]  *** DEADLOCK ***
[    4.608200] 
[    4.608692] 3 locks held by slabinfo/142:
[    4.609024]  #0: ffff88803bf59480 (sb_writers#7){.+.+}, at: vfs_write+0x13b/0x1a0
[    4.609646]  #1: ffff88803bfca090 (&of->mutex){+.+.}, at: kernfs_fop_write+0x93/0x1b0
[    4.610283]  #2: ffff88803c01eee8 (kn->count#60){++++}, at: kernfs_fop_write+0x9b/0x1b0
[    4.610936] 
[    4.610936] stack backtrace:
[    4.611294] CPU: 1 PID: 142 Comm: slabinfo Not tainted 5.5.0-rc1 #20
[    4.611825] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[    4.612747] Call Trace:
[    4.612956]  dump_stack+0x71/0xa0
[    4.613233]  check_noncircular+0x176/0x190
[    4.613572]  __lock_acquire+0xe2f/0x19f0
[    4.613896]  lock_acquire+0x95/0x180
[    4.614193]  ? kmem_cache_shrink_all+0x9/0x20
[    4.614553]  cpus_read_lock+0x26/0x90
[    4.614857]  ? kmem_cache_shrink_all+0x9/0x20
[    4.615215]  kmem_cache_shrink_all+0x9/0x20
[    4.615560]  shrink_store+0xe/0x20
[    4.615853]  slab_attr_store+0x1b/0x30
[    4.616164]  kernfs_fop_write+0xca/0x1b0
[    4.616490]  vfs_write+0xb4/0x1a0
[    4.616769]  ksys_write+0x63/0xe0
[    4.617057]  do_syscall_64+0x4b/0x1e0
[    4.617365]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[    4.617779] RIP: 0033:0x45c283
[    4.618034] Code: ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb bb 0f 1f 80 00 00 00 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
[    4.619538] RSP: 002b:00007ffcd158ec58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[    4.620163] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 000000000045c283
[    4.620756] RDX: 0000000000000002 RSI: 0000000001ec6360 RDI: 0000000000000003
[    4.621367] RBP: 0000000001ec6360 R08: 0000000000000000 R09: 0000000000000002
[    4.621954] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000002
[    4.622544] R13: 0000000001ece3a0 R14: 0000000000000002 R15: 00000000004c6ec0
Cannot write to Acpi-Parse/sanity
# 

