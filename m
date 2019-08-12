Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48D3C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E02F20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfHLJmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:42:44 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:43593 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbfHLJmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:42:43 -0400
Received: from rabammel.molgen.mpg.de (rabammel.molgen.mpg.de [141.14.30.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id BE9ED2000C0B2;
        Mon, 12 Aug 2019 11:42:34 +0200 (CEST)
To:     =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        "x86@kernel.org" <x86@kernel.org>, kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Donald Buczek <buczek@molgen.mpg.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Crash kernel with 256 MB reserved memory runs into OOM condition
Message-ID: <d65e4a42-1962-78c6-1b5a-65cb70529d62@molgen.mpg.de>
Date:   Mon, 12 Aug 2019 11:42:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050606000201000303030004"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050606000201000303030004
Content-Type: multipart/mixed;
 boundary="------------ECD0E31B99966CE0B8D4CC98"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------ECD0E31B99966CE0B8D4CC98
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dear Linux folks,


On a Dell PowerEdge R7425 with two AMD EPYC 7601 (total 128 threads) and
1 TB RAM, the crash kernel with 256 MB of space reserved crashes.

Please find the messages of the normal and the crash kernel attached.

```
[=E2=80=A6]
[    4.319253] iommu: Adding device 0000:06:00.2 to group 5
[    4.325869] iommu: Adding device 0000:20:01.0 to group 15
[    4.332648] iommu: Adding device 0000:20:02.0 to group 16
[    4.338946] swapper/0 invoked oom-killer: gfp_mask=3D0x6040c0(GFP_KERN=
EL|__GFP_COMP), nodemask=3D(null), order=3D0, oom_score_adj=3D0
[    4.350251] swapper/0 cpuset=3D/ mems_allowed=3D0
[    4.354618] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.57.mx64.282=
 #1
[    4.355612] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.9.=
3 06/25/2019
[    4.355612] Call Trace:
[    4.355612]  dump_stack+0x46/0x5b
[    4.355612]  dump_header+0x6b/0x289
[    4.355612]  ? try_to_free_pages+0xcf/0x1c0
[    4.355612]  out_of_memory+0x470/0x4c0
[    4.355612]  __alloc_pages_nodemask+0x970/0x1030
[    4.355612]  cache_grow_begin+0x7d/0x520
[    4.355612]  fallback_alloc+0x148/0x200
[    4.355612]  kmem_cache_alloc_trace+0xac/0x1f0
[    4.355612]  init_iova_domain+0x112/0x170
[    4.355612]  amd_iommu_domain_alloc+0x138/0x1a0
[    4.355612]  iommu_group_get_for_dev+0xc4/0x1a0
[    4.355612]  amd_iommu_add_device+0x13a/0x610
[    4.355612]  ? iommu_group_alloc+0x180/0x180
[    4.355612]  ? set_debug_rodata+0x11/0x11
[    4.355612]  add_iommu_group+0x20/0x30
[    4.355612]  bus_for_each_dev+0x76/0xc0
[    4.355612]  ? down_write+0xe/0x40
[    4.355612]  bus_set_iommu+0xb6/0xf0
[    4.355612]  amd_iommu_init_api+0x112/0x132
[    4.355612]  state_next+0xfb1/0x1165
[    4.355612]  ? set_debug_rodata+0x11/0x11
[    4.355612]  amd_iommu_init+0x1f/0x67
[    4.355612]  ? e820__memblock_setup+0x60/0x60
[    4.355612]  pci_iommu_init+0x16/0x3f
[    4.355612]  do_one_initcall+0x4f/0x1d0
[    4.355612]  ? set_debug_rodata+0x11/0x11
[    4.355612]  kernel_init_freeable+0x1ee/0x27f
[    4.355612]  ? rest_init+0xb0/0xb0
[    4.355612]  kernel_init+0xa/0x110
[    4.355612]  ret_from_fork+0x22/0x40
[    4.489484] Mem-Info:
[    4.491778] active_anon:0 inactive_anon:0 isolated_anon:0
[    4.491778]  active_file:0 inactive_file:0 isolated_file:0
[    4.491778]  unevictable:3930 dirty:0 writeback:0 unstable:0
[    4.491778]  slab_reclaimable:2367 slab_unreclaimable:17814
[    4.491778]  mapped:0 shmem:0 pagetables:0 bounce:0
[    4.491778]  free:472 free_pcp:53 free_cma:0
[    4.522929] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB i=
nactive_file:0kB unevictable:15720kB isolated(anon):0kB isolated(file):0k=
B mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdma=
pped: 0kB anon_thp: 0kB writeback_tmp:0kB unstable:0kB all_unreclaimable?=
 no
[    4.548703] Node 0 DMA free:484kB min:4kB low:4kB high:4kB active_anon=
:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB =
writepending:0kB present:568kB managed:484kB mlocked:0kB kernel_stack:0kB=
 pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[    4.573612] lowmem_reserve[]: 0 125 125 125
[    4.577799] Node 0 DMA32 free:1404kB min:1428kB low:1784kB high:2140kB=
 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unev=
ictable:15720kB writepending:0kB present:261560kB managed:133752kB mlocke=
d:0kB kernel_stack:2496kB pagetables:0kB bounce:0kB free_pcp:212kB local_=
pcp:212kB free_cma:0kB
[    4.605221] lowmem_reserve[]: 0 0 0 0
[    4.608887] Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 1*64kB (U) 1=
*128kB (U) 1*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 484kB
[    4.621056] Node 0 DMA32: 9*4kB (UM) 1*8kB (U) 15*16kB (UM) 1*32kB (M)=
 17*64kB (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 1404=
kB
[    4.633918] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_su=
rp=3D0 hugepages_size=3D2048kB
[    4.642350] 3943 total pagecache pages
[    4.646106] 0 pages in swap cache
[    4.649424] Swap cache stats: add 0, delete 0, find 0/0
[    4.654651] Free swap  =3D 0kB
[    4.657536] Total swap =3D 0kB
[    4.660422] 65532 pages RAM
[    4.663219] 0 pages HighMem/MovableOnly
[    4.667061] 31973 pages reserved
[    4.670295] Unreclaimable slab info:
[    4.673874] Name                      Used          Total
[    4.679277] tcp_bind_bucket           29KB         32KB
[    4.684514] RAW                      240KB        240KB
[    4.689752] hugetlbfs_inode_cache          0KB          3KB
[    4.695333] biovec-max                32KB         32KB
[    4.700565] uid_cache                  0KB          3KB
[    4.705799] skbuff_head_cache          3KB          4KB
[    4.711033] shmem_inode_cache         56KB         59KB
[    4.716267] proc_dir_entry            40KB         43KB
[    4.721502] kernfs_node_cache       2420KB       2424KB
[    4.726737] mnt_cache                  4KB          7KB
[    4.731970] filp                       1KB          4KB
[    4.737197] names_cache              420KB        440KB
[    4.742425] fs_cache                   8KB         11KB
[    4.747656] files_cache               88KB         90KB
[    4.752887] signal_cache             166KB        171KB
[    4.758118] sighand_cache            321KB        321KB
[    4.763346] task_struct              516KB        516KB
[    4.768571] cred_jar                  29KB         31KB
[    4.773796] anon_vma_chain             9KB         12KB
[    4.779026] pid                        3KB          4KB
[    4.784261] Acpi-Operand             527KB        531KB
[    4.789494] Acpi-Parse                26KB         31KB
[    4.794721] Acpi-State                37KB         43KB
[    4.799946] Acpi-Namespace            98KB        100KB
[    4.805173] numa_policy                3KB          3KB
[    4.810399] trace_event_file         145KB        146KB
[    4.815626] ftrace_event_field        151KB        151KB
[    4.820948] pool_workqueue             4KB          4KB
[    4.826202] kmalloc-262144           256KB        256KB
[    4.831433] kmalloc-65536            128KB        128KB
[    4.836659] kmalloc-32768             64KB         64KB
[    4.841885] kmalloc-16384             48KB         48KB
[    4.847112] kmalloc-8192              80KB         80KB
[    4.852339] kmalloc-4096            2700KB       2700KB
[    4.857565] kmalloc-2048           59164KB      59164KB
[    4.862793] kmalloc-1024             705KB        708KB
[    4.868026] kmalloc-512              185KB        188KB
[    4.873251] kmalloc-256               84KB         88KB
[    4.878479] kmalloc-192              255KB        255KB
[    4.883706] kmalloc-96               177KB        180KB
[    4.888939] kmalloc-64               519KB        520KB
[    4.894165] kmalloc-32               230KB        232KB
[    4.899391] kmalloc-128              871KB        872KB
[    4.904617] kmem_cache                32KB         33KB
[    4.909842] Tasks state (memory values in pages):
[    4.914547] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swa=
pents oom_score_adj name
[    4.923156] Out of memory and no killable processes...
[=E2=80=A6]
```

Is on big server systems really more reserved memory needed, or is that
maybe something which can be fixed in the Linux kernel?


Kind regards,

Paul


PS: No idea, if the output below is helpful.

```
$ lspci -nn
00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Root Complex [1022:1450]
00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Family 17h (Mode=
ls 00h-0fh) I/O Memory Management Unit [1022:1451]
00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) PCIe GPP Bridge [1022:1453]
00:01.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) PCIe GPP Bridge [1022:1453]
00:01.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) PCIe GPP Bridge [1022:1453]
00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Contro=
ller [1022:790b] (rev 59)
00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bri=
dge [1022:790e] (rev 51)
00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric Device 18h Function 6 [1022:1466]
00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
00:19.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
00:19.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
00:19.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
00:19.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
00:19.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
00:19.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
00:19.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric Device 18h Function 6 [1022:1466]
00:19.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
00:1a.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
00:1a.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
00:1a.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
00:1a.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
00:1a.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
00:1a.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
00:1a.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric Device 18h Function 6 [1022:1466]
00:1a.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
00:1b.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
00:1b.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
00:1b.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
00:1b.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
00:1b.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
00:1b.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
00:1b.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric Device 18h Function 6 [1022:1466]
00:1b.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
00:1c.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
00:1c.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
00:1c.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
00:1c.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
00:1c.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
00:1c.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
00:1c.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric Device 18h Function 6 [1022:1466]
00:1c.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
00:1d.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
00:1d.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
00:1d.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
00:1d.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
00:1d.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
00:1d.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
00:1d.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric Device 18h Function 6 [1022:1466]
00:1d.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
00:1e.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
00:1e.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
00:1e.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
00:1e.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
00:1e.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
00:1e.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
00:1e.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric Device 18h Function 6 [1022:1466]
00:1e.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
00:1f.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 0 [1022:1460]
00:1f.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 1 [1022:1461]
00:1f.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 2 [1022:1462]
00:1f.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 3 [1022:1463]
00:1f.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 4 [1022:1464]
00:1f.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 5 [1022:1465]
00:1f.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric Device 18h Function 6 [1022:1466]
00:1f.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Data Fabric: Device 18h; Function 7 [1022:1467]
01:00.0 Ethernet controller [0200]: Intel Corporation 82599ES 10-Gigabit =
SFI/SFP+ Network Connection [8086:10fb] (rev 01)
01:00.1 Ethernet controller [0200]: Intel Corporation 82599ES 10-Gigabit =
SFI/SFP+ Network Connection [8086:10fb] (rev 01)
02:00.0 PCI bridge [0604]: PLDA Device [1556:be00] (rev 02)
03:00.0 VGA compatible controller [0300]: Matrox Electronics Systems Ltd.=
 Integrated Matrox G200eW3 Graphics Controller [102b:0536] (rev 04)
04:00.0 Ethernet controller [0200]: Intel Corporation I350 Gigabit Networ=
k Connection [8086:1521] (rev 01)
04:00.1 Ethernet controller [0200]: Intel Corporation I350 Gigabit Networ=
k Connection [8086:1521] (rev 01)
05:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:145a]
05:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Family 17h (Models 00h-0fh) Platform Security Processor [1022:1456]
05:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] USB 3.0=
 Host controller [1022:145f]
06:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:1455]
06:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:1468]
06:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SA=
TA Controller [AHCI mode] [1022:7901] (rev 51)
20:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Root Complex [1022:1450]
20:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Family 17h (Mode=
ls 00h-0fh) I/O Memory Management Unit [1022:1451]
20:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
20:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
20:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
20:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
20:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
20:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
20:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
20:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
21:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:145a]
21:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Family 17h (Models 00h-0fh) Platform Security Processor [1022:1456]
21:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] USB 3.0=
 Host controller [1022:145f]
22:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:1455]
22:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:1468]
40:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Root Complex [1022:1450]
40:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Family 17h (Mode=
ls 00h-0fh) I/O Memory Management Unit [1022:1451]
40:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
40:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
40:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
40:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
40:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
40:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
40:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
40:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
41:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:145a]
41:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Family 17h (Models 00h-0fh) Platform Security Processor [1022:1456]
42:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:1455]
42:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:1468]
60:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Root Complex [1022:1450]
60:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Family 17h (Mode=
ls 00h-0fh) I/O Memory Management Unit [1022:1451]
60:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
60:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
60:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
60:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) PCIe GPP Bridge [1022:1453]
60:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
60:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
60:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
60:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
60:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
61:00.0 Serial Attached SCSI controller [0107]: LSI Logic / Symbios Logic=
 MegaRAID Tri-Mode SAS3508 [1000:0016] (rev 01)
62:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:145a]
62:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Family 17h (Models 00h-0fh) Platform Security Processor [1022:1456]
63:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:1455]
63:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:1468]
80:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Root Complex [1022:1450]
80:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Family 17h (Mode=
ls 00h-0fh) I/O Memory Management Unit [1022:1451]
80:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
80:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
80:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
80:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
80:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
80:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
80:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
80:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
81:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:145a]
81:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Family 17h (Models 00h-0fh) Platform Security Processor [1022:1456]
82:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:1455]
82:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:1468]
a0:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Root Complex [1022:1450]
a0:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Family 17h (Mode=
ls 00h-0fh) I/O Memory Management Unit [1022:1451]
a0:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
a0:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
a0:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
a0:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
a0:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
a0:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
a0:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
a0:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
a1:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:145a]
a1:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Family 17h (Models 00h-0fh) Platform Security Processor [1022:1456]
a2:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:1455]
a2:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:1468]
c0:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Root Complex [1022:1450]
c0:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Family 17h (Mode=
ls 00h-0fh) I/O Memory Management Unit [1022:1451]
c0:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
c0:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
c0:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
c0:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
c0:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
c0:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
c0:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
c0:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
c1:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:145a]
c1:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Family 17h (Models 00h-0fh) Platform Security Processor [1022:1456]
c2:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:1455]
c2:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:1468]
e0:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) Root Complex [1022:1450]
e0:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Family 17h (Mode=
ls 00h-0fh) I/O Memory Management Unit [1022:1451]
e0:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
e0:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
e0:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
e0:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
e0:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
e0:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
e0:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Family 17h=
 (Models 00h-0fh) PCIe Dummy Host Bridge [1022:1452]
e0:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Family 17h =
(Models 00h-0fh) Internal PCIe GPP Bridge 0 to Bus B [1022:1454]
e1:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:145a]
e1:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Family 17h (Models 00h-0fh) Platform Security Processor [1022:1456]
e2:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc=
=2E [AMD] Device [1022:1455]
e2:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] =
Device [1022:1468]
```

--------------ECD0E31B99966CE0B8D4CC98
Content-Type: text/x-log;
 name="ttyS0.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="ttyS0.log"

Linux version 4.19.57.mx64.282 (root@theinternet.molgen.mpg.de) (gcc vers=
ion 7.3.0 (GCC)) #1 SMP Thu Aug 1 13:01:42 CEST 2019
[    0.000000] Command line: BOOT_IMAGE=3D/boot/bzImage-4.19.57.mx64.282 =
crashkernel=3D256M root=3DLABEL=3Droot ro console=3DttyS1,115200n8 consol=
e=3Dtty0 init=3D/bin/systemd audit=3D0
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poi=
nt registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 =
bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACP=
I NVS
[    0.000000] BIOS-e820: [mem 0x0000000000090000-0x000000000009ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000006cacefff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000006cacf000-0x000000006cbcefff] res=
erved
[    0.000000] BIOS-e820: [mem 0x000000006cbcf000-0x000000006cdcefff] typ=
e 20
[    0.000000] BIOS-e820: [mem 0x000000006cdcf000-0x000000006efcefff] res=
erved
[    0.000000] BIOS-e820: [mem 0x000000006efcf000-0x000000006fdfefff] ACP=
I NVS
[    0.000000] BIOS-e820: [mem 0x000000006fdff000-0x000000006fffefff] ACP=
I data
[    0.000000] BIOS-e820: [mem 0x000000006ffff000-0x000000006fffffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x0000000070000000-0x000000008fffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fec10000-0x00000000fec10fff] res=
erved
[    0.000000] BIOS-e820: [mem 0x00000000fed80000-0x00000000fed80fff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000207f37ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000207f380000-0x000000207fffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000002080000000-0x000000407ff7ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000407ff80000-0x000000407fffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000004080000000-0x000000607ff7ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000607ff80000-0x000000607fffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000006080000000-0x000000807ff7ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000807ff80000-0x000000807fffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x0000008080000000-0x000000a07ff7ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000a07ff80000-0x000000a07fffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x000000a080000000-0x000000c07ff7ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000c07ff80000-0x000000c07fffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x000000c080000000-0x000000e07ff7ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000e07ff80000-0x000000e07fffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x000000e080000000-0x000000fcffffffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000fd00000000-0x000000fdffffffff] res=
erved
[    0.000000] BIOS-e820: [mem 0x000000fe00000000-0x000001007ff7ffff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000001007ff80000-0x000001007fffffff] res=
erved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.50 by Dell Inc.
[    0.000000] efi:  ACPI=3D0x6fffe000  ACPI 2.0=3D0x6fffe014  SMBIOS=3D0=
x6eab2000  SMBIOS 3.0=3D0x6eab0000=20
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: Dell Inc. PowerEdge R7425/08V001, BIOS 1.9.3 06/25/20=
19
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2195.834 MHz processor
[    0.000046] last_pfn =3D 0x1007ff80 max_arch_pfn =3D 0x400000000
[    0.000724] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT =20
[    0.001011] last_pfn =3D 0x70000 max_arch_pfn =3D 0x400000000
[    0.006203] Using GB pages for direct mapping
[    0.007074] Secure boot could not be determined
[    0.007076] RAMDISK: [mem 0x375e7000-0x37aeafff]
[    0.007083] ACPI: Early table checksum verification disabled
[    0.007088] ACPI: RSDP 0x000000006FFFE014 000024 (v02 DELL  )
[    0.007092] ACPI: XSDT 0x000000006FFFD0E8 0000AC (v01 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007099] ACPI: FACP 0x000000006FFEB000 000114 (v06 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007105] ACPI: DSDT 0x000000006FFDA000 00D6D3 (v02 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007109] ACPI: FACS 0x000000006FDC8000 000040
[    0.007112] ACPI: SSDT 0x000000006FFFC000 0000D2 (v02 DELL   PE_SC3   =
00000002 MSFT 04000000)
[    0.007115] ACPI: BERT 0x000000006FFFB000 000030 (v01 DELL   BERT     =
00000001 DELL 00000001)
[    0.007118] ACPI: HEST 0x000000006FFFA000 0006DC (v01 DELL   HEST     =
00000001 DELL 00000001)
[    0.007121] ACPI: SSDT 0x000000006FFF9000 0006A4 (v01 DELL   PE_SC3   =
00000001 AMD  00000001)
[    0.007124] ACPI: SRAT 0x000000006FFF8000 0009C0 (v03 DELL   PE_SC3   =
00000001 AMD  00000001)
[    0.007127] ACPI: MSCT 0x000000006FFF7000 00004E (v01 DELL   PE_SC3   =
00000000 AMD  00000001)
[    0.007130] ACPI: SLIT 0x000000006FFF6000 00006C (v01 DELL   PE_SC3   =
00000001 AMD  00000001)
[    0.007133] ACPI: CRAT 0x000000006FFEE000 007700 (v01 DELL   PE_SC3   =
00000001 AMD  00000001)
[    0.007136] ACPI: EINJ 0x000000006FFED000 000150 (v01 DELL   PE_SC3   =
00000001 AMD  00000001)
[    0.007138] ACPI: SLIC 0x000000006FFEC000 000024 (v01 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007142] ACPI: HPET 0x000000006FFEA000 000038 (v01 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007144] ACPI: APIC 0x000000006FFE9000 0004B2 (v03 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007147] ACPI: MCFG 0x000000006FFE8000 00003C (v01 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007150] ACPI: SSDT 0x000000006FFD9000 0005CA (v02 DELL   xhc_port =
00000001 INTL 20170119)
[    0.007153] ACPI: IVRS 0x000000006FFD8000 000370 (v02 DELL   PE_SC3   =
00000001 AMD  00000000)
[    0.007156] ACPI: SSDT 0x000000006FFD6000 001658 (v01 AMD    CPMCMN   =
00000001 INTL 20170119)
[    0.007209] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.007210] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.007211] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.007212] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.007213] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.007214] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.007214] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.007215] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.007216] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.007217] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.007218] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.007218] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.007219] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.007220] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.007221] SRAT: PXM 0 -> APIC 0x0e -> Node 0
[    0.007222] SRAT: PXM 0 -> APIC 0x0f -> Node 0
[    0.007222] SRAT: PXM 1 -> APIC 0x10 -> Node 1
[    0.007223] SRAT: PXM 1 -> APIC 0x11 -> Node 1
[    0.007224] SRAT: PXM 1 -> APIC 0x12 -> Node 1
[    0.007225] SRAT: PXM 1 -> APIC 0x13 -> Node 1
[    0.007226] SRAT: PXM 1 -> APIC 0x14 -> Node 1
[    0.007227] SRAT: PXM 1 -> APIC 0x15 -> Node 1
[    0.007227] SRAT: PXM 1 -> APIC 0x16 -> Node 1
[    0.007228] SRAT: PXM 1 -> APIC 0x17 -> Node 1
[    0.007229] SRAT: PXM 1 -> APIC 0x18 -> Node 1
[    0.007230] SRAT: PXM 1 -> APIC 0x19 -> Node 1
[    0.007230] SRAT: PXM 1 -> APIC 0x1a -> Node 1
[    0.007231] SRAT: PXM 1 -> APIC 0x1b -> Node 1
[    0.007232] SRAT: PXM 1 -> APIC 0x1c -> Node 1
[    0.007233] SRAT: PXM 1 -> APIC 0x1d -> Node 1
[    0.007234] SRAT: PXM 1 -> APIC 0x1e -> Node 1
[    0.007234] SRAT: PXM 1 -> APIC 0x1f -> Node 1
[    0.007235] SRAT: PXM 2 -> APIC 0x20 -> Node 2
[    0.007236] SRAT: PXM 2 -> APIC 0x21 -> Node 2
[    0.007237] SRAT: PXM 2 -> APIC 0x22 -> Node 2
[    0.007238] SRAT: PXM 2 -> APIC 0x23 -> Node 2
[    0.007238] SRAT: PXM 2 -> APIC 0x24 -> Node 2
[    0.007239] SRAT: PXM 2 -> APIC 0x25 -> Node 2
[    0.007240] SRAT: PXM 2 -> APIC 0x26 -> Node 2
[    0.007241] SRAT: PXM 2 -> APIC 0x27 -> Node 2
[    0.007241] SRAT: PXM 2 -> APIC 0x28 -> Node 2
[    0.007242] SRAT: PXM 2 -> APIC 0x29 -> Node 2
[    0.007243] SRAT: PXM 2 -> APIC 0x2a -> Node 2
[    0.007244] SRAT: PXM 2 -> APIC 0x2b -> Node 2
[    0.007245] SRAT: PXM 2 -> APIC 0x2c -> Node 2
[    0.007245] SRAT: PXM 2 -> APIC 0x2d -> Node 2
[    0.007246] SRAT: PXM 2 -> APIC 0x2e -> Node 2
[    0.007247] SRAT: PXM 2 -> APIC 0x2f -> Node 2
[    0.007248] SRAT: PXM 3 -> APIC 0x30 -> Node 3
[    0.007249] SRAT: PXM 3 -> APIC 0x31 -> Node 3
[    0.007249] SRAT: PXM 3 -> APIC 0x32 -> Node 3
[    0.007250] SRAT: PXM 3 -> APIC 0x33 -> Node 3
[    0.007251] SRAT: PXM 3 -> APIC 0x34 -> Node 3
[    0.007252] SRAT: PXM 3 -> APIC 0x35 -> Node 3
[    0.007252] SRAT: PXM 3 -> APIC 0x36 -> Node 3
[    0.007253] SRAT: PXM 3 -> APIC 0x37 -> Node 3
[    0.007254] SRAT: PXM 3 -> APIC 0x38 -> Node 3
[    0.007255] SRAT: PXM 3 -> APIC 0x39 -> Node 3
[    0.007256] SRAT: PXM 3 -> APIC 0x3a -> Node 3
[    0.007256] SRAT: PXM 3 -> APIC 0x3b -> Node 3
[    0.007257] SRAT: PXM 3 -> APIC 0x3c -> Node 3
[    0.007258] SRAT: PXM 3 -> APIC 0x3d -> Node 3
[    0.007259] SRAT: PXM 3 -> APIC 0x3e -> Node 3
[    0.007259] SRAT: PXM 3 -> APIC 0x3f -> Node 3
[    0.007260] SRAT: PXM 4 -> APIC 0x40 -> Node 4
[    0.007261] SRAT: PXM 4 -> APIC 0x41 -> Node 4
[    0.007262] SRAT: PXM 4 -> APIC 0x42 -> Node 4
[    0.007263] SRAT: PXM 4 -> APIC 0x43 -> Node 4
[    0.007263] SRAT: PXM 4 -> APIC 0x44 -> Node 4
[    0.007264] SRAT: PXM 4 -> APIC 0x45 -> Node 4
[    0.007265] SRAT: PXM 4 -> APIC 0x46 -> Node 4
[    0.007266] SRAT: PXM 4 -> APIC 0x47 -> Node 4
[    0.007267] SRAT: PXM 4 -> APIC 0x48 -> Node 4
[    0.007267] SRAT: PXM 4 -> APIC 0x49 -> Node 4
[    0.007268] SRAT: PXM 4 -> APIC 0x4a -> Node 4
[    0.007269] SRAT: PXM 4 -> APIC 0x4b -> Node 4
[    0.007270] SRAT: PXM 4 -> APIC 0x4c -> Node 4
[    0.007270] SRAT: PXM 4 -> APIC 0x4d -> Node 4
[    0.007271] SRAT: PXM 4 -> APIC 0x4e -> Node 4
[    0.007272] SRAT: PXM 4 -> APIC 0x4f -> Node 4
[    0.007273] SRAT: PXM 5 -> APIC 0x50 -> Node 5
[    0.007274] SRAT: PXM 5 -> APIC 0x51 -> Node 5
[    0.007274] SRAT: PXM 5 -> APIC 0x52 -> Node 5
[    0.007275] SRAT: PXM 5 -> APIC 0x53 -> Node 5
[    0.007276] SRAT: PXM 5 -> APIC 0x54 -> Node 5
[    0.007277] SRAT: PXM 5 -> APIC 0x55 -> Node 5
[    0.007278] SRAT: PXM 5 -> APIC 0x56 -> Node 5
[    0.007278] SRAT: PXM 5 -> APIC 0x57 -> Node 5
[    0.007279] SRAT: PXM 5 -> APIC 0x58 -> Node 5
[    0.007280] SRAT: PXM 5 -> APIC 0x59 -> Node 5
[    0.007281] SRAT: PXM 5 -> APIC 0x5a -> Node 5
[    0.007281] SRAT: PXM 5 -> APIC 0x5b -> Node 5
[    0.007282] SRAT: PXM 5 -> APIC 0x5c -> Node 5
[    0.007283] SRAT: PXM 5 -> APIC 0x5d -> Node 5
[    0.007284] SRAT: PXM 5 -> APIC 0x5e -> Node 5
[    0.007285] SRAT: PXM 5 -> APIC 0x5f -> Node 5
[    0.007285] SRAT: PXM 6 -> APIC 0x60 -> Node 6
[    0.007286] SRAT: PXM 6 -> APIC 0x61 -> Node 6
[    0.007287] SRAT: PXM 6 -> APIC 0x62 -> Node 6
[    0.007288] SRAT: PXM 6 -> APIC 0x63 -> Node 6
[    0.007289] SRAT: PXM 6 -> APIC 0x64 -> Node 6
[    0.007289] SRAT: PXM 6 -> APIC 0x65 -> Node 6
[    0.007290] SRAT: PXM 6 -> APIC 0x66 -> Node 6
[    0.007291] SRAT: PXM 6 -> APIC 0x67 -> Node 6
[    0.007292] SRAT: PXM 6 -> APIC 0x68 -> Node 6
[    0.007292] SRAT: PXM 6 -> APIC 0x69 -> Node 6
[    0.007293] SRAT: PXM 6 -> APIC 0x6a -> Node 6
[    0.007294] SRAT: PXM 6 -> APIC 0x6b -> Node 6
[    0.007295] SRAT: PXM 6 -> APIC 0x6c -> Node 6
[    0.007296] SRAT: PXM 6 -> APIC 0x6d -> Node 6
[    0.007296] SRAT: PXM 6 -> APIC 0x6e -> Node 6
[    0.007297] SRAT: PXM 6 -> APIC 0x6f -> Node 6
[    0.007298] SRAT: PXM 7 -> APIC 0x70 -> Node 7
[    0.007299] SRAT: PXM 7 -> APIC 0x71 -> Node 7
[    0.007300] SRAT: PXM 7 -> APIC 0x72 -> Node 7
[    0.007300] SRAT: PXM 7 -> APIC 0x73 -> Node 7
[    0.007301] SRAT: PXM 7 -> APIC 0x74 -> Node 7
[    0.007302] SRAT: PXM 7 -> APIC 0x75 -> Node 7
[    0.007303] SRAT: PXM 7 -> APIC 0x76 -> Node 7
[    0.007303] SRAT: PXM 7 -> APIC 0x77 -> Node 7
[    0.007304] SRAT: PXM 7 -> APIC 0x78 -> Node 7
[    0.007305] SRAT: PXM 7 -> APIC 0x79 -> Node 7
[    0.007306] SRAT: PXM 7 -> APIC 0x7a -> Node 7
[    0.007307] SRAT: PXM 7 -> APIC 0x7b -> Node 7
[    0.007307] SRAT: PXM 7 -> APIC 0x7c -> Node 7
[    0.007308] SRAT: PXM 7 -> APIC 0x7d -> Node 7
[    0.007309] SRAT: PXM 7 -> APIC 0x7e -> Node 7
[    0.007310] SRAT: PXM 7 -> APIC 0x7f -> Node 7
[    0.007313] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.007314] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
[    0.007315] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
[    0.007317] ACPI: SRAT: Node 1 PXM 1 [mem 0x2080000000-0x407fffffff]
[    0.007318] ACPI: SRAT: Node 2 PXM 2 [mem 0x4080000000-0x607fffffff]
[    0.007319] ACPI: SRAT: Node 3 PXM 3 [mem 0x6080000000-0x807fffffff]
[    0.007320] ACPI: SRAT: Node 4 PXM 4 [mem 0x8080000000-0xa07fffffff]
[    0.007321] ACPI: SRAT: Node 5 PXM 5 [mem 0xa080000000-0xc07fffffff]
[    0.007322] ACPI: SRAT: Node 6 PXM 6 [mem 0xc080000000-0xe07fffffff]
[    0.007323] ACPI: SRAT: Node 7 PXM 7 [mem 0xe080000000-0x1007fffffff]
[    0.007331] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000=
-0x7fffffff] -> [mem 0x00000000-0x7fffffff]
[    0.007332] NUMA: Node 0 [mem 0x00000000-0x7fffffff] + [mem 0x10000000=
0-0x207fffffff] -> [mem 0x00000000-0x207fffffff]
[    0.007346] NODE_DATA(0) allocated [mem 0x207f37c000-0x207f37ffff]
[    0.007350] NODE_DATA(1) allocated [mem 0x407ff7c000-0x407ff7ffff]
[    0.007355] NODE_DATA(2) allocated [mem 0x607ff7c000-0x607ff7ffff]
[    0.007359] NODE_DATA(3) allocated [mem 0x807ff7c000-0x807ff7ffff]
[    0.007364] NODE_DATA(4) allocated [mem 0xa07ff7c000-0xa07ff7ffff]
[    0.007370] NODE_DATA(5) allocated [mem 0xc07ff7c000-0xc07ff7ffff]
[    0.007376] NODE_DATA(6) allocated [mem 0xe07ff7c000-0xe07ff7ffff]
[    0.007382] NODE_DATA(7) allocated [mem 0x1007ff7b000-0x1007ff7efff]
[    0.007398] Reserving 256MB of memory at 624MB for crashkernel (System=
 RAM: 1044154MB)
[    0.008195] Zone ranges:
[    0.008197]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.008199]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.008200]   Normal   [mem 0x0000000100000000-0x000001007ff7ffff]
[    0.008202] Movable zone start for each node
[    0.008203] Early memory node ranges
[    0.008204]   node   0: [mem 0x0000000000001000-0x000000000008efff]
[    0.008205]   node   0: [mem 0x0000000000090000-0x000000000009ffff]
[    0.008206]   node   0: [mem 0x0000000000100000-0x000000006cacefff]
[    0.008207]   node   0: [mem 0x000000006ffff000-0x000000006fffffff]
[    0.008208]   node   0: [mem 0x0000000100000000-0x000000207f37ffff]
[    0.008209]   node   1: [mem 0x0000002080000000-0x000000407ff7ffff]
[    0.008209]   node   2: [mem 0x0000004080000000-0x000000607ff7ffff]
[    0.008210]   node   3: [mem 0x0000006080000000-0x000000807ff7ffff]
[    0.008211]   node   4: [mem 0x0000008080000000-0x000000a07ff7ffff]
[    0.008212]   node   5: [mem 0x000000a080000000-0x000000c07ff7ffff]
[    0.008213]   node   6: [mem 0x000000c080000000-0x000000e07ff7ffff]
[    0.008214]   node   7: [mem 0x000000e080000000-0x000000fcffffffff]
[    0.008214]   node   7: [mem 0x000000fe00000000-0x000001007ff7ffff]
[    0.008220] Reserved but unavailable: 97 pages
[    0.008221] Initmem setup node 0 [mem 0x0000000000001000-0x000000207f3=
7ffff]
[    0.680857] Initmem setup node 1 [mem 0x0000002080000000-0x000000407ff=
7ffff]
[    1.357331] Initmem setup node 2 [mem 0x0000004080000000-0x000000607ff=
7ffff]
[    2.033602] Initmem setup node 3 [mem 0x0000006080000000-0x000000807ff=
7ffff]
[    2.709948] Initmem setup node 4 [mem 0x0000008080000000-0x000000a07ff=
7ffff]
[    3.405894] Initmem setup node 5 [mem 0x000000a080000000-0x000000c07ff=
7ffff]
[    4.101292] Initmem setup node 6 [mem 0x000000c080000000-0x000000e07ff=
7ffff]
[    4.786316] Initmem setup node 7 [mem 0x000000e080000000-0x000001007ff=
7ffff]
[    5.462442] ACPI: PM-Timer IO Port: 0x408
[    5.462469] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    5.462498] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GS=
I 0-23
[    5.462503] IOAPIC[1]: apic_id 129, version 33, address 0xfd880000, GS=
I 24-55
[    5.462509] IOAPIC[2]: apic_id 130, version 33, address 0xea900000, GS=
I 56-87
[    5.462515] IOAPIC[3]: apic_id 131, version 33, address 0xdd900000, GS=
I 88-119
[    5.462520] IOAPIC[4]: apic_id 132, version 33, address 0xd0900000, GS=
I 120-151
[    5.462527] IOAPIC[5]: apic_id 133, version 33, address 0xc3900000, GS=
I 152-183
[    5.462534] IOAPIC[6]: apic_id 134, version 33, address 0xb6900000, GS=
I 184-215
[    5.462540] IOAPIC[7]: apic_id 135, version 33, address 0xa9900000, GS=
I 216-247
[    5.462547] IOAPIC[8]: apic_id 136, version 33, address 0x9c900000, GS=
I 248-279
[    5.462550] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    5.462553] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)=

[    5.462558] Using ACPI (MADT) for SMP configuration information
[    5.462560] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    5.462569] smpboot: Allowing 128 CPUs, 0 hotplug CPUs
[    5.462640] [mem 0x90000000-0xfec0ffff] available for PCI devices
[    5.462647] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:=
 0xffffffff, max_idle_ns: 1910969940391419 ns
[    5.618760] random: get_random_bytes called from start_kernel+0x90/0x4=
ae with crng_init=3D0
[    5.618772] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:1=
28 nr_node_ids:8
[    5.627920] percpu: Embedded 43 pages/cpu s136536 r8192 d31400 u262144=

[    5.628106] Built 8 zonelists, mobility grouping on.  Total pages: 263=
109401
[    5.628108] Policy zone: Normal
[    5.628111] Kernel command line: BOOT_IMAGE=3D/boot/bzImage-4.19.57.mx=
64.282 crashkernel=3D256M root=3DLABEL=3Droot ro console=3DttyS1,115200n8=
 console=3Dtty0 init=3D/bin/systemd audit=3D0
[    5.628244] audit: disabled (until reboot)
[    5.628245] log_buf_len individual max cpu contribution: 4096 bytes
[    5.628246] log_buf_len total cpu_extra contributions: 520192 bytes
[    5.628247] log_buf_len min size: 131072 bytes
[    5.628482] log_buf_len: 1048576 bytes
[    5.628483] early log buf free: 108116(82%)
[    8.972056] Memory: 1051967552K/1069214136K available (14348K kernel c=
ode, 1414K rwdata, 3376K rodata, 1576K init, 1124K bss, 17246584K reserve=
d, 0K cma-reserved)
[    8.973978] ftrace: allocating 42115 entries in 165 pages
[    8.993596] rcu: Hierarchical RCU implementation.
[    8.993598] rcu: 	RCU event tracing is enabled.
[    8.993599] rcu: 	RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_id=
s=3D128.
[    8.993600] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D128
[    8.995692] NR_IRQS: 16640, nr_irqs: 5800, preallocated irqs: 16
[    9.001353] Console: colour dummy device 80x25
[    9.001755] console [tty0] enabled
[   10.664588] console [ttyS1] enabled
[   10.669058] ACPI: Core revision 20180810
[   10.673841] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 133484873504 ns
[   10.683008] APIC: Switch to symmetric I/O mode setup
[   10.687991] Switched APIC routing to physical flat.
[   10.695781] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[   10.706028] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycle=
s: 0x1fa6d33d5b6, max_idle_ns: 440795244173 ns
[   10.716549] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 4391.66 BogoMIPS (lpj=3D2195834)
[   10.717549] pid_max: default: 131072 minimum: 1024
[   10.795449] Dentry cache hash table entries: 33554432 (order: 16, 2684=
35456 bytes)
[   10.832165] Inode-cache hash table entries: 16777216 (order: 15, 13421=
7728 bytes)
[   10.833907] Mount-cache hash table entries: 524288 (order: 10, 4194304=
 bytes)
[   10.836081] Mountpoint-cache hash table entries: 524288 (order: 10, 41=
94304 bytes)
[   10.837976] LVT offset 2 assigned for vector 0xf4
[   10.838559] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[   10.839548] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB =
0
[   10.840550] Spectre V2 : Mitigation: Full AMD retpoline
[   10.841549] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling R=
SB on context switch
[   10.842549] Spectre V2 : mitigation: Enabling conditional Indirect Bra=
nch Prediction Barrier
[   10.843548] Spectre V2 : User space: Vulnerable
[   10.844549] Speculative Store Bypass: Mitigation: Speculative Store By=
pass disabled via prctl and seccomp
[   10.858473] Freeing SMP alternatives memory: 44K
[   10.862547] random: fast init done
[   10.862547] APIC calibration not consistent with PM-Timer: 101ms inste=
ad of 100ms
[   10.862547] APIC delta adjusted to PM-Timer: 623827 (636297)
[   10.862583] smpboot: CPU0: AMD EPYC 7601 32-Core Processor (family: 0x=
17, model: 0x1, stepping: 0x2)
[   10.863790] Performance Events: Fam17h core perfctr, AMD PMU driver.
[   10.864551] ... version:                0
[   10.865548] ... bit width:              48
[   10.866548] ... generic registers:      6
[   10.867548] ... value mask:             0000ffffffffffff
[   10.868548] ... max period:             00007fffffffffff
[   10.869548] ... fixed-purpose events:   0
[   10.870548] ... event mask:             000000000000003f
[   10.872659] rcu: Hierarchical SRCU implementation.
[   10.874646] MCE: In-kernel MCE decoding enabled.
[   10.877585] smp: Bringing up secondary CPUs ...
[   10.878805] x86: Booting SMP configuration:
[   10.879549] .... node  #4, CPUs:          #1
[    1.709859] do_IRQ: 1.55 No irq handler for vector
[   10.901165] .... node  #1, CPUs:     #2
[   10.903550] .... node  #5, CPUs:     #3
[   10.905551] .... node  #2, CPUs:     #4
[   10.908550] .... node  #6, CPUs:     #5
[   10.910551] .... node  #3, CPUs:     #6
[   10.913551] .... node  #7, CPUs:     #7
[   10.915552] .... node  #0, CPUs:     #8
[   10.918551] .... node  #4, CPUs:     #9
[   10.920551] .... node  #1, CPUs:    #10
[   10.923550] .... node  #5, CPUs:    #11
[   10.926552] .... node  #2, CPUs:    #12
[   10.929550] .... node  #6, CPUs:    #13
[   10.932551] .... node  #3, CPUs:    #14
[   10.934551] .... node  #7, CPUs:    #15
[   10.937551] .... node  #0, CPUs:    #16
[   10.940549] .... node  #4, CPUs:    #17
[   10.942551] .... node  #1, CPUs:    #18
[   10.945550] .... node  #5, CPUs:    #19
[   10.948552] .... node  #2, CPUs:    #20
[   10.950551] .... node  #6, CPUs:    #21
[   10.953551] .... node  #3, CPUs:    #22
[   10.955552] .... node  #7, CPUs:    #23
[   10.958552] .... node  #0, CPUs:    #24
[   10.961551] .... node  #4, CPUs:    #25
[   10.963551] .... node  #1, CPUs:    #26
[   10.966550] .... node  #5, CPUs:    #27
[   10.968552] .... node  #2, CPUs:    #28
[   10.971551] .... node  #6, CPUs:    #29
[   10.973551] .... node  #3, CPUs:    #30
[   10.976550] .... node  #7, CPUs:    #31
[   10.979551] .... node  #0, CPUs:    #32
[   10.982549] .... node  #4, CPUs:    #33
[   10.985551] .... node  #1, CPUs:    #34
[   10.988550] .... node  #5, CPUs:    #35
[   10.991551] .... node  #2, CPUs:    #36
[   10.993551] .... node  #6, CPUs:    #37
[   10.996551] .... node  #3, CPUs:    #38
[   10.998552] .... node  #7, CPUs:    #39
[   11.001551] .... node  #0, CPUs:    #40
[   11.003551] .... node  #4, CPUs:    #41
[   11.006551] .... node  #1, CPUs:    #42
[   11.008551] .... node  #5, CPUs:    #43
[   11.011551] .... node  #2, CPUs:    #44
[   11.013551] .... node  #6, CPUs:    #45
[   11.016551] .... node  #3, CPUs:    #46
[   11.018552] .... node  #7, CPUs:    #47
[   11.021551] .... node  #0, CPUs:    #48
[   11.023551] .... node  #4, CPUs:    #49
[   11.026551] .... node  #1, CPUs:    #50
[   11.029550] .... node  #5, CPUs:    #51
[   11.032552] .... node  #2, CPUs:    #52
[   11.035551] .... node  #6, CPUs:    #53
[   11.038551] .... node  #3, CPUs:    #54
[   11.041550] .... node  #7, CPUs:    #55
[   11.043551] .... node  #0, CPUs:    #56
[   11.046550] .... node  #4, CPUs:    #57
[   11.048552] .... node  #1, CPUs:    #58
[   11.051550] .... node  #5, CPUs:    #59
[   11.053552] .... node  #2, CPUs:    #60
[   11.056551] .... node  #6, CPUs:    #61
[   11.059550] .... node  #3, CPUs:    #62
[   11.062552] .... node  #7, CPUs:    #63
[   11.065551] .... node  #0, CPUs:    #64
[   11.067552] .... node  #4, CPUs:    #65
[   11.070550] .... node  #1, CPUs:    #66
[   11.072551] .... node  #5, CPUs:    #67
[   11.075550] .... node  #2, CPUs:    #68
[   11.077551] .... node  #6, CPUs:    #69
[   11.080550] .... node  #3, CPUs:    #70
[   11.082551] .... node  #7, CPUs:    #71
[   11.085551] .... node  #0, CPUs:    #72
[   11.087551] .... node  #4, CPUs:    #73
[   11.090551] .... node  #1, CPUs:    #74
[   11.092551] .... node  #5, CPUs:    #75
[   11.095551] .... node  #2, CPUs:    #76
[   11.097551] .... node  #6, CPUs:    #77
[   11.100550] .... node  #3, CPUs:    #78
[   11.102551] .... node  #7, CPUs:    #79
[   11.105551] .... node  #0, CPUs:    #80
[   11.107551] .... node  #4, CPUs:    #81
[   11.110550] .... node  #1, CPUs:    #82
[   11.113550] .... node  #5, CPUs:    #83
[   11.115551] .... node  #2, CPUs:    #84
[   11.118550] .... node  #6, CPUs:    #85
[   11.121551] .... node  #3, CPUs:    #86
[   11.124550] .... node  #7, CPUs:    #87
[   11.127550] .... node  #0, CPUs:    #88
[   11.130549] .... node  #4, CPUs:    #89
[   11.132550] .... node  #1, CPUs:    #90
[   11.135550] .... node  #5, CPUs:    #91
[   11.137551] .... node  #2, CPUs:    #92
[   11.140550] .... node  #6, CPUs:    #93
[   11.142551] .... node  #3, CPUs:    #94
[   11.145550] .... node  #7, CPUs:    #95
[   11.147551] .... node  #0, CPUs:    #96
[   11.150550] .... node  #4, CPUs:    #97
[   11.153551] .... node  #1, CPUs:    #98
[   11.155551] .... node  #5, CPUs:    #99
[   11.158550] .... node  #2, CPUs:   #100
[   11.161550] .... node  #6, CPUs:   #101
[   11.164551] .... node  #3, CPUs:   #102
[   11.167550] .... node  #7, CPUs:   #103
[   11.169551] .... node  #0, CPUs:   #104
[   11.172550] .... node  #4, CPUs:   #105
[   11.174552] .... node  #1, CPUs:   #106
[   11.177550] .... node  #5, CPUs:   #107
[   11.180551] .... node  #2, CPUs:   #108
[   11.183550] .... node  #6, CPUs:   #109
[   11.186551] .... node  #3, CPUs:   #110
[   11.188551] .... node  #7, CPUs:   #111
[   11.191551] .... node  #0, CPUs:   #112
[   11.194550] .... node  #4, CPUs:   #113
[   11.196550] .... node  #1, CPUs:   #114
[   11.199551] .... node  #5, CPUs:   #115
[   11.202551] .... node  #2, CPUs:   #116
[   11.205550] .... node  #6, CPUs:   #117
[   11.208551] .... node  #3, CPUs:   #118
[   11.210550] .... node  #7, CPUs:   #119
[   11.213551] .... node  #0, CPUs:   #120
[   11.216549] .... node  #4, CPUs:   #121
[   11.218550] .... node  #1, CPUs:   #122
[   11.221550] .... node  #5, CPUs:   #123
[   11.224551] .... node  #2, CPUs:   #124
[   11.227550] .... node  #6, CPUs:   #125
[   11.230551] .... node  #3, CPUs:   #126
[   11.232551] .... node  #7, CPUs:   #127
[   11.235016] smp: Brought up 8 nodes, 128 CPUs
[   11.236550] smpboot: Max logical packages: 2
[   11.237569] smpboot: Total of 128 processors activated (561036.54 Bogo=
MIPS)
[   11.293879] devtmpfs: initialized
[   11.295629] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff=
] (4096 bytes)
[   11.296550] PM: Registering ACPI NVS region [mem 0x6efcf000-0x6fdfefff=
] (14876672 bytes)
[   11.299395] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 1911260446275000 ns
[   11.299668] futex hash table entries: 32768 (order: 9, 2097152 bytes)
[   11.302077] xor: automatically using best checksumming function   avx =
     =20
[   11.305037] NET: Registered protocol family 16
[   11.307467] cpuidle: using governor ladder
[   11.313156] ACPI FADT declares the system doesn't support PCIe ASPM, s=
o disable it
[   11.320551] ACPI: bus type PCI registered
[   11.324597] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x800000=
00-0x8fffffff] (base 0x80000000)
[   11.334354] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in E=
820
[   11.340565] PCI: Using configuration type 1 for base access
[   11.346566] PCI: Dell System detected, enabling pci=3Dbfsort.
[   11.360763] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pag=
es
[   11.385997] raid6: sse2x1   gen()  6156 MB/s
[   11.406997] raid6: sse2x1   xor()  5921 MB/s
[   11.428000] raid6: sse2x2   gen() 13000 MB/s
[   11.448997] raid6: sse2x2   xor()  8162 MB/s
[   11.469997] raid6: sse2x4   gen() 13062 MB/s
[   11.490999] raid6: sse2x4   xor()  6451 MB/s
[   11.511998] raid6: avx2x1   gen() 15128 MB/s
[   11.532998] raid6: avx2x1   xor() 10982 MB/s
[   11.553997] raid6: avx2x2   gen() 19648 MB/s
[   11.574999] raid6: avx2x2   xor() 11886 MB/s
[   11.595999] raid6: avx2x4   gen() 19949 MB/s
[   11.616998] raid6: avx2x4   xor()  8347 MB/s
[   11.621549] raid6: using algorithm avx2x4 gen() 19949 MB/s
[   11.626551] raid6: .... xor() 8347 MB/s, rmw enabled
[   11.631550] raid6: using avx2x2 recovery algorithm
[   11.637549] ACPI: Added _OSI(Module Device)
[   11.641550] ACPI: Added _OSI(Processor Device)
[   11.645548] ACPI: Added _OSI(3.0 _SCP Extensions)
[   11.650549] ACPI: Added _OSI(Processor Aggregator Device)
[   11.655549] ACPI: Added _OSI(Linux-Dell-Video)
[   11.660549] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[   11.674102] ACPI: 5 ACPI AML tables successfully acquired and loaded
[   11.685625] ACPI: Interpreter enabled
[   11.689561] ACPI: (supports S0 S5)
[   11.692550] ACPI: Using IOAPIC for interrupt routing
[   11.697838] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3Dnocrs" and report a bug
[   11.707885] ACPI: Enabled 2 GPEs in block 00 to 1F
[   11.726055] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *=
0
[   11.732595] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *=
0
[   11.739599] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *=
0
[   11.746596] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *=
0
[   11.752598] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *=
0
[   11.759597] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *=
0
[   11.766596] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *=
0
[   11.772596] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *=
0
[   11.779567] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-1f])
[   11.785553] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[   11.793673] acpi PNP0A08:00: _OSC: platform does not support [AER LTR]=

[   11.800659] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability=
]
[   11.807549] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[   11.815739] PCI host bridge to bus 0000:00
[   11.819551] pci_bus 0000:00: root bus resource [io  0x0000-0x03af wind=
ow]
[   11.826549] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 wind=
ow]
[   11.833549] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df wind=
ow]
[   11.840549] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bf=
fff window]
[   11.847549] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3=
fff window]
[   11.855549] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7=
fff window]
[   11.862549] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cb=
fff window]
[   11.870549] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cf=
fff window]
[   11.877549] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3=
fff window]
[   11.885551] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7=
fff window]
[   11.892550] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000db=
fff window]
[   11.900549] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000df=
fff window]
[   11.907549] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3=
fff window]
[   11.915550] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7=
fff window]
[   11.922549] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000eb=
fff window]
[   11.929549] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000ef=
fff window]
[   11.937549] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000ff=
fff window]
[   11.944550] pci_bus 0000:00: root bus resource [io  0x0d00-0x1fff wind=
ow]
[   11.951549] pci_bus 0000:00: root bus resource [mem 0xeb000000-0xfebff=
fff window]
[   11.959549] pci_bus 0000:00: root bus resource [mem 0x10080000000-0x1e=
00fffffff window]
[   11.967549] pci_bus 0000:00: root bus resource [bus 00-1f]
[   11.975551] pci 0000:00:07.1: enabling Extended Tags
[   11.981552] pci 0000:00:08.1: enabling Extended Tags
[   11.991742] pci 0000:01:00.0: VF(n) BAR0 space: [mem 0x00000000-0x000f=
ffff 64bit pref] (contains BAR0 for 64 VFs)
[   12.002566] pci 0000:01:00.0: VF(n) BAR3 space: [mem 0x00000000-0x000f=
ffff 64bit pref] (contains BAR3 for 64 VFs)
[   12.012969] pci 0000:01:00.1: VF(n) BAR0 space: [mem 0x00000000-0x000f=
ffff 64bit pref] (contains BAR0 for 64 VFs)
[   12.023566] pci 0000:01:00.1: VF(n) BAR3 space: [mem 0x00000000-0x000f=
ffff 64bit pref] (contains BAR3 for 64 VFs)
[   12.033815] pci 0000:00:01.1: PCI bridge to [bus 01]
[   12.042564] pci 0000:00:01.3: PCI bridge to [bus 02-03]
[   12.047586] pci_bus 0000:03: extended config space not accessible
[   12.053734] pci 0000:02:00.0: PCI bridge to [bus 03]
[   12.059843] pci 0000:04:00.0: 8.000 Gb/s available PCIe bandwidth, lim=
ited by 5 GT/s x2 link at 0000:00:01.4 (capable of 16.000 Gb/s with 5 GT/=
s x4 link)
[   12.073930] pci 0000:00:01.4: PCI bridge to [bus 04]
[   12.079631] pci 0000:05:00.0: enabling Extended Tags
[   12.084665] pci 0000:05:00.2: enabling Extended Tags
[   12.089665] pci 0000:05:00.3: enabling Extended Tags
[   12.094649] pci 0000:00:07.1: PCI bridge to [bus 05]
[   12.100632] pci 0000:06:00.0: enabling Extended Tags
[   12.105672] pci 0000:06:00.1: enabling Extended Tags
[   12.110678] pci 0000:06:00.2: enabling Extended Tags
[   12.115658] pci 0000:00:08.1: PCI bridge to [bus 06]
[   12.121005] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 20-3f])
[   12.127551] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[   12.135668] acpi PNP0A08:01: _OSC: platform does not support [AER LTR]=

[   12.142658] acpi PNP0A08:01: _OSC: OS now controls [PME PCIeCapability=
]
[   12.148549] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[   12.156803] PCI host bridge to bus 0000:20
[   12.161550] pci_bus 0000:20: root bus resource [io  0x2000-0x3fff wind=
ow]
[   12.168550] pci_bus 0000:20: root bus resource [mem 0xde000000-0xeafff=
fff window]
[   12.175549] pci_bus 0000:20: root bus resource [mem 0x1e010000000-0x2b=
f9fffffff window]
[   12.183549] pci_bus 0000:20: root bus resource [bus 20-3f]
[   12.190075] pci 0000:20:07.1: enabling Extended Tags
[   12.195331] pci 0000:20:08.1: enabling Extended Tags
[   12.200671] pci 0000:21:00.0: enabling Extended Tags
[   12.205674] pci 0000:21:00.2: enabling Extended Tags
[   12.210675] pci 0000:21:00.3: enabling Extended Tags
[   12.215658] pci 0000:20:07.1: PCI bridge to [bus 21]
[   12.221121] pci 0000:22:00.0: enabling Extended Tags
[   12.226658] pci 0000:22:00.1: enabling Extended Tags
[   12.231650] pci 0000:20:08.1: PCI bridge to [bus 22]
[   12.236833] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 40-5f])
[   12.243551] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[   12.251665] acpi PNP0A08:02: _OSC: platform does not support [AER LTR]=

[   12.257651] acpi PNP0A08:02: _OSC: OS now controls [PME PCIeCapability=
]
[   12.264549] acpi PNP0A08:02: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[   12.272795] PCI host bridge to bus 0000:40
[   12.277550] pci_bus 0000:40: root bus resource [io  0x4000-0x5fff wind=
ow]
[   12.283549] pci_bus 0000:40: root bus resource [mem 0xd1000000-0xddfff=
fff window]
[   12.291549] pci_bus 0000:40: root bus resource [mem 0x2bfa0000000-0x39=
f2fffffff window]
[   12.299552] pci_bus 0000:40: root bus resource [bus 40-5f]
[   12.305552] pci 0000:40:07.1: enabling Extended Tags
[   12.310832] pci 0000:40:08.1: enabling Extended Tags
[   12.316639] pci 0000:41:00.0: enabling Extended Tags
[   12.321672] pci 0000:41:00.2: enabling Extended Tags
[   12.327648] pci 0000:40:07.1: PCI bridge to [bus 41]
[   12.332671] pci 0000:42:00.0: enabling Extended Tags
[   12.337680] pci 0000:42:00.1: enabling Extended Tags
[   12.342660] pci 0000:40:08.1: PCI bridge to [bus 42]
[   12.347644] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus 60-7f])
[   12.353551] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[   12.362658] acpi PNP0A08:03: _OSC: platform does not support [AER LTR]=

[   12.368652] acpi PNP0A08:03: _OSC: OS now controls [PME PCIeCapability=
]
[   12.375549] acpi PNP0A08:03: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[   12.383767] PCI host bridge to bus 0000:60
[   12.387549] pci_bus 0000:60: root bus resource [io  0x6000-0x7fff wind=
ow]
[   12.394550] pci_bus 0000:60: root bus resource [mem 0xc4000000-0xd0fff=
fff window]
[   12.402550] pci_bus 0000:60: root bus resource [mem 0x39f30000000-0x47=
ebfffffff window]
[   12.410549] pci_bus 0000:60: root bus resource [bus 60-7f]
[   12.416928] pci 0000:60:07.1: enabling Extended Tags
[   12.422720] pci 0000:60:08.1: enabling Extended Tags
[   12.428047] pci 0000:60:03.1: PCI bridge to [bus 61]
[   12.433635] pci 0000:62:00.0: enabling Extended Tags
[   12.438672] pci 0000:62:00.2: enabling Extended Tags
[   12.443648] pci 0000:60:07.1: PCI bridge to [bus 62]
[   12.448675] pci 0000:63:00.0: enabling Extended Tags
[   12.454682] pci 0000:63:00.1: enabling Extended Tags
[   12.459657] pci 0000:60:08.1: PCI bridge to [bus 63]
[   12.464801] ACPI: PCI Root Bridge [PC04] (domain 0000 [bus 80-9f])
[   12.470829] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[   12.478661] acpi PNP0A08:04: _OSC: platform does not support [AER LTR]=

[   12.485653] acpi PNP0A08:04: _OSC: OS now controls [PME PCIeCapability=
]
[   12.492549] acpi PNP0A08:04: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[   12.500804] PCI host bridge to bus 0000:80
[   12.504550] pci_bus 0000:80: root bus resource [io  0x8000-0x9fff wind=
ow]
[   12.511550] pci_bus 0000:80: root bus resource [mem 0xb7000000-0xc3fff=
fff window]
[   12.519549] pci_bus 0000:80: root bus resource [mem 0x47ec0000000-0x55=
e4fffffff window]
[   12.527550] pci_bus 0000:80: root bus resource [bus 80-9f]
[   12.533359] pci 0000:80:07.1: enabling Extended Tags
[   12.539474] pci 0000:80:08.1: enabling Extended Tags
[   12.545573] pci 0000:81:00.0: enabling Extended Tags
[   12.550690] pci 0000:81:00.2: enabling Extended Tags
[   12.555668] pci 0000:80:07.1: PCI bridge to [bus 81]
[   12.561611] pci 0000:82:00.0: enabling Extended Tags
[   12.566706] pci 0000:82:00.1: enabling Extended Tags
[   12.571675] pci 0000:80:08.1: PCI bridge to [bus 82]
[   12.576799] ACPI: PCI Root Bridge [PC05] (domain 0000 [bus a0-bf])
[   12.583551] acpi PNP0A08:05: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[   12.591654] acpi PNP0A08:05: _OSC: platform does not support [AER LTR]=

[   12.597646] acpi PNP0A08:05: _OSC: OS now controls [PME PCIeCapability=
]
[   12.604549] acpi PNP0A08:05: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[   12.612771] PCI host bridge to bus 0000:a0
[   12.617550] pci_bus 0000:a0: root bus resource [io  0xa000-0xbfff wind=
ow]
[   12.623549] pci_bus 0000:a0: root bus resource [mem 0xaa000000-0xb6fff=
fff window]
[   12.631549] pci_bus 0000:a0: root bus resource [mem 0x55e50000000-0x63=
ddfffffff window]
[   12.639550] pci_bus 0000:a0: root bus resource [bus a0-bf]
[   12.646027] pci 0000:a0:07.1: enabling Extended Tags
[   12.650861] pci 0000:a0:08.1: enabling Extended Tags
[   12.656650] pci 0000:a1:00.0: enabling Extended Tags
[   12.661697] pci 0000:a1:00.2: enabling Extended Tags
[   12.667672] pci 0000:a0:07.1: PCI bridge to [bus a1]
[   12.672687] pci 0000:a2:00.0: enabling Extended Tags
[   12.677648] pci 0000:a2:00.1: enabling Extended Tags
[   12.682672] pci 0000:a0:08.1: PCI bridge to [bus a2]
[   12.687829] ACPI: PCI Root Bridge [PC06] (domain 0000 [bus c0-df])
[   12.693551] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[   12.702653] acpi PNP0A08:06: _OSC: platform does not support [AER LTR]=

[   12.708645] acpi PNP0A08:06: _OSC: OS now controls [PME PCIeCapability=
]
[   12.715549] acpi PNP0A08:06: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[   12.723771] PCI host bridge to bus 0000:c0
[   12.727551] pci_bus 0000:c0: root bus resource [io  0xc000-0xdfff wind=
ow]
[   12.734550] pci_bus 0000:c0: root bus resource [mem 0x9d000000-0xa9fff=
fff window]
[   12.742549] pci_bus 0000:c0: root bus resource [mem 0x63de0000000-0x71=
d6fffffff window]
[   12.750549] pci_bus 0000:c0: root bus resource [bus c0-df]
[   12.756137] pci 0000:c0:07.1: enabling Extended Tags
[   12.761713] pci 0000:c0:08.1: enabling Extended Tags
[   12.767860] pci 0000:c1:00.0: enabling Extended Tags
[   12.772685] pci 0000:c1:00.2: enabling Extended Tags
[   12.777660] pci 0000:c0:07.1: PCI bridge to [bus c1]
[   12.783063] pci 0000:c2:00.0: enabling Extended Tags
[   12.788693] pci 0000:c2:00.1: enabling Extended Tags
[   12.793671] pci 0000:c0:08.1: PCI bridge to [bus c2]
[   12.798666] ACPI: PCI Root Bridge [PC07] (domain 0000 [bus e0-ff])
[   12.804551] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[   12.812654] acpi PNP0A08:07: _OSC: platform does not support [AER LTR]=

[   12.819647] acpi PNP0A08:07: _OSC: OS now controls [PME PCIeCapability=
]
[   12.826549] acpi PNP0A08:07: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[   12.834745] acpi PNP0A08:07: host bridge window [mem 0x71d70000000-0xf=
fffffffffff window] ([0x80000000000-0xffffffffffff] ignored, not CPU addr=
essable)
[   12.848579] PCI host bridge to bus 0000:e0
[   12.852549] pci_bus 0000:e0: root bus resource [io  0xe000-0xffff wind=
ow]
[   12.859551] pci_bus 0000:e0: root bus resource [mem 0x90000000-0x9cfff=
fff window]
[   12.866549] pci_bus 0000:e0: root bus resource [mem 0x71d70000000-0x7f=
fffffffff window]
[   12.874549] pci_bus 0000:e0: root bus resource [bus e0-ff]
[   12.880794] pci 0000:e0:07.1: enabling Extended Tags
[   12.885854] pci 0000:e0:08.1: enabling Extended Tags
[   12.891649] pci 0000:e1:00.0: enabling Extended Tags
[   12.896693] pci 0000:e1:00.2: enabling Extended Tags
[   12.901666] pci 0000:e0:07.1: PCI bridge to [bus e1]
[   12.906683] pci 0000:e2:00.0: enabling Extended Tags
[   12.911704] pci 0000:e2:00.1: enabling Extended Tags
[   12.917676] pci 0000:e0:08.1: PCI bridge to [bus e2]
[   12.926257] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[   12.926547] pci 0000:03:00.0: vgaarb: VGA device added: decodes=3Dio+m=
em,owns=3Dio+mem,locks=3Dnone
[   12.940565] pci 0000:03:00.0: vgaarb: bridge control possible
[   12.946549] vgaarb: loaded
[   12.949636] SCSI subsystem initialized
[   12.953566] ACPI: bus type USB registered
[   12.957576] usbcore: registered new interface driver usbfs
[   12.962557] usbcore: registered new interface driver hub
[   12.969447] usbcore: registered new device driver usb
[   12.974570] pps_core: LinuxPPS API ver. 1 registered
[   12.978550] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
[   12.988554] PTP clock support registered
[   12.993076] EDAC MC: Ver: 3.0.0
[   12.996834] Registered efivars operations
[   13.033095] Advanced Linux Sound Architecture Driver Initialized.
[   13.038561] PCI: Using ACPI for IRQ routing
[   13.063455] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[   13.068550] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[   13.076917] clocksource: Switched to clocksource tsc-early
[   13.098582] VFS: Disk quotas dquot_6.6.0
[   13.102612] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
[   13.109722] FS-Cache: Loaded
[   13.112731] CacheFiles: Loaded
[   13.115813] pnp: PnP ACPI init
[   13.119289] system 00:00: [mem 0x80000000-0x8fffffff] has been reserve=
d
[   13.126977] pnp: PnP ACPI: found 4 devices
[   13.136942] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,=
 max_idle_ns: 2085701024 ns
[   13.145822] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfff80000-0xffff=
ffff pref]: no compatible bridge window
[   13.155732] pci 0000:01:00.1: can't claim BAR 6 [mem 0xfff80000-0xffff=
ffff pref]: no compatible bridge window
[   13.165648] pci 0000:04:00.0: can't claim BAR 6 [mem 0xfff80000-0xffff=
ffff pref]: no compatible bridge window
[   13.175561] pci 0000:04:00.1: can't claim BAR 6 [mem 0xfff80000-0xffff=
ffff pref]: no compatible bridge window
[   13.185498] pci 0000:61:00.0: can't claim BAR 6 [mem 0xfff00000-0xffff=
ffff pref]: no compatible bridge window
[   13.195466] pci 0000:00:01.1: BAR 15: assigned [mem 0x10080000000-0x10=
0803fffff 64bit pref]
[   13.203818] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa280000-0xfa2fff=
ff pref]
[   13.211042] pci 0000:01:00.1: BAR 6: no space for [mem size 0x00080000=
 pref]
[   13.218089] pci 0000:01:00.1: BAR 6: failed to assign [mem size 0x0008=
0000 pref]
[   13.225480] pci 0000:01:00.0: BAR 7: assigned [mem 0x10080000000-0x100=
800fffff 64bit pref]
[   13.233744] pci 0000:01:00.0: BAR 10: assigned [mem 0x10080100000-0x10=
0801fffff 64bit pref]
[   13.242097] pci 0000:01:00.1: BAR 7: assigned [mem 0x10080200000-0x100=
802fffff 64bit pref]
[   13.250365] pci 0000:01:00.1: BAR 10: assigned [mem 0x10080300000-0x10=
0803fffff 64bit pref]
[   13.258722] pci 0000:00:01.1: PCI bridge to [bus 01]
[   13.263694] pci 0000:00:01.1:   bridge window [io  0x1000-0x1fff]
[   13.269788] pci 0000:00:01.1:   bridge window [mem 0xfa000000-0xfa2fff=
ff]
[   13.276580] pci 0000:00:01.1:   bridge window [mem 0x10080000000-0x100=
803fffff 64bit pref]
[   13.284844] pci 0000:02:00.0: PCI bridge to [bus 03]
[   13.289820] pci 0000:02:00.0:   bridge window [mem 0xf9000000-0xf98fff=
ff]
[   13.296617] pci 0000:02:00.0:   bridge window [mem 0xeb000000-0xebffff=
ff 64bit pref]
[   13.304361] pci 0000:00:01.3: PCI bridge to [bus 02-03]
[   13.309592] pci 0000:00:01.3:   bridge window [mem 0xf9000000-0xf98fff=
ff]
[   13.316378] pci 0000:00:01.3:   bridge window [mem 0xeb000000-0xebffff=
ff 64bit pref]
[   13.324131] pci 0000:04:00.0: BAR 6: assigned [mem 0xf9f80000-0xf9ffff=
ff pref]
[   13.331356] pci 0000:04:00.1: BAR 6: no space for [mem size 0x00080000=
 pref]
[   13.338409] pci 0000:04:00.1: BAR 6: failed to assign [mem size 0x0008=
0000 pref]
[   13.345802] pci 0000:00:01.4: PCI bridge to [bus 04]
[   13.350769] pci 0000:00:01.4:   bridge window [mem 0xf9e00000-0xf9ffff=
ff]
[   13.357561] pci 0000:00:07.1: PCI bridge to [bus 05]
[   13.362530] pci 0000:00:07.1:   bridge window [mem 0xf9b00000-0xf9dfff=
ff]
[   13.369319] pci 0000:00:08.1: PCI bridge to [bus 06]
[   13.374291] pci 0000:00:08.1:   bridge window [mem 0xf9900000-0xf9afff=
ff]
[   13.381161] pci 0000:20:07.1: PCI bridge to [bus 21]
[   13.386132] pci 0000:20:07.1:   bridge window [mem 0xe8200000-0xe84fff=
ff]
[   13.392927] pci 0000:20:08.1: PCI bridge to [bus 22]
[   13.397900] pci 0000:20:08.1:   bridge window [mem 0xe8000000-0xe81fff=
ff]
[   13.404731] pci 0000:40:07.1: PCI bridge to [bus 41]
[   13.409704] pci 0000:40:07.1:   bridge window [mem 0xdb200000-0xdb3fff=
ff]
[   13.416493] pci 0000:40:08.1: PCI bridge to [bus 42]
[   13.421464] pci 0000:40:08.1:   bridge window [mem 0xdb000000-0xdb1fff=
ff]
[   13.428291] pci 0000:61:00.0: BAR 6: no space for [mem size 0x00100000=
 pref]
[   13.435339] pci 0000:61:00.0: BAR 6: failed to assign [mem size 0x0010=
0000 pref]
[   13.442730] pci 0000:60:03.1: PCI bridge to [bus 61]
[   13.447697] pci 0000:60:03.1:   bridge window [io  0x6000-0x6fff]
[   13.453790] pci 0000:60:03.1:   bridge window [mem 0xce400000-0xce4fff=
ff]
[   13.460576] pci 0000:60:03.1:   bridge window [mem 0xc4000000-0xc41fff=
ff 64bit pref]
[   13.468319] pci 0000:60:07.1: PCI bridge to [bus 62]
[   13.473292] pci 0000:60:07.1:   bridge window [mem 0xce200000-0xce3fff=
ff]
[   13.480079] pci 0000:60:08.1: PCI bridge to [bus 63]
[   13.485052] pci 0000:60:08.1:   bridge window [mem 0xce000000-0xce1fff=
ff]
[   13.491874] pci 0000:80:07.1: PCI bridge to [bus 81]
[   13.496840] pci 0000:80:07.1:   bridge window [mem 0xc1200000-0xc13fff=
ff]
[   13.503637] pci 0000:80:08.1: PCI bridge to [bus 82]
[   13.508610] pci 0000:80:08.1:   bridge window [mem 0xc1000000-0xc11fff=
ff]
[   13.515433] pci 0000:a0:07.1: PCI bridge to [bus a1]
[   13.520407] pci 0000:a0:07.1:   bridge window [mem 0xb4200000-0xb43fff=
ff]
[   13.527203] pci 0000:a0:08.1: PCI bridge to [bus a2]
[   13.532173] pci 0000:a0:08.1:   bridge window [mem 0xb4000000-0xb41fff=
ff]
[   13.538999] pci 0000:c0:07.1: PCI bridge to [bus c1]
[   13.543970] pci 0000:c0:07.1:   bridge window [mem 0xa7200000-0xa73fff=
ff]
[   13.550768] pci 0000:c0:08.1: PCI bridge to [bus c2]
[   13.555738] pci 0000:c0:08.1:   bridge window [mem 0xa7000000-0xa71fff=
ff]
[   13.562557] pci 0000:e0:07.1: PCI bridge to [bus e1]
[   13.567526] pci 0000:e0:07.1:   bridge window [mem 0x9a200000-0x9a3fff=
ff]
[   13.574324] pci 0000:e0:08.1: PCI bridge to [bus e2]
[   13.579297] pci 0000:e0:08.1:   bridge window [mem 0x9a000000-0x9a1fff=
ff]
[   13.586405] NET: Registered protocol family 2
[   13.591299] tcp_listen_portaddr_hash hash table entries: 65536 (order:=
 8, 1048576 bytes)
[   13.599766] TCP established hash table entries: 524288 (order: 10, 419=
4304 bytes)
[   13.608071] TCP bind hash table entries: 65536 (order: 8, 1048576 byte=
s)
[   13.614954] TCP: Hash tables configured (established 524288 bind 65536=
)
[   13.621830] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[   13.628530] UDP-Lite hash table entries: 65536 (order: 9, 2097152 byte=
s)
[   13.636123] pci 0000:03:00.0: Video device with shadowed ROM at [mem 0=
x000c0000-0x000dffff]
[   13.645085] Trying to unpack rootfs image as initramfs...
[   13.734111] Freeing initrd memory: 5136K
[   14.524188] AMD-Vi: IOMMU performance counters supported
[   14.529604] AMD-Vi: IOMMU performance counters supported
[   14.534971] AMD-Vi: IOMMU performance counters supported
[   14.540332] AMD-Vi: IOMMU performance counters supported
[   14.545699] AMD-Vi: IOMMU performance counters supported
[   14.551059] AMD-Vi: IOMMU performance counters supported
[   14.556420] AMD-Vi: IOMMU performance counters supported
[   14.561793] AMD-Vi: IOMMU performance counters supported
[   14.569855] iommu: Adding device 0000:00:01.0 to group 0
[   14.575217] iommu: Adding device 0000:00:01.1 to group 0
[   14.580578] iommu: Adding device 0000:00:01.3 to group 0
[   14.585933] iommu: Adding device 0000:00:01.4 to group 0
[   14.592478] iommu: Adding device 0000:00:02.0 to group 1
[   14.599109] iommu: Adding device 0000:00:03.0 to group 2
[   14.605667] iommu: Adding device 0000:00:04.0 to group 3
[   14.612327] iommu: Adding device 0000:00:07.0 to group 4
[   14.617688] iommu: Adding device 0000:00:07.1 to group 4
[   14.624358] iommu: Adding device 0000:00:08.0 to group 5
[   14.629715] iommu: Adding device 0000:00:08.1 to group 5
[   14.636257] iommu: Adding device 0000:00:14.0 to group 6
[   14.641614] iommu: Adding device 0000:00:14.3 to group 6
[   14.648436] iommu: Adding device 0000:00:18.0 to group 7
[   14.653792] iommu: Adding device 0000:00:18.1 to group 7
[   14.659146] iommu: Adding device 0000:00:18.2 to group 7
[   14.664499] iommu: Adding device 0000:00:18.3 to group 7
[   14.669846] iommu: Adding device 0000:00:18.4 to group 7
[   14.675195] iommu: Adding device 0000:00:18.5 to group 7
[   14.680539] iommu: Adding device 0000:00:18.6 to group 7
[   14.685888] iommu: Adding device 0000:00:18.7 to group 7
[   14.692575] iommu: Adding device 0000:00:19.0 to group 8
[   14.697932] iommu: Adding device 0000:00:19.1 to group 8
[   14.703281] iommu: Adding device 0000:00:19.2 to group 8
[   14.708629] iommu: Adding device 0000:00:19.3 to group 8
[   14.713978] iommu: Adding device 0000:00:19.4 to group 8
[   14.719326] iommu: Adding device 0000:00:19.5 to group 8
[   14.724674] iommu: Adding device 0000:00:19.6 to group 8
[   14.730029] iommu: Adding device 0000:00:19.7 to group 8
[   14.736899] iommu: Adding device 0000:00:1a.0 to group 9
[   14.742251] iommu: Adding device 0000:00:1a.1 to group 9
[   14.747610] iommu: Adding device 0000:00:1a.2 to group 9
[   14.752961] iommu: Adding device 0000:00:1a.3 to group 9
[   14.758309] iommu: Adding device 0000:00:1a.4 to group 9
[   14.763656] iommu: Adding device 0000:00:1a.5 to group 9
[   14.769003] iommu: Adding device 0000:00:1a.6 to group 9
[   14.774352] iommu: Adding device 0000:00:1a.7 to group 9
[   14.781049] iommu: Adding device 0000:00:1b.0 to group 10
[   14.786490] iommu: Adding device 0000:00:1b.1 to group 10
[   14.791928] iommu: Adding device 0000:00:1b.2 to group 10
[   14.797372] iommu: Adding device 0000:00:1b.3 to group 10
[   14.802814] iommu: Adding device 0000:00:1b.4 to group 10
[   14.808257] iommu: Adding device 0000:00:1b.5 to group 10
[   14.813700] iommu: Adding device 0000:00:1b.6 to group 10
[   14.819141] iommu: Adding device 0000:00:1b.7 to group 10
[   14.826038] iommu: Adding device 0000:00:1c.0 to group 11
[   14.831484] iommu: Adding device 0000:00:1c.1 to group 11
[   14.836927] iommu: Adding device 0000:00:1c.2 to group 11
[   14.842370] iommu: Adding device 0000:00:1c.3 to group 11
[   14.847813] iommu: Adding device 0000:00:1c.4 to group 11
[   14.853257] iommu: Adding device 0000:00:1c.5 to group 11
[   14.858697] iommu: Adding device 0000:00:1c.6 to group 11
[   14.864143] iommu: Adding device 0000:00:1c.7 to group 11
[   14.870937] iommu: Adding device 0000:00:1d.0 to group 12
[   14.876382] iommu: Adding device 0000:00:1d.1 to group 12
[   14.881823] iommu: Adding device 0000:00:1d.2 to group 12
[   14.887267] iommu: Adding device 0000:00:1d.3 to group 12
[   14.892707] iommu: Adding device 0000:00:1d.4 to group 12
[   14.898150] iommu: Adding device 0000:00:1d.5 to group 12
[   14.903595] iommu: Adding device 0000:00:1d.6 to group 12
[   14.909037] iommu: Adding device 0000:00:1d.7 to group 12
[   14.915908] iommu: Adding device 0000:00:1e.0 to group 13
[   14.921357] iommu: Adding device 0000:00:1e.1 to group 13
[   14.926797] iommu: Adding device 0000:00:1e.2 to group 13
[   14.932240] iommu: Adding device 0000:00:1e.3 to group 13
[   14.937682] iommu: Adding device 0000:00:1e.4 to group 13
[   14.943123] iommu: Adding device 0000:00:1e.5 to group 13
[   14.948569] iommu: Adding device 0000:00:1e.6 to group 13
[   14.954009] iommu: Adding device 0000:00:1e.7 to group 13
[   14.960904] iommu: Adding device 0000:00:1f.0 to group 14
[   14.966356] iommu: Adding device 0000:00:1f.1 to group 14
[   14.971804] iommu: Adding device 0000:00:1f.2 to group 14
[   14.977258] iommu: Adding device 0000:00:1f.3 to group 14
[   14.982697] iommu: Adding device 0000:00:1f.4 to group 14
[   14.988141] iommu: Adding device 0000:00:1f.5 to group 14
[   14.993591] iommu: Adding device 0000:00:1f.6 to group 14
[   14.999034] iommu: Adding device 0000:00:1f.7 to group 14
[   15.004458] iommu: Adding device 0000:01:00.0 to group 0
[   15.009792] iommu: Adding device 0000:01:00.1 to group 0
[   15.015124] iommu: Adding device 0000:02:00.0 to group 0
[   15.020445] iommu: Adding device 0000:03:00.0 to group 0
[   15.025780] iommu: Adding device 0000:04:00.0 to group 0
[   15.031117] iommu: Adding device 0000:04:00.1 to group 0
[   15.036452] iommu: Adding device 0000:05:00.0 to group 4
[   15.041778] iommu: Adding device 0000:05:00.2 to group 4
[   15.047111] iommu: Adding device 0000:05:00.3 to group 4
[   15.052442] iommu: Adding device 0000:06:00.0 to group 5
[   15.057770] iommu: Adding device 0000:06:00.1 to group 5
[   15.063100] iommu: Adding device 0000:06:00.2 to group 5
[   15.069669] iommu: Adding device 0000:20:01.0 to group 15
[   15.076403] iommu: Adding device 0000:20:02.0 to group 16
[   15.083025] iommu: Adding device 0000:20:03.0 to group 17
[   15.089791] iommu: Adding device 0000:20:04.0 to group 18
[   15.096439] iommu: Adding device 0000:20:07.0 to group 19
[   15.101891] iommu: Adding device 0000:20:07.1 to group 19
[   15.108658] iommu: Adding device 0000:20:08.0 to group 20
[   15.114114] iommu: Adding device 0000:20:08.1 to group 20
[   15.119533] iommu: Adding device 0000:21:00.0 to group 19
[   15.124956] iommu: Adding device 0000:21:00.2 to group 19
[   15.130371] iommu: Adding device 0000:21:00.3 to group 19
[   15.135789] iommu: Adding device 0000:22:00.0 to group 20
[   15.141207] iommu: Adding device 0000:22:00.1 to group 20
[   15.147871] iommu: Adding device 0000:40:01.0 to group 21
[   15.154760] iommu: Adding device 0000:40:02.0 to group 22
[   15.161415] iommu: Adding device 0000:40:03.0 to group 23
[   15.168224] iommu: Adding device 0000:40:04.0 to group 24
[   15.174958] iommu: Adding device 0000:40:07.0 to group 25
[   15.180413] iommu: Adding device 0000:40:07.1 to group 25
[   15.187085] iommu: Adding device 0000:40:08.0 to group 26
[   15.192544] iommu: Adding device 0000:40:08.1 to group 26
[   15.197965] iommu: Adding device 0000:41:00.0 to group 25
[   15.203382] iommu: Adding device 0000:41:00.2 to group 25
[   15.208800] iommu: Adding device 0000:42:00.0 to group 26
[   15.214217] iommu: Adding device 0000:42:00.1 to group 26
[   15.220954] iommu: Adding device 0000:60:01.0 to group 27
[   15.227642] iommu: Adding device 0000:60:02.0 to group 28
[   15.234440] iommu: Adding device 0000:60:03.0 to group 29
[   15.239904] iommu: Adding device 0000:60:03.1 to group 29
[   15.246570] iommu: Adding device 0000:60:04.0 to group 30
[   15.253383] iommu: Adding device 0000:60:07.0 to group 31
[   15.258843] iommu: Adding device 0000:60:07.1 to group 31
[   15.265500] iommu: Adding device 0000:60:08.0 to group 32
[   15.270964] iommu: Adding device 0000:60:08.1 to group 32
[   15.276391] iommu: Adding device 0000:61:00.0 to group 29
[   15.281809] iommu: Adding device 0000:62:00.0 to group 31
[   15.287225] iommu: Adding device 0000:62:00.2 to group 31
[   15.292641] iommu: Adding device 0000:63:00.0 to group 32
[   15.298054] iommu: Adding device 0000:63:00.1 to group 32
[   15.304843] iommu: Adding device 0000:80:01.0 to group 33
[   15.311495] iommu: Adding device 0000:80:02.0 to group 34
[   15.318296] iommu: Adding device 0000:80:03.0 to group 35
[   15.324917] iommu: Adding device 0000:80:04.0 to group 36
[   15.331681] iommu: Adding device 0000:80:07.0 to group 37
[   15.337144] iommu: Adding device 0000:80:07.1 to group 37
[   15.343784] iommu: Adding device 0000:80:08.0 to group 38
[   15.349244] iommu: Adding device 0000:80:08.1 to group 38
[   15.354663] iommu: Adding device 0000:81:00.0 to group 37
[   15.360077] iommu: Adding device 0000:81:00.2 to group 37
[   15.365496] iommu: Adding device 0000:82:00.0 to group 38
[   15.370912] iommu: Adding device 0000:82:00.1 to group 38
[   15.377681] iommu: Adding device 0000:a0:01.0 to group 39
[   15.384295] iommu: Adding device 0000:a0:02.0 to group 40
[   15.391063] iommu: Adding device 0000:a0:03.0 to group 41
[   15.397735] iommu: Adding device 0000:a0:04.0 to group 42
[   15.404515] iommu: Adding device 0000:a0:07.0 to group 43
[   15.409978] iommu: Adding device 0000:a0:07.1 to group 43
[   15.416658] iommu: Adding device 0000:a0:08.0 to group 44
[   15.422121] iommu: Adding device 0000:a0:08.1 to group 44
[   15.427542] iommu: Adding device 0000:a1:00.0 to group 43
[   15.432957] iommu: Adding device 0000:a1:00.2 to group 43
[   15.438377] iommu: Adding device 0000:a2:00.0 to group 44
[   15.443803] iommu: Adding device 0000:a2:00.1 to group 44
[   15.450531] iommu: Adding device 0000:c0:01.0 to group 45
[   15.457287] iommu: Adding device 0000:c0:02.0 to group 46
[   15.463937] iommu: Adding device 0000:c0:03.0 to group 47
[   15.470635] iommu: Adding device 0000:c0:04.0 to group 48
[   15.477301] iommu: Adding device 0000:c0:07.0 to group 49
[   15.482764] iommu: Adding device 0000:c0:07.1 to group 49
[   15.489501] iommu: Adding device 0000:c0:08.0 to group 50
[   15.494966] iommu: Adding device 0000:c0:08.1 to group 50
[   15.500385] iommu: Adding device 0000:c1:00.0 to group 49
[   15.505800] iommu: Adding device 0000:c1:00.2 to group 49
[   15.511219] iommu: Adding device 0000:c2:00.0 to group 50
[   15.516633] iommu: Adding device 0000:c2:00.1 to group 50
[   15.523294] iommu: Adding device 0000:e0:01.0 to group 51
[   15.530010] iommu: Adding device 0000:e0:02.0 to group 52
[   15.536657] iommu: Adding device 0000:e0:03.0 to group 53
[   15.543468] iommu: Adding device 0000:e0:04.0 to group 54
[   15.550252] iommu: Adding device 0000:e0:07.0 to group 55
[   15.555717] iommu: Adding device 0000:e0:07.1 to group 55
[   15.562374] iommu: Adding device 0000:e0:08.0 to group 56
[   15.567840] iommu: Adding device 0000:e0:08.1 to group 56
[   15.573265] iommu: Adding device 0000:e1:00.0 to group 55
[   15.578682] iommu: Adding device 0000:e1:00.2 to group 55
[   15.584098] iommu: Adding device 0000:e2:00.0 to group 56
[   15.589512] iommu: Adding device 0000:e2:00.1 to group 56
[   15.595104] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
[   15.600416] AMD-Vi: Extended features (0xf77ef22294ada):
[   15.605728]  PPR NX GT IA GA PC GA_vAPIC
[   15.609656] AMD-Vi: Found IOMMU at 0000:20:00.2 cap 0x40
[   15.614968] AMD-Vi: Extended features (0xf77ef22294ada):
[   15.620280]  PPR NX GT IA GA PC GA_vAPIC
[   15.624207] AMD-Vi: Found IOMMU at 0000:40:00.2 cap 0x40
[   15.629522] AMD-Vi: Extended features (0xf77ef22294ada):
[   15.634833]  PPR NX GT IA GA PC GA_vAPIC
[   15.638758] AMD-Vi: Found IOMMU at 0000:60:00.2 cap 0x40
[   15.644072] AMD-Vi: Extended features (0xf77ef22294ada):
[   15.649384]  PPR NX GT IA GA PC GA_vAPIC
[   15.653310] AMD-Vi: Found IOMMU at 0000:80:00.2 cap 0x40
[   15.658622] AMD-Vi: Extended features (0xf77ef22294ada):
[   15.663935]  PPR NX GT IA GA PC GA_vAPIC
[   15.667862] AMD-Vi: Found IOMMU at 0000:a0:00.2 cap 0x40
[   15.673175] AMD-Vi: Extended features (0xf77ef22294ada):
[   15.678486]  PPR NX GT IA GA PC GA_vAPIC
[   15.682413] AMD-Vi: Found IOMMU at 0000:c0:00.2 cap 0x40
[   15.687725] AMD-Vi: Extended features (0xf77ef22294ada):
[   15.693038]  PPR NX GT IA GA PC GA_vAPIC
[   15.696964] AMD-Vi: Found IOMMU at 0000:e0:00.2 cap 0x40
[   15.702278] AMD-Vi: Extended features (0xf77ef22294ada):
[   15.707591]  PPR NX GT IA GA PC GA_vAPIC
[   15.712549] AMD-Vi: Lazy IO/TLB flushing enabled
[   15.718153] amd_uncore: AMD NB counters detected
[   15.722794] amd_uncore: AMD LLC counters detected
[   15.731772] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters=
/bank).
[   15.738922] perf/amd_iommu: Detected AMD IOMMU #1 (2 banks, 4 counters=
/bank).
[   15.746074] perf/amd_iommu: Detected AMD IOMMU #2 (2 banks, 4 counters=
/bank).
[   15.753233] perf/amd_iommu: Detected AMD IOMMU #3 (2 banks, 4 counters=
/bank).
[   15.760388] perf/amd_iommu: Detected AMD IOMMU #4 (2 banks, 4 counters=
/bank).
[   15.767538] perf/amd_iommu: Detected AMD IOMMU #5 (2 banks, 4 counters=
/bank).
[   15.774722] perf/amd_iommu: Detected AMD IOMMU #6 (2 banks, 4 counters=
/bank).
[   15.781899] perf/amd_iommu: Detected AMD IOMMU #7 (2 banks, 4 counters=
/bank).
[   15.791935] workingset: timestamp_bits=3D40 max_order=3D28 bucket_orde=
r=3D0
[   15.800209] SGI XFS with ACLs, security attributes, realtime, no debug=
 enabled
[   15.810982] Block layer SCSI generic (bsg) driver version 0.4 loaded (=
major 249)
[   15.818801] io scheduler noop registered
[   15.822732] io scheduler deadline registered
[   15.827066] io scheduler cfq registered (default)
[   15.831778] io scheduler mq-deadline registered
[   15.836311] io scheduler kyber registered
[   15.855323] pcieport 0000:00:01.1: Signaling PME with IRQ 34
[   15.861307] pcieport 0000:00:01.3: Signaling PME with IRQ 35
[   15.867337] pcieport 0000:00:01.4: Signaling PME with IRQ 36
[   15.873332] pcieport 0000:00:07.1: Signaling PME with IRQ 37
[   15.879361] pcieport 0000:00:08.1: Signaling PME with IRQ 39
[   15.885392] pcieport 0000:20:07.1: Signaling PME with IRQ 40
[   15.891408] pcieport 0000:20:08.1: Signaling PME with IRQ 42
[   15.897127] pcieport 0000:40:07.1: Signaling PME with IRQ 44
[   15.902849] pcieport 0000:40:08.1: Signaling PME with IRQ 46
[   15.908572] pcieport 0000:60:03.1: Signaling PME with IRQ 47
[   15.914382] pcieport 0000:60:07.1: Signaling PME with IRQ 49
[   15.920386] pcieport 0000:60:08.1: Signaling PME with IRQ 51
[   15.926799] pcieport 0000:80:07.1: Signaling PME with IRQ 53
[   15.932818] pcieport 0000:80:08.1: Signaling PME with IRQ 55
[   15.938545] pcieport 0000:a0:07.1: Signaling PME with IRQ 57
[   15.944274] pcieport 0000:a0:08.1: Signaling PME with IRQ 59
[   15.950092] pcieport 0000:c0:07.1: Signaling PME with IRQ 61
[   15.956102] pcieport 0000:c0:08.1: Signaling PME with IRQ 63
[   15.961821] pcieport 0000:e0:07.1: Signaling PME with IRQ 65
[   15.967546] pcieport 0000:e0:08.1: Signaling PME with IRQ 67
[   15.973242] version 39.2
[   15.975791] ipmi device interface
[   15.979135] IPMI System Interface driver.
[   15.983163] ipmi_si dmi-ipmi-si.0: ipmi_platform: probing via SMBIOS
[   15.989522] ipmi_si: SMBIOS: io 0xca8 regsize 1 spacing 4 irq 10
[   15.995530] ipmi_si: Adding SMBIOS-specified kcs state machine
[   16.001386] ipmi_si IPI0001:00: ipmi_platform: probing via ACPI
[   16.007335] ipmi_si IPI0001:00: [io  0x0ca8] regsize 1 spacing 4 irq 1=
0
[   16.013953] ipmi_si dmi-ipmi-si.0: Removing SMBIOS-specified kcs state=
 machine in favor of ACPI
[   16.022645] ipmi_si: Adding ACPI-specified kcs state machine
[   16.028346] ipmi_si: Trying ACPI-specified kcs state machine at i/o ad=
dress 0xca8, slave address 0x20, irq 10
[   16.152558] ipmi_si IPI0001:00: The BMC does not support setting the r=
ecv irq bit, compensating, but the BMC needs to be fixed.
[   16.184641] ipmi_si IPI0001:00: Using irq 10
[   16.218717] ipmi_si IPI0001:00: Found new BMC (man_id: 0x0002a2, prod_=
id: 0x0100, dev_id: 0x20)
[   16.343499] ipmi_si IPI0001:00: IPMI kcs interface initialized
[   16.357659] IPMI Watchdog: driver initialized
[   16.362021] Copyright (C) 2004 MontaVista Software - IPMI Powerdown vi=
a sys_reboot.
[   16.378719] IPMI poweroff: ATCA Detect mfg 0x2A2 prod 0x100
[   16.384293] IPMI poweroff: Found a chassis style poweroff function
[   16.390528] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PN=
P0C0C:00/input/input0
[   16.398888] ACPI: Power Button [PWRB]
[   16.402766] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/in=
put/input1
[   16.410277] ACPI: Power Button [PWRF]
[   16.418814] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[   16.446131] 00:02: ttyS1 at I/O 0x2f8 (irq =3D 3, base_baud =3D 115200=
) is a 16550A
[   16.474428] 00:03: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200=
) is a 16550A
[   16.482197] lp: driver loaded but no devices found
[   16.487097] Linux agpgart interface v0.103
[   16.524969] brd: module loaded
[   16.536698] loop: module loaded
[   16.560408] drbd: initialized. Version: 8.4.10 (api:1/proto:86-101)
[   16.566678] drbd: built-in
[   16.569389] drbd: registered as block device major 147
[   16.574715] Uniform Multi-Platform E-IDE driver
[   16.579738] ide_generic: please use "probe_mask=3D0x3f" module paramet=
er for probing all legacy ISA IDE ports
[   16.817563] tsc: Refined TSC clocksource calibration: 2195.874 MHz
[   16.823945] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1=
fa6f9655b2, max_idle_ns: 440795314254 ns
[   16.834311] clocksource: Switched to clocksource tsc
[   17.115635] ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
[   17.646628] ide1 at 0x170-0x177,0x376 on irq 15
[   17.651172] ide-gd driver 1.18
[   17.654240] ide-cd driver 5.00
[   17.657657] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 =
EST 2006)
[   17.665000] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST =
2006)
[   17.671985] megasas: 07.706.03.00-rc1
[   17.676040] megaraid_sas 0000:61:00.0: FW now in Ready state
[   17.681715] megaraid_sas 0000:61:00.0: 64 bit DMA mask and 64 bit cons=
istent mask
[   17.690896] megaraid_sas 0000:61:00.0: firmware supports msix	: (128)
[   17.697345] megaraid_sas 0000:61:00.0: current msix/online cpus	: (128=
/128)
[   17.704311] megaraid_sas 0000:61:00.0: RDPQ mode	: (enabled)
[   17.709970] megaraid_sas 0000:61:00.0: Current firmware supports maxim=
um commands: 5101	 LDIO threshold: 0
[   17.723669] megaraid_sas 0000:61:00.0: Configured max firmware command=
s: 5100
[   17.772041] megaraid_sas 0000:61:00.0: FW supports sync cache	: Yes
[   17.845559] megaraid_sas 0000:61:00.0: firmware type	: Extended VD(240=
 VD)firmware
[   17.853127] megaraid_sas 0000:61:00.0: controller type	: MR(8192MB)
[   17.859394] megaraid_sas 0000:61:00.0: Online Controller Reset(OCR)	: =
Enabled
[   17.866535] megaraid_sas 0000:61:00.0: Secure JBOD support	: No
[   17.872462] megaraid_sas 0000:61:00.0: NVMe passthru support	: Yes
[   17.878642] megaraid_sas 0000:61:00.0: FW provided TM TaskAbort/Reset =
timeout	: 0 secs/0 secs
[   17.910692] megaraid_sas 0000:61:00.0: NVME page size	: (4096)
[   17.917319] megaraid_sas 0000:61:00.0: INIT adapter done
[   17.930712] megaraid_sas 0000:61:00.0: pci id		: (0x1000)/(0x0016)/(0x=
1028)/(0x1fcb)
[   17.938461] megaraid_sas 0000:61:00.0: unevenspan support	: yes
[   17.944428] megaraid_sas 0000:61:00.0: firmware crash dump	: no
[   17.950347] megaraid_sas 0000:61:00.0: jbod sync map		: yes
[   17.955924] scsi host0: Avago SAS based MegaRAID driver
[   17.964950] mpt3sas version 26.100.00.00 loaded
[   17.970832] ahci 0000:06:00.2: AHCI 0001.0301 32 slots 1 ports 6 Gbps =
0x1 impl SATA mode
[   17.978930] ahci 0000:06:00.2: flags: 64bit ncq sntf ilck pm led clo o=
nly pmp fbs pio slum part=20
[   17.988113] scsi host1: ahci
[   17.991162] ata1: SATA max UDMA/133 abar m4096@0xf9a02000 port 0xf9a02=
100 irq 198
[   17.999306] tun: Universal TUN/TAP device driver, 1.6
[   18.004564] bnx2x: QLogic 5771x/578xx 10/20-Gigabit Ethernet Driver bn=
x2x 1.712.30-0 (2014/02/10)
[   18.013888] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[   18.019988] e100: Copyright(c) 1999-2006 Intel Corporation
[   18.025511] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k=
8-NAPI
[   18.032562] e1000: Copyright (c) 1999-2006 Intel Corporation.
[   18.038344] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[   18.043982] scsi 0:2:0:0: Direct-Access     ATA      HUS722T2TALA600  =
MU03 PQ: 0 ANSI: 6
[   18.044183] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[   18.056129] scsi 0:2:1:0: Direct-Access     ATA      HUS722T2TALA600  =
MU03 PQ: 0 ANSI: 6
[   18.058247] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.=
4.0-k
[   18.069687] scsi 0:2:2:0: Direct-Access     SEAGATE  ST8000NM0195     =
PT71 PQ: 0 ANSI: 6
[   18.073268] igb: Copyright (c) 2007-2014 Intel Corporation.
[   18.084447] scsi 0:2:3:0: Direct-Access     SEAGATE  ST8000NM0195     =
PT71 PQ: 0 ANSI: 6
[   18.137926] igb 0000:04:00.0: added PHC on eth0
[   18.142478] igb 0000:04:00.0: Intel(R) Gigabit Ethernet Network Connec=
tion
[   18.149361] igb 0000:04:00.0: eth0: (PCIe:5.0Gb/s:Width x2) e4:43:4b:1=
3:5a:14
[   18.156791] igb 0000:04:00.0: eth0: PBA No: G61346-018
[   18.161948] igb 0000:04:00.0: Using MSI-X interrupts. 8 rx queue(s), 8=
 tx queue(s)
[   18.186796] sd 0:2:0:0: Attached scsi generic sg0 type 0
[   18.190503] sd 0:2:0:0: [sda] 3907029168 512-byte logical blocks: (2.0=
0 TB/1.82 TiB)
[   18.192255] sd 0:2:1:0: Attached scsi generic sg1 type 0
[   18.195770] sd 0:2:1:0: [sdb] 3907029168 512-byte logical blocks: (2.0=
0 TB/1.82 TiB)
[   18.203531] sd 0:2:1:0: [sdb] Write Protect is off
[   18.205325] sd 0:2:2:0: Attached scsi generic sg2 type 0
[   18.205934] sd 0:2:2:0: [sdc] Disabling DIF Type 2 protection
[   18.207475] sd 0:2:2:0: [sdc] 1953506646 4096-byte logical blocks: (8.=
00 TB/7.28 TiB)
[   18.207605] sd 0:2:0:0: [sda] Write Protect is off
[   18.208196] sd 0:2:2:0: [sdc] Write Protect is off
[   18.209480] sd 0:2:2:0: [sdc] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   18.210199] sd 0:2:0:0: [sda] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   18.214412] sd 0:2:1:0: [sdb] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   18.217927] sd 0:2:3:0: Attached scsi generic sg3 type 0
[   18.218529] sd 0:2:3:0: [sdd] Disabling DIF Type 2 protection
[   18.220070] sd 0:2:3:0: [sdd] 1953506646 4096-byte logical blocks: (8.=
00 TB/7.28 TiB)
[   18.220790] sd 0:2:3:0: [sdd] Write Protect is off
[   18.220878] sd 0:2:2:0: [sdc] Attached SCSI disk
[   18.220911] igb 0000:04:00.1: added PHC on eth1
[   18.220913] igb 0000:04:00.1: Intel(R) Gigabit Ethernet Network Connec=
tion
[   18.220914] igb 0000:04:00.1: eth1: (PCIe:5.0Gb/s:Width x2) e4:43:4b:1=
3:5a:15
[   18.221229] igb 0000:04:00.1: eth1: PBA No: G61346-018
[   18.221230] igb 0000:04:00.1: Using MSI-X interrupts. 8 rx queue(s), 8=
 tx queue(s)
[   18.221268] igbvf: Intel(R) Gigabit Virtual Function Network Driver - =
version 2.4.0-k
[   18.221269] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[   18.221315] sky2: driver version 1.30
[   18.221588] Fusion MPT base driver 3.04.20
[   18.221589] Copyright (c) 1999-2008 LSI Corporation
[   18.221593] Fusion MPT SPI Host driver 3.04.20
[   18.221619] Fusion MPT FC Host driver 3.04.20
[   18.221645] Fusion MPT SAS Host driver 3.04.20
[   18.221670] Fusion MPT misc device (ioctl) driver 3.04.20
[   18.221692] mptctl: Registered with Fusion MPT base driver
[   18.221693] mptctl: /dev/mptctl @ (major,minor=3D10,220)
[   18.221699] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver=

[   18.221699] ehci-pci: EHCI PCI platform driver
[   18.221722] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[   18.221727] ohci-pci: OHCI PCI platform driver
[   18.221749] uhci_hcd: USB Universal Host Controller Interface driver
[   18.221924] xhci_hcd 0000:05:00.3: xHCI Host Controller
[   18.221931] xhci_hcd 0000:05:00.3: new USB bus registered, assigned bu=
s number 1
[   18.222052] xhci_hcd 0000:05:00.3: hcc params 0x0270f665 hci version 0=
x100 quirks 0x0000000000000410
[   18.222100] sd 0:2:3:0: [sdd] Write cache: disabled, read cache: enabl=
ed, supports DPO and FUA
[   18.222489] hub 1-0:1.0: USB hub found
[   18.222497] hub 1-0:1.0: 2 ports detected
[   18.222823] xhci_hcd 0000:05:00.3: xHCI Host Controller
[   18.222827] xhci_hcd 0000:05:00.3: new USB bus registered, assigned bu=
s number 2
[   18.222830] xhci_hcd 0000:05:00.3: Host supports USB 3.0 SuperSpeed
[   18.222845] usb usb2: We don't know the algorithms for LPM for this ho=
st, disabling LPM.
[   18.222985] hub 2-0:1.0: USB hub found
[   18.222991] hub 2-0:1.0: 2 ports detected
[   18.223470] xhci_hcd 0000:21:00.3: xHCI Host Controller
[   18.233353] sd 0:2:3:0: [sdd] Attached SCSI disk
[   18.236741] xhci_hcd 0000:21:00.3: new USB bus registered, assigned bu=
s number 3
[   18.284504]  sda: sda1 sda2 sda3
[   18.291167] xhci_hcd 0000:21:00.3: hcc params 0x0270f665 hci version 0=
x100 quirks 0x0000000000000410
[   18.310627] ata1: SATA link down (SStatus 0 SControl 300)
[   18.312373] hub 3-0:1.0: USB hub found
[   18.385144] sd 0:2:0:0: [sda] Attached SCSI disk
[   18.387416] hub 3-0:1.0: 2 ports detected
[   18.392419] sd 0:2:1:0: [sdb] Attached SCSI disk
[   18.540581] xhci_hcd 0000:21:00.3: xHCI Host Controller
[   18.545810] xhci_hcd 0000:21:00.3: new USB bus registered, assigned bu=
s number 4
[   18.546561] usb 1-1: new high-speed USB device number 2 using xhci_hcd=

[   18.553210] xhci_hcd 0000:21:00.3: Host supports USB 3.0 SuperSpeed
[   18.553225] usb usb4: We don't know the algorithms for LPM for this ho=
st, disabling LPM.
[   18.574333] hub 4-0:1.0: USB hub found
[   18.578098] hub 4-0:1.0: 2 ports detected
[   18.582394] usbcore: registered new interface driver usb-storage
[   18.588431] usbcore: registered new interface driver ftdi_sio
[   18.594191] usbserial: USB Serial support registered for FTDI USB Seri=
al Device
[   18.601524] usbcore: registered new interface driver omninet
[   18.607190] usbserial: USB Serial support registered for ZyXEL - omni.=
net lcd plus usb
[   18.615131] i8042: PNP: No PS/2 controller found.
[   18.619957] rtc_cmos 00:01: RTC can wake from S4
[   18.624867] rtc_cmos 00:01: registered as rtc0
[   18.629339] rtc_cmos 00:01: alarms up to one month, y3k, 114 bytes nvr=
am, hpet irqs
[   18.637255] piix4_smbus 0000:00:14.0: SMBus Host Controller at 0xb00, =
revision 0
[   18.644654] piix4_smbus 0000:00:14.0: Using register 0x02 for SMBus po=
rt selection
[   18.652434] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.11
[   18.658020] iTCO_vendor_support: vendor-support=3D0
[   18.662750] nv_tco: NV TCO WatchDog Timer Driver v0.01
[   18.668458] EDAC amd64: Node 0: DRAM ECC enabled.
[   18.673164] EDAC amd64: F17h detected (node 0).
[   18.677737] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   18.682444] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   18.687150] EDAC amd64: MC: 4:     0MB 5:     0MB
[   18.691859] EDAC amd64: MC: 6:     0MB 7:     0MB
[   18.696564] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   18.701269] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   18.705974] EDAC amd64: MC: 4:     0MB 5:     0MB
[   18.710680] EDAC amd64: MC: 6:     0MB 7:     0MB
[   18.715386] EDAC amd64: using x8 syndromes.
[   18.719571] EDAC amd64: MCT channel count: 2
[   18.724011] EDAC MC0: Giving out device to module amd64_edac controlle=
r F17h: DEV 0000:00:18.3 (INTERRUPT)
[   18.733661] EDAC amd64: Node 1: DRAM ECC enabled.
[   18.734986] hub 1-1:1.0: USB hub found
[   18.738371] EDAC amd64: F17h detected (node 1).
[   18.742346] hub 1-1:1.0: 4 ports detected
[   18.746663] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   18.746664] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   18.746664] EDAC amd64: MC: 4:     0MB 5:     0MB
[   18.746665] EDAC amd64: MC: 6:     0MB 7:     0MB
[   18.769511] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   18.774215] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   18.778921] EDAC amd64: MC: 4:     0MB 5:     0MB
[   18.783627] EDAC amd64: MC: 6:     0MB 7:     0MB
[   18.788332] EDAC amd64: using x8 syndromes.
[   18.792520] EDAC amd64: MCT channel count: 2
[   18.796950] EDAC MC1: Giving out device to module amd64_edac controlle=
r F17h: DEV 0000:00:19.3 (INTERRUPT)
[   18.802600] usb 2-2: new SuperSpeed Gen 1 USB device number 2 using xh=
ci_hcd
[   18.806610] EDAC amd64: Node 2: DRAM ECC enabled.
[   18.818366] EDAC amd64: F17h detected (node 2).
[   18.822940] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   18.827645] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   18.832352] EDAC amd64: MC: 4:     0MB 5:     0MB
[   18.837056] EDAC amd64: MC: 6:     0MB 7:     0MB
[   18.841766] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   18.846477] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   18.846988] hub 2-2:1.0: USB hub found
[   18.851186] EDAC amd64: MC: 4:     0MB 5:     0MB
[   18.851187] EDAC amd64: MC: 6:     0MB 7:     0MB
[   18.851187] EDAC amd64: using x8 syndromes.
[   18.851188] EDAC amd64: MCT channel count: 2
[   18.851336] EDAC MC2: Giving out device to module amd64_edac controlle=
r F17h: DEV 0000:00:1a.3 (INTERRUPT)
[   18.855220] hub 2-2:1.0: 3 ports detected
[   18.859657] EDAC amd64: Node 3: DRAM ECC enabled.
[   18.869566] usb 3-2: new full-speed USB device number 2 using xhci_hcd=

[   18.872818] EDAC amd64: F17h detected (node 3).
[   18.902259] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   18.906970] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   18.911677] EDAC amd64: MC: 4:     0MB 5:     0MB
[   18.916383] EDAC amd64: MC: 6:     0MB 7:     0MB
[   18.921091] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   18.925794] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   18.930500] EDAC amd64: MC: 4:     0MB 5:     0MB
[   18.935206] EDAC amd64: MC: 6:     0MB 7:     0MB
[   18.939913] EDAC amd64: using x8 syndromes.
[   18.940563] usb 1-2: new high-speed USB device number 3 using xhci_hcd=

[   18.944102] EDAC amd64: MCT channel count: 2
[   18.944244] EDAC MC3: Giving out device to module amd64_edac controlle=
r F17h: DEV 0000:00:1b.3 (INTERRUPT)
[   18.964561] EDAC amd64: Node 4: DRAM ECC enabled.
[   18.969269] EDAC amd64: F17h detected (node 4).
[   18.973854] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   18.978566] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   18.983273] EDAC amd64: MC: 4:     0MB 5:     0MB
[   18.987977] EDAC amd64: MC: 6:     0MB 7:     0MB
[   18.992687] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   18.997397] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   19.002104] EDAC amd64: MC: 4:     0MB 5:     0MB
[   19.006812] EDAC amd64: MC: 6:     0MB 7:     0MB
[   19.011516] EDAC amd64: using x8 syndromes.
[   19.015702] EDAC amd64: MCT channel count: 2
[   19.020119] EDAC MC4: Giving out device to module amd64_edac controlle=
r F17h: DEV 0000:00:1c.3 (INTERRUPT)
[   19.029776] EDAC amd64: Node 5: DRAM ECC enabled.
[   19.034248] usb 3-2: config 1 interface 0 altsetting 0 has 2 endpoint =
descriptors, different from the interface descriptor's value: 1
[   19.034486] EDAC amd64: F17h detected (node 5).
[   19.051068] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   19.055779] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   19.060485] EDAC amd64: MC: 4:     0MB 5:     0MB
[   19.065188] EDAC amd64: MC: 6:     0MB 7:     0MB
[   19.069899] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   19.074609] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   19.079315] EDAC amd64: MC: 4:     0MB 5:     0MB
[   19.084024] EDAC amd64: MC: 6:     0MB 7:     0MB
[   19.088727] EDAC amd64: using x8 syndromes.
[   19.092914] EDAC amd64: MCT channel count: 2
[   19.097341] EDAC MC5: Giving out device to module amd64_edac controlle=
r F17h: DEV 0000:00:1d.3 (INTERRUPT)
[   19.106996] EDAC amd64: Node 6: DRAM ECC enabled.
[   19.111705] EDAC amd64: F17h detected (node 6).
[   19.116288] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   19.118988] hub 1-2:1.0: USB hub found
[   19.120994] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   19.120995] EDAC amd64: MC: 4:     0MB 5:     0MB
[   19.120995] EDAC amd64: MC: 6:     0MB 7:     0MB
[   19.124972] hub 1-2:1.0: 3 ports detected
[   19.129462] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   19.129463] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   19.129463] EDAC amd64: MC: 4:     0MB 5:     0MB
[   19.129464] EDAC amd64: MC: 6:     0MB 7:     0MB
[   19.129464] EDAC amd64: using x8 syndromes.
[   19.129464] EDAC amd64: MCT channel count: 2
[   19.129625] EDAC MC6: Giving out device to module amd64_edac controlle=
r F17h: DEV 0000:00:1e.3 (INTERRUPT)
[   19.179837] EDAC amd64: Node 7: DRAM ECC enabled.
[   19.184549] EDAC amd64: F17h detected (node 7).
[   19.189145] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   19.193854] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   19.198561] EDAC amd64: MC: 4:     0MB 5:     0MB
[   19.203268] EDAC amd64: MC: 6:     0MB 7:     0MB
[   19.207975] EDAC amd64: MC: 0: 65535MB 1: 65535MB
[   19.212687] EDAC amd64: MC: 2: 65535MB 3: 65535MB
[   19.217393] EDAC amd64: MC: 4:     0MB 5:     0MB
[   19.222098] EDAC amd64: MC: 6:     0MB 7:     0MB
[   19.226805] EDAC amd64: using x8 syndromes.
[   19.230991] EDAC amd64: MCT channel count: 2
[   19.235428] EDAC MC7: Giving out device to module amd64_edac controlle=
r F17h: DEV 0000:00:1f.3 (INTERRUPT)
[   19.245087] EDAC PCI0: Giving out device to module amd64_edac controll=
er EDAC PCI controller: DEV 0000:00:18.0 (POLLED)
[   19.255866] AMD64 EDAC driver v3.5.0
[   19.259446] EFI Variables Facility v0.08 2004-May-17
[   19.296951] hidraw: raw HID events driver (C) Jiri Kosina
[   19.313300] usbcore: registered new interface driver usbhid
[   19.318882] usbhid: USB HID core driver
[   19.323697] Key type dns_resolver registered
[   19.334648] mce: Using 23 MCE banks
[   19.338202] microcode: CPU0: patch_level=3D0x08001230
[   19.343096] microcode: CPU1: patch_level=3D0x08001230
[   19.347999] microcode: CPU2: patch_level=3D0x08001230
[   19.352896] microcode: CPU3: patch_level=3D0x08001230
[   19.357800] microcode: CPU4: patch_level=3D0x08001230
[   19.362700] microcode: CPU5: patch_level=3D0x08001230
[   19.367602] microcode: CPU6: patch_level=3D0x08001230
[   19.372502] microcode: CPU7: patch_level=3D0x08001230
[   19.377405] microcode: CPU8: patch_level=3D0x08001230
[   19.382305] microcode: CPU9: patch_level=3D0x08001230
[   19.387207] microcode: CPU10: patch_level=3D0x08001230
[   19.392192] microcode: CPU11: patch_level=3D0x08001230
[   19.397182] microcode: CPU12: patch_level=3D0x08001230
[   19.402166] microcode: CPU13: patch_level=3D0x08001230
[   19.407157] microcode: CPU14: patch_level=3D0x08001230
[   19.412144] microcode: CPU15: patch_level=3D0x08001230
[   19.417131] microcode: CPU16: patch_level=3D0x08001230
[   19.422115] microcode: CPU17: patch_level=3D0x08001230
[   19.427098] microcode: CPU18: patch_level=3D0x08001230
[   19.432081] microcode: CPU19: patch_level=3D0x08001230
[   19.437066] microcode: CPU20: patch_level=3D0x08001230
[   19.442050] microcode: CPU21: patch_level=3D0x08001230
[   19.447031] microcode: CPU22: patch_level=3D0x08001230
[   19.452014] microcode: CPU23: patch_level=3D0x08001230
[   19.456998] microcode: CPU24: patch_level=3D0x08001230
[   19.461981] microcode: CPU25: patch_level=3D0x08001230
[   19.466964] microcode: CPU26: patch_level=3D0x08001230
[   19.468561] usb 1-2.1: new full-speed USB device number 4 using xhci_h=
cd
[   19.471949] microcode: CPU27: patch_level=3D0x08001230
[   19.483631] microcode: CPU28: patch_level=3D0x08001230
[   19.488614] microcode: CPU29: patch_level=3D0x08001230
[   19.493596] microcode: CPU30: patch_level=3D0x08001230
[   19.498572] microcode: CPU31: patch_level=3D0x08001230
[   19.503559] microcode: CPU32: patch_level=3D0x08001230
[   19.508539] microcode: CPU33: patch_level=3D0x08001230
[   19.513520] microcode: CPU34: patch_level=3D0x08001230
[   19.518497] microcode: CPU35: patch_level=3D0x08001230
[   19.523481] microcode: CPU36: patch_level=3D0x08001230
[   19.528463] microcode: CPU37: patch_level=3D0x08001230
[   19.533445] microcode: CPU38: patch_level=3D0x08001230
[   19.538429] microcode: CPU39: patch_level=3D0x08001230
[   19.543413] microcode: CPU40: patch_level=3D0x08001230
[   19.548400] microcode: CPU41: patch_level=3D0x08001230
[   19.553377] microcode: CPU42: patch_level=3D0x08001230
[   19.558354] microcode: CPU43: patch_level=3D0x08001230
[   19.563338] microcode: CPU44: patch_level=3D0x08001230
[   19.568321] microcode: CPU45: patch_level=3D0x08001230
[   19.568570] floppy0: no floppy controllers found
[   19.573305] microcode: CPU46: patch_level=3D0x08001230
[   19.582916] microcode: CPU47: patch_level=3D0x08001230
[   19.587896] microcode: CPU48: patch_level=3D0x08001230
[   19.592876] microcode: CPU49: patch_level=3D0x08001230
[   19.597856] microcode: CPU50: patch_level=3D0x08001230
[   19.602841] microcode: CPU51: patch_level=3D0x08001230
[   19.607823] microcode: CPU52: patch_level=3D0x08001230
[   19.612804] microcode: CPU53: patch_level=3D0x08001230
[   19.617780] microcode: CPU54: patch_level=3D0x08001230
[   19.622753] microcode: CPU55: patch_level=3D0x08001230
[   19.627729] microcode: CPU56: patch_level=3D0x08001230
[   19.632704] microcode: CPU57: patch_level=3D0x08001230
[   19.637689] microcode: CPU58: patch_level=3D0x08001230
[   19.641558] usb 1-1.1: new high-speed USB device number 5 using xhci_h=
cd
[   19.642670] microcode: CPU59: patch_level=3D0x08001230
[   19.654355] microcode: CPU60: patch_level=3D0x08001230
[   19.659337] microcode: CPU61: patch_level=3D0x08001230
[   19.664322] microcode: CPU62: patch_level=3D0x08001230
[   19.667197] input: Peppercon AG Multidevice as /devices/pci0000:00/000=
0:00:07.1/0000:05:00.3/usb1/1-2/1-2.1/1-2.1:1.0/0003:14DD:0002.0002/input=
/input2
[   19.669306] microcode: CPU63: patch_level=3D0x08001230
[   19.687738] microcode: CPU64: patch_level=3D0x08001230
[   19.692713] microcode: CPU65: patch_level=3D0x08001230
[   19.697696] microcode: CPU66: patch_level=3D0x08001230
[   19.702669] microcode: CPU67: patch_level=3D0x08001230
[   19.707654] microcode: CPU68: patch_level=3D0x08001230
[   19.712628] microcode: CPU69: patch_level=3D0x08001230
[   19.717601] microcode: CPU70: patch_level=3D0x08001230
[   19.722577] microcode: CPU71: patch_level=3D0x08001230
[   19.727558] microcode: CPU72: patch_level=3D0x08001230
[   19.732538] microcode: CPU73: patch_level=3D0x08001230
[   19.734697] hid-generic 0003:14DD:0002.0002: input,hidraw0: USB HID v1=
=2E01 Keyboard [Peppercon AG Multidevice] on usb-0000:05:00.3-2.1/input0
[   19.737519] microcode: CPU74: patch_level=3D0x08001230
[   19.753111] input: Peppercon AG Multidevice as /devices/pci0000:00/000=
0:00:07.1/0000:05:00.3/usb1/1-2/1-2.1/1-2.1:1.1/0003:14DD:0002.0003/input=
/input3
[   19.755087] microcode: CPU75: patch_level=3D0x08001230
[   19.768682] hid-generic 0003:14DD:0002.0003: input,hidraw1: USB HID v1=
=2E01 Mouse [Peppercon AG Multidevice] on usb-0000:05:00.3-2.1/input1
[   19.773532] microcode: CPU76: patch_level=3D0x08001230
[   19.790844] microcode: CPU77: patch_level=3D0x08001230
[   19.795818] microcode: CPU78: patch_level=3D0x08001230
[   19.800796] microcode: CPU79: patch_level=3D0x08001230
[   19.805778] microcode: CPU80: patch_level=3D0x08001230
[   19.810759] microcode: CPU81: patch_level=3D0x08001230
[   19.815734] microcode: CPU82: patch_level=3D0x08001230
[   19.820711] microcode: CPU83: patch_level=3D0x08001230
[   19.822984] hub 1-1.1:1.0: USB hub found
[   19.825694] microcode: CPU84: patch_level=3D0x08001230
[   19.829847] hub 1-1.1:1.0: 4 ports detected
[   19.834595] microcode: CPU85: patch_level=3D0x08001230
[   19.843753] microcode: CPU86: patch_level=3D0x08001230
[   19.848730] microcode: CPU87: patch_level=3D0x08001230
[   19.853713] microcode: CPU88: patch_level=3D0x08001230
[   19.858688] microcode: CPU89: patch_level=3D0x08001230
[   19.863671] microcode: CPU90: patch_level=3D0x08001230
[   19.868656] microcode: CPU91: patch_level=3D0x08001230
[   19.873637] microcode: CPU92: patch_level=3D0x08001230
[   19.878610] microcode: CPU93: patch_level=3D0x08001230
[   19.883584] microcode: CPU94: patch_level=3D0x08001230
[   19.888560] microcode: CPU95: patch_level=3D0x08001230
[   19.893534] microcode: CPU96: patch_level=3D0x08001230
[   19.898511] microcode: CPU97: patch_level=3D0x08001230
[   19.903491] microcode: CPU98: patch_level=3D0x08001230
[   19.904557] usb 1-1.4: new high-speed USB device number 6 using xhci_h=
cd
[   19.908467] microcode: CPU99: patch_level=3D0x08001230
[   19.920144] microcode: CPU100: patch_level=3D0x08001230
[   19.925210] microcode: CPU101: patch_level=3D0x08001230
[   19.930272] microcode: CPU102: patch_level=3D0x08001230
[   19.935335] microcode: CPU103: patch_level=3D0x08001230
[   19.940403] microcode: CPU104: patch_level=3D0x08001230
[   19.945463] microcode: CPU105: patch_level=3D0x08001230
[   19.950528] microcode: CPU106: patch_level=3D0x08001230
[   19.955596] microcode: CPU107: patch_level=3D0x08001230
[   19.960666] microcode: CPU108: patch_level=3D0x08001230
[   19.965727] microcode: CPU109: patch_level=3D0x08001230
[   19.970791] microcode: CPU110: patch_level=3D0x08001230
[   19.975861] microcode: CPU111: patch_level=3D0x08001230
[   19.980930] microcode: CPU112: patch_level=3D0x08001230
[   19.985991] microcode: CPU113: patch_level=3D0x08001230
[   19.991053] microcode: CPU114: patch_level=3D0x08001230
[   19.996123] microcode: CPU115: patch_level=3D0x08001230
[   20.001184] microcode: CPU116: patch_level=3D0x08001230
[   20.006246] microcode: CPU117: patch_level=3D0x08001230
[   20.011315] microcode: CPU118: patch_level=3D0x08001230
[   20.016378] microcode: CPU119: patch_level=3D0x08001230
[   20.021446] microcode: CPU120: patch_level=3D0x08001230
[   20.026510] microcode: CPU121: patch_level=3D0x08001230
[   20.031577] microcode: CPU122: patch_level=3D0x08001230
[   20.036638] microcode: CPU123: patch_level=3D0x08001230
[   20.041701] microcode: CPU124: patch_level=3D0x08001230
[   20.046771] microcode: CPU125: patch_level=3D0x08001230
[   20.046985] hub 1-1.4:1.0: USB hub found
[   20.051841] microcode: CPU126: patch_level=3D0x08001230
[   20.055973] hub 1-1.4:1.0: 4 ports detected
[   20.060830] microcode: CPU127: patch_level=3D0x08001230
[   20.070115] microcode: Microcode Update Driver: v2.2.
[   20.070139] sched_clock: Marking stable (18360690554, 1708859799)->(20=
895875050, -826324697)
[   20.083746] registered taskstats version 1
[   20.090126] rtc_cmos 00:01: setting system clock to 2019-08-12 08:07:2=
1 UTC (1565597241)
[   20.098293] ALSA device list:
[   20.101268]   No soundcards found.
[   20.491126] Freeing unused kernel image memory: 1576K
[   20.502570] Write protecting the kernel read-only data: 20480k
[   20.510735] Freeing unused kernel image memory: 2008K
[   20.516239] Freeing unused kernel image memory: 720K
[   20.521225] Run /init as init process
[   20.903208] random: crng init done
[   20.912928] XFS (sda1): Mounting V5 Filesystem
[   21.042218] XFS (sda1): Ending clean mount
[   21.829278] systemd[1]: Inserted module 'autofs4'
[   21.971416] NET: Registered protocol family 10
[   21.976940] Segment Routing with IPv6
[   21.993187] NET: Registered protocol family 1
[   21.998469] systemd[1]: Inserted module 'unix'
[   22.278873] systemd[1]: systemd 242 running in system mode. (+PAM -AUD=
IT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP -LIBCRYPTSETUP +GCRYPT =
+GNUTLS +ACL +XZ +LZ4 -SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN -PCRE2 d=
efault-hierarchy=3Dhybrid)
[   22.312591] systemd[1]: Detected architecture x86-64.
[   22.336080] systemd[1]: Set hostname to <kreios.molgen.mpg.de>.
[   22.983056] systemd[1]: Listening on udev Kernel Socket.
[   22.989099] systemd[1]: Condition check resulted in Journal Audit Sock=
et being skipped.
[   22.997131] systemd[1]: Reached target network after root writable.
[   23.004705] systemd[1]: Created slice system-getty.slice.
[   23.010580] systemd[1]: Created slice User and Session Slice.
[   23.016407] systemd[1]: Listening on initctl Compatibility Named Pipe.=

[   23.023411] systemd[1]: Set up automount Arbitrary Executable File For=
mats File System Automount Point.
[   23.449140] RPC: Registered named UNIX socket transport module.
[   23.455080] RPC: Registered udp transport module.
[   23.459796] RPC: Registered tcp transport module.
[   23.464508] RPC: Registered tcp NFSv4.1 backchannel transport module.
[   23.838502] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[   23.972466] systemd-journald[915]: Received request to flush runtime j=
ournal from PID 1
[   24.595454] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - ve=
rsion 5.1.0-k
[   24.603125] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
[   24.772449] ixgbe 0000:01:00.0: Multiqueue Enabled: Rx Queue count =3D=
 63, Tx Queue count =3D 63 XDP Queue count =3D 0
[   24.782927] ixgbe 0000:01:00.0: 32.000 Gb/s available PCIe bandwidth (=
5 GT/s x8 link)
[   24.791088] ixgbe 0000:01:00.0: MAC: 2, PHY: 20, SFP+: 6, PBA No: G613=
46-018
[   24.798140] ixgbe 0000:01:00.0: e4:43:4b:13:5a:10
[   24.805593] ixgbe 0000:01:00.0: Intel(R) 10 Gigabit Network Connection=

[   25.460352] hid-led 0003:27B8:01ED.0001: hidraw2: USB HID v1.01 Device=
 [ThingM blink(1) mk2] on usb-0000:21:00.3-2/input0
[   25.471437] hid-led 0003:27B8:01ED.0001: ThingM blink(1) initialized
[   25.823660] kvm: Nested Virtualization enabled
[   25.828165] kvm: Nested Paging enabled
[   25.831923] SVM: Virtual VMLOAD VMSAVE supported
[   25.831925] SVM: Virtual GIF supported
[   25.951156] ixgbe 0000:01:00.1: Multiqueue Enabled: Rx Queue count =3D=
 63, Tx Queue count =3D 63 XDP Queue count =3D 0
[   25.961634] ixgbe 0000:01:00.1: 32.000 Gb/s available PCIe bandwidth (=
5 GT/s x8 link)
[   25.969807] ixgbe 0000:01:00.1: MAC: 2, PHY: 1, PBA No: G61346-018
[   25.975996] ixgbe 0000:01:00.1: e4:43:4b:13:5a:12
[   25.983596] ixgbe 0000:01:00.1: Intel(R) 10 Gigabit Network Connection=

[   26.232102] [TTM] Zone  kernel: Available graphics memory: 526096136 k=
iB
[   26.238816] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB=

[   26.245349] [TTM] Initializing pool allocator
[   26.249721] [TTM] Initializing DMA pool allocator
[   26.279067] fbcon: mgadrmfb (fb0) is primary device
[   26.279131] Console: switching to colour frame buffer device 128x48
[   26.673077] mgag200 0000:03:00.0: fb0: mgadrmfb frame buffer device
[   26.682577] [drm] Initialized mgag200 1.0.0 20110418 for 0000:03:00.0 =
on minor 0
[   27.713568] igb 0000:04:00.0 net00: renamed from eth0
[   27.730998] igb 0000:04:00.1 net01: renamed from eth1
[   27.756833] ixgbe 0000:01:00.0 net02: renamed from eth2
[   27.772750] ixgbe 0000:01:00.1 net03: renamed from eth3
[ 3022.953645] sysrq: SysRq : Trigger a crash
[ 3022.957822] BUG: unable to handle kernel NULL pointer dereference at 0=
000000000000000
[ 3022.965682] PGD bff6495067 P4D bff6495067 PUD bff666d067 PMD 0=20
[ 3022.971631] Oops: 0002 [#1] SMP NOPTI
[ 3022.975315] CPU: 91 PID: 2897 Comm: sh Kdump: loaded Not tainted 4.19.=
57.mx64.282 #1
[ 3022.983085] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.9.=
3 06/25/2019
[ 3022.990687] RIP: 0010:sysrq_handle_crash+0x12/0x20
[ 3022.995496] Code: 5d 41 5e 41 5f e9 de 83 c6 ff 48 89 ef e8 96 fb ff f=
f e9 ae fe ff ff 90 0f 1f 44 00 00 c7 05 e9 10 66 01 01 00 00 00 0f ae f8=
 <c6> 04 25 00 00 00 00 01 c3 0f 1f 44 00 00 0f 1f 44 00 00 53 8d 5f
[ 3023.014303] RSP: 0018:ffffb05edbcc7df8 EFLAGS: 00010286
[ 3023.019547] RAX: ffffffff9c49ccf0 RBX: 0000000000000063 RCX: 000000000=
0000000
[ 3023.026705] RDX: 0000000000000000 RSI: ffffa3f4bfad54b8 RDI: 000000000=
0000063
[ 3023.033865] RBP: ffffffff9d4ca8a0 R08: 0000000000000807 R09: 000000000=
0000000
[ 3023.041039] R10: 0000000000000000 R11: 000000000000000f R12: 000000000=
0000001
[ 3023.048208] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
[ 3023.055365] FS:  00007f9a6ae43c00(0000) GS:ffffa3f4bfac0000(0000) knlG=
S:0000000000000000
[ 3023.063479] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3023.069258] CR2: 0000000000000000 CR3: 000000bfeaff4000 CR4: 000000000=
03406e0
[ 3023.076416] Call Trace:
[ 3023.078889]  __handle_sysrq+0x84/0x130
[ 3023.082667]  write_sysrq_trigger+0x2b/0x30
[ 3023.086786]  proc_reg_write+0x39/0x60
[ 3023.090480]  __vfs_write+0x36/0x180
[ 3023.093995]  vfs_write+0xb0/0x190
[ 3023.097330]  ksys_write+0x5a/0xe0
[ 3023.100671]  do_syscall_64+0x48/0x100
[ 3023.104365]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 3023.109449] RIP: 0033:0x7f9a6a0d6e44
[ 3023.113052] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 0=
0 00 00 66 90 48 8d 05 21 0b 2d 00 8b 00 85 c0 75 2b b8 01 00 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 04 c3 0f 1f 00 48 8b 15 11 b0 2c 00 f7 d8 64
[ 3023.131867] RSP: 002b:00007ffc76bbbcc8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000001
[ 3023.139459] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f9a6=
a0d6e44
[ 3023.146617] RDX: 0000000000000002 RSI: 00000000006f1cc0 RDI: 000000000=
0000001
[ 3023.153776] RBP: 00000000006f1cc0 R08: 00007f9a6a3a3760 R09: 000000000=
0000001
[ 3023.160932] R10: 00000000000000a0 R11: 0000000000000246 R12: 00007f9a6=
a3a3760
[ 3023.168092] R13: 0000000000000002 R14: 0000000000000002 R15: 000000000=
0000000
[ 3023.175253] Modules linked in: rpcsec_gss_krb5 nfsv4 nfs 8021q garp st=
p mrp llc input_leds mgag200 ttm drm_kms_helper kvm_amd drm drm_panel_ori=
entation_quirks kvm cfbfillrect hid_led cfbimgblt led_class cfbcopyarea f=
b_sys_fops syscopyarea sysfillrect sysimgblt fb font ixgbe irqbypass fbde=
v crc32c_intel nfsd auth_rpcgss oid_registry nfs_acl lockd grace sunrpc e=
fivarfs ip_tables x_tables unix ipv6 autofs4
[ 3023.211039] CR2: 0000000000000000
[    0.000000] Linux version 4.19.57.mx64.282 (root@theinternet.molgen.mp=
g.de) (gcc version 7.3.0 (GCC)) #1 SMP Thu Aug 1 13:01:42 CEST 2019
[    0.000000] Command line: root=3DLABEL=3Droot ro console=3DttyS1,11520=
0n8 console=3Dtty0 irqpoll maxcpus=3D1 reset_devices CRASH elfcorehdr=3D9=
00536K
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating poi=
nt registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 =
bytes, using 'compacted' format.
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000001000-0x000000000008efff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000008ffff] ACP=
I NVS
[    0.000000] BIOS-e820: [mem 0x0000000027000000-0x0000000036f6dfff] usa=
ble
[    0.000000] BIOS-e820: [mem 0x000000006efcf000-0x000000006fdfefff] ACP=
I NVS
[    0.000000] BIOS-e820: [mem 0x000000006fdff000-0x000000006fffefff] ACP=
I data
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] extended physical RAM map:
[    0.000000] reserve setup_data: [mem 0x0000000000001000-0x000000000008=
efff] usable
[    0.000000] reserve setup_data: [mem 0x000000000008f000-0x000000000008=
ffff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x0000000027000000-0x000000002700=
006f] usable
[    0.000000] reserve setup_data: [mem 0x0000000027000070-0x0000000036f6=
dfff] usable
[    0.000000] reserve setup_data: [mem 0x000000006efcf000-0x000000006fdf=
efff] ACPI NVS
[    0.000000] reserve setup_data: [mem 0x000000006fdff000-0x000000006fff=
efff] ACPI data
[    0.000000] efi: EFI v2.50 by Dell Inc.
[    0.000000] efi:  ACPI=3D0x6fffe000  ACPI 2.0=3D0x6fffe014  SMBIOS=3D0=
x6eab2000  SMBIOS 3.0=3D0x6eab0000=20
[    0.000000] SMBIOS 3.2.0 present.
[    0.000000] DMI: Dell Inc. PowerEdge R7425/08V001, BIOS 1.9.3 06/25/20=
19
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2195.764 MHz processor
[    0.000083] last_pfn =3D 0x36f6e max_arch_pfn =3D 0x400000000
[    0.001293] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- =
WT =20
[    0.007706] Using GB pages for direct mapping
[    0.007819] Secure boot could not be determined
[    0.007821] RAMDISK: [mem 0x36a5d000-0x36f60fff]
[    0.007829] ACPI: Early table checksum verification disabled
[    0.007837] ACPI: RSDP 0x000000006FFFE014 000024 (v02 DELL  )
[    0.007843] ACPI: XSDT 0x000000006FFFD0E8 0000AC (v01 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007852] ACPI: FACP 0x000000006FFEB000 000114 (v06 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007859] ACPI: DSDT 0x000000006FFDA000 00D6D3 (v02 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007863] ACPI: FACS 0x000000006FDC8000 000040
[    0.007865] ACPI: SSDT 0x000000006FFFC000 0000D2 (v02 DELL   PE_SC3   =
00000002 MSFT 04000000)
[    0.007869] ACPI: BERT 0x000000006FFFB000 000030 (v01 DELL   BERT     =
00000001 DELL 00000001)
[    0.007872] ACPI: HEST 0x000000006FFFA000 0006DC (v01 DELL   HEST     =
00000001 DELL 00000001)
[    0.007876] ACPI: SSDT 0x000000006FFF9000 0006A4 (v01 DELL   PE_SC3   =
00000001 AMD  00000001)
[    0.007879] ACPI: SRAT 0x000000006FFF8000 0009C0 (v03 DELL   PE_SC3   =
00000001 AMD  00000001)
[    0.007882] ACPI: MSCT 0x000000006FFF7000 00004E (v01 DELL   PE_SC3   =
00000000 AMD  00000001)
[    0.007885] ACPI: SLIT 0x000000006FFF6000 00006C (v01 DELL   PE_SC3   =
00000001 AMD  00000001)
[    0.007887] ACPI: CRAT 0x000000006FFEE000 007700 (v01 DELL   PE_SC3   =
00000001 AMD  00000001)
[    0.007890] ACPI: EINJ 0x000000006FFED000 000150 (v01 DELL   PE_SC3   =
00000001 AMD  00000001)
[    0.007893] ACPI: SLIC 0x000000006FFEC000 000024 (v01 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007896] ACPI: HPET 0x000000006FFEA000 000038 (v01 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007899] ACPI: APIC 0x000000006FFE9000 0004B2 (v03 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007902] ACPI: MCFG 0x000000006FFE8000 00003C (v01 DELL   PE_SC3   =
00000002 DELL 00000001)
[    0.007905] ACPI: SSDT 0x000000006FFD9000 0005CA (v02 DELL   xhc_port =
00000001 INTL 20170119)
[    0.007908] ACPI: IVRS 0x000000006FFD8000 000370 (v02 DELL   PE_SC3   =
00000001 AMD  00000000)
[    0.007910] ACPI: SSDT 0x000000006FFD6000 001658 (v01 AMD    CPMCMN   =
00000001 INTL 20170119)
[    0.007965] SRAT: PXM 0 -> APIC 0x00 -> Node 0
[    0.007966] SRAT: PXM 0 -> APIC 0x01 -> Node 0
[    0.007967] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.007968] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.007969] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.007970] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.007971] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.007971] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.007972] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.007973] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.007974] SRAT: PXM 0 -> APIC 0x0a -> Node 0
[    0.007974] SRAT: PXM 0 -> APIC 0x0b -> Node 0
[    0.007975] SRAT: PXM 0 -> APIC 0x0c -> Node 0
[    0.007976] SRAT: PXM 0 -> APIC 0x0d -> Node 0
[    0.007977] SRAT: PXM 0 -> APIC 0x0e -> Node 0
[    0.007977] SRAT: PXM 0 -> APIC 0x0f -> Node 0
[    0.007978] SRAT: PXM 1 -> APIC 0x10 -> Node 1
[    0.007979] SRAT: PXM 1 -> APIC 0x11 -> Node 1
[    0.007980] SRAT: PXM 1 -> APIC 0x12 -> Node 1
[    0.007980] SRAT: PXM 1 -> APIC 0x13 -> Node 1
[    0.007981] SRAT: PXM 1 -> APIC 0x14 -> Node 1
[    0.007982] SRAT: PXM 1 -> APIC 0x15 -> Node 1
[    0.007983] SRAT: PXM 1 -> APIC 0x16 -> Node 1
[    0.007983] SRAT: PXM 1 -> APIC 0x17 -> Node 1
[    0.007984] SRAT: PXM 1 -> APIC 0x18 -> Node 1
[    0.007985] SRAT: PXM 1 -> APIC 0x19 -> Node 1
[    0.007986] SRAT: PXM 1 -> APIC 0x1a -> Node 1
[    0.007986] SRAT: PXM 1 -> APIC 0x1b -> Node 1
[    0.007987] SRAT: PXM 1 -> APIC 0x1c -> Node 1
[    0.007988] SRAT: PXM 1 -> APIC 0x1d -> Node 1
[    0.007988] SRAT: PXM 1 -> APIC 0x1e -> Node 1
[    0.007989] SRAT: PXM 1 -> APIC 0x1f -> Node 1
[    0.007990] SRAT: PXM 2 -> APIC 0x20 -> Node 2
[    0.007991] SRAT: PXM 2 -> APIC 0x21 -> Node 2
[    0.007991] SRAT: PXM 2 -> APIC 0x22 -> Node 2
[    0.007992] SRAT: PXM 2 -> APIC 0x23 -> Node 2
[    0.007993] SRAT: PXM 2 -> APIC 0x24 -> Node 2
[    0.007994] SRAT: PXM 2 -> APIC 0x25 -> Node 2
[    0.007994] SRAT: PXM 2 -> APIC 0x26 -> Node 2
[    0.007995] SRAT: PXM 2 -> APIC 0x27 -> Node 2
[    0.007996] SRAT: PXM 2 -> APIC 0x28 -> Node 2
[    0.007997] SRAT: PXM 2 -> APIC 0x29 -> Node 2
[    0.007997] SRAT: PXM 2 -> APIC 0x2a -> Node 2
[    0.007998] SRAT: PXM 2 -> APIC 0x2b -> Node 2
[    0.007999] SRAT: PXM 2 -> APIC 0x2c -> Node 2
[    0.008000] SRAT: PXM 2 -> APIC 0x2d -> Node 2
[    0.008000] SRAT: PXM 2 -> APIC 0x2e -> Node 2
[    0.008001] SRAT: PXM 2 -> APIC 0x2f -> Node 2
[    0.008002] SRAT: PXM 3 -> APIC 0x30 -> Node 3
[    0.008003] SRAT: PXM 3 -> APIC 0x31 -> Node 3
[    0.008003] SRAT: PXM 3 -> APIC 0x32 -> Node 3
[    0.008004] SRAT: PXM 3 -> APIC 0x33 -> Node 3
[    0.008005] SRAT: PXM 3 -> APIC 0x34 -> Node 3
[    0.008005] SRAT: PXM 3 -> APIC 0x35 -> Node 3
[    0.008006] SRAT: PXM 3 -> APIC 0x36 -> Node 3
[    0.008007] SRAT: PXM 3 -> APIC 0x37 -> Node 3
[    0.008008] SRAT: PXM 3 -> APIC 0x38 -> Node 3
[    0.008008] SRAT: PXM 3 -> APIC 0x39 -> Node 3
[    0.008009] SRAT: PXM 3 -> APIC 0x3a -> Node 3
[    0.008010] SRAT: PXM 3 -> APIC 0x3b -> Node 3
[    0.008011] SRAT: PXM 3 -> APIC 0x3c -> Node 3
[    0.008011] SRAT: PXM 3 -> APIC 0x3d -> Node 3
[    0.008012] SRAT: PXM 3 -> APIC 0x3e -> Node 3
[    0.008013] SRAT: PXM 3 -> APIC 0x3f -> Node 3
[    0.008014] SRAT: PXM 4 -> APIC 0x40 -> Node 4
[    0.008014] SRAT: PXM 4 -> APIC 0x41 -> Node 4
[    0.008015] SRAT: PXM 4 -> APIC 0x42 -> Node 4
[    0.008016] SRAT: PXM 4 -> APIC 0x43 -> Node 4
[    0.008017] SRAT: PXM 4 -> APIC 0x44 -> Node 4
[    0.008017] SRAT: PXM 4 -> APIC 0x45 -> Node 4
[    0.008018] SRAT: PXM 4 -> APIC 0x46 -> Node 4
[    0.008019] SRAT: PXM 4 -> APIC 0x47 -> Node 4
[    0.008020] SRAT: PXM 4 -> APIC 0x48 -> Node 4
[    0.008020] SRAT: PXM 4 -> APIC 0x49 -> Node 4
[    0.008021] SRAT: PXM 4 -> APIC 0x4a -> Node 4
[    0.008022] SRAT: PXM 4 -> APIC 0x4b -> Node 4
[    0.008022] SRAT: PXM 4 -> APIC 0x4c -> Node 4
[    0.008023] SRAT: PXM 4 -> APIC 0x4d -> Node 4
[    0.008024] SRAT: PXM 4 -> APIC 0x4e -> Node 4
[    0.008025] SRAT: PXM 4 -> APIC 0x4f -> Node 4
[    0.008025] SRAT: PXM 5 -> APIC 0x50 -> Node 5
[    0.008026] SRAT: PXM 5 -> APIC 0x51 -> Node 5
[    0.008027] SRAT: PXM 5 -> APIC 0x52 -> Node 5
[    0.008028] SRAT: PXM 5 -> APIC 0x53 -> Node 5
[    0.008028] SRAT: PXM 5 -> APIC 0x54 -> Node 5
[    0.008029] SRAT: PXM 5 -> APIC 0x55 -> Node 5
[    0.008030] SRAT: PXM 5 -> APIC 0x56 -> Node 5
[    0.008031] SRAT: PXM 5 -> APIC 0x57 -> Node 5
[    0.008031] SRAT: PXM 5 -> APIC 0x58 -> Node 5
[    0.008032] SRAT: PXM 5 -> APIC 0x59 -> Node 5
[    0.008033] SRAT: PXM 5 -> APIC 0x5a -> Node 5
[    0.008034] SRAT: PXM 5 -> APIC 0x5b -> Node 5
[    0.008034] SRAT: PXM 5 -> APIC 0x5c -> Node 5
[    0.008035] SRAT: PXM 5 -> APIC 0x5d -> Node 5
[    0.008036] SRAT: PXM 5 -> APIC 0x5e -> Node 5
[    0.008036] SRAT: PXM 5 -> APIC 0x5f -> Node 5
[    0.008037] SRAT: PXM 6 -> APIC 0x60 -> Node 6
[    0.008038] SRAT: PXM 6 -> APIC 0x61 -> Node 6
[    0.008039] SRAT: PXM 6 -> APIC 0x62 -> Node 6
[    0.008039] SRAT: PXM 6 -> APIC 0x63 -> Node 6
[    0.008040] SRAT: PXM 6 -> APIC 0x64 -> Node 6
[    0.008041] SRAT: PXM 6 -> APIC 0x65 -> Node 6
[    0.008042] SRAT: PXM 6 -> APIC 0x66 -> Node 6
[    0.008042] SRAT: PXM 6 -> APIC 0x67 -> Node 6
[    0.008043] SRAT: PXM 6 -> APIC 0x68 -> Node 6
[    0.008044] SRAT: PXM 6 -> APIC 0x69 -> Node 6
[    0.008045] SRAT: PXM 6 -> APIC 0x6a -> Node 6
[    0.008045] SRAT: PXM 6 -> APIC 0x6b -> Node 6
[    0.008046] SRAT: PXM 6 -> APIC 0x6c -> Node 6
[    0.008047] SRAT: PXM 6 -> APIC 0x6d -> Node 6
[    0.008048] SRAT: PXM 6 -> APIC 0x6e -> Node 6
[    0.008048] SRAT: PXM 6 -> APIC 0x6f -> Node 6
[    0.008049] SRAT: PXM 7 -> APIC 0x70 -> Node 7
[    0.008050] SRAT: PXM 7 -> APIC 0x71 -> Node 7
[    0.008050] SRAT: PXM 7 -> APIC 0x72 -> Node 7
[    0.008051] SRAT: PXM 7 -> APIC 0x73 -> Node 7
[    0.008052] SRAT: PXM 7 -> APIC 0x74 -> Node 7
[    0.008053] SRAT: PXM 7 -> APIC 0x75 -> Node 7
[    0.008053] SRAT: PXM 7 -> APIC 0x76 -> Node 7
[    0.008054] SRAT: PXM 7 -> APIC 0x77 -> Node 7
[    0.008055] SRAT: PXM 7 -> APIC 0x78 -> Node 7
[    0.008056] SRAT: PXM 7 -> APIC 0x79 -> Node 7
[    0.008056] SRAT: PXM 7 -> APIC 0x7a -> Node 7
[    0.008057] SRAT: PXM 7 -> APIC 0x7b -> Node 7
[    0.008058] SRAT: PXM 7 -> APIC 0x7c -> Node 7
[    0.008059] SRAT: PXM 7 -> APIC 0x7d -> Node 7
[    0.008059] SRAT: PXM 7 -> APIC 0x7e -> Node 7
[    0.008060] SRAT: PXM 7 -> APIC 0x7f -> Node 7
[    0.008063] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.008065] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0x7fffffff]
[    0.008066] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x207fffffff]
[    0.008067] ACPI: SRAT: Node 1 PXM 1 [mem 0x2080000000-0x407fffffff]
[    0.008068] ACPI: SRAT: Node 2 PXM 2 [mem 0x4080000000-0x607fffffff]
[    0.008069] ACPI: SRAT: Node 3 PXM 3 [mem 0x6080000000-0x807fffffff]
[    0.008070] ACPI: SRAT: Node 4 PXM 4 [mem 0x8080000000-0xa07fffffff]
[    0.008071] ACPI: SRAT: Node 5 PXM 5 [mem 0xa080000000-0xc07fffffff]
[    0.008072] ACPI: SRAT: Node 6 PXM 6 [mem 0xc080000000-0xe07fffffff]
[    0.008073] ACPI: SRAT: Node 7 PXM 7 [mem 0xe080000000-0x1007fffffff]
[    0.008080] NUMA: Node 0 [mem 0x00000000-0x0009ffff] + [mem 0x00100000=
-0x36f6dfff] -> [mem 0x00000000-0x36f6dfff]
[    0.008085] NODE_DATA(0) allocated [mem 0x36f69000-0x36f6cfff]
[    0.008114] Zone ranges:
[    0.008115]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.008117]   DMA32    [mem 0x0000000001000000-0x0000000036f6dfff]
[    0.008119]   Normal   empty
[    0.008120] Movable zone start for each node
[    0.008121] Early memory node ranges
[    0.008122]   node   0: [mem 0x0000000000001000-0x000000000008efff]
[    0.008123]   node   0: [mem 0x0000000027000000-0x0000000036f6dfff]
[    0.008127] Reserved but unavailable: 98 pages
[    0.008128] Initmem setup node 0 [mem 0x0000000000001000-0x0000000036f=
6dfff]
[    0.011778] ACPI: PM-Timer IO Port: 0x408
[    0.011802] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    0.011826] IOAPIC[0]: apic_id 128, version 33, address 0xfec00000, GS=
I 0-23
[    0.011833] IOAPIC[1]: apic_id 129, version 33, address 0xfd880000, GS=
I 24-55
[    0.011840] IOAPIC[2]: apic_id 130, version 33, address 0xea900000, GS=
I 56-87
[    0.011847] IOAPIC[3]: apic_id 131, version 33, address 0xdd900000, GS=
I 88-119
[    0.011853] IOAPIC[4]: apic_id 132, version 33, address 0xd0900000, GS=
I 120-151
[    0.011859] IOAPIC[5]: apic_id 133, version 33, address 0xc3900000, GS=
I 152-183
[    0.011864] IOAPIC[6]: apic_id 134, version 33, address 0xb6900000, GS=
I 184-215
[    0.011869] IOAPIC[7]: apic_id 135, version 33, address 0xa9900000, GS=
I 216-247
[    0.011874] IOAPIC[8]: apic_id 136, version 33, address 0x9c900000, GS=
I 248-279
[    0.011877] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.011879] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)=

[    0.011885] Using ACPI (MADT) for SMP configuration information
[    0.011888] ACPI: HPET id: 0x10228201 base: 0xfed00000
[    0.011893] smpboot: Allowing 128 CPUs, 0 hotplug CPUs
[    0.011896] NODE_DATA(5) allocated [mem 0x36a59000-0x36a5cfff]
[    0.011897]     NODE_DATA(5) on node 0
[    0.011901] Initmem setup node 5 [mem 0x0000000000000000-0x00000000000=
00000]
[    0.011903] NODE_DATA(4) allocated [mem 0x36a55000-0x36a58fff]
[    0.011904]     NODE_DATA(4) on node 0
[    0.011907] Initmem setup node 4 [mem 0x0000000000000000-0x00000000000=
00000]
[    0.011909] NODE_DATA(1) allocated [mem 0x36a51000-0x36a54fff]
[    0.011910]     NODE_DATA(1) on node 0
[    0.011914] Initmem setup node 1 [mem 0x0000000000000000-0x00000000000=
00000]
[    0.011916] NODE_DATA(2) allocated [mem 0x36a4d000-0x36a50fff]
[    0.011916]     NODE_DATA(2) on node 0
[    0.011920] Initmem setup node 2 [mem 0x0000000000000000-0x00000000000=
00000]
[    0.011922] NODE_DATA(6) allocated [mem 0x36a49000-0x36a4cfff]
[    0.011923]     NODE_DATA(6) on node 0
[    0.011927] Initmem setup node 6 [mem 0x0000000000000000-0x00000000000=
00000]
[    0.011929] NODE_DATA(3) allocated [mem 0x36a45000-0x36a48fff]
[    0.011930]     NODE_DATA(3) on node 0
[    0.011933] Initmem setup node 3 [mem 0x0000000000000000-0x00000000000=
00000]
[    0.011935] NODE_DATA(7) allocated [mem 0x36a41000-0x36a44fff]
[    0.011936]     NODE_DATA(7) on node 0
[    0.011939] Initmem setup node 7 [mem 0x0000000000000000-0x00000000000=
00000]
[    0.011955] [mem 0x6ffff000-0xffffffff] available for PCI devices
[    0.011962] clocksource: refined-jiffies: mask: 0xffffffff max_cycles:=
 0xffffffff, max_idle_ns: 1910969940391419 ns
[    0.168092] random: get_random_bytes called from start_kernel+0x90/0x4=
ae with crng_init=3D0
[    0.168101] setup_percpu: NR_CPUS:256 nr_cpumask_bits:256 nr_cpu_ids:1=
28 nr_node_ids:8
[    0.179735] percpu: Embedded 43 pages/cpu s136536 r8192 d31400 u262144=

[    0.179899] Built 8 zonelists, mobility grouping on.  Total pages: 644=
86
[    0.179901] Policy zone: DMA32
[    0.179906] Kernel command line: root=3DLABEL=3Droot ro console=3DttyS=
1,115200n8 console=3Dtty0 irqpoll maxcpus=3D1 reset_devices CRASH elfcore=
hdr=3D900536K
[    0.180006] Misrouted IRQ fixup and polling support enabled
[    0.180007] This may significantly impact system performance
[    0.180064] log_buf_len individual max cpu contribution: 4096 bytes
[    0.180065] log_buf_len total cpu_extra contributions: 520192 bytes
[    0.180066] log_buf_len min size: 131072 bytes
[    0.180341] log_buf_len: 1048576 bytes
[    0.180343] early log buf free: 111720(85%)
[    0.195170] Memory: 129092K/262128K available (14348K kernel code, 141=
4K rwdata, 3376K rodata, 1576K init, 1124K bss, 133036K reserved, 0K cma-=
reserved)
[    0.196080] ftrace: allocating 42115 entries in 165 pages
[    0.218874] rcu: Hierarchical RCU implementation.
[    0.218877] rcu: 	RCU event tracing is enabled.
[    0.218878] rcu: 	RCU restricting CPUs from NR_CPUS=3D256 to nr_cpu_id=
s=3D128.
[    0.218879] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D128
[    0.221052] NR_IRQS: 16640, nr_irqs: 5800, preallocated irqs: 16
[    0.222083] Spurious LAPIC timer interrupt on cpu 0
[    0.225158] Console: colour dummy device 80x25
[    0.225502] console [tty0] enabled
[    1.691892] console [ttyS1] enabled
[    1.695667] ACPI: Core revision 20180810
[    1.700288] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff=
, max_idle_ns: 133484873504 ns
[    1.709460] APIC: Switch to symmetric I/O mode setup
[    1.714527] Switched APIC routing to physical flat.
[    1.722431] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    1.733498] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycle=
s: 0x1fa691340dc, max_idle_ns: 440795212637 ns
[    1.744048] Calibrating delay loop (skipped), value calculated using t=
imer frequency.. 4391.52 BogoMIPS (lpj=3D2195764)
[    1.745075] pid_max: default: 131072 minimum: 1024
[    1.747698] Dentry cache hash table entries: 32768 (order: 6, 262144 b=
ytes)
[    1.748133] Inode-cache hash table entries: 16384 (order: 5, 131072 by=
tes)
[    1.749222] Mount-cache hash table entries: 512 (order: 0, 4096 bytes)=

[    1.750078] Mountpoint-cache hash table entries: 512 (order: 0, 4096 b=
ytes)
[    1.752429] LVT offset 2 assigned for vector 0xf4
[    1.753087] Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
[    1.754077] Last level dTLB entries: 4KB 1536, 2MB 1536, 4MB 768, 1GB =
0
[    1.755080] Spectre V2 : Mitigation: Full AMD retpoline
[    1.756081] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling R=
SB on context switch
[    1.757078] Spectre V2 : mitigation: Enabling conditional Indirect Bra=
nch Prediction Barrier
[    1.758077] Spectre V2 : User space: Vulnerable
[    1.759081] Speculative Store Bypass: Mitigation: Speculative Store By=
pass disabled via prctl and seccomp
[    1.769661] smpboot: CPU 0 Converting physical 1 to logical package 0
[    1.771046] smpboot: CPU0: AMD EPYC 7601 32-Core Processor (family: 0x=
17, model: 0x1, stepping: 0x2)
[    1.771380] Performance Events: Fam17h core perfctr, AMD PMU driver.
[    1.772050] ... version:                0
[    1.773047] ... bit width:              48
[    1.774047] ... generic registers:      6
[    1.775047] ... value mask:             0000ffffffffffff
[    1.776047] ... max period:             00007fffffffffff
[    1.777047] ... fixed-purpose events:   0
[    1.778047] ... event mask:             000000000000003f
[    1.780123] rcu: Hierarchical SRCU implementation.
[    1.782116] MCE: In-kernel MCE decoding enabled.
[    1.785228] smp: Bringing up secondary CPUs ...
[    1.786048] smp: Brought up 8 nodes, 1 CPU
[    1.787048] smpboot: Max logical packages: 128
[    1.788048] smpboot: Total of 1 processors activated (4391.52 BogoMIPS=
)
[    1.791300] devtmpfs: initialized
[    1.792460] PM: Registering ACPI NVS region [mem 0x0008f000-0x0008ffff=
] (4096 bytes)
[    1.794048] PM: Registering ACPI NVS region [mem 0x6efcf000-0x6fdfefff=
] (14876672 bytes)
[    1.796253] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xfffff=
fff, max_idle_ns: 1911260446275000 ns
[    1.798076] futex hash table entries: 32768 (order: 9, 2097152 bytes)
[    1.800126] xor: automatically using best checksumming function   avx =
     =20
[    1.801697] NET: Registered protocol family 16
[    1.802201] audit: initializing netlink subsys (disabled)
[    1.803172] cpuidle: using governor ladder
[    1.804172] ACPI FADT declares the system doesn't support PCIe ASPM, s=
o disable it
[    1.805050] ACPI: bus type PCI registered
[    1.806090] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x800000=
00-0x8fffffff] (base 0x80000000)
[    1.807057] PCI: not using MMCONFIG
[    1.808048] PCI: Using configuration type 1 for base access
[    1.809047] PCI: Using configuration type 1 for extended access
[    1.810056] audit: type=3D2000 audit(1565600246.071:1): state=3Dinitia=
lized audit_enabled=3D0 res=3D1
[    1.811063] PCI: Dell System detected, enabling pci=3Dbfsort.
[    1.817589] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pag=
es
[    1.835057] raid6: sse2x1   gen()  6136 MB/s
[    1.853049] raid6: sse2x1   xor()  5927 MB/s
[    1.871048] raid6: sse2x2   gen() 12906 MB/s
[    1.889049] raid6: sse2x2   xor()  8173 MB/s
[    1.907048] raid6: sse2x4   gen() 13062 MB/s
[    1.925051] raid6: sse2x4   xor()  6173 MB/s
[    1.943048] raid6: avx2x1   gen() 15042 MB/s
[    1.961048] raid6: avx2x1   xor() 11007 MB/s
[    1.979049] raid6: avx2x2   gen() 19585 MB/s
[    1.997048] raid6: avx2x2   xor() 11892 MB/s
[    2.015049] raid6: avx2x4   gen() 19875 MB/s
[    2.033048] raid6: avx2x4   xor()  8146 MB/s
[    2.034047] raid6: using algorithm avx2x4 gen() 19875 MB/s
[    2.035047] raid6: .... xor() 8146 MB/s, rmw enabled
[    2.036048] raid6: using avx2x2 recovery algorithm
[    2.037193] ACPI: Added _OSI(Module Device)
[    2.038052] ACPI: Added _OSI(Processor Device)
[    2.039047] ACPI: Added _OSI(3.0 _SCP Extensions)
[    2.040047] ACPI: Added _OSI(Processor Aggregator Device)
[    2.041054] ACPI: Added _OSI(Linux-Dell-Video)
[    2.042047] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    2.050123] ACPI: 5 ACPI AML tables successfully acquired and loaded
[    2.055373] ACPI: Interpreter enabled
[    2.057056] ACPI: (supports S0 S5)
[    2.058047] ACPI: Using IOAPIC for interrupt routing
[    2.059344] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x800000=
00-0x8fffffff] (base 0x80000000)
[    2.061079] PCI: MMCONFIG at [mem 0x80000000-0x8fffffff] reserved in A=
CPI motherboard resources
[    2.062062] PCI: Using host bridge windows from ACPI; if necessary, us=
e "pci=3Dnocrs" and report a bug
[    2.064695] ACPI: Enabled 2 GPEs in block 00 to 1F
[    2.077883] ACPI: PCI Interrupt Link [LNKA] (IRQs 4 5 7 10 11 14 15) *=
0
[    2.078094] ACPI: PCI Interrupt Link [LNKB] (IRQs 4 5 7 10 11 14 15) *=
0
[    2.079092] ACPI: PCI Interrupt Link [LNKC] (IRQs 4 5 7 10 11 14 15) *=
0
[    2.080092] ACPI: PCI Interrupt Link [LNKD] (IRQs 4 5 7 10 11 14 15) *=
0
[    2.081091] ACPI: PCI Interrupt Link [LNKE] (IRQs 4 5 7 10 11 14 15) *=
0
[    2.082092] ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 7 10 11 14 15) *=
0
[    2.083092] ACPI: PCI Interrupt Link [LNKG] (IRQs 4 5 7 10 11 14 15) *=
0
[    2.084092] ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 7 10 11 14 15) *=
0
[    2.085271] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-1f])
[    2.086053] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[    2.087154] acpi PNP0A08:00: _OSC: platform does not support [AER LTR]=

[    2.088146] acpi PNP0A08:00: _OSC: OS now controls [PME PCIeCapability=
]
[    2.089048] acpi PNP0A08:00: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    2.090278] PCI host bridge to bus 0000:00
[    2.091050] pci_bus 0000:00: root bus resource [io  0x0000-0x03af wind=
ow]
[    2.092048] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 wind=
ow]
[    2.093048] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df wind=
ow]
[    2.094048] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bf=
fff window]
[    2.095047] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000c3=
fff window]
[    2.096047] pci_bus 0000:00: root bus resource [mem 0x000c4000-0x000c7=
fff window]
[    2.097047] pci_bus 0000:00: root bus resource [mem 0x000c8000-0x000cb=
fff window]
[    2.098047] pci_bus 0000:00: root bus resource [mem 0x000cc000-0x000cf=
fff window]
[    2.099048] pci_bus 0000:00: root bus resource [mem 0x000d0000-0x000d3=
fff window]
[    2.100047] pci_bus 0000:00: root bus resource [mem 0x000d4000-0x000d7=
fff window]
[    2.101047] pci_bus 0000:00: root bus resource [mem 0x000d8000-0x000db=
fff window]
[    2.102047] pci_bus 0000:00: root bus resource [mem 0x000dc000-0x000df=
fff window]
[    2.103047] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000e3=
fff window]
[    2.104048] pci_bus 0000:00: root bus resource [mem 0x000e4000-0x000e7=
fff window]
[    2.105047] pci_bus 0000:00: root bus resource [mem 0x000e8000-0x000eb=
fff window]
[    2.106047] pci_bus 0000:00: root bus resource [mem 0x000ec000-0x000ef=
fff window]
[    2.107047] pci_bus 0000:00: root bus resource [mem 0x000f0000-0x000ff=
fff window]
[    2.108047] pci_bus 0000:00: root bus resource [io  0x0d00-0x1fff wind=
ow]
[    2.109047] pci_bus 0000:00: root bus resource [mem 0xeb000000-0xfebff=
fff window]
[    2.110047] pci_bus 0000:00: root bus resource [mem 0x10080000000-0x1e=
00fffffff window]
[    2.111048] pci_bus 0000:00: root bus resource [bus 00-1f]
[    2.122070] pci 0000:01:00.0: VF(n) BAR0 space: [mem 0x10080000000-0x1=
00800fffff 64bit pref] (contains BAR0 for 64 VFs)
[    2.123067] pci 0000:01:00.0: VF(n) BAR3 space: [mem 0x10080100000-0x1=
00801fffff 64bit pref] (contains BAR3 for 64 VFs)
[    2.125134] pci 0000:01:00.1: VF(n) BAR0 space: [mem 0x10080200000-0x1=
00802fffff 64bit pref] (contains BAR0 for 64 VFs)
[    2.126067] pci 0000:01:00.1: VF(n) BAR3 space: [mem 0x10080300000-0x1=
00803fffff 64bit pref] (contains BAR3 for 64 VFs)
[    2.127357] pci 0000:00:01.1: PCI bridge to [bus 01]
[    2.132065] pci 0000:00:01.3: PCI bridge to [bus 02-03]
[    2.133091] pci_bus 0000:03: extended config space not accessible
[    2.134257] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.136285] pci 0000:04:00.0: 8.000 Gb/s available PCIe bandwidth, lim=
ited by 5 GT/s x2 link at 0000:00:01.4 (capable of 16.000 Gb/s with 5 GT/=
s x4 link)
[    2.138418] pci 0000:00:01.4: PCI bridge to [bus 04]
[    2.140519] pci 0000:00:07.1: PCI bridge to [bus 05]
[    2.142560] pci 0000:00:08.1: PCI bridge to [bus 06]
[    2.143559] ACPI: PCI Root Bridge [PC01] (domain 0000 [bus 20-3f])
[    2.144050] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[    2.145151] acpi PNP0A08:01: _OSC: platform does not support [AER LTR]=

[    2.147136] acpi PNP0A08:01: _OSC: OS now controls [PME PCIeCapability=
]
[    2.148048] acpi PNP0A08:01: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    2.150149] PCI host bridge to bus 0000:20
[    2.151048] pci_bus 0000:20: root bus resource [io  0x2000-0x3fff wind=
ow]
[    2.152048] pci_bus 0000:20: root bus resource [mem 0xde000000-0xeafff=
fff window]
[    2.153047] pci_bus 0000:20: root bus resource [mem 0x1e010000000-0x2b=
f9fffffff window]
[    2.154047] pci_bus 0000:20: root bus resource [bus 20-3f]
[    2.158546] pci 0000:20:07.1: PCI bridge to [bus 21]
[    2.160417] pci 0000:20:08.1: PCI bridge to [bus 22]
[    2.161316] ACPI: PCI Root Bridge [PC02] (domain 0000 [bus 40-5f])
[    2.162050] acpi PNP0A08:02: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[    2.163148] acpi PNP0A08:02: _OSC: platform does not support [AER LTR]=

[    2.164142] acpi PNP0A08:02: _OSC: OS now controls [PME PCIeCapability=
]
[    2.165047] acpi PNP0A08:02: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    2.166273] PCI host bridge to bus 0000:40
[    2.167049] pci_bus 0000:40: root bus resource [io  0x4000-0x5fff wind=
ow]
[    2.168047] pci_bus 0000:40: root bus resource [mem 0xd1000000-0xddfff=
fff window]
[    2.169047] pci_bus 0000:40: root bus resource [mem 0x2bfa0000000-0x39=
f2fffffff window]
[    2.170048] pci_bus 0000:40: root bus resource [bus 40-5f]
[    2.174060] pci 0000:40:07.1: PCI bridge to [bus 41]
[    2.176403] pci 0000:40:08.1: PCI bridge to [bus 42]
[    2.177283] ACPI: PCI Root Bridge [PC03] (domain 0000 [bus 60-7f])
[    2.178049] acpi PNP0A08:03: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[    2.180088] acpi PNP0A08:03: _OSC: platform does not support [AER LTR]=

[    2.181142] acpi PNP0A08:03: _OSC: OS now controls [PME PCIeCapability=
]
[    2.182047] acpi PNP0A08:03: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    2.183268] PCI host bridge to bus 0000:60
[    2.184048] pci_bus 0000:60: root bus resource [io  0x6000-0x7fff wind=
ow]
[    2.185047] pci_bus 0000:60: root bus resource [mem 0xc4000000-0xd0fff=
fff window]
[    2.186047] pci_bus 0000:60: root bus resource [mem 0x39f30000000-0x47=
ebfffffff window]
[    2.187047] pci_bus 0000:60: root bus resource [bus 60-7f]
[    2.191306] pci 0000:60:03.1: PCI bridge to [bus 61]
[    2.192410] pci 0000:60:07.1: PCI bridge to [bus 62]
[    2.194393] pci 0000:60:08.1: PCI bridge to [bus 63]
[    2.195288] ACPI: PCI Root Bridge [PC04] (domain 0000 [bus 80-9f])
[    2.196049] acpi PNP0A08:04: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[    2.197149] acpi PNP0A08:04: _OSC: platform does not support [AER LTR]=

[    2.199081] acpi PNP0A08:04: _OSC: OS now controls [PME PCIeCapability=
]
[    2.200047] acpi PNP0A08:04: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    2.202078] PCI host bridge to bus 0000:80
[    2.203048] pci_bus 0000:80: root bus resource [io  0x8000-0x9fff wind=
ow]
[    2.204047] pci_bus 0000:80: root bus resource [mem 0xb7000000-0xc3fff=
fff window]
[    2.205047] pci_bus 0000:80: root bus resource [mem 0x47ec0000000-0x55=
e4fffffff window]
[    2.206047] pci_bus 0000:80: root bus resource [bus 80-9f]
[    2.211283] pci 0000:80:07.1: PCI bridge to [bus 81]
[    2.213311] pci 0000:80:08.1: PCI bridge to [bus 82]
[    2.214282] ACPI: PCI Root Bridge [PC05] (domain 0000 [bus a0-bf])
[    2.215049] acpi PNP0A08:05: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[    2.216149] acpi PNP0A08:05: _OSC: platform does not support [AER LTR]=

[    2.217142] acpi PNP0A08:05: _OSC: OS now controls [PME PCIeCapability=
]
[    2.218047] acpi PNP0A08:05: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    2.219260] PCI host bridge to bus 0000:a0
[    2.220048] pci_bus 0000:a0: root bus resource [io  0xa000-0xbfff wind=
ow]
[    2.221047] pci_bus 0000:a0: root bus resource [mem 0xaa000000-0xb6fff=
fff window]
[    2.222047] pci_bus 0000:a0: root bus resource [mem 0x55e50000000-0x63=
ddfffffff window]
[    2.223047] pci_bus 0000:a0: root bus resource [bus a0-bf]
[    2.226317] pci 0000:a0:07.1: PCI bridge to [bus a1]
[    2.228052] pci 0000:a0:08.1: PCI bridge to [bus a2]
[    2.230280] ACPI: PCI Root Bridge [PC06] (domain 0000 [bus c0-df])
[    2.231049] acpi PNP0A08:06: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[    2.232149] acpi PNP0A08:06: _OSC: platform does not support [AER LTR]=

[    2.233142] acpi PNP0A08:06: _OSC: OS now controls [PME PCIeCapability=
]
[    2.234047] acpi PNP0A08:06: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    2.235262] PCI host bridge to bus 0000:c0
[    2.236048] pci_bus 0000:c0: root bus resource [io  0xc000-0xdfff wind=
ow]
[    2.237048] pci_bus 0000:c0: root bus resource [mem 0x9d000000-0xa9fff=
fff window]
[    2.238048] pci_bus 0000:c0: root bus resource [mem 0x63de0000000-0x71=
d6fffffff window]
[    2.239047] pci_bus 0000:c0: root bus resource [bus c0-df]
[    2.242062] pci 0000:c0:07.1: PCI bridge to [bus c1]
[    2.244368] pci 0000:c0:08.1: PCI bridge to [bus c2]
[    2.246053] ACPI: PCI Root Bridge [PC07] (domain 0000 [bus e0-ff])
[    2.247049] acpi PNP0A08:07: _OSC: OS supports [ExtendedConfig ASPM Cl=
ockPM Segments MSI]
[    2.248148] acpi PNP0A08:07: _OSC: platform does not support [AER LTR]=

[    2.250137] acpi PNP0A08:07: _OSC: OS now controls [PME PCIeCapability=
]
[    2.251047] acpi PNP0A08:07: FADT indicates ASPM is unsupported, using=
 BIOS configuration
[    2.253123] acpi PNP0A08:07: host bridge window [mem 0x71d70000000-0xf=
fffffffffff window] ([0x80000000000-0xffffffffffff] ignored, not CPU addr=
essable)
[    2.254071] PCI host bridge to bus 0000:e0
[    2.255048] pci_bus 0000:e0: root bus resource [io  0xe000-0xffff wind=
ow]
[    2.256047] pci_bus 0000:e0: root bus resource [mem 0x90000000-0x9cfff=
fff window]
[    2.257047] pci_bus 0000:e0: root bus resource [mem 0x71d70000000-0x7f=
fffffffff window]
[    2.258047] pci_bus 0000:e0: root bus resource [bus e0-ff]
[    2.261340] pci 0000:e0:07.1: PCI bridge to [bus e1]
[    2.262392] pci 0000:e0:08.1: PCI bridge to [bus e2]
[    2.266410] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    2.267046] pci 0000:03:00.0: vgaarb: VGA device added: decodes=3Dio+m=
em,owns=3Dio+mem,locks=3Dnone
[    2.267056] pci 0000:03:00.0: vgaarb: bridge control possible
[    2.268047] vgaarb: loaded
[    2.269127] SCSI subsystem initialized
[    2.270187] ACPI: bus type USB registered
[    2.271071] usbcore: registered new interface driver usbfs
[    2.272054] usbcore: registered new interface driver hub
[    2.273127] usbcore: registered new device driver usb
[    2.274063] pps_core: LinuxPPS API ver. 1 registered
[    2.275047] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolf=
o Giometti <giometti@linux.it>
[    2.276049] PTP clock support registered
[    2.277198] EDAC MC: Ver: 3.0.0
[    2.278362] Registered efivars operations
[    2.315097] Advanced Linux Sound Architecture Driver Initialized.
[    2.316058] PCI: Using ACPI for IRQ routing
[    2.337705] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    2.338048] hpet0: 3 comparators, 32-bit 14.318180 MHz counter
[    2.341119] clocksource: Switched to clocksource tsc-early
[    2.359621] VFS: Disk quotas dquot_6.6.0
[    2.363631] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 by=
tes)
[    2.371485] FS-Cache: Loaded
[    2.374546] CacheFiles: Loaded
[    2.377638] pnp: PnP ACPI init
[    2.381114] system 00:00: [mem 0x80000000-0x8fffffff] has been reserve=
d
[    2.388712] pnp: PnP ACPI: found 4 devices
[    2.398355] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff,=
 max_idle_ns: 2085701024 ns
[    2.407232] pci 0000:01:00.0: can't claim BAR 6 [mem 0xfff80000-0xffff=
ffff pref]: no compatible bridge window
[    2.417143] pci 0000:01:00.1: can't claim BAR 6 [mem 0xfff80000-0xffff=
ffff pref]: no compatible bridge window
[    2.427059] pci 0000:04:00.0: can't claim BAR 6 [mem 0xfff80000-0xffff=
ffff pref]: no compatible bridge window
[    2.436972] pci 0000:04:00.1: can't claim BAR 6 [mem 0xfff80000-0xffff=
ffff pref]: no compatible bridge window
[    2.446912] pci 0000:61:00.0: can't claim BAR 6 [mem 0xfff00000-0xffff=
ffff pref]: no compatible bridge window
[    2.456885] pci 0000:01:00.0: BAR 6: assigned [mem 0xfa280000-0xfa2fff=
ff pref]
[    2.464108] pci 0000:01:00.1: BAR 6: no space for [mem size 0x00080000=
 pref]
[    2.471153] pci 0000:01:00.1: BAR 6: failed to assign [mem size 0x0008=
0000 pref]
[    2.478548] pci 0000:00:01.1: PCI bridge to [bus 01]
[    2.483514] pci 0000:00:01.1:   bridge window [io  0x1000-0x1fff]
[    2.489611] pci 0000:00:01.1:   bridge window [mem 0xfa000000-0xfa2fff=
ff]
[    2.496403] pci 0000:00:01.1:   bridge window [mem 0x10080000000-0x100=
803fffff 64bit pref]
[    2.504667] pci 0000:03:00.0: BAR 6: assigned [mem 0xf9810000-0xf981ff=
ff pref]
[    2.511890] pci 0000:02:00.0: PCI bridge to [bus 03]
[    2.516859] pci 0000:02:00.0:   bridge window [mem 0xf9000000-0xf98fff=
ff]
[    2.523653] pci 0000:02:00.0:   bridge window [mem 0xeb000000-0xebffff=
ff 64bit pref]
[    2.531404] pci 0000:00:01.3: PCI bridge to [bus 02-03]
[    2.536635] pci 0000:00:01.3:   bridge window [mem 0xf9000000-0xf98fff=
ff]
[    2.543422] pci 0000:00:01.3:   bridge window [mem 0xeb000000-0xebffff=
ff 64bit pref]
[    2.551173] pci 0000:04:00.0: BAR 6: assigned [mem 0xf9f80000-0xf9ffff=
ff pref]
[    2.558399] pci 0000:04:00.1: BAR 6: no space for [mem size 0x00080000=
 pref]
[    2.565443] pci 0000:04:00.1: BAR 6: failed to assign [mem size 0x0008=
0000 pref]
[    2.572836] pci 0000:00:01.4: PCI bridge to [bus 04]
[    2.577804] pci 0000:00:01.4:   bridge window [mem 0xf9e00000-0xf9ffff=
ff]
[    2.584598] pci 0000:00:07.1: PCI bridge to [bus 05]
[    2.589565] pci 0000:00:07.1:   bridge window [mem 0xf9b00000-0xf9dfff=
ff]
[    2.596358] pci 0000:00:08.1: PCI bridge to [bus 06]
[    2.601329] pci 0000:00:08.1:   bridge window [mem 0xf9900000-0xf9afff=
ff]
[    2.608217] pci 0000:20:07.1: PCI bridge to [bus 21]
[    2.613185] pci 0000:20:07.1:   bridge window [mem 0xe8200000-0xe84fff=
ff]
[    2.619981] pci 0000:20:08.1: PCI bridge to [bus 22]
[    2.624953] pci 0000:20:08.1:   bridge window [mem 0xe8000000-0xe81fff=
ff]
[    2.631781] pci 0000:40:07.1: PCI bridge to [bus 41]
[    2.636751] pci 0000:40:07.1:   bridge window [mem 0xdb200000-0xdb3fff=
ff]
[    2.643547] pci 0000:40:08.1: PCI bridge to [bus 42]
[    2.648518] pci 0000:40:08.1:   bridge window [mem 0xdb000000-0xdb1fff=
ff]
[    2.655340] pci 0000:61:00.0: BAR 6: no space for [mem size 0x00100000=
 pref]
[    2.662384] pci 0000:61:00.0: BAR 6: failed to assign [mem size 0x0010=
0000 pref]
[    2.669779] pci 0000:60:03.1: PCI bridge to [bus 61]
[    2.674745] pci 0000:60:03.1:   bridge window [io  0x6000-0x6fff]
[    2.680839] pci 0000:60:03.1:   bridge window [mem 0xce400000-0xce4fff=
ff]
[    2.687633] pci 0000:60:03.1:   bridge window [mem 0xc4000000-0xc41fff=
ff 64bit pref]
[    2.695374] pci 0000:60:07.1: PCI bridge to [bus 62]
[    2.700338] pci 0000:60:07.1:   bridge window [mem 0xce200000-0xce3fff=
ff]
[    2.707130] pci 0000:60:08.1: PCI bridge to [bus 63]
[    2.712099] pci 0000:60:08.1:   bridge window [mem 0xce000000-0xce1fff=
ff]
[    2.718920] pci 0000:80:07.1: PCI bridge to [bus 81]
[    2.723889] pci 0000:80:07.1:   bridge window [mem 0xc1200000-0xc13fff=
ff]
[    2.730685] pci 0000:80:08.1: PCI bridge to [bus 82]
[    2.735658] pci 0000:80:08.1:   bridge window [mem 0xc1000000-0xc11fff=
ff]
[    2.742480] pci 0000:a0:07.1: PCI bridge to [bus a1]
[    2.747454] pci 0000:a0:07.1:   bridge window [mem 0xb4200000-0xb43fff=
ff]
[    2.754243] pci 0000:a0:08.1: PCI bridge to [bus a2]
[    2.759213] pci 0000:a0:08.1:   bridge window [mem 0xb4000000-0xb41fff=
ff]
[    2.766041] pci 0000:c0:07.1: PCI bridge to [bus c1]
[    2.771009] pci 0000:c0:07.1:   bridge window [mem 0xa7200000-0xa73fff=
ff]
[    2.777802] pci 0000:c0:08.1: PCI bridge to [bus c2]
[    2.782771] pci 0000:c0:08.1:   bridge window [mem 0xa7000000-0xa71fff=
ff]
[    2.789587] pci 0000:e0:07.1: PCI bridge to [bus e1]
[    2.794561] pci 0000:e0:07.1:   bridge window [mem 0x9a200000-0x9a3fff=
ff]
[    2.801357] pci 0000:e0:08.1: PCI bridge to [bus e2]
[    2.806328] pci 0000:e0:08.1:   bridge window [mem 0x9a000000-0x9a1fff=
ff]
[    2.813347] NET: Registered protocol family 2
[    2.818310] tcp_listen_portaddr_hash hash table entries: 256 (order: 0=
, 4096 bytes)
[    2.826028] TCP established hash table entries: 2048 (order: 2, 16384 =
bytes)
[    2.833087] TCP bind hash table entries: 2048 (order: 3, 32768 bytes)
[    2.839541] TCP: Hash tables configured (established 2048 bind 2048)
[    2.846058] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    2.851896] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    2.858609] pci 0000:03:00.0: Video device with shadowed ROM at [mem 0=
x000c0000-0x000dffff]
[    2.883561] pci 0000:21:00.3: xHCI HW did not halt within 16000 usec s=
tatus =3D 0x0
[    2.891088] pci 0000:21:00.3: quirk_usb_early_handoff+0x0/0x6a0 took 2=
3229 usecs
[    2.898621] Trying to unpack rootfs image as initramfs...
[    2.988043] Freeing initrd memory: 5136K
[    2.993539] Translation is already enabled - trying to copy translatio=
n structures
[    3.002003] Copied DEV table from previous kernel.
[    3.784864] AMD-Vi: IOMMU performance counters supported
[    3.790306] AMD-Vi: IOMMU performance counters supported
[    3.795665] AMD-Vi: IOMMU performance counters supported
[    3.801015] AMD-Vi: IOMMU performance counters supported
[    3.806375] AMD-Vi: IOMMU performance counters supported
[    3.811726] AMD-Vi: IOMMU performance counters supported
[    3.817080] AMD-Vi: IOMMU performance counters supported
[    3.822430] AMD-Vi: IOMMU performance counters supported
[    3.829978] iommu: Adding device 0000:00:01.0 to group 0
[    3.835343] iommu: Adding device 0000:00:01.1 to group 0
[    3.840684] iommu: Adding device 0000:00:01.3 to group 0
[    3.846023] iommu: Adding device 0000:00:01.4 to group 0
[    3.852433] iommu: Adding device 0000:00:02.0 to group 1
[    3.859010] iommu: Adding device 0000:00:03.0 to group 2
[    3.865539] iommu: Adding device 0000:00:04.0 to group 3
[    3.872014] iommu: Adding device 0000:00:07.0 to group 4
[    3.877366] iommu: Adding device 0000:00:07.1 to group 4
[    3.883748] iommu: Adding device 0000:00:08.0 to group 5
[    3.889094] iommu: Adding device 0000:00:08.1 to group 5
[    3.895567] iommu: Adding device 0000:00:14.0 to group 6
[    3.900914] iommu: Adding device 0000:00:14.3 to group 6
[    3.907430] iommu: Adding device 0000:00:18.0 to group 7
[    3.912780] iommu: Adding device 0000:00:18.1 to group 7
[    3.918118] iommu: Adding device 0000:00:18.2 to group 7
[    3.923456] iommu: Adding device 0000:00:18.3 to group 7
[    3.928794] iommu: Adding device 0000:00:18.4 to group 7
[    3.934136] iommu: Adding device 0000:00:18.5 to group 7
[    3.939474] iommu: Adding device 0000:00:18.6 to group 7
[    3.944811] iommu: Adding device 0000:00:18.7 to group 7
[    3.951225] iommu: Adding device 0000:00:19.0 to group 8
[    3.956574] iommu: Adding device 0000:00:19.1 to group 8
[    3.961912] iommu: Adding device 0000:00:19.2 to group 8
[    3.967253] iommu: Adding device 0000:00:19.3 to group 8
[    3.972592] iommu: Adding device 0000:00:19.4 to group 8
[    3.977931] iommu: Adding device 0000:00:19.5 to group 8
[    3.983269] iommu: Adding device 0000:00:19.6 to group 8
[    3.988606] iommu: Adding device 0000:00:19.7 to group 8
[    3.995150] iommu: Adding device 0000:00:1a.0 to group 9
[    4.000494] iommu: Adding device 0000:00:1a.1 to group 9
[    4.005833] iommu: Adding device 0000:00:1a.2 to group 9
[    4.011167] iommu: Adding device 0000:00:1a.3 to group 9
[    4.016508] iommu: Adding device 0000:00:1a.4 to group 9
[    4.021849] iommu: Adding device 0000:00:1a.5 to group 9
[    4.027183] iommu: Adding device 0000:00:1a.6 to group 9
[    4.032524] iommu: Adding device 0000:00:1a.7 to group 9
[    4.038936] iommu: Adding device 0000:00:1b.0 to group 10
[    4.044372] iommu: Adding device 0000:00:1b.1 to group 10
[    4.049798] iommu: Adding device 0000:00:1b.2 to group 10
[    4.055221] iommu: Adding device 0000:00:1b.3 to group 10
[    4.060650] iommu: Adding device 0000:00:1b.4 to group 10
[    4.066073] iommu: Adding device 0000:00:1b.5 to group 10
[    4.071501] iommu: Adding device 0000:00:1b.6 to group 10
[    4.076928] iommu: Adding device 0000:00:1b.7 to group 10
[    4.083564] iommu: Adding device 0000:00:1c.0 to group 11
[    4.088998] iommu: Adding device 0000:00:1c.1 to group 11
[    4.094426] iommu: Adding device 0000:00:1c.2 to group 11
[    4.099850] iommu: Adding device 0000:00:1c.3 to group 11
[    4.105275] iommu: Adding device 0000:00:1c.4 to group 11
[    4.110702] iommu: Adding device 0000:00:1c.5 to group 11
[    4.116126] iommu: Adding device 0000:00:1c.6 to group 11
[    4.121554] iommu: Adding device 0000:00:1c.7 to group 11
[    4.128057] iommu: Adding device 0000:00:1d.0 to group 12
[    4.133492] iommu: Adding device 0000:00:1d.1 to group 12
[    4.138916] iommu: Adding device 0000:00:1d.2 to group 12
[    4.144338] iommu: Adding device 0000:00:1d.3 to group 12
[    4.149764] iommu: Adding device 0000:00:1d.4 to group 12
[    4.155192] iommu: Adding device 0000:00:1d.5 to group 12
[    4.160617] iommu: Adding device 0000:00:1d.6 to group 12
[    4.166040] iommu: Adding device 0000:00:1d.7 to group 12
[    4.172710] iommu: Adding device 0000:00:1e.0 to group 13
[    4.178148] iommu: Adding device 0000:00:1e.1 to group 13
[    4.183576] iommu: Adding device 0000:00:1e.2 to group 13
[    4.189001] iommu: Adding device 0000:00:1e.3 to group 13
[    4.194428] iommu: Adding device 0000:00:1e.4 to group 13
[    4.199851] iommu: Adding device 0000:00:1e.5 to group 13
[    4.205280] iommu: Adding device 0000:00:1e.6 to group 13
[    4.210703] iommu: Adding device 0000:00:1e.7 to group 13
[    4.217225] iommu: Adding device 0000:00:1f.0 to group 14
[    4.222662] iommu: Adding device 0000:00:1f.1 to group 14
[    4.228093] iommu: Adding device 0000:00:1f.2 to group 14
[    4.233514] iommu: Adding device 0000:00:1f.3 to group 14
[    4.238943] iommu: Adding device 0000:00:1f.4 to group 14
[    4.244368] iommu: Adding device 0000:00:1f.5 to group 14
[    4.249794] iommu: Adding device 0000:00:1f.6 to group 14
[    4.255224] iommu: Adding device 0000:00:1f.7 to group 14
[    4.260645] iommu: Adding device 0000:01:00.0 to group 0
[    4.265973] iommu: Adding device 0000:01:00.1 to group 0
[    4.271304] iommu: Adding device 0000:02:00.0 to group 0
[    4.276627] iommu: Adding device 0000:03:00.0 to group 0
[    4.281959] iommu: Adding device 0000:04:00.0 to group 0
[    4.287287] iommu: Adding device 0000:04:00.1 to group 0
[    4.292615] iommu: Adding device 0000:05:00.0 to group 4
[    4.297939] iommu: Adding device 0000:05:00.2 to group 4
[    4.303264] iommu: Adding device 0000:05:00.3 to group 4
[    4.308595] iommu: Adding device 0000:06:00.0 to group 5
[    4.313924] iommu: Adding device 0000:06:00.1 to group 5
[    4.319253] iommu: Adding device 0000:06:00.2 to group 5
[    4.325869] iommu: Adding device 0000:20:01.0 to group 15
[    4.332648] iommu: Adding device 0000:20:02.0 to group 16
[    4.338946] swapper/0 invoked oom-killer: gfp_mask=3D0x6040c0(GFP_KERN=
EL|__GFP_COMP), nodemask=3D(null), order=3D0, oom_score_adj=3D0
[    4.350251] swapper/0 cpuset=3D/ mems_allowed=3D0
[    4.354618] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.57.mx64.282=
 #1
[    4.355612] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.9.=
3 06/25/2019
[    4.355612] Call Trace:
[    4.355612]  dump_stack+0x46/0x5b
[    4.355612]  dump_header+0x6b/0x289
[    4.355612]  ? try_to_free_pages+0xcf/0x1c0
[    4.355612]  out_of_memory+0x470/0x4c0
[    4.355612]  __alloc_pages_nodemask+0x970/0x1030
[    4.355612]  cache_grow_begin+0x7d/0x520
[    4.355612]  fallback_alloc+0x148/0x200
[    4.355612]  kmem_cache_alloc_trace+0xac/0x1f0
[    4.355612]  init_iova_domain+0x112/0x170
[    4.355612]  amd_iommu_domain_alloc+0x138/0x1a0
[    4.355612]  iommu_group_get_for_dev+0xc4/0x1a0
[    4.355612]  amd_iommu_add_device+0x13a/0x610
[    4.355612]  ? iommu_group_alloc+0x180/0x180
[    4.355612]  ? set_debug_rodata+0x11/0x11
[    4.355612]  add_iommu_group+0x20/0x30
[    4.355612]  bus_for_each_dev+0x76/0xc0
[    4.355612]  ? down_write+0xe/0x40
[    4.355612]  bus_set_iommu+0xb6/0xf0
[    4.355612]  amd_iommu_init_api+0x112/0x132
[    4.355612]  state_next+0xfb1/0x1165
[    4.355612]  ? set_debug_rodata+0x11/0x11
[    4.355612]  amd_iommu_init+0x1f/0x67
[    4.355612]  ? e820__memblock_setup+0x60/0x60
[    4.355612]  pci_iommu_init+0x16/0x3f
[    4.355612]  do_one_initcall+0x4f/0x1d0
[    4.355612]  ? set_debug_rodata+0x11/0x11
[    4.355612]  kernel_init_freeable+0x1ee/0x27f
[    4.355612]  ? rest_init+0xb0/0xb0
[    4.355612]  kernel_init+0xa/0x110
[    4.355612]  ret_from_fork+0x22/0x40
[    4.489484] Mem-Info:
[    4.491778] active_anon:0 inactive_anon:0 isolated_anon:0
[    4.491778]  active_file:0 inactive_file:0 isolated_file:0
[    4.491778]  unevictable:3930 dirty:0 writeback:0 unstable:0
[    4.491778]  slab_reclaimable:2367 slab_unreclaimable:17814
[    4.491778]  mapped:0 shmem:0 pagetables:0 bounce:0
[    4.491778]  free:472 free_pcp:53 free_cma:0
[    4.522929] Node 0 active_anon:0kB inactive_anon:0kB active_file:0kB i=
nactive_file:0kB unevictable:15720kB isolated(anon):0kB isolated(file):0k=
B mapped:0kB dirty:0kB writeback:0kB shmem:0kB shmem_thp: 0kB shmem_pmdma=
pped: 0kB anon_thp: 0kB writeback_tmp:0kB unstable:0kB all_unreclaimable?=
 no
[    4.548703] Node 0 DMA free:484kB min:4kB low:4kB high:4kB active_anon=
:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB =
writepending:0kB present:568kB managed:484kB mlocked:0kB kernel_stack:0kB=
 pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[    4.573612] lowmem_reserve[]: 0 125 125 125
[    4.577799] Node 0 DMA32 free:1404kB min:1428kB low:1784kB high:2140kB=
 active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unev=
ictable:15720kB writepending:0kB present:261560kB managed:133752kB mlocke=
d:0kB kernel_stack:2496kB pagetables:0kB bounce:0kB free_pcp:212kB local_=
pcp:212kB free_cma:0kB
[    4.605221] lowmem_reserve[]: 0 0 0 0
[    4.608887] Node 0 DMA: 1*4kB (U) 0*8kB 0*16kB 1*32kB (U) 1*64kB (U) 1=
*128kB (U) 1*256kB (U) 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 484kB
[    4.621056] Node 0 DMA32: 9*4kB (UM) 1*8kB (U) 15*16kB (UM) 1*32kB (M)=
 17*64kB (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB =3D 1404=
kB
[    4.633918] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_su=
rp=3D0 hugepages_size=3D2048kB
[    4.642350] 3943 total pagecache pages
[    4.646106] 0 pages in swap cache
[    4.649424] Swap cache stats: add 0, delete 0, find 0/0
[    4.654651] Free swap  =3D 0kB
[    4.657536] Total swap =3D 0kB
[    4.660422] 65532 pages RAM
[    4.663219] 0 pages HighMem/MovableOnly
[    4.667061] 31973 pages reserved
[    4.670295] Unreclaimable slab info:
[    4.673874] Name                      Used          Total
[    4.679277] tcp_bind_bucket           29KB         32KB
[    4.684514] RAW                      240KB        240KB
[    4.689752] hugetlbfs_inode_cache          0KB          3KB
[    4.695333] biovec-max                32KB         32KB
[    4.700565] uid_cache                  0KB          3KB
[    4.705799] skbuff_head_cache          3KB          4KB
[    4.711033] shmem_inode_cache         56KB         59KB
[    4.716267] proc_dir_entry            40KB         43KB
[    4.721502] kernfs_node_cache       2420KB       2424KB
[    4.726737] mnt_cache                  4KB          7KB
[    4.731970] filp                       1KB          4KB
[    4.737197] names_cache              420KB        440KB
[    4.742425] fs_cache                   8KB         11KB
[    4.747656] files_cache               88KB         90KB
[    4.752887] signal_cache             166KB        171KB
[    4.758118] sighand_cache            321KB        321KB
[    4.763346] task_struct              516KB        516KB
[    4.768571] cred_jar                  29KB         31KB
[    4.773796] anon_vma_chain             9KB         12KB
[    4.779026] pid                        3KB          4KB
[    4.784261] Acpi-Operand             527KB        531KB
[    4.789494] Acpi-Parse                26KB         31KB
[    4.794721] Acpi-State                37KB         43KB
[    4.799946] Acpi-Namespace            98KB        100KB
[    4.805173] numa_policy                3KB          3KB
[    4.810399] trace_event_file         145KB        146KB
[    4.815626] ftrace_event_field        151KB        151KB
[    4.820948] pool_workqueue             4KB          4KB
[    4.826202] kmalloc-262144           256KB        256KB
[    4.831433] kmalloc-65536            128KB        128KB
[    4.836659] kmalloc-32768             64KB         64KB
[    4.841885] kmalloc-16384             48KB         48KB
[    4.847112] kmalloc-8192              80KB         80KB
[    4.852339] kmalloc-4096            2700KB       2700KB
[    4.857565] kmalloc-2048           59164KB      59164KB
[    4.862793] kmalloc-1024             705KB        708KB
[    4.868026] kmalloc-512              185KB        188KB
[    4.873251] kmalloc-256               84KB         88KB
[    4.878479] kmalloc-192              255KB        255KB
[    4.883706] kmalloc-96               177KB        180KB
[    4.888939] kmalloc-64               519KB        520KB
[    4.894165] kmalloc-32               230KB        232KB
[    4.899391] kmalloc-128              871KB        872KB
[    4.904617] kmem_cache                32KB         33KB
[    4.909842] Tasks state (memory values in pages):
[    4.914547] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swa=
pents oom_score_adj name
[    4.923156] Out of memory and no killable processes...
[    4.928296] Kernel panic - not syncing: System is deadlocked on memory=

[    4.928296]=20
[    4.929294] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.19.57.mx64.282=
 #1
[    4.929294] Hardware name: Dell Inc. PowerEdge R7425/08V001, BIOS 1.9.=
3 06/25/2019
[    4.929294] Call Trace:
[    4.929294]  dump_stack+0x46/0x5b
[    4.929294]  panic+0xde/0x232
[    4.929294]  out_of_memory+0x4b5/0x4c0
[    4.929294]  __alloc_pages_nodemask+0x970/0x1030
[    4.929294]  cache_grow_begin+0x7d/0x520
[    4.929294]  fallback_alloc+0x148/0x200
[    4.929294]  kmem_cache_alloc_trace+0xac/0x1f0
[    4.929294]  init_iova_domain+0x112/0x170
[    4.929294]  amd_iommu_domain_alloc+0x138/0x1a0
[    4.929294]  iommu_group_get_for_dev+0xc4/0x1a0
[    4.929294]  amd_iommu_add_device+0x13a/0x610
[    4.929294]  ? iommu_group_alloc+0x180/0x180
[    4.929294]  ? set_debug_rodata+0x11/0x11
[    4.929294]  add_iommu_group+0x20/0x30
[    4.929294]  bus_for_each_dev+0x76/0xc0
[    4.929294]  ? down_write+0xe/0x40
[    4.929294]  bus_set_iommu+0xb6/0xf0
[    4.929294]  amd_iommu_init_api+0x112/0x132
[    4.929294]  state_next+0xfb1/0x1165
[    4.929294]  ? set_debug_rodata+0x11/0x11
[    4.929294]  amd_iommu_init+0x1f/0x67
[    4.929294]  ? e820__memblock_setup+0x60/0x60
[    4.929294]  pci_iommu_init+0x16/0x3f
[    4.929294]  do_one_initcall+0x4f/0x1d0
[    4.929294]  ? set_debug_rodata+0x11/0x11
[    4.929294]  kernel_init_freeable+0x1ee/0x27f
[    4.929294]  ? rest_init+0xb0/0xb0
[    4.929294]  kernel_init+0xa/0x110
[    4.929294]  ret_from_fork+0x22/0x40
[    4.929294] ---[ end Kernel panic - not syncing: System is deadlocked =
on memory
[    4.929294]  ]---

--------------ECD0E31B99966CE0B8D4CC98--

--------------ms050606000201000303030004
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTA4MTIwOTQyMzRaMC8GCSqGSIb3DQEJBDEiBCBVKx6kD67cv5HqAdX6
aF/mffQoxtFgLEHrv1GNT8QvvzBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAHK7
rh0O7LRG+I3m91wO22HxDvPppP5degB3p60y36JXaZUbVRojlmB284eHn4Z+RFqQh/XHgfEB
pEtRmbW5Uf7wAbvVjmfwMAxAqR3/KPEf+Q39DCMTbV2FZcEXLWCKWcY+1veaCfnEvzG+et+Y
N9e/Gartv0MTIN9QemJQlLsYVZigSvh4iE05n1tE/yJ6KMJfWIt+h5wS6qwVcfz/H8SniQUC
XZvQOlmrrxgzN+hP/g65T8nyrGFXvwproRRmLm0iaowKcy/leZebg5fpnax+EHuJA07kKz5a
kgqgMbrpzJdKwtab3N4bAfRUaTjLhENqTfHJ1t2C27p8z35F+UIAAAAAAAA=
--------------ms050606000201000303030004--
