Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B144C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5C2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 08:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCc5XNHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfC0IV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 04:21:28 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46715 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfC0IV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 04:21:27 -0400
Received: by mail-ed1-f67.google.com with SMTP id d1so13161668edd.13;
        Wed, 27 Mar 2019 01:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=DKZ4zLp0sREFxpLNSzF75pLrfcYehnz0g89gccLY4vA=;
        b=sCc5XNHbf32k+PW1LQZJX3jhSqP6bkmtyQnJFgS5N93c7gFngYVezA87TxeqgeUaP4
         WL6vGo0eiZth9ZFDxR5dcY0g7Q4QfgoBsDhyELadun/UVe7VPypArshMKgY3coFW4Sk2
         jiwZPtm61GnZx4TbXQltvLgqTUKlOD375T6a7TEGn5ZiDlxQgP23PfqpzFrGJbJ3rYty
         N9+RtIGu7uKmM1M5RibcAQX3+TNjP+sb+kg1JevO1TYn2g9DQa9vH1CP/qNxfztypozd
         oRPQh/PscCcU4kBIhVWNOzP2x/ZJijAH/2UNSV0cVb0Ls26uON6hDAQ5gBW65n9MfqGM
         WjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=DKZ4zLp0sREFxpLNSzF75pLrfcYehnz0g89gccLY4vA=;
        b=RL9ltYEkEQ0NchZYbW4apxO8qcrzxqptA+hB9IrjMy6xEd0XQGA2WlKjk7qWJKHKgP
         vk75ScU5sJCJlDOTcpTfiF19Lr383+M0cSPAkCmt+nfJdD7ADcHamVaYL9HWt5KbNFbb
         3+8VbnYWvYJySmAPnT3yMJd5raqE2ni54OFowRwoftzokhxD0dCaFweh50lEZSB3fahq
         R7p10eXHUpNOj4FBSRYOSyaWe93Dz/YWfSjBbnDhWci6jkJKmplabIHC1dq0CKc5NNko
         jNTFLn2KlARJDxXpGUXxRrt5R1LepSul2YAmvcohJYcexpFo6Df93iSW1Aeyj6cB4XjM
         oEiA==
X-Gm-Message-State: APjAAAUNrzgYLCUxqMXijAT8ydOSVh3p9KaXKdBqHWMqS992O5l9J3WU
        WNRpLJGQfNbIL7b7l0I1qDM=
X-Google-Smtp-Source: APXvYqw9UlZMzwuSrP4Udgl2mASPy3VYoGnYb5CXPwsOmCE/4INoU88ZgA2mo4pKTTZFqwkbIIcedw==
X-Received: by 2002:a50:9970:: with SMTP id l45mr23742613edb.171.1553674881255;
        Wed, 27 Mar 2019 01:21:21 -0700 (PDT)
Received: from dumbo ([83.137.6.242])
        by smtp.gmail.com with ESMTPSA id q45sm1184390edd.88.2019.03.27.01.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 01:21:20 -0700 (PDT)
Date:   Wed, 27 Mar 2019 09:21:15 +0100
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [REGRESSION] 5.1-rc1: tpm_try_transmit: send(): error -5
Message-ID: <20190327082115.k35fhxfkk25ekdzw@dumbo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jarkko,

  my laptop fails to suspend/hibernate since v5.1-rc1, it worked fine
with v4.20 and previous.

My suspect is on tpm_tis driver, is there anything I can do to understand
what goes wrong here?

Best regards,
Domenico


[    0.000000] Linux version 5.1.0-rc2 (cavok@dumbo) (gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1)) #29 SMP Mon Mar 25 09:03:06 CET 2019
[    0.000000] Command line: BOOT_IMAGE=/vmlinuz-5.1.0-rc2 root=/dev/mapper/vg_enc-root ro quiet libata.force=1.00:disable
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
[    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
[    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000b70fafff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b70fb000-0x00000000b7c7efff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000b7c7f000-0x00000000b7e7efff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x00000000b7e7f000-0x00000000b7efefff] ACPI data
[    0.000000] BIOS-e820: [mem 0x00000000b7eff000-0x00000000b7efffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b7f00000-0x00000000bc7fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80fa000-0x00000000f80fafff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000f80fd000-0x00000000f80fdfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000004417fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] e820: update [mem 0x98215018-0x98223c57] usable ==> usable
[    0.000000] e820: update [mem 0x98215018-0x98223c57] usable ==> usable
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000000000-0x0000000000057fff] usable
[    0.000000] reserve setup_data: [mem 0x0000000000058000-0x0000000000058fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000059000-0x000000000009dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000000009e000-0x00000000000fffff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000000100000-0x0000000098215017] usable
[    0.000000] reserve setup_data: [mem 0x0000000098215018-0x0000000098223c57] usable
[    0.000000] reserve setup_data: [mem 0x0000000098223c58-0x00000000b70fafff] usable
[    0.000000] reserve setup_data: [mem 0x00000000b70fb000-0x00000000b7c7efff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000b7c7f000-0x00000000b7e7efff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x00000000b7e7f000-0x00000000b7efefff] ACPI data
[    0.000000] reserve setup_data: [mem 0x00000000b7eff000-0x00000000b7efffff] usable
[    0.000000] reserve setup_data: [mem 0x00000000b7f00000-0x00000000bc7fffff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f80fa000-0x00000000f80fafff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000f80fd000-0x00000000f80fdfff] reserved
[    0.000000] reserve setup_data: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] reserve setup_data: [mem 0x0000000100000000-0x00000004417fffff] usable
[    0.000000] efi: EFI v2.40 by HP
[    0.000000] efi:  ACPI=0xb7efe000  ACPI 2.0=0xb7efe014  SMBIOS=0xb78db000  ESRT=0xb6fdf660 
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: HP HP EliteBook 850 G3/8079, BIOS N75 Ver. 01.24 01/30/2018
[    0.000000] tsc: Detected 2500.000 MHz processor
[    0.001589] tsc: Detected 2496.000 MHz TSC
[    0.001589] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.001591] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.001595] last_pfn = 0x441800 max_arch_pfn = 0x400000000
[    0.001605] MTRR default type: write-back
[    0.001606] MTRR fixed ranges enabled:
[    0.001607]   00000-9FFFF write-back
[    0.001607]   A0000-BFFFF uncachable
[    0.001608]   C0000-FFFFF write-protect
[    0.001608] MTRR variable ranges enabled:
[    0.001610]   0 base 00C0000000 mask 7FC0000000 uncachable
[    0.001610]   1 base 00BC000000 mask 7FFC000000 uncachable
[    0.001611]   2 base 00BA000000 mask 7FFE000000 uncachable
[    0.001612]   3 disabled
[    0.001612]   4 disabled
[    0.001612]   5 disabled
[    0.001613]   6 disabled
[    0.001613]   7 disabled
[    0.001613]   8 disabled
[    0.001614]   9 disabled
[    0.002417] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.002541] last_pfn = 0xb7f00 max_arch_pfn = 0x400000000
[    0.015112] esrt: ESRT header is not in the memory map.
[    0.015118] Base memory trampoline at [(____ptrval____)] 98000 size 24576
[    0.015121] Using GB pages for direct mapping
[    0.015123] BRK [0x187801000, 0x187801fff] PGTABLE
[    0.015124] BRK [0x187802000, 0x187802fff] PGTABLE
[    0.015125] BRK [0x187803000, 0x187803fff] PGTABLE
[    0.015156] BRK [0x187804000, 0x187804fff] PGTABLE
[    0.015157] BRK [0x187805000, 0x187805fff] PGTABLE
[    0.015319] BRK [0x187806000, 0x187806fff] PGTABLE
[    0.015348] BRK [0x187807000, 0x187807fff] PGTABLE
[    0.015383] BRK [0x187808000, 0x187808fff] PGTABLE
[    0.015439] Secure boot disabled
[    0.015440] RAMDISK: [mem 0x3d330000-0x3fffdfff]
[    0.015444] ACPI: Early table checksum verification disabled
[    0.015446] ACPI: RSDP 0x00000000B7EFE014 000024 (v02 HPQOEM)
[    0.015449] ACPI: XSDT 0x00000000B7EBB188 0000E4 (v01 HPQOEM SLIC-BPC 00000000      01000013)
[    0.015453] ACPI: FACP 0x00000000B7EEE000 0000F4 (v05 HPQOEM SLIC-BPC 00000000 HP   00000001)
[    0.015457] ACPI: DSDT 0x00000000B7EC4000 02654A (v02 HPQOEM 8079     00000000 INTL 20121018)
[    0.015459] ACPI: FACS 0x00000000B7E58000 000040
[    0.015461] ACPI: SSDT 0x00000000B7EFC000 000108 (v02 HP     ShmTable 00000001 INTL 20121018)
[    0.015463] ACPI: TCPA 0x00000000B7EFA000 000032 (v02 HPQOEM EDK2     00000002      01000013)
[    0.015465] ACPI: SSDT 0x00000000B7EF9000 0003B8 (v02 HPQOEM TcgTable 00001000 INTL 20121018)
[    0.015467] ACPI: UEFI 0x00000000B7E6A000 000042 (v01 HPQOEM EDK2     00000002      01000013)
[    0.015469] ACPI: SSDT 0x00000000B7EF3000 0051FA (v02 SaSsdt SaSsdt   00003000 INTL 20121018)
[    0.015471] ACPI: SSDT 0x00000000B7EF2000 0005B1 (v01 Intel  PerfTune 00001000 INTL 20121018)
[    0.015473] ACPI: MSDM 0x00000000B7EF1000 000055 (v03 HPQOEM SLIC-BPC 00000000 HP   00000001)
[    0.015475] ACPI: SLIC 0x00000000B7EF0000 000176 (v01 HPQOEM SLIC-BPC 00000001 HP   00000001)
[    0.015477] ACPI: WSMT 0x00000000B7EEF000 000028 (v01 HPQOEM 8079     00000001 HP   00000001)
[    0.015479] ACPI: HPET 0x00000000B7EED000 000038 (v01 HPQOEM 8079     00000001 HP   00000001)
[    0.015481] ACPI: APIC 0x00000000B7EEC000 0000BC (v01 HPQOEM 8079     00000001 HP   00000001)
[    0.015483] ACPI: MCFG 0x00000000B7EEB000 00003C (v01 HPQOEM 8079     00000001 HP   00000001)
[    0.015484] ACPI: SSDT 0x00000000B7EC3000 00019A (v02 HPQOEM Sata0Ide 00001000 INTL 20121018)
[    0.015486] ACPI: SSDT 0x00000000B7EC2000 000729 (v01 HPQOEM PtidDevc 00001000 INTL 20121018)
[    0.015488] ACPI: SSDT 0x00000000B7EC1000 0003DC (v02 HPQOEM SDS_RTD3 00001000 INTL 20121018)
[    0.015490] ACPI: SSDT 0x00000000B7EC0000 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 20121018)
[    0.015492] ACPI: DMAR 0x00000000B7EBF000 0000CC (v01 INTEL  SKL      00000001 INTL 00000001)
[    0.015494] ACPI: NHLT 0x00000000B7EBE000 00002D (v00 INTEL  EDK2     00000002      01000013)
[    0.015496] ACPI: SSDT 0x00000000B7EBC000 0010DA (v01 HP     AMDSGPCH 00001000 INTL 20121018)
[    0.015498] ACPI: ASF! 0x00000000B7EFD000 0000A5 (v32 HPQOEM  UYA     00000001 TFSM 000F4240)
[    0.015500] ACPI: FPDT 0x00000000B7EBA000 000044 (v01 HPQOEM EDK2     00000002      01000013)
[    0.015502] ACPI: BGRT 0x00000000B7EB9000 000038 (v01 HPQOEM EDK2     00000002      01000013)
[    0.015504] ACPI: SSDT 0x00000000B7EFB000 000260 (v02 HP     PwrCtlEv 00000001 INTL 20121018)
[    0.015509] ACPI: Local APIC address 0xfee00000
[    0.015677] No NUMA configuration found
[    0.015677] Faking a node at [mem 0x0000000000000000-0x00000004417fffff]
[    0.015688] NODE_DATA(0) allocated [mem 0x4417fb000-0x4417fffff]
[    0.015707] Zone ranges:
[    0.015707]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.015708]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.015709]   Normal   [mem 0x0000000100000000-0x00000004417fffff]
[    0.015710]   Device   empty
[    0.015710] Movable zone start for each node
[    0.015711] Early memory node ranges
[    0.015712]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
[    0.015712]   node   0: [mem 0x0000000000059000-0x000000000009dfff]
[    0.015713]   node   0: [mem 0x0000000000100000-0x00000000b70fafff]
[    0.015713]   node   0: [mem 0x00000000b7eff000-0x00000000b7efffff]
[    0.015714]   node   0: [mem 0x0000000100000000-0x00000004417fffff]
[    0.015768] Zeroed struct page in unavailable ranges: 3944 pages
[    0.015769] Initmem setup node 0 [mem 0x0000000000001000-0x00000004417fffff]
[    0.015770] On node 0 totalpages: 4163736
[    0.015771]   DMA zone: 64 pages used for memmap
[    0.015771]   DMA zone: 21 pages reserved
[    0.015772]   DMA zone: 3996 pages, LIFO batch:0
[    0.015851]   DMA32 zone: 11652 pages used for memmap
[    0.015851]   DMA32 zone: 745724 pages, LIFO batch:63
[    0.031554]   Normal zone: 53344 pages used for memmap
[    0.031561]   Normal zone: 3414016 pages, LIFO batch:63
[    0.099616] Reserving Intel graphics memory at [mem 0xba800000-0xbc7fffff]
[    0.099792] ACPI: PM-Timer IO Port: 0x1808
[    0.099793] ACPI: Local APIC address 0xfee00000
[    0.099798] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.099799] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.099799] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.099800] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.099800] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.099801] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.099801] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.099802] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.099828] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.099829] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.099830] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.099831] ACPI: IRQ0 used by override.
[    0.099833] ACPI: IRQ9 used by override.
[    0.099835] Using ACPI (MADT) for SMP configuration information
[    0.099836] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.099837] efi_bgrt: Ignoring BGRT: null image address
[    0.099839] smpboot: Allowing 4 CPUs, 0 hotplug CPUs
[    0.099851] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.099852] PM: Registered nosave memory: [mem 0x00058000-0x00058fff]
[    0.099853] PM: Registered nosave memory: [mem 0x0009e000-0x000fffff]
[    0.099854] PM: Registered nosave memory: [mem 0x98215000-0x98215fff]
[    0.099855] PM: Registered nosave memory: [mem 0x98223000-0x98223fff]
[    0.099856] PM: Registered nosave memory: [mem 0xb70fb000-0xb7c7efff]
[    0.099857] PM: Registered nosave memory: [mem 0xb7c7f000-0xb7e7efff]
[    0.099857] PM: Registered nosave memory: [mem 0xb7e7f000-0xb7efefff]
[    0.099858] PM: Registered nosave memory: [mem 0xb7f00000-0xbc7fffff]
[    0.099859] PM: Registered nosave memory: [mem 0xbc800000-0xf80f9fff]
[    0.099859] PM: Registered nosave memory: [mem 0xf80fa000-0xf80fafff]
[    0.099860] PM: Registered nosave memory: [mem 0xf80fb000-0xf80fcfff]
[    0.099860] PM: Registered nosave memory: [mem 0xf80fd000-0xf80fdfff]
[    0.099861] PM: Registered nosave memory: [mem 0xf80fe000-0xfdffffff]
[    0.099861] PM: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.099861] PM: Registered nosave memory: [mem 0xfe011000-0xffffffff]
[    0.099863] [mem 0xbc800000-0xf80f9fff] available for PCI devices
[    0.099864] Booting paravirtualized kernel on bare hardware
[    0.099867] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.181439] random: get_random_bytes called from start_kernel+0x95/0x4ae with crng_init=0
[    0.181446] setup_percpu: NR_CPUS:16 nr_cpumask_bits:16 nr_cpu_ids:4 nr_node_ids:1
[    0.181600] percpu: Embedded 45 pages/cpu @(____ptrval____) s146008 r8192 d30120 u524288
[    0.181606] pcpu-alloc: s146008 r8192 d30120 u524288 alloc=1*2097152
[    0.181607] pcpu-alloc: [0] 0 1 2 3 
[    0.181624] Built 1 zonelists, mobility grouping on.  Total pages: 4098655
[    0.181624] Policy zone: Normal
[    0.181626] Kernel command line: BOOT_IMAGE=/vmlinuz-5.1.0-rc2 root=/dev/mapper/vg_enc-root ro quiet libata.force=1.00:disable
[    0.223640] Memory: 16126604K/16654944K available (10243K kernel code, 1149K rwdata, 3220K rodata, 1592K init, 2352K bss, 528340K reserved, 0K cma-reserved)
[    0.223711] Kernel/User page tables isolation: enabled
[    0.223723] ftrace: allocating 32171 entries in 126 pages
[    0.235524] rcu: Hierarchical RCU implementation.
[    0.235526] rcu: 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=4.
[    0.235527] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.235527] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.238095] NR_IRQS: 4352, nr_irqs: 1024, preallocated irqs: 16
[    0.238465] Console: colour dummy device 80x25
[    0.238468] printk: console [tty0] enabled
[    0.238483] ACPI: Core revision 20190215
[    0.238824] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
[    0.238853] hpet clockevent registered
[    0.238889] APIC: Switch to symmetric I/O mode setup
[    0.238890] DMAR: Host address width 39
[    0.238891] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.238897] DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e3ff0505e
[    0.238898] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.238901] DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050da
[    0.238902] DMAR: RMRR base: 0x000000b7c37000 end: 0x000000b7c56fff
[    0.238902] DMAR: RMRR base: 0x000000ba000000 end: 0x000000bc7fffff
[    0.238903] DMAR: ANDD device: 1 name: \_SB.PCI0.I2C0
[    0.238905] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.238905] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.238906] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.240506] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.240507] x2apic enabled
[    0.240518] Switched APIC routing to cluster x2apic.
[    0.244383] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.262863] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
[    0.262873] Calibrating delay loop (skipped), value calculated using timer frequency.. 4992.00 BogoMIPS (lpj=9984000)
[    0.262875] pid_max: default: 32768 minimum: 301
[    0.266368] LSM: Security Framework initializing
[    0.266377] Yama: becoming mindful.
[    0.266383] SELinux:  Initializing.
[    0.266395] *** VALIDATE SELinux ***
[    0.266396] TOMOYO Linux initialized
[    0.268493] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes)
[    0.269543] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes)
[    0.269583] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.269614] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.269739] *** VALIDATE proc ***
[    0.269775] *** VALIDATE cgroup1 ***
[    0.269776] *** VALIDATE cgroup2 ***
[    0.269807] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    0.269807] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)
[    0.269812] mce: CPU supports 8 MCE banks
[    0.269821] mce: CPU0: Thermal monitoring enabled (TM1)
[    0.269835] process: using mwait in idle threads
[    0.269837] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
[    0.269837] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
[    0.269839] Spectre V2 : Mitigation: Full generic retpoline
[    0.269839] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.269840] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    0.269845] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.269845] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
[    0.269845] Speculative Store Bypass: Vulnerable
[    0.270096] Freeing SMP alternatives memory: 28K
[    0.273117] TSC deadline timer enabled
[    0.273122] smpboot: CPU0: Intel(R) Core(TM) i5-6300U CPU @ 2.40GHz (family: 0x6, model: 0x4e, stepping: 0x3)
[    0.273229] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.273255] ... version:                4
[    0.273255] ... bit width:              48
[    0.273255] ... generic registers:      4
[    0.273256] ... value mask:             0000ffffffffffff
[    0.273257] ... max period:             00007fffffffffff
[    0.273257] ... fixed-purpose events:   3
[    0.273257] ... event mask:             000000070000000f
[    0.273289] rcu: Hierarchical SRCU implementation.
[    0.273867] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.273906] smp: Bringing up secondary CPUs ...
[    0.273973] x86: Booting SMP configuration:
[    0.273974] .... node  #0, CPUs:      #1 #2 #3
[    0.274333] smp: Brought up 1 node, 4 CPUs
[    0.274333] smpboot: Max logical packages: 1
[    0.274333] smpboot: Total of 4 processors activated (19968.00 BogoMIPS)
[    0.275231] devtmpfs: initialized
[    0.275231] x86/mm: Memory block size: 128MB
[    0.276051] PM: Registering ACPI NVS region [mem 0xb7c7f000-0xb7e7efff] (2097152 bytes)
[    0.276051] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.276051] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.276051] pinctrl core: initialized pinctrl subsystem
[    0.276051] NET: Registered protocol family 16
[    0.276051] audit: initializing netlink subsys (disabled)
[    0.276051] audit: type=2000 audit(1553677214.040:1): state=initialized audit_enabled=0 res=1
[    0.276051] cpuidle: using governor ladder
[    0.276051] cpuidle: using governor menu
[    0.276051] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    0.276051] ACPI: bus type PCI registered
[    0.276051] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.276051] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    0.276051] PCI: not using MMCONFIG
[    0.276051] PCI: Using configuration type 1 for base access
[    0.276051] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
[    0.276051] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
[    0.276051] ACPI: Added _OSI(Module Device)
[    0.276051] ACPI: Added _OSI(Processor Device)
[    0.276051] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.276051] ACPI: Added _OSI(Processor Aggregator Device)
[    0.276051] ACPI: Added _OSI(Linux-Dell-Video)
[    0.276051] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.276051] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.308960] ACPI: 11 ACPI AML tables successfully acquired and loaded
[    0.312008] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.316560] ACPI: Dynamic OEM Table Load:
[    0.316571] ACPI: SSDT 0xFFFF9D1A2E9A7800 00063F (v02 PmRef  Cpu0Ist  00003000 INTL 20121018)
[    0.316994] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
[    0.318000] ACPI: Dynamic OEM Table Load:
[    0.318006] ACPI: SSDT 0xFFFF9D1A2E8AF000 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 20121018)
[    0.318370] ACPI: Dynamic OEM Table Load:
[    0.318374] ACPI: SSDT 0xFFFF9D1A2E94F3C0 00008E (v02 PmRef  Cpu0Hwp  00003000 INTL 20121018)
[    0.318635] ACPI: Dynamic OEM Table Load:
[    0.318639] ACPI: SSDT 0xFFFF9D1A2E8ADA00 000130 (v02 PmRef  HwpLvt   00003000 INTL 20121018)
[    0.319390] ACPI: Dynamic OEM Table Load:
[    0.319398] ACPI: SSDT 0xFFFF9D1A2EE71800 0005AA (v02 PmRef  ApIst    00003000 INTL 20121018)
[    0.319865] ACPI: Dynamic OEM Table Load:
[    0.319865] ACPI: SSDT 0xFFFF9D1A2E8AE800 000119 (v02 PmRef  ApHwp    00003000 INTL 20121018)
[    0.319865] ACPI: Dynamic OEM Table Load:
[    0.319865] ACPI: SSDT 0xFFFF9D1A2E8AEE00 000119 (v02 PmRef  ApCst    00003000 INTL 20121018)
[    0.321035] ACPI: EC: EC started
[    0.321035] ACPI: EC: interrupt blocked
[    3.643421] ACPI: \_SB_.PCI0.LPCB.EC0_: Used as first EC
[    3.643423] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x6e, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    3.643424] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions
[    3.643424] ACPI: Interpreter enabled
[    3.643473] ACPI: (supports S0 S3 S4 S5)
[    3.643474] ACPI: Using IOAPIC for interrupt routing
[    3.643514] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] (base 0xf8000000)
[    3.646183] PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in ACPI motherboard resources
[    3.646190] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.646809] ACPI: Enabled 8 GPEs in block 00 to 7F
[    3.648057] ACPI: Power Resource [PG01] (on)
[    3.648363] ACPI: Power Resource [PG02] (on)
[    3.648677] ACPI: Power Resource [PG00] (on)
[    3.653292] ACPI: Power Resource [WRST] (on)
[    3.653489] ACPI: Power Resource [PXP] (on)
[    3.783420] ACPI: Power Resource [WRST] (on)
[    3.783841] ACPI: Power Resource [WRST] (on)
[    3.784354] ACPI: Power Resource [WRST] (on)
[    3.784441] ACPI: Power Resource [PC09] (on)
[    3.785124] ACPI: Power Resource [WRST] (on)
[    3.785581] ACPI: Power Resource [WRST] (on)
[    3.785991] ACPI: Power Resource [WRST] (on)
[    3.786398] ACPI: Power Resource [WRST] (on)
[    3.786805] ACPI: Power Resource [WRST] (on)
[    3.787225] ACPI: Power Resource [WRST] (on)
[    3.787633] ACPI: Power Resource [WRST] (on)
[    3.788048] ACPI: Power Resource [WRST] (on)
[    3.788424] ACPI: Power Resource [WRST] (on)
[    3.788802] ACPI: Power Resource [WRST] (on)
[    3.789176] ACPI: Power Resource [WRST] (on)
[    3.789551] ACPI: Power Resource [WRST] (on)
[    3.789927] ACPI: Power Resource [WRST] (on)
[    3.790310] ACPI: Power Resource [WRST] (on)
[    3.790691] ACPI: Power Resource [WRST] (on)
[    3.791067] ACPI: Power Resource [WRST] (on)
[    3.798849] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
[    3.798854] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.801530] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]
[    3.801531] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using BIOS configuration
[    3.803139] PCI host bridge to bus 0000:00
[    3.803141] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    3.803142] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    3.803143] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.803144] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3fff window]
[    3.803144] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7fff window]
[    3.803145] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cbfff window]
[    3.803146] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cffff window]
[    3.803147] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3fff window]
[    3.803148] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7fff window]
[    3.803149] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000dbfff window]
[    3.803150] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000dffff window]
[    3.803152] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3fff window]
[    3.803153] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7fff window]
[    3.803154] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000ebfff window]
[    3.803155] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000effff window]
[    3.803156] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000fffff window]
[    3.803157] pci_bus 0000:00: root bus resource [mem 0xbc800000-0xf7ffffff window]
[    3.803157] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
[    3.803158] pci_bus 0000:00: root bus resource [bus 00-3e]
[    3.803165] pci 0000:00:00.0: [8086:1904] type 00 class 0x060000
[    3.803823] pci 0000:00:02.0: [8086:1916] type 00 class 0x030000
[    3.803834] pci 0000:00:02.0: reg 0x10: [mem 0xe0000000-0xe0ffffff 64bit]
[    3.803839] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bit pref]
[    3.803843] pci 0000:00:02.0: reg 0x20: [io  0x4000-0x403f]
[    3.803857] pci 0000:00:02.0: BAR 2: assigned to efifb
[    3.804564] pci 0000:00:14.0: [8086:9d2f] type 00 class 0x0c0330
[    3.804583] pci 0000:00:14.0: reg 0x10: [mem 0xe1320000-0xe132ffff 64bit]
[    3.804642] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    3.805342] pci 0000:00:14.2: [8086:9d31] type 00 class 0x118000
[    3.805361] pci 0000:00:14.2: reg 0x10: [mem 0xe134b000-0xe134bfff 64bit]
[    3.806090] pci 0000:00:15.0: [8086:9d60] type 00 class 0x118000
[    3.806240] pci 0000:00:15.0: reg 0x10: [mem 0xe134c000-0xe134cfff 64bit]
[    3.807329] pci 0000:00:16.0: [8086:9d3a] type 00 class 0x078000
[    3.807348] pci 0000:00:16.0: reg 0x10: [mem 0xe134d000-0xe134dfff 64bit]
[    3.807413] pci 0000:00:16.0: PME# supported from D3hot
[    3.808071] pci 0000:00:16.3: [8086:9d3d] type 00 class 0x070002
[    3.808086] pci 0000:00:16.3: reg 0x10: [io  0x4080-0x4087]
[    3.808092] pci 0000:00:16.3: reg 0x14: [mem 0xe134a000-0xe134afff]
[    3.808776] pci 0000:00:17.0: [8086:9d03] type 00 class 0x010601
[    3.808793] pci 0000:00:17.0: reg 0x10: [mem 0xe1348000-0xe1349fff]
[    3.808800] pci 0000:00:17.0: reg 0x14: [mem 0xe1350000-0xe13500ff]
[    3.808807] pci 0000:00:17.0: reg 0x18: [io  0x4088-0x408f]
[    3.808814] pci 0000:00:17.0: reg 0x1c: [io  0x4090-0x4093]
[    3.808820] pci 0000:00:17.0: reg 0x20: [io  0x4040-0x405f]
[    3.808825] pci 0000:00:17.0: reg 0x24: [mem 0xe134e000-0xe134e7ff]
[    3.808864] pci 0000:00:17.0: PME# supported from D3hot
[    3.809534] pci 0000:00:1c.0: [8086:9d11] type 01 class 0x060400
[    3.810202] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    3.810896] pci 0000:00:1c.3: [8086:9d13] type 01 class 0x060400
[    3.810971] pci 0000:00:1c.3: PME# supported from D0 D3hot D3cold
[    3.811660] pci 0000:00:1c.4: [8086:9d14] type 01 class 0x060400
[    3.811728] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    3.812427] pci 0000:00:1f.0: [8086:9d48] type 00 class 0x060100
[    3.813148] pci 0000:00:1f.2: [8086:9d21] type 00 class 0x058000
[    3.813161] pci 0000:00:1f.2: reg 0x10: [mem 0xe1340000-0xe1343fff]
[    3.813849] pci 0000:00:1f.3: [8086:9d70] type 00 class 0x040380
[    3.813874] pci 0000:00:1f.3: reg 0x10: [mem 0xe1344000-0xe1347fff 64bit]
[    3.813897] pci 0000:00:1f.3: reg 0x20: [mem 0xe1330000-0xe133ffff 64bit]
[    3.813941] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    3.814630] pci 0000:00:1f.4: [8086:9d23] type 00 class 0x0c0500
[    3.814683] pci 0000:00:1f.4: reg 0x10: [mem 0xe134f000-0xe134f0ff 64bit]
[    3.814745] pci 0000:00:1f.4: reg 0x20: [io  0xefa0-0xefbf]
[    3.815473] pci 0000:00:1f.6: [8086:156f] type 00 class 0x020000
[    3.815497] pci 0000:00:1f.6: reg 0x10: [mem 0xe1300000-0xe131ffff]
[    3.815589] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
[    3.816305] pci 0000:01:00.0: [10ec:522a] type 00 class 0xff0000
[    3.816334] pci 0000:01:00.0: reg 0x10: [mem 0xe1000000-0xe1000fff]
[    3.816469] pci 0000:01:00.0: supports D1 D2
[    3.816469] pci 0000:01:00.0: PME# supported from D1 D2 D3hot D3cold
[    3.816648] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    3.816652] pci 0000:00:1c.0:   bridge window [mem 0xe1000000-0xe10fffff]
[    3.816760] pci 0000:02:00.0: [8086:24f3] type 00 class 0x028000
[    3.816807] pci 0000:02:00.0: reg 0x10: [mem 0xe1100000-0xe1101fff 64bit]
[    3.817072] pci 0000:02:00.0: PME# supported from D0 D3hot D3cold
[    3.817453] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    3.817457] pci 0000:00:1c.3:   bridge window [mem 0xe1100000-0xe11fffff]
[    3.817508] pci 0000:03:00.0: [1002:6604] type 00 class 0x030000
[    3.817529] pci 0000:03:00.0: reg 0x10: [mem 0xc0000000-0xcfffffff 64bit pref]
[    3.817540] pci 0000:03:00.0: reg 0x18: [mem 0xe1200000-0xe123ffff 64bit]
[    3.817547] pci 0000:03:00.0: reg 0x20: [io  0x3000-0x30ff]
[    3.817560] pci 0000:03:00.0: reg 0x30: [mem 0xfffe0000-0xffffffff pref]
[    3.817565] pci 0000:03:00.0: enabling Extended Tags
[    3.817618] pci 0000:03:00.0: supports D1 D2
[    3.817619] pci 0000:03:00.0: PME# supported from D1 D2 D3hot
[    3.817648] pci 0000:03:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8 GT/s x2 link at 0000:00:1c.4 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[    3.817707] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    3.817710] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    3.817712] pci 0000:00:1c.4:   bridge window [mem 0xe1200000-0xe12fffff]
[    3.817715] pci 0000:00:1c.4:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    3.819820] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
[    3.819820] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
[    3.819820] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
[    3.819820] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
[    3.819820] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
[    3.819820] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
[    3.819820] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
[    3.819820] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
[    3.820063] ACPI: EC: interrupt unblocked
[    3.820077] ACPI: EC: event unblocked
[    3.820089] ACPI: \_SB_.PCI0.LPCB.EC0_: GPE=0x6e, EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    3.820090] ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used to handle transactions and events
[    3.820169] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    3.820169] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    3.820169] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=none,locks=none
[    3.820169] pci 0000:00:02.0: vgaarb: no bridge control possible
[    3.820169] pci 0000:03:00.0: vgaarb: bridge control possible
[    3.820169] vgaarb: loaded
[    3.820169] SCSI subsystem initialized
[    3.820169] ACPI: bus type USB registered
[    3.820169] usbcore: registered new interface driver usbfs
[    3.820169] usbcore: registered new interface driver hub
[    3.820169] usbcore: registered new device driver usb
[    3.820169] pps_core: LinuxPPS API ver. 1 registered
[    3.820169] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.820169] PTP clock support registered
[    3.820169] EDAC MC: Ver: 3.0.0
[    3.820169] Registered efivars operations
[    3.855041] PCI: Using ACPI for IRQ routing
[    3.860504] PCI: pci_cache_line_size set to 64 bytes
[    3.860683] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
[    3.860684] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    3.860685] e820: reserve RAM buffer [mem 0x98215018-0x9bffffff]
[    3.860686] e820: reserve RAM buffer [mem 0xb70fb000-0xb7ffffff]
[    3.860686] e820: reserve RAM buffer [mem 0xb7f00000-0xb7ffffff]
[    3.860687] e820: reserve RAM buffer [mem 0x441800000-0x443ffffff]
[    3.862928] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    3.862931] hpet0: 8 comparators, 64-bit 24.000000 MHz counter
[    3.862931] clocksource: Switched to clocksource tsc-early
[    3.871665] VFS: Disk quotas dquot_6.6.0
[    3.871679] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.871701] *** VALIDATE hugetlbfs ***
[    3.871740] pnp: PnP ACPI init
[    3.871927] system 00:00: [mem 0xfd000000-0xfdabffff] has been reserved
[    3.871928] system 00:00: [mem 0xfdad0000-0xfdadffff] has been reserved
[    3.871929] system 00:00: [mem 0xfdb00000-0xfdffffff] has been reserved
[    3.871930] system 00:00: [mem 0xfe000000-0xfe01ffff] could not be reserved
[    3.871931] system 00:00: [mem 0xfe03d000-0xfe3fffff] has been reserved
[    3.871935] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.872212] system 00:01: [io  0x2000-0x20fe] has been reserved
[    3.872214] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.872353] system 00:02: [io  0x0680-0x069f] has been reserved
[    3.872354] system 00:02: [io  0xffff] has been reserved
[    3.872355] system 00:02: [io  0xffff] has been reserved
[    3.872356] system 00:02: [io  0xffff] has been reserved
[    3.872357] system 00:02: [io  0x1800-0x18fe] has been reserved
[    3.872358] system 00:02: [io  0x164e-0x164f] has been reserved
[    3.872360] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.872447] pnp 00:03: Plug and Play ACPI device, IDs PNP0b00 (active)
[    3.872480] system 00:04: [io  0x1854-0x1857] has been reserved
[    3.872482] system 00:04: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    3.872496] pnp 00:05: Plug and Play ACPI device, IDs HPQ8002 PNP0303 (active)
[    3.872513] pnp 00:06: Plug and Play ACPI device, IDs SYN3038 SYN0100 SYN0002 PNP0f13 (active)
[    3.872563] system 00:07: [io  0x0200-0x023f] has been reserved
[    3.872564] system 00:07: [mem 0xfedf0000-0xfedfffff] has been reserved
[    3.872566] system 00:07: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.873589] system 00:08: [mem 0xfe031000-0xfe031fff] has been reserved
[    3.873590] system 00:08: [mem 0xfe030008-0xfe030fff] has been reserved
[    3.873592] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.873981] system 00:09: [mem 0xfe030000-0xfe030007] has been reserved
[    3.873983] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.874216] system 00:0a: [mem 0xfed10000-0xfed17fff] has been reserved
[    3.874217] system 00:0a: [mem 0xfed18000-0xfed18fff] has been reserved
[    3.874218] system 00:0a: [mem 0xfed19000-0xfed19fff] has been reserved
[    3.874219] system 00:0a: [mem 0xf8000000-0xfbffffff] could not be reserved
[    3.874220] system 00:0a: [mem 0xfed20000-0xfed3ffff] has been reserved
[    3.874221] system 00:0a: [mem 0xfed90000-0xfed93fff] could not be reserved
[    3.874222] system 00:0a: [mem 0xfed45000-0xfed8ffff] has been reserved
[    3.874223] system 00:0a: [mem 0xff000000-0xffffffff] has been reserved
[    3.874224] system 00:0a: [mem 0xfee00000-0xfeefffff] has been reserved
[    3.874225] system 00:0a: [mem 0xbc800000-0xbc81ffff] has been reserved
[    3.874227] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
[    3.874456] pnp 00:0b: Plug and Play ACPI device, IDs IFX0102 PNP0c31 (active)
[    3.874504] pnp: PnP ACPI: found 12 devices
[    3.880104] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.880107] pci 0000:03:00.0: can't claim BAR 6 [mem 0xfffe0000-0xffffffff pref]: no compatible bridge window
[    3.880111] pci 0000:00:1c.0: bridge window [io  0x1000-0x0fff] to [bus 01] add_size 1000
[    3.880113] pci 0000:00:1c.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 01] add_size 200000 add_align 100000
[    3.880126] pci 0000:00:1c.0: BAR 15: assigned [mem 0xbc900000-0xbcafffff 64bit pref]
[    3.880127] pci 0000:00:1c.0: BAR 13: assigned [io  0x5000-0x5fff]
[    3.880129] pci 0000:00:1c.0: PCI bridge to [bus 01]
[    3.880131] pci 0000:00:1c.0:   bridge window [io  0x5000-0x5fff]
[    3.880134] pci 0000:00:1c.0:   bridge window [mem 0xe1000000-0xe10fffff]
[    3.880137] pci 0000:00:1c.0:   bridge window [mem 0xbc900000-0xbcafffff 64bit pref]
[    3.880140] pci 0000:00:1c.3: PCI bridge to [bus 02]
[    3.880142] pci 0000:00:1c.3:   bridge window [mem 0xe1100000-0xe11fffff]
[    3.880148] pci 0000:03:00.0: BAR 6: assigned [mem 0xe1240000-0xe125ffff pref]
[    3.880149] pci 0000:00:1c.4: PCI bridge to [bus 03]
[    3.880150] pci 0000:00:1c.4:   bridge window [io  0x3000-0x3fff]
[    3.880153] pci 0000:00:1c.4:   bridge window [mem 0xe1200000-0xe12fffff]
[    3.880155] pci 0000:00:1c.4:   bridge window [mem 0xc0000000-0xcfffffff 64bit pref]
[    3.880160] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    3.880160] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    3.880161] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    3.880162] pci_bus 0000:00: resource 7 [mem 0x000c0000-0x000c3fff window]
[    3.880163] pci_bus 0000:00: resource 8 [mem 0x000c4000-0x000c7fff window]
[    3.880163] pci_bus 0000:00: resource 9 [mem 0x000c8000-0x000cbfff window]
[    3.880164] pci_bus 0000:00: resource 10 [mem 0x000cc000-0x000cffff window]
[    3.880165] pci_bus 0000:00: resource 11 [mem 0x000d0000-0x000d3fff window]
[    3.880166] pci_bus 0000:00: resource 12 [mem 0x000d4000-0x000d7fff window]
[    3.880166] pci_bus 0000:00: resource 13 [mem 0x000d8000-0x000dbfff window]
[    3.880167] pci_bus 0000:00: resource 14 [mem 0x000dc000-0x000dffff window]
[    3.880168] pci_bus 0000:00: resource 15 [mem 0x000e0000-0x000e3fff window]
[    3.880169] pci_bus 0000:00: resource 16 [mem 0x000e4000-0x000e7fff window]
[    3.880169] pci_bus 0000:00: resource 17 [mem 0x000e8000-0x000ebfff window]
[    3.880170] pci_bus 0000:00: resource 18 [mem 0x000ec000-0x000effff window]
[    3.880171] pci_bus 0000:00: resource 19 [mem 0x000f0000-0x000fffff window]
[    3.880172] pci_bus 0000:00: resource 20 [mem 0xbc800000-0xf7ffffff window]
[    3.880172] pci_bus 0000:00: resource 21 [mem 0xfd000000-0xfe7fffff window]
[    3.880173] pci_bus 0000:01: resource 0 [io  0x5000-0x5fff]
[    3.880174] pci_bus 0000:01: resource 1 [mem 0xe1000000-0xe10fffff]
[    3.880175] pci_bus 0000:01: resource 2 [mem 0xbc900000-0xbcafffff 64bit pref]
[    3.880176] pci_bus 0000:02: resource 1 [mem 0xe1100000-0xe11fffff]
[    3.880177] pci_bus 0000:03: resource 0 [io  0x3000-0x3fff]
[    3.880177] pci_bus 0000:03: resource 1 [mem 0xe1200000-0xe12fffff]
[    3.880178] pci_bus 0000:03: resource 2 [mem 0xc0000000-0xcfffffff 64bit pref]
[    3.880316] NET: Registered protocol family 2
[    3.880425] tcp_listen_portaddr_hash hash table entries: 8192 (order: 5, 131072 bytes)
[    3.880464] TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
[    3.880603] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    3.880733] TCP: Hash tables configured (established 131072 bind 65536)
[    3.880760] UDP hash table entries: 8192 (order: 6, 262144 bytes)
[    3.880794] UDP-Lite hash table entries: 8192 (order: 6, 262144 bytes)
[    3.880855] NET: Registered protocol family 1
[    3.880865] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    3.881180] PCI: CLS 0 bytes, default 64
[    3.881210] Unpacking initramfs...
[    4.493469] Freeing initrd memory: 45880K
[    4.493559] DMAR: ACPI device "device:6f" under DMAR at fed91000 as 00:15.0
[    4.493581] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    4.493583] software IO TLB: mapped [mem 0xb26c3000-0xb66c3000] (64MB)
[    4.493609] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
[    4.493621] clocksource: Switched to clocksource tsc
[    4.494198] Initialise system trusted keyrings
[    4.494242] workingset: timestamp_bits=40 max_order=22 bucket_order=0
[    4.494267] zbud: loaded
[    4.736854] alg: No test for lzo-rle (lzo-rle-generic)
[    4.737341] alg: No test for lzo-rle (lzo-rle-scomp)
[    4.737805] Key type asymmetric registered
[    4.737806] Asymmetric key parser 'x509' registered
[    4.737819] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
[    4.737846] io scheduler mq-deadline registered
[    4.738168] pcieport 0000:00:1c.0: Signaling PME with IRQ 122
[    4.738218] aer 0000:00:1c.0:pcie002: AER enabled with IRQ 122
[    4.738234] pciehp 0000:00:1c.0:pcie004: Slot #1 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ LLActRep+
[    4.738515] pcieport 0000:00:1c.3: Signaling PME with IRQ 123
[    4.738554] aer 0000:00:1c.3:pcie002: AER enabled with IRQ 123
[    4.738819] pcieport 0000:00:1c.4: Signaling PME with IRQ 124
[    4.738858] aer 0000:00:1c.4:pcie002: AER enabled with IRQ 124
[    4.738913] pci 0000:03:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8 GT/s x2 link at 0000:00:1c.4 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[    4.738963] efifb: probing for efifb
[    4.738978] efifb: framebuffer at 0xd0000000, using 8100k, total 8100k
[    4.738978] efifb: mode is 1920x1080x32, linelength=7680, pages=1
[    4.738979] efifb: scrolling: redraw
[    4.738980] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
[    4.739067] Console: switching to colour frame buffer device 240x67
[    4.742252] fb0: EFI VGA frame buffer device
[    4.742258] intel_idle: MWAIT substates: 0x11142120
[    4.742259] intel_idle: v0.4.1 model 0x4E
[    4.742449] intel_idle: lapic_timer_reliable_states 0xffffffff
[    4.743307] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.743529] serial 0000:00:16.3: enabling device (0000 -> 0003)
[    4.764042] 0000:00:16.3: ttyS0 at I/O 0x4080 (irq = 19, base_baud = 115200) is a 16550A
[    4.764214] Linux agpgart interface v0.103
[    4.766372] tpm_tis 00:0b: 1.2 TPM (device-id 0x1B, rev-id 16)
[    4.779351] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    4.779352] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[    4.779979] i8042: PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
[    4.781468] i8042: Detected active multiplexing controller, rev 1.1
[    4.781763] serio: i8042 KBD port at 0x60,0x64 irq 1
[    4.781766] serio: i8042 AUX0 port at 0x60,0x64 irq 12
[    4.781784] serio: i8042 AUX1 port at 0x60,0x64 irq 12
[    4.781797] serio: i8042 AUX2 port at 0x60,0x64 irq 12
[    4.781809] serio: i8042 AUX3 port at 0x60,0x64 irq 12
[    4.781999] mousedev: PS/2 mouse device common for all mice
[    4.782061] rtc_cmos 00:03: RTC can wake from S4
[    4.782580] rtc_cmos 00:03: registered as rtc0
[    4.782593] rtc_cmos 00:03: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
[    4.782600] intel_pstate: Intel P-state driver initializing
[    4.782827] intel_pstate: HWP enabled
[    4.782845] ledtrig-cpu: registered to indicate activity on CPUs
[    4.783085] NET: Registered protocol family 10
[    4.783254] Segment Routing with IPv6
[    4.783267] mip6: Mobile IPv6
[    4.783268] NET: Registered protocol family 17
[    4.783270] mpls_gso: MPLS GSO support
[    4.783496] microcode: sig=0x406e3, pf=0x80, revision=0xc2
[    4.783573] microcode: Microcode Update Driver: v2.2.
[    4.783582] sched_clock: Marking stable (4787057707, -3487003)->(4797404402, -13833698)
[    4.783974] registered taskstats version 1
[    4.783975] Loading compiled-in X.509 certificates
[    4.783988] zswap: loaded using pool lzo/zbud
[    4.784115] ima: Allocated hash algorithm: sha256
[    4.810633] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    4.813241] No architecture policies found
[    4.814509] rtc_cmos 00:03: setting system clock to 2019-03-27T09:00:18 UTC (1553677218)
[    4.815349] Freeing unused kernel image memory: 1592K
[    4.835309] Write protecting the kernel read-only data: 16384k
[    4.836090] Freeing unused kernel image memory: 2016K
[    4.836463] Freeing unused kernel image memory: 876K
[    4.859328] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.859331] x86/mm: Checking user space page tables
[    4.876102] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    4.876105] Run /init as init process
[    4.933879] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    4.933948] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    4.933956] random: systemd-udevd: uninitialized urandom read (16 bytes read)
[    4.978955] thermal LNXTHERM:00: registered as thermal_zone0
[    4.978957] ACPI: Thermal Zone [CPUZ] (33 C)
[    4.979088] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    4.980069] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.980189] libata version 3.00 loaded.
[    4.980210] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    4.980217] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
[    4.981327] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000081109810
[    4.981334] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
[    4.981610] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.01
[    4.981611] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.981613] usb usb1: Product: xHCI Host Controller
[    4.981615] usb usb1: Manufacturer: Linux 5.1.0-rc2 xhci-hcd
[    4.981616] usb usb1: SerialNumber: 0000:00:14.0
[    4.981882] ahci 0000:00:17.0: version 3.0
[    4.981931] hub 1-0:1.0: USB hub found
[    4.981956] hub 1-0:1.0: 12 ports detected
[    4.982836] ahci 0000:00:17.0: SSS flag set, parallel bus scan disabled
[    4.984582] thermal LNXTHERM:01: registered as thermal_zone1
[    4.984583] ACPI: Thermal Zone [GFXZ] (0 C)
[    4.989305] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    4.989306] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    4.989459] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    4.989463] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
[    4.989467] xhci_hcd 0000:00:14.0: Host supports USB 3.0  SuperSpeed
[    4.989538] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.01
[    4.989540] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.989541] usb usb2: Product: xHCI Host Controller
[    4.989543] usb usb2: Manufacturer: Linux 5.1.0-rc2 xhci-hcd
[    4.989544] usb usb2: SerialNumber: 0000:00:14.0
[    4.990108] rtsx_pci 0000:01:00.0: enabling device (0000 -> 0002)
[    4.990242] hub 2-0:1.0: USB hub found
[    4.990255] hub 2-0:1.0: 6 ports detected
[    4.990347] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    4.992953] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 2 ports 6 Gbps 0x5 impl SATA mode
[    4.992957] ahci 0000:00:17.0: flags: 64bit ncq stag pm led clo only pio slum part deso sadm sds apst 
[    4.995494] cryptd: max_cpu_qlen set to 1000
[    5.002205] thermal LNXTHERM:02: registered as thermal_zone2
[    5.002206] ACPI: Thermal Zone [EXTZ] (22 C)
[    5.002933] AVX2 version of gcm_enc/dec engaged.
[    5.002935] AES CTR mode by8 optimization enabled
[    5.003332] usb: port power management may be unreliable
[    5.004507] scsi host0: ahci
[    5.004648] scsi host1: ahci
[    5.004750] scsi host2: ahci
[    5.004804] ata1: SATA max UDMA/133 abar m2048@0xe134e000 port 0xe134e100 irq 126
[    5.004805] ata2: DUMMY
[    5.004806] ata3: SATA max UDMA/133 abar m2048@0xe134e000 port 0xe134e200 irq 126
[    5.022144] thermal LNXTHERM:03: registered as thermal_zone3
[    5.022146] ACPI: Thermal Zone [LOCZ] (22 C)
[    5.024667] thermal LNXTHERM:04: registered as thermal_zone4
[    5.024669] ACPI: Thermal Zone [BATZ] (21 C)
[    5.025073] thermal LNXTHERM:05: registered as thermal_zone5
[    5.025074] ACPI: Thermal Zone [PCHZ] (0 C)
[    5.126380] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
[    5.210202] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) b4:b6:86:25:0f:8a
[    5.210207] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
[    5.210305] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
[    5.212403] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
[    5.315168] ata1: SATA link down (SStatus 4 SControl 300)
[    5.323072] usb 1-7: new full-speed USB device number 2 using xhci_hcd
[    5.473097] usb 1-7: New USB device found, idVendor=8087, idProduct=0a2b, bcdDevice= 0.01
[    5.473105] usb 1-7: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.599415] usb 2-2: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    5.628148] ata3: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    5.628894] usb 2-2: New USB device found, idVendor=04e8, idProduct=61f5, bcdDevice= 1.00
[    5.628904] usb 2-2: New USB device strings: Mfr=2, Product=3, SerialNumber=1
[    5.628911] usb 2-2: Product: Portable SSD T5
[    5.628918] usb 2-2: Manufacturer: Samsung
[    5.628924] usb 2-2: SerialNumber: 1234567BBC71
[    5.629217] ata3.00: ACPI cmd f5/00:00:00:00:00:e0 (SECURITY FREEZE LOCK) filtered out
[    5.629275] ata3.00: ATA-10: INTEL SSDSCKKF256G8H,  LHFH03N, max UDMA/100
[    5.629283] ata3.00: 500118192 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    5.629962] ata3.00: ACPI cmd f5/00:00:00:00:00:e0 (SECURITY FREEZE LOCK) filtered out
[    5.630254] ata3.00: configured for UDMA/100
[    5.630751] scsi 2:0:0:0: Direct-Access     ATA      INTEL SSDSCKKF25 H03N PQ: 0 ANSI: 5
[    5.636445] ata3.00: Enabling discard_zeroes_data
[    5.636491] sd 2:0:0:0: [sda] 500118192 512-byte logical blocks: (256 GB/238 GiB)
[    5.636500] sd 2:0:0:0: [sda] Write Protect is off
[    5.636502] sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.636514] sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.636532] sd 2:0:0:0: [sda] Optimal transfer size 0 bytes < PAGE_SIZE (4096 bytes)
[    5.636620] ata3.00: Enabling discard_zeroes_data
[    5.636938] usbcore: registered new interface driver usb-storage
[    5.638006] random: fast init done
[    5.638236]  sda: sda1 sda2 sda3 sda4 sda5
[    5.638553] ata3.00: Enabling discard_zeroes_data
[    5.638664] sd 2:0:0:0: [sda] Attached SCSI disk
[    5.639927] scsi host3: uas
[    5.640052] usbcore: registered new interface driver uas
[    5.640378] scsi 3:0:0:0: Direct-Access     Samsung  Portable SSD T5  0    PQ: 0 ANSI: 6
[    5.641341] sd 3:0:0:0: [sdb] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    5.641418] sd 3:0:0:0: [sdb] Write Protect is off
[    5.641420] sd 3:0:0:0: [sdb] Mode Sense: 43 00 00 00
[    5.641578] sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.641778] sd 3:0:0:0: [sdb] Optimal transfer size 33553920 bytes
[    5.644420]  sdb: sdb1 sdb2 sdb3 sdb4
[    5.645468] sd 3:0:0:0: [sdb] Attached SCSI disk
[    5.754880] usb 1-9: new high-speed USB device number 3 using xhci_hcd
[    5.758867] raid6: avx2x4   gen() 24131 MB/s
[    5.826870] raid6: avx2x4   xor() 18157 MB/s
[    5.894868] raid6: avx2x2   gen() 22550 MB/s
[    5.939781] usb 1-9: New USB device found, idVendor=05c8, idProduct=0383, bcdDevice= 1.06
[    5.939782] usb 1-9: New USB device strings: Mfr=2, Product=1, SerialNumber=0
[    5.939783] usb 1-9: Product: HP HD Camera
[    5.939784] usb 1-9: Manufacturer: Sonix Technology Co., Ltd.
[    5.941248] input: PS/2 Generic Mouse as /devices/platform/i8042/serio2/input/input6
[    5.962868] raid6: avx2x2   xor() 15303 MB/s
[    6.030871] raid6: avx2x1   gen() 20030 MB/s
[    6.098869] raid6: avx2x1   xor() 14700 MB/s
[    6.166866] raid6: sse2x4   gen() 14599 MB/s
[    6.234871] raid6: sse2x4   xor() 10077 MB/s
[    6.302867] raid6: sse2x2   gen() 12834 MB/s
[    6.370871] raid6: sse2x2   xor()  8955 MB/s
[    6.438874] raid6: sse2x1   gen() 10333 MB/s
[    6.506869] raid6: sse2x1   xor()  7776 MB/s
[    6.506870] raid6: using algorithm avx2x4 gen() 24131 MB/s
[    6.506870] raid6: .... xor() 18157 MB/s, rmw enabled
[    6.506871] raid6: using avx2x2 recovery algorithm
[    6.507317] xor: automatically using best checksumming function   avx       
[    6.509428] async_tx: api initialized (async)
[    6.584751] device-mapper: ioctl: 4.40.0-ioctl (2019-01-18) initialised: dm-devel@redhat.com
[    6.666122] psmouse serio3: synaptics: queried max coordinates: x [..5662], y [..4710]
[    6.702370] psmouse serio3: synaptics: queried min coordinates: x [1278..], y [1144..]
[    6.702383] psmouse serio3: synaptics: The touchpad can support a better bus than the too old PS/2 protocol. Make sure MOUSE_PS2_SYNAPTICS_SMBUS and RMI4_SMB are enabled to get a better touchpad experience.
[    6.768599] psmouse serio3: synaptics: Touchpad model: 1, fw: 8.2, id: 0x1e2b1, caps: 0xf00123/0x840300/0x2e800/0x0, board id: 3140, fw id: 1994908
[    6.810516] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042/serio3/input/input7
[   10.572409] random: crng init done
[   10.572414] random: 7 urandom warning(s) missed due to ratelimiting
[   12.165308] device-mapper: crypt: xts(aes) using implementation "xts-aes-aesni"
[   12.306927] device-mapper: crypt: xts(aes) using implementation "xts-aes-aesni"
[   12.459186] Btrfs loaded, crc32c=crc32c-intel
[   12.538339] PM: Image not found (code -22)
[   12.541072] PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
[   12.541074] PM: Marking nosave pages: [mem 0x00058000-0x00058fff]
[   12.541075] PM: Marking nosave pages: [mem 0x0009e000-0x000fffff]
[   12.541077] PM: Marking nosave pages: [mem 0x98215000-0x98215fff]
[   12.541078] PM: Marking nosave pages: [mem 0x98223000-0x98223fff]
[   12.541078] PM: Marking nosave pages: [mem 0xb70fb000-0xb7efefff]
[   12.541149] PM: Marking nosave pages: [mem 0xb7f00000-0xffffffff]
[   12.541834] PM: Basic memory bitmaps created
[   12.542370] PM: Basic memory bitmaps freed
[   12.622706] EXT4-fs (dm-1): mounted filesystem with ordered data mode. Opts: (null)
[   12.673307] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[   12.756917] systemd[1]: RTC configured in localtime, applying delta of 60 minutes to system time.
[   12.884385] systemd[1]: systemd 232 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN)
[   12.903375] systemd[1]: Detected architecture x86-64.
[   12.903765] systemd[1]: Set hostname to <dumbo>.
[   12.916386] systemd-fstab-generator[405]: Checking was requested for "/srv/chroot.img", but it is not a device.
[   12.971965] systemd[1]: Listening on udev Kernel Socket.
[   12.972213] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[   12.972250] systemd[1]: Listening on LVM2 metadata daemon socket.
[   12.972290] systemd[1]: Listening on Journal Socket.
[   12.972334] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   12.972343] systemd[1]: Reached target Remote File Systems.
[   12.972374] systemd[1]: Listening on udev Control Socket.
[   13.001378] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro
[   13.097316] systemd-journald[422]: Received request to flush runtime journal from PID 1
[   13.104618] loop: module loaded
[   13.129679] BTRFS: device fsid bac089bb-629c-42d5-9649-0931ec86e607 devid 1 transid 10423 /dev/loop0
[   13.130025] BTRFS info (device loop0): disk space caching is enabled
[   13.130027] BTRFS info (device loop0): has skinny extents
[   13.142254] ACPI: AC Adapter [AC] (off-line)
[   13.143708] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input9
[   13.143728] ACPI: Sleep Button [SLPB]
[   13.143808] input: Lid Switch as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0D:00/input/input10
[   13.143816] ACPI: Lid Switch [LID]
[   13.143887] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input11
[   13.143900] ACPI: Power Button [PWRF]
[   13.195707] acpi PNP0C14:01: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:00)
[   13.206038] battery: ACPI: Battery Slot [BAT0] (battery present)
[   13.221073] sd 2:0:0:0: Attached scsi generic sg0 type 0
[   13.221121] sd 3:0:0:0: Attached scsi generic sg1 type 0
[   13.223652] iTCO_vendor_support: vendor-support=0
[   13.227245] EFI Variables Facility v0.08 2004-May-17
[   13.230840] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   13.231165] iTCO_wdt: Found a Intel PCH TCO device (Version=4, TCOBASE=0x0400)
[   13.232575] iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
[   13.277364] RAPL PMU: API unit is 2^-32 Joules, 5 fixed counters, 655360 ms ovfl timer
[   13.277366] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[   13.277367] RAPL PMU: hw unit of domain package 2^-14 Joules
[   13.277368] RAPL PMU: hw unit of domain dram 2^-14 Joules
[   13.277368] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[   13.277369] RAPL PMU: hw unit of domain psys 2^-14 Joules
[   13.304148] pstore: Using crash dump compression: deflate
[   13.304197] pstore: Registered efi as persistent store backend
[   13.314567] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[   13.372819] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[   13.421837] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[   13.432231] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[   13.433338] platform regulatory.0: Direct firmware load for regulatory.db failed with error -2
[   13.433340] cfg80211: failed to load regulatory.db
[   13.535674] intel_rapl: Found RAPL domain package
[   13.535676] intel_rapl: Found RAPL domain core
[   13.535677] intel_rapl: Found RAPL domain uncore
[   13.536124] Intel(R) Wireless WiFi driver for Linux
[   13.536125] Copyright(c) 2003- 2015 Intel Corporation
[   13.536248] iwlwifi 0000:02:00.0: enabling device (0000 -> 0002)
[   13.560046] iwlwifi 0000:02:00.0: loaded firmware version 36.9f0a2d68.0 op_mode iwlmvm
[   13.587422] Adding 8740860k swap on /dev/mapper/vg_enc-swap.  Priority:-2 extents:1 across:8740860k SSFS
[   13.811280] iwlwifi 0000:02:00.0: Detected Intel(R) Dual Band Wireless AC 8260, REV=0x208
[   13.830942] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro,stripe=8191,commit=600
[   13.842691] checking generic (d0000000 7e9000) vs hw (d0000000 10000000)
[   13.842692] fb0: switching to inteldrmfb from EFI VGA
[   13.842719] Console: switching to colour dummy device 80x25
[   13.843451] i915 0000:00:02.0: vgaarb: deactivate vga console
[   13.844524] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   13.844525] [drm] Driver supports precise vblank timestamp query.
[   13.844970] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=none:owns=io+mem
[   13.845018] i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin failed with error -2
[   13.845020] i915 0000:00:02.0: Failed to load DMC firmware i915/skl_dmc_ver1_27.bin. Disabling runtime power management.
[   13.845021] i915 0000:00:02.0: DMC firmware homepage: https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
[   13.860844] [drm] Initialized i915 1.6.0 20190207 for 0000:00:02.0 on minor 0
[   13.863782] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[   13.864226] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input12
[   13.864407] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[   13.872260] fbcon: inteldrmfb (fb0) is primary device
[   13.875039] Console: switching to colour frame buffer device 240x67
[   13.887190] iwlwifi 0000:02:00.0: base HW address: f8:63:3f:cb:fc:19
[   13.896041] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[   13.949241] snd_hda_codec_conexant hdaudioC0D0: CX20724: BIOS auto-probing.
[   13.949680] snd_hda_codec_conexant hdaudioC0D0: action: 0 gpio_led: 0
[   13.949822] snd_hda_codec_conexant hdaudioC0D0: autoconfig for CX20724: line_outs=1 (0x16/0x0/0x0/0x0/0x0) type:line
[   13.949824] snd_hda_codec_conexant hdaudioC0D0:    speaker_outs=1 (0x17/0x0/0x0/0x0/0x0)
[   13.949825] snd_hda_codec_conexant hdaudioC0D0:    hp_outs=1 (0x1d/0x0/0x0/0x0/0x0)
[   13.949826] snd_hda_codec_conexant hdaudioC0D0:    mono: mono_out=0x0
[   13.949827] snd_hda_codec_conexant hdaudioC0D0:    inputs:
[   13.949829] snd_hda_codec_conexant hdaudioC0D0:      Mic=0x19
[   13.949830] snd_hda_codec_conexant hdaudioC0D0:      Internal Mic=0x1a
[   13.949831] snd_hda_codec_conexant hdaudioC0D0:      Line=0x18
[   13.950909] snd_hda_codec_conexant hdaudioC0D0: Enable sync_write for stable communication
[   13.950910] snd_hda_codec_conexant hdaudioC0D0: action: 1 gpio_led: 0
[   13.954388] snd_hda_codec_conexant hdaudioC0D0: action: 2 gpio_led: 0
[   13.967156] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[   13.967243] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[   13.967307] input: HDA Intel PCH Dock Line Out as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[   13.967364] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[   13.967421] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input17
[   13.967478] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input18
[   13.967535] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input19
[   13.967593] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input20
[   13.977451] ieee80211 phy0: Selected rate control algorithm 'iwl-mvm-rs'
[   13.977746] thermal thermal_zone7: failed to read out thermal zone (-61)
[   13.980304] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[   15.426845] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro,stripe=8191,commit=600
[   15.449975] EXT4-fs (sdb2): mounted filesystem with ordered data mode. Opts: (null)
[   16.412104] pci 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x2 link at 0000:00:1c.4 (capable of 992.439 Gb/s with 16 GT/s x63 link)
[   17.229364] Bluetooth: Core ver 2.22
[   17.229385] NET: Registered protocol family 31
[   17.229386] Bluetooth: HCI device and connection manager initialized
[   17.229509] Bluetooth: HCI socket layer initialized
[   17.229512] Bluetooth: L2CAP socket layer initialized
[   17.229516] Bluetooth: SCO socket layer initialized
[   17.294574] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro,stripe=8191,commit=600
[   17.325635] EXT4-fs (sdb2): re-mounted. Opts: stripe=8191,commit=600
[   17.359459] usbcore: registered new interface driver btusb
[   17.360103] Bluetooth: hci0: Bootloader revision 0.0 build 2 week 52 2014
[   17.367144] Bluetooth: hci0: Device revision is 5
[   17.367146] Bluetooth: hci0: Secure boot is enabled
[   17.367146] Bluetooth: hci0: OTP lock is enabled
[   17.367147] Bluetooth: hci0: API lock is enabled
[   17.367148] Bluetooth: hci0: Debug lock is disabled
[   17.367151] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   17.369836] Bluetooth: hci0: Found device firmware: intel/ibt-11-5.sfi
[   17.425298] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   17.425300] Bluetooth: BNEP filters: protocol multicast
[   17.425304] Bluetooth: BNEP socket layer initialized
[   17.883985] pci 0000:03:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s x2 link at 0000:00:1c.4 (capable of 992.439 Gb/s with 16 GT/s x63 link)
[   18.768361] Bluetooth: hci0: Waiting for firmware download to complete
[   18.769075] Bluetooth: hci0: Firmware loaded in 1376622 usecs
[   18.769104] Bluetooth: hci0: Waiting for device to boot
[   18.774103] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro,stripe=8191,commit=600
[   18.780097] Bluetooth: hci0: Device booted in 10746 usecs
[   18.780412] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-11-5.ddc
[   18.784097] Bluetooth: hci0: Applying Intel DDC parameters completed
[   18.801519] EXT4-fs (sdb2): re-mounted. Opts: stripe=8191,commit=600
[   20.235004] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro,stripe=8191,commit=600
[   20.257060] EXT4-fs (sdb2): re-mounted. Opts: stripe=8191,commit=600
[   20.471435] wlp2s0: authenticate with a8:b8:6e:4b:d1:16
[   20.481081] wlp2s0: send auth to a8:b8:6e:4b:d1:16 (try 1/3)
[   20.586886] wlp2s0: send auth to a8:b8:6e:4b:d1:16 (try 2/3)
[   20.623766] wlp2s0: authenticated
[   20.626889] wlp2s0: associate with a8:b8:6e:4b:d1:16 (try 1/3)
[   20.667228] wlp2s0: RX AssocResp from a8:b8:6e:4b:d1:16 (capab=0x131 status=0 aid=1)
[   20.669804] wlp2s0: associated
[   20.797147] IPv6: ADDRCONF(NETDEV_CHANGE): wlp2s0: link becomes ready
[   21.709387] EXT4-fs (dm-1): re-mounted. Opts: errors=remount-ro,stripe=8191,commit=600
[   21.734497] EXT4-fs (sdb2): re-mounted. Opts: stripe=8191,commit=600
[   23.135940] Bluetooth: RFCOMM TTY layer initialized
[   23.135946] Bluetooth: RFCOMM socket layer initialized
[   23.135950] Bluetooth: RFCOMM ver 1.11
[   28.775667] tun: Universal TUN/TAP device driver, 1.6
[   41.982966] Syncing filesystems ... 
[   41.984681] done.
[   41.984682] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   41.986126] OOM killer disabled.
[   41.986267] PM: Marking nosave pages: [mem 0x00000000-0x00000fff]
[   41.986269] PM: Marking nosave pages: [mem 0x00058000-0x00058fff]
[   41.986270] PM: Marking nosave pages: [mem 0x0009e000-0x000fffff]
[   41.986273] PM: Marking nosave pages: [mem 0x98215000-0x98215fff]
[   41.986274] PM: Marking nosave pages: [mem 0x98223000-0x98223fff]
[   41.986274] PM: Marking nosave pages: [mem 0xb70fb000-0xb7efefff]
[   41.986348] PM: Marking nosave pages: [mem 0xb7f00000-0xffffffff]
[   41.987154] PM: Basic memory bitmaps created
[   41.987346] PM: Preallocating image memory... done (allocated 311262 pages)
[   42.227830] PM: Allocated 1245048 kbytes in 0.24 seconds (5187.70 MB/s)
[   42.227831] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   42.330589] printk: Suspending console(s) (use no_console_suspend to debug)
[   42.330691] wlp2s0: deauthenticating from a8:b8:6e:4b:d1:16 by local choice (Reason: 3=DEAUTH_LEAVING)
[   42.331492] tpm tpm0: tpm_try_transmit: send(): error -5
[   42.331493] tpm tpm0: Error (-5) sending savestate before suspend
[   42.331497] PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x80 returns -5
[   42.331499] PM: dpm_run_callback(): pnp_bus_freeze+0x0/0x20 returns -5
[   42.331500] PM: Device 00:0b failed to freeze: error -5
[   42.420632] sd 2:0:0:0: [sda] Starting disk
[   42.438254] snd_hda_codec_conexant hdaudioC0D0: action: 2 gpio_led: 1
[   42.734726] ata1: SATA link down (SStatus 4 SControl 300)
[   42.856986] acpi LNXPOWER:18: Turning OFF
[   42.857158] acpi LNXPOWER:17: Turning OFF
[   42.857319] acpi LNXPOWER:16: Turning OFF
[   42.857479] acpi LNXPOWER:15: Turning OFF
[   42.857778] acpi LNXPOWER:14: Turning OFF
[   42.857939] acpi LNXPOWER:13: Turning OFF
[   42.858099] acpi LNXPOWER:12: Turning OFF
[   42.858256] acpi LNXPOWER:11: Turning OFF
[   42.858413] acpi LNXPOWER:10: Turning OFF
[   42.858571] acpi LNXPOWER:0f: Turning OFF
[   42.858730] acpi LNXPOWER:0e: Turning OFF
[   42.858888] acpi LNXPOWER:0d: Turning OFF
[   42.859045] acpi LNXPOWER:0c: Turning OFF
[   42.859201] acpi LNXPOWER:0b: Turning OFF
[   42.859358] acpi LNXPOWER:0a: Turning OFF
[   42.859516] acpi LNXPOWER:09: Turning OFF
[   42.859686] acpi LNXPOWER:07: Turning OFF
[   42.859843] acpi LNXPOWER:06: Turning OFF
[   42.860106] acpi LNXPOWER:05: Turning OFF
[   42.861139] acpi LNXPOWER:03: Turning OFF
[   42.861384] PM: Basic memory bitmaps freed
[   42.861385] OOM killer enabled.
[   42.861385] Restarting tasks ... done.
[   44.430141] psmouse serio3: synaptics: queried max coordinates: x [..5662], y [..4710]
[   44.464498] psmouse serio3: synaptics: queried min coordinates: x [1278..], y [1144..]
[   46.236956] wlp2s0: authenticate with a8:b8:6e:4b:d1:16
[   46.244869] wlp2s0: send auth to a8:b8:6e:4b:d1:16 (try 1/3)
[   46.352148] wlp2s0: send auth to a8:b8:6e:4b:d1:16 (try 2/3)
[   46.363196] wlp2s0: authenticated
[   46.367962] wlp2s0: associate with a8:b8:6e:4b:d1:16 (try 1/3)
[   46.407495] wlp2s0: RX AssocResp from a8:b8:6e:4b:d1:16 (capab=0x531 status=0 aid=2)
[   46.411245] wlp2s0: associated

-- 
3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
