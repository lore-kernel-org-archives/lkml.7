Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D571EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584EF214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbfCMJrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:47:48 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:52620 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfCMJrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:47:47 -0400
From:   Meelis Roos <mroos@linux.ee>
Subject: Radeon init fail and resulting cascade of UBSAN errors
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <27d3a6ae-2de0-b694-5f9f-cc008c7fa514@linux.ee>
Date:   Wed, 13 Mar 2019 11:47:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I just put a Radeon 9600XT into an Athlon XP machine. I do not know if the card
is good or not, but 2D dumb framebufer works fine with radeon module. However,
init of the acceleration engine fails. I compiled my own kernel (v5.0 from git)
with UBSAN (no other debug yet) and got a cascade of UBSAN warnings and two other
errors on bootup.

A "kobject (b8a6a825): tried to init an initialized object", some UBSAN warnings
from ttm and finally a kernel read fault.

Whether or not the initial problem is hardware or software problem, the rest
seem to be our error handling bugs.

Full dmesg:

[    0.000000] Linux version 5.0.0 (mroos@kt600) (gcc version 8.3.0 (Debian 8.3.0-2)) #2 Tue Mar 12 18:48:05 EET 2019
[    0.000000] x86/fpu: x87 FPU will use FXSAVE
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009fbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009fc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000ce000-0x00000000000d3fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000007ffeffff] usable
[    0.000000] BIOS-e820: [mem 0x000000007fff0000-0x000000007fff7fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000007fff8000-0x000000007fffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fff80000-0x00000000ffffffff] reserved
[    0.000000] Notice: NX (Execute Disable) protection missing in CPU!
[    0.000000] Legacy DMI 2.3 present.
[    0.000000] DMI:  K7VT6-C /K7VT6-C , BIOS P1.50 06/15/2006
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 1798.193 MHz processor
[    0.006124] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.006128] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.006138] last_pfn = 0x7fff0 max_arch_pfn = 0x100000
[    0.006147] MTRR default type: uncachable
[    0.006149] MTRR fixed ranges enabled:
[    0.006151]   00000-9FFFF write-back
[    0.006153]   A0000-BFFFF uncachable
[    0.006154]   C0000-C7FFF write-protect
[    0.006155]   C8000-EFFFF uncachable
[    0.006156]   F0000-FFFFF write-protect
[    0.006157] MTRR variable ranges enabled:
[    0.006160]   0 base 000000000 mask F80000000 write-back
[    0.006161]   1 disabled
[    0.006161]   2 disabled
[    0.006162]   3 disabled
[    0.006163]   4 disabled
[    0.006164]   5 base 0E0000000 mask FF0000000 write-combining
[    0.006165]   6 disabled
[    0.006165]   7 disabled
[    0.006536] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[    0.006896] check: Scanning 1 areas for low memory corruption
[    0.006906] initial memory mapped: [mem 0x00000000-0x1fbfffff]
[    0.006915] Base memory trampoline at [(ptrval)] 9b000 size 16384
[    0.006963] BRK [0x1f85d000, 0x1f85dfff] PGTABLE
[    0.006999] ACPI: Early table checksum verification disabled
[    0.010441] ACPI: RSDP 0x00000000000FA920 000014 (v00 AMI   )
[    0.010448] ACPI: RSDT 0x000000007FFF0000 00002C (v01 AMIINT VIA_K7   00000010 MSFT 00000097)
[    0.010461] ACPI: FACP 0x000000007FFF0030 000081 (v01 AMIINT VIA_K7   00000011 MSFT 00000097)
[    0.010477] ACPI: DSDT 0x000000007FFF0120 00324C (v01 VIA    K7VT4    00001000 INTL 02002024)
[    0.010484] ACPI: FACS 0x000000007FFF8000 000040
[    0.010489] ACPI: APIC 0x000000007FFF00C0 000054 (v01 AMIINT VIA_K7   00000009 MSFT 00000097)
[    0.010506] ACPI: Local APIC address 0xfee00000
[    0.010513] 1163MB HIGHMEM available.
[    0.010518] 883MB LOWMEM available.
[    0.010519]   mapped low ram: 0 - 373fe000
[    0.010521]   low ram: 0 - 373fe000
[    0.010524] BRK [0x1f85e000, 0x1f85efff] PGTABLE
[    0.011606] Zone ranges:
[    0.011610]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.011615]   Normal   [mem 0x0000000001000000-0x00000000373fdfff]
[    0.011618]   HighMem  [mem 0x00000000373fe000-0x000000007ffeffff]
[    0.011620] Movable zone start for each node
[    0.011622] Early memory node ranges
[    0.011624]   node   0: [mem 0x0000000000001000-0x000000000009efff]
[    0.011627]   node   0: [mem 0x0000000000100000-0x000000007ffeffff]
[    0.011638] Zeroed struct page in unavailable ranges: 98 pages
[    0.011641] Initmem setup node 0 [mem 0x0000000000001000-0x000000007ffeffff]
[    0.011648] On node 0 totalpages: 524174
[    0.011650]   DMA zone: 32 pages used for memmap
[    0.011651]   DMA zone: 0 pages reserved
[    0.011653]   DMA zone: 3998 pages, LIFO batch:0
[    0.011993]   Normal zone: 1736 pages used for memmap
[    0.011994]   Normal zone: 222206 pages, LIFO batch:63
[    0.033171]   HighMem zone: 297970 pages, LIFO batch:63
[    0.061418] Using APIC driver default
[    0.061522] ACPI: PM-Timer IO Port: 0x808
[    0.061525] ACPI: Local APIC address 0xfee00000
[    0.061568] IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
[    0.061574] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.061580] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.061583] ACPI: IRQ0 used by override.
[    0.061586] ACPI: IRQ9 used by override.
[    0.061590] Using ACPI (MADT) for SMP configuration information
[    0.061617] [mem 0x80000000-0xfebfffff] available for PCI devices
[    0.061627] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.061652] random: get_random_bytes called from start_kernel+0x78/0x354 with crng_init=0
[    0.061757] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.061759] pcpu-alloc: [0] 0
[    0.061783] Built 1 zonelists, mobility grouping on.  Total pages: 522406
[    0.061786] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.0.0 root=/dev/sda1 ro hpet=force
[    0.063029] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.063606] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.063622] Initializing CPU#0
[    0.063633] Initializing HighMem for node 0 (000373fe:0007fff0)
[    0.129040] Initializing Movable for node 0 (00000000:00000000)
[    0.144551] Memory: 2070828K/2096696K available (5295K kernel code, 671K rwdata, 1288K rodata, 404K init, 316K bss, 25868K reserved, 0K cma-reserved, 1191880K highmem)
[    0.144564] virtual kernel memory layout:
                    fixmap  : 0xfffa4000 - 0xfffff000   ( 364 kB)
                  cpu_entry : 0xffc00000 - 0xffc27000   ( 156 kB)
                    pkmap   : 0xff400000 - 0xff800000   (4096 kB)
                    vmalloc : 0xf7bfe000 - 0xff3fe000   ( 120 MB)
                    lowmem  : 0xc0000000 - 0xf73fe000   ( 883 MB)
                      .init : 0xdf729000 - 0xdf78e000   ( 404 kB)
                      .data : 0xdf52bee5 - 0xdf71bdc0   (1983 kB)
                      .text : 0xdf000000 - 0xdf52bee5   (5295 kB)
[    0.144567] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.144811] SLUB: HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.144926] NR_IRQS: 2304, nr_irqs: 256, preallocated irqs: 16
[    0.145279] CPU 0 irqstacks, hard=(ptrval) soft=(ptrval)
[    0.146925] Console: colour VGA+ 80x25
[    0.151436] printk: console [tty0] enabled
[    0.151524] ACPI: Core revision 20181213
[    0.151773] APIC: Switch to symmetric I/O mode setup
[    0.151843] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.153231] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.171773] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x19eb7e965e3, max_idle_ns: 440795261427 ns
[    0.171889] Calibrating delay loop (skipped), value calculated using timer frequency.. 3596.38 BogoMIPS (lpj=7192772)
[    0.171989] pid_max: default: 32768 minimum: 301
[    0.172117] LSM: Security Framework initializing
[    0.172192] AppArmor: AppArmor disabled by boot time parameter
[    0.172298] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.172374] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.172789] mce: CPU supports 4 MCE banks
[    0.172892] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.172961] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.173028] CPU: AMD Athlon(tm) XP 2200+ (family: 0x6, model: 0x8, stepping: 0x0)
[    0.173124] Spectre V2 : Spectre mitigation: kernel not compiled with retpoline; no mitigation available!
[    0.173126] Speculative Store Bypass: Vulnerable
[    0.173955] Performance Events: AMD PMU driver.
[    0.174033] ... version:                0
[    0.174098] ... bit width:              48
[    0.174163] ... generic registers:      4
[    0.174230] ... value mask:             0000ffffffffffff
[    0.174297] ... max period:             00007fffffffffff
[    0.174364] ... fixed-purpose events:   0
[    0.174429] ... event mask:             000000000000000f
[    0.174745] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.175873] devtmpfs: initialized
[    0.175873] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.175873] futex hash table entries: 256 (order: -1, 3072 bytes)
[    0.175873] NET: Registered protocol family 16
[    0.175873] audit: initializing netlink subsys (disabled)
[    0.175873] cpuidle: using governor menu
[    0.175873] ACPI: bus type PCI registered
[    0.195174] PCI: PCI BIOS revision 2.10 entry at 0xfdae1, last bus=1
[    0.195244] PCI: Using configuration type 1 for base access
[    0.196953] audit: type=2000 audit(1552468564.020:1): state=initialized audit_enabled=0 res=1
[    0.197208] HugeTLB registered 4.00 MiB page size, pre-allocated 0 pages
[    0.197556] ACPI: Added _OSI(Module Device)
[    0.197624] ACPI: Added _OSI(Processor Device)
[    0.197690] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.197757] ACPI: Added _OSI(Processor Aggregator Device)
[    0.197825] ACPI: Added _OSI(Linux-Dell-Video)
[    0.197892] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.197959] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.201061] ACPI: 1 ACPI AML tables successfully acquired and loaded
[    0.203343] ACPI: Interpreter enabled
[    0.203418] ACPI: (supports S0 S5)
[    0.203484] ACPI: Using IOAPIC for interrupt routing
[    0.203601] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.203864] ACPI: Enabled 7 GPEs in block 00 to 0F
[    0.205341] ACPI: Power Resource [URP1] (off)
[    0.207385] ACPI: Power Resource [URP2] (off)
[    0.207515] ACPI: Power Resource [FDDP] (off)
[    0.207639] ACPI: Power Resource [LPTP] (off)
[    0.210780] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.210863] acpi PNP0A03:00: _OSC: OS supports [Segments MSI]
[    0.210945] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.211116] acpi PNP0A03:00: host bridge window expanded to [mem 0x80000000-0xffdfffff window]; [mem 0xfee01000-0xffdfffff window] ignored
[    0.211220] acpi PNP0A03:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
[    0.211222] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7 window] (ignored)
[    0.211224] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff window] (ignored)
[    0.211227] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
[    0.211229] acpi PNP0A03:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
[    0.211232] acpi PNP0A03:00: host bridge window [mem 0x80000000-0xffdfffff window] (ignored)
[    0.211234] PCI: root bus 00: using default resources
[    0.211290] PCI host bridge to bus 0000:00
[    0.211359] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.211429] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffff]
[    0.211501] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.211591] pci 0000:00:00.0: [1106:3189] type 00 class 0x060000
[    0.211613] pci 0000:00:00.0: reg 0x10: [mem 0xe0000000-0xefffffff pref]
[    0.211784] pci 0000:00:01.0: [1106:b198] type 01 class 0x060400
[    0.211837] pci 0000:00:01.0: supports D1
[    0.211958] pci 0000:00:10.0: [1106:3038] type 00 class 0x0c0300
[    0.212004] pci 0000:00:10.0: reg 0x20: [io  0xe400-0xe41f]
[    0.212046] pci 0000:00:10.0: supports D1 D2
[    0.212049] pci 0000:00:10.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.212165] pci 0000:00:10.1: [1106:3038] type 00 class 0x0c0300
[    0.212211] pci 0000:00:10.1: reg 0x20: [io  0xe800-0xe81f]
[    0.212254] pci 0000:00:10.1: supports D1 D2
[    0.212257] pci 0000:00:10.1: PME# supported from D0 D1 D2 D3hot D3cold
[    0.212363] pci 0000:00:10.2: [1106:3038] type 00 class 0x0c0300
[    0.212408] pci 0000:00:10.2: reg 0x20: [io  0xec00-0xec1f]
[    0.212450] pci 0000:00:10.2: supports D1 D2
[    0.212452] pci 0000:00:10.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.212548] pci 0000:00:10.3: [1106:3104] type 00 class 0x0c0320
[    0.212568] pci 0000:00:10.3: reg 0x10: [mem 0xdfffff00-0xdfffffff]
[    0.212635] pci 0000:00:10.3: supports D1 D2
[    0.212638] pci 0000:00:10.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.212748] pci 0000:00:11.0: [1106:3177] type 00 class 0x060100
[    0.212817] pci 0000:00:11.0: Force enabled HPET at 0xfed00000
[    0.212826] pci 0000:00:11.0: quirk: [io  0x0800-0x087f] claimed by vt8235 PM
[    0.212899] pci 0000:00:11.0: quirk: [io  0x0400-0x040f] claimed by vt8235 SMB
[    0.213107] pci 0000:00:11.1: [1106:0571] type 00 class 0x01018a
[    0.213157] pci 0000:00:11.1: reg 0x20: [io  0xfc00-0xfc0f]
[    0.213177] pci 0000:00:11.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.213249] pci 0000:00:11.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.213321] pci 0000:00:11.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.213392] pci 0000:00:11.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.213595] pci 0000:00:11.5: [1106:3059] type 00 class 0x040100
[    0.213615] pci 0000:00:11.5: reg 0x10: [io  0xe000-0xe0ff]
[    0.213687] pci 0000:00:11.5: supports D1 D2
[    0.213789] pci 0000:00:12.0: [1106:3065] type 00 class 0x020000
[    0.213809] pci 0000:00:12.0: reg 0x10: [io  0xdc00-0xdcff]
[    0.213818] pci 0000:00:12.0: reg 0x14: [mem 0xdffffe00-0xdffffeff]
[    0.213881] pci 0000:00:12.0: supports D1 D2
[    0.213883] pci 0000:00:12.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.213998] pci_bus 0000:01: extended config space not accessible
[    0.214107] pci 0000:01:00.0: [1002:4152] type 00 class 0x030000
[    0.214122] pci 0000:01:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff pref]
[    0.214130] pci 0000:01:00.0: reg 0x14: [io  0xc800-0xc8ff]
[    0.214138] pci 0000:01:00.0: reg 0x18: [mem 0xdfef0000-0xdfefffff]
[    0.214161] pci 0000:01:00.0: reg 0x30: [mem 0xdfec0000-0xdfedffff pref]
[    0.214191] pci 0000:01:00.0: supports D1 D2
[    0.214246] pci 0000:01:00.1: [1002:4172] type 00 class 0x038000
[    0.214259] pci 0000:01:00.1: reg 0x10: [mem 0xb0000000-0xbfffffff pref]
[    0.214267] pci 0000:01:00.1: reg 0x14: [mem 0xdfee0000-0xdfeeffff]
[    0.214317] pci 0000:01:00.1: supports D1 D2
[    0.214395] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.214466] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
[    0.214471] pci 0000:00:01.0:   bridge window [mem 0xdfe00000-0xdfefffff]
[    0.214475] pci 0000:00:01.0:   bridge window [mem 0x9fd00000-0xdfcfffff pref]
[    0.214482] pci_bus 0000:00: on NUMA node 0
[    0.215541] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
[    0.215715] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 *10 11 12 14 15)
[    0.215914] ACPI: PCI Interrupt Link [LNKC] (IRQs *3 4 5 7 10 11 12 14 15)
[    0.216087] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *10 11 12 14 15)
[    0.216570] pci 0000:01:00.0: vgaarb: setting as boot VGA device
[    0.216644] pci 0000:01:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    0.216738] pci 0000:01:00.0: vgaarb: bridge control possible
[    0.216807] vgaarb: loaded
[    0.216990] SCSI subsystem initialized
[    0.217156] libata version 3.00 loaded.
[    0.217160] ACPI: bus type USB registered
[    0.217261] usbcore: registered new interface driver usbfs
[    0.217343] usbcore: registered new interface driver hub
[    0.217425] usbcore: registered new device driver usb
[    0.217569] PCI: Using ACPI for IRQ routing
[    0.217640] PCI: pci_cache_line_size set to 32 bytes
[    0.217682] e820: reserve RAM buffer [mem 0x0009fc00-0x0009ffff]
[    0.217685] e820: reserve RAM buffer [mem 0x7fff0000-0x7fffffff]
[    0.218114] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.218219] hpet clockevent registered
[    0.218231] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.218306] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.218376] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    0.219949] clocksource: Switched to clocksource tsc-early
[    0.220171] pnp: PnP ACPI init
[    0.220520] pnp 00:00: [dma 2]
[    0.220599] pnp 00:00: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.220974] pnp 00:01: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.221480] pnp 00:02: [dma 0]
[    0.221591] pnp 00:02: Plug and Play ACPI device, IDs PNP0401 (active)
[    0.221853] pnp 00:03: Plug and Play ACPI device, IDs PNPb02f (active)
[    0.222141] pnp 00:04: Plug and Play ACPI device, IDs PNPb006 (active)
[    0.222271] system 00:05: [io  0x0295-0x0296] has been reserved
[    0.222343] system 00:05: [io  0x03f0-0x03f1] has been reserved
[    0.222414] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    0.222484] system 00:05: [io  0x0400-0x040f] has been reserved
[    0.222554] system 00:05: [io  0x0800-0x087f] has been reserved
[    0.222626] system 00:05: [mem 0xfec00000-0xfec00fff] could not be reserved
[    0.222697] system 00:05: [mem 0xfee00000-0xfee00fff] has been reserved
[    0.223316] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.223383] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.223610] pnp: PnP ACPI: found 7 devices
[    0.260590] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    0.260732] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.260803] pci 0000:00:01.0:   bridge window [io  0xc000-0xcfff]
[    0.260878] pci 0000:00:01.0:   bridge window [mem 0xdfe00000-0xdfefffff]
[    0.260951] pci 0000:00:01.0:   bridge window [mem 0x9fd00000-0xdfcfffff pref]
[    0.261049] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.261051] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffff]
[    0.261054] pci_bus 0000:01: resource 0 [io  0xc000-0xcfff]
[    0.261057] pci_bus 0000:01: resource 1 [mem 0xdfe00000-0xdfefffff]
[    0.261059] pci_bus 0000:01: resource 2 [mem 0x9fd00000-0xdfcfffff pref]
[    0.261215] NET: Registered protocol family 2
[    0.261598] tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 4096 bytes)
[    0.261703] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.261842] TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
[    0.261978] TCP: Hash tables configured (established 8192 bind 8192)
[    0.262111] UDP hash table entries: 512 (order: 1, 8192 bytes)
[    0.262198] UDP-Lite hash table entries: 512 (order: 1, 8192 bytes)
[    0.262351] NET: Registered protocol family 1
[    0.262450] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.263514] pci 0000:01:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.263613] PCI: CLS 32 bytes, default 32
[    0.263993] check: Scanning for low memory corruption every 60 seconds
[    0.264784] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    0.268590] bounce: pool size: 64 pages
[    0.268685] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    0.268779] io scheduler mq-deadline registered
[    0.269211] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.289658] 00:01: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.290347] pata_via 0000:00:11.1: version 0.3.4
[    0.290537] pata_via 0000:00:11.1: can't derive routing for PCI INT A
[    0.292349] scsi host0: pata_via
[    0.292626] scsi host1: pata_via
[    0.292756] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xfc00 irq 14
[    0.292828] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xfc08 irq 15
[    0.292963] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.293033] ehci-pci: EHCI PCI platform driver
[    0.293319] ehci-pci 0000:00:10.3: EHCI Host Controller
[    0.293398] ehci-pci 0000:00:10.3: new USB bus registered, assigned bus number 1
[    0.293578] ehci-pci 0000:00:10.3: irq 21, io mem 0xdfffff00
[    0.307205] ehci-pci 0000:00:10.3: USB 2.0 started, EHCI 1.00
[    0.307344] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.00
[    0.307438] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.307530] usb usb1: Product: EHCI Host Controller
[    0.307598] usb usb1: Manufacturer: Linux 5.0.0 ehci_hcd
[    0.307666] usb usb1: SerialNumber: 0000:00:10.3
[    0.307957] hub 1-0:1.0: USB hub found
[    0.308035] hub 1-0:1.0: 6 ports detected
[    0.308361] uhci_hcd: USB Universal Host Controller Interface driver
[    0.308649] uhci_hcd 0000:00:10.0: UHCI Host Controller
[    0.308726] uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
[    0.308848] uhci_hcd 0000:00:10.0: irq 21, io base 0x0000e400
[    0.309007] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.00
[    0.309102] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.309194] usb usb2: Product: UHCI Host Controller
[    0.309261] usb usb2: Manufacturer: Linux 5.0.0 uhci_hcd
[    0.309329] usb usb2: SerialNumber: 0000:00:10.0
[    0.309557] hub 2-0:1.0: USB hub found
[    0.309633] hub 2-0:1.0: 2 ports detected
[    0.309962] uhci_hcd 0000:00:10.1: UHCI Host Controller
[    0.310038] uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
[    0.310155] uhci_hcd 0000:00:10.1: irq 21, io base 0x0000e800
[    0.310307] usb usb3: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.00
[    0.310401] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.310493] usb usb3: Product: UHCI Host Controller
[    0.310560] usb usb3: Manufacturer: Linux 5.0.0 uhci_hcd
[    0.310628] usb usb3: SerialNumber: 0000:00:10.1
[    0.310852] hub 3-0:1.0: USB hub found
[    0.310927] hub 3-0:1.0: 2 ports detected
[    0.311289] uhci_hcd 0000:00:10.2: UHCI Host Controller
[    0.311372] uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
[    0.311490] uhci_hcd 0000:00:10.2: irq 21, io base 0x0000ec00
[    0.311645] usb usb4: New USB device found, idVendor=1d6b, idProduct=0001, bcdDevice= 5.00
[    0.311739] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.311832] usb usb4: Product: UHCI Host Controller
[    0.311899] usb usb4: Manufacturer: Linux 5.0.0 uhci_hcd
[    0.311968] usb usb4: SerialNumber: 0000:00:10.2
[    0.312189] hub 4-0:1.0: USB hub found
[    0.312266] hub 4-0:1.0: 2 ports detected
[    0.312549] usbcore: registered new interface driver usb-storage
[    0.312681] i8042: PNP: No PS/2 controller found.
[    0.312748] i8042: Probing ports directly.
[    0.313315] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.313389] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.313634] mousedev: PS/2 mouse device common for all mice
[    0.313763] rtc_cmos 00:06: RTC can wake from S4
[    0.314089] rtc_cmos 00:06: registered as rtc0
[    0.314188] rtc_cmos 00:06: alarms up to one year, y3k, 114 bytes nvram, hpet irqs
[    0.314320] hidraw: raw HID events driver (C) Jiri Kosina
[    0.314417] usbcore: registered new interface driver usbhid
[    0.314484] usbhid: USB HID core driver
[    0.314916] NET: Registered protocol family 10
[    0.315418] Segment Routing with IPv6
[    0.315515] mip6: Mobile IPv6
[    0.315582] NET: Registered protocol family 17
[    0.315847] Using IPI Shortcut mode
[    0.315919] sched_clock: Marking stable (308660647, 6554974)->(423824417, -108608796)
[    0.316387] printk: console [netcon0] enabled
[    0.316454] netconsole: network logging started
[    0.316575] rtc_cmos 00:06: setting system clock to 2019-03-13T09:16:05 UTC (1552468565)
[    0.456670] ata1.00: ATA-6: WDC WD2000JB-00DUA3, 75.13B75, max UDMA/100
[    0.456745] ata1.00: 390625000 sectors, multi 16: LBA48
[    0.464755] scsi 0:0:0:0: Direct-Access     ATA      WDC WD2000JB-00D 3B75 PQ: 0 ANSI: 5
[    0.465489] sd 0:0:0:0: [sda] 390625000 512-byte logical blocks: (200 GB/186 GiB)
[    0.465608] sd 0:0:0:0: [sda] Write Protect is off
[    0.465679] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    0.465712] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    0.499787]  sda: sda1 sda2 < sda5 >
[    0.500374] sd 0:0:0:0: [sda] Attached SCSI disk
[    0.627588] ata2.00: ATAPI: HL-DT-ST GCE-8520B, 1.02, max UDMA/33
[    0.635987] scsi 1:0:0:0: CD-ROM            HL-DT-ST CD-RW GCE-8520B  1.02 PQ: 0 ANSI: 5
[    0.660837] sr 1:0:0:0: [sr0] scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
[    0.660933] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.661172] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    0.684864] EXT4-fs (sda1): INFO: recovery required on readonly filesystem
[    0.684949] EXT4-fs (sda1): write access will be enabled during recovery
[    0.831868] EXT4-fs (sda1): recovery complete
[    0.865930] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    0.866066] VFS: Mounted root (ext4 filesystem) readonly on device 8:1.
[    0.886611] devtmpfs: mounted
[    0.887579] Freeing unused kernel image memory: 404K
[    0.887759] Write protecting kernel text and read-only data: 6608k
[    0.887831] Run /sbin/init as init process
[    1.271904] tsc: Refined TSC clocksource calibration: 1798.233 MHz
[    1.271997] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x19eba47a4ac, max_idle_ns: 440795272906 ns
[    1.272097] clocksource: Switched to clocksource tsc
[    2.154238] random: fast init done
[    2.396315] systemd[1]: Inserted module 'autofs4'
[    2.457427] systemd[1]: systemd 241 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 default-hierarchy=hybrid)
[    2.457816] systemd[1]: Detected architecture x86.
[    2.481759] systemd[1]: Set hostname to <kt600>.
[    3.898990] random: systemd: uninitialized urandom read (16 bytes read)
[    3.923121] random: systemd: uninitialized urandom read (16 bytes read)
[    3.923614] systemd[1]: Listening on Syslog Socket.
[    3.924594] random: systemd: uninitialized urandom read (16 bytes read)
[    3.924953] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    3.925721] systemd[1]: Listening on initctl Compatibility Named Pipe.
[    3.926562] systemd[1]: Listening on Journal Socket.
[    3.943419] systemd[1]: Starting Set the console keyboard layout...
[    3.946545] systemd[1]: Starting Load Kernel Modules...
[    3.948307] systemd[1]: Condition check resulted in Kernel Debug File System being skipped.
[    4.308438] w83627hf: w83627hf: Found W83697HF chip at 0x290
[    4.308800] w83627hf w83627hf.656: hwmon_device_register() is deprecated. Please convert the driver to use hwmon_device_register_with_info().
[    4.358367] random: crng init done
[    4.358451] random: 7 urandom warning(s) missed due to ratelimiting
[    5.045450] EXT4-fs (sda1): re-mounted. Opts: errors=remount-ro
[    5.155851] systemd-journald[61]: Received request to flush runtime journal from PID 1
[    6.332372] Floppy drive(s): fd0 is 1.44M
[    6.339817] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
[    6.339964] ACPI: Power Button [PWRB]
[    6.340140] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input3
[    6.340237] ACPI: Sleep Button [SLPB]
[    6.340369] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input4
[    6.340462] ACPI: Power Button [PWRF]
[    6.351765] parport_pc 00:02: reported by Plug and Play ACPI
[    6.351990] parport0: PC-style at 0x378 (0x778), irq 7, dma 0 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
[    6.358273] FDC 0 is a post-1991 82077
[    6.395691] gameport gameport0: NS558 PnP Gameport is pnp00:03/gameport0, io 0x200, speed 833kHz
[    6.422865] via_rhine: v1.10-LK1.5.1 2010-10-09 Written by Donald Becker
[    6.423611] via-rhine 0000:00:12.0 eth0: VIA Rhine II at 5f8c16f8, 00:0b:6a:d1:75:e9, IRQ 23
[    6.424467] via-rhine 0000:00:12.0 eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1
[    6.426980] Linux agpgart interface v0.103
[    6.470144] agpgart: Detected VIA KT400/KT400A/KT600 chipset
[    6.506598] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    6.506734] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    6.558219] input: PC Speaker as /devices/platform/pcspkr/input/input6
[    6.584011] agpgart-via 0000:00:00.0: AGP aperture is 256M @ 0xe0000000
[    6.900133] via-rhine 0000:00:12.0 enp0s18: renamed from eth0
[    7.203076] snd_via82xx 0000:00:11.5: Using DXS as PCM Playback
[    7.281313] [drm] radeon kernel modesetting enabled.
[    7.283059] [drm] initializing kernel modesetting (RV350 0x1002:0x4152 0x174B:0x7C29 0x00).
[    7.284231] agpgart-via 0000:00:00.0: AGP 3.5 bridge
[    7.284314] agpgart-via 0000:00:00.0: putting AGP V3 device into 8x mode
[    7.284419] radeon 0000:01:00.0: putting AGP V3 device into 8x mode
[    7.284493] radeon 0000:01:00.0: GTT: 256M 0xE0000000 - 0xEFFFFFFF
[    7.284563] [drm] Generation 2 PCI interface, using max accessible memory
[    7.284637] radeon 0000:01:00.0: VRAM: 256M 0x00000000C0000000 - 0x00000000CFFFFFFF (256M used)
[    7.284738] [drm] Detected VRAM RAM=256M, BAR=256M
[    7.284804] [drm] RAM width 128bits DDR
[    7.288171] [TTM] Zone  kernel: Available graphics memory: 439676 kiB
[    7.288255] [TTM] Zone highmem: Available graphics memory: 1035616 kiB
[    7.288324] [TTM] Initializing pool allocator
[    7.288446] [drm] radeon: 256M of VRAM memory ready
[    7.288514] [drm] radeon: 256M of GTT memory ready.
[    7.288603] [drm] radeon: 1 quad pipes, 1 Z pipes initialized
[    7.289580] radeon 0000:01:00.0: WB disabled
[    7.289674] radeon 0000:01:00.0: fence driver on ring 0 use gpu addr 0x00000000e0000000 and cpu addr 0x0236f992
[    7.289784] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    7.289854] [drm] Driver supports precise vblank timestamp query.
[    7.289957] [drm] radeon: irq initialized.
[    7.290024] [drm] Loading R300 Microcode
[    7.703397] [drm] radeon: ring at 0x00000000E0001000
[    7.806992] [drm:r100_ring_test [radeon]] *ERROR* radeon: ring test failed (scratch(0x15E4)=0xCAFEDEAD)
[    7.807167] [drm:r100_cp_init [radeon]] *ERROR* radeon: cp isn't working (-22).
[    7.807264] radeon 0000:01:00.0: failed initializing CP (-22).
[    7.807334] radeon 0000:01:00.0: Disabling GPU acceleration
[    7.910391] [drm:r100_cp_fini [radeon]] *ERROR* Wait for CP idle timeout, shutting down CP.
[    7.910542] [drm] radeon: cp finalized
[    7.910656] [drm] radeon: cp finalized
[    7.910749] [TTM] Finalizing pool allocator
[    7.913746] [TTM] Zone  kernel: Used memory at exit: 0 kiB
[    7.913835] [TTM] Zone highmem: Used memory at exit: 0 kiB
[    7.913908] [drm] radeon: ttm finalized
[    7.913981] [drm] Forcing AGP to PCI mode
[    7.915041] [drm] Generation 2 PCI interface, using max accessible memory
[    7.915122] radeon 0000:01:00.0: VRAM: 256M 0x00000000C0000000 - 0x00000000CFFFFFFF (256M used)
[    7.915217] radeon 0000:01:00.0: GTT: 512M 0x00000000A0000000 - 0x00000000BFFFFFFF
[    7.915316] [drm] Detected VRAM RAM=256M, BAR=256M
[    7.915383] [drm] RAM width 128bits DDR
[    7.915541] kobject (b8a6a825): tried to init an initialized object, something is seriously wrong.
[    7.915639] CPU: 0 PID: 110 Comm: systemd-udevd Not tainted 5.0.0 #2
[    7.915708] Hardware name:  K7VT6-C /K7VT6-C , BIOS P1.50 06/15/2006
[    7.915778] Call Trace:
[    7.915860]  dump_stack+0x16/0x19
[    7.915962]  kobject_init.cold.9+0x3b/0x4a
[    7.916036]  ? __alloc_workqueue_key+0x202/0x350
[    7.916106]  kobject_init_and_add+0x19/0x50
[    7.916205]  ttm_mem_global_init+0x85/0x360 [ttm]
[    7.916292]  ttm_bo_device_init+0x14a/0x280 [ttm]
[    7.916671]  radeon_ttm_init+0x55/0x2d0 [radeon]
[    7.916755]  ? vprintk_func+0x32/0x94
[    7.916835]  ? arch_phys_wc_add+0x18/0x80
[    7.916992]  radeon_bo_init+0xb0/0xe0 [radeon]
[    7.917151]  r300_init+0xd7/0x280 [radeon]
[    7.917285]  ? printk+0xe/0x10
[    7.917427]  ? radeon_agp_disable+0x4d/0x90 [radeon]
[    7.917570]  radeon_device_init+0x643/0xc70 [radeon]
[    7.917712]  ? cail_mc_write+0x20/0x20 [radeon]
[    7.917854]  radeon_driver_load_kms+0x99/0x1e0 [radeon]
[    7.917970]  drm_dev_register+0x118/0x1c0 [drm]
[    7.918047]  ? drm_agp_init+0x19/0xc0 [drm]
[    7.918115]  ? arch_phys_wc_add+0x18/0x80
[    7.918192]  drm_get_pci_dev+0x91/0x170 [drm]
[    7.918333]  radeon_pci_probe+0x2e/0x40 [radeon]
[    7.918406]  pci_device_probe+0x92/0x123
[    7.918480]  ? sysfs_create_link+0x26/0x40
[    7.918548]  really_probe+0xbb/0x260
[    7.918615]  driver_probe_device+0x53/0x150
[    7.918682]  ? pci_match_device+0xbc/0xf0
[    7.918749]  ? pci_bus_match+0x32/0x50
[    7.918816]  __driver_attach+0xc9/0xe0
[    7.918882]  ? driver_probe_device+0x150/0x150
[    7.918953]  bus_for_each_dev+0x53/0x90
[    7.919021]  driver_attach+0x19/0x20
[    7.919087]  ? driver_probe_device+0x150/0x150
[    7.919154]  bus_add_driver+0x197/0x210
[    7.919221]  ? pci_dma_configure+0x70/0x70
[    7.919288]  ? pci_dma_configure+0x70/0x70
[    7.919958]  driver_register+0x54/0xf0
[    7.920025]  ? vprintk_func+0x32/0x94
[    7.920092]  ? 0xf82a3000
[    7.920157]  __pci_register_driver+0x2e/0x40
[    7.920300]  radeon_init+0x7b/0x1000 [radeon]
[    7.920368]  do_one_initcall+0x77/0x17d
[    7.920437]  ? kmem_cache_alloc+0x21/0xc0
[    7.920506]  ? do_init_module+0x1a/0x1f0
[    7.920573]  do_init_module+0x51/0x1f0
[    7.920643]  ? __vunmap+0x74/0xc0
[    7.920709]  load_module+0x1f02/0x24c0
[    7.920778]  ? kernel_read+0x34/0x50
[    7.920845]  sys_finit_module+0x99/0xc0
[    7.920913]  do_fast_syscall_32+0x8e/0x1c0
[    7.920982]  entry_SYSENTER_32+0x6b/0xbd
[    7.921049] EIP: 0xb7f6379d
[    7.921117] Code: 54 cd ff ff 8b 98 58 cd ff ff 85 d2 89 c8 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[    7.921246] EAX: ffffffda EBX: 00000018 ECX: b7d70bdd EDX: 00000000
[    7.921315] ESI: 00c82de0 EDI: 00c7fbb0 EBP: 00000000 ESP: bfb446bc
[    7.921384] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200292
[    7.921487] ================================================================================
[    7.921581] UBSAN: Undefined behaviour in drivers/gpu/drm/ttm/ttm_memory.c:326:13
[    7.921674] index 2 is out of range for type 'ttm_mem_zone *[2]'
[    7.921745] CPU: 0 PID: 110 Comm: systemd-udevd Not tainted 5.0.0 #2
[    7.921813] Hardware name:  K7VT6-C /K7VT6-C , BIOS P1.50 06/15/2006
[    7.921882] Call Trace:
[    7.921953]  dump_stack+0x16/0x19
[    7.922025]  ubsan_epilogue+0xb/0x29
[    7.922092]  __ubsan_handle_out_of_bounds+0x8d/0xa0
[    7.922166]  ? __blk_mq_sched_bio_merge+0x92/0x160
[    7.922237]  ? kfree_const+0xf/0x30
[    7.922313]  ttm_mem_global_init+0x2e4/0x360 [ttm]
[    7.922385]  ttm_bo_device_init+0x14a/0x280 [ttm]
[    7.922532]  radeon_ttm_init+0x55/0x2d0 [radeon]
[    7.922600]  ? vprintk_func+0x32/0x94
[    7.922667]  ? arch_phys_wc_add+0x18/0x80
[    7.922809]  radeon_bo_init+0xb0/0xe0 [radeon]
[    7.922952]  r300_init+0xd7/0x280 [radeon]
[    7.923019]  ? printk+0xe/0x10
[    7.923158]  ? radeon_agp_disable+0x4d/0x90 [radeon]
[    7.923300]  radeon_device_init+0x643/0xc70 [radeon]
[    7.923442]  ? cail_mc_write+0x20/0x20 [radeon]
[    7.923585]  radeon_driver_load_kms+0x99/0x1e0 [radeon]
[    7.923688]  drm_dev_register+0x118/0x1c0 [drm]
[    7.923766]  ? drm_agp_init+0x19/0xc0 [drm]
[    7.923833]  ? arch_phys_wc_add+0x18/0x80
[    7.923909]  drm_get_pci_dev+0x91/0x170 [drm]
[    7.924051]  radeon_pci_probe+0x2e/0x40 [radeon]
[    7.924122]  pci_device_probe+0x92/0x123
[    7.924193]  ? sysfs_create_link+0x26/0x40
[    7.924261]  really_probe+0xbb/0x260
[    7.924327]  driver_probe_device+0x53/0x150
[    7.924394]  ? pci_match_device+0xbc/0xf0
[    7.924461]  ? pci_bus_match+0x32/0x50
[    7.924528]  __driver_attach+0xc9/0xe0
[    7.924594]  ? driver_probe_device+0x150/0x150
[    7.924665]  bus_for_each_dev+0x53/0x90
[    7.924733]  driver_attach+0x19/0x20
[    7.924798]  ? driver_probe_device+0x150/0x150
[    7.924866]  bus_add_driver+0x197/0x210
[    7.924933]  ? pci_dma_configure+0x70/0x70
[    7.924999]  ? pci_dma_configure+0x70/0x70
[    7.925066]  driver_register+0x54/0xf0
[    7.925132]  ? vprintk_func+0x32/0x94
[    7.925198]  ? 0xf82a3000
[    7.925262]  __pci_register_driver+0x2e/0x40
[    7.925403]  radeon_init+0x7b/0x1000 [radeon]
[    7.925471]  do_one_initcall+0x77/0x17d
[    7.925538]  ? kmem_cache_alloc+0x21/0xc0
[    7.925606]  ? do_init_module+0x1a/0x1f0
[    7.925672]  do_init_module+0x51/0x1f0
[    7.925740]  ? __vunmap+0x74/0xc0
[    7.925806]  load_module+0x1f02/0x24c0
[    7.925873]  ? kernel_read+0x34/0x50
[    7.925940]  sys_finit_module+0x99/0xc0
[    7.926008]  do_fast_syscall_32+0x8e/0x1c0
[    7.926076]  entry_SYSENTER_32+0x6b/0xbd
[    7.926141] EIP: 0xb7f6379d
[    7.926207] Code: 54 cd ff ff 8b 98 58 cd ff ff 85 d2 89 c8 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[    7.926336] EAX: ffffffda EBX: 00000018 ECX: b7d70bdd EDX: 00000000
[    7.926405] ESI: 00c82de0 EDI: 00c7fbb0 EBP: 00000000 ESP: bfb446bc
[    7.926474] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200292
[    7.926544] ================================================================================
[    7.926672] ================================================================================
[    7.926767] UBSAN: Undefined behaviour in drivers/gpu/drm/ttm/ttm_memory.c:363:13
[    7.926859] index 4116742240 is out of range for type 'ttm_mem_zone *[2]'
[    7.926930] CPU: 0 PID: 110 Comm: systemd-udevd Not tainted 5.0.0 #2
[    7.926999] Hardware name:  K7VT6-C /K7VT6-C , BIOS P1.50 06/15/2006
[    7.927067] Call Trace:
[    7.927135]  dump_stack+0x16/0x19
[    7.927203]  ubsan_epilogue+0xb/0x29
[    7.927270]  __ubsan_handle_out_of_bounds+0x8d/0xa0
[    7.927339]  ? kfree_const+0xf/0x30
[    7.927412]  ttm_mem_global_init+0x344/0x360 [ttm]
[    7.927484]  ttm_bo_device_init+0x14a/0x280 [ttm]
[    7.927636]  radeon_ttm_init+0x55/0x2d0 [radeon]
[    7.927704]  ? vprintk_func+0x32/0x94
[    7.927771]  ? arch_phys_wc_add+0x18/0x80
[    7.927912]  radeon_bo_init+0xb0/0xe0 [radeon]
[    7.928055]  r300_init+0xd7/0x280 [radeon]
[    7.928122]  ? printk+0xe/0x10
[    7.928261]  ? radeon_agp_disable+0x4d/0x90 [radeon]
[    7.928404]  radeon_device_init+0x643/0xc70 [radeon]
[    7.928546]  ? cail_mc_write+0x20/0x20 [radeon]
[    7.928688]  radeon_driver_load_kms+0x99/0x1e0 [radeon]
[    7.928786]  drm_dev_register+0x118/0x1c0 [drm]
[    7.928864]  ? drm_agp_init+0x19/0xc0 [drm]
[    7.928931]  ? arch_phys_wc_add+0x18/0x80
[    7.929007]  drm_get_pci_dev+0x91/0x170 [drm]
[    7.929148]  radeon_pci_probe+0x2e/0x40 [radeon]
[    7.929219]  pci_device_probe+0x92/0x123
[    7.929291]  ? sysfs_create_link+0x26/0x40
[    7.929358]  really_probe+0xbb/0x260
[    7.929425]  driver_probe_device+0x53/0x150
[    7.929492]  ? pci_match_device+0xbc/0xf0
[    7.929558]  ? pci_bus_match+0x32/0x50
[    7.929625]  __driver_attach+0xc9/0xe0
[    7.929691]  ? driver_probe_device+0x150/0x150
[    7.929762]  bus_for_each_dev+0x53/0x90
[    7.929829]  driver_attach+0x19/0x20
[    7.929894]  ? driver_probe_device+0x150/0x150
[    7.929962]  bus_add_driver+0x197/0x210
[    7.930029]  ? pci_dma_configure+0x70/0x70
[    7.930095]  ? pci_dma_configure+0x70/0x70
[    7.930162]  driver_register+0x54/0xf0
[    7.930228]  ? vprintk_func+0x32/0x94
[    7.930294]  ? 0xf82a3000
[    7.930359]  __pci_register_driver+0x2e/0x40
[    7.930500]  radeon_init+0x7b/0x1000 [radeon]
[    7.930567]  do_one_initcall+0x77/0x17d
[    7.930635]  ? kmem_cache_alloc+0x21/0xc0
[    7.930702]  ? do_init_module+0x1a/0x1f0
[    7.930768]  do_init_module+0x51/0x1f0
[    7.930836]  ? __vunmap+0x74/0xc0
[    7.930902]  load_module+0x1f02/0x24c0
[    7.930969]  ? kernel_read+0x34/0x50
[    7.931036]  sys_finit_module+0x99/0xc0
[    7.931104]  do_fast_syscall_32+0x8e/0x1c0
[    7.931172]  entry_SYSENTER_32+0x6b/0xbd
[    7.931238] EIP: 0xb7f6379d
[    7.931304] Code: 54 cd ff ff 8b 98 58 cd ff ff 85 d2 89 c8 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[    7.931432] EAX: ffffffda EBX: 00000018 ECX: b7d70bdd EDX: 00000000
[    7.931501] ESI: 00c82de0 EDI: 00c7fbb0 EBP: 00000000 ESP: bfb446bc
[    7.931571] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200292
[    7.931641] ================================================================================
[    7.931754] [TTM] Zone  kernel: Available graphics memory: 439676 kiB
[    7.931824] [TTM] Zone highmem: Available graphics memory: 1035616 kiB
[    7.931897] ================================================================================
[    7.931990] UBSAN: Undefined behaviour in drivers/gpu/drm/ttm/ttm_memory.c:450:21
[    7.932082] index 2 is out of range for type 'ttm_mem_zone *[2]'
[    7.932152] CPU: 0 PID: 110 Comm: systemd-udevd Not tainted 5.0.0 #2
[    7.932220] Hardware name:  K7VT6-C /K7VT6-C , BIOS P1.50 06/15/2006
[    7.932289] Call Trace:
[    7.932357]  dump_stack+0x16/0x19
[    7.932424]  ubsan_epilogue+0xb/0x29
[    7.932491]  __ubsan_handle_out_of_bounds+0x8d/0xa0
[    7.932560]  ? vprintk_func+0x32/0x94
[    7.932633]  ttm_mem_global_init+0x358/0x360 [ttm]
[    7.932705]  ttm_bo_device_init+0x14a/0x280 [ttm]
[    7.932849]  radeon_ttm_init+0x55/0x2d0 [radeon]
[    7.932918]  ? vprintk_func+0x32/0x94
[    7.932984]  ? arch_phys_wc_add+0x18/0x80
[    7.933125]  radeon_bo_init+0xb0/0xe0 [radeon]
[    7.933268]  r300_init+0xd7/0x280 [radeon]
[    7.933335]  ? printk+0xe/0x10
[    7.933474]  ? radeon_agp_disable+0x4d/0x90 [radeon]
[    7.934200]  radeon_device_init+0x643/0xc70 [radeon]
[    7.934342]  ? cail_mc_write+0x20/0x20 [radeon]
[    7.934485]  radeon_driver_load_kms+0x99/0x1e0 [radeon]
[    7.934581]  drm_dev_register+0x118/0x1c0 [drm]
[    7.934659]  ? drm_agp_init+0x19/0xc0 [drm]
[    7.934726]  ? arch_phys_wc_add+0x18/0x80
[    7.934802]  drm_get_pci_dev+0x91/0x170 [drm]
[    7.934944]  radeon_pci_probe+0x2e/0x40 [radeon]
[    7.935014]  pci_device_probe+0x92/0x123
[    7.935084]  ? sysfs_create_link+0x26/0x40
[    7.935152]  really_probe+0xbb/0x260
[    7.935219]  driver_probe_device+0x53/0x150
[    7.935285]  ? pci_match_device+0xbc/0xf0
[    7.935352]  ? pci_bus_match+0x32/0x50
[    7.935419]  __driver_attach+0xc9/0xe0
[    7.935485]  ? driver_probe_device+0x150/0x150
[    7.935555]  bus_for_each_dev+0x53/0x90
[    7.935622]  driver_attach+0x19/0x20
[    7.935688]  ? driver_probe_device+0x150/0x150
[    7.935756]  bus_add_driver+0x197/0x210
[    7.935823]  ? pci_dma_configure+0x70/0x70
[    7.935889]  ? pci_dma_configure+0x70/0x70
[    7.935956]  driver_register+0x54/0xf0
[    7.936022]  ? vprintk_func+0x32/0x94
[    7.936088]  ? 0xf82a3000
[    7.936152]  __pci_register_driver+0x2e/0x40
[    7.936294]  radeon_init+0x7b/0x1000 [radeon]
[    7.936362]  do_one_initcall+0x77/0x17d
[    7.936429]  ? kmem_cache_alloc+0x21/0xc0
[    7.936496]  ? do_init_module+0x1a/0x1f0
[    7.936562]  do_init_module+0x51/0x1f0
[    7.936631]  ? __vunmap+0x74/0xc0
[    7.936696]  load_module+0x1f02/0x24c0
[    7.936764]  ? kernel_read+0x34/0x50
[    7.936831]  sys_finit_module+0x99/0xc0
[    7.936899]  do_fast_syscall_32+0x8e/0x1c0
[    7.936967]  entry_SYSENTER_32+0x6b/0xbd
[    7.937032] EIP: 0xb7f6379d
[    7.937098] Code: 54 cd ff ff 8b 98 58 cd ff ff 85 d2 89 c8 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[    7.937227] EAX: ffffffda EBX: 00000018 ECX: b7d70bdd EDX: 00000000
[    7.937296] ESI: 00c82de0 EDI: 00c7fbb0 EBP: 00000000 ESP: bfb446bc
[    7.937365] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200292
[    7.937435] ================================================================================
[    7.938505] BUG: unable to handle kernel paging request at 00f80c53
[    7.938507] #PF error: [normal kernel read fault]
[    7.938508] *pde = 7f891067
[    7.938509] Oops: 0000 [#1]
[    7.938510] CPU: 0 PID: 110 Comm: systemd-udevd Not tainted 5.0.0 #2
[    7.938511] Hardware name:  K7VT6-C /K7VT6-C , BIOS P1.50 06/15/2006
[    7.938511] EIP: string+0x29/0x90
[    7.938514] Code: 00 55 89 e5 57 56 89 d6 53 83 ec 14 8b 7d 0c 8b 55 08 89 7d e8 c1 ff 10 81 f9 ff 0f 00 00 89 55 ec 89 7d f0 76 53 85 ff 74 60 <0f> b6 19 31 d2 8d 79 01 84 db 74 23 b9 01 00 00 00 eb 0e 8d 74 26
[    7.938514] EAX: df7a0bcd EBX: f5471a48 ECX: 00f80c53 EDX: 00000704
[    7.938515] ESI: df7a0fa0 EDI: ffffffff EBP: f5471940 ESP: f5471920
[    7.938516] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00210086
[    7.938517] CR0: 80050033 CR2: 00f80c53 CR3: 354cf000 CR4: 000006d0
[    7.938517] Call Trace:
[    7.938518]  ? format_decode+0x300/0x3e0
[    7.938518]  vsnprintf+0x107/0x4c0
[    7.938519]  vscnprintf+0x16/0x30
[    7.938520]  vprintk_store+0x2b/0x1f0
[    7.938520]  ? apic_timer_interrupt+0xd4/0xdc
[    7.938521]  vprintk_emit+0x63/0x190
[    7.938521]  vprintk_default+0x32/0x40
[    7.938522]  vprintk_func+0x32/0x94
[    7.938522]  printk+0xe/0x10
[    7.938523]  ttm_mem_global_init+0x328/0x360 [ttm]
[    7.938524]  ttm_bo_device_init+0x14a/0x280 [ttm]
[    7.938524]  radeon_ttm_init+0x55/0x2d0 [radeon]
[    7.938525]  ? vprintk_func+0x32/0x94
[    7.938526]  ? arch_phys_wc_add+0x18/0x80
[    7.938526]  radeon_bo_init+0xb0/0xe0 [radeon]
[    7.938527]  r300_init+0xd7/0x280 [radeon]
[    7.938527]  ? printk+0xe/0x10
[    7.938528]  ? radeon_agp_disable+0x4d/0x90 [radeon]
[    7.938529]  radeon_device_init+0x643/0xc70 [radeon]
[    7.938529]  ? cail_mc_write+0x20/0x20 [radeon]
[    7.938530]  radeon_driver_load_kms+0x99/0x1e0 [radeon]
[    7.938531]  drm_dev_register+0x118/0x1c0 [drm]
[    7.938531]  ? drm_agp_init+0x19/0xc0 [drm]
[    7.938532]  ? arch_phys_wc_add+0x18/0x80
[    7.938532]  drm_get_pci_dev+0x91/0x170 [drm]
[    7.938533]  radeon_pci_probe+0x2e/0x40 [radeon]
[    7.938534]  pci_device_probe+0x92/0x123
[    7.938534]  ? sysfs_create_link+0x26/0x40
[    7.938535]  really_probe+0xbb/0x260
[    7.938535]  driver_probe_device+0x53/0x150
[    7.938536]  ? pci_match_device+0xbc/0xf0
[    7.938537]  ? pci_bus_match+0x32/0x50
[    7.938537]  __driver_attach+0xc9/0xe0
[    7.938538]  ? driver_probe_device+0x150/0x150
[    7.938538]  bus_for_each_dev+0x53/0x90
[    7.938539]  driver_attach+0x19/0x20
[    7.938540]  ? driver_probe_device+0x150/0x150
[    7.938540]  bus_add_driver+0x197/0x210
[    7.938541]  ? pci_dma_configure+0x70/0x70
[    7.938541]  ? pci_dma_configure+0x70/0x70
[    7.938542]  driver_register+0x54/0xf0
[    7.938543]  ? vprintk_func+0x32/0x94
[    7.938543]  ? 0xf82a3000
[    7.938544]  __pci_register_driver+0x2e/0x40
[    7.938544]  radeon_init+0x7b/0x1000 [radeon]
[    7.938545]  do_one_initcall+0x77/0x17d
[    7.938545]  ? kmem_cache_alloc+0x21/0xc0
[    7.938546]  ? do_init_module+0x1a/0x1f0
[    7.938547]  do_init_module+0x51/0x1f0
[    7.938547]  ? __vunmap+0x74/0xc0
[    7.938548]  load_module+0x1f02/0x24c0
[    7.938548]  ? kernel_read+0x34/0x50
[    7.938549]  sys_finit_module+0x99/0xc0
[    7.938549]  do_fast_syscall_32+0x8e/0x1c0
[    7.938550]  entry_SYSENTER_32+0x6b/0xbd
[    7.938551] EIP: 0xb7f6379d
[    7.938552] Code: 54 cd ff ff 8b 98 58 cd ff ff 85 d2 89 c8 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
[    7.938553] EAX: ffffffda EBX: 00000018 ECX: b7d70bdd EDX: 00000000
[    7.938554] ESI: 00c82de0 EDI: 00c7fbb0 EBP: 00000000 ESP: bfb446bc
[    7.938555] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00200292
[    7.938555] Modules linked in: radeon(+) i2c_algo_bit backlight evdev drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm snd_via82xx snd_ac97_codec drm pcspkr psmouse ac97_bus snd_mpu401 snd_pcm drm_panel_orientation_quirks sg snd_mpu401_uart snd_timer snd_rawmidi snd_seq_device via_agp snd agpgart soundcore via_rhine ns558 gameport i2c_viapro parport_pc mii button parport floppy processor w83627hf hwmon_vid hwmon autofs4
[    7.938572] CR2: 0000000000f80c53
[    7.938573] ---[ end trace 66968c9653ae31dd ]---
[    7.938574] EIP: string+0x29/0x90
[    7.938576] Code: 00 55 89 e5 57 56 89 d6 53 83 ec 14 8b 7d 0c 8b 55 08 89 7d e8 c1 ff 10 81 f9 ff 0f 00 00 89 55 ec 89 7d f0 76 53 85 ff 74 60 <0f> b6 19 31 d2 8d 79 01 84 db 74 23 b9 01 00 00 00 eb 0e 8d 74 26
[    7.938576] EAX: df7a0bcd EBX: f5471a48 ECX: 00f80c53 EDX: 00000704
[    7.938577] ESI: df7a0fa0 EDI: ffffffff EBP: f5471940 ESP: df79439c
[    7.938578] DS: 007b ES: 007b FS: 0000 GS: 00e0 SS: 0068 EFLAGS: 00210086
[    7.938579] CR0: 80050033 CR2: 00f80c53 CR3: 354cf000 CR4: 000006d0
[    8.201765] Adding 2096124k swap on /dev/sda5.  Priority:-2 extents:1 across:2096124k

  

-- 
Meelis Roos <mroos@linux.ee>
