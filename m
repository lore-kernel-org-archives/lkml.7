Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A85EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B962D2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=de.amadeus.com header.i=@de.amadeus.com header.b="HztsiTKP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729706AbfC2Pul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:50:41 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.129]:24071 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728936AbfC2Puj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.amadeus.com;
        s=SYM2018Q2; t=1553874617; i=@de.amadeus.com;
        bh=c4Mjg87cUpXFsLJqO2UgDFCYJpKJJ7JAogEF5td0a9U=;
        h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
         In-Reply-To;
        b=HztsiTKP9jHAfirdPJZFvvYRKA3J7RklxG3Vkp0CGLSSnrsTy1A8x1jG2v71HWloI
         3SCegzHG8rLnrjnC66iE8+JZmt51x2BwirSQ881k2pL9TOUH+yP5CH80wAlNy1gKoD
         3ivTZDt+2mg0Y99WjpeSrecY6OfhgmNdcAEa2MPhU3J8M3HL7uINej35rVCY74ffHz
         zhvQMGKpYBnPKHpH3e8iVucjiE6NOWB827gp2u7TGemO/wDRvjRccFl3YTaorToRNa
         UpluzP3b36qDiXlAKQ7F8dCbeTX2OOLahKHutbmxhd7soRNGesAhhKPJREwXxUIjiY
         12OXKUiZSPllQ==
Received: from [46.226.53.57] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.eu-west-1.aws.symcld.net id B1/30-25548-9BE3E9C5; Fri, 29 Mar 2019 15:50:17 +0000
Authentication-Results: mx.messagelabs.com; dkim=none (message not 
  signed); dmarc=none header.from=de.amadeus.com
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRWlGSWpSXmKPExsWyWrBZWXeH3bw
  Yg6k3NCzmrF/DZjHnfAuLxY51O9ktLu+aw2bx+8czJovVJ6axWCzY+IjRgd1jy8qbTB4z/k1l
  9Dgx4zeLx+dNch7v5r9l8+jvPsYewBbFmpmXlF+RwJox+ewltoIFLWwVjcs2sDYw3u1n7WLk4
  hAS2M4ocX3DGShnP6PEzj/vgBxODhYBVYkr16eygNhsAl4SixecZwexRQRsJF43HmQGaWAWaG
  KS2PxgDRNIQljAR2LL9xtgDbwCDhIfz+9hhrAFJU7OfAIWZxbQkViw+xNbFyMHkC0tsfwfB0i
  YU8BcouPTWkaQsKiAisSrg/UgYSEBXYlH796BTZEQUJL42PWeFcIulmh+f4Z5AqPALCQLZiFZ
  MAthwQJG5lWMZklFmekZJbmJmTm6hgYGuoaGRrpGBoa6xnqJVbrJeqmluuWpxSW6hnqJ5cV6x
  ZW5yTkpenmpJZsYgZGSUnCSeQfjsxXphxglOZiURHkf/ZgbI8SXlJ9SmZFYnBFfVJqTWnyIUY
  aDQ0mCNxIYeUKCRanpqRVpmTnAmIVJS3DwKInweoKkeYsLEnOLM9MhUqcY7Tm+tD+ay8wxfQW
  IPPnwGZB82Pp5LrMQS15+XqqUOK+5LVCbAEhbRmke3FBYirnEKCslzMvIwMAgxFOQWpSbWYIq
  /4pRnINRSZiXE2Q5T2ZeCdzuV0BnMQGd9ap+NshZJYkIKakGRkl3Yb2iRCn2CLv5TS+j334We
  ibxqshH0v3nn+ubHmueNC20bFirWqu6sM/i9dwtP9zSbdt8nvB/+Lbk9DLusGavtDQmp0v1l2
  wVkqLYrk3h4l+69lVVyr1cNdu9n+LrpoS+a9v4RM3EgrPgzcHjVnMFDtmxLTJfFitm+OKh7jw
  b2X3NS2sXKbEUZyQaajEXFScCAHx3/UgsAwAA
X-Env-Sender: thomas.weissschuh@de.amadeus.com
X-Msg-Ref: server-9.tower-309.messagelabs.com!1553874616!4205386!2
X-Originating-IP: [171.17.131.35]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 882 invoked from network); 29 Mar 2019 15:50:16 -0000
Received: from unknown (HELO smtpexch.amadeus.com) (171.17.131.35)
  by server-9.tower-309.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 29 Mar 2019 15:50:16 -0000
Received: from MUCEXMBXCASP01.iis.amadeus.net (172.19.131.9) by
 smtpexch.amadeus.com (172.19.134.23) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Fri, 29 Mar 2019 15:48:04 +0000
Received: from fralrnd0033.fra.amadeus.net (172.19.131.243) by
 MUCEXMBXCASP01.iis.amadeus.net (172.19.131.9) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Fri, 29 Mar 2019 15:48:05 +0000
Date:   Fri, 29 Mar 2019 16:47:58 +0100
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= 
        <thomas.weissschuh@de.amadeus.com>
To:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
CC:     <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Shrikrishna Khare <skhare@vmware.com>,
        Max Vozeler <max.vozeler@de.amadeus.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH 3.16 310/366] vmxnet3: fix checks for dma mapping errors
Message-ID: <20190329154756.GA14540@fralrnd0033.fra.amadeus.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <lsq.1539530741.243191634@decadent.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [172.19.131.243]
X-ClientProxiedBy: MUCEXMBXCASP04.iis.amadeus.net (172.19.131.63) To
 MUCEXMBXCASP01.iis.amadeus.net (172.19.131.9)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

Sorry for the late response, this just hit the kernel in Debian Jessie
(oldstable) a few days ago.

> ------------------
> 
> From: Alexey Khoroshilov <khoroshilov@ispras.ru>
> 
> commit 5738a09d58d5ad2871f1f9a42bf6a3aa9ece5b3c upstream.
> 
> vmxnet3_drv does not check dma_addr with dma_mapping_error()
> after mapping dma memory. The patch adds the checks and
> tries to handle failures.

We are seeing kernel panics/machine freezes/BUGs with the new 3.16.64 from Debian.
I bisected it with the vanilla stable kernel and it boiled down to this commit.
VMs of multiple nodes of our vmware cluster are affected.
The bug can be triggered in multiple ways, I have seen it when an external
network request is served, when installing packages over the network and
performing a git clone.

I will try to get the specific versions of the involved hardware components
next week.
The 4.9.144 stable kernel (which also contains this commit works fine on the
affected machine)

Below you can see the dmesg log of one affected machine:

[    1.772994] vmxnet3 0000:03:00.0 eth0: intr type 3, mode 0, 5 vectors allocated
[    1.774079] vmxnet3 0000:03:00.0 eth0: NIC Link is Up 10000 Mbps
[    9.622787] gunicorn: worke: Corrupted page table at address 362d000
[    9.622817] PGD 80000000753b7067 PUD 6f84e067 PMD 76cbb067 PTE 6461685368637845
[    9.622848] Bad pagetable: 000d [#1] SMP 
[    9.622866] Modules linked in: binfmt_misc ip6table_filter ip6_tables ipt_REJECT nf_conntrack_ipv4 nf_defrag_ipv4 xt_comment xt_multiport xt_conntrack nf_conntrack iptable_filter ip_tables x_tables crc32_pclmul crc32c_intel aesni_intel aes_x86_64 glue_helper lrw vmw_vsock_vmci_transport vsock gf128mul vmw_balloon ppdev evdev ablk_helper cryptd pcspkr serio_raw vmwgfx drm_kms_helper ttm ac processor battery button parport_pc thermal_sys drm parport shpchp vmw_vmci autofs4 ext4 crc16 mbcache jbd2 dm_mod sg sr_mod cdrom sd_mod crc_t10dif crct10dif_generic ata_generic crct10dif_pclmul crct10dif_common psmouse vmxnet3 ata_piix mptspi scsi_transport_spi mptscsih libata i2c_piix4 mptbase scsi_mod i2c_core
[    9.623168] CPU: 1 PID: 717 Comm: gunicorn: worke Not tainted 3.16.59+ #18
[    9.623191] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.623225] task: ffff88007835e090 ti: ffff88006f834000 task.ti: ffff88006f834000
[    9.623249] RIP: 0033:[<00007fb4bfb6d123>]  [<00007fb4bfb6d123>] 0x7fb4bfb6d123
[    9.623278] RSP: 002b:00007fff6e4718b8  EFLAGS: 00010206
[    9.623296] RAX: fffffffffff7b8c0 RBX: 00000000036aadc0 RCX: 00000000036b1740
[    9.623318] RDX: 000000000372f500 RSI: 0000000003626690 RDI: 00000000036aade0
[    9.623341] RBP: 0000000000084740 R08: fffffffffff7b8b0 R09: fffffffffff7b8a0
[    9.623363] R10: fffffffffff7b890 R11: 0000000000000037 R12: 0000000000085760
[    9.623385] R13: 00000000004cd810 R14: 0000000000001000 R15: 0000000003589dd0
[    9.623408] FS:  00007fb4c0ffe700(0000) GS:ffff88007fc80000(0000) knlGS:0000000000000000
[    9.623433] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.623451] CR2: 000000000362d000 CR3: 00000000753fa000 CR4: 0000000000360770
[    9.623524] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    9.623547] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

[    9.623577] RIP  [<00007fb4bfb6d123>] 0x7fb4bfb6d123
[    9.623600]  RSP <00007fff6e4718b8>
[    9.623614] ---[ end trace f863ea854df6c9a5 ]---
[    9.624169] swap_free: Bad swap file entry 1001a1e5a32423f7
[    9.624189] BUG: Bad page map in process gunicorn: worke  pte:417869736f702024 pmd:76cbb067
[    9.624215] addr:0000000003600000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3600
[    9.625444] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G      D       3.16.59+ #18
[    9.626070] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.627321]  0000000000000000 ffffffff8151fda4 0000000003600000 ffff8800753700d0
[    9.627968]  ffffffff8116f380 0000000000000008 ffff880076cbb000 417869736f702024
[    9.628596]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003600000
[    9.629213] Call Trace:
[    9.629811]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.630413]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.630991]  [<ffffffff811707a2>] ? unmap_single_vma+0x4c2/0x830
[    9.631556]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.632106]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.632640]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.633162]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.633677]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.634171]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.634653]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.635129]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.635629] BUG: Bad page map in process gunicorn: worke  pte:2420746e756f6363 pmd:76cbb067
[    9.636111] addr:0000000003601000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3601
[    9.637080] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.637594] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.638611]  0000000000000000 ffffffff8151fda4 0000000003601000 ffff8800753700d0
[    9.639145]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb008 2420746e756f6363
[    9.639671]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003601000
[    9.640203] Call Trace:
[    9.640737]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.641268]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.641798]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.642320]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.642839]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.643357]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.643867]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.644359]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.644837]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.645304]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.645758]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.646196]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.646634]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.647078] BUG: Bad page map in process gunicorn: worke  pte:4d68637845736d20 pmd:76cbb067
[    9.647552] addr:0000000003602000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3602
[    9.648420] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.648876] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.649810]  0000000000000000 ffffffff8151fda4 0000000003602000 ffff8800753700d0
[    9.650310]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb010 4d68637845736d20
[    9.650827]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003602000
[    9.651341] Call Trace:
[    9.651846]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.652362]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.652903]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.653419]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.653917]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.654406]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.654879]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.655341]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.655789]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.656221]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.656647]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.657062]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.657487]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.657912] BUG: Bad page map in process gunicorn: worke  pte:614d786f626c6961 pmd:76cbb067
[    9.658331] addr:0000000003603000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3603
[    9.659218] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.659676] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.660610]  0000000000000000 ffffffff8151fda4 0000000003603000 ffff8800753700d0
[    9.661110]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb018 614d786f626c6961
[    9.661620]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003603000
[    9.662132] Call Trace:
[    9.662637]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.663156]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.663673]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.664182]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.664686]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.665175]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.665649]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.666111]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.666559]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.666992]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.667425]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.667841]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.668252]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.668676] BUG: Bad page map in process gunicorn: worke  pte:6c6f50726567616e pmd:76cbb067
[    9.669096] addr:0000000003604000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3604
[    9.669951] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.670407] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.671345]  0000000000000000 ffffffff8151fda4 0000000003604000 ffff8800753700d0
[    9.671851]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb020 6c6f50726567616e
[    9.672357]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003604000
[    9.672870] Call Trace:
[    9.673376]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.673892]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.674410]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.674924]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.675424]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.675912]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.676385]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.676848]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.677296]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.677744]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.678165]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.678579]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.678990]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.679410] BUG: Bad page map in process gunicorn: worke  pte:414d202920796369 pmd:76cbb067
[    9.679829] addr:0000000003605000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3605
[    9.680682] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.681137] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.682076]  0000000000000000 ffffffff8151fda4 0000000003605000 ffff8800753700d0
[    9.682575]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb028 414d202920796369
[    9.683079]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003605000
[    9.683593] Call Trace:
[    9.684098]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.684620]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.685137]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.685647]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.686144]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.686633]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.687106]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.687580]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.688027]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.688460]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.688887]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.689301]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.689712]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.690131] BUG: Bad page map in process gunicorn: worke  pte:49776f6873282059 pmd:76cbb067
[    9.690551] addr:0000000003606000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3606
[    9.691424] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.691881] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.692816]  0000000000000000 ffffffff8151fda4 0000000003606000 ffff8800753700d0
[    9.693315]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb030 49776f6873282059
[    9.693825]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003606000
[    9.694338] Call Trace:
[    9.694843]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.695361]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.695878]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.696387]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.696891]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.697379]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.697866]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.698328]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.698777]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.699215]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.699636]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.700051]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.700468]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.700909] BUG: Bad page map in process gunicorn: worke  pte:737365726464416e pmd:76cbb067
[    9.701327] addr:0000000003607000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3607
[    9.702181] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.702636] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.703592]  0000000000000000 ffffffff8151fda4 0000000003607000 ffff8800753700d0
[    9.704092]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb038 737365726464416e
[    9.704597]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003607000
[    9.705110] Call Trace:
[    9.705719]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.706305]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.706936]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.707492]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.707991]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.708487]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.708962]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.709426]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.709881]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.710315]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.710743]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.711159]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.711572]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.712000] BUG: Bad page map in process gunicorn: worke  pte:6c2024206b6f6f42 pmd:76cbb067
[    9.712422] addr:0000000003608000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3608
[    9.713280] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.713737] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.714681]  0000000000000000 ffffffff8151fda4 0000000003608000 ffff8800753700d0
[    9.715186]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb040 6c2024206b6f6f42
[    9.715698]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003608000
[    9.716212] Call Trace:
[    9.716719]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.717237]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.717770]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.718281]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.718780]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.719270]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.719758]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.720222]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.720677]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.721111]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.721533]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.721954]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.722366]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.722791] BUG: Bad page map in process gunicorn: worke  pte:6378457963616765 pmd:76cbb067
[    9.723226] addr:0000000003609000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3609
[    9.724088] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.724550] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.725491]  0000000000000000 ffffffff8151fda4 0000000003609000 ffff8800753700d0
[    9.725991]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb048 6378457963616765
[    9.726496]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003609000
[    9.727008] Call Trace:
[    9.727534]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.728050]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.728568]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.729081]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.729580]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.730069]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.730549]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.731012]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.731461]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.731899]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.732326]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.732741]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.733153]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.733582] BUG: Bad page map in process gunicorn: worke  pte:204e4465676e6168 pmd:76cbb067
[    9.734002] addr:000000000360a000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:360a
[    9.734857] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.735322] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.736257]  0000000000000000 ffffffff8151fda4 000000000360a000 ffff8800753700d0
[    9.736770]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb050 204e4465676e6168
[    9.737276]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000360a000
[    9.737806] Call Trace:
[    9.738314]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.738830]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.739347]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.739856]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.740359]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.740853]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.741327]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.741789]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.742238]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.742676]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.743097]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.743518]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.743935]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.744365] swap_free: Bad swap file entry 1a01e721eea324b7
[    9.744771] BUG: Bad page map in process gunicorn: worke  pte:68637845736d2024 pmd:76cbb067
[    9.745190] addr:000000000360b000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:360b
[    9.746077] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.746546] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.747512]  0000000000000000 ffffffff8151fda4 000000000360b000 ffff8800753700d0
[    9.748022]  ffffffff8116f380 000000000000000d ffff880076cbb058 68637845736d2024
[    9.748534]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000360b000
[    9.749052] Call Trace:
[    9.749562]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.750087]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.750613]  [<ffffffff811707a2>] ? unmap_single_vma+0x4c2/0x830
[    9.751123]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.751621]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.752114]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.752586]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.753045]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.753494]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.753926]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.754354]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.754805] BUG: Bad page map in process gunicorn: worke  pte:61447972616e6143 pmd:76cbb067
[    9.755255] addr:000000000360c000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:360c
[    9.756128] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.756594] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.757577]  0000000000000000 ffffffff8151fda4 000000000360c000 ffff8800753700d0
[    9.758087]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb060 61447972616e6143
[    9.758607]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000360c000
[    9.759132] Call Trace:
[    9.759650]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.760177]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.760711]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.761232]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.761752]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.762275]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.762780]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.763272]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.763761]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.764233]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.764687]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.765125]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.765555]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.765999] BUG: Bad page map in process gunicorn: worke  pte:6568202420326174 pmd:76cbb067
[    9.766438] addr:000000000360d000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:360d
[    9.767325] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.767799] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.768732]  0000000000000000 ffffffff8151fda4 000000000360d000 ffff8800753700d0
[    9.769231]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb068 6568202420326174
[    9.769736]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000360d000
[    9.770253] Call Trace:
[    9.770771]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.771290]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.771807]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.772322]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.772820]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.773309]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.773789]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.774251]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.774699]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.775135]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.775556]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.775977]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.776388]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.776814] BUG: Bad page map in process gunicorn: worke  pte:7363697473697275 pmd:76cbb067
[    9.777234] addr:000000000360e000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:360e
[    9.778105] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.778561] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.779498]  0000000000000000 ffffffff8151fda4 000000000360e000 ffff8800753700d0
[    9.780003]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb070 7363697473697275
[    9.780514]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000360e000
[    9.781027] Call Trace:
[    9.781533]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.782054]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.782572]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.783087]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.783593]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.784082]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.784556]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.785019]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.785468]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.785902]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.786323]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.786744]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.787155]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.787598] swap_free: Bad swap file entry 180121eea324b7f6
[    9.788001] BUG: Bad page map in process gunicorn: worke  pte:637845736d202420 pmd:76cbb067
[    9.788421] addr:000000000360f000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:360f
[    9.789290] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.789748] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.790698]  0000000000000000 ffffffff8151fda4 000000000360f000 ffff8800753700d0
[    9.791202]  ffffffff8116f380 000000000000000c ffff880076cbb078 637845736d202420
[    9.791716]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000360f000
[    9.792234] Call Trace:
[    9.792744]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.793263]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.793792]  [<ffffffff811707a2>] ? unmap_single_vma+0x4c2/0x830
[    9.794303]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.794800]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.795284]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.795756]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.796215]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.796664]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.797096]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.797540]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.797979] swap_free: Bad swap file entry 100122e467a466aa
[    9.798398] BUG: Bad page map in process gunicorn: worke  pte:43746e616e655468 pmd:76cbb067
[    9.798832] addr:0000000003610000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3610
[    9.799738] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.800211] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.801201]  0000000000000000 ffffffff8151fda4 0000000003610000 ffff8800753700d0
[    9.801717]  ffffffff8116f380 0000000000000008 ffff880076cbb080 43746e616e655468
[    9.802240]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003610000
[    9.802775] Call Trace:
[    9.803300]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.803833]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.804366]  [<ffffffff811707a2>] ? unmap_single_vma+0x4c2/0x830
[    9.804901]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.805429]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.805952]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.806456]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.806946]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.807424]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.807902]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.808357]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.808821] BUG: Bad page map in process gunicorn: worke  pte:24207972746e756f pmd:76cbb067
[    9.809276] addr:0000000003611000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3611
[    9.810180] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.810648] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.811615]  0000000000000000 ffffffff8151fda4 0000000003611000 ffff8800753700d0
[    9.812125]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb088 24207972746e756f
[    9.812641]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003611000
[    9.813165] Call Trace:
[    9.813682]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.814210]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.814746]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.815269]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.815790]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.816309]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.816821]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.817315]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.817808]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.818276]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.818730]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.819169]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.819600]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.820041] BUG: Bad page map in process gunicorn: worke  pte:5368637845736d20 pmd:76cbb067
[    9.820483] addr:0000000003612000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3612
[    9.821351] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.821812] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.822753]  0000000000000000 ffffffff8151fda4 0000000003612000 ffff8800753700d0
[    9.823256]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb090 5368637845736d20
[    9.823761]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003612000
[    9.824273] Call Trace:
[    9.824779]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.825296]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.825822]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.826332]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.826830]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.827319]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.827809]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.828271]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.828720]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.829152]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.829573]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.829987]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.830398]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.830835] BUG: Bad page map in process gunicorn: worke  pte:7461745370757465 pmd:76cbb067
[    9.831272] addr:0000000003613000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3613
[    9.832127] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.832583] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.833516]  0000000000000000 ffffffff8151fda4 0000000003613000 ffff8800753700d0
[    9.834039]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb098 7461745370757465
[    9.834545]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003613000
[    9.835058] Call Trace:
[    9.835567]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.836083]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.836607]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.837117]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.837635]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.838123]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.838597]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.839059]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.839507]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.839940]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.840361]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.840781]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.841193]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.841615] BUG: Bad page map in process gunicorn: worke  pte:45736d2024207375 pmd:76cbb067
[    9.842036] addr:0000000003614000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3614
[    9.842890] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.843348] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.844285]  0000000000000000 ffffffff8151fda4 0000000003614000 ffff8800753700d0
[    9.844790]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0a0 45736d2024207375
[    9.845296]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003614000
[    9.845808] Call Trace:
[    9.846314]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.846831]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.847348]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.847877]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.848375]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.848864]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.849338]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.849800]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.850249]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.850688]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.851109]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.851523]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.851935]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.852355] BUG: Bad page map in process gunicorn: worke  pte:736e617254686378 pmd:76cbb067
[    9.852775] addr:0000000003615000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3615
[    9.853628] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.854083] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.855025]  0000000000000000 ffffffff8151fda4 0000000003615000 ffff8800753700d0
[    9.855526]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0a8 736e617254686378
[    9.856031]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003615000
[    9.856544] Call Trace:
[    9.857049]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.857580]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.858098]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.858608]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.859141]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.859665]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.860185]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.860681]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.861131]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.861660]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.862108]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.862597]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.863072]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.863499] BUG: Bad page map in process gunicorn: worke  pte:6f626e4974726f70 pmd:76cbb067
[    9.863920] addr:0000000003616000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3616
[    9.864776] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.865233] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.866176]  0000000000000000 ffffffff8151fda4 0000000003616000 ffff8800753700d0
[    9.866679]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0b0 6f626e4974726f70
[    9.867185]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003616000
[    9.867721] Call Trace:
[    9.868228]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.868745]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.869262]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.869772]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.870271]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.870766]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.871240]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.871703]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.872152]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.872608]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.873047]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.873462]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.873879]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.874301] BUG: Bad page map in process gunicorn: worke  pte:6974746553646e75 pmd:76cbb067
[    9.874721] addr:0000000003617000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3617
[    9.875593] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.876049] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.876983]  0000000000000000 ffffffff8151fda4 0000000003617000 ffff8800753700d0
[    9.877483]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0b8 6974746553646e75
[    9.878001]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003617000
[    9.878514] Call Trace:
[    9.879019]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.879538]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.880055]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.880565]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.881068]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.881557]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.882031]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.882493]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.882946]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.883379]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.883805]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.884219]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.884630]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.885050] BUG: Bad page map in process gunicorn: worke  pte:736d20242073676e pmd:76cbb067
[    9.885470] addr:0000000003618000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3618
[    9.886324] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.886779] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.887733]  0000000000000000 ffffffff8151fda4 0000000003618000 ffff8800753700d0
[    9.888232]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0c0 736d20242073676e
[    9.888738]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003618000
[    9.889250] Call Trace:
[    9.889755]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.890272]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.890795]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.891306]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.891804]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.892294]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.892769]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.893232]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.893687]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.894120]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.894542]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.894957]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.895368]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.895789] BUG: Bad page map in process gunicorn: worke  pte:624f4c4168637845 pmd:76cbb067
[    9.896208] addr:0000000003619000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3619
[    9.897063] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.897519] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.898467]  0000000000000000 ffffffff8151fda4 0000000003619000 ffff8800753700d0
[    9.898967]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0c8 624f4c4168637845
[    9.899476]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003619000
[    9.899989] Call Trace:
[    9.900495]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.901018]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.901536]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.902048]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.902548]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.903038]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.903513]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.903983]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.904432]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.904866]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.905288]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.905704]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.906115]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.906535] BUG: Bad page map in process gunicorn: worke  pte:737265567463656a pmd:76cbb067
[    9.906954] addr:000000000361a000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:361a
[    9.907851] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.908309] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.909245]  0000000000000000 ffffffff8151fda4 000000000361a000 ffff8800753700d0
[    9.909745]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0d0 737265567463656a
[    9.910250]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000361a000
[    9.910769] Call Trace:
[    9.911275]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.911793]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.912310]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.912819]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.913318]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.913812]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.914286]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.914748]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.915197]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.915631]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.916052]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.916467]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.916883]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.917304] BUG: Bad page map in process gunicorn: worke  pte:65722024206e6f69 pmd:76cbb067
[    9.917739] addr:000000000361b000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:361b
[    9.918592] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.919046] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.919983]  0000000000000000 ffffffff8151fda4 000000000361b000 ffff8800753700d0
[    9.920483]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0d8 65722024206e6f69
[    9.920993]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000361b000
[    9.921505] Call Trace:
[    9.922011]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.922527]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.923044]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.923554]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.924062]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.924551]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.925025]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.925524]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.925974]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.926406]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.926827]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.927241]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.927667]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.928087] swap_free: Bad swap file entry 1a0025a2e7a725a4
[    9.928492] BUG: Bad page map in process gunicorn: worke  pte:6f69746163696c70 pmd:76cbb067
[    9.928912] addr:000000000361c000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:361c
[    9.929780] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.930238] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.931186]  0000000000000000 ffffffff8151fda4 000000000361c000 ffff8800753700d0
[    9.931692]  ffffffff8116f380 000000000000000d ffff880076cbb0e0 6f69746163696c70
[    9.932204]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000361c000
[    9.932721] Call Trace:
[    9.933231]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.933755]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.934300]  [<ffffffff811707a2>] ? unmap_single_vma+0x4c2/0x830
[    9.934833]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.935339]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.935822]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.936294]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.936758]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.937200]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.937644]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.938071]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.938519] BUG: Bad page map in process gunicorn: worke  pte:7574616e6769536e pmd:76cbb067
[    9.938952] addr:000000000361d000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:361d
[    9.939843] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.940311] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.941268]  0000000000000000 ffffffff8151fda4 000000000361d000 ffff8800753700d0
[    9.941777]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0e8 7574616e6769536e
[    9.942293]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000361d000
[    9.942822] Call Trace:
[    9.943341]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.943869]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.944415]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.944938]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.945459]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.945984]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.946490]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.946984]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.947463]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.947949]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.948404]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.948843]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.949274]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.949718] BUG: Bad page map in process gunicorn: worke  pte:45736d2024206572 pmd:76cbb067
[    9.950158] addr:000000000361e000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:361e
[    9.951028] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.951507] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.952445]  0000000000000000 ffffffff8151fda4 000000000361e000 ffff8800753700d0
[    9.952946]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0f0 45736d2024206572
[    9.953453]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000361e000
[    9.953972] Call Trace:
[    9.954479]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.954997]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.955515]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.956026]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.956526]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.957021]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.957496]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.957972]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.958421]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.958855]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.959277]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.959692]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.960103]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.960525] BUG: Bad page map in process gunicorn: worke  pte:7973726944686378 pmd:76cbb067
[    9.960945] addr:000000000361f000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:361f
[    9.961798] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.962253] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.963196]  0000000000000000 ffffffff8151fda4 000000000361f000 ffff8800753700d0
[    9.963697]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb0f8 7973726944686378
[    9.964203]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000361f000
[    9.964716] Call Trace:
[    9.965221]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.965744]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.966262]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.966772]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.967270]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.967773]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.968247]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.968710]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.969159]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.969593]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.970014]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.970430]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.970848]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.971269] BUG: Bad page map in process gunicorn: worke  pte:726f68747541636e pmd:76cbb067
[    9.971706] addr:0000000003620000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3620
[    9.972562] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.973018] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.973955]  0000000000000000 ffffffff8151fda4 0000000003620000 ffff8800753700d0
[    9.974456]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb100 726f68747541636e
[    9.974967]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003620000
[    9.975481] Call Trace:
[    9.975987]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.976504]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.977021]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.977532]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.978045]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.978534]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.979009]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.979472]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.979922]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.980355]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.980783]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.981198]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.981609]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.982030] BUG: Bad page map in process gunicorn: worke  pte:646174654d797469 pmd:76cbb067
[    9.982450] addr:0000000003621000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3621
[    9.983304] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.983762] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.984701]  0000000000000000 ffffffff8151fda4 0000000003621000 ffff8800753700d0
[    9.985200]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb108 646174654d797469
[    9.985705]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003621000
[    9.986218] Call Trace:
[    9.986723]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.987239]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.987773]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.988284]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.988782]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[    9.989271]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[    9.989746]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[    9.990208]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[    9.990658]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[    9.991096]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[    9.991517]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[    9.991933]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[    9.992344]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[    9.992765] BUG: Bad page map in process gunicorn: worke  pte:736d202420617461 pmd:76cbb067
[    9.993184] addr:0000000003622000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3622
[    9.994039] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[    9.994495] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[    9.995433]  0000000000000000 ffffffff8151fda4 0000000003622000 ffff8800753700d0
[    9.995941]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb110 736d202420617461
[    9.996447]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003622000
[    9.996961] Call Trace:
[    9.997466]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[    9.997997]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.998514]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[    9.999024]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[    9.999523]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.000012]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.000488]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.000959]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.001410]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.001845]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.002268]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.002684]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.003096]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.003517] BUG: Bad page map in process gunicorn: worke  pte:6166654468637845 pmd:76cbb067
[   10.003936] addr:0000000003623000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3623
[   10.004792] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.005249] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.006191]  0000000000000000 ffffffff8151fda4 0000000003623000 ffff8800753700d0
[   10.006692]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb118 6166654468637845
[   10.007199]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003623000
[   10.007728] Call Trace:
[   10.008235]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.008753]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.009272]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.009784]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.010284]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.010784]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.011259]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.011723]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.012173]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.012607]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.013029]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.013449]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.013867]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.014287] BUG: Bad page map in process gunicorn: worke  pte:696c627550746c75 pmd:76cbb067
[   10.014706] addr:0000000003624000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3624
[   10.015660] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.016167] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.017131]  0000000000000000 ffffffff8151fda4 0000000003624000 ffff8800753700d0
[   10.017631]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb120 696c627550746c75
[   10.018152]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003624000
[   10.018665] Call Trace:
[   10.019170]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.019689]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.020206]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.020722]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.021220]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.021708]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.022182]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.022644]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.023092]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.023525]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.023951]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.024365]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.024775]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.025199] BUG: Bad page map in process gunicorn: worke  pte:4d7265646c6f4663 pmd:76cbb067
[   10.025617] addr:0000000003625000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3625
[   10.026508] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.026963] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.028333]  0000000000000000 ffffffff8151fda4 0000000003625000 ffff8800753700d0
[   10.028844]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb128 4d7265646c6f4663
[   10.029348]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003625000
[   10.029861] Call Trace:
[   10.030368]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.030885]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.031403]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.031919]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.032418]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.032908]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.033382]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.033844]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.034293]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.034732]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.035153]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.035569]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.035986]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.036412] BUG: Bad page map in process gunicorn: worke  pte:2420786f626c6961 pmd:76cbb067
[   10.036832] addr:0000000003626000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3626
[   10.037688] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.038152] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.039088]  0000000000000000 ffffffff8151fda4 0000000003626000 ffff8800753700d0
[   10.039590]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb130 2420786f626c6961
[   10.040097]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003626000
[   10.040620] Call Trace:
[   10.041126]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.041643]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.042161]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.042671]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.043176]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.043665]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.044139]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.044602]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.045051]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.045484]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.045912]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.046327]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.046738]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.047160] BUG: Bad page map in process gunicorn: worke  pte:4568637845736d20 pmd:76cbb067
[   10.047594] addr:0000000003627000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3627
[   10.048457] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.048912] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.049845]  0000000000000000 ffffffff8151fda4 0000000003627000 ffff8800753700d0
[   10.050344]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb138 4568637845736d20
[   10.050855]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003627000
[   10.051367] Call Trace:
[   10.051876]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.052392]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.052909]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.053419]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.053923]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.054412]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.054886]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.055348]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.055797]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.056229]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.056650]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.057071]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.057482]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.057922] BUG: Bad page map in process gunicorn: worke  pte:656c62616e457377 pmd:76cbb067
[   10.058343] addr:0000000003628000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3628
[   10.059197] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.059655] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.060589]  0000000000000000 ffffffff8151fda4 0000000003628000 ffff8800753700d0
[   10.061094]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb140 656c62616e457377
[   10.061600]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003628000
[   10.062113] Call Trace:
[   10.062619]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.063135]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.063653]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.064169]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.064668]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.065157]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.065631]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.066094]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.066544]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.066983]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.067404]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.067837]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.068248]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.068669] swap_free: Bad swap file entry 1a00e3e6a377f6f7
[   10.069073] BUG: Bad page map in process gunicorn: worke  pte:6c70657220242064 pmd:76cbb067
[   10.069493] addr:0000000003629000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3629
[   10.070362] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.070826] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.071773]  0000000000000000 ffffffff8151fda4 0000000003629000 ffff8800753700d0
[   10.072276]  ffffffff8116f380 000000000000000d ffff880076cbb148 6c70657220242064
[   10.072790]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003629000
[   10.073308] Call Trace:
[   10.073825]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.074345]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.074866]  [<ffffffff811707a2>] ? unmap_single_vma+0x4c2/0x830
[   10.075378]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.075876]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.076361]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.076842]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.077301]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.077761]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.078193]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.078623]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.079064] BUG: Bad page map in process gunicorn: worke  pte:624f646574616369 pmd:76cbb067
[   10.079514] addr:000000000362a000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:362a
[   10.080385] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.080851] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.081815]  0000000000000000 ffffffff8151fda4 000000000362a000 ffff8800753700d0
[   10.082324]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb150 624f646574616369
[   10.082840]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000362a000
[   10.083362] Call Trace:
[   10.083881]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.084408]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.084943]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.085464]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.085985]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.086504]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.087009]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.087503]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.087992]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.088459]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.088915]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.089355]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.089786]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.090228] BUG: Bad page map in process gunicorn: worke  pte:737265567463656a pmd:76cbb067
[   10.090667] addr:000000000362b000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:362b
[   10.091555] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.092013] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.092949]  0000000000000000 ffffffff8151fda4 000000000362b000 ffff8800753700d0
[   10.093448]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb158 737265567463656a
[   10.093959]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000362b000
[   10.094472] Call Trace:
[   10.094978]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.095497]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.096015]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.096525]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.097030]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.097520]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.098010]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.098474]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.098923]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.099356]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.099778]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.100194]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.100606]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.101031] BUG: Bad page map in process gunicorn: worke  pte:736d2024206e6f69 pmd:76cbb067
[   10.101450] addr:000000000362c000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:362c
[   10.102307] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.102764] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.103702]  0000000000000000 ffffffff8151fda4 000000000362c000 ffff8800753700d0
[   10.104208]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb160 736d2024206e6f69
[   10.104714]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000362c000
[   10.105227] Call Trace:
[   10.105733]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.106251]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.106775]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.107286]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.107803]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.108306]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.108781]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.109244]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.109693]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.110127]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.110549]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.110969]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.111381]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.111802] BUG: Bad page map in process gunicorn: worke  pte:6461685368637845 pmd:76cbb067
[   10.112219] addr:000000000362d000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:362d
[   10.113073] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.113529] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.114464]  0000000000000000 ffffffff8151fda4 000000000362d000 ffff8800753700d0
[   10.114969]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb168 6461685368637845
[   10.115478]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000362d000
[   10.115992] Call Trace:
[   10.116499]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.117016]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.117534]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.118057]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.118556]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.119046]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.119521]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.119984]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.120433]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.120873]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.121295]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.121711]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.122123]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.122544] BUG: Bad page map in process gunicorn: worke  pte:48726568744f776f pmd:76cbb067
[   10.122962] addr:000000000362e000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:362e
[   10.123836] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.124293] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.125231]  0000000000000000 ffffffff8151fda4 000000000362e000 ffff8800753700d0
[   10.125731]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb170 48726568744f776f
[   10.126237]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000362e000
[   10.126750] Call Trace:
[   10.127260]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.127796]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.128314]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.128824]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.129322]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.129811]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.130285]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.130747]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.131201]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.131634]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.132056]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.132470]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.132881]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.133303] BUG: Bad page map in process gunicorn: worke  pte:656e6f6850656d6f pmd:76cbb067
[   10.133722] addr:000000000362f000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:362f
[   10.134574] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.135029] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.135970]  0000000000000000 ffffffff8151fda4 000000000362f000 ffff8800753700d0
[   10.136476]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb178 656e6f6850656d6f
[   10.136981]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000362f000
[   10.137493] Call Trace:
[   10.138013]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.138530]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.139053]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.139562]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.140060]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.140549]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.141036]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.141498]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.141947]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.142379]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.142800]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.143215]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.143627]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.144054] swap_free: Bad swap file entry 1c0166a4a462b7f6
[   10.144459] BUG: Bad page map in process gunicorn: worke  pte:72656d6e75202420 pmd:76cbb067
[   10.144881] addr:0000000003630000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3630
[   10.145752] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.146212] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.147167]  0000000000000000 ffffffff8151fda4 0000000003630000 ffff8800753700d0
[   10.147674]  ffffffff8116f380 000000000000000e ffff880076cbb180 72656d6e75202420
[   10.148201]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003630000
[   10.148718] Call Trace:
[   10.149229]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.149749]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.150270]  [<ffffffff811707a2>] ? unmap_single_vma+0x4c2/0x830
[   10.150783]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.151286]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.151771]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.152245]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.152704]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.153214]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.153654]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.154083]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.154531] BUG: Bad page map in process gunicorn: worke  pte:2073747441646567 pmd:76cbb067
[   10.154963] addr:0000000003631000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3631
[   10.155854] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.156323] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.157280]  0000000000000000 ffffffff8151fda4 0000000003631000 ffff8800753700d0
[   10.157789]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb188 2073747441646567
[   10.158322]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003631000
[   10.158851] Call Trace:
[   10.159368]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.159897]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.160427]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.160954]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.161488]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.162006]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.162511]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.163010]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.163488]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.163966]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.164429]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.164869]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.165300]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.165742] swap_free: Bad swap file entry 1a01e721eea324b7
[   10.166165] BUG: Bad page map in process gunicorn: worke  pte:68637845736d2024 pmd:76cbb067
[   10.166602] addr:0000000003632000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3632
[   10.167475] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.167994] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.169003]  0000000000000000 ffffffff8151fda4 0000000003632000 ffff8800753700d0
[   10.169514]  ffffffff8116f380 000000000000000d ffff880076cbb190 68637845736d2024
[   10.170027]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003632000
[   10.170545] Call Trace:
[   10.171056]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.171585]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.172106]  [<ffffffff811707a2>] ? unmap_single_vma+0x4c2/0x830
[   10.172618]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.173116]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.173601]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.174074]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.174534]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.174978]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.175410]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.175839]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.176281] BUG: Bad page map in process gunicorn: worke  pte:6f437463656a624f pmd:76cbb067
[   10.176714] addr:0000000003633000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3633
[   10.177592] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.178075] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.179038]  0000000000000000 ffffffff8151fda4 0000000003633000 ffff8800753700d0
[   10.179555]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb198 6f437463656a624f
[   10.180071]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003633000
[   10.180594] Call Trace:
[   10.181118]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.181645]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.182174]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.182697]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.183224]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.183743]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.184259]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.184753]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.185232]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.185700]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.186154]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.186594]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.187030]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.187471] BUG: Bad page map in process gunicorn: worke  pte:61746f7551746e75 pmd:76cbb067
[   10.187935] addr:0000000003634000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3634
[   10.188804] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.189261] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.190202]  0000000000000000 ffffffff8151fda4 0000000003634000 ffff8800753700d0
[   10.190702]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb1a0 61746f7551746e75
[   10.191213]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003634000
[   10.191729] Call Trace:
[   10.192235]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.192752]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.193269]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.193785]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.194290]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.194780]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.195261]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.195724]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.196173]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.196606]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.197036]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.197451]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.197876]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.198296] swap_free: Bad swap file entry 180121eea324b7f6
[   10.198701] BUG: Bad page map in process gunicorn: worke  pte:637845736d202420 pmd:76cbb067
[   10.199125] addr:0000000003635000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3635
[   10.200016] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.200476] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.201418]  0000000000000000 ffffffff8151fda4 0000000003635000 ffff8800753700d0
[   10.201921]  ffffffff8116f380 000000000000000c ffff880076cbb1a8 637845736d202420
[   10.202432]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003635000
[   10.202959] Call Trace:
[   10.203468]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.203990]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.204515]  [<ffffffff811707a2>] ? unmap_single_vma+0x4c2/0x830
[   10.205026]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.205524]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.206013]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.206486]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.206944]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.207387]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.207818]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.208267]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.208708] BUG: Bad page map in process gunicorn: worke  pte:54776f6461685368 pmd:76cbb067
[   10.209143] addr:0000000003636000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3636
[   10.210014] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.210481] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.211445]  0000000000000000 ffffffff8151fda4 0000000003636000 ffff8800753700d0
[   10.211957]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb1b0 54776f6461685368
[   10.212473]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003636000
[   10.212996] Call Trace:
[   10.213519]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.214155]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.214686]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.215209]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.215763]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.216310]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.216824]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.217318]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.217804]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.218287]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.218743]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.219183]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.219615]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.220066] BUG: Bad page map in process gunicorn: worke  pte:6d202420656c7469 pmd:76cbb067
[   10.220507] addr:0000000003637000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3637
[   10.221377] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.221842] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.222778]  0000000000000000 ffffffff8151fda4 0000000003637000 ffff8800753700d0
[   10.223284]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb1b8 6d202420656c7469
[   10.223792]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003637000
[   10.224306] Call Trace:
[   10.224813]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.225344]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.225868]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.226379]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.226878]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.227373]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.227860]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.228325]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.228775]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.229209]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.229630]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.230046]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.230463]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.230891] BUG: Bad page map in process gunicorn: worke  pte:6168536863784573 pmd:76cbb067
[   10.231312] addr:0000000003638000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3638
[   10.232198] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.232657] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.233596]  0000000000000000 ffffffff8151fda4 0000000003638000 ffff8800753700d0
[   10.234096]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb1c0 6168536863784573
[   10.234602]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003638000
[   10.235121] Call Trace:
[   10.235629]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.236146]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.236664]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.237174]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.237679]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.238177]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.238652]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.239114]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.239564]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.240002]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.240424]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.240839]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.241256]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.241683] BUG: Bad page map in process gunicorn: worke  pte:6c69626f4d776f64 pmd:76cbb067
[   10.242103] addr:0000000003639000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:3639
[   10.242957] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.243413] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.244356]  0000000000000000 ffffffff8151fda4 0000000003639000 ffff8800753700d0
[   10.244855]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb1c8 6c69626f4d776f64
[   10.245361]  0000000000000000 000000000373f000 ffff88006f837dd0 0000000003639000
[   10.245874] Call Trace:
[   10.246380]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.246902]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.247420]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.247944]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.248443]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.248932]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.249406]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.249869]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.250319]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.250752]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.251179]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.251595]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.252007]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.252427] BUG: Bad page map in process gunicorn: worke  pte:7845736d20242065 pmd:76cbb067
[   10.252845] addr:000000000363a000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:363a
[   10.253701] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.254157] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.255099]  0000000000000000 ffffffff8151fda4 000000000363a000 ffff8800753700d0
[   10.255601]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb1d0 7845736d20242065
[   10.256107]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000363a000
[   10.256620] Call Trace:
[   10.257126]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.257642]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.258174]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.258685]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.259184]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.259673]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.260147]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.260610]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.261065]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.261498]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.261920]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.262334]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.262745]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.263164] BUG: Bad page map in process gunicorn: worke  pte:533450414d496863 pmd:76cbb067
[   10.263599] addr:000000000363b000 vm_flags:08100073 anon_vma:ffff88007538c470 mapping:          (null) index:363b
[   10.264453] CPU: 1 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.264909] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.265843]  0000000000000000 ffffffff8151fda4 000000000363b000 ffff8800753700d0
[   10.266348]  ffffffff8116f380 ffffffff8116f380 ffff880076cbb1d8 533450414d496863
[   10.266853]  0000000000000000 000000000373f000 ffff88006f837dd0 000000000363b000
[   10.267365] Call Trace:
[   10.267873]  [<ffffffff8151fda4>] ? dump_stack+0x5d/0x78
[   10.268401]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.268919]  [<ffffffff8116f380>] ? print_bad_pte+0x1b0/0x280
[   10.269428]  [<ffffffff811702a7>] ? vm_normal_page+0x87/0xc0
[   10.269927]  [<ffffffff81170820>] ? unmap_single_vma+0x540/0x830
[   10.270417]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.270897]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.271359]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.271809]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.272242]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.272663]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.273078]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.273490]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.273915] swap_free: Bad swap file entry 1a01e721eea324b7
[   10.274322] swap_free: Bad swap file entry 1a01e721eea324b7
[   10.274717] swap_free: Bad swap file entry 1a01e721eea324b7
[   10.275112] swap_free: Bad swap file entry 180121eea324b7f6
[   10.275504] swap_free: Bad swap file entry 180121eea324b7f6
[   10.275910] swap_free: Bad swap file entry 801f6f7e32627a4
[   10.276295] swap_free: Bad swap file entry 180121eea324b7f6
[   10.276676] swap_free: Bad swap file entry 180121eea324b7f6
[   10.277050] swap_free: Bad swap file entry 1a0023e32467a36a
[   10.277422] swap_free: Bad swap file entry 1c00a42762e2ac22
[   10.277791] swap_free: Bad swap file entry 1a0065a2e2e6ab26
[   10.278174] swap_free: Bad swap file entry 1a01e721eea324b7
[   10.278537] swap_free: Bad swap file entry 1a01e721eea324b7
[   10.278892] swap_free: Bad swap file entry 180121eea324b7f6
[   10.279233] swap_free: Bad swap file entry 180121eea324b7f6
[   10.279556] swap_free: Bad swap file entry 1a01e721eea324b7
[   10.279885] swap_free: Bad swap file entry 1a01e721eea324b7
[   10.280177] swap_free: Bad swap file entry 180121eea324b7f6
[   10.280452] swap_free: Bad swap file entry 1e01eea324b7f6f7
[   10.280709] swap_free: Bad swap file entry 1000a324b7f6f7e2
[   10.280951] swap_free: Bad swap file entry 180121eea324b7f6
[   10.281184] swap_free: Bad swap file entry 1e01eea324b7f6f7
[   10.281407] swap_free: Bad swap file entry 1a00a2ac66a46425
[   10.281619] swap_free: Bad swap file entry 1c0126a32326a366
[   10.281824] swap_free: Bad swap file entry 180121eea324b7f6
[   10.282030] swap_free: Bad swap file entry 180121eea324b7f6
[   10.282231] swap_free: Bad swap file entry 18012461a32365ae
[   10.282428] swap_free: Bad swap offset entry 1defef5b5b7e2
[   10.282623] swap_free: Bad swap file entry c0133b3b473f2f1
[   10.282818] swap_free: Bad swap file entry 1000acafac77f332
[   10.283012] swap_free: Bad swap file entry 1801a2e4242777f5
[   10.283202] swap_free: Bad swap file entry 180125a266aee6a4
[   10.283391] swap_free: Bad swap file entry 1c0162a726ab26a4
[   10.283576] swap_free: Bad swap file entry 1800a6a6a5b7f6f7
[   10.283779] swap_free: Bad swap file entry 180125a266aef373
[   10.283960] swap_free: Bad swap file entry 14012ee324b7f6f7
[   10.284135] swap_free: Bad swap file entry 10012aeb6324b7f6
[   10.284301] swap_free: Bad swap file entry 1800ab26a325a363
[   10.284470] swap_free: Bad swap file entry 10012aeb6324b7f6
[   10.285057] stack segment: 0000 [#2] SMP 
[   10.285249] Modules linked in: binfmt_misc ip6table_filter ip6_tables ipt_REJECT nf_conntrack_ipv4 nf_defrag_ipv4 xt_comment xt_multiport xt_conntrack nf_conntrack iptable_filter ip_tables x_tables crc32_pclmul crc32c_intel aesni_intel aes_x86_64 glue_helper lrw vmw_vsock_vmci_transport vsock gf128mul vmw_balloon ppdev evdev ablk_helper cryptd pcspkr serio_raw vmwgfx drm_kms_helper ttm ac processor battery button parport_pc thermal_sys drm parport shpchp vmw_vmci autofs4 ext4 crc16 mbcache jbd2 dm_mod sg sr_mod cdrom sd_mod crc_t10dif crct10dif_generic ata_generic crct10dif_pclmul crct10dif_common psmouse vmxnet3 ata_piix mptspi scsi_transport_spi mptscsih libata i2c_piix4 mptbase scsi_mod i2c_core
[   10.287519] CPU: 2 PID: 717 Comm: gunicorn: worke Tainted: G    B D       3.16.59+ #18
[   10.287874] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 04/05/2016
[   10.288623] task: ffff88007835e090 ti: ffff88006f834000 task.ti: ffff88006f834000
[   10.289024] RIP: 0010:[<ffffffff81184f8c>]  [<ffffffff81184f8c>] free_pages_and_swap_cache+0x5c/0xc0
[   10.289870] RSP: 0018:ffff88006f837c60  EFLAGS: 00010282
[   10.290311] RAX: 000000000000000d RBX: ffff880076d1a010 RCX: 0000000000000000
[   10.290768] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88007fd12140
[   10.291235] RBP: 7265726576696c65 R08: 0000000000000001 R09: 0000000000016ef8
[   10.291702] R10: 0000000000000004 R11: ffffffff8172a2cb R12: ffff880076d1a080
[   10.292179] R13: ffff880076d1a010 R14: 000000000000000e R15: 0000000068637845
[   10.292665] FS:  00007fb4c0ffe700(0000) GS:ffff88007fd00000(0000) knlGS:0000000000000000
[   10.293167] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   10.293687] CR2: 00007f97a8265050 CR3: 000000007ade2000 CR4: 0000000000360770
[   10.294263] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   10.294793] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   10.295316] Stack:
[   10.295839]  ffff880076d1a000 ffff88006f837df8 ffff88006f837dd0 00007fb4bbc00000
[   10.296393]  ffff88006f837dd0 00007fb4bbb9a000 ffffffff8116f05c ffffffffffffffff
[   10.296961]  ffffea000179f040 0000000000000000 ffffffff8117092a ffff8800783cd080
[   10.297531] Call Trace:
[   10.298111]  [<ffffffff8116f05c>] ? tlb_flush_mmu_free+0x2c/0x50
[   10.298694]  [<ffffffff8117092a>] ? unmap_single_vma+0x64a/0x830
[   10.299280]  [<ffffffff81171c6c>] ? unmap_vmas+0x4c/0xa0
[   10.299869]  [<ffffffff8117ad62>] ? exit_mmap+0x92/0x160
[   10.300460]  [<ffffffff81069b4c>] ? mmput+0x5c/0x120
[   10.301060]  [<ffffffff8106f033>] ? do_exit+0x333/0xae0
[   10.301648]  [<ffffffff8151e706>] ? printk+0x4f/0x57
[   10.302226]  [<ffffffff81017697>] ? oops_end+0x97/0xe0
[   10.302786]  [<ffffffff8105b896>] ? __do_page_fault+0x376/0x470
[   10.303333]  [<ffffffff81527f08>] ? page_fault+0x28/0x30
[   10.303863] Code: 00 45 0f 4e f7 45 85 f6 7e 55 41 8d 46 ff 4c 89 eb 4c 8d 24 c5 08 00 00 00 4d 01 ec eb 0a 90 48 83 c3 08 4c 39 e3 74 37 48 8b 2b <48> 8b 45 00 a9 00 00 01 00 74 e9 8b 45 18 85 c0 79 e2 f0 0f ba 
[   10.305611] RIP  [<ffffffff81184f8c>] free_pages_and_swap_cache+0x5c/0xc0
[   10.306580]  RSP <ffff88006f837c60>
[   10.307535] ---[ end trace f863ea854df6c9a6 ]---
[   10.308180] Fixing recursive fault but reboot is needed!
