Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E8EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC18920704
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 20:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKVUEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 15:04:40 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:39678 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbfKVUEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 15:04:40 -0500
To:     LKML <linux-kernel@vger.kernel.org>, linux-ia64@vger.kernel.org
From:   Meelis Roos <mroos@linux.ee>
Subject: 5.4-rc8+ ia64 WARNING: CPU: 0 PID: 92 at mm/percpu.c:1616
 pcpu_alloc+0xce0/0xe00
Message-ID: <19c33eb1-0b58-b881-dc86-f2bb42488a37@linux.ee>
Date:   Fri, 22 Nov 2019 22:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried todays git on HP RX1600 (IA64) and got warnings from percpu allocation, during module load.

I do not know what module causes it - final list of loaded modules is the same as in 5.3.0.

Other than that the system seems to work normally - at least apt upgrade succeeded.

Config is below.

[    0.000000] Linux version 5.4.0-rc8-00037-gcc079039c9b6 (mroos@rx1600) (gcc version 9.2.1 20191109 (Debian 9.2.1-19)) #26 SMP Fri Nov 22 21:27:57 EET 2019
[    0.000000] EFI v1.10 by HP:
[    0.000000] efi:  SALsystab=0x3ee7a000  ACPI 2.0=0x3fe2c000  SMBIOS=0x3ee7c000  HCDP=0x3fe2a000
[    0.000000] PCDP: v3 at 0x3fe2a000
[    0.000000] earlycon: uart8250 at MMIO 0x00000000f4050000 (options '9600n8')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000003FE2C000 000028 (v02 HP    )
[    0.000000] ACPI: XSDT 0x000000003FE2C02C 000084 (v01 HP     rx1600   00000000 HP   00000000)
[    0.000000] ACPI: FACP 0x000000003FE35F78 0000F4 (v03 HP     rx1600   00000000 HP   00000000)
[    0.000000] ACPI: DSDT 0x000000003FE2C1C8 008390 (v01 HP     rx1600   00000007 INTL 20050309)
[    0.000000] ACPI: FACS 0x000000003FE36070 000040
[    0.000000] ACPI: SPCR 0x000000003FE360B0 000050 (v01 HP     rx1600   00000000 HP   00000000)
[    0.000000] ACPI: DBGP 0x000000003FE36100 000034 (v01 HP     rx1600   00000000 HP   00000000)
[    0.000000] ACPI: APIC 0x000000003FE36320 000094 (v01 HP     rx1600   00000000 HP   00000000)
[    0.000000] ACPI: SPMI 0x000000003FE36138 000050 (v04 HP     rx1600   00000000 HP   00000000)
[    0.000000] ACPI: CPEP 0x000000003FE361F0 000034 (v01 HP     rx1600   00000000 HP   00000000)
[    0.000000] ACPI: SSDT 0x000000003FE34568 0001A7 (v01 HP     rx1600   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FE34718 0004AF (v01 HP     rx1600   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FE34BC8 000887 (v01 HP     rx1600   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FE35458 000887 (v01 HP     rx1600   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FE35CE8 0001A9 (v01 HP     rx1600   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FE35E98 0000DC (v01 HP     rx1600   00000006 INTL 20050309)
[    0.000000] ACPI: Local APIC address (____ptrval____)
[    0.000000] 1 CPUs available, 1 CPUs total
[    0.000000] SAL 3.1: HP version 4.27
[    0.000000] SAL Platform features:
[    0.000000]  None
[    0.000000] SAL: AP wakeup using external interrupt vector 0xff
[    0.000000] MCA related initialization done
[    0.000000] Zone ranges:
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000040ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000001000000-0x000000003e873fff]
[    0.000000]   node   0: [mem 0x000000003eb90000-0x000000003ee77fff]
[    0.000000]   node   0: [mem 0x000000003fc00000-0x000000003fe27fff]
[    0.000000]   node   0: [mem 0x0000004040000000-0x00000040feffbfff]
[    0.000000]   node   0: [mem 0x00000040ff000000-0x00000040ffc6bfff]
[    0.000000]   node   0: [mem 0x00000040ffcd8000-0x00000040ffe03fff]
[    0.000000]   node   0: [mem 0x00000040ffe80000-0x00000040fffdffff]
[    0.000000] Zeroed struct page in unavailable ranges: 2274 pages
[    0.000000] Initmem setup node 0 [mem 0x0000000001000000-0x00000040fffdffff]
[    0.000000] On node 0 totalpages: 259870
[    0.000000]   DMA32 zone: 217 pages used for memmap
[    0.000000]   DMA32 zone: 0 pages reserved
[    0.000000]   DMA32 zone: 63329 pages, LIFO batch:15
[    0.000000]   Normal zone: 672 pages used for memmap
[    0.000000]   Normal zone: 196541 pages, LIFO batch:15
[    0.000000] pcpu-alloc: s39960 r8192 d213992 u262144 alloc=16*16384
[    0.000000] pcpu-alloc: [0] 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 258981
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.4.0-rc8-00037-gcc079039c9b6 root=/dev/sda2 ro module_blacklist=radeon
[    0.000000] Dentry cache hash table entries: 524288 (order: 8, 4194304 bytes, linear)
[    0.000000] Inode-cache hash table entries: 262144 (order: 7, 2097152 bytes, linear)
[    0.000000] Sorting __ex_table...
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] software IO TLB: mapped [mem 0x3a874000-0x3e874000] (64MB)
[    0.000000] Memory: 4035104K/4157920K available (13498K kernel code, 5710K rwdata, 1512K rodata, 1008K init, 3652K bss, 122816K reserved, 0K cma-reserved)
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=1, Nodes=1024
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=1.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 1024
[    0.000000] ACPI: Local APIC address (____ptrval____)
[    0.000000] GSI 36 (level, low) -> CPU 0 (0x0000) vector 49
[    0.000000] CPU 0: base freq=200.000MHz, ITC ratio=10/2, ITC freq=1000.002MHz
[    0.000000] +/-500ppm
[    0.000000] clocksource: itc: mask: 0xffffffffffffffff max_cycles: 0xe6a1914778, max_idle_ns: 440795250529 ns
[    0.012000] Console: colour VGA+ 80x25
[    0.012000] ACPI: Core revision 20190816
[    0.028000] Calibrating delay loop... 1494.01 BogoMIPS (lpj=2988032)
[    0.056000] pid_max: default: 32768 minimum: 301
[    0.056000] LSM: Security Framework initializing
[    0.060000] AppArmor: AppArmor initialized
[    0.060000] Mount-cache hash table entries: 8192 (order: 2, 65536 bytes, linear)
[    0.080000] Mountpoint-cache hash table entries: 8192 (order: 2, 65536 bytes, linear)
[    0.096000] Boot processor id 0x0/0x0
[    0.100000] rcu: Hierarchical SRCU implementation.
[    0.100000] smp: Bringing up secondary CPUs ...
[    0.112000] smp: Brought up 1 node, 1 CPU
[    0.112000] Total of 1 processors activated (1494.01 BogoMIPS).
[    0.476000] devtmpfs: initialized
[    0.476000] random: get_random_u32 called from bucket_table_alloc.isra.0+0xd0/0x3e0 with crng_init=0
[    0.488000] SMBIOS 2.3 present.
[    0.488000] DMI: hp server rx1600                   , BIOS 04.27                                                            05/15/2007
[    0.512000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.528000] futex hash table entries: 256 (order: 1, 32768 bytes, linear)
[    0.544000] NET: Registered protocol family 16
[    0.544000] audit: initializing netlink subsys (disabled)
[    0.544000] ACPI: bus type PCI registered
[    0.568000] audit: type=2000 audit(1574451784.544:1): state=initialized audit_enabled=0 res=1
[    0.580000] HugeTLB registered 256 MiB page size, pre-allocated 0 pages
[    0.580000] ACPI: Added _OSI(Module Device)
[    0.596000] ACPI: Added _OSI(Processor Device)
[    0.596000] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.596000] ACPI: Added _OSI(Processor Aggregator Device)
[    0.612000] ACPI: Added _OSI(Linux-Dell-Video)
[    0.612000] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.628000] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.628000] ACPI: 7 ACPI AML tables successfully acquired and loaded
[    0.684000] ACPI: Interpreter enabled
[    0.684000] ACPI: (supports S0 S5)
[    0.684000] ACPI: Using IOSAPIC for interrupt routing
[    0.704000] ACPI: Enabled 1 GPEs in block 10 to 1F
[    0.956000] ACPI: PCI Root Bridge [L000] (domain 0000 [bus 00-1f])
[    0.956000] acpi HWP0002:00: _OSC: OS supports [ExtendedConfig Segments MSI HPX-Type3]
[    0.984000] PCI host bridge to bus 0000:00
[    0.984000] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    0.984000] pci_bus 0000:00: root bus resource [io  0x03e0-0x1fff window]
[    0.992000] pci_bus 0000:00: root bus resource [mem 0x80000000-0x8fffffff window]
[    1.012000] pci_bus 0000:00: root bus resource [mem 0x80004000000-0x80103fffffe window]
[    1.012000] pci_bus 0000:00: root bus resource [bus 00-1f]
[    1.028000] pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
[    1.044000] pci 0000:00:01.0: reg 0x10: [mem 0x80023000-0x80023fff]
[    1.056000] pci 0000:00:01.0: supports D1 D2
[    1.056000] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
[    1.064000] pci 0000:00:01.1: [1033:0035] type 00 class 0x0c0310
[    1.080000] pci 0000:00:01.1: reg 0x10: [mem 0x80022000-0x80022fff]
[    1.088000] pci 0000:00:01.1: supports D1 D2
[    1.088000] pci 0000:00:01.1: PME# supported from D0 D1 D2 D3hot
[    1.096000] pci 0000:00:01.2: [1033:00e0] type 00 class 0x0c0320
[    1.112000] pci 0000:00:01.2: reg 0x10: [mem 0x80021000-0x800210ff]
[    1.124000] pci 0000:00:01.2: supports D1 D2
[    1.128000] pci 0000:00:01.2: PME# supported from D0 D1 D2 D3hot
[    1.128000] pci 0000:00:02.0: [1095:0649] type 00 class 0x01018f
[    1.144000] pci 0000:00:02.0: reg 0x10: [io  0x0d58-0x0d5f]
[    1.144000] pci 0000:00:02.0: reg 0x14: [io  0x0d64-0x0d67]
[    1.160000] pci 0000:00:02.0: reg 0x18: [io  0x0d50-0x0d57]
[    1.160000] pci 0000:00:02.0: reg 0x1c: [io  0x0d60-0x0d63]
[    1.180000] pci 0000:00:02.0: reg 0x20: [io  0x0d40-0x0d4f]
[    1.188000] pci 0000:00:02.0: supports D1 D2
[    1.188000] pci 0000:00:03.0: [8086:1229] type 00 class 0x020000
[    1.196000] pci 0000:00:03.0: reg 0x10: [mem 0x80020000-0x80020fff]
[    1.212000] pci 0000:00:03.0: reg 0x14: [io  0x0d00-0x0d3f]
[    1.212000] pci 0000:00:03.0: reg 0x18: [mem 0x80000000-0x8001ffff]
[    1.236000] pci 0000:00:03.0: supports D1 D2
[    1.236000] pci 0000:00:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.276000] ACPI: PCI Root Bridge [L001] (domain 0000 [bus 20-3f])
[    1.276000] acpi HWP0002:01: _OSC: OS supports [ExtendedConfig Segments MSI HPX-Type3]
[    1.308000] PCI host bridge to bus 0000:20
[    1.308000] pci_bus 0000:20: root bus resource [io  0x2000-0x3fff window]
[    1.308000] pci_bus 0000:20: root bus resource [mem 0x90000000-0x97ffffff window]
[    1.312000] pci_bus 0000:20: root bus resource [mem 0x90004000000-0x90103fffffe window]
[    1.328000] pci_bus 0000:20: root bus resource [bus 20-3f]
[    1.328000] pci 0000:20:01.0: [1000:0030] type 00 class 0x010000
[    1.344000] pci 0000:20:01.0: reg 0x10: [io  0x2100-0x21ff]
[    1.344000] pci 0000:20:01.0: reg 0x14: [mem 0x90240000-0x9024ffff 64bit]
[    1.364000] pci 0000:20:01.0: reg 0x1c: [mem 0x90230000-0x9023ffff 64bit]
[    1.380000] pci 0000:20:01.0: reg 0x30: [mem 0x90100000-0x901fffff pref]
[    1.388000] pci 0000:20:01.0: supports D1 D2
[    1.396000] pci 0000:20:01.1: [1000:0030] type 00 class 0x010000
[    1.396000] pci 0000:20:01.1: reg 0x10: [io  0x2000-0x20ff]
[    1.412000] pci 0000:20:01.1: reg 0x14: [mem 0x90220000-0x9022ffff 64bit]
[    1.412000] pci 0000:20:01.1: reg 0x1c: [mem 0x90210000-0x9021ffff 64bit]
[    1.428000] pci 0000:20:01.1: reg 0x30: [mem 0x90000000-0x900fffff pref]
[    1.436000] pci 0000:20:01.1: supports D1 D2
[    1.444000] pci 0000:20:02.0: [14e4:1645] type 00 class 0x020000
[    1.444000] pci 0000:20:02.0: reg 0x10: [mem 0x90200000-0x9020ffff 64bit]
[    1.472000] pci 0000:20:02.0: PME# supported from D3hot D3cold
[    1.500000] random: fast init done
[    1.508000] ACPI: PCI Root Bridge [L002] (domain 0000 [bus 40-7f])
[    1.508000] acpi HWP0002:02: _OSC: OS supports [ExtendedConfig Segments MSI HPX-Type3]
[    1.552000] PCI host bridge to bus 0000:40
[    1.552000] pci_bus 0000:40: root bus resource [io  0x4000-0x7fff window]
[    1.552000] pci_bus 0000:40: root bus resource [mem 0x98000000-0xbfffffff window]
[    1.556000] pci_bus 0000:40: root bus resource [mem 0xa0004000000-0xa0103fffffe window]
[    1.580000] pci_bus 0000:40: root bus resource [bus 40-7f]
[    1.628000] ACPI: PCI Root Bridge [L004] (domain 0000 [bus 80-bf])
[    1.628000] acpi HWP0002:03: _OSC: OS supports [ExtendedConfig Segments MSI HPX-Type3]
[    1.684000] PCI host bridge to bus 0000:80
[    1.684000] pci_bus 0000:80: root bus resource [io  0x8000-0xdfff window]
[    1.684000] pci_bus 0000:80: root bus resource [mem 0xc0000000-0xefffffff window]
[    1.688000] pci_bus 0000:80: root bus resource [mem 0xc0004000000-0xc0103fffffe window]
[    1.712000] pci_bus 0000:80: root bus resource [bus 80-bf]
[    1.716000] pci 0000:80:01.0: [103c:1029] type 00 class 0x0c0400
[    1.728000] pci 0000:80:01.0: reg 0x14: [io  0x8100-0x81ff]
[    1.728000] pci 0000:80:01.0: reg 0x18: [io  0x8000-0x80ff]
[    1.748000] pci 0000:80:01.0: reg 0x1c: [mem 0xc0040000-0xc00401ff]
[    1.748000] pci 0000:80:01.0: reg 0x24: [mem 0xc0020000-0xc003ffff]
[    1.764000] pci 0000:80:01.0: reg 0x30: [mem 0xc0000000-0xc001ffff pref]
[    1.788000] pci 0000:80:01.0: supports D1
[    1.848000] ACPI: PCI Root Bridge [L007] (domain 0000 [bus e0-ff])
[    1.848000] acpi HWP0002:04: _OSC: OS supports [ExtendedConfig Segments MSI HPX-Type3]
[    1.888000] PCI host bridge to bus 0000:e0
[    1.888000] pci_bus 0000:e0: root bus resource [io  0x03b0-0x03df window]
[    1.888000] pci_bus 0000:e0: root bus resource [io  0xe000-0xffff window]
[    1.908000] pci_bus 0000:e0: root bus resource [mem 0x000a0000-0x000fffff window]
[    1.928000] pci_bus 0000:e0: root bus resource [mem 0xf0000000-0xfdffffff window]
[    1.928000] pci_bus 0000:e0: root bus resource [mem 0xf0004000000-0xf0103fffffe window]
[    1.944000] pci_bus 0000:e0: root bus resource [bus e0-ff]
[    1.968000] pci 0000:e0:01.0: [103c:1290] type 00 class 0x078000
[    1.968000] pci 0000:e0:01.0: reg 0x18: [mem 0xf4051000-0xf405100f]
[    1.992000] pci 0000:e0:01.1: [103c:1048] type 00 class 0x070002
[    1.992000] pci 0000:e0:01.1: reg 0x10: [mem 0xf4050000-0xf4050fff]
[    1.996000] pci 0000:e0:01.1: reg 0x18: [mem 0xf4020000-0xf403ffff pref]
[    2.008000] pci 0000:e0:02.0: [1002:5159] type 00 class 0x030000
[    2.012000] pci 0000:e0:02.0: reg 0x10: [mem 0xf0000000-0xf3ffffff pref]
[    2.028000] pci 0000:e0:02.0: reg 0x14: [io  0xe000-0xe0ff]
[    2.028000] pci 0000:e0:02.0: reg 0x18: [mem 0xf4040000-0xf404ffff]
[    2.044000] pci 0000:e0:02.0: reg 0x30: [mem 0xf4000000-0xf401ffff pref]
[    2.056000] pci 0000:e0:02.0: supports D1 D2
[    2.060000] pci 0000:e0:02.0: vgaarb: setting as boot VGA device
[    2.060000] pci 0000:e0:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    2.080000] pci 0000:e0:02.0: vgaarb: bridge control possible
[    2.080000] vgaarb: loaded
[    2.096000] SCSI subsystem initialized
[    2.096000] ACPI: bus type USB registered
[    2.096000] usbcore: registered new interface driver usbfs
[    2.112000] usbcore: registered new interface driver hub
[    2.112000] usbcore: registered new device driver usb
[    2.128000] Registered efivars operations
[    2.140000] IOC: zx1 2.3 HPA 0xfed01000 IOVA space 1024Mb at 0x40000000
[    2.200000] clocksource: Switched to clocksource itc
[    2.204978] AppArmor: AppArmor Filesystem Enabled
[    2.204978] pnp: PnP ACPI init
[    2.216975] GSI 34 (level, low) -> CPU 0 (0x0000) vector 50
[    2.216975] pnp 00:00: Plug and Play ACPI device, IDs PNP0501 (active)
[    2.260975] pnp: PnP ACPI: found 1 devices
[    2.264975] thermal_sys: Registered thermal governor 'step_wise'
[    2.264975] NET: Registered protocol family 2
[    2.276340] tcp_listen_portaddr_hash hash table entries: 2048 (order: 1, 32768 bytes, linear)
[    2.298145] TCP established hash table entries: 32768 (order: 4, 262144 bytes, linear)
[    2.298145] TCP bind hash table entries: 32768 (order: 5, 524288 bytes, linear)
[    2.314958] TCP: Hash tables configured (established 32768 bind 32768)
[    2.331527] UDP hash table entries: 2048 (order: 2, 65536 bytes, linear)
[    2.331527] UDP-Lite hash table entries: 2048 (order: 2, 65536 bytes, linear)
[    2.348233] NET: Registered protocol family 1
[    2.352981] GSI 16 (level, low) -> CPU 0 (0x0000) vector 51
[    2.368980] GSI 16 (level, low) -> CPU 0 (0x0000) vector 51 unregistered
[    2.368980] pci 0000:00:01.0: quirk_usb_early_handoff+0x0/0x1460 took 20393 usecs
[    2.384975] GSI 17 (level, low) -> CPU 0 (0x0000) vector 51
[    2.388976] GSI 17 (level, low) -> CPU 0 (0x0000) vector 51 unregistered
[    2.398528] pci 0000:00:01.1: quirk_usb_early_handoff+0x0/0x1460 took 16523 usecs
[    2.416975] GSI 18 (level, low) -> CPU 0 (0x0000) vector 51
[    2.420976] GSI 18 (level, low) -> CPU 0 (0x0000) vector 51 unregistered
[    2.431545] pci 0000:00:01.2: quirk_usb_early_handoff+0x0/0x1460 took 16228 usecs
[    2.431545] pci 0000:00:03.0: Firmware left e100 interrupts enabled; disabling
[    2.448318] pci 0000:00:03.0: quirk_e100_interrupt+0x0/0x400 took 16095 usecs
[    2.464899] pci 0000:e0:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    2.482125] pci 0000:e0:02.0: pci_fixup_video+0x0/0x280 took 16473 usecs
[    2.482125] PCI: CLS 128 bytes, default 128
[    2.482125] workingset: timestamp_bits=52 max_order=18 bucket_order=0
[    2.500976] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.514873] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    2.514873] ACPI: Power Button [PWRF]
[    2.531546] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
[    2.531546] ACPI: Sleep Button [SLPF]
[    2.548250] thermal LNXTHERM:00: registered as thermal_zone0
[    2.548250] ACPI: Thermal Zone [THM0] (27 C)
[    2.564827] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    2.585526] 00:00: ttyS0 at MMIO 0xff5e0000 (irq = 50, base_baud = 115200) is a 16550A
[    2.588976] GSI 60 (level, low) -> CPU 0 (0x0000) vector 51
[    2.619143] 0000:e0:01.0: ttyS1 at MMIO 0xf4051000 (irq = 54, base_baud = 115200) is a 16550A
[    2.645137] 0000:e0:01.1: ttyS2 at MMIO 0xf4050000 (irq = 54, base_baud = 115200) is a 16550A
[    2.659457] printk: console [ttyS2] enabled
[    2.676400] printk: bootconsole [uart8250] disabled
[    2.719046] 0000:e0:01.1: ttyS3 at MMIO 0xf4050010 (irq = 54, base_baud = 115200) is a 16550A
[    2.719046] serial 0000:e0:01.1: Couldn't register serial port 0, irq 54, type 2, error -28
[    2.730674] Fusion MPT base driver 3.04.20
[    2.747897] Copyright (c) 1999-2008 LSI Corporation
[    2.747897] Fusion MPT SPI Host driver 3.04.20
[    2.764523] GSI 27 (level, low) -> CPU 0 (0x0000) vector 52
[    2.768979] mptbase: ioc0: Initiating bringup
[    3.740984] ioc0: LSI53C1030 B2: Capabilities={Initiator,Target}
[    5.068983] scsi host0: ioc0: LSI53C1030 B2, FwRev=01032345h, Ports=1, MaxQ=255, IRQ=55
[    5.820976] GSI 28 (level, low) -> CPU 0 (0x0000) vector 53
[    5.820976] mptbase: ioc1: Initiating bringup
[    6.780983] ioc1: LSI53C1030 B2: Capabilities={Initiator,Target}
[    8.108983] scsi 0:0:0:0: Direct-Access     HP 36.4G ST336753LC       HPC8 PQ: 0 ANSI: 3
[    8.108983] scsi target0:0:0: Beginning Domain Validation
[    8.125583] scsi host1: ioc1: LSI53C1030 B2, FwRev=01032345h, Ports=1, MaxQ=255, IRQ=56
[    8.892983] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    8.892983] ehci-pci: EHCI PCI platform driver
[    8.912979] GSI 18 (level, low) -> CPU 0 (0x0000) vector 54
[    8.912979] ehci-pci 0000:00:01.2: EHCI Host Controller
[    8.930741] ehci-pci 0000:00:01.2: new USB bus registered, assigned bus number 1
[    8.930741] ehci-pci 0000:00:01.2: irq 53, io mem 0x80021000
[    8.960983] ehci-pci 0000:00:01.2: USB 2.0 started, EHCI 0.95
[    8.960983] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.04
[    8.960983] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    8.981349] usb usb1: Product: EHCI Host Controller
[    8.997507] usb usb1: Manufacturer: Linux 5.4.0-rc8-00037-gcc079039c9b6 ehci_hcd
[    8.997507] usb usb1: SerialNumber: 0000:00:01.2
[    9.014218] hub 1-0:1.0: USB hub found
[    9.014218] hub 1-0:1.0: 5 ports detected
[    9.030834] usbcore: registered new interface driver usb-storage
[    9.032975] rtc-efi rtc-efi: registered as rtc0
[    9.047477] hidraw: raw HID events driver (C) Jiri Kosina
[    9.047477] usbcore: registered new interface driver usbhid
[    9.064204] usbhid: USB HID core driver
[    9.064204] NET: Registered protocol family 10
[    9.081176] Segment Routing with IPv6
[    9.081176] NET: Registered protocol family 17
[    9.097420] AppArmor: AppArmor sha1 policy hashing enabled
[    9.097420] printk: console [netcon0] enabled
[    9.114103] netconsole: network logging started
[    9.114103] rtc-efi rtc-efi: setting system clock to 2019-11-22T19:43:13 UTC (1574451793)
[    9.147441] scsi 0:0:0:0: Power-on or device reset occurred
[    9.152987] scsi target0:0:0: Ending Domain Validation
[    9.162685] scsi target0:0:0: FAST-160 WIDE SCSI 320.0 MB/s DT IU QAS RTI WRFLOW PCOMP (6.25 ns, offset 63)
[   12.680983] scsi 0:0:0:0: Attached scsi generic sg0 type 0
[   12.684975] sd 0:0:0:0: [sda] 71132960 512-byte logical blocks: (36.4 GB/33.9 GiB)
[   12.691940] sd 0:0:0:0: [sda] Write Protect is off
[   12.691940] sd 0:0:0:0: [sda] Mode Sense: d3 00 10 08
[   12.691940] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
[   12.740983]  sda: sda1 sda2 sda3
[   12.744984] sd 0:0:0:0: [sda] Attached SCSI disk
[   12.776983] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: (null)
[   12.776983] VFS: Mounted root (ext4 filesystem) readonly on device 8:2.
[   12.808983] devtmpfs: mounted
[   12.808983] Freeing unused kernel memory: 1008K
[   12.813831] This architecture does not have kernel memory protection.
[   12.813831] Run /sbin/init as init process
[   13.992983] systemd[1]: Inserted module 'autofs4'
[   14.048983] systemd[1]: systemd 242 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[   14.080789] systemd[1]: Detected architecture ia64.
[   14.112983] systemd[1]: Set hostname to <rx1600>.
[   14.136983] systemd[1]: Failed to bump fs.file-max, ignoring: Invalid argument
[   15.084985] systemd[1]: /lib/systemd/system/dbus.socket:4: ListenStream= references a path below legacy directory /var/run/, updating /var/run/dbus/system_bus_socket → /run/dbus/system_bus_socket; please update the unit file accordingly.
[   15.280980] random: systemd: uninitialized urandom read (16 bytes read)
[   15.280980] systemd[1]: Created slice system-serial\x2dgetty.slice.
[   15.320983] random: systemd: uninitialized urandom read (16 bytes read)
[   15.320983] systemd[1]: Listening on Journal Socket.
[   15.330369] random: systemd: uninitialized urandom read (16 bytes read)
[   15.347105] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   15.363691] systemd[1]: Listening on Syslog Socket.
[   15.380414] systemd[1]: Created slice system-getty.slice.
[   15.908987] EXT4-fs (sda2): re-mounted. Opts: errors=remount-ro
[   16.036983] systemd-journald[75]: Received request to flush runtime journal from PID 1
[   16.104990] random: crng init done
[   16.104990] random: 7 urandom warning(s) missed due to ratelimiting
[   16.608983] EFI Variables Facility v0.08 2004-May-17
[   16.636979] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   16.644978] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[   16.644978] e100: Copyright(c) 1999-2006 Intel Corporation
[   16.664977] GSI 20 (level, low) -> CPU 0 (0x0000) vector 55
[   16.765007] e100 0000:00:03.0 eth0: addr 0x80020000, irq 57, MAC addr 00:30:6e:4c:21:50
[   16.765007] ohci-pci: OHCI PCI platform driver
[   16.774985] GSI 16 (level, low) -> CPU 0 (0x0000) vector 56
[   16.774985] ohci-pci 0000:00:01.0: OHCI PCI host controller
[   16.796934] ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 2
[   16.813621] ohci-pci 0000:00:01.0: irq 51, io mem 0x80023000
[   16.888980] tg3.c:v3.137 (May 11, 2014)
[   16.892982] GSI 29 (level, low) -> CPU 0 (0x0000) vector 57
[   16.900976] libata version 3.00 loaded.
[   16.900976] ------------[ cut here ]------------
[   16.908337] WARNING: CPU: 0 PID: 92 at mm/percpu.c:1616 pcpu_alloc+0xce0/0xe00
[   16.930179] illegal size (55608) or align (4) for percpu allocation
[   16.930179] Modules linked in: L<\xf3\x80(PEK) tg3(+) libata libphy ohci_pci(+) e100 ohci_hcd mii efivars autofs4
[   16.947084] CPU: 0 PID: 92 Comm: systemd-udevd Not tainted 5.4.0-rc8-00037-gcc079039c9b6 #26
[   16.947084] Hardware name: hp server rx1600                   , BIOS 04.27                                                            05/15/2007
[   16.947084]
                Call Trace:
[   16.947084]  [<a000000100014270>] show_stack+0x90/0xc0
                                                sp=e0000040818cfb00 bsp=e0000040818c9590
[   16.947084]  [<a000000100cf0240>] dump_stack+0x120/0x180
                                                sp=e0000040818cfcd0 bsp=e0000040818c9520
[   16.947084]  [<a0000001000631b0>] __warn+0x190/0x1d0
                                                sp=e0000040818cfcd0 bsp=e0000040818c94d8
[   16.947084]  [<a0000001000632b0>] warn_slowpath_fmt+0xc0/0xf0
                                                sp=e0000040818cfcd0 bsp=e0000040818c9478
[   16.947084]  [<a000000100289e60>] pcpu_alloc+0xce0/0xe00
                                                sp=e0000040818cfd00 bsp=e0000040818c93a8
[   16.947084]  [<a00000010028a070>] __alloc_reserved_percpu+0x30/0x60
                                                sp=e0000040818cfd10 bsp=e0000040818c9380
[   16.947084]  [<a0000001001743c0>] load_module+0x2120/0x5dc0
                                                sp=e0000040818cfd10 bsp=e0000040818c91e8
[   16.947084]  [<a000000100178450>] __do_sys_finit_module+0x110/0x180
                                                sp=e0000040818cfd90 bsp=e0000040818c91b8
[   16.947084]  [<a000000100178550>] sys_finit_module+0x30/0x80
                                                sp=e0000040818cfe30 bsp=e0000040818c9160
[   16.947084]  [<a00000010000c500>] ia64_ret_from_syscall+0x0/0x20
                                                sp=e0000040818cfe30 bsp=e0000040818c9158
[   17.230327] ---[ end trace 937215a26355bb2f ]---
[   17.230327] L<\xf3\x80: Could not allocate 55608 bytes percpu data
[   17.246879] ------------[ cut here ]------------
[   17.246879] WARNING: CPU: 0 PID: 92 at mm/vmalloc.c:2234 __vunmap+0x470/0x5a0
[   17.263592] Trying to vfree() bad address (00000000b71401db)
[   17.263592] Modules linked in: tg3(+) libata libphy ohci_pci(+) e100 ohci_hcd mii efivars autofs4
[   17.280701] CPU: 0 PID: 92 Comm: systemd-udevd Tainted: G        W         5.4.0-rc8-00037-gcc079039c9b6 #26
[   17.280701] Hardware name: hp server rx1600                   , BIOS 04.27                                                            05/15/2007
[   17.280701]
                Call Trace:
[   17.280701]  [<a000000100014270>] show_stack+0x90/0xc0
                                                sp=e0000040818cfb10 bsp=e0000040818c9558
[   17.280701]  [<a000000100cf0240>] dump_stack+0x120/0x180
                                                sp=e0000040818cfce0 bsp=e0000040818c94e8
[   17.280701]  [<a0000001000631b0>] __warn+0x190/0x1d0
                                                sp=e0000040818cfce0 bsp=e0000040818c94a0
[   17.280701]  [<a0000001000632b0>] warn_slowpath_fmt+0xc0/0xf0
                                                sp=e0000040818cfce0 bsp=e0000040818c9440
[   17.280701]  [<a0000001002c8790>] __vunmap+0x470/0x5a0
                                                sp=e0000040818cfd10 bsp=e0000040818c93e8
[   17.280701]  [<a0000001002c89b0>] __vfree+0x50/0x120
                                                sp=e0000040818cfd10 bsp=e0000040818c93c0
[   17.280701]  [<a0000001002c8ad0>] vfree+0x50/0xc0
                                                sp=e0000040818cfd10 bsp=e0000040818c93a0
[   17.280701]  [<a0000001001711b0>] module_memfree+0x70/0xa0
                                                sp=e0000040818cfd10 bsp=e0000040818c9380
[   17.280701]  [<a0000001001758c0>] load_module+0x3620/0x5dc0
                                                sp=e0000040818cfd10 bsp=e0000040818c91e8
[   17.280701]  [<a000000100178450>] __do_sys_finit_module+0x110/0x180
                                                sp=e0000040818cfd90 bsp=e0000040818c91b8
[   17.280701]  [<a000000100178550>] sys_finit_module+0x30/0x80
                                                sp=e0000040818cfe30 bsp=e0000040818c9160
[   17.280701]  [<a00000010000c500>] ia64_ret_from_syscall+0x0/0x20
                                                sp=e0000040818cfe30 bsp=e0000040818c9158
[   17.597152] ---[ end trace 937215a26355bb30 ]---
[   17.613554] ------------[ cut here ]------------
[   17.613554] WARNING: CPU: 0 PID: 92 at mm/vmalloc.c:2234 __vunmap+0x470/0x5a0
[   17.630274] Trying to vfree() bad address (000000003aa97e73)
[   17.630274] Modules linked in: tg3(+) libata libphy ohci_pci(+) e100 ohci_hcd mii efivars autofs4
[   17.647053] CPU: 0 PID: 92 Comm: systemd-udevd Tainted: G        W         5.4.0-rc8-00037-gcc079039c9b6 #26
[   17.647053] Hardware name: hp server rx1600                   , BIOS 04.27                                                            05/15/2007
[   17.647053]
                Call Trace:
[   17.647053]  [<a000000100014270>] show_stack+0x90/0xc0
                                                sp=e0000040818cfb10 bsp=e0000040818c9558
[   17.647053]  [<a000000100cf0240>] dump_stack+0x120/0x180
                                                sp=e0000040818cfce0 bsp=e0000040818c94e8
[   17.647053]  [<a0000001000631b0>] __warn+0x190/0x1d0
                                                sp=e0000040818cfce0 bsp=e0000040818c94a0
[   17.647053]  [<a0000001000632b0>] warn_slowpath_fmt+0xc0/0xf0
                                                sp=e0000040818cfce0 bsp=e0000040818c9440
[   17.647053]  [<a0000001002c8790>] __vunmap+0x470/0x5a0
                                                sp=e0000040818cfd10 bsp=e0000040818c93e8
[   17.647053]  [<a0000001002c89b0>] __vfree+0x50/0x120
                                                sp=e0000040818cfd10 bsp=e0000040818c93c0
[   17.647053]  [<a0000001002c8ad0>] vfree+0x50/0xc0
                                                sp=e0000040818cfd10 bsp=e0000040818c93a0
[   17.647053]  [<a0000001001711b0>] module_memfree+0x70/0xa0
                                                sp=e0000040818cfd10 bsp=e0000040818c9380
[   17.647053]  [<a0000001001758d0>] load_module+0x3630/0x5dc0
                                                sp=e0000040818cfd10 bsp=e0000040818c91e8
[   17.647053]  [<a000000100178450>] __do_sys_finit_module+0x110/0x180
                                                sp=e0000040818cfd90 bsp=e0000040818c91b8
[   17.647053]  [<a000000100178550>] sys_finit_module+0x30/0x80
                                                sp=e0000040818cfe30 bsp=e0000040818c9160
[   17.647053]  [<a00000010000c500>] ia64_ret_from_syscall+0x0/0x20
                                                sp=e0000040818cfe30 bsp=e0000040818c9158
[   17.963817] ---[ end trace 937215a26355bb31 ]---


Config:

#
# Automatically generated file; DO NOT EDIT.
# Linux/ia64 5.4.0-rc8 Kernel Configuration
#

#
# Compiler: gcc (Debian 9.2.1-19) 9.2.1 20191109
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=90201
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_DEFAULT_HOSTNAME="rx1600"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
# CONFIG_USELIB is not set
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_LEGACY=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_MSI_IRQ=y
# end of IRQ subsystem

CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

# CONFIG_CPU_ISOLATION is not set

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
# end of RCU Subsystem

# CONFIG_IKCONFIG is not set
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# CONFIG_UCLAMP_TASK is not set
# end of Scheduler features

CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_RDMA is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_HUGETLB is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CGROUP_CPUACCT is not set
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
# CONFIG_BLK_DEV_INITRD is not set
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_MULTIUSER=y
CONFIG_SYSFS_SYSCALL=y
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_ALL is not set
CONFIG_BPF_SYSCALL=y
CONFIG_USERFAULTFD=y
# CONFIG_EMBEDDED is not set

#
# Kernel Performance Events And Counters
#
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_PROFILING is not set
# end of General setup

CONFIG_PGTABLE_LEVELS=3

#
# Processor type and features
#
CONFIG_IA64=y
CONFIG_64BIT=y
CONFIG_ZONE_DMA32=y
CONFIG_MMU=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_HUGETLB_PAGE_SIZE_VARIABLE=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_DMI=y
CONFIG_EFI=y
CONFIG_SCHED_OMIT_FRAME_POINTER=y
CONFIG_IA64_UNCACHED_ALLOCATOR=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_AUDIT_ARCH=y
# CONFIG_ITANIUM is not set
CONFIG_MCKINLEY=y
# CONFIG_IA64_PAGE_SIZE_4KB is not set
# CONFIG_IA64_PAGE_SIZE_8KB is not set
CONFIG_IA64_PAGE_SIZE_16KB=y
# CONFIG_IA64_PAGE_SIZE_64KB is not set
# CONFIG_HZ_100 is not set
CONFIG_HZ_250=y
# CONFIG_HZ_300 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=250
CONFIG_IA64_L1_CACHE_SHIFT=7
# CONFIG_IA64_SGI_UV is not set
CONFIG_IA64_HP_SBA_IOMMU=y
# CONFIG_IA64_CYCLONE is not set
CONFIG_FORCE_MAX_ZONEORDER=17
CONFIG_SMP=y
CONFIG_NR_CPUS=4096
# CONFIG_HOTPLUG_CPU is not set
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
# CONFIG_SCHED_SMT is not set
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_DISCONTIGMEM_DEFAULT=y
CONFIG_NUMA=y
CONFIG_NODES_SHIFT=10
CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID=y
CONFIG_HAVE_ARCH_NODEDATA_EXTENSION=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_HAVE_MEMORYLESS_NODES=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_IA64_MCA_RECOVERY=m
CONFIG_IA64_PALINFO=m
# CONFIG_IA64_MC_ERR_INJECT is not set
CONFIG_IA64_ESI=y
CONFIG_IA64_HP_AML_NFW=y

#
# Firmware Drivers
#
CONFIG_EFI_PCDP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=m
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=m
CONFIG_EFI_BOOTLOADER_CONTROL=m
CONFIG_EFI_CAPSULE_LOADER=m
# CONFIG_EFI_TEST is not set
# end of EFI (Extensible Firmware Interface) Support

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers
# end of Processor type and features

#
# Power management and ACPI options
#
CONFIG_PM=y
# CONFIG_PM_DEBUG is not set
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_ENERGY_MODEL=y
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
# CONFIG_ACPI_CONTAINER is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_HMAT is not set
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set

#
# CPU Frequency scaling
#

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=m
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y

#
# CPU frequency scaling drivers
#
CONFIG_IA64_ACPI_CPUFREQ=m
# end of CPU Frequency scaling
# end of CPU Frequency scaling
# end of Power management and ACPI options

CONFIG_MSPEC=m

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_TASK_STRUCT_ON_STACK=y
CONFIG_ARCH_TASK_STRUCT_ALLOCATOR=y
CONFIG_ARCH_THREAD_STACK_ALLOCATOR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_64BIT_TIME=y
# CONFIG_REFCOUNT_FULL is not set

#
# GCOV-based kernel profiling
#
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC=""
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_DEV_ZONED is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
# CONFIG_MQ_IOSCHED_DEADLINE is not set
# CONFIG_MQ_IOSCHED_KYBER is not set
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PADATA=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=y
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
# CONFIG_FLATMEM_MANUAL is not set
# CONFIG_DISCONTIGMEM_MANUAL is not set
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
# CONFIG_COMPACTION is not set
# CONFIG_MIGRATION is not set
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
# CONFIG_CMA is not set
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=y
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=y
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
# CONFIG_IP_MROUTE is not set
CONFIG_SYN_COOKIES=y
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_UDP_DIAG=y
CONFIG_INET_RAW_DIAG=y
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
# CONFIG_IPV6_SIT is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_NETLABEL is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
# CONFIG_WIRELESS is not set
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_NET_SOCK_MSG=y
# CONFIG_FAILOVER is not set

#
# Device Drivers
#
CONFIG_HAVE_PCI=y
CONFIG_FORCE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_SYSCALL=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_PCCARD is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_ALLOW_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

# CONFIG_CONNECTOR is not set
# CONFIG_GNSS is not set
# CONFIG_MTD is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_CDROM=y
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SKD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_BLK_DEV_RBD is not set
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_FC is not set
# end of NVME Support

#
# Misc devices
#
# CONFIG_DUMMY_IRQ is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
# CONFIG_PVPANIC is not set
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_93CX6 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# end of Texas Instruments shared transport line discipline

#
# Altera FPGA firmware download module (requires I2C)
#

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_PROC_FS is not set

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=y
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=y
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_NONSTANDARD=y
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
CONFIG_SATA_ZPODD=y
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
# CONFIG_SATA_AHCI is not set
# CONFIG_SATA_AHCI_PLATFORM is not set
# CONFIG_SATA_INIC162X is not set
# CONFIG_SATA_ACARD_AHCI is not set
# CONFIG_SATA_SIL24 is not set
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
# CONFIG_PDC_ADMA is not set
# CONFIG_SATA_QSTOR is not set
# CONFIG_SATA_SX4 is not set
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
# CONFIG_ATA_PIIX is not set
# CONFIG_SATA_MV is not set
# CONFIG_SATA_NV is not set
# CONFIG_SATA_PROMISE is not set
# CONFIG_SATA_SIL is not set
# CONFIG_SATA_SIS is not set
# CONFIG_SATA_SVW is not set
# CONFIG_SATA_ULI is not set
# CONFIG_SATA_VIA is not set
# CONFIG_SATA_VITESSE is not set

#
# PATA SFF controllers with BMDMA
#
# CONFIG_PATA_ALI is not set
# CONFIG_PATA_AMD is not set
# CONFIG_PATA_ARTOP is not set
# CONFIG_PATA_ATIIXP is not set
# CONFIG_PATA_ATP867X is not set
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
# CONFIG_PATA_HPT366 is not set
# CONFIG_PATA_HPT37X is not set
# CONFIG_PATA_HPT3X2N is not set
# CONFIG_PATA_HPT3X3 is not set
# CONFIG_PATA_IT8213 is not set
# CONFIG_PATA_IT821X is not set
# CONFIG_PATA_JMICRON is not set
# CONFIG_PATA_MARVELL is not set
# CONFIG_PATA_NETCELL is not set
# CONFIG_PATA_NINJA32 is not set
# CONFIG_PATA_NS87415 is not set
# CONFIG_PATA_OLDPIIX is not set
# CONFIG_PATA_OPTIDMA is not set
# CONFIG_PATA_PDC2027X is not set
# CONFIG_PATA_PDC_OLD is not set
# CONFIG_PATA_RADISYS is not set
# CONFIG_PATA_RDC is not set
# CONFIG_PATA_SCH is not set
# CONFIG_PATA_SERVERWORKS is not set
# CONFIG_PATA_SIL680 is not set
# CONFIG_PATA_SIS is not set
# CONFIG_PATA_TOSHIBA is not set
# CONFIG_PATA_TRIFLEX is not set
# CONFIG_PATA_VIA is not set
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
# CONFIG_PATA_ACPI is not set
# CONFIG_ATA_GENERIC is not set
# CONFIG_PATA_LEGACY is not set
# CONFIG_MD is not set
# CONFIG_TARGET_CORE is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
# CONFIG_FUSION_SAS is not set
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_NETDEVICES=y
CONFIG_MII=m
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
CONFIG_NETCONSOLE=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_TUN=m
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set
# CONFIG_ARCNET is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
# CONFIG_NET_VENDOR_AGERE is not set
# CONFIG_NET_VENDOR_ALACRITECH is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
# CONFIG_NET_VENDOR_AMAZON is not set
# CONFIG_NET_VENDOR_AMD is not set
# CONFIG_NET_VENDOR_AQUANTIA is not set
# CONFIG_NET_VENDOR_ARC is not set
# CONFIG_NET_VENDOR_ATHEROS is not set
# CONFIG_NET_VENDOR_AURORA is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
CONFIG_TIGON3=m
CONFIG_TIGON3_HWMON=y
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
# CONFIG_NET_VENDOR_BROCADE is not set
# CONFIG_NET_VENDOR_CADENCE is not set
# CONFIG_NET_VENDOR_CAVIUM is not set
# CONFIG_NET_VENDOR_CHELSIO is not set
# CONFIG_NET_VENDOR_CISCO is not set
# CONFIG_NET_VENDOR_CORTINA is not set
# CONFIG_DNET is not set
# CONFIG_NET_VENDOR_DEC is not set
# CONFIG_NET_VENDOR_DLINK is not set
# CONFIG_NET_VENDOR_EMULEX is not set
# CONFIG_NET_VENDOR_EZCHIP is not set
# CONFIG_NET_VENDOR_GOOGLE is not set
# CONFIG_NET_VENDOR_HP is not set
# CONFIG_NET_VENDOR_HUAWEI is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
CONFIG_E100=m
CONFIG_E1000=m
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_IXGBEVF is not set
# CONFIG_I40E is not set
# CONFIG_I40EVF is not set
# CONFIG_ICE is not set
# CONFIG_FM10K is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
# CONFIG_NET_VENDOR_MARVELL is not set
# CONFIG_NET_VENDOR_MELLANOX is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
# CONFIG_NET_VENDOR_MICROSEMI is not set
# CONFIG_NET_VENDOR_MYRI is not set
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
# CONFIG_NET_VENDOR_NETERION is not set
# CONFIG_NET_VENDOR_NETRONOME is not set
# CONFIG_NET_VENDOR_NI is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
# CONFIG_NET_VENDOR_OKI is not set
# CONFIG_ETHOC is not set
# CONFIG_NET_VENDOR_PACKET_ENGINES is not set
# CONFIG_NET_VENDOR_PENSANDO is not set
# CONFIG_NET_VENDOR_QLOGIC is not set
# CONFIG_NET_VENDOR_QUALCOMM is not set
# CONFIG_NET_VENDOR_RDC is not set
# CONFIG_NET_VENDOR_REALTEK is not set
# CONFIG_NET_VENDOR_RENESAS is not set
# CONFIG_NET_VENDOR_ROCKER is not set
# CONFIG_NET_VENDOR_SAMSUNG is not set
# CONFIG_NET_VENDOR_SEEQ is not set
# CONFIG_NET_VENDOR_SOLARFLARE is not set
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
# CONFIG_NET_VENDOR_SMSC is not set
# CONFIG_NET_VENDOR_SOCIONEXT is not set
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
# CONFIG_NET_VENDOR_SYNOPSYS is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
# CONFIG_NET_VENDOR_TI is not set
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=m
CONFIG_MDIO_BUS=m
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=m

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_CORTINA_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_INTEL_XWAY_PHY is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_MARVELL_10G_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_NXP_TJA11XX_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_USB_NET_DRIVERS is not set
# CONFIG_WLAN is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NET_FAILOVER is not set
# CONFIG_ISDN is not set
# CONFIG_NVM is not set

#
# Input device support
#
CONFIG_INPUT=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
# CONFIG_INPUT_MOUSEDEV is not set
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ATKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_NOZOMI is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
# CONFIG_LDISC_AUTOLOAD is not set
# CONFIG_DEVMEM is not set
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_RT288X is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# end of Serial drivers

# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=m
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

CONFIG_RANDOM_TRUST_BOOTLOADER=y

#
# I2C support
#
# CONFIG_I2C is not set
# end of I2C support

# CONFIG_I3C is not set
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
# CONFIG_PPS is not set

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
# end of PTP clock support

# CONFIG_PINCTRL is not set
# CONFIG_GPIOLIB is not set
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
# CONFIG_POWER_RESET is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_CHARGER_MAX8903 is not set
CONFIG_HWMON=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AS370 is not set
# CONFIG_SENSORS_ASPEED is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
# CONFIG_SENSORS_NTC_THERMISTOR is not set
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NPCM7XX is not set
# CONFIG_SENSORS_SIS5595 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_VT8231 is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_EMULATION is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
# CONFIG_WATCHDOG_SYSFS is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ALIM7101_WDT is not set
# CONFIG_I6300ESB_WDT is not set
# CONFIG_ITCO_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
# CONFIG_MFD_MADERA is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_TQMX86 is not set
# CONFIG_MFD_VX855 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
# CONFIG_RC_CORE is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_AGP=m
# CONFIG_AGP_I460 is not set
CONFIG_AGP_HP_ZX1=m
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_DRM is not set
# CONFIG_DRM_DP_CEC is not set

#
# ARM devices
#
# end of ARM devices

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

#
# Frame buffer Devices
#
# CONFIG_FB is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
# CONFIG_LCD_CLASS_DEVICE is not set
# CONFIG_BACKLIGHT_CLASS_DEVICE is not set
# end of Backlight & LCD device support

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
# end of Console display driver support
# end of Graphics support

# CONFIG_SOUND is not set

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
# CONFIG_HID_ACCUTOUCH is not set
# CONFIG_HID_ACRUX is not set
# CONFIG_HID_APPLE is not set
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_AUREAL is not set
# CONFIG_HID_BELKIN is not set
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_CHERRY is not set
# CONFIG_HID_CHICONY is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
# CONFIG_HID_CYPRESS is not set
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
# CONFIG_HID_EZKEY is not set
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_VIEWSONIC is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
# CONFIG_HID_JABRA is not set
# CONFIG_HID_TWINHAN is not set
# CONFIG_HID_KENSINGTON is not set
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO is not set
# CONFIG_HID_LOGITECH is not set
# CONFIG_HID_MAGICMOUSE is not set
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
# CONFIG_HID_REDRAGON is not set
# CONFIG_HID_MICROSOFT is not set
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_RETRODE is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEAM is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set
# CONFIG_HID_ALPS is not set
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_ULPI_BUS is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
CONFIG_USB_DYNAMIC_MINORS=y
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=m

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
# CONFIG_USB_XHCI_HCD is not set
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_HCD_PCI=m
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=m
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
# CONFIG_MMC is not set
# CONFIG_MEMSTICK is not set
# CONFIG_NEW_LEDS is not set
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#

#
# SPI RTC drivers
#

#
# SPI and I2C RTC drivers
#

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
CONFIG_RTC_DRV_EFI=y
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# end of DMABUF options

# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set
# CONFIG_VIRTIO_MENU is not set

#
# Microsoft Hyper-V guest support
#
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
# CONFIG_STAGING is not set
# CONFIG_HWSPINLOCK is not set
# CONFIG_MAILBOX is not set
# CONFIG_IOMMU_SUPPORT is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

# CONFIG_PM_DEVFREQ is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
# CONFIG_PWM is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
# CONFIG_GENERIC_PHY is not set
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set
# CONFIG_RAS is not set

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

# CONFIG_LIBNVDIMM is not set
# CONFIG_DAX is not set
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=y
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_FS_DAX is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS4_FS is not set
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="utf8"
CONFIG_FAT_DEFAULT_UTF8=y
CONFIG_NTFS_FS=m
# CONFIG_NTFS_DEBUG is not set
# CONFIG_NTFS_RW is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
# CONFIG_CONFIGFS_FS is not set
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
# CONFIG_NETWORK_FILESYSTEMS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
CONFIG_NLS_UTF8=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SELINUX is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
# CONFIG_SECURITY_YAMA is not set
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_INTEGRITY is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=m
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=m
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
# CONFIG_CRYPTO_NULL is not set
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Public-key cryptography
#
# CONFIG_CRYPTO_RSA is not set
# CONFIG_CRYPTO_DH is not set
# CONFIG_CRYPTO_ECDH is not set
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
# CONFIG_CRYPTO_CBC is not set
# CONFIG_CRYPTO_CFB is not set
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_OFB is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_ADIANTUM is not set
# CONFIG_CRYPTO_ESSIV is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
# CONFIG_CRYPTO_HMAC is not set
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_XXHASH is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
CONFIG_CRYPTO_SHA1=y
# CONFIG_CRYPTO_SHA256 is not set
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_SM4 is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
# CONFIG_CRYPTO_DRBG_MENU is not set
# CONFIG_CRYPTO_JITTERENTROPY is not set
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_HW is not set

#
# Certificates for signature checking
#
# end of Certificates for signature checking

#
# Library routines
#
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
# CONFIG_CRC_CCITT is not set
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
# CONFIG_XZ_DEC is not set
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU=y
CONFIG_ARCH_HAS_DMA_COHERENT_TO_PFN=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
# CONFIG_IRQ_POLL is not set
CONFIG_UCS2_STRING=y
CONFIG_SG_POOL=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=2048
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_DEBUG_FS is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0xffff
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
CONFIG_WQ_WATCHDOG=y
# end of Debug Lockups and Hangs

# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
# CONFIG_SCHED_DEBUG is not set
# CONFIG_SCHEDSTATS is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

# CONFIG_STACKTRACE is not set
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
# CONFIG_LATENCYTOP is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
# CONFIG_RUNTIME_TESTING_MENU is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_UBSAN=y
# CONFIG_UBSAN_NO_ALIGNMENT is not set
CONFIG_UBSAN_ALIGNMENT=y
# CONFIG_TEST_UBSAN is not set
CONFIG_IA64_GRANULE_16MB=y
# CONFIG_IA64_PRINT_HAZARDS is not set
# CONFIG_DISABLE_VHPT is not set
# CONFIG_IA64_DEBUG_CMPXCHG is not set
# CONFIG_IA64_DEBUG_IRQ is not set
# end of Kernel hacking


-- 
Meelis Roos <mroos@linux.ee>
