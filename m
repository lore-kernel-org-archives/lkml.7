Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A740C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3324208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 19:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SIiW5l71";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cResadpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbfE1TjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 15:39:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:3298 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfE1Ti7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 15:38:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559072339; x=1590608339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vAhbLdR4ZaBsE95qXFKaN0XGflr2ES4+ZsSUSRt9CYw=;
  b=SIiW5l718X25Vg54z/G7Vv/gsYdbXu37fXEtIES1ICb1e7hIjNkCtXcV
   5W0ql5n4hMjt6Er28bgQl0Wyk2J+6rJvAstI9UFMn3H4Ma7gjbpvbSZA9
   SOAUHQG4H6dRi3UNvDuUjsfbe10ycx0a97pF5ae+/c2RnfGrBvc29obpK
   uAoziuN7tCCaCjw/QJxTNcXTv2BMnbes2gL0pNSUuofbo7CC50AjfzEog
   cs5a89vMZHAStNejbZapyQx0j56PcCGXZjxMdm9eCU+LmWkGG92q96aES
   YKEePrS8itoIWfRC0kl1yy37Sfu5SmwJPgfWPeUSslWO7KN8Pzgh35uId
   A==;
X-IronPort-AV: E=Sophos;i="5.60,524,1549900800"; 
   d="scan'208";a="114202715"
Received: from mail-bn3nam04lp2057.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.57])
  by ob1.hgst.iphmx.com with ESMTP; 29 May 2019 03:38:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBDlzJp1KJzHMsZUL1hTWmHR9Oxq5c83vGna6Th503E=;
 b=cResadpM45/2LXQEPeABAa3nBkkFgDuOqGiiSSWK6obGyU9D229c3Dpn/PKrZXoXdDf8Z6fiAxhS3aLklpoZVkaLftH8Nhn4P7zZKDR30fSD8S4doiDWV7gpRMH4xWVk1yLL0JQZY2tVrqf7/2hiCFIfBBv7ErIWhbtpnBFRM3c=
Received: from BYAPR04MB3782.namprd04.prod.outlook.com (52.135.214.142) by
 BYAPR04MB5830.namprd04.prod.outlook.com (20.179.58.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.15; Tue, 28 May 2019 19:38:55 +0000
Received: from BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ce8:bf96:aaf8:d2b0]) by BYAPR04MB3782.namprd04.prod.outlook.com
 ([fe80::ce8:bf96:aaf8:d2b0%4]) with mapi id 15.20.1922.021; Tue, 28 May 2019
 19:38:55 +0000
From:   Atish Patra <Atish.Patra@wdc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "lollivier@baylibre.com" <lollivier@baylibre.com>
Subject: Re: Testing the recent RISC-V DT patchsets
Thread-Topic: Testing the recent RISC-V DT patchsets
Thread-Index: AQHU+WoC33eaLOfxLkSrxsaS40QPYaaAbQuAgAC6GAA=
Date:   Tue, 28 May 2019 19:38:55 +0000
Message-ID: <AE5C4E2E-13C2-4CD4-B98A-499BBB922BDB@wdc.com>
References: <alpine.DEB.2.21.9999.1904221705170.18377@viisi.sifive.com>
 <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1905280105110.20842@viisi.sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Atish.Patra@wdc.com; 
x-originating-ip: [2607:fb90:9e4d:a2f5:7c7d:af93:6799:77fe]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a5096fa-8c4d-4631-550f-08d6e3a41f56
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5830;
x-ms-traffictypediagnostic: BYAPR04MB5830:
x-ms-exchange-purlcount: 3
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB58305BFE4E950AB3D2552102FA1E0@BYAPR04MB5830.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-forefront-prvs: 00514A2FE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(376002)(136003)(174864002)(189003)(199004)(68736007)(71200400001)(71190400001)(2616005)(11346002)(446003)(14444005)(46003)(14454004)(6512007)(25786009)(476003)(256004)(82746002)(83716004)(72206003)(33656002)(966005)(6246003)(66476007)(478600001)(2906002)(66556008)(486006)(2501003)(6306002)(53936002)(6116002)(6506007)(53546011)(66446008)(66946007)(8936002)(6486002)(86362001)(64756008)(5660300002)(305945005)(73956011)(4326008)(36756003)(76116006)(110136005)(91956017)(2201001)(30864003)(76176011)(99286004)(8676002)(186003)(7736002)(229853002)(6436002)(102836004)(316002)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5830;H:BYAPR04MB3782.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IfgxPK8sTNuniVJEhxrH8XI+xsVNEBAoiU9TuJ77yhkCofcAhWG3XWhq+9T6Sje7vA9LDyXSHGjCPBoQdApxCufqwTuaEtYXX8VWc1jGX5rO1kLxbLLeNn7edTqMJ8SBthwWz3pbPMTz0wm13PwcO0RF8D5mj4N1GthqM84vj1pg0sjcln8NRq2tB2xSf9ZfmmyJ54j/z9n6o5Fk6XzFijUh4cmglcbBvWNtgTA8HXrxS8m/2/KzghvoRnyIa27yDvlX843wSBUyv4ZC5bVVA7wn13KsNFa0WTlbaRNjKwDsHHCzYKH+XK/Y6sMtzkQ4mx0gk4P8Q3mKfh0FH6BwlyVvHSSAvYDVOohyBDqn+/oZXbEyy/x6IOpagIXevKpZcnfkQsQ6Qq9l9Gs5HXbeIzxyRVltKf9qeezXTAwHiJg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8027677D07E86E4AA5833E7744A0EBC4@sharedspace.onmicrosoft.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5096fa-8c4d-4631-550f-08d6e3a41f56
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2019 19:38:55.7658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Atish.Patra@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 5/28/19 1:33 AM, Paul Walmsley wrote:
> An update for those testing RISC-V patches: here's a new branch of
> riscv-pk/bbl that doesn't try to read or modify the DT data at all, which
> should be useful until U-Boot settles down.  This new riscv-pk version
> should be easier to use than the previous version for those testing
> upstream-bound kernel DT data on SiFive hardware:
>    https://github.com/sifive/riscv-pk/tree/dev/paulw/configurable-machine=
-data-methods-v1
> To build a BBL that doesn't touch the DT data, use the
> "--with-config-method=3Dhifive_unleashed" switch for the "configure" scri=
pt.
> As before, this version of riscv-pk can take a DTB that can be passed
> along to the kernel.  But this time the path to the DTB can be specified
> on the "configure" script command line.
> Below is an example of how to configure it.  (The directory structure
> should be familiar to those using the v1_0 tag of freedom-u-sdk, with the
> kernel source in ./linux, riscv-pk source in ./riscv-pk, and build trees
> in work/{linux,riscv-pk}.)
>    cd work/riscv-pk
>    CC=3D/opt/rv64gc-mmu-linux-8.2.0/bin/riscv64-unknown-linux-gnu-gcc ../=
../riscv-pk/configure \
>                 --host=3Driscv64-unknown-linux-gnu \
>                 --with-payload=3D../../work/linux/vmlinux-stripped \
>                 --with-config-method=3Dhifive_unleashed \
>                 --enable-dtb \
>                 --with-dtb-path=3D../../work/linux/arch/riscv/boot/dts/si=
five/hifive-unleashed-a00.dtb
>   Here is an Linux kernel branch with updated DT data that can be booted
> with the above bootloader:
>    https://github.com/sifive/riscv-linux/tree/dev/paulw/dts-v5.2-rc1-expe=
rimental

Hi Paul,
I see your branch has the DT where the hart0 is marked disabled and M-mode =
interrupts are masked in PLIC DT entry. IIRC, your v1 patch series for DT d=
idn't have those fixes.

I am assuming that you are planning to upstream these changes as well and i=
t will be part of your v2 patch. Is that correct ?

> A sample boot log follows, using a 'defconfig' build from that branch.
> - Paul
> iFive FSBL:       2019-04-22-1081db9
> Using FSBL DTB
> HiFive-U serial #: 0000002d
> Loading boot payload................................
> bbl loader
> Relocated DTB from 0000000080007040 to 0000000083200000
> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> [    0.000000] Linux version 5.2.0-rc1-00006-ge4a86563f655 (paulw@viisi) =
(gcc version 8.2.0 (GCC)) #65 SMP Mon May 27 23:36:33 PDT 2019
> [    0.000000] earlycon: sifive0 at MMIO 0x0000000010010000 (options '')
> [    0.000000] printk: bootconsole [sifive0] enabled
> [    0.000000] printk: debug: ignoring loglevel setting.
> [    0.000000] initrd not found or empty - disabling initrd
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000027fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080200000-0x000000027fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x000000027ff=
fffff]
> [    0.000000] On node 0 totalpages: 2096640
> [    0.000000]   DMA32 zone: 7161 pages used for memmap
> [    0.000000]   DMA32 zone: 0 pages reserved
> [    0.000000]   DMA32 zone: 523776 pages, LIFO batch:63
> [    0.000000]   Normal zone: 21504 pages used for memmap
> [    0.000000]   Normal zone: 1572864 pages, LIFO batch:63
> [    0.000000] software IO TLB: mapped [mem 0xfbfff000-0xfffff000] (64MB)
> [    0.000000] CPU with hartid=3D0 is not available
> [    0.000000] CPU with hartid=3D0 is not available
> [    0.000000] elf_hwcap is 0x112d
> [    0.000000] percpu: Embedded 17 pages/cpu s30184 r8192 d31256 u69632
> [    0.000000] pcpu-alloc: s30184 r8192 d31256 u69632 alloc=3D17*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 206=
7975
> [    0.000000] Kernel command line: earlycon=3Dsifive,0x10010000 console=
=3DttySIF0,115200 ignore_loglevel debug root=3D/dev/ram0
> [    0.000000] Dentry cache hash table entries: 1048576 (order: 11, 83886=
08 bytes)
> [    0.000000] Inode-cache hash table entries: 524288 (order: 10, 4194304=
 bytes)
> [    0.000000] Sorting __ex_table...
> [    0.000000] Memory: 8178620K/8386560K available (5806K kernel code, 39=
5K rwdata, 1851K rodata, 5853K init, 806K bss, 207940K reserved, 0K cma-res=
erved)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4,=
 Nodes=3D1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_i=
ds=3D4.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is=
 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D4
> [    0.000000] NR_IRQS: 0, nr_irqs: 0, preallocated irqs: 0
> [    0.000000] plic: mapped 53 interrupts with 4 handlers for 9 contexts.
> [    0.000000] riscv_timer_init_dt: Registering clocksource cpuid [0] har=
tid [3]
> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff m=
ax_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns
> [    0.000006] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps =
every 2199023255500ns
> [    0.008456] Console: colour dummy device 80x25
> [    0.012813] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 2.00 BogoMIPS (lpj=3D4000)
> [    0.022841] pid_max: default: 32768 minimum: 301
> [    0.027939] Mount-cache hash table entries: 16384 (order: 5, 131072 by=
tes)
> [    0.034634] Mountpoint-cache hash table entries: 16384 (order: 5, 1310=
72 bytes)
> [    0.042315] *** VALIDATE proc ***
> [    0.045010] *** VALIDATE cgroup1 ***
> [    0.048462] *** VALIDATE cgroup2 ***
> [    0.053000] rcu: Hierarchical SRCU implementation.
> [    0.057473] smp: Bringing up secondary CPUs ...
> [    0.063256] smp: Brought up 1 node, 4 CPUs
> [    0.068186] devtmpfs: initialized
> [    0.072404] random: get_random_u32 called from bucket_table_alloc.isra=
.10+0x4e/0x15e with crng_init=3D0
> [    0.081020] random: get_random_bytes called from setup_net+0x3a/0x1b8 =
with crng_init=3D0
> [    0.088974] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 7645041785100000 ns
> [    0.098480] futex hash table entries: 1024 (order: 4, 65536 bytes)
> [    0.105299] NET: Registered protocol family 16
> [    0.109683] random: get_random_bytes called from kcmp_cookies_init+0x1=
c/0x4a with crng_init=3D0
> [    0.129984] vgaarb: loaded
> [    0.132159] SCSI subsystem initialized
> [    0.135927] libata version 3.00 loaded.
> [    0.139630] usbcore: registered new interface driver usbfs
> [    0.144998] usbcore: registered new interface driver hub
> [    0.150360] usbcore: registered new device driver usb
> [    0.156037] clocksource: Switched to clocksource riscv_clocksource
> [    0.167530] NET: Registered protocol family 2
> [    0.171747] tcp_listen_portaddr_hash hash table entries: 4096 (order: =
5, 163840 bytes)
> [    0.179576] TCP established hash table entries: 65536 (order: 7, 52428=
8 bytes)
> [    0.188249] TCP bind hash table entries: 65536 (order: 9, 2097152 byte=
s)
> [    0.201277] TCP: Hash tables configured (established 65536 bind 65536)
> [    0.207506] UDP hash table entries: 4096 (order: 6, 393216 bytes)
> [    0.214439] UDP-Lite hash table entries: 4096 (order: 6, 393216 bytes)
> [    0.221731] NET: Registered protocol family 1
> [    0.225830] RPC: Registered named UNIX socket transport module.
> [    0.231226] RPC: Registered udp transport module.
> [    0.235906] RPC: Registered tcp transport module.
> [    0.240593] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    0.247018] PCI: CLS 0 bytes, default 64
> [    0.665279] workingset: timestamp_bits=3D62 max_order=3D21 bucket_orde=
r=3D0
> [    0.680212] NFS: Registering the id_resolver key type
> [    0.684561] Key type id_resolver registered
> [    0.688653] Key type id_legacy registered
> [    0.692654] nfs4filelayout_init: NFSv4 File Layout Driver Registering.=
..
> [    0.699720] NET: Registered protocol family 38
> [    0.703819] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 254)
> [    0.711145] io scheduler mq-deadline registered
> [    0.715653] io scheduler kyber registered
> [    0.757094] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> [    0.763685] 10010000.serial: ttySIF0 at MMIO 0x10010000 (irq =3D 4, ba=
se_baud =3D 0) is a SiFive UART v0
> [    0.772072] printk: console [ttySIF0] enabled
> [    0.772072] printk: console [ttySIF0] enabled
> [    0.780723] printk: bootconsole [sifive0] disabled
> [    0.780723] printk: bootconsole [sifive0] disabled
> [    0.790539] 10011000.serial: ttySIF1 at MMIO 0x10011000 (irq =3D 1, ba=
se_baud =3D 0) is a SiFive UART v0
> [    0.799641] [drm] radeon kernel modesetting enabled.
> [    0.813383] loop: module loaded
> [    0.816227] libphy: Fixed MDIO Bus: probed
> [    0.820345] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    0.825645] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    0.831647] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    0.838065] ehci-pci: EHCI PCI platform driver
> [    0.842520] ehci-platform: EHCI generic platform driver
> [    0.847757] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    0.853865] ohci-pci: OHCI PCI platform driver
> [    0.858329] ohci-platform: OHCI generic platform driver
> [    0.863771] usbcore: registered new interface driver uas
> [    0.868853] usbcore: registered new interface driver usb-storage
> [    0.874961] mousedev: PS/2 mouse device common for all mice
> [    0.880734] usbcore: registered new interface driver usbhid
> [    0.885901] usbhid: USB HID core driver
> [    0.890586] NET: Registered protocol family 10
> [    0.895181] Segment Routing with IPv6
> [    0.898160] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
> [    0.904576] NET: Registered protocol family 17
> [    0.908487] Key type dns_resolver registered
> [    0.913352] Warning: unable to open an initial console.
> [    0.933780] Freeing unused kernel memory: 5852K
> [    0.937543] This architecture does not have kernel memory protection.
> [    0.943960] Run /init as init process
> [    1.531025] random: dd: uninitialized urandom read (512 bytes read)
> [   16.657284] random: dropbear: uninitialized urandom read (32 bytes rea=
d)
> [   16.669210] _warn_unseeded_randomness: 11 callbacks suppressed
> [   16.669230] random: get_random_bytes called from tcp_fastopen_init_key=
_once+0x40/0x58 with crng_init=3D0
> [   16.686212] random: get_random_bytes called from load_elf_binary+0x7c0=
/0xca4 with crng_init=3D0
> Welcome to Buildroot
> buildroot login:
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv


--=20
Regards,
Atish
