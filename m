Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D34C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B441206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 22:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392300AbfHBWE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 18:04:27 -0400
Received: from savella.carfax.org.uk ([85.119.84.138]:43758 "EHLO
        savella.carfax.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbfHBWE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 18:04:26 -0400
X-Greylist: delayed 2044 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Aug 2019 18:04:24 EDT
Received: from hrm by savella.carfax.org.uk with local (Exim 4.92)
        (envelope-from <hrm@savella.carfax.org.uk>)
        id 1htf80-0001E4-0w; Fri, 02 Aug 2019 22:30:20 +0100
Date:   Fri, 2 Aug 2019 22:30:19 +0100
From:   Hugo Mills <hugo@carfax.org.uk>
To:     linux@highpoint-tech.com, linux-kernel@vger.kernel.org
Subject: Highpoint RocketRAID 3720A not detected (4.19.63)
Message-ID: <20190802213019.GA24125@savella.carfax.org.uk>
Mail-Followup-To: Hugo Mills <hugo@carfax.org.uk>, linux@highpoint-tech.com,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: DD84 D558 9D81 DDEE 930D  2054 585E 1475 E2AB 1DE4
X-GPG-Key: E2AB1DE4
X-Parrot: It is no more. It has joined the choir invisible.
X-IRC-Nicks: darksatanic darkersatanic darkling darkthing
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

   I've just bought a Highpoint RocketRAID 3720A, and I can't seem to
persuade it to show me any disks. I've built a vanilla 4.19.63 kernel
for this, and I'm not seeing any of the six (SATA) disks I've attached
to it.

   I've tried modprobing the hptiop module manually, and still
nothing. I've even, in desperation, tried installing Highpoint's own
driver, but that's also not having any effect.

   I've probably missed something really obvious, but this is my first
time with both SAS and this hardware. However, I note that the PCI ID
(1103:3720) doesn't appear to be in include/linux/pci_ids.h, at which
point I've more or less exhausted my knowledge of kernel internals...

   What do I need to do to get this thing to work? I'm only after JBOD
-- I don't actually need the hardware RAID capabilities.

   Thanks,
   Hugo.

hrm@amelia:~ $ sudo lspci
00:00.0 Host bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD9x0/RX980 Host Bridge (rev 02)
00:02.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GFX port 0)
00:04.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GPP Port 0)
00:06.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GPP Port 2)
00:09.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] RD890/RD9x0/RX980 PCI to PCI bridge (PCI Express GPP Port 4)
00:11.0 SATA controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 SATA Controller [AHCI mode] (rev 40)
00:12.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:12.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:13.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:13.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:14.0 SMBus: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 SMBus Controller (rev 42)
00:14.2 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 Azalia (Intel HDA) (rev 40)
00:14.3 ISA bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 LPC host controller (rev 40)
00:14.4 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SBx00 PCI to PCI Bridge (rev 40)
00:14.5 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI2 Controller
00:15.0 PCI bridge: Advanced Micro Devices, Inc. [AMD/ATI] SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0)
00:16.0 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB OHCI0 Controller
00:16.2 USB controller: Advanced Micro Devices, Inc. [AMD/ATI] SB7x0/SB8x0/SB9x0 USB EHCI Controller
00:18.0 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 0
00:18.1 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 1
00:18.2 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 2
00:18.3 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 3
00:18.4 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 4
00:18.5 Host bridge: Advanced Micro Devices, Inc. [AMD] Family 15h Processor Function 5
01:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI] Cedar [Radeon HD 5000/6000/7350/8350 Series]
01:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Cedar HDMI Audio [Radeon HD 5400/6300/7300 Series]
02:00.0 USB controller: VIA Technologies, Inc. VL805 USB 3.0 Host Controller (rev 01)
03:00.0 SATA controller: Silicon Image, Inc. SiI 3132 Serial ATA Raid II Controller (rev 01)
04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
06:00.0 RAID bus controller: HighPoint Technologies, Inc. Device 3720 (rev a1)

hrm@amelia:~ $ sudo lspci -n
00:00.0 0600: 1002:5a14 (rev 02)
00:02.0 0604: 1002:5a16
00:04.0 0604: 1002:5a18
00:06.0 0604: 1002:5a1a
00:09.0 0604: 1002:5a1c
00:11.0 0106: 1002:4391 (rev 40)
00:12.0 0c03: 1002:4397
00:12.2 0c03: 1002:4396
00:13.0 0c03: 1002:4397
00:13.2 0c03: 1002:4396
00:14.0 0c05: 1002:4385 (rev 42)
00:14.2 0403: 1002:4383 (rev 40)
00:14.3 0601: 1002:439d (rev 40)
00:14.4 0604: 1002:4384 (rev 40)
00:14.5 0c03: 1002:4399
00:15.0 0604: 1002:43a0
00:16.0 0c03: 1002:4397
00:16.2 0c03: 1002:4396
00:18.0 0600: 1022:1600
00:18.1 0600: 1022:1601
00:18.2 0600: 1022:1602
00:18.3 0600: 1022:1603
00:18.4 0600: 1022:1604
00:18.5 0600: 1022:1605
01:00.0 0300: 1002:68f9
01:00.1 0403: 1002:aa68
02:00.0 0c03: 1106:3483 (rev 01)
03:00.0 0106: 1095:3132 (rev 01)
04:00.0 0200: 10ec:8168 (rev 0c)
06:00.0 0104: 1103:3720 (rev a1)

hrm@amelia:~ $ lsmod
Module                  Size  Used by
hptiop                 20480  0
rr3740a               573440  0
tun                    40960  0
nfsd                  290816  13
auth_rpcgss            57344  2 nfsd
oid_registry           16384  1 auth_rpcgss
nfs_acl                16384  1 nfsd
nfs                   233472  0
lockd                  77824  2 nfsd,nfs
grace                  16384  2 nfsd,lockd
sunrpc                311296  21 nfsd,auth_rpcgss,lockd,nfs_acl,nfs
nfnetlink              16384  0
bridge                143360  0
stp                    16384  1 bridge
llc                    16384  2 bridge,stp
it87                   57344  0
hwmon_vid              16384  1 it87
dm_crypt               36864  0
dm_mod                118784  1 dm_crypt
dax                    20480  1 dm_mod
amd64_edac_mod         28672  0
edac_mce_amd           28672  1 amd64_edac_mod
kvm_amd                73728  0
kvm                   593920  1 kvm_amd
irqbypass              16384  1 kvm
k10temp                16384  0
sr_mod                 20480  0
cdrom                  36864  1 sr_mod
sg                     32768  0
rtc_cmos               20480  1
r8169                  69632  0
realtek                20480  0
acpi_cpufreq           16384  0
button                 16384  0
raid1                  36864  0
md_mod                126976  1 raid1
crc32c_intel           24576  0
sata_sil24             20480  0

hrm@amelia:~ $ sudo lshw
[...]
        *-pci:5
             description: PCI bridge
             product: SB700/SB800/SB900 PCI to PCI bridge (PCIE port 0)
             vendor: Advanced Micro Devices, Inc. [AMD/ATI]
             physical id: 15
             bus info: pci@0000:00:15.0
             version: 00
             width: 32 bits
             clock: 33MHz
             capabilities: pci pm pciexpress msi ht normal_decode bus_master cap_list
             configuration: driver=pcieport
             resources: irq:16 memory:fe600000-fe6fffff ioport:d0000000(size=2097152)
           *-raid UNCLAIMED
                description: RAID bus controller
                product: HighPoint Technologies, Inc.
                vendor: HighPoint Technologies, Inc.
                physical id: 0
                bus info: pci@0000:06:00.0
                version: a1
                width: 64 bits
                clock: 33MHz
                capabilities: raid pm msi msix pciexpress bus_master cap_list
                configuration: latency=0
                resources: memory:d0000000-d00fffff memory:d0100000-d013ffff memory:fe600000-fe61ffff
[...]

-- 
Hugo Mills             | Mushrooms on toast: the breakfast of champignons
hugo@... carfax.org.uk |
http://carfax.org.uk/  |
PGP: E2AB1DE4          |
