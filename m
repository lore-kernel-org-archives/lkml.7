Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9352DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB4020674
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ofg2FzWs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfKKQ3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:29:01 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]:42300 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfKKQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:29:00 -0500
Received: by mail-qt1-f182.google.com with SMTP id t20so16257844qtn.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 08:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9Np9q008djrufnzKVh019koHjtiU0GH6FaS29KStmxg=;
        b=Ofg2FzWsCGJ48tSFHJS841pYn7xOJhCf9DetEtAvWnJNfWQ2R6JB0vB7Nz7r7Ozlqf
         0CLEndsWVc98XSpazViFW2H62AvJJXaElk759kJ41K4KiV5RtOgliPjKpHwx8fzYRxd+
         ItcqYdm2qrIoON8AM6236573feDPUTLkm5VOvjqsSJx4NOmfTFDtkVXS5EaJLhiw8eT2
         xfGj9/XXpGn/e5af2VCvlVbm/zHHbhQikgEJkGAVB4GNPsMPrfOn8tEYhM7t2VJv8Zh/
         vCveJrtPdLxeNuoO3MQe2kPtMoZu5JhhiFJt+1YsA16MStFTVOrmd1HgbQYstjE2dRSa
         4eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9Np9q008djrufnzKVh019koHjtiU0GH6FaS29KStmxg=;
        b=f4TdDO0+TKHXs69s94JRqUpjNG3VZ2Yo7NTwLYXyNyjbiUc703PcOd6r4Ir9oKKebD
         lFgaLhNss6mcazhP8kt+nvmU3mxv4xOywZCSQo/ztI+Htmb22LyU27y5g6bllvIm6JhJ
         5pbxpfkkcFYYAScHr6lYU6+Y9Kk3htF8wGcPszqPYHhgk5wJi34kx5HdM8BK16/m8Agg
         NF5udlA93Xu+Hpgpy1bb4EKDcsX5JksBQT5RHa5OYE0TshNzKMs0UqelWHHAIw5tn3KT
         cmTOP7FUzMPR0UekUZ/b0mWBE04uPI0LYq5oTWOyu7CI7bu/9RfVvo0jdrPP3D3n8ObU
         rnnw==
X-Gm-Message-State: APjAAAVpp7RV6+vgiOhniGmKgtC4Kp5EYQGS8jmfXvnL+lLUa+UXA9it
        wAKItj0FACVY4vVSlerDHSoDeSVV3lRv471pFVTu4T7x
X-Google-Smtp-Source: APXvYqyCvnhDG8eSt075dmkCq4mrPQ/Y11Q9UkkP7fpJ3o9LsC6epuBG+gwma9FLH2obhH/H6voXTFbh5HzxEHznJL0=
X-Received: by 2002:ac8:6f44:: with SMTP id n4mr26136476qtv.379.1573489735589;
 Mon, 11 Nov 2019 08:28:55 -0800 (PST)
MIME-Version: 1.0
From:   Fawad Lateef <fawadlateef@gmail.com>
Date:   Mon, 11 Nov 2019 17:28:44 +0100
Message-ID: <CAGgoGu7Fw16m=OjtSdpxuCcP9ugRfzoG-9tydpyuNC++Dm2HfA@mail.gmail.com>
Subject: Unhandled fault: imprecise external abort (0x1406) - on UART
 comminucation between i.MX6 and STM32F0
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am seeing "Unhandled fault: imprecise external abort (0x1406)" when
doing constant UART communication between STM32F0 and i.MX6Q (Phytec
phyCORE eMMC SOM).

Communication is at the moment one character send (and receive) every
half second.

Running kernel version 5.2.14 and using device tree from phytec yocto
bsp modified to support our custom base-board.

Few months ago I was asking for help exactly same error for "v1"
prototype hardware _but_ that was happening when trying to load
xhci_pci.ko kernel module (using uPD720202 connected tp i.MX6 using
PEX8605). This problem is now solved (likely hidden) after having
uPD720202 chip variant which supports external EEPROM for firmware and
loaded EEPROM with proper firmware.

I noticed that time the xhci_pci.ko driver crashes likely because the
uPD720202 gives wrong status/information when not supporting EEPROM
(whereas EEPROM was populated on board). Now we don't see any crashes
because of PCIe bus (though we still have to program the USB3.0
power-delivery/connection controllers so USB3.0 communication part is
untested).

Now at this moment we see "Unhandled fault: imprecise external abort
(0x1406)" very quickly without even enabling PCIe/PEX8605 switch. Just
start communicating with STM32F0 directly connected to i.MX6 UART3
RX/TX pins (with 550ohm resistors between SOM/STM32 connection).

With-in few minutes of communication back and forth we see the kernel
crash and dump always shows PC at arch_cpu_idle().

BTW tested the same kernel and device-tree on phytec-MIRA
development-kit and connecting UART3 to PC using FTDI cable works
(UART on dev-kit is available through RS232 transceiver for PC
connection, TTL level is not accessible).

Any help and suggestion to help debugging the issue much appreciated.
Logs are below:

------------------------------------------------
barebox 2017.12.0-bsp-yocto-i.mx6-pd18.1.1 #1 Tue Oct 8 14:25:52 UTC 2019


Board: Phytec phyCORE-i.MX6 Quad with eMMC
detected i.MX6 Quad revision 1.5
i.MX6 unique ID: ee7f9502021a21d4
mdio_bus: miibus0: probed
eth0: got preset MAC address: 50:2d:f4:15:a9:ff
m25p80 flash@00: n25q128a13 (16384 Kbytes)
imx-usb 2184200.usb: USB EHCI 1.00
imx-esdhc 2190000.usdhc: registered as 2190000.usdhc
imx-esdhc 219c000.usdhc: registered as 219c000.usdhc
da9063 da90620: da9062 with id 62.22.ff.1a detected
state: New state registered 'state'
state: Using bucket 0@0x00000000
netconsole: registered as netconsole-1
phySOM-i.MX6: Using environment in MMC
malloc space: 0x4fefb480 -> 0x8fdf68ff (size 1023 MiB)
mmc3: detected MMC card version 5.0
mmc3: registered mmc3.boot0
mmc3: registered mmc3.boot1
mmc3: registered mmc3
envfs: no envfs (magic mismatch) - envfs never written?
running /env/bin/init...

Hit m for menu or any other key to stop autoboot:    0
bootchooser: Target list $global.bootchooser.targets is empty
Nothing bootable found on 'bootchooser'
booting 'emmc'

Loading ARM Linux zImage '/mnt/emmc/zImage'
Loading devicetree from '/mnt/emmc/oftree'
m25p0: Cannot find nodepath
/soc/aips-bus@02000000/spba-bus@02000000/ecspi@02008000/flash@0,
cannot fixup
Failed to fixup node in of_partition_fixup+0x1/0x1f4: Invalid argument
at24 24c320: Cannot find nodepath
/soc/aips-bus@02100000/i2c@021a8000/eeprom@50, cannot fixup
Failed to fixup node in of_partition_fixup+0x1/0x1f4: Invalid argument
Failed to fixup node in of_state_fixup+0x1/0x1f8: No such device
mmc3: Cannot find nodepath /soc/aips-bus@02100000/usdhc@0219c000, cannot fi=
xup
Failed to fixup node in of_partition_fixup+0x1/0x1f4: Invalid argument
commandline:  console=3Dttymxc1,115200n8  root=3D/dev/mmcblk1p2 rootwait
rw net.ifnames=3D0 biosdevname=3D0
Starting kernel in secure mode
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.2.14-bsp-yocto-i.mx6-pd18.1.1
(br-user@flateef-XPS-13-9360) (gcc version 9.1.0 (Buildroot
2019.08-g22814e85)) #1 SMP Tue Oct 8 13:02:45 UTC 2019
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: AirFi LEO with PhyCORE i.MX6
Quad eMMC SOM
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 128 MiB at 0x38000000
[    0.000000] percpu: Embedded 16 pages/cpu s34124 r8192 d23220 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 52275=
2
[    0.000000] Kernel command line:  console=3Dttymxc1,115200n8
root=3D/dev/mmcblk1p2 rootwait rw net.ifnames=3D0 biosdevname=3D0
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Memory: 1934232K/2097152K available (8192K kernel code,
356K rwdata, 2592K rodata, 1024K init, 399K bss, 31848K reserved,
131072K cma-reserved, 1309804K highmem)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 10 jiffies.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] random: get_random_bytes called from
start_kernel+0x250/0x430 with crng_init=3D0
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000015] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 715827882841ns
[    0.000049] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.002833] Console: colour dummy device 80x30
[    0.002895] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
[    0.002923] pid_max: default: 32768 minimum: 301
[    0.003212] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.003252] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes)
[    0.004365] CPU: Testing write buffer coherency: ok
[    0.004427] CPU0: Spectre v2: using BPIALL workaround
[    0.004907] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.006057] Setting up static identity map for 0x10100000 - 0x10100078
[    0.006337] rcu: Hierarchical SRCU implementation.
[    0.007092] smp: Bringing up secondary CPUs ...
[    0.008370] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.008383] CPU1: Spectre v2: using BPIALL workaround
[    0.009991] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.010003] CPU2: Spectre v2: using BPIALL workaround
[    0.011466] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.011477] CPU3: Spectre v2: using BPIALL workaround
[    0.011707] smp: Brought up 1 node, 4 CPUs
[    0.011733] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.011747] CPU: All CPU(s) started in SVC mode.
[    0.013542] devtmpfs: initialized
[    0.031647] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.031885] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.031926] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.044589] pinctrl core: initialized pinctrl subsystem
[    0.046222] NET: Registered protocol family 16
[    0.060328] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.061186] audit: initializing netlink subsys (disabled)
[    0.061520] audit: type=3D2000 audit(0.060:1): state=3Dinitialized
audit_enabled=3D0 res=3D1
[    0.062526] CPU identified as i.MX6Q, silicon rev 1.5
[    0.073926] vdd1p1: supplied by regulator-dummy
[    0.074782] vdd3p0: supplied by regulator-dummy
[    0.075563] vdd2p5: supplied by regulator-dummy
[    0.095002] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.095021] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.097621] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.151281] mxs-dma 110000.dma-apbh: initialized
[    0.158672] SCSI subsystem initialized
[    0.159439] usbcore: registered new interface driver usbfs
[    0.159561] usbcore: registered new interface driver hub
[    0.159724] usbcore: registered new device driver usb
[    0.159974] usb_phy_generic usbphynop1: usbphynop1 supply vcc not
found, using dummy regulator
[    0.160326] usb_phy_generic usbphynop2: usbphynop2 supply vcc not
found, using dummy regulator
[    0.162982] i2c i2c-0: IMX I2C adapter registered
[    0.163740] i2c i2c-1: IMX I2C adapter registered
[    0.164860] i2c i2c-2: IMX I2C adapter registered
[    0.165151] pps_core: LinuxPPS API ver. 1 registered
[    0.165168] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.165208] PTP clock support registered
[    0.166475] Bluetooth: Core ver 2.22
[    0.166566] NET: Registered protocol family 31
[    0.166583] Bluetooth: HCI device and connection manager initialized
[    0.166609] Bluetooth: HCI socket layer initialized
[    0.166630] Bluetooth: L2CAP socket layer initialized
[    0.166671] Bluetooth: SCO socket layer initialized
[    0.167557] clocksource: Switched to clocksource mxc_timer1
[    0.167822] VFS: Disk quotas dquot_6.6.0
[    0.167972] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.181217] NET: Registered protocol family 2
[    0.182402] tcp_listen_portaddr_hash hash table entries: 512
(order: 0, 6144 bytes)
[    0.182459] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.182627] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.182892] TCP: Hash tables configured (established 8192 bind 8192)
[    0.183210] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.183288] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.183630] NET: Registered protocol family 1
[    0.184536] RPC: Registered named UNIX socket transport module.
[    0.184554] RPC: Registered udp transport module.
[    0.184570] RPC: Registered tcp transport module.
[    0.184584] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.184609] PCI: CLS 0 bytes, default 64
[    0.185988] hw perfevents: no interrupt-affinity property for /pmu, gues=
sing.
[    0.186388] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 counters available
[    0.189114] Initialise system trusted keyrings
[    0.189407] workingset: timestamp_bits=3D30 max_order=3D19 bucket_order=
=3D0
[    0.199520] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.200623] NFS: Registering the id_resolver key type
[    0.200666] Key type id_resolver registered
[    0.200681] Key type id_legacy registered
[    0.200758] jffs2: version 2.2. (NAND) =EF=BF=BD=C2=A9 2001-2006 Red Hat=
, Inc.
[    0.201531] fuse: init (API version 7.31)
[    0.205682] Key type asymmetric registered
[    0.205702] Asymmetric key parser 'x509' registered
[    0.205822] bounce: pool size: 64 pages
[    0.205847] io scheduler mq-deadline registered
[    0.205865] io scheduler kyber registered
[    0.210980] imx6q-pcie 1ffc000.pcie: host bridge /soc/pcie@1ffc000 range=
s:
[    0.211120] imx6q-pcie 1ffc000.pcie:    IO 0x01f80000..0x01f8ffff
-> 0x00000000
[    0.211178] imx6q-pcie 1ffc000.pcie:   MEM 0x01000000..0x01efffff
-> 0x01000000
[    0.213966] imx-pgc-pd imx-pgc-power-domain.0: DMA mask not set
[    0.214150] imx-pgc-pd imx-pgc-power-domain.1: DMA mask not set
[    0.215878] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq =3D 26,
base_baud =3D 5000000) is a IMX
[    0.217021] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 65,
base_baud =3D 5000000) is a IMX
[    0.950952] printk: console [ttymxc1] enabled
[    0.956154] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq =3D 66,
base_baud =3D 5000000) is a IMX
[    0.965704] 21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq =3D 67,
base_baud =3D 5000000) is a IMX
[    0.991711] brd: module loaded
[    1.011714] loop: module loaded
[    1.015946] at24 2-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
[    1.026041] da9062 2-0058: Device detected (device-ID: 0x62,
var-ID: 0x22, DA9062)
[    1.040295] buck1: mapping for mode 2 not defined
[    1.048163] buck2: mapping for mode 2 not defined
[    1.055048] buck3: mapping for mode 2 not defined
[    1.062820] buck4: mapping for mode 2 not defined
[    1.071456] vdd_snvs: Bringing 3100000uV into 3000000-3000000uV
[    1.081145] vdd_high: Bringing 3100000uV into 3000000-3000000uV
[    1.090883] vdd_eth_io: Bringing 2600000uV into 2500000-2500000uV
[    1.099423] random: fast init done
[    1.103316] vdd_emmc: Bringing 1900000uV into 1800000-1800000uV
[    1.114988] ahci-imx 2200000.sata: fsl,transmit-level-mV not
specified, using 00000024
[    1.122991] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not
specified, using 00000480
[    1.131040] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not
specified, using 00002000
[    1.139263] ahci-imx 2200000.sata: fsl,receive-eq-mdB not
specified, using 05000000
[    1.149996] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disab=
led
[    1.157018] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports
3 Gbps 0x1 impl platform mode
[    1.165884] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo
only pmp pio slum part ccc apst
[    1.177386] scsi host0: ahci-imx
[    1.181416] ata1: SATA max UDMA/133 mmio [mem
0x02200000-0x02203fff] port 0x100 irq 70
[    1.194059] libphy: Fixed MDIO Bus: probed
[    1.199130] CAN device driver interface
[    1.206182] usbcore: registered new interface driver asix
[    1.211720] usbcore: registered new interface driver ax88179_178a
[    1.217929] usbcore: registered new interface driver cdc_ether
[    1.223836] usbcore: registered new interface driver net1080
[    1.229603] usbcore: registered new interface driver cdc_subset
[    1.235608] usbcore: registered new interface driver zaurus
[    1.241334] usbcore: registered new interface driver cdc_ncm
[    1.247007] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.253579] ehci-pci: EHCI PCI platform driver
[    1.258140] ehci-platform: EHCI generic platform driver
[    1.263930] ehci-mxc: Freescale On-Chip EHCI Host driver
[    1.269940] usbcore: registered new interface driver usb-storage
[    1.328046] imx6q-pcie 1ffc000.pcie: Phy link never came up
[    1.336948] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    1.343403] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.348947] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    1.355148] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01effff=
f]
[    1.362115] pci 0000:00:00.0: [16c3:abcd] type 01 class 0x060400
[    1.368210] pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x000fffff]
[    1.374511] pci 0000:00:00.0: reg 0x38: [mem 0x00000000-0x0000ffff pref]
[    1.381355] pci 0000:00:00.0: supports D1
[    1.385385] pci 0000:00:00.0: PME# supported from D0 D1 D3hot D3cold
[    1.401494] PCI: bus0: Fast back to back transfers disabled
[    1.416409] PCI: bus1: Fast back to back transfers enabled
[    1.421999] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff=
]
[    1.428850] pci 0000:00:00.0: BAR 6: assigned [mem
0x01100000-0x0110ffff pref]
[    1.436102] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.442369] pcieport 0000:00:00.0: AER: enabled with IRQ 313
[    1.551756] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    1.556699] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus numb=
er 1
[    1.587624] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    1.594210] hub 1-0:1.0: USB hub found
[    1.598108] hub 1-0:1.0: 1 port detected
[    1.605312] input: 20cc000.snvs:snvs-powerkey as
/devices/soc0/soc/2000000.aips-bus/20cc000.snvs/20cc000.snvs:snvs-powerkey/=
input/input0
[    1.620172] da9063-rtc da9062-rtc: DMA mask not set
[    1.635483] da9063-rtc da9062-rtc: registered as rtc1
[    1.641958] rtc-m41t80 0-0068: Can't clear HT bit
[    1.648555] snvs_rtc 20cc000.snvs:snvs-rtc-lp: registered as rtc2
[    1.654948] i2c /dev entries driver
[    1.664755] Bluetooth: HCI UART driver ver 2.3
[    1.669271] Bluetooth: HCI UART protocol H4 registered
[    1.675351] sdhci: Secure Digital Host Controller Interface driver
[    1.681579] sdhci: Copyright(c) Pierre Ossman
[    1.685948] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.687614] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    1.693462] sdhci-esdhc-imx 2190000.usdhc: Got CD GPIO
[    1.698215] ata1.00: supports DRM functions and may not be fully accessi=
ble
[    1.710017] ata1.00: ATA-11: Samsung SSD 860 EVO M.2 2TB, RVT22B6Q,
max UDMA/133
[    1.717437] ata1.00: 3907029168 sectors, multi 1: LBA48 NCQ (depth 32)
[    1.728138] ata1.00: supports DRM functions and may not be fully accessi=
ble
[    1.737102] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc]
using ADMA
[    1.737315] ata1.00: configured for UDMA/133
[    1.749929] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD
860  2B6Q PQ: 0 ANSI: 5
[    1.759141] ata1.00: Enabling discard_zeroes_data
[    1.764389] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    1.772310] sd 0:0:0:0: [sda] Write Protect is off
[    1.777313] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    1.780659] mmc1: SDHCI controller on 219c000.usdhc [219c000.usdhc]
using ADMA
[    1.793966] ata1.00: Enabling discard_zeroes_data
[    1.794561] leds-pca953x 0-0062: setting platform data
[    1.802120]  sda: sda1 sda2 sda3
[    1.809207] gpio gpiochip7: GPIO integer space overlap, cannot add chip
[    1.809440] ata1.00: Enabling discard_zeroes_data
[    1.815872] gpiochip_add_data_with_key: GPIOs 0..3 (gpio-pca9532)
failed to register, -16
[    1.821629] sd 0:0:0:0: [sda] Attached SCSI disk
[    1.828830] leds-pca953x 0-0062: could not add gpiochip
[    1.845776] caam 2100000.caam: Entropy delay =3D 3200
[    1.911533] caam 2100000.caam: Instantiated RNG4 SH0
[    1.972292] caam 2100000.caam: Instantiated RNG4 SH1
[    1.977284] caam 2100000.caam: device ID =3D 0x0a16010000000000 (Era 4)
[    1.983772] caam 2100000.caam: job rings =3D 2, qi =3D 0
[    2.014326] caam algorithms registered in /proc/crypto
[    2.028899] caam_jr 2101000.jr0: registering rng-caam
[    2.034978] hidraw: raw HID events driver (C) Jiri Kosina
[    2.040724] usbcore: registered new interface driver usbhid
[    2.046311] usbhid: USB HID core driver
[    2.048451] mmc1: new DDR MMC card at address 0001
[    2.054552] NET: Registered protocol family 10
[    2.057473] mmcblk1: mmc1:0001 Q2J55L 7.09 GiB
[    2.061286] Segment Routing with IPv6
[    2.064088] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    2.067896] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    2.076292] mmcblk1boot0: mmc1:0001 Q2J55L partition 1 16.0 MiB
[    2.081837] NET: Registered protocol family 17
[    2.088233] mmcblk1boot1: mmc1:0001 Q2J55L partition 2 16.0 MiB
[    2.090648] can: controller area network core (rev 20170425 abi 9)
[    2.096835] mmcblk1rpmb: mmc1:0001 Q2J55L partition 3 4.00 MiB,
chardev (247:0)
[    2.102867] NET: Registered protocol family 29
[    2.111997]  mmcblk1: p1 p2
[    2.114611] can: raw protocol (rev 20170425)
[    2.121718] can: broadcast manager protocol (rev 20170425 t)
[    2.127406] can: netlink gateway (rev 20170425) max_hops=3D1
[    2.133256] 8021q: 802.1Q VLAN Support v1.8
[    2.137521] Key type dns_resolver registered
[    2.142531] vddarm: supplied by vdd_arm
[    2.147470] vddpu: supplied by vdd_soc
[    2.152361] vddsoc: supplied by vdd_soc
[    2.158874] Registering SWP/SWPB emulation handler
[    2.165202] Loading compiled-in X.509 certificates
[    2.187945] imx_thermal tempmon: Automotive CPU temperature grade -
max:125C critical:120C passive:115C
[    2.199060] hctosys: unable to open rtc device (rtc0)
[    2.204711] VCC_CAM0: disabling
[    2.207885] flexcan1-reg: disabling
[    2.211382] usb_otg_vbus: disabling
[    2.215546] vdd_eth_io: disabling
[    2.238792] EXT4-fs (mmcblk1p2): mounted filesystem with ordered
data mode. Opts: (null)
[    2.246941] VFS: Mounted root (ext4 filesystem) on device 179:2.
[    2.253811] devtmpfs: mounted
[    2.259277] Freeing unused kernel memory: 1024K
[    2.278948] hub 1-1:1.0: USB hub found
[    2.282878] hub 1-1:1.0: 4 ports detected
[    2.288251] Run /sbin/init as init process
[    2.411051] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
Starting rsyslogd: OK
Starting syslogd: [    2.617646] usb 1-1.4: new high-speed USB device
number 3 using ci_hdrc
OK
Starting auditd: OK
Starting klogd: [    2.768702] hub 1-1.4:1.0: USB hub found
[    2.772867] hub 1-1.4:1.0: 4 ports detected
OK
Running sysctl: OK
Populating /dev using udev: [    3.022809] udevd[288]: starting version 3.2=
.8
[    3.036194] random: udevd: uninitialized urandom read (16 bytes read)
[    3.043824] random: udevd: uninitialized urandom read (16 bytes read)
[    3.050525] random: udevd: uninitialized urandom read (16 bytes read)
[    3.067756] udevd[288]: specified group 'kvm' unknown
[    3.117586] usb 1-1.4.1: new full-speed USB device number 4 using ci_hdr=
c
[    3.124337] udevd[289]: starting eudev-3.2.8
[    3.521312] usbcore: registered new interface driver usbserial_generic
[    3.531004] usbserial: USB Serial support registered for generic
[    3.558960] usbcore: registered new interface driver ftdi_sio
[    3.564830] usbserial: USB Serial support registered for FTDI USB
Serial Device
[    3.572423] ftdi_sio 1-1.4.1:1.0: FTDI USB Serial Device converter detec=
ted
[    3.579570] usb 1-1.4.1: Detected FT232RL
[    3.584940] usb 1-1.4.1: FTDI USB Serial Device converter now
attached to ttyUSB0
done
Starting irqbalance: OK
Initializing random number generator... done.
Starting system message bus: done
Starting network: OK
Starting sshd: OK

Welcome to Buildroot 2019.08
buildroot-2019.08-imx6 login: root
Password:
# sh /etc/powman-watchdog-kicker.sh &
# [  283.153303] Unhandled fault: imprecise external abort (0x1406) at
0xb6efb098
[  283.160381] pgd =3D (ptrval)
[  283.163104] [b6efb098] *pgd=3D00000000
[  283.166704] Internal error: : 1406 [#1] SMP ARM
[  283.171244] Modules linked in: ftdi_sio usbserial
[  283.175983] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.2.14-bsp-yocto-i.mx6-pd18.1.1 #1
[  283.184086] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  283.190649] PC is at arch_cpu_idle+0x30/0x3c
[  283.194935] LR is at arch_cpu_idle+0x2c/0x3c
[  283.199219] pc : [<c0108938>]    lr : [<c0108934>]    psr: 600a0013
[  283.205497] sp : c0d01f78  ip : 00000000  fp : c0c62a40
[  283.210732] r10: c0aa14ec  r9 : c0d5228b  r8 : c0d051a0
[  283.215969] r7 : c0d05168  r6 : 00000000  r5 : c0d00000  r4 : 00000000
[  283.222505] r3 : c011a720  r2 : 00000000  r1 : e6f62260  r0 : 0003a578
[  283.229048] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[  283.236195] Control: 10c5387d  Table: 34ea804a  DAC: 00000051
[  283.241953] Process swapper/0 (pid: 0, stack limit =3D 0x(ptrval))
[  283.247971] Stack: (0xc0d01f78 to 0xc0d02000)
[  283.252344] 1f60:
    00000000 c014bdc0
[  283.260541] 1f80: 000000cd 00000057 ffffffff c0d05140 c0d59280
c0d59280 00000001 c014c0dc
[  283.268737] 1fa0: c0d592d8 c0c00cc8 ffffffff ffffffff 00000000
c0c0057c 00000000 e7fffa00
[  283.276933] 1fc0: 00000000 c0c62a40 d5676c44 c0d05148 00000000
c0c00330 00000051 10c0387d
[  283.285129] 1fe0: 00000000 18000000 412fc09a 10c5387d 00000000
00000000 00000000 00000000
[  283.293348] [<c0108938>] (arch_cpu_idle) from [<c014bdc0>]
(do_idle+0xc8/0x160)
[  283.300683] [<c014bdc0>] (do_idle) from [<c014c0dc>]
(cpu_startup_entry+0x18/0x1c)
[  283.308284] [<c014c0dc>] (cpu_startup_entry) from [<c0c00cc8>]
(start_kernel+0x394/0x430)
[  283.316484] Code: e59f3010 e5933018 e12fff33 f1080080 (e8bd8010)
[  283.322596] ---[ end trace 34a9603c8e1ad68a ]---
[  283.327228] Kernel panic - not syncing: Attempted to kill the idle task!
[  283.333962] CPU1: stopping
[  283.336700] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
  5.2.14-bsp-yocto-i.mx6-pd18.1.1 #1
[  283.346189] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  283.352755] [<c010fdd8>] (unwind_backtrace) from [<c010b948>]
(show_stack+0x10/0x14)
[  283.360526] [<c010b948>] (show_stack) from [<c083b0d0>]
(dump_stack+0xb4/0xd0)
[  283.367774] [<c083b0d0>] (dump_stack) from [<c010e974>]
(handle_IPI+0x188/0x1e0)
[  283.375201] [<c010e974>] (handle_IPI) from [<c0434830>]
(gic_handle_irq+0x8c/0x9c)
[  283.382795] [<c0434830>] (gic_handle_irq) from [<c0101aac>]
(__irq_svc+0x6c/0x90)
[  283.390288] Exception stack(0xe4093f78 to 0xe4093fc0)
[  283.395353] 3f60:
    000421a0 e6f72260
[  283.403550] 3f80: 00000000 c011a720 00000000 e4092000 00000001
c0d05168 c0d051a0 c0d5228b
[  283.411746] 3fa0: c0aa14ec 00000000 00000000 e4093fc8 c0108934
c0108938 60040013 ffffffff
[  283.419950] [<c0101aac>] (__irq_svc) from [<c0108938>]
(arch_cpu_idle+0x30/0x3c)
[  283.427370] [<c0108938>] (arch_cpu_idle) from [<c014bdc0>]
(do_idle+0xc8/0x160)
[  283.434699] [<c014bdc0>] (do_idle) from [<c014c0dc>]
(cpu_startup_entry+0x18/0x1c)
[  283.442287] [<c014c0dc>] (cpu_startup_entry) from [<101024cc>] (0x101024=
cc)
[  283.449262] CPU2: stopping
[  283.451996] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D
  5.2.14-bsp-yocto-i.mx6-pd18.1.1 #1
[  283.461489] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  283.468051] [<c010fdd8>] (unwind_backtrace) from [<c010b948>]
(show_stack+0x10/0x14)
[  283.475818] [<c010b948>] (show_stack) from [<c083b0d0>]
(dump_stack+0xb4/0xd0)
[  283.483062] [<c083b0d0>] (dump_stack) from [<c010e974>]
(handle_IPI+0x188/0x1e0)
[  283.490482] [<c010e974>] (handle_IPI) from [<c0434830>]
(gic_handle_irq+0x8c/0x9c)
[  283.498074] [<c0434830>] (gic_handle_irq) from [<c0101aac>]
(__irq_svc+0x6c/0x90)
[  283.505567] Exception stack(0xe4095f78 to 0xe4095fc0)
[  283.510631] 5f60:
    000438b8 e6f82260
[  283.518828] 5f80: 00000000 c011a720 00000000 e4094000 00000002
c0d05168 c0d051a0 c0d5228b
[  283.527025] 5fa0: c0aa14ec 00000000 00000000 e4095fc8 c0108934
c0108938 60040013 ffffffff
[  283.535227] [<c0101aac>] (__irq_svc) from [<c0108938>]
(arch_cpu_idle+0x30/0x3c)
[  283.542645] [<c0108938>] (arch_cpu_idle) from [<c014bdc0>]
(do_idle+0xc8/0x160)
[  283.549975] [<c014bdc0>] (do_idle) from [<c014c0dc>]
(cpu_startup_entry+0x18/0x1c)
[  283.557562] [<c014c0dc>] (cpu_startup_entry) from [<101024cc>] (0x101024=
cc)
[  283.564538] CPU3: stopping
[  283.567274] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D
  5.2.14-bsp-yocto-i.mx6-pd18.1.1 #1
[  283.576763] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  283.583323] [<c010fdd8>] (unwind_backtrace) from [<c010b948>]
(show_stack+0x10/0x14)
[  283.591089] [<c010b948>] (show_stack) from [<c083b0d0>]
(dump_stack+0xb4/0xd0)
[  283.598333] [<c083b0d0>] (dump_stack) from [<c010e974>]
(handle_IPI+0x188/0x1e0)
[  283.605753] [<c010e974>] (handle_IPI) from [<c0434830>]
(gic_handle_irq+0x8c/0x9c)
[  283.613343] [<c0434830>] (gic_handle_irq) from [<c0101aac>]
(__irq_svc+0x6c/0x90)
[  283.620836] Exception stack(0xe4097f78 to 0xe4097fc0)
[  283.625901] 7f60:
    0004e88c e6f92260
[  283.634098] 7f80: 00000000 c011a720 00000000 e4096000 00000003
c0d05168 c0d051a0 c0d5228b
[  283.642295] 7fa0: c0aa14ec 00000000 00000000 e4097fc8 c0108934
c0108938 600c0013 ffffffff
[  283.650498] [<c0101aac>] (__irq_svc) from [<c0108938>]
(arch_cpu_idle+0x30/0x3c)
[  283.657919] [<c0108938>] (arch_cpu_idle) from [<c014bdc0>]
(do_idle+0xc8/0x160)
[  283.665249] [<c014bdc0>] (do_idle) from [<c014c0dc>]
(cpu_startup_entry+0x18/0x1c)
[  283.672837] [<c014c0dc>] (cpu_startup_entry) from [<101024cc>] (0x101024=
cc)
[  283.679824] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---

--------------------------------------------------------------------------


barebox 2017.12.0-bsp-yocto-i.mx6-pd18.1.1 #1 Thu Oct 3 11:19:18 UTC 2019


Board: Phytec phyCORE-i.MX6 Quad with eMMC
detected i.MX6 Quad revision 1.5
i.MX6 unique ID: ee7f9502021a21d4
mdio_bus: miibus0: probed
eth0: got preset MAC address: 50:2d:f4:15:a9:ff
m25p80 flash@00: n25q128a13 (16384 Kbytes)
imx-usb 2184200.usb: USB EHCI 1.00
imx-esdhc 2190000.usdhc: registered as 2190000.usdhc
imx-esdhc 219c000.usdhc: registered as 219c000.usdhc
da9063 da90620: da9062 with id 62.22.ff.1a detected
state: New state registered 'state'
state: Using bucket 0@0x00000000
netconsole: registered as netconsole-1
phySOM-i.MX6: Using environment in MMC
malloc space: 0x4fefb480 -> 0x8fdf68ff (size 1023 MiB)
mmc3: detected MMC card version 5.0
mmc3: registered mmc3.boot0
mmc3: registered mmc3.boot1
mmc3: registered mmc3
running /env/bin/init...

Hit m for menu or any other key to stop autoboot:    1
bootchooser: Target list $global.bootchooser.targets is empty
Nothing bootable found on 'bootchooser'
booting 'emmc'

Loading ARM Linux zImage '/mnt/emmc/zImage'
Loading devicetree from '/mnt/emmc/oftree'
commandline:  console=3Dttymxc1,115200n8  root=3D/dev/mmcblk3p2 rootwait
rw net.ifnames=3D0 biosdevname=3D0
Starting kernel in secure mode
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.14.93-bsp-yocto-i.mx6-pd18.1.1
(br-user@flateef-XPS-13-9360) (gcc version 9.1.0 (Buildroot
2019.08-g22814e85-dirty)) #1 SMP Thu Oct 3 08:57:15 UTC 2019
[    0.000000] CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=3D10=
c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: AirFi LEO with PhyCORE i.MX6
Quad eMMC SOM
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] cma: Reserved 128 MiB at 0x86000000
[    0.000000] percpu: Embedded 16 pages/cpu @eef91000 s33932 r8192
d23412 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 52275=
2
[    0.000000] Kernel command line:  console=3Dttymxc1,115200n8
root=3D/dev/mmcblk3p2 rootwait rw net.ifnames=3D0 biosdevname=3D0
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 by=
tes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 byte=
s)
[    0.000000] Memory: 1935468K/2097152K available (7168K kernel code,
304K rwdata, 2316K rodata, 1024K init, 401K bss, 30612K reserved,
131072K cma-reserved, 1178732K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0800000   (8160 kB)
[    0.000000]       .init : 0xc0b00000 - 0xc0c00000   (1024 kB)
[    0.000000]       .data : 0xc0c00000 - 0xc0c4c380   ( 305 kB)
[    0.000000]        .bss : 0xc0c5508c - 0xc0cb9688   ( 402 kB)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, N=
odes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU event tracing is enabled.
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] L2C-310 errata 752271 769419 enabled
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 16 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c7, AUX_CTRL 0x76470001
[    0.000000] Switching to timer-based delay loop, resolution 333ns
[    0.000016] sched_clock: 32 bits at 3000kHz, resolution 333ns,
wraps every 715827882841ns
[    0.000054] clocksource: mxc_timer1: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 637086815595 ns
[    0.002907] Console: colour dummy device 80x30
[    0.002963] Calibrating delay loop (skipped), value calculated
using timer frequency.. 6.00 BogoMIPS (lpj=3D30000)
[    0.002994] pid_max: default: 32768 minimum: 301
[    0.003262] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.003306] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 by=
tes)
[    0.004284] CPU: Testing write buffer coherency: ok
[    0.004344] CPU0: Spectre v2: using BPIALL workaround
[    0.004988] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.005720] Setting up static identity map for 0x10100000 - 0x10100078
[    0.005965] Hierarchical SRCU implementation.
[    0.007120] smp: Bringing up secondary CPUs ...
[    0.008285] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.008297] CPU1: Spectre v2: using BPIALL workaround
[    0.009645] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.009655] CPU2: Spectre v2: using BPIALL workaround
[    0.010999] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.011011] CPU3: Spectre v2: using BPIALL workaround
[    0.011204] smp: Brought up 1 node, 4 CPUs
[    0.011227] SMP: Total of 4 processors activated (24.00 BogoMIPS).
[    0.011246] CPU: All CPU(s) started in SVC mode.
[    0.012909] devtmpfs: initialized
[    0.029803] random: get_random_u32 called from
bucket_table_alloc+0xf8/0x224 with crng_init=3D0
[    0.030060] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.030294] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.030333] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.043257] pinctrl core: initialized pinctrl subsystem
[    0.044652] NET: Registered protocol family 16
[    0.057157] DMA: preallocated 256 KiB pool for atomic coherent allocatio=
ns
[    0.058648] CPU identified as i.MX6Q, silicon rev 1.5
[    0.067986] vdd1p1: supplied by regulator-dummy
[    0.068741] vdd3p0: supplied by regulator-dummy
[    0.069479] vdd2p5: supplied by regulator-dummy
[    0.086628] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.086650] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.089065] imx6q-pinctrl 20e0000.iomuxc: initialized IMX pinctrl driver
[    0.122672] mxs-dma 110000.dma-apbh: initialized
[    0.129746] SCSI subsystem initialized
[    0.130471] usbcore: registered new interface driver usbfs
[    0.130568] usbcore: registered new interface driver hub
[    0.130716] usbcore: registered new device driver usb
[    0.132804] i2c i2c-0: IMX I2C adapter registered
[    0.132838] i2c i2c-0: can't use DMA, using PIO instead.
[    0.133473] i2c i2c-1: IMX I2C adapter registered
[    0.133503] i2c i2c-1: can't use DMA, using PIO instead.
[    0.134386] i2c i2c-2: IMX I2C adapter registered
[    0.134417] i2c i2c-2: can't use DMA, using PIO instead.
[    0.134681] pps_core: LinuxPPS API ver. 1 registered
[    0.134699] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.134740] PTP clock support registered
[    0.135831] Bluetooth: Core ver 2.22
[    0.135907] NET: Registered protocol family 31
[    0.135925] Bluetooth: HCI device and connection manager initialized
[    0.135950] Bluetooth: HCI socket layer initialized
[    0.135972] Bluetooth: L2CAP socket layer initialized
[    0.136072] Bluetooth: SCO socket layer initialized
[    0.136890] clocksource: Switched to clocksource mxc_timer1
[    0.137073] VFS: Disk quotas dquot_6.6.0
[    0.137228] VFS: Dquot-cache hash table entries: 1024 (order 0, 4096 byt=
es)
[    0.149443] NET: Registered protocol family 2
[    0.150508] TCP established hash table entries: 8192 (order: 3, 32768 by=
tes)
[    0.150677] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.150951] TCP: Hash tables configured (established 8192 bind 8192)
[    0.151266] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.151342] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.151651] NET: Registered protocol family 1
[    0.152414] RPC: Registered named UNIX socket transport module.
[    0.152435] RPC: Registered udp transport module.
[    0.152449] RPC: Registered tcp transport module.
[    0.152462] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.153807] hw perfevents: no interrupt-affinity property for
/soc/pmu, guessing.
[    0.154167] hw perfevents: enabled with armv7_cortex_a9 PMU driver,
7 counters available
[    0.155971] audit: initializing netlink subsys (disabled)
[    0.156263] audit: type=3D2000 audit(0.140:1): state=3Dinitialized
audit_enabled=3D0 res=3D1
[    0.156732] Initialise system trusted keyrings
[    0.157056] workingset: timestamp_bits=3D30 max_order=3D19 bucket_order=
=3D0
[    0.163960] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.165067] NFS: Registering the id_resolver key type
[    0.165117] Key type id_resolver registered
[    0.165136] Key type id_legacy registered
[    0.165217] jffs2: version 2.2. (NAND) =C2=A9 2001-2006 Red Hat, Inc.
[    0.165934] fuse init (API version 7.26)
[    0.174876] Key type asymmetric registered
[    0.174902] Asymmetric key parser 'x509' registered
[    0.175002] bounce: pool size: 64 pages
[    0.175034] io scheduler noop registered
[    0.175053] io scheduler deadline registered
[    0.175300] io scheduler cfq registered (default)
[    0.175320] io scheduler mq-deadline registered
[    0.175336] io scheduler kyber registered
[    0.179225] OF: PCI: host bridge /soc/pcie@1ffc000 ranges:
[    0.179283] OF: PCI:    IO 0x01f80000..0x01f8ffff -> 0x00000000
[    0.179315] OF: PCI:   MEM 0x01000000..0x01efffff -> 0x01000000
[    1.297341] imx6q-pcie 1ffc000.pcie: phy link never came up
[    1.300623] imx6q-pcie 1ffc000.pcie: PCI host bridge to bus 0000:00
[    1.300654] pci_bus 0000:00: root bus resource [bus 00-ff]
[    1.300678] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    1.300699] pci_bus 0000:00: root bus resource [mem 0x01000000-0x01effff=
f]
[    1.301243] PCI: bus0: Fast back to back transfers disabled
[    1.301414] PCI: bus1: Fast back to back transfers enabled
[    1.301484] pci 0000:00:00.0: BAR 0: assigned [mem 0x01000000-0x010fffff=
]
[    1.301514] pci 0000:00:00.0: BAR 6: assigned [mem
0x01100000-0x0110ffff pref]
[    1.301539] pci 0000:00:00.0: PCI bridge to [bus 01-ff]
[    1.302150] pcieport 0000:00:00.0: AER enabled with IRQ 297
[    1.305742] imx-pgc-pd imx-pgc-power-domain.0: Linked as a consumer
to 20dc000.gpc
[    1.307953] 2020000.serial: ttymxc0 at MMIO 0x2020000 (irq =3D 25,
base_baud =3D 5000000) is a IMX
[    1.309154] 21e8000.serial: ttymxc1 at MMIO 0x21e8000 (irq =3D 64,
base_baud =3D 5000000) is a IMX
[    2.161442] console [ttymxc1] enabled
[    2.165962] 21ec000.serial: ttymxc2 at MMIO 0x21ec000 (irq =3D 65,
base_baud =3D 5000000) is a IMX
[    2.175506] 21f0000.serial: ttymxc3 at MMIO 0x21f0000 (irq =3D 66,
base_baud =3D 5000000) is a IMX
[    2.199502] brd: module loaded
[    2.217998] loop: module loaded
[    2.221972] at24 2-0050: 4096 byte 24c32 EEPROM, writable, 1 bytes/write
[    2.231942] da9062 2-0058: Device detected (device-ID: 0x62,
var-ID: 0x22, DA9062)
[    2.265672] random: fast init done
[    2.271796] vdd_snvs: Bringing 3100000uV into 3000000-3000000uV
[    2.281552] vdd_high: Bringing 3100000uV into 3000000-3000000uV
[    2.291285] vdd_eth_io: Bringing 2600000uV into 2500000-2500000uV
[    2.300386] vdd_emmc: Bringing 1900000uV into 1800000-1800000uV
[    2.311660] ahci-imx 2200000.sata: fsl,transmit-level-mV not
specified, using 00000024
[    2.319653] ahci-imx 2200000.sata: fsl,transmit-boost-mdB not
specified, using 00000480
[    2.327709] ahci-imx 2200000.sata: fsl,transmit-atten-16ths not
specified, using 00002000
[    2.335911] ahci-imx 2200000.sata: fsl,receive-eq-mdB not
specified, using 05000000
[    2.346628] ahci-imx 2200000.sata: SSS flag set, parallel bus scan disab=
led
[    2.353692] ahci-imx 2200000.sata: AHCI 0001.0300 32 slots 1 ports
3 Gbps 0x1 impl platform mode
[    2.362537] ahci-imx 2200000.sata: flags: ncq sntf stag pm led clo
only pmp pio slum part ccc apst
[    2.373772] scsi host0: ahci-imx
[    2.377371] ata1: SATA max UDMA/133 mmio [mem
0x02200000-0x02203fff] port 0x100 irq 69
[    2.389689] libphy: Fixed MDIO Bus: probed
[    2.394574] CAN device driver interface
[    2.401039] usbcore: registered new interface driver asix
[    2.406523] usbcore: registered new interface driver ax88179_178a
[    2.412741] usbcore: registered new interface driver cdc_ether
[    2.418691] usbcore: registered new interface driver net1080
[    2.424430] usbcore: registered new interface driver cdc_subset
[    2.430464] usbcore: registered new interface driver zaurus
[    2.436142] usbcore: registered new interface driver cdc_ncm
[    2.441850] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.448417] ehci-pci: EHCI PCI platform driver
[    2.452952] ehci-platform: EHCI generic platform driver
[    2.458711] ehci-mxc: Freescale On-Chip EHCI Host driver
[    2.464636] usbcore: registered new interface driver usb-storage
[    2.481908] ci_hdrc ci_hdrc.1: EHCI Host Controller
[    2.486853] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus numb=
er 1
[    2.516950] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
[    2.523497] hub 1-0:1.0: USB hub found
[    2.527375] hub 1-0:1.0: 1 port detected
[    2.545895] da9063-rtc da9062-rtc: rtc core: registered da9063-rtc as rt=
c1
[    2.555041] rtc-m41t80 0-0068: Can't clear HT bit
[    2.561488] snvs_rtc 20cc000.snvs:snvs-rtc-lp: rtc core: registered
20cc000.snvs:snvs-rtc-lp as rtc2
[    2.570938] i2c /dev entries driver
[    2.579772] Bluetooth: HCI UART driver ver 2.3
[    2.584240] Bluetooth: HCI UART protocol H4 registered
[    2.590247] sdhci: Secure Digital Host Controller Interface driver
[    2.596443] sdhci: Copyright(c) Pierre Ossman
[    2.600849] sdhci-pltfm: SDHCI platform and OF driver helper
[    2.608023] sdhci-esdhc-imx 2190000.usdhc: Got CD GPIO
[    2.677196] mmc0: SDHCI controller on 2190000.usdhc [2190000.usdhc]
using ADMA
[    2.747098] mmc1: SDHCI controller on 219c000.usdhc [219c000.usdhc]
using ADMA
[    2.755109] leds-pca953x 0-0062: setting platform data
[    2.767365] leds-pca953x 0-0062: gpios 508...511
[    2.775911] caam 2100000.caam: Entropy delay =3D 3200
[    2.841654] caam 2100000.caam: Instantiated RNG4 SH0
[    2.876973] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    2.883552] ata1.00: supports DRM functions and may not be fully accessi=
ble
[    2.890579] ata1.00: ATA-11: Samsung SSD 860 EVO M.2 2TB, RVT22B6Q,
max UDMA/133
[    2.898020] ata1.00: 3907029168 sectors, multi 1: LBA48 NCQ (depth 31/32=
)
[    2.902414] caam 2100000.caam: Instantiated RNG4 SH1
[    2.910100] caam 2100000.caam: device ID =3D 0x0a16010000000000 (Era 4)
[    2.916586] caam 2100000.caam: job rings =3D 2, qi =3D 0, dpaa2 =3D no
[    2.924072] ata1.00: supports DRM functions and may not be fully accessi=
ble
[    2.934081] ata1.00: configured for UDMA/133
[    2.939106] scsi 0:0:0:0: Direct-Access     ATA      Samsung SSD
860  2B6Q PQ: 0 ANSI: 5
[    2.940521] caam algorithms registered in /proc/crypto
[    2.948401] ata1.00: Enabling discard_zeroes_data
[    2.958247] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks:
(2.00 TB/1.82 TiB)
[    2.958800] caam_jr 2101000.jr0: registering rng-caam
[    2.966116] sd 0:0:0:0: [sda] Write Protect is off
[    2.972068] hidraw: raw HID events driver (C) Jiri Kosina
[    2.981603] sd 0:0:0:0: [sda] Write cache: enabled, read cache:
enabled, doesn't support DPO or FUA
[    2.981708] usbcore: registered new interface driver usbhid
[    2.982136] mmc1: new DDR MMC card at address 0001
[    2.982770] mmcblk3: mmc1:0001 Q2J55L 7.09 GiB
[    2.983090] mmcblk3boot0: mmc1:0001 Q2J55L partition 1 16.0 MiB
[    2.983412] mmcblk3boot1: mmc1:0001 Q2J55L partition 2 16.0 MiB
[    2.983699] mmcblk3rpmb: mmc1:0001 Q2J55L partition 3 4.00 MiB
[    2.986997] usb 1-1: new high-speed USB device number 2 using ci_hdrc
[    2.991878] ata1.00: Enabling discard_zeroes_data
[    2.992053]  mmcblk3: p1 p2
[    2.996299] usbhid: USB HID core driver
[    3.003021]  sda: sda1 sda2 sda3
[    3.008293] ip_tables: (C) 2000-2006 Netfilter Core Team
[    3.013015] ata1.00: Enabling discard_zeroes_data
[    3.055480] NET: Registered protocol family 10
[    3.055653] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.061369] Segment Routing with IPv6
[    3.068443] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.075335] NET: Registered protocol family 17
[    3.079854] can: controller area network core (rev 20170425 abi 9)
[    3.086187] NET: Registered protocol family 29
#!/bin/sh

stty -F /dev/ttymxc2 921600

while (true) do
        usleep 500000
        echo "0" > /dev/ttymxc2
        usleep 500000
        echo "1" > /dev/ttymxc2
        usleep 500000
        echo "2" > /dev/ttymxc2
done

# sh /etc/powman-watchdog-kicker.sh
[  175.903693] random: crng init done
[  175.907127] random: 7 urandom warning(s) missed due to ratelimiting
[  252.965632] Unhandled fault: imprecise external abort (0x1406) at 0xb6f6=
5098
[  252.972714] pgd =3D c0004000
[  252.975438] [b6f65098] *pgd=3D00000000
[  252.979041] Internal error: : 1406 [#1] SMP ARM
[  252.983584] Modules linked in: ftdi_sio usbserial
[  252.988330] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
4.14.93-bsp-yocto-i.mx6-pd18.1.1 #1
[  252.996522] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  253.003063] task: c0c078c0 task.stack: c0c00000
[  253.007628] PC is at arch_cpu_idle+0x30/0x3c
[  253.011922] LR is at arch_cpu_idle+0x2c/0x3c
[  253.016206] pc : [<c0108358>]    lr : [<c0108354>]    psr: 600a0013
[  253.022489] sp : c0c01f90  ip : c0c042d4  fp : 00000000
[  253.027727] r10: 00000001  r9 : c097ef8c  r8 : c0c4c0be
[  253.032966] r7 : c0c0416c  r6 : c0c041b8  r5 : 00000000  r4 : c0c00000
[  253.039507] r3 : c011a1c0  r2 : 2e423000  r1 : c0b72340  r0 : c0c00000
[  253.046050] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment=
 none
[  253.053201] Control: 10c5387d  Table: 3c73c04a  DAC: 00000051
[  253.058960] Process swapper/0 (pid: 0, stack limit =3D 0xc0c00210)
[  253.064981] Stack: (0xc0c01f90 to 0xc0c02000)
[  253.069357] 1f80:                                     c0c00000
c01562b4 000000be ffffffff
[  253.077555] 1fa0: c0c550c0 c0c04140 c0c550c0 efffca40 c0b5ea30
c0156590 c0c5510c c0b00bf4
[  253.085754] 1fc0: ffffffff ffffffff 00000000 c0b0059c 00000000
c0b5ea30 c0c55354 c0c04158
[  253.093953] 1fe0: c0b5ea2c c0c08afc 1000406a 412fc09a 00000000
1000807c 00000000 00000000
[  253.102175] [<c0108358>] (arch_cpu_idle) from [<c01562b4>]
(do_idle+0xbc/0x144)
[  253.109519] [<c01562b4>] (do_idle) from [<c0156590>]
(cpu_startup_entry+0x18/0x1c)
[  253.117122] [<c0156590>] (cpu_startup_entry) from [<c0b00bf4>]
(start_kernel+0x324/0x394)
[  253.125327] Code: e59f3010 e5933018 e12fff33 f1080080 (e8bd8010)
[  253.131441] ---[ end trace cc76bee095fa7b3e ]---
[  253.136075] Kernel panic - not syncing: Attempted to kill the idle task!
[  253.142811] CPU2: stopping
[  253.145551] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G      D
4.14.93-bsp-yocto-i.mx6-pd18.1.1 #1
[  253.154958] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  253.161529] [<c010fb18>] (unwind_backtrace) from [<c010b3e8>]
(show_stack+0x10/0x14)
[  253.169309] [<c010b3e8>] (show_stack) from [<c0797488>]
(dump_stack+0x8c/0xa8)
[  253.176563] [<c0797488>] (dump_stack) from [<c010e850>]
(handle_IPI+0x158/0x1b0)
[  253.183985] [<c010e850>] (handle_IPI) from [<c01015a4>]
(gic_handle_irq+0x8c/0x9c)
[  253.191581] [<c01015a4>] (gic_handle_irq) from [<c010c2ac>]
(__irq_svc+0x6c/0x90)
[  253.199077] Exception stack(0xec08df78 to 0xec08dfc0)
[  253.204145] df60:
    ec08c000 c0b72340
[  253.212345] df80: 2e443000 c011a1c0 ec08c000 00000000 c0c041b8
c0c0416c c0c4c0be c097ef8c
[  253.220543] dfa0: 00000001 00000000 c0c042d4 ec08dfc8 c0108354
c0108358 600c0013 ffffffff
[  253.228751] [<c010c2ac>] (__irq_svc) from [<c0108358>]
(arch_cpu_idle+0x30/0x3c)
[  253.236178] [<c0108358>] (arch_cpu_idle) from [<c01562b4>]
(do_idle+0xbc/0x144)
[  253.243513] [<c01562b4>] (do_idle) from [<c0156590>]
(cpu_startup_entry+0x18/0x1c)
[  253.251107] [<c0156590>] (cpu_startup_entry) from [<1010186c>] (0x101018=
6c)
[  253.258085] CPU3: stopping
[  253.260822] CPU: 3 PID: 0 Comm: swapper/3 Tainted: G      D
4.14.93-bsp-yocto-i.mx6-pd18.1.1 #1
[  253.270228] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  253.276792] [<c010fb18>] (unwind_backtrace) from [<c010b3e8>]
(show_stack+0x10/0x14)
[  253.284564] [<c010b3e8>] (show_stack) from [<c0797488>]
(dump_stack+0x8c/0xa8)
[  253.291813] [<c0797488>] (dump_stack) from [<c010e850>]
(handle_IPI+0x158/0x1b0)
[  253.299232] [<c010e850>] (handle_IPI) from [<c01015a4>]
(gic_handle_irq+0x8c/0x9c)
[  253.306822] [<c01015a4>] (gic_handle_irq) from [<c010c2ac>]
(__irq_svc+0x6c/0x90)
[  253.314317] Exception stack(0xec08ff78 to 0xec08ffc0)
[  253.319384] ff60:
    ec08e000 c0b72340
[  253.327584] ff80: 2e453000 c011a1c0 ec08e000 00000000 c0c041b8
c0c0416c c0c4c0be c097ef8c
[  253.335784] ffa0: 00000001 00000000 c0c042d4 ec08ffc8 c0108354
c0108358 60040013 ffffffff
[  253.343989] [<c010c2ac>] (__irq_svc) from [<c0108358>]
(arch_cpu_idle+0x30/0x3c)
[  253.351415] [<c0108358>] (arch_cpu_idle) from [<c01562b4>]
(do_idle+0xbc/0x144)
[  253.358750] [<c01562b4>] (do_idle) from [<c0156590>]
(cpu_startup_entry+0x18/0x1c)
[  253.366342] [<c0156590>] (cpu_startup_entry) from [<1010186c>] (0x101018=
6c)
[  253.373318] CPU1: stopping
[  253.376056] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G      D
4.14.93-bsp-yocto-i.mx6-pd18.1.1 #1
[  253.385463] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  253.392027] [<c010fb18>] (unwind_backtrace) from [<c010b3e8>]
(show_stack+0x10/0x14)
[  253.399799] [<c010b3e8>] (show_stack) from [<c0797488>]
(dump_stack+0x8c/0xa8)
[  253.407048] [<c0797488>] (dump_stack) from [<c010e850>]
(handle_IPI+0x158/0x1b0)
[  253.414466] [<c010e850>] (handle_IPI) from [<c01015a4>]
(gic_handle_irq+0x8c/0x9c)
[  253.422057] [<c01015a4>] (gic_handle_irq) from [<c010c2ac>]
(__irq_svc+0x6c/0x90)
[  253.429552] Exception stack(0xec08bf78 to 0xec08bfc0)
[  253.434618] bf60:
    ec08a000 c0b72340
[  253.442818] bf80: 2e433000 c011a1c0 ec08a000 00000000 c0c041b8
c0c0416c c0c4c0be c097ef8c
[  253.451017] bfa0: 00000001 00000000 c0c042d4 ec08bfc8 c0108354
c0108358 60040013 ffffffff
[  253.459223] [<c010c2ac>] (__irq_svc) from [<c0108358>]
(arch_cpu_idle+0x30/0x3c)
[  253.466648] [<c0108358>] (arch_cpu_idle) from [<c01562b4>]
(do_idle+0xbc/0x144)
[  253.473986] [<c01562b4>] (do_idle) from [<c0156590>]
(cpu_startup_entry+0x18/0x1c)
[  253.481579] [<c0156590>] (cpu_startup_entry) from [<1010186c>] (0x101018=
6c)
[  253.488569] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task!



-- Fawad Lateef
