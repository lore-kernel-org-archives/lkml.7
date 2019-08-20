Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6DAC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533E7206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 06:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl2aRnYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbfHTGLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 02:11:24 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46315 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbfHTGLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 02:11:23 -0400
Received: by mail-lf1-f65.google.com with SMTP id n19so3167252lfe.13;
        Mon, 19 Aug 2019 23:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P5VeKMz0oJaiw6CUYmrII92TVqJOFky0R7VP7UA3qVo=;
        b=Vl2aRnYZODSoudEF0xAP4fCFcrWVJmdEEl0oon9PJjlnO0mSUcereJdqNiKa0WXJNd
         E6BnN6+XGsE0wCcUWGl9m+CzZkUBuPEd157YSjml9WNn2HvcHnsxkwQuno0FBGhp/hGn
         ddmwWPt4bPOacoW8OhRG2Yc8QkzYlCG+/75Ham9tv7+OCJCQXcaD63xAKQ2UOBq//ucc
         xjE1/g/UoWhK2tGFFX4PRUeVbiVqQy3Q36gNrEIDamdVYCiA+B2q8o8um1lzLiWZ2m3B
         jAoeq4NTP+wGKRGhohWULUlyfHCQdJNRO8PwnxhYlhmYuVLGxHYTwCtBGT8D2QyTA9d3
         +Pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P5VeKMz0oJaiw6CUYmrII92TVqJOFky0R7VP7UA3qVo=;
        b=uKVWt8CDO+sGZatfBt+WtU1vxgpYmHieLOUYIyBT5JMNLwC6zmZteJpWd9nec6g2fc
         KCwxkXfgDgIZHG2A+H1IQzaAVXxbprHbFDLKMqDH63YQB1F4mZkI3sJ5p+XzvJGSo3QI
         PqK+4QyfcJL8TeGNfEjpuTqvwDtoeM07vaJEg1Kr0rzyexu14trg1BhEwwCti0kR+jKK
         mY06jv7alYPPKux5BRQoh/BGnwrxcBLGo+A2oDAf6LDglZF9IKc6R4pThwroXvW52HrO
         B9U3Gc/f0K+sNXU3rJddCksVz78vnQ6Mtrje5N9NJzo06zLWdL02SPU29qkSLvhsWs+O
         AOlA==
X-Gm-Message-State: APjAAAU7PuLjVXUuIjZTNmMO6S6eJGAZqW0dKXlL09aCCQFDDpxnbvOq
        Ab78u6W0KUBg74XFbCKAK4ZpMpZa6/sEvjSKsQk=
X-Google-Smtp-Source: APXvYqxYOs2lEb1R03xowmNilmLAur05UjtN60C0cUjkR6N0j9CB7D+jLzq59z/Wkf1WxDn6gIc2qz3VNwzdg06qtPw=
X-Received: by 2002:a19:2297:: with SMTP id i145mr13823403lfi.97.1566281473001;
 Mon, 19 Aug 2019 23:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190816083246.169312-1-arul.jeniston@gmail.com>
 <CACAVd4iXVH2U41msVKhT4GBGgE=2V2oXnOXkQUQKSSh72HMMmw@mail.gmail.com>
 <alpine.DEB.2.21.1908161224220.1873@nanos.tec.linutronix.de>
 <CACAVd4h05P2tWb7Eh1+3_0Cm7MkDNAt+SJVoBT4gErBfsBmsAQ@mail.gmail.com>
 <CACAVd4gHQ+_y5QBSQm3pMFHKrVgvvJZAABGvtp6=qt3drVXpTA@mail.gmail.com>
 <alpine.DEB.2.21.1908162255400.1923@nanos.tec.linutronix.de>
 <CACAVd4hT6QYtgtDsBcgy7c_s9WVBAH+1m0r5geBe7BUWJWYhbA@mail.gmail.com>
 <alpine.DEB.2.21.1908171942370.1923@nanos.tec.linutronix.de>
 <CACAVd4jfoSUK4xgLByKeMY5ZPHZ40exY+74e4fOcBDPeoLpqQg@mail.gmail.com>
 <alpine.DEB.2.21.1908190947290.1923@nanos.tec.linutronix.de>
 <CACAVd4izozzXNF9qwNcXC+EUx5n1sfsNeb9JNXNJF56LdZkkYg@mail.gmail.com>
 <alpine.DEB.2.21.1908191646350.2147@nanos.tec.linutronix.de>
 <CACAVd4j60pn=td5hh485SJOcoYZ_jWQDQg2DVasSodPtsaupkw@mail.gmail.com>
 <alpine.DEB.2.21.1908191752580.2147@nanos.tec.linutronix.de>
 <CACAVd4iRN7=eq_B1+Yb-xcspU-Sg1dmMo_=VtLXXVPkjN1hY5Q@mail.gmail.com> <alpine.DEB.2.21.1908191943280.1796@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1908191943280.1796@nanos.tec.linutronix.de>
From:   Arul Jeniston <arul.jeniston@gmail.com>
Date:   Tue, 20 Aug 2019 11:41:00 +0530
Message-ID: <CACAVd4jAJ5QcOH=q=Q9kAz20X4_nAc7=vVU_gPWTS1UuiGK-fg@mail.gmail.com>
Subject: Re: [PATCH] FS: timerfd: Fix unexpected return value of timerfd_read function.
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, arul_mc@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Tglx

Agreed. Please find the dmesg output below. We see the problem on
[1456773.366951].
Let us know if you find anything suspicious.


[    0.000000] Linux version 4.9.0-8-amd64
(debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian
6.3.0-18+deb9u1) ) #1 SMP Debian 4.9.110-3+deb9u6 (2015-12-19)
[    0.000000] Command line:
BOOT_IMAGE=/image-20181130.26/boot/vmlinuz-4.9.0-8-amd64
root=/dev/sda8 rw console=tty0 console=ttyS1,9600n8 quiet
net.ifnames=0 biosdevname=0 loop=image-20181130.26/fs.squashfs
loopfstype=squashfs apparmor=1 security=apparmor varlog_size=4096
usbcore.autosuspend=-1 module_blacklist=gpio_ich
[    0.000000] x86/fpu: Legacy x87 FPU detected.
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009abff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009ac00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000bedb5fff] usable
[    0.000000] BIOS-e820: [mem 0x00000000bedb6000-0x00000000bede5fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bede6000-0x00000000bedf5fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000bedf6000-0x00000000bf4b7fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000bf4b8000-0x00000000bf66afff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000bf66b000-0x00000000bf7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000e0000000-0x00000000e3ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed01000-0x00000000fed03fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed08000-0x00000000fed08fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed0c000-0x00000000fed0ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed1cfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fef00000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff800000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.8 present.
[    0.000000] DMI: Dell, Inc. S6100/S6100-CPU, BIOS 5.6.5 07/26/2016
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x240000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 0C0000000 mask FC0000000 uncachable
[    0.000000]   1 base 240000000 mask FC0000000 uncachable
[    0.000000]   2 base 280000000 mask F80000000 uncachable
[    0.000000]   3 base 300000000 mask F00000000 uncachable
[    0.000000]   4 base 400000000 mask C00000000 uncachable
[    0.000000]   5 base 800000000 mask 800000000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86/PAT: Configuration [0-7]: WB  WT  UC- UC  WB  WT  UC- UC
[    0.000000] e820: last_pfn = 0xbf800 max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fd880-0x000fd88f]
mapped at [ffff96ea400fd880]
[    0.000000] Base memory trampoline at [ffff96ea40094000] 94000 size 24576
[    0.000000] BRK [0x10453a000, 0x10453afff] PGTABLE
[    0.000000] BRK [0x10453b000, 0x10453bfff] PGTABLE
[    0.000000] BRK [0x10453c000, 0x10453cfff] PGTABLE
[    0.000000] BRK [0x10453d000, 0x10453dfff] PGTABLE
[    0.000000] BRK [0x10453e000, 0x10453efff] PGTABLE
[    0.000000] BRK [0x10453f000, 0x10453ffff] PGTABLE
[    0.000000] BRK [0x104540000, 0x104540fff] PGTABLE
[    0.000000] BRK [0x104541000, 0x104541fff] PGTABLE
[    0.000000] BRK [0x104542000, 0x104542fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x353e8000-0x369ebfff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F0530 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x00000000BEDF2090 00009C (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x00000000BEDF4630 00010C (v05 ALASKA A M I
  01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x00000000BEDF21B8 002476 (v02 ALASKA A M I
  01072009 INTL 20061109)
[    0.000000] ACPI: FACS 0x00000000BF4B5F80 000040
[    0.000000] ACPI: FPDT 0x00000000BEDF4740 000044 (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.000000] ACPI: FIDT 0x00000000BEDF4788 00009C (v01 ALASKA A M I
  01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x00000000BEDF4828 00003C (v01 ALASKA A M I
  01072009 MSFT 00000097)
[    0.000000] ACPI: WDAT 0x00000000BEDF4868 0001AC (v01 ALASKA A M I
  01072009 MSFT 00010013)
[    0.000000] ACPI: UEFI 0x00000000BEDF4A18 000042 (v01
  00000000      00000000)
[    0.000000] ACPI: APIC 0x00000000BEDF4A60 000078 (v03 INTEL  TIANO
  00000001 MSFT 00000000)
[    0.000000] ACPI: BDAT 0x00000000BEDF4AD8 000030 (v01
  00000000      00000000)
[    0.000000] ACPI: HPET 0x00000000BEDF4B08 000038 (v01 INTEL
  00000001 MSFT 01000013)
[    0.000000] ACPI: SSDT 0x00000000BEDF4B40 0009F1 (v01 PmRef  CpuPm
  00003000 INTL 20061109)
[    0.000000] ACPI: SPCR 0x00000000BEDF5538 000050 (v01 A M I  APTIO
V  01072009 AMI. 00000005)
[    0.000000] ACPI: HEST 0x00000000BEDF5588 0000A8 (v01 INTEL  AVOTON
B 00000001 INTL 00000001)
[    0.000000] ACPI: BERT 0x00000000BEDF5630 000030 (v01 INTEL  AVOTON
B 00000001 INTL 00000001)
[    0.000000] ACPI: ERST 0x00000000BEDF5660 000230 (v01 INTEL  AVOTON
B 00000001 INTL 00000001)
[    0.000000] ACPI: EINJ 0x00000000BEDF5890 000150 (v01 INTEL  AVOTON
B 00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000023fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x23fff7000-0x23fffbfff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000023fffffff]
[    0.000000]   Device   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x0000000000099fff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x00000000bedb5fff]
[    0.000000]   node   0: [mem 0x00000000bf66b000-0x00000000bf7fffff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000023fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000023fffffff]
[    0.000000] On node 0 totalpages: 2092772
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3993 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 12158 pages used for memmap
[    0.000000]   DMA32 zone: 778059 pages, LIFO batch:31
[    0.000000]   Normal zone: 20480 pages used for memmap
[    0.000000]   Normal zone: 1310720 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009a000-0x0009afff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009b000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xbedb6000-0xbede5fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbede6000-0xbedf5fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbedf6000-0xbf4b7fff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf4b8000-0xbf66afff]
[    0.000000] PM: Registered nosave memory: [mem 0xbf800000-0xdfffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe0000000-0xe3ffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xe4000000-0xfed00fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed01000-0xfed03fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed04000-0xfed07fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed08000-0xfed08fff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed09000-0xfed0bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed0c000-0xfed0ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed10000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed1cfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1d000-0xfeefffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfef00000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xff7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff800000-0xffffffff]
[    0.000000] e820: [mem 0xbf800000-0xdfffffff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff
max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:512 nr_cpumask_bits:512
nr_cpu_ids:4 nr_node_ids:1
[    0.000000] percpu: Embedded 35 pages/cpu @ffff96ec7fc00000 s105304
r8192 d29864 u524288
[    0.000000] pcpu-alloc: s105304 r8192 d29864 u524288 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 1 2 3
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.
Total pages: 2060049
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line:
BOOT_IMAGE=/image-20181130.26/boot/vmlinuz-4.9.0-8-amd64
root=/dev/sda8 rw console=tty0 console=ttyS1,9600n8 quiet
net.ifnames=0 biosdevname=0 loop=image-20181130.26/fs.squashfs
loopfstype=squashfs apparmor=1 security=apparmor varlog_size=4096
usbcore.autosuspend=-1 module_blacklist=gpio_ich
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 8135136K/8371088K available (6250K kernel code,
1159K rwdata, 2876K rodata, 1420K init, 688K bss, 235952K reserved, 0K
cma-reserved)
[    0.000000] Kernel/User page tables isolation: enabled
[    0.000000] Hierarchical RCU implementation.
[    0.000000] Build-time adjustment of leaf fanout to 64.
[    0.000000] RCU restricting CPUs from NR_CPUS=512 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:33024 nr_irqs:456 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] console [ttyS1] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2400.001 MHz processor
[    0.000030] Calibrating delay loop (skipped), value calculated
using timer frequency.. 4800.00 BogoMIPS (lpj=9600004)
[    0.000034] pid_max: default: 32768 minimum: 301
[    0.000065] ACPI: Core revision 20160831
[    0.003662] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.003749] Security Framework initialized
[    0.003752] Yama: disabled by default; enable with sysctl kernel.yama.*
[    0.003766] AppArmor: AppArmor initialized
[    0.004472] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes)
[    0.007913] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    0.009489] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
[    0.009505] Mountpoint-cache hash table entries: 16384 (order: 5,
131072 bytes)
[    0.010016] mce: CPU supports 6 MCE banks
[    0.010025] CPU0: Thermal monitoring enabled (TM1)
[    0.010031] process: using mwait in idle threads
[    0.010035] Last level iTLB entries: 4KB 48, 2MB 0, 4MB 0
[    0.010037] Last level dTLB entries: 4KB 128, 2MB 16, 4MB 16, 1GB 0
[    0.010041] Spectre V2 : Mitigation: Full generic retpoline
[    0.010042] Spectre V2 : Spectre v2 / SpectreRSB mitigation:
Filling RSB on context switch
[    0.010400] Freeing SMP alternatives memory: 24K
[    0.012287] ftrace: allocating 25265 entries in 99 pages
[    0.034129] smpboot: Max logical packages: 1
[    0.034574] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.074265] TSC deadline timer enabled
[    0.074270] smpboot: CPU0: Intel(R) Atom(TM) CPU  C2538  @ 2.40GHz
(family: 0x6, model: 0x4d, stepping: 0x8)
[    0.074276] Performance Events: PEBS fmt2+, 8-deep LBR, Silvermont
events, 8-deep LBR, full-width counters, Intel PMU driver.
[    0.074298] ... version:                3
[    0.074299] ... bit width:              40
[    0.074300] ... generic registers:      2
[    0.074301] ... value mask:             000000ffffffffff
[    0.074302] ... max period:             0000007fffffffff
[    0.074303] ... fixed-purpose events:   3
[    0.074304] ... event mask:             0000000700000003
[    0.075371] NMI watchdog: enabled on all CPUs, permanently consumes
one hw-PMU counter.
[    0.075657] x86: Booting SMP configuration:
[    0.075659] .... node  #0, CPUs:      #1 #2 #3
[    0.082734] x86: Booted up 1 node, 4 CPUs
[    0.082738] smpboot: Total of 4 processors activated (19200.00 BogoMIPS)
[    0.084263] devtmpfs: initialized
[    0.084403] x86/mm: Memory block size: 128MB
[    0.091277] PM: Registering ACPI NVS region [mem
0xbedf6000-0xbf4b7fff] (7086080 bytes)
[    0.091673] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.091687] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.091772] pinctrl core: initialized pinctrl subsystem
[    0.091993] NET: Registered protocol family 16
[    0.108318] cpuidle: using governor ladder
[    0.120327] cpuidle: using governor menu
[    0.120409] ACPI: bus type PCI registered
[    0.120411] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.120535] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem
0xe0000000-0xefffffff] (base 0xe0000000)
[    0.120538] PCI: MMCONFIG at [mem 0xe0000000-0xefffffff] reserved in E820
[    0.120541] PCI: MMCONFIG for 0000 [bus00-3f] at [mem
0xe0000000-0xe3ffffff] (base 0xe0000000) (size reduced!)
[    0.120555] PCI: Using configuration type 1 for base access
[    0.132670] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.133308] ACPI: Added _OSI(Module Device)
[    0.133310] ACPI: Added _OSI(Processor Device)
[    0.133312] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.133313] ACPI: Added _OSI(Processor Aggregator Device)
[    0.136417] ACPI: Dynamic OEM Table Load:
[    0.136426] ACPI: SSDT 0xFFFF96EC75C79800 00044E (v01 PmRef
Cpu0Ist  00003000 INTL 20061109)
[    0.136686] ACPI: Dynamic OEM Table Load:
[    0.136693] ACPI: SSDT 0xFFFF96EC75C78E00 0001FA (v01 PmRef
Cpu0Cst  00003001 INTL 20061109)
[    0.137383] ACPI: Dynamic OEM Table Load:
[    0.137391] ACPI: SSDT 0xFFFF96EC75CA7800 00047A (v01 PmRef  ApIst
  00003000 INTL 20061109)
[    0.138046] ACPI: Dynamic OEM Table Load:
[    0.138052] ACPI: SSDT 0xFFFF96EC75C78A00 000119 (v01 PmRef  ApCst
  00003000 INTL 20061109)
[    0.139369] ACPI: Interpreter enabled
[    0.139387] ACPI: (supports S0 S5)
[    0.139389] ACPI: Using IOAPIC for interrupt routing
[    0.139502] HEST: Table parsing has been initialized.
[    0.139506] PCI: Using host bridge windows from ACPI; if necessary,
use "pci=nocrs" and report a bug
[    0.146038] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.146046] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM
ClockPM Segments MSI]
[    0.146606] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME
AER PCIeCapability]
[    0.146621] acpi PNP0A08:00: [Firmware Info]: MMCONFIG for domain
0000 [bus 00-3f] only partially covers this bridge
[    0.147092] PCI host bridge to bus 0000:00
[    0.147097] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.147099] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.147102] pci_bus 0000:00: root bus resource [mem
0x000a0000-0x000bffff window]
[    0.147104] pci_bus 0000:00: root bus resource [mem
0xc0000000-0xdfffffff window]
[    0.147107] pci_bus 0000:00: root bus resource [mem
0x240000000-0xfffffffff window]
[    0.147110] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.147120] pci 0000:00:00.0: [8086:1f0c] type 00 class 0x060000
[    0.147282] pci 0000:00:01.0: [8086:1f10] type 01 class 0x060400
[    0.147301] pci 0000:00:01.0: reg 0x10: [mem 0xdffc0000-0xdffdffff 64bit]
[    0.147352] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.147441] pci 0000:00:01.0: System wakeup disabled by ACPI
[    0.147514] pci 0000:00:02.0: [8086:1f11] type 01 class 0x060400
[    0.147532] pci 0000:00:02.0: reg 0x10: [mem 0xdffa0000-0xdffbffff 64bit]
[    0.147582] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.147669] pci 0000:00:02.0: System wakeup disabled by ACPI
[    0.147743] pci 0000:00:03.0: [8086:1f12] type 01 class 0x060400
[    0.147761] pci 0000:00:03.0: reg 0x10: [mem 0xdff80000-0xdff9ffff 64bit]
[    0.147810] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.147897] pci 0000:00:03.0: System wakeup disabled by ACPI
[    0.147969] pci 0000:00:04.0: [8086:1f13] type 01 class 0x060400
[    0.147987] pci 0000:00:04.0: reg 0x10: [mem 0xdff60000-0xdff7ffff 64bit]
[    0.148037] pci 0000:00:04.0: PME# supported from D0 D3hot D3cold
[    0.148123] pci 0000:00:04.0: System wakeup disabled by ACPI
[    0.148203] pci 0000:00:0e.0: [8086:1f14] type 00 class 0x060000
[    0.148374] pci 0000:00:0f.0: [8086:1f16] type 00 class 0x080600
[    0.148431] pci 0000:00:0f.0: PME# supported from D0 D3hot D3cold
[    0.148589] pci 0000:00:13.0: [8086:1f15] type 00 class 0x088000
[    0.148610] pci 0000:00:13.0: reg 0x10: [mem 0xdfff0000-0xdfff03ff 64bit]
[    0.148835] pci 0000:00:14.0: [8086:1f41] type 00 class 0x020000
[    0.148854] pci 0000:00:14.0: reg 0x10: [mem 0xdff40000-0xdff5ffff 64bit]
[    0.148863] pci 0000:00:14.0: reg 0x18: [io  0xf0a0-0xf0bf]
[    0.148882] pci 0000:00:14.0: reg 0x20: [mem 0xdffe8000-0xdffebfff 64bit]
[    0.148942] pci 0000:00:14.0: PME# supported from D0 D3hot D3cold
[    0.149106] pci 0000:00:14.1: [8086:1f41] type 00 class 0x020000
[    0.149125] pci 0000:00:14.1: reg 0x10: [mem 0xdff20000-0xdff3ffff 64bit]
[    0.149135] pci 0000:00:14.1: reg 0x18: [io  0xf080-0xf09f]
[    0.149154] pci 0000:00:14.1: reg 0x20: [mem 0xdffe4000-0xdffe7fff 64bit]
[    0.149214] pci 0000:00:14.1: PME# supported from D0 D3hot D3cold
[    0.149378] pci 0000:00:14.2: [8086:1f41] type 00 class 0x020000
[    0.149397] pci 0000:00:14.2: reg 0x10: [mem 0xdff00000-0xdff1ffff 64bit]
[    0.149406] pci 0000:00:14.2: reg 0x18: [io  0xf060-0xf07f]
[    0.149426] pci 0000:00:14.2: reg 0x20: [mem 0xdffe0000-0xdffe3fff 64bit]
[    0.149486] pci 0000:00:14.2: PME# supported from D0 D3hot D3cold
[    0.149660] pci 0000:00:16.0: [8086:1f2c] type 00 class 0x0c0320
[    0.149683] pci 0000:00:16.0: reg 0x10: [mem 0xdffef000-0xdffef3ff]
[    0.149792] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.149879] pci 0000:00:16.0: System wakeup disabled by ACPI
[    0.149952] pci 0000:00:17.0: [8086:1f22] type 00 class 0x010601
[    0.149968] pci 0000:00:17.0: reg 0x10: [io  0xf130-0xf137]
[    0.149977] pci 0000:00:17.0: reg 0x14: [io  0xf120-0xf123]
[    0.149985] pci 0000:00:17.0: reg 0x18: [io  0xf110-0xf117]
[    0.149993] pci 0000:00:17.0: reg 0x1c: [io  0xf100-0xf103]
[    0.150001] pci 0000:00:17.0: reg 0x20: [io  0xf040-0xf05f]
[    0.150010] pci 0000:00:17.0: reg 0x24: [mem 0xdffee000-0xdffee7ff]
[    0.150053] pci 0000:00:17.0: PME# supported from D3hot
[    0.150202] pci 0000:00:18.0: [8086:1f32] type 00 class 0x010601
[    0.150218] pci 0000:00:18.0: reg 0x10: [io  0xf0f0-0xf0f7]
[    0.150226] pci 0000:00:18.0: reg 0x14: [io  0xf0e0-0xf0e3]
[    0.150235] pci 0000:00:18.0: reg 0x18: [io  0xf0d0-0xf0d7]
[    0.150243] pci 0000:00:18.0: reg 0x1c: [io  0xf0c0-0xf0c3]
[    0.150251] pci 0000:00:18.0: reg 0x20: [io  0xf020-0xf03f]
[    0.150259] pci 0000:00:18.0: reg 0x24: [mem 0xdffed000-0xdffed7ff]
[    0.150303] pci 0000:00:18.0: PME# supported from D3hot
[    0.150455] pci 0000:00:1f.0: [8086:1f38] type 00 class 0x060100
[    0.150663] pci 0000:00:1f.3: [8086:1f3c] type 00 class 0x0c0500
[    0.150679] pci 0000:00:1f.3: reg 0x10: [mem 0xdffec000-0xdffec01f]
[    0.150717] pci 0000:00:1f.3: reg 0x20: [io  0xf000-0xf01f]
[    0.150973] pci 0000:01:00.0: [14e4:b960] type 00 class 0x020000
[    0.150995] pci 0000:01:00.0: reg 0x10: [mem 0xdf808000-0xdf80ffff
64bit pref]
[    0.151010] pci 0000:01:00.0: reg 0x18: [mem 0xdf000000-0xdf7fffff
64bit pref]
[    0.151119] pci 0000:01:00.0: PME# supported from D0 D3hot D3cold
[    0.151249] pci 0000:01:00.1: [14e4:b960] type 00 class 0x020000
[    0.151271] pci 0000:01:00.1: reg 0x10: [mem 0xdf800000-0xdf807fff
64bit pref]
[    0.151286] pci 0000:01:00.1: reg 0x18: [mem 0xde800000-0xdeffffff
64bit pref]
[    0.151385] pci 0000:01:00.1: PME# supported from D0 D3hot D3cold
[    0.162746] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.162755] pci 0000:00:01.0:   bridge window [mem
0xde800000-0xdf8fffff 64bit pref]
[    0.162849] pci 0000:02:00.0: [12d8:2608] type 01 class 0x060400
[    0.162952] pci 0000:02:00.0: supports D1 D2
[    0.162955] pci 0000:02:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.174743] pci 0000:00:02.0: PCI bridge to [bus 02-07]
[    0.174831] pci 0000:03:01.0: [12d8:2608] type 01 class 0x060400
[    0.174874] pci 0000:03:01.0: Max Payload Size set to 256 (was 128, max 256)
[    0.174942] pci 0000:03:01.0: supports D1 D2
[    0.174945] pci 0000:03:01.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.175054] pci 0000:03:02.0: [12d8:2608] type 01 class 0x060400
[    0.175097] pci 0000:03:02.0: Max Payload Size set to 256 (was 128, max 256)
[    0.175163] pci 0000:03:02.0: supports D1 D2
[    0.175165] pci 0000:03:02.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.175273] pci 0000:03:03.0: [12d8:2608] type 01 class 0x060400
[    0.175316] pci 0000:03:03.0: Max Payload Size set to 256 (was 128, max 256)
[    0.175381] pci 0000:03:03.0: supports D1 D2
[    0.175384] pci 0000:03:03.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.175493] pci 0000:03:04.0: [12d8:2608] type 01 class 0x060400
[    0.175536] pci 0000:03:04.0: Max Payload Size set to 256 (was 128, max 256)
[    0.175602] pci 0000:03:04.0: supports D1 D2
[    0.175604] pci 0000:03:04.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.175728] pci 0000:02:00.0: PCI bridge to [bus 03-07]
[    0.175804] pci 0000:03:01.0: PCI bridge to [bus 04]
[    0.175880] pci 0000:03:02.0: PCI bridge to [bus 05]
[    0.175957] pci 0000:03:03.0: PCI bridge to [bus 06]
[    0.176038] pci 0000:03:04.0: PCI bridge to [bus 07]
[    0.176168] pci 0000:08:00.0: [10ee:7021] type 00 class 0x000000
[    0.176190] pci 0000:08:00.0: reg 0x10: [mem 0xdfe00000-0xdfe0ffff]
[    0.190751] pci 0000:00:03.0: PCI bridge to [bus 08]
[    0.190757] pci 0000:00:03.0:   bridge window [mem 0xdfe00000-0xdfefffff]
[    0.190841] pci 0000:00:04.0: PCI bridge to [bus 09]
[    0.191075] ACPI: PCI Interrupt Link [LNKA] (IRQs 6 7 10 *11 12)
[    0.191204] ACPI: PCI Interrupt Link [LNKB] (IRQs 6 7 *10 11 12)
[    0.191331] ACPI: PCI Interrupt Link [LNKC] (IRQs 6 7 *10 11 12)
[    0.191458] ACPI: PCI Interrupt Link [LNKD] (IRQs 6 7 10 *11 12)
[    0.191586] ACPI: PCI Interrupt Link [LNKE] (IRQs 6 *7 10 11 12)
[    0.191712] ACPI: PCI Interrupt Link [LNKF] (IRQs 6 7 *10 11 12)
[    0.191840] ACPI: PCI Interrupt Link [LNKG] (IRQs 6 7 10 *11 12)
[    0.191967] ACPI: PCI Interrupt Link [LNKH] (IRQs 6 *7 10 11 12)
[    0.192445] ACPI: Enabled 1 GPEs in block 00 to 1F
[    0.192640] vgaarb: loaded
[    0.192797] PCI: Using ACPI for IRQ routing
[    0.193722] PCI: pci_cache_line_size set to 64 bytes
[    0.193788] e820: reserve RAM buffer [mem 0x0009ac00-0x0009ffff]
[    0.193791] e820: reserve RAM buffer [mem 0xbedb6000-0xbfffffff]
[    0.193793] e820: reserve RAM buffer [mem 0xbf800000-0xbfffffff]
[    0.194108] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.194113] hpet0: 3 comparators, 64-bit 14.318180 MHz counter
[    0.196147] clocksource: Switched to clocksource hpet
[    0.208678] VFS: Disk quotas dquot_6.6.0
[    0.208718] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.208839] AppArmor: AppArmor Filesystem Enabled
[    0.208913] pnp: PnP ACPI init
[    0.209369] system 00:00: [mem 0xe0000000-0xefffffff] could not be reserved
[    0.209373] system 00:00: [mem 0xbf800000-0xbfffffff] could not be reserved
[    0.209379] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.209477] system 00:01: [io  0x0680-0x069f] has been reserved
[    0.209480] system 00:01: [io  0x0400-0x047f] has been reserved
[    0.209482] system 00:01: [io  0x0500-0x05fe] has been reserved
[    0.209486] system 00:01: [mem 0xfed00000-0xfedfffff] could not be reserved
[    0.209489] system 00:01: [mem 0x000c0000-0x000dffff] has been reserved
[    0.209492] system 00:01: [mem 0x000e0000-0x000fffff] could not be reserved
[    0.209494] system 00:01: [mem 0xffa00000-0xffffffff] has been reserved
[    0.209497] system 00:01: [mem 0xfee00000-0xfeefffff] has been reserved
[    0.209502] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.209560] pnp 00:02: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.209659] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.209747] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.209933] pnp: PnP ACPI: found 5 devices
[    0.218458] clocksource: acpi_pm: mask: 0xffffff max_cycles:
0xffffff, max_idle_ns: 2085701024 ns
[    0.218539] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.218548] pci 0000:00:01.0:   bridge window [mem
0xde800000-0xdf8fffff 64bit pref]
[    0.218556] pci 0000:03:01.0: PCI bridge to [bus 04]
[    0.218568] pci 0000:03:02.0: PCI bridge to [bus 05]
[    0.218580] pci 0000:03:03.0: PCI bridge to [bus 06]
[    0.218592] pci 0000:03:04.0: PCI bridge to [bus 07]
[    0.218603] pci 0000:02:00.0: PCI bridge to [bus 03-07]
[    0.218615] pci 0000:00:02.0: PCI bridge to [bus 02-07]
[    0.218627] pci 0000:00:03.0: PCI bridge to [bus 08]
[    0.218632] pci 0000:00:03.0:   bridge window [mem 0xdfe00000-0xdfefffff]
[    0.218642] pci 0000:00:04.0: PCI bridge to [bus 09]
[    0.218656] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    0.218658] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    0.218661] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    0.218663] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xdfffffff window]
[    0.218665] pci_bus 0000:00: resource 8 [mem 0x240000000-0xfffffffff window]
[    0.218668] pci_bus 0000:01: resource 2 [mem 0xde800000-0xdf8fffff
64bit pref]
[    0.218671] pci_bus 0000:08: resource 1 [mem 0xdfe00000-0xdfefffff]
[    0.218809] NET: Registered protocol family 2
[    0.219125] TCP established hash table entries: 65536 (order: 7,
524288 bytes)
[    0.219349] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.219657] TCP: Hash tables configured (established 65536 bind 65536)
[    0.219746] UDP hash table entries: 4096 (order: 5, 131072 bytes)
[    0.219808] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes)
[    0.219966] NET: Registered protocol family 1
[    0.240332] PCI: CLS 64 bytes, default 64
[    0.240430] Unpacking initramfs...
[    0.791630] Freeing initrd memory: 22544K
[    0.791746] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    0.791750] software IO TLB [mem 0xbadb6000-0xbedb6000] (64MB)
mapped at [ffff96eafadb6000-ffff96eafedb5fff]
[    0.792471] audit: initializing netlink subsys (disabled)
[    0.792501] audit: type=2000 audit(1560819123.784:1): initialized
[    0.793143] workingset: timestamp_bits=40 max_order=21 bucket_order=0
[    0.793228] zbud: loaded
[    0.794587] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 250)
[    0.794646] io scheduler noop registered
[    0.794648] io scheduler deadline registered
[    0.794665] io scheduler cfq registered (default)
[    0.796756] aer 0000:00:01.0:pcie002: service driver aer loaded
[    0.796804] aer 0000:00:02.0:pcie002: service driver aer loaded
[    0.796837] aer 0000:00:03.0:pcie002: service driver aer loaded
[    0.796877] aer 0000:00:04.0:pcie002: service driver aer loaded
[    0.796913] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    0.796915] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
[    0.796917] pci 0000:01:00.1: Signaling PME through PCIe PME interrupt
[    0.796921] pcie_pme 0000:00:01.0:pcie001: service driver pcie_pme loaded
[    0.796937] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    0.796939] pcieport 0000:02:00.0: Signaling PME through PCIe PME interrupt
[    0.796941] pcieport 0000:03:01.0: Signaling PME through PCIe PME interrupt
[    0.796943] pcieport 0000:03:02.0: Signaling PME through PCIe PME interrupt
[    0.796945] pcieport 0000:03:03.0: Signaling PME through PCIe PME interrupt
[    0.796946] pcieport 0000:03:04.0: Signaling PME through PCIe PME interrupt
[    0.796950] pcie_pme 0000:00:02.0:pcie001: service driver pcie_pme loaded
[    0.796965] pcieport 0000:00:03.0: Signaling PME through PCIe PME interrupt
[    0.796968] pci 0000:08:00.0: Signaling PME through PCIe PME interrupt
[    0.796971] pcie_pme 0000:00:03.0:pcie001: service driver pcie_pme loaded
[    0.796986] pcieport 0000:00:04.0: Signaling PME through PCIe PME interrupt
[    0.796990] pcie_pme 0000:00:04.0:pcie001: service driver pcie_pme loaded
[    0.797018] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.797029] pciehp: PCI Express Hot Plug Controller Driver version: 0.4
[    0.797059] intel_idle: MWAIT substates: 0x3000020
[    0.797061] intel_idle: v0.4.1 model 0x4D
[    0.797223] intel_idle: lapic_timer_reliable_states 0xffffffff
[    0.797697] ERST: Error Record Serialization Table (ERST) support
is initialized.
[    0.797700] pstore: using zlib compression
[    0.797703] pstore: Registered erst as persistent store backend
[    0.798230] GHES: APEI firmware first mode is enabled by APEI bit
and WHEA _OSC.
[    0.798422] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.818692] serial8250: ttyS0 at I/O 0x3f8 (irq = 4, base_baud =
115200) is a 16550A
[    0.839022] serial8250: ttyS1 at I/O 0x2f8 (irq = 3, base_baud =
115200) is a 16550A
[    0.839552] Linux agpgart interface v0.103
[    0.839677] AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.839678] AMD IOMMUv2 functionality not available on this system
[    0.840279] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    1.875616] i8042: No controller found
[    1.875889] mousedev: PS/2 mouse device common for all mice
[    1.875949] rtc_cmos 00:02: RTC can wake from S4
[    1.876132] rtc_cmos 00:02: rtc core: registered rtc_cmos as rtc0
[    1.876206] rtc_cmos 00:02: alarms up to one month, 242 bytes
nvram, hpet irqs
[    1.876459] ledtrig-cpu: registered to indicate activity on CPUs
[    1.877251] NET: Registered protocol family 10
[    1.877431] tsc: Refined TSC clocksource calibration: 2399.999 MHz
[    1.877438] clocksource: tsc: mask: 0xffffffffffffffff max_cycles:
0x2298364cab5, max_idle_ns: 440795214892 ns
[    1.877670] mip6: Mobile IPv6
[    1.877672] NET: Registered protocol family 17
[    1.877677] mpls_gso: MPLS GSO support
[    1.878115] microcode: sig=0x406d8, pf=0x1, revision=0x125
[    1.878255] microcode: Microcode Update Driver: v2.01
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    1.878568] registered taskstats version 1
[    1.878595] zswap: loaded using pool lzo/zbud
[    1.878813] AppArmor: AppArmor sha1 policy hashing enabled
[    1.878816] ima: No TPM chip found, activating TPM-bypass!
[    1.878818] ima: Allocated hash algorithm: sha256
[    1.879333] rtc_cmos 00:02: setting system clock to 2019-06-18
00:52:05 UTC (1560819125)
[    1.879433] PM: Hibernation image not present or could not be loaded.
[    1.881082] Freeing unused kernel memory: 1420K
[    1.881084] Write protecting the kernel read-only data: 12288k
[    1.882303] Freeing unused kernel memory: 1924K
[    1.887466] Freeing unused kernel memory: 1220K
[    1.896226] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.922931] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    1.923118] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    1.923143] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    1.988119] ismt_smbus 0000:00:13.0: SMBus clock is running at 100
kHz with delay 1000 us
[    1.988896] pps_core: LinuxPPS API ver. 1 registered
[    1.988899] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    1.989348] PTP clock support registered
[    1.989727] dca service started, version 1.12.1
[    1.991634] ACPI: bus type USB registered
[    1.991690] usbcore: registered new interface driver usbfs
[    1.991725] usbcore: registered new interface driver hub
[    1.991735] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.4.0-k
[    1.991745] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.991787] usbcore: registered new device driver usb
[    1.992726] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.993085] ehci-pci: EHCI PCI platform driver
[    1.995930] SCSI subsystem initialized
[    1.998978] libata version 3.00 loaded.
[    2.007303] SSE version of gcm_enc/dec engaged.
[    2.344761] igb 0000:00:14.0: added PHC on eth0
[    2.344765] igb 0000:00:14.0: Intel(R) Gigabit Ethernet Network Connection
[    2.344840] igb 0000:00:14.0: eth0: PBA No: 001800-000
[    2.344843] igb 0000:00:14.0: Using MSI-X interrupts. 4 rx
queue(s), 4 tx queue(s)
[    2.345281] igb: probe of 0000:00:14.1 failed with error -2
[    2.345617] igb: probe of 0000:00:14.2 failed with error -2
[    2.345787] ehci-pci 0000:00:16.0: EHCI Host Controller
[    2.345797] ehci-pci 0000:00:16.0: new USB bus registered, assigned
bus number 1
[    2.345813] ehci-pci 0000:00:16.0: debug port 2
[    2.349741] ehci-pci 0000:00:16.0: cache line size of 64 is not supported
[    2.349766] ehci-pci 0000:00:16.0: irq 23, io mem 0xdffef000
[    2.364251] ehci-pci 0000:00:16.0: USB 2.0 started, EHCI 1.00
[    2.364338] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    2.364341] usb usb1: New USB device strings: Mfr=3, Product=2,
SerialNumber=1
[    2.364344] usb usb1: Product: EHCI Host Controller
[    2.364346] usb usb1: Manufacturer: Linux 4.9.0-8-amd64 ehci_hcd
[    2.364347] usb usb1: SerialNumber: 0000:00:16.0
[    2.364608] hub 1-0:1.0: USB hub found
[    2.364622] hub 1-0:1.0: 8 ports detected
[    2.365154] i801_smbus 0000:00:1f.3: SPD Write Disable is set
[    2.365191] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[    2.365888] ahci 0000:00:17.0: version 3.0
[    2.376263] ahci 0000:00:17.0: AHCI 0001.0300 32 slots 4 ports 3
Gbps 0xf impl SATA mode
[    2.376267] ahci 0000:00:17.0: flags: 64bit ncq led clo pio deso
sadm sds apst
[    2.377223] scsi host0: ahci
[    2.377474] scsi host1: ahci
[    2.377741] scsi host2: ahci
[    2.377945] scsi host3: ahci
[    2.378042] ata1: SATA max UDMA/133 abar m2048@0xdffee000 port
0xdffee100 irq 42
[    2.378045] ata2: SATA max UDMA/133 abar m2048@0xdffee000 port
0xdffee180 irq 42
[    2.378047] ata3: SATA max UDMA/133 abar m2048@0xdffee000 port
0xdffee200 irq 42
[    2.378049] ata4: SATA max UDMA/133 abar m2048@0xdffee000 port
0xdffee280 irq 42
[    2.388406] ahci 0000:00:18.0: AHCI 0001.0300 32 slots 2 ports 6
Gbps 0x3 impl SATA mode
[    2.388410] ahci 0000:00:18.0: flags: 64bit ncq led clo pio deso
sadm sds apst
[    2.389004] scsi host4: ahci
[    2.389290] scsi host5: ahci
[    2.389387] ata5: SATA max UDMA/133 abar m2048@0xdffed000 port
0xdffed100 irq 43
[    2.389390] ata6: SATA max UDMA/133 abar m2048@0xdffed000 port
0xdffed180 irq 43
[    2.692192] usb 1-1: new high-speed USB device number 2 using ehci-pci
[    2.695201] ata2: SATA link down (SStatus 0 SControl 300)
[    2.695496] ata3: SATA link down (SStatus 0 SControl 300)
[    2.695515] ata1: SATA link down (SStatus 0 SControl 300)
[    2.695535] ata4: SATA link down (SStatus 0 SControl 300)
[    2.703393] ata6: SATA link down (SStatus 0 SControl 300)
[    2.703413] ata5: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    2.703606] ata5.00: ATA-9: InnoDisk Corp. - mSATA 3IE, S141002c,
max UDMA/133
[    2.703609] ata5.00: 31277232 sectors, multi 16: LBA48 NCQ (depth 31/32), AA
[    2.703832] ata5.00: configured for UDMA/133
[    2.704117] scsi 4:0:0:0: Direct-Access     ATA      InnoDisk Corp.
- 002c PQ: 0 ANSI: 5
[    2.741051] sd 4:0:0:0: [sda] 31277232 512-byte logical blocks:
(16.0 GB/14.9 GiB)
[    2.741134] sd 4:0:0:0: [sda] Write Protect is off
[    2.741138] sd 4:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.741174] sd 4:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    2.743289]  sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda10 sda11 sda12
[    2.744778] sd 4:0:0:0: [sda] Attached SCSI disk
[    2.815095] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    2.840590] usb 1-1: New USB device found, idVendor=8087, idProduct=07db
[    2.840594] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    2.841033] hub 1-1:1.0: USB hub found
[    2.841204] hub 1-1:1.0: 4 ports detected
[    2.884392] clocksource: Switched to clocksource tsc
[    2.912729] random: fast init done
[    3.128187] usb 1-1.1: new high-speed USB device number 3 using ehci-pci
[    3.236607] usb 1-1.1: New USB device found, idVendor=0424, idProduct=2422
[    3.236610] usb 1-1.1: New USB device strings: Mfr=0, Product=0,
SerialNumber=0
[    3.237027] hub 1-1.1:1.0: USB hub found
[    3.237201] hub 1-1.1:1.0: 1 port detected
[    3.779581] EXT4-fs (sda8): 5 orphan inodes deleted
[    3.779584] EXT4-fs (sda8): recovery complete
[    3.793180] EXT4-fs (sda8): mounted filesystem with ordered data
mode. Opts: (null)
[    3.801011] loop: module loaded
[    3.941063] EXT4-fs (loop1): mounted filesystem with ordered data
mode. Opts: (null)
[    4.128317] ip_tables: (C) 2000-2006 Netfilter Core Team
[    4.140095] systemd[1]: systemd 232 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[    4.140462] systemd[1]: Detected architecture x86-64.
[    4.141623] systemd[1]: Set hostname to <sonic>.
[    4.224617] systemd[1]: Started Forward Password Requests to Wall
Directory Watch.
[    4.224790] systemd[1]: Started Dispatch Password Requests to
Console Directory Watch.
[    4.226412] systemd[1]: Created slice User and Session Slice.
[    4.226576] systemd[1]: Listening on Journal Audit Socket.
[    4.226891] systemd[1]: Set up automount Arbitrary Executable File
Formats File System Automount Point.
[    4.226927] systemd[1]: Reached target Paths.
[    4.227639] systemd[1]: Created slice System Slice.
[    4.395628] systemd-journald[290]: Received request to flush
runtime journal from PID 1
[    4.465187] Ebtables v2.0 registered
[    4.503160] bridge: filtering via arp/ip/ip6tables is no longer
available by default. Update your scripts to load br_netfilter if you
need this.
[    4.576491] input: Power Button as
/devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    4.576498] ACPI: Power Button [PWRF]
[    4.580016] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    4.633526] input: PC Speaker as /devices/platform/pcspkr/input/input1
[    4.633997] sd 4:0:0:0: Attached scsi generic sg0 type 0
[    4.698772] dcdbas dcdbas: Dell Systems Management Base Driver
(version 5.6.0-3.2)
[    4.779331] iTCO_vendor_support: vendor-support=0
[    4.779736] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[    4.779791] iTCO_wdt: Found a Avoton SoC TCO device (Version=3,
TCOBASE=0x0460)
[    4.781795] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[    4.819042] audit: type=1400 audit(1560819128.433:2):
apparmor="STATUS" operation="profile_load" name="/usr/sbin/ntpd"
pid=375 comm="apparmor_parser"
[    4.901788] linux_kernel_bde: loading out-of-tree module taints kernel.
[    4.902867] linux-kernel-bde (443): _init(3700):use_msi = 0
[    4.902920] linux-kernel-bde (443): probing: vendor_id=0x14e4,
device_id=0xb960
[    4.902923] linux-kernel-bde (443): Enabling PCI device :
vendor_id=0x14e4, device_id=0xb960
[    4.903020] linux-kernel-bde (443): found irq 16
[    4.903022] linux-kernel-bde (443): _pci_probe:irq = 16
[    4.903039] linux-kernel-bde (443): Set max payload size (128)
[    4.903040] linux-kernel-bde (443): Set max payload val (0)
[    4.903060] linux-kernel-bde (443): Found VSEC (256)
[    4.903101] linux-kernel-bde (443): BAR 2: kernel
addr:0xffffb35cc1800000 phys addr:0xdf000000 length:800000
[    4.903107] linux-kernel-bde (443): BAR 0: kernel
addr:0xffffb35cc1010000 phys addr:0xdf808000 length:8000
[    4.903109] linux-kernel-bde (443): config_pci_intr_type: msi = 0
[    4.903123] linux-kernel-bde (443): Found VSEC (256)
[    4.903125] linux-kernel-bde (443): iproc version = 0 dma_hi_bits  =  0
[    4.903130] linux-kernel-bde (443): PCI resource len 8MB
[    4.903832] linux-kernel-bde (443): _use_dma_mapping:1
_dma_vbase:ffff96eaf8c00000 _dma_pbase:b8c00000 _cpu_pbase:b8c00000
allocated:2000000 dmaalloc:0
[    4.903838] linux-kernel-bde (443): _pci_probe: configured
dev:0xb960 rev:0x11 with base_addresses: 0xffffb35cc1800000
0xffffb35cc1010000
[    4.903907] linux-kernel-bde (443): probing: vendor_id=0x14e4,
device_id=0xb960
[    4.903990] linux-kernel-bde (443): Not find vendor(0x184e)
device(0x1004) bus
[    4.903993] linux-kernel-bde (443): Not find vendor(0x184e)
device(0x1004) bus
[    4.903994] linux-kernel-bde (443): Not find vendor(0x184e)
device(0x1004) bus
[    4.903995] linux-kernel-bde (443): Not find vendor(0x184e)
device(0x1004) bus
[    4.911743] linux-kernel-bde (446): _get_cmic_ver:Found VSEC = 256
[    5.135893] audit: type=1400 audit(1560819128.749:3):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="sbin"
pid=534 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[    5.135924] audit: type=1400 audit(1560819128.749:4):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="bin"
pid=534 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[    5.135952] audit: type=1400 audit(1560819128.749:5):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="usr/sbin"
pid=534 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[    5.135978] audit: type=1400 audit(1560819128.749:6):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="usr/bin"
pid=534 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[    6.762018] audit: type=1400 audit(1560819130.377:7):
apparmor="STATUS" operation="profile_load" name="docker-default"
pid=584 comm="apparmor_parser"
[    6.841683] Initializing XFRM netlink socket
[    6.852221] nf_conntrack version 0.5.0 (65536 buckets, 262144 max)
[    6.857489] Netfilter messages via NETLINK v0.30.
[    6.860325] ctnetlink v0.93: registering with nfnetlink.
[    6.866166] IPv6: ADDRCONF(NETDEV_UP): docker0: link is not ready
[   12.342586] i2c /dev entries driver
[   12.348514] dell_ich: dell_ich: found SMF for ID 0x1
[   12.348644] dell_ich: dell_ich base_addr_cfg fed03002 base_addr fed03000
[   12.348646] dell_ich: dell_ich pmc res_start:end fed03058:fed0305b
[   12.358381] Found SMF_S6100_ON chip at 0x200
[   12.365647] i2c i2c-0: Added multiplexed i2c bus 2
[   12.365778] i2c i2c-0: Added multiplexed i2c bus 3
[   12.365890] i2c i2c-0: Added multiplexed i2c bus 4
[   12.366011] i2c i2c-0: Added multiplexed i2c bus 5
[   12.366125] i2c i2c-0: Added multiplexed i2c bus 6
[   12.366236] i2c i2c-0: Added multiplexed i2c bus 7
[   12.366350] i2c i2c-0: Added multiplexed i2c bus 8
[   12.366458] i2c i2c-0: Added multiplexed i2c bus 9
[   12.366461] pca954x 0-0070: registered 8 multiplexed busses for I2C
mux pca9547
[   12.366481] i2c i2c-0: new_device: Instantiated device pca9547 at 0x70
[   12.376375] i2c i2c-4: Added multiplexed i2c bus 10
[   12.376508] i2c i2c-4: Added multiplexed i2c bus 11
[   12.376644] i2c i2c-4: Added multiplexed i2c bus 12
[   12.376768] i2c i2c-4: Added multiplexed i2c bus 13
[   12.376886] i2c i2c-4: Added multiplexed i2c bus 14
[   12.376999] i2c i2c-4: Added multiplexed i2c bus 15
[   12.377138] i2c i2c-4: Added multiplexed i2c bus 16
[   12.377249] i2c i2c-4: Added multiplexed i2c bus 17
[   12.377252] pca954x 4-0071: registered 8 multiplexed busses for I2C
switch pca9548
[   12.377271] i2c i2c-4: new_device: Instantiated device pca9548 at 0x71
[   12.385007] i2c i2c-2: new_device: Instantiated device 24c02 at 0x50
[   12.392525] dell_s6100_iom_cpld 14-003e: chip found
[   12.392564] i2c i2c-14: new_device: Instantiated device
dell_s6100_iom_cpld at 0x3e
[   12.395541] at24 2-0050: 256 byte 24c02 EEPROM, writable, 1 bytes/write
[   12.398796] dell_s6100_iom_cpld 15-003e: chip found
[   12.399419] i2c i2c-15: new_device: Instantiated device
dell_s6100_iom_cpld at 0x3e
[   12.406752] dell_s6100_iom_cpld 16-003e: chip found
[   12.408199] i2c i2c-16: new_device: Instantiated device
dell_s6100_iom_cpld at 0x3e
[   12.414575] dell_s6100_iom_cpld 17-003e: chip found
[   12.414615] i2c i2c-17: new_device: Instantiated device
dell_s6100_iom_cpld at 0x3e
[   12.423802] i2c i2c-9: Added multiplexed i2c bus 18
[   12.423919] i2c i2c-9: Added multiplexed i2c bus 19
[   12.424037] i2c i2c-9: Added multiplexed i2c bus 20
[   12.425551] i2c i2c-9: Added multiplexed i2c bus 21
[   12.425848] i2c i2c-9: Added multiplexed i2c bus 22
[   12.426033] i2c i2c-9: Added multiplexed i2c bus 23
[   12.426151] i2c i2c-9: Added multiplexed i2c bus 24
[   12.426270] i2c i2c-9: Added multiplexed i2c bus 25
[   12.426273] pca954x 9-0071: registered 8 multiplexed busses for I2C
switch pca9548
[   12.426293] i2c i2c-9: new_device: Instantiated device pca9548 at 0x71
[   12.438182] i2c i2c-9: Added multiplexed i2c bus 26
[   12.438336] i2c i2c-9: Added multiplexed i2c bus 27
[   12.438486] i2c i2c-9: Added multiplexed i2c bus 28
[   12.438639] i2c i2c-9: Added multiplexed i2c bus 29
[   12.438793] i2c i2c-9: Added multiplexed i2c bus 30
[   12.438920] i2c i2c-9: Added multiplexed i2c bus 31
[   12.439048] i2c i2c-9: Added multiplexed i2c bus 32
[   12.439173] i2c i2c-9: Added multiplexed i2c bus 33
[   12.439176] pca954x 9-0072: registered 8 multiplexed busses for I2C
switch pca9548
[   12.439198] i2c i2c-9: new_device: Instantiated device pca9548 at 0x72
[   12.451745] i2c i2c-8: Added multiplexed i2c bus 34
[   12.451981] i2c i2c-8: Added multiplexed i2c bus 35
[   12.452104] i2c i2c-8: Added multiplexed i2c bus 36
[   12.452243] i2c i2c-8: Added multiplexed i2c bus 37
[   12.452350] i2c i2c-8: Added multiplexed i2c bus 38
[   12.452452] i2c i2c-8: Added multiplexed i2c bus 39
[   12.452568] i2c i2c-8: Added multiplexed i2c bus 40
[   12.455784] i2c i2c-8: Added multiplexed i2c bus 41
[   12.455788] pca954x 8-0071: registered 8 multiplexed busses for I2C
switch pca9548
[   12.455805] i2c i2c-8: new_device: Instantiated device pca9548 at 0x71
[   12.470057] i2c i2c-8: Added multiplexed i2c bus 42
[   12.470193] i2c i2c-8: Added multiplexed i2c bus 43
[   12.470316] i2c i2c-8: Added multiplexed i2c bus 44
[   12.470432] i2c i2c-8: Added multiplexed i2c bus 45
[   12.473524] i2c i2c-8: Added multiplexed i2c bus 46
[   12.474832] i2c i2c-8: Added multiplexed i2c bus 47
[   12.474993] i2c i2c-8: Added multiplexed i2c bus 48
[   12.475129] i2c i2c-8: Added multiplexed i2c bus 49
[   12.475132] pca954x 8-0072: registered 8 multiplexed busses for I2C
switch pca9548
[   12.475152] i2c i2c-8: new_device: Instantiated device pca9548 at 0x72
[   12.488036] i2c i2c-7: Added multiplexed i2c bus 50
[   12.488887] i2c i2c-7: Added multiplexed i2c bus 51
[   12.489041] i2c i2c-7: Added multiplexed i2c bus 52
[   12.489162] i2c i2c-7: Added multiplexed i2c bus 53
[   12.489292] i2c i2c-7: Added multiplexed i2c bus 54
[   12.489411] i2c i2c-7: Added multiplexed i2c bus 55
[   12.489520] i2c i2c-7: Added multiplexed i2c bus 56
[   12.489625] i2c i2c-7: Added multiplexed i2c bus 57
[   12.489628] pca954x 7-0071: registered 8 multiplexed busses for I2C
switch pca9548
[   12.489647] i2c i2c-7: new_device: Instantiated device pca9548 at 0x71
[   12.514719] i2c i2c-7: Added multiplexed i2c bus 58
[   12.514858] i2c i2c-7: Added multiplexed i2c bus 59
[   12.514973] i2c i2c-7: Added multiplexed i2c bus 60
[   12.515084] i2c i2c-7: Added multiplexed i2c bus 61
[   12.515191] i2c i2c-7: Added multiplexed i2c bus 62
[   12.515305] i2c i2c-7: Added multiplexed i2c bus 63
[   12.515413] i2c i2c-7: Added multiplexed i2c bus 64
[   12.515535] i2c i2c-7: Added multiplexed i2c bus 65
[   12.515538] pca954x 7-0072: registered 8 multiplexed busses for I2C
switch pca9548
[   12.515558] i2c i2c-7: new_device: Instantiated device pca9548 at 0x72
[   12.526805] i2c i2c-6: Added multiplexed i2c bus 66
[   12.526908] i2c i2c-6: Added multiplexed i2c bus 67
[   12.527007] i2c i2c-6: Added multiplexed i2c bus 68
[   12.527106] i2c i2c-6: Added multiplexed i2c bus 69
[   12.527205] i2c i2c-6: Added multiplexed i2c bus 70
[   12.527307] i2c i2c-6: Added multiplexed i2c bus 71
[   12.527408] i2c i2c-6: Added multiplexed i2c bus 72
[   12.527510] i2c i2c-6: Added multiplexed i2c bus 73
[   12.527513] pca954x 6-0071: registered 8 multiplexed busses for I2C
switch pca9548
[   12.527531] i2c i2c-6: new_device: Instantiated device pca9548 at 0x71
[   12.541011] i2c i2c-6: Added multiplexed i2c bus 74
[   12.541146] i2c i2c-6: Added multiplexed i2c bus 75
[   12.541255] i2c i2c-6: Added multiplexed i2c bus 76
[   12.541356] i2c i2c-6: Added multiplexed i2c bus 77
[   12.541470] i2c i2c-6: Added multiplexed i2c bus 78
[   12.541584] i2c i2c-6: Added multiplexed i2c bus 79
[   12.541694] i2c i2c-6: Added multiplexed i2c bus 80
[   12.541798] i2c i2c-6: Added multiplexed i2c bus 81
[   12.541801] pca954x 6-0072: registered 8 multiplexed busses for I2C
switch pca9548
[   12.541821] i2c i2c-6: new_device: Instantiated device pca9548 at 0x72
[   12.552324] i2c i2c-11: new_device: Instantiated device sff8436 at 0x50
[   12.557136] sff8436 11-0050: 640 byte sff8436 EEPROM, read-only
[   12.557813] optoe 12-0050: 32896 byte sff8436 EEPROM, read/write
[   12.557871] i2c i2c-12: new_device: Instantiated device sff8436 at 0x50
[   12.565323] sff8436 18-0050: 640 byte sff8436 EEPROM, read-only
[   12.565928] i2c i2c-18: new_device: Instantiated device sff8436 at 0x50
[   12.571976] sff8436 19-0050: 640 byte sff8436 EEPROM, read-only
[   12.572018] i2c i2c-19: new_device: Instantiated device sff8436 at 0x50
[   12.578221] sff8436 20-0050: 640 byte sff8436 EEPROM, read-only
[   12.578242] i2c i2c-20: new_device: Instantiated device sff8436 at 0x50
[   12.584318] sff8436 21-0050: 640 byte sff8436 EEPROM, read-only
[   12.584333] i2c i2c-21: new_device: Instantiated device sff8436 at 0x50
[   12.590476] sff8436 22-0050: 640 byte sff8436 EEPROM, read-only
[   12.590499] i2c i2c-22: new_device: Instantiated device sff8436 at 0x50
[   12.597428] sff8436 23-0050: 640 byte sff8436 EEPROM, read-only
[   12.597452] i2c i2c-23: new_device: Instantiated device sff8436 at 0x50
[   12.603499] sff8436 24-0050: 640 byte sff8436 EEPROM, read-only
[   12.603521] i2c i2c-24: new_device: Instantiated device sff8436 at 0x50
[   12.610673] sff8436 25-0050: 640 byte sff8436 EEPROM, read-only
[   12.611257] i2c i2c-25: new_device: Instantiated device sff8436 at 0x50
[   12.617820] sff8436 26-0050: 640 byte sff8436 EEPROM, read-only
[   12.617858] i2c i2c-26: new_device: Instantiated device sff8436 at 0x50
[   12.628895] sff8436 27-0050: 640 byte sff8436 EEPROM, read-only
[   12.628920] i2c i2c-27: new_device: Instantiated device sff8436 at 0x50
[   12.636612] sff8436 28-0050: 640 byte sff8436 EEPROM, read-only
[   12.636634] i2c i2c-28: new_device: Instantiated device sff8436 at 0x50
[   12.644219] sff8436 29-0050: 640 byte sff8436 EEPROM, read-only
[   12.644239] i2c i2c-29: new_device: Instantiated device sff8436 at 0x50
[   12.650049] sff8436 30-0050: 640 byte sff8436 EEPROM, read-only
[   12.650071] i2c i2c-30: new_device: Instantiated device sff8436 at 0x50
[   12.657273] sff8436 31-0050: 640 byte sff8436 EEPROM, read-only
[   12.657294] i2c i2c-31: new_device: Instantiated device sff8436 at 0x50
[   12.664077] sff8436 32-0050: 640 byte sff8436 EEPROM, read-only
[   12.664099] i2c i2c-32: new_device: Instantiated device sff8436 at 0x50
[   12.673972] sff8436 33-0050: 640 byte sff8436 EEPROM, read-only
[   12.673996] i2c i2c-33: new_device: Instantiated device sff8436 at 0x50
[   12.681228] sff8436 34-0050: 640 byte sff8436 EEPROM, read-only
[   12.681251] i2c i2c-34: new_device: Instantiated device sff8436 at 0x50
[   12.689592] sff8436 35-0050: 640 byte sff8436 EEPROM, read-only
[   12.689614] i2c i2c-35: new_device: Instantiated device sff8436 at 0x50
[   12.698860] sff8436 36-0050: 640 byte sff8436 EEPROM, read-only
[   12.698884] i2c i2c-36: new_device: Instantiated device sff8436 at 0x50
[   12.705740] sff8436 37-0050: 640 byte sff8436 EEPROM, read-only
[   12.705768] i2c i2c-37: new_device: Instantiated device sff8436 at 0x50
[   12.713974] sff8436 38-0050: 640 byte sff8436 EEPROM, read-only
[   12.713997] i2c i2c-38: new_device: Instantiated device sff8436 at 0x50
[   12.719979] sff8436 39-0050: 640 byte sff8436 EEPROM, read-only
[   12.720028] i2c i2c-39: new_device: Instantiated device sff8436 at 0x50
[   12.731412] sff8436 40-0050: 640 byte sff8436 EEPROM, read-only
[   12.731437] i2c i2c-40: new_device: Instantiated device sff8436 at 0x50
[   12.737788] sff8436 41-0050: 640 byte sff8436 EEPROM, read-only
[   12.737813] i2c i2c-41: new_device: Instantiated device sff8436 at 0x50
[   12.743455] sff8436 42-0050: 640 byte sff8436 EEPROM, read-only
[   12.743478] i2c i2c-42: new_device: Instantiated device sff8436 at 0x50
[   12.749431] sff8436 43-0050: 640 byte sff8436 EEPROM, read-only
[   12.749454] i2c i2c-43: new_device: Instantiated device sff8436 at 0x50
[   12.755593] sff8436 44-0050: 640 byte sff8436 EEPROM, read-only
[   12.755616] i2c i2c-44: new_device: Instantiated device sff8436 at 0x50
[   12.762068] sff8436 45-0050: 640 byte sff8436 EEPROM, read-only
[   12.762089] i2c i2c-45: new_device: Instantiated device sff8436 at 0x50
[   12.769186] sff8436 46-0050: 640 byte sff8436 EEPROM, read-only
[   12.769208] i2c i2c-46: new_device: Instantiated device sff8436 at 0x50
[   12.776994] sff8436 47-0050: 640 byte sff8436 EEPROM, read-only
[   12.777028] i2c i2c-47: new_device: Instantiated device sff8436 at 0x50
[   12.783707] sff8436 48-0050: 640 byte sff8436 EEPROM, read-only
[   12.783728] i2c i2c-48: new_device: Instantiated device sff8436 at 0x50
[   12.790351] sff8436 49-0050: 640 byte sff8436 EEPROM, read-only
[   12.790375] i2c i2c-49: new_device: Instantiated device sff8436 at 0x50
[   12.797641] sff8436 50-0050: 640 byte sff8436 EEPROM, read-only
[   12.797661] i2c i2c-50: new_device: Instantiated device sff8436 at 0x50
[   12.804024] sff8436 51-0050: 640 byte sff8436 EEPROM, read-only
[   12.804046] i2c i2c-51: new_device: Instantiated device sff8436 at 0x50
[   12.811949] sff8436 52-0050: 640 byte sff8436 EEPROM, read-only
[   12.811971] i2c i2c-52: new_device: Instantiated device sff8436 at 0x50
[   12.818537] sff8436 53-0050: 640 byte sff8436 EEPROM, read-only
[   12.818567] i2c i2c-53: new_device: Instantiated device sff8436 at 0x50
[   12.831901] sff8436 54-0050: 640 byte sff8436 EEPROM, read-only
[   12.831927] i2c i2c-54: new_device: Instantiated device sff8436 at 0x50
[   12.840244] sff8436 55-0050: 640 byte sff8436 EEPROM, read-only
[   12.840265] i2c i2c-55: new_device: Instantiated device sff8436 at 0x50
[   12.846220] sff8436 56-0050: 640 byte sff8436 EEPROM, read-only
[   12.846242] i2c i2c-56: new_device: Instantiated device sff8436 at 0x50
[   12.852690] sff8436 57-0050: 640 byte sff8436 EEPROM, read-only
[   12.852712] i2c i2c-57: new_device: Instantiated device sff8436 at 0x50
[   12.858614] sff8436 58-0050: 640 byte sff8436 EEPROM, read-only
[   12.858638] i2c i2c-58: new_device: Instantiated device sff8436 at 0x50
[   12.865200] sff8436 59-0050: 640 byte sff8436 EEPROM, read-only
[   12.865223] i2c i2c-59: new_device: Instantiated device sff8436 at 0x50
[   12.870962] sff8436 60-0050: 640 byte sff8436 EEPROM, read-only
[   12.870985] i2c i2c-60: new_device: Instantiated device sff8436 at 0x50
[   12.877109] sff8436 61-0050: 640 byte sff8436 EEPROM, read-only
[   12.877134] i2c i2c-61: new_device: Instantiated device sff8436 at 0x50
[   12.883654] sff8436 62-0050: 640 byte sff8436 EEPROM, read-only
[   12.883675] i2c i2c-62: new_device: Instantiated device sff8436 at 0x50
[   12.891445] sff8436 63-0050: 640 byte sff8436 EEPROM, read-only
[   12.891469] i2c i2c-63: new_device: Instantiated device sff8436 at 0x50
[   12.898059] sff8436 64-0050: 640 byte sff8436 EEPROM, read-only
[   12.898083] i2c i2c-64: new_device: Instantiated device sff8436 at 0x50
[   12.904366] sff8436 65-0050: 640 byte sff8436 EEPROM, read-only
[   12.904389] i2c i2c-65: new_device: Instantiated device sff8436 at 0x50
[   12.913351] sff8436 66-0050: 640 byte sff8436 EEPROM, read-only
[   12.913377] i2c i2c-66: new_device: Instantiated device sff8436 at 0x50
[   12.922508] sff8436 67-0050: 640 byte sff8436 EEPROM, read-only
[   12.922536] i2c i2c-67: new_device: Instantiated device sff8436 at 0x50
[   12.929755] sff8436 68-0050: 640 byte sff8436 EEPROM, read-only
[   12.929777] i2c i2c-68: new_device: Instantiated device sff8436 at 0x50
[   12.936855] sff8436 69-0050: 640 byte sff8436 EEPROM, read-only
[   12.936875] i2c i2c-69: new_device: Instantiated device sff8436 at 0x50
[   12.942930] sff8436 70-0050: 640 byte sff8436 EEPROM, read-only
[   12.942953] i2c i2c-70: new_device: Instantiated device sff8436 at 0x50
[   12.949355] sff8436 71-0050: 640 byte sff8436 EEPROM, read-only
[   12.949377] i2c i2c-71: new_device: Instantiated device sff8436 at 0x50
[   12.956010] sff8436 72-0050: 640 byte sff8436 EEPROM, read-only
[   12.956031] i2c i2c-72: new_device: Instantiated device sff8436 at 0x50
[   12.980781] sff8436 73-0050: 640 byte sff8436 EEPROM, read-only
[   12.980802] i2c i2c-73: new_device: Instantiated device sff8436 at 0x50
[   12.987101] sff8436 74-0050: 640 byte sff8436 EEPROM, read-only
[   12.987124] i2c i2c-74: new_device: Instantiated device sff8436 at 0x50
[   12.995165] sff8436 75-0050: 640 byte sff8436 EEPROM, read-only
[   12.995191] i2c i2c-75: new_device: Instantiated device sff8436 at 0x50
[   13.001931] sff8436 76-0050: 640 byte sff8436 EEPROM, read-only
[   13.001954] i2c i2c-76: new_device: Instantiated device sff8436 at 0x50
[   13.009227] sff8436 77-0050: 640 byte sff8436 EEPROM, read-only
[   13.009250] i2c i2c-77: new_device: Instantiated device sff8436 at 0x50
[   13.014915] sff8436 78-0050: 640 byte sff8436 EEPROM, read-only
[   13.014943] i2c i2c-78: new_device: Instantiated device sff8436 at 0x50
[   13.021331] sff8436 79-0050: 640 byte sff8436 EEPROM, read-only
[   13.021353] i2c i2c-79: new_device: Instantiated device sff8436 at 0x50
[   13.027858] sff8436 80-0050: 640 byte sff8436 EEPROM, read-only
[   13.027882] i2c i2c-80: new_device: Instantiated device sff8436 at 0x50
[   13.033550] sff8436 81-0050: 640 byte sff8436 EEPROM, read-only
[   13.033572] i2c i2c-81: new_device: Instantiated device sff8436 at 0x50
[   17.126827] random: crng init done
[   17.126830] random: 7 urandom warning(s) missed due to ratelimiting
[   24.992195] ip6_tables: (C) 2000-2006 Netfilter Core Team
[   27.566652] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   29.976525] igb 0000:00:14.0 eth0: igb: eth0 NIC Link is Up 1000
Mbps Full Duplex, Flow Control: RX/TX
[   29.976656] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   41.862947] PortChannel101: Mode changed to "loadbalance"
[   41.940298] IPv6: ADDRCONF(NETDEV_UP): PortChannel101: link is not ready
[   41.979440] PortChannel102: Mode changed to "loadbalance"
[   42.053354] IPv6: ADDRCONF(NETDEV_UP): PortChannel102: link is not ready
[   42.097154] PortChannel103: Mode changed to "loadbalance"
[   42.169196] IPv6: ADDRCONF(NETDEV_UP): PortChannel103: link is not ready
[   42.213116] PortChannel104: Mode changed to "loadbalance"
[   42.251760] IPv6: ADDRCONF(NETDEV_UP): PortChannel104: link is not ready
[   42.352748] PortChannel105: Mode changed to "loadbalance"
[   42.373254] IPv6: ADDRCONF(NETDEV_UP): PortChannel105: link is not ready
[   42.455121] PortChannel106: Mode changed to "loadbalance"
[   42.482123] IPv6: ADDRCONF(NETDEV_UP): PortChannel106: link is not ready
[   42.527357] PortChannel107: Mode changed to "loadbalance"
[   42.543612] IPv6: ADDRCONF(NETDEV_UP): PortChannel107: link is not ready
[   42.626832] PortChannel108: Mode changed to "loadbalance"
[   42.694019] IPv6: ADDRCONF(NETDEV_UP): PortChannel108: link is not ready
[   42.741828] PortChannel109: Mode changed to "loadbalance"
[   42.772371] IPv6: ADDRCONF(NETDEV_UP): PortChannel109: link is not ready
[   42.876524] PortChannel110: Mode changed to "loadbalance"
[   42.899300] IPv6: ADDRCONF(NETDEV_UP): PortChannel110: link is not ready
[   43.070203] PortChannel111: Mode changed to "loadbalance"
[   43.114240] IPv6: ADDRCONF(NETDEV_UP): PortChannel111: link is not ready
[   43.242855] PortChannel112: Mode changed to "loadbalance"
[   43.317102] IPv6: ADDRCONF(NETDEV_UP): PortChannel112: link is not ready
[   43.404897] PortChannel113: Mode changed to "loadbalance"
[   43.451413] IPv6: ADDRCONF(NETDEV_UP): PortChannel113: link is not ready
[   43.562352] PortChannel114: Mode changed to "loadbalance"
[   43.689647] IPv6: ADDRCONF(NETDEV_UP): PortChannel114: link is not ready
[   43.789267] PortChannel115: Mode changed to "loadbalance"
[   43.825418] IPv6: ADDRCONF(NETDEV_UP): PortChannel115: link is not ready
[   44.005588] PortChannel116: Mode changed to "loadbalance"
[   44.069658] IPv6: ADDRCONF(NETDEV_UP): PortChannel116: link is not ready
[   44.183159] PortChannel117: Mode changed to "loadbalance"
[   44.251766] IPv6: ADDRCONF(NETDEV_UP): PortChannel117: link is not ready
[   44.318604] PortChannel118: Mode changed to "loadbalance"
[   44.394322] IPv6: ADDRCONF(NETDEV_UP): PortChannel118: link is not ready
[   44.589340] PortChannel57: Mode changed to "loadbalance"
[   44.613716] IPv6: ADDRCONF(NETDEV_UP): PortChannel57: link is not ready
[   44.765785] PortChannel58: Mode changed to "loadbalance"
[   44.786911] IPv6: ADDRCONF(NETDEV_UP): PortChannel58: link is not ready
[   44.890396] PortChannel59: Mode changed to "loadbalance"
[   44.893175] audit: type=1400 audit(1560819168.509:8):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="sbin"
pid=5211 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[   44.893204] audit: type=1400 audit(1560819168.509:9):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="bin"
pid=5211 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[   44.893229] audit: type=1400 audit(1560819168.509:10):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="usr/sbin"
pid=5211 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[   44.893253] audit: type=1400 audit(1560819168.509:11):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd"
name="image-20181130.26/rw/usr/bin" pid=5211 comm="ntpd"
requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[   44.982491] IPv6: ADDRCONF(NETDEV_UP): PortChannel59: link is not ready
[   45.132146] PortChannel60: Mode changed to "loadbalance"
[   45.156160] IPv6: ADDRCONF(NETDEV_UP): PortChannel60: link is not ready
[   45.258209] PortChannel61: Mode changed to "loadbalance"
[   45.287866] IPv6: ADDRCONF(NETDEV_UP): PortChannel61: link is not ready
[   45.375945] PortChannel62: Mode changed to "loadbalance"
[   45.391407] IPv6: ADDRCONF(NETDEV_UP): PortChannel62: link is not ready
[   45.431980] PortChannel63: Mode changed to "loadbalance"
[   45.480864] IPv6: ADDRCONF(NETDEV_UP): PortChannel63: link is not ready
[   45.523517] PortChannel64: Mode changed to "loadbalance"
[   45.538725] IPv6: ADDRCONF(NETDEV_UP): PortChannel64: link is not ready
[   51.055774] linux-kernel-bde (5475): _interrupt_connect d 0
[   51.055777] linux-kernel-bde (5475): _interrupt_connect:isr_active = 0
[   51.055778] linux-kernel-bde (5475): connect primary isr
[   51.055806] linux-kernel-bde (5475):
_interrupt_connect(4276):device# = 0, irq_flags = 128, irq = 16
[   51.303563] linux-bcm-knet (5540): bkn_get_next_dma_event dev 0 evt_idx 0
[   51.303567] linux-bcm-knet (5540): wait queue index 0
[   51.303646] linux-kernel-bde (5475): _interrupt_connect d 0
[   51.303649] linux-kernel-bde (5475): _interrupt_connect:isr_active = 1
[   51.303650] linux-kernel-bde (5475): connect secondary isr
[   88.083793] IPv6: ADDRCONF(NETDEV_UP): Ethernet52: link is not ready
[   88.087310] PortChannel112: Port device Ethernet52 added
[   88.151542] IPv6: ADDRCONF(NETDEV_UP): Ethernet53: link is not ready
[   88.152706] PortChannel113: Port device Ethernet53 added
[   88.212569] PortChannel114: Port device Ethernet54 added
[   88.394036] IPv6: ADDRCONF(NETDEV_UP): Ethernet55: link is not ready
[   88.395990] PortChannel115: Port device Ethernet55 added
[   88.481610] IPv6: ADDRCONF(NETDEV_UP): Ethernet34: link is not ready
[   88.488179] PortChannel101: Port device Ethernet34 added
[   88.626126] PortChannel59: Port device Ethernet16 added
[   88.940325] IPv6: ADDRCONF(NETDEV_UP): Ethernet17: link is not ready
[   88.940933] PortChannel60: Port device Ethernet17 added
[   89.156901] IPv6: ADDRCONF(NETDEV_UP): Ethernet58: link is not ready
[   89.157960] PortChannel116: Port device Ethernet58 added
[   89.206749] PortChannel109: Port device Ethernet46 added
[   89.488209] IPv6: ADDRCONF(NETDEV_UP): Ethernet47: link is not ready
[   89.489147] PortChannel110: Port device Ethernet47 added
[   89.560486] IPv6: ADDRCONF(NETDEV_UP): Ethernet44: link is not ready
[   89.561739] PortChannel107: Port device Ethernet44 added
[   89.616817] IPv6: ADDRCONF(NETDEV_UP): Ethernet45: link is not ready
[   89.617430] PortChannel108: Port device Ethernet45 added
[   89.976444] IPv6: ADDRCONF(NETDEV_UP): Ethernet20: link is not ready
[   89.977027] PortChannel63: Port device Ethernet20 added
[   90.023823] IPv6: ADDRCONF(NETDEV_UP): Ethernet21: link is not ready
[   90.024668] PortChannel64: Port device Ethernet21 added
[   90.183317] IPv6: ADDRCONF(NETDEV_UP): Ethernet4: link is not ready
[   90.187071] PortChannel61: Port device Ethernet4 added
[   90.290291] PortChannel62: Port device Ethernet5 added
[   90.680631] IPv6: ADDRCONF(NETDEV_UP): Ethernet60: link is not ready
[   90.681232] PortChannel117: Port device Ethernet60 added
[   90.792217] IPv6: ADDRCONF(NETDEV_UP): Ethernet61: link is not ready
[   90.793200] PortChannel118: Port device Ethernet61 added
[   90.849105] IPv6: ADDRCONF(NETDEV_UP): Ethernet42: link is not ready
[   90.849653] PortChannel106: Port device Ethernet42 added
[   91.236898] IPv6: ADDRCONF(NETDEV_UP): Ethernet0: link is not ready
[   91.238372] PortChannel57: Port device Ethernet0 added
[   91.319015] IPv6: ADDRCONF(NETDEV_UP): Ethernet1: link is not ready
[   91.321389] PortChannel58: Port device Ethernet1 added
[   91.827750] IPv6: ADDRCONF(NETDEV_UP): Ethernet50: link is not ready
[   91.830125] PortChannel111: Port device Ethernet50 added
[   91.856870] IPv6: ADDRCONF(NETDEV_UP): Ethernet36: link is not ready
[   91.894019] IPv6: ADDRCONF(NETDEV_UP): Ethernet37: link is not ready
[   91.907168] IPv6: ADDRCONF(NETDEV_UP): Ethernet38: link is not ready
[   91.929117] IPv6: ADDRCONF(NETDEV_UP): Ethernet36: link is not ready
[   91.929652] PortChannel102: Port device Ethernet36 added
[   91.935945] IPv6: ADDRCONF(NETDEV_UP): Ethernet39: link is not ready
[   92.085622] IPv6: ADDRCONF(NETDEV_UP): Ethernet37: link is not ready
[   92.086195] PortChannel103: Port device Ethernet37 added
[   92.181370] IPv6: ADDRCONF(NETDEV_UP): Ethernet38: link is not ready
[   92.185316] PortChannel104: Port device Ethernet38 added
[   92.259586] IPv6: ADDRCONF(NETDEV_UP): Ethernet39: link is not ready
[   92.264660] PortChannel105: Port device Ethernet39 added
[   95.961076] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet34: link becomes ready
[   95.970356] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel101: link becomes ready
[   95.982377] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet47: link becomes ready
[   95.988802] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet44: link becomes ready
[   95.996772] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel109: link becomes ready
[   95.997035] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet45: link becomes ready
[   95.997363] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet20: link becomes ready
[   95.997686] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet42: link becomes ready
[   95.998173] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet0: link becomes ready
[   96.000348] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet1: link becomes ready
[   96.005615] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet50: link becomes ready
[   96.009732] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet38: link becomes ready
[   96.042037] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel110: link becomes ready
[   96.042333] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel108: link becomes ready
[   96.042462] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet39: link becomes ready
[   96.042752] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet36: link becomes ready
[   96.042997] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel107: link becomes ready
[   96.043105] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet37: link becomes ready
[   96.043359] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet52: link becomes ready
[   96.043608] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet53: link becomes ready
[   96.044055] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet55: link becomes ready
[   96.044306] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel111: link becomes ready
[   96.044423] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet58: link becomes ready
[   96.048806] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet21: link becomes ready
[   96.049859] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet4: link becomes ready
[   96.056987] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet60: link becomes ready
[   96.060118] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet61: link becomes ready
[   96.091069] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel104: link becomes ready
[   96.109920] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel117: link becomes ready
[   96.118851] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel116: link becomes ready
[   96.119097] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel112: link becomes ready
[   96.127188] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel103: link becomes ready
[   96.135279] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel118: link becomes ready
[   96.135582] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel106: link becomes ready
[   96.152683] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel115: link becomes ready
[   96.159807] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel105: link becomes ready
[   96.167796] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel114: link becomes ready
[   96.180653] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel113: link becomes ready
[   97.982424] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel59: link becomes ready
[   98.019510] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel57: link becomes ready
[   98.027106] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel63: link becomes ready
[   98.041172] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel58: link becomes ready
[   98.073767] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel64: link becomes ready
[   98.080895] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel61: link becomes ready
[   98.090413] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel62: link becomes ready
[   98.976167] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet17: link becomes ready
[  100.979748] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel60: link becomes ready
[  126.048768] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel102: link becomes ready
[ 3613.511599] perf: interrupt took too long (2519 > 2500), lowering
kernel.perf_event_max_sample_rate to 79250
[ 5261.395001] perf: interrupt took too long (3157 > 3148), lowering
kernel.perf_event_max_sample_rate to 63250
[ 8430.376881] perf: interrupt took too long (3954 > 3946), lowering
kernel.perf_event_max_sample_rate to 50500
[25411.131158] perf: interrupt took too long (4943 > 4942), lowering
kernel.perf_event_max_sample_rate to 40250
[179684.618254] DCCP: Activated CCID 2 (TCP-like)
[179684.618258] DCCP: Activated CCID 3 (TCP-Friendly Rate Control)
[179684.629605] sctp: Hash tables configured (bind 256/256)
[179735.674398] audit: type=1400 audit(1560998850.373:12):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/bin/" pid=11722 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[179735.674426] audit: type=1400 audit(1560998850.373:13):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd"
name="image-20181130.26/rw/usr/bin" pid=11722 comm="ntpd"
requested_mask="r" denied_mask="r" fsuid=1002 ouid=0
[179735.674451] audit: type=1400 audit(1560998850.373:14):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="bin"
pid=11722 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[179735.674474] audit: type=1400 audit(1560998850.373:15):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/games/" pid=11722 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[179735.674494] audit: type=1400 audit(1560998850.373:16):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/games/" pid=11722 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[179735.674516] audit: type=1400 audit(1560998850.373:17):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="sbin"
pid=11722 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[179735.674540] audit: type=1400 audit(1560998850.373:18):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="usr/sbin"
pid=11722 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[179735.674562] audit: type=1400 audit(1560998850.373:19):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/sbin/" pid=11722 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[642902.723605] audit: type=1400 audit(1561461995.531:20):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/bin/" pid=12530 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[642902.723658] audit: type=1400 audit(1561461995.531:21):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd"
name="image-20181130.26/rw/usr/bin" pid=12530 comm="ntpd"
requested_mask="r" denied_mask="r" fsuid=1002 ouid=0
[642902.723706] audit: type=1400 audit(1561461995.531:22):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="bin"
pid=12530 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[642902.723748] audit: type=1400 audit(1561461995.531:23):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/games/" pid=12530 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[642902.723787] audit: type=1400 audit(1561461995.531:24):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/games/" pid=12530 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[642902.723830] audit: type=1400 audit(1561461995.531:25):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="sbin"
pid=12530 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[642902.723876] audit: type=1400 audit(1561461995.531:26):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="usr/sbin"
pid=12530 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[642902.723919] audit: type=1400 audit(1561461995.531:27):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/sbin/" pid=12530 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[986956.142965] audit: type=1400 audit(1561806032.684:28):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/bin/" pid=23585 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[986956.142999] audit: type=1400 audit(1561806032.684:29):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd"
name="image-20181130.26/rw/usr/bin" pid=23585 comm="ntpd"
requested_mask="r" denied_mask="r" fsuid=1002 ouid=0
[986956.143029] audit: type=1400 audit(1561806032.684:30):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="bin"
pid=23585 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[986956.143056] audit: type=1400 audit(1561806032.684:31):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/games/" pid=23585 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[986956.143081] audit: type=1400 audit(1561806032.684:32):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/games/" pid=23585 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[986956.143109] audit: type=1400 audit(1561806032.684:33):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="sbin"
pid=23585 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[986956.143138] audit: type=1400 audit(1561806032.684:34):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="usr/sbin"
pid=23585 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[986956.143165] audit: type=1400 audit(1561806032.684:35):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/sbin/" pid=23585 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[1334502.772598] audit: type=1400 audit(1562153562.891:36):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/bin/" pid=7214 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[1334502.772627] audit: type=1400 audit(1562153562.891:37):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd"
name="image-20181130.26/rw/usr/bin" pid=7214 comm="ntpd"
requested_mask="r" denied_mask="r" fsuid=1002 ouid=0
[1334502.772651] audit: type=1400 audit(1562153562.891:38):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="bin"
pid=7214 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[1334502.772673] audit: type=1400 audit(1562153562.891:39):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/games/" pid=7214 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[1334502.772692] audit: type=1400 audit(1562153562.891:40):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/games/" pid=7214 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[1334502.772715] audit: type=1400 audit(1562153562.891:41):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="sbin"
pid=7214 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[1334502.772738] audit: type=1400 audit(1562153562.891:42):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="usr/sbin"
pid=7214 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=1002
ouid=0
[1334502.772760] audit: type=1400 audit(1562153562.891:43):
apparmor="DENIED" operation="open" profile="/usr/sbin/ntpd"
name="/usr/local/sbin/" pid=7214 comm="ntpd" requested_mask="r"
denied_mask="r" fsuid=1002 ouid=0
[1456773.366951] traps: ..... error:0 <--------------problem time
[1456773.366973]  ...
[1461339.071954] linux-kernel-bde (5475): _interrupt_disconnect d 0
[1461339.071957] linux-kernel-bde (5475): _interrupt_disconnect: isr_active = 1
[1461339.071958] linux-kernel-bde (5475): disconnect primary isr
[1461339.086394] linux-bcm-knet (5540): Next DMA events (0x00000001)
[1461374.118180] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[1461375.621258] audit: type=1400 audit(1562280429.742:44):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="sbin"
pid=21156 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=0
ouid=0
[1461375.621294] audit: type=1400 audit(1562280429.742:45):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="bin"
pid=21156 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=0
ouid=0
[1461375.621328] audit: type=1400 audit(1562280429.742:46):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd" name="usr/sbin"
pid=21156 comm="ntpd" requested_mask="r" denied_mask="r" fsuid=0
ouid=0
[1461375.621361] audit: type=1400 audit(1562280429.742:47):
apparmor="DENIED" operation="open" info="Failed name lookup -
disconnected path" error=-13 profile="/usr/sbin/ntpd"
name="image-20181130.26/rw/usr/bin" pid=21156 comm="ntpd"
requested_mask="r" denied_mask="r" fsuid=0 ouid=0
[1461376.612413] igb 0000:00:14.0 eth0: igb: eth0 NIC Link is Up 1000
Mbps Full Duplex, Flow Control: RX/TX
[1461376.612547] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[1461390.608503] PortChannel101 (unregistering): Port device Ethernet34 removed
[1461390.644800] PortChannel101: Mode changed to "loadbalance"
[1461390.667092] IPv6: ADDRCONF(NETDEV_UP): PortChannel101: link is not ready
[1461390.722259] PortChannel102 (unregistering): Port device Ethernet36 removed
[1461390.758361] PortChannel102: Mode changed to "loadbalance"
[1461390.831039] IPv6: ADDRCONF(NETDEV_UP): PortChannel102: link is not ready
[1461390.877409] PortChannel103 (unregistering): Port device Ethernet37 removed
[1461390.927287] PortChannel103: Mode changed to "loadbalance"
[1461390.974006] IPv6: ADDRCONF(NETDEV_UP): PortChannel103: link is not ready
[1461391.024272] PortChannel104 (unregistering): Port device Ethernet38 removed
[1461391.098592] PortChannel104: Mode changed to "loadbalance"
[1461391.150354] IPv6: ADDRCONF(NETDEV_UP): PortChannel104: link is not ready
[1461391.184239] PortChannel105 (unregistering): Port device Ethernet39 removed
[1461391.233954] PortChannel105: Mode changed to "loadbalance"
[1461391.283714] IPv6: ADDRCONF(NETDEV_UP): PortChannel105: link is not ready
[1461391.357021] PortChannel106 (unregistering): Port device Ethernet42 removed
[1461391.395617] PortChannel106: Mode changed to "loadbalance"
[1461391.439371] IPv6: ADDRCONF(NETDEV_UP): PortChannel106: link is not ready
[1461391.517808] PortChannel107 (unregistering): Port device Ethernet44 removed
[1461391.578232] PortChannel107: Mode changed to "loadbalance"
[1461391.611486] IPv6: ADDRCONF(NETDEV_UP): PortChannel107: link is not ready
[1461391.679073] PortChannel108 (unregistering): Port device Ethernet45 removed
[1461391.754330] PortChannel108: Mode changed to "loadbalance"
[1461391.866820] IPv6: ADDRCONF(NETDEV_UP): PortChannel108: link is not ready
[1461391.954800] PortChannel109 (unregistering): Port device Ethernet46 removed
[1461392.026974] PortChannel109: Mode changed to "loadbalance"
[1461392.096086] IPv6: ADDRCONF(NETDEV_UP): PortChannel109: link is not ready
[1461392.224066] PortChannel110 (unregistering): Port device Ethernet47 removed
[1461392.297858] PortChannel110: Mode changed to "loadbalance"
[1461392.430096] IPv6: ADDRCONF(NETDEV_UP): PortChannel110: link is not ready
[1461392.530874] PortChannel111 (unregistering): Port device Ethernet50 removed
[1461392.594746] PortChannel111: Mode changed to "loadbalance"
[1461392.615928] IPv6: ADDRCONF(NETDEV_UP): PortChannel111: link is not ready
[1461392.694102] PortChannel112 (unregistering): Port device Ethernet52 removed
[1461392.760574] PortChannel112: Mode changed to "loadbalance"
[1461392.879835] IPv6: ADDRCONF(NETDEV_UP): PortChannel112: link is not ready
[1461393.001743] PortChannel113 (unregistering): Port device Ethernet53 removed
[1461393.080963] PortChannel113: Mode changed to "loadbalance"
[1461393.112925] IPv6: ADDRCONF(NETDEV_UP): PortChannel113: link is not ready
[1461393.243522] PortChannel114 (unregistering): Port device Ethernet54 removed
[1461393.330178] PortChannel114: Mode changed to "loadbalance"
[1461393.365419] IPv6: ADDRCONF(NETDEV_UP): PortChannel114: link is not ready
[1461393.504853] PortChannel115 (unregistering): Port device Ethernet55 removed
[1461393.563416] PortChannel115: Mode changed to "loadbalance"
[1461393.639953] IPv6: ADDRCONF(NETDEV_UP): PortChannel115: link is not ready
[1461393.680374] PortChannel116 (unregistering): Port device Ethernet58 removed
[1461393.724359] PortChannel116: Mode changed to "loadbalance"
[1461393.789539] IPv6: ADDRCONF(NETDEV_UP): PortChannel116: link is not ready
[1461393.857502] PortChannel117 (unregistering): Port device Ethernet60 removed
[1461393.896671] PortChannel117: Mode changed to "loadbalance"
[1461393.944544] IPv6: ADDRCONF(NETDEV_UP): PortChannel117: link is not ready
[1461394.078524] PortChannel118 (unregistering): Port device Ethernet61 removed
[1461394.152345] PortChannel118: Mode changed to "loadbalance"
[1461394.199118] IPv6: ADDRCONF(NETDEV_UP): PortChannel118: link is not ready
[1461394.243541] PortChannel57 (unregistering): Port device Ethernet0 removed
[1461394.290988] PortChannel57: Mode changed to "loadbalance"
[1461394.322525] IPv6: ADDRCONF(NETDEV_UP): PortChannel57: link is not ready
[1461394.406370] linux-kernel-bde (23749): _interrupt_connect d 0
[1461394.406374] linux-kernel-bde (23749): _interrupt_connect:isr_active = 1
[1461394.406376] linux-kernel-bde (23749): connect primary isr
[1461394.430883] PortChannel58 (unregistering): Port device Ethernet1 removed
[1461394.546400] PortChannel58: Mode changed to "loadbalance"
[1461394.649073] IPv6: ADDRCONF(NETDEV_UP): PortChannel58: link is not ready
[1461394.717548] linux-bcm-knet (24056): bkn_get_next_dma_event dev 0 evt_idx 0
[1461394.717552] linux-bcm-knet (24056): wait queue index 0
[1461394.718641] linux-kernel-bde (23749): _interrupt_connect d 0
[1461394.718645] linux-kernel-bde (23749): _interrupt_connect:isr_active = 1
[1461394.718646] linux-kernel-bde (23749): connect secondary isr
[1461394.782934] PortChannel59 (unregistering): Port device Ethernet16 removed
[1461394.854884] PortChannel59: Mode changed to "loadbalance"
[1461394.988996] IPv6: ADDRCONF(NETDEV_UP): PortChannel59: link is not ready
[1461395.067061] PortChannel60 (unregistering): Port device Ethernet17 removed
[1461395.158426] PortChannel60: Mode changed to "loadbalance"
[1461395.209420] IPv6: ADDRCONF(NETDEV_UP): PortChannel60: link is not ready
[1461395.356894] PortChannel61 (unregistering): Port device Ethernet4 removed
[1461395.513054] PortChannel61: Mode changed to "loadbalance"
[1461395.643909] IPv6: ADDRCONF(NETDEV_UP): PortChannel61: link is not ready
[1461395.726541] PortChannel62 (unregistering): Port device Ethernet5 removed
[1461395.805966] PortChannel62: Mode changed to "loadbalance"
[1461395.886602] IPv6: ADDRCONF(NETDEV_UP): PortChannel62: link is not ready
[1461395.961634] PortChannel63 (unregistering): Port device Ethernet20 removed
[1461396.026295] PortChannel63: Mode changed to "loadbalance"
[1461396.153304] IPv6: ADDRCONF(NETDEV_UP): PortChannel63: link is not ready
[1461396.288182] PortChannel64 (unregistering): Port device Ethernet21 removed
[1461396.364766] PortChannel64: Mode changed to "loadbalance"
[1461396.479758] IPv6: ADDRCONF(NETDEV_UP): PortChannel64: link is not ready
[1461441.626692] IPv6: ADDRCONF(NETDEV_UP): Ethernet52: link is not ready
[1461441.627295] PortChannel112: Port device Ethernet52 added
[1461441.700854] PortChannel113: Device Ethernet53 is up. Set it down
before adding it as a team port
[1461442.012349] IPv6: ADDRCONF(NETDEV_UP): Ethernet53: link is not ready
[1461442.013509] PortChannel113: Port device Ethernet53 added
[1461442.089923] IPv6: ADDRCONF(NETDEV_UP): Ethernet54: link is not ready
[1461442.090522] PortChannel114: Port device Ethernet54 added
[1461442.158644] IPv6: ADDRCONF(NETDEV_UP): Ethernet34: link is not ready
[1461442.159454] PortChannel101: Port device Ethernet34 added
[1461442.217985] IPv6: ADDRCONF(NETDEV_UP): Ethernet55: link is not ready
[1461442.218542] PortChannel115: Port device Ethernet55 added
[1461442.691347] IPv6: ADDRCONF(NETDEV_UP): Ethernet16: link is not ready
[1461442.691926] PortChannel59: Port device Ethernet16 added
[1461442.785148] IPv6: ADDRCONF(NETDEV_UP): Ethernet17: link is not ready
[1461442.800777] PortChannel60: Device Ethernet17 is up. Set it down
before adding it as a team port
[1461442.847564] IPv6: ADDRCONF(NETDEV_UP): Ethernet17: link is not ready
[1461442.848147] PortChannel60: Port device Ethernet17 added
[1461443.249885] IPv6: ADDRCONF(NETDEV_UP): Ethernet58: link is not ready
[1461443.250461] PortChannel116: Port device Ethernet58 added
[1461443.365401] IPv6: ADDRCONF(NETDEV_UP): Ethernet46: link is not ready
[1461443.366383] PortChannel109: Port device Ethernet46 added
[1461443.469521] IPv6: ADDRCONF(NETDEV_UP): Ethernet47: link is not ready
[1461443.470051] PortChannel110: Port device Ethernet47 added
[1461443.511868] IPv6: ADDRCONF(NETDEV_UP): Ethernet44: link is not ready
[1461443.512818] PortChannel107: Port device Ethernet44 added
[1461443.566106] PortChannel108: Port device Ethernet45 added
[1461443.873600] IPv6: ADDRCONF(NETDEV_UP): Ethernet20: link is not ready
[1461443.874191] PortChannel63: Port device Ethernet20 added
[1461443.937583] IPv6: ADDRCONF(NETDEV_UP): Ethernet21: link is not ready
[1461443.938094] PortChannel64: Port device Ethernet21 added
[1461444.498744] IPv6: ADDRCONF(NETDEV_UP): Ethernet4: link is not ready
[1461444.501056] PortChannel61: Port device Ethernet4 added
[1461444.558732] IPv6: ADDRCONF(NETDEV_UP): Ethernet5: link is not ready
[1461444.559254] PortChannel62: Port device Ethernet5 added
[1461444.685636] IPv6: ADDRCONF(NETDEV_UP): Ethernet60: link is not ready
[1461444.686175] PortChannel117: Port device Ethernet60 added
[1461444.733099] PortChannel118: Port device Ethernet61 added
[1461445.144717] IPv6: ADDRCONF(NETDEV_UP): Ethernet42: link is not ready
[1461445.145596] PortChannel106: Port device Ethernet42 added
[1461445.645208] IPv6: ADDRCONF(NETDEV_UP): Ethernet0: link is not ready
[1461445.645894] PortChannel57: Port device Ethernet0 added
[1461445.767703] IPv6: ADDRCONF(NETDEV_UP): Ethernet1: link is not ready
[1461445.769927] PortChannel58: Port device Ethernet1 added
[1461445.908863] PortChannel111: Port device Ethernet50 added
[1461446.292304] IPv6: ADDRCONF(NETDEV_UP): Ethernet38: link is not ready
[1461446.293501] PortChannel104: Port device Ethernet38 added
[1461446.317613] IPv6: ADDRCONF(NETDEV_UP): Ethernet39: link is not ready
[1461446.319105] PortChannel105: Port device Ethernet39 added
[1461446.419703] IPv6: ADDRCONF(NETDEV_UP): Ethernet36: link is not ready
[1461446.420741] PortChannel102: Port device Ethernet36 added
[1461446.487442] IPv6: ADDRCONF(NETDEV_UP): Ethernet37: link is not ready
[1461446.489386] PortChannel103: Port device Ethernet37 added
[1461454.906611] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet34: link becomes ready
[1461460.061108] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet16: link becomes ready
[1461460.071330] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet17: link becomes ready
[1461460.075613] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet46: link becomes ready
[1461460.078079] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet47: link becomes ready
[1461460.080690] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet44: link becomes ready
[1461460.082713] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet20: link becomes ready
[1461460.116907] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet21: link becomes ready
[1461460.117475] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet42: link becomes ready
[1461460.117891] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet0: link becomes ready
[1461460.118276] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet1: link becomes ready
[1461460.118913] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet38: link becomes ready
[1461460.119237] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet39: link becomes ready
[1461460.119525] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet36: link becomes ready
[1461460.119810] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet37: link becomes ready
[1461460.120094] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet52: link becomes ready
[1461460.120369] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet53: link becomes ready
[1461460.120658] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet54: link becomes ready
[1461460.121013] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet55: link becomes ready
[1461460.121352] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel108: link
becomes ready
[1461460.121502] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet58: link becomes ready
[1461460.121797] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet4: link becomes ready
[1461460.125872] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet5: link becomes ready
[1461460.127227] IPv6: ADDRCONF(NETDEV_CHANGE): Ethernet60: link becomes ready
[1461462.116305] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel63: link
becomes ready
[1461463.068894] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel59: link
becomes ready
[1461463.088290] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel60: link
becomes ready
[1461463.138709] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel64: link
becomes ready
[1461463.161766] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel57: link
becomes ready
[1461463.175966] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel58: link
becomes ready
[1461463.200306] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel61: link
becomes ready
[1461463.251863] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel62: link
becomes ready
[1461480.692587] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel101: link
becomes ready
[1461480.711640] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel102: link
becomes ready
[1461480.827927] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel105: link
becomes ready
[1461480.876749] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel103: link
becomes ready
[1461481.133201] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel104: link
becomes ready
[1461481.169094] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel111: link
becomes ready
[1461481.238078] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel109: link
becomes ready
[1461481.247837] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel112: link
becomes ready
[1461481.276051] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel110: link
becomes ready
[1461481.306425] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel107: link
becomes ready
[1461481.387960] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel116: link
becomes ready
[1461481.402663] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel106: link
becomes ready
[1461481.512918] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel117: link
becomes ready
[1461481.578713] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel115: link
becomes ready
[1461481.617057] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel114: link
becomes ready
[1461481.675983] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel113: link
becomes ready
[1461481.776071] IPv6: ADDRCONF(NETDEV_CHANGE): PortChannel118: link
becomes ready


Regards,
Arul


On Mon, Aug 19, 2019 at 11:59 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Arul,
>
> On Mon, 19 Aug 2019, Arul Jeniston wrote:
>
> > > hits ktime_get() or whether it happens concurrent on a different CPU.
> > > ktime_get() can never use inconsistent tk data for calculating the time.
> >
> > Agreed. I think, I am not making my point clear here.
> > Do you mean to say ktime_get() would always return incremental time
> > irrespective of isr and multi-processors?
>
> Yes. The only exception is when the TSC is either jumping or not fully in
> sync between cores.
>
> > If yes, this is where, I have difference of understanding.
>
> And your understanding is still wrong. I explain it to you _once_ more:
>
> The side which updates the timekeeper:
>
>     - increments the sequence count _BEFORE_ it changes any data. After that
>       increment the sequence count is odd, i.e. bit 0 is set.
>
>     - updates data (base, last, mult, shift ....)
>
>     - increments it again _AFTER_ it updated data.  After that increment
>       the sequence count is even, i.e. bit 0 is cleared.
>
> The read out side:
>
> start:
>     - reads the sequence count
>       - if sequence count is odd (update in progress) go back to start
>
>     - reads base from timekeeper data
>     - reads TSC and calculates the delta with timekeeper data
>       (last, mult, shift ...), i.e. timekeeping_get_ns().
>
>     - reads the sequence count again.
>
>       If it is even and the same as read above, the data is valid and
>       consistent and the result is returned.
>
>       If the sequence count is different to the original value it goes back
>       to start.
>
> It does not matter at all if timekeeping_get_ns() returns occasionally a
> wrong value due to timekeeper data being updated concurrently. The result
> is discarded and never returned to the caller. It tries again.
>
> All places which update the timer keeper issue the sequence count increment
> protection and are properly serialized against each other. So there is no
> occacional point where ktime_get() would return random crap due to being
> interrupted by an update or due to a concurrent update on a different CPU.
>
> This is a protection mechanism which is well understood in computer science
> (seqlock with lockless readers) and it works in kernel timekeeping for way
> more than a decade without any issue except when the underlying hardware
> clocksource (TSC in that case) misbehaves. There is no way to protect the
> code against this and we are not going to do anything about it simply
> because we can't.
>
> The fact that you can observe the (cycles < last) condition is not proving
> anything. Just looking at the (cycles < last) condition is wrong. You need
> to proof that the result is returned from ktime_get() without a retry
> despite the sequence counter being changed. I doubt you can.
>
> If you can prove that the condition is met _AND_ the sequence counter has
> NOT changed, then you have proven that the TSC on your machine is not
> correctly synchronized or otherwise returning crap values.
>
> You can make up further weird theories about the incorrectness of that
> code, but these theories wont become magically true.
>
> Thanks,
>
>         tglx
