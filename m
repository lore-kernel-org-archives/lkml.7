Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EB1CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080BF21872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571808295;
	bh=57AjTpVsEK2wLpxNbMuuV5YOyVG4VhHtsDkkObll51w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kC8b7Ro7sm2TTPYLLirWCa8v1PohViar6GXQqbjUAFLUZoww7neO1VbD2y4rw6lHo
	 WwsArD2SvvZxRGVrTZrL8NGsbFKcS1eLFW3jUjRanH3Wd/9x7WzGKgmaFCKbDYoj13
	 igH90tHt/lgg5aUar2okqLq+cYM1nkLvZmvVLedQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbfJWFYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:24:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728697AbfJWFYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:24:50 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5B422084C;
        Wed, 23 Oct 2019 05:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571808289;
        bh=57AjTpVsEK2wLpxNbMuuV5YOyVG4VhHtsDkkObll51w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UICWj69EvHL7qJROQbwFyC32PbAmLlgn0g+8aYY+MduRc6bkLxGcpQ9VEEN64ME/V
         3mpJqMz+tdMs+l6+y3Z0zIwGbzn7twstjf6NJbWWfaa7KqdIVwTO+r9hH+iaRLB/oW
         //F6PF7luiCJAwzzyjAtkvYyLVM3aPHkwggU4WCk=
Date:   Tue, 22 Oct 2019 22:24:47 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/2] f2fs: support data compression
Message-ID: <20191023052447.GD361298@sol.localdomain>
Mail-Followup-To: Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20191022171602.93637-1-jaegeuk@kernel.org>
 <20191022171602.93637-2-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022171602.93637-2-jaegeuk@kernel.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:16:02AM -0700, Jaegeuk Kim wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> This patch tries to support compression in f2fs.
> 
> - New term named cluster is defined as basic unit of compression, file can
> be divided into multiple clusters logically. One cluster includes 4 << n
> (n >= 0) logical pages, compression size is also cluster size, each of
> cluster can be compressed or not.
> 
> - In cluster metadata layout, one special flag is used to indicate cluster
> is compressed one or normal one, for compressed cluster, following metadata
> maps cluster to [1, 4 << n - 1] physical blocks, in where f2fs stores
> data including compress header and compressed data.
> 
> - In order to eliminate write amplification during overwrite, F2FS only
> support compression on write-once file, data can be compressed only when
> all logical blocks in file are valid and cluster compress ratio is lower
> than specified threshold.
> 
> - To enable compression on regular inode, there are three ways:
> * chattr +c file
> * chattr +c dir; touch dir/file
> * mount w/ -o compress_extension=ext; touch file.ext
> 
> Compress metadata layout:
>                              [Dnode Structure]
>              +-----------------------------------------------+
>              | cluster 1 | cluster 2 | ......... | cluster N |
>              +-----------------------------------------------+
>              .           .                       .           .
>        .                       .                .                      .
>   .         Compressed Cluster       .        .        Normal Cluster            .
> +----------+---------+---------+---------+  +---------+---------+---------+---------+
> |compr flag| block 1 | block 2 | block 3 |  | block 1 | block 2 | block 3 | block 4 |
> +----------+---------+---------+---------+  +---------+---------+---------+---------+
>            .                             .
>          .                                           .
>        .                                                           .
>       +-------------+-------------+----------+----------------------------+
>       | data length | data chksum | reserved |      compressed data       |
>       +-------------+-------------+----------+----------------------------+
> 
> Changelog:
> 
> 20190326:
> - fix error handling of read_end_io().
> - remove unneeded comments in f2fs_encrypt_one_page().
> 
> 20190327:
> - fix wrong use of f2fs_cluster_is_full() in f2fs_mpage_readpages().
> - don't jump into loop directly to avoid uninitialized variables.
> - add TODO tag in error path of f2fs_write_cache_pages().
> 
> 20190328:
> - fix wrong merge condition in f2fs_read_multi_pages().
> - check compressed file in f2fs_post_read_required().
> 
> 20190401
> - allow overwrite on non-compressed cluster.
> - check cluster meta before writing compressed data.
> 
> 20190402
> - don't preallocate blocks for compressed file.
> 
> - add lz4 compress algorithm
> - process multiple post read works in one workqueue
>   Now f2fs supports processing post read work in multiple workqueue,
>   it shows low performance due to schedule overhead of multiple
>   workqueue executing orderly.
> 
> - compress: support buffered overwrite
> C: compress cluster flag
> V: valid block address
> N: NEW_ADDR
> 
> One cluster contain 4 blocks
> 
>  before overwrite   after overwrite
> 
> - VVVV		->	CVNN
> - CVNN		->	VVVV
> 
> - CVNN		->	CVNN
> - CVNN		->	CVVV
> 
> - CVVV		->	CVNN
> - CVVV		->	CVVV
> 
> [Jaegeuk Kim]
> - add tracepoint for f2fs_{,de}compress_pages()
> - fix many bugs and add some compression stats
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

How was this tested?  Shouldn't there a mount option analogous to
test_dummy_encryption that causes all files to be auto-compressed, so that a
full run of xfstests can be done with compression?  I see "compress_extension",
but apparently it's only for a file extension?  Also, since reads can involve
any combination of decryption, compression, and verity, it's important to test
as many combinations as possible, including all at once.  Has that been done?

I also tried running the fs-verity xfstests on this with
'kvm-xfstests -c f2fs -g verity', but the kernel immediately crashes:

BUG: kernel NULL pointer dereference, address: 0000000000000182
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0 
Oops: 0000 [#1] SMP
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.4.0-rc1-00119-g60f351f4c50f #3
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20191013_105130-anatol 04/01/2014
RIP: 0010:__queue_work+0x3e/0x5f0 kernel/workqueue.c:1409
Code: d4 53 48 83 ec 18 89 7d d4 8b 3d c1 bf 2a 01 85 ff 74 17 65 48 8b 04 25 80 5d 01 00 8b b0 0c 07 00 00 85 f6 0f 84 1
RSP: 0018:ffffc900000a8db0 EFLAGS: 00010046
RAX: ffff88807d94e340 RBX: 0000000000000246 RCX: 0000000000000000
RDX: ffff88807d9e0be8 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc900000a8df0 R08: 0000000000000000 R09: 0000000000000001
R10: ffff888075f2bc68 R11: 0000000000000000 R12: ffff88807d9e0be8
R13: 0000000000000000 R14: 0000000000000030 R15: ffff88807c2c6780
FS:  0000000000000000(0000) GS:ffff88807fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000182 CR3: 00000000757e3000 CR4: 00000000003406e0
Call Trace:
 <IRQ>
 queue_work_on+0x67/0x70 kernel/workqueue.c:1518
 queue_work include/linux/workqueue.h:494 [inline]
 f2fs_enqueue_post_read_work fs/f2fs/data.c:166 [inline]
 bio_post_read_processing fs/f2fs/data.c:173 [inline]
 f2fs_read_end_io+0xcb/0xe0 fs/f2fs/data.c:195
 bio_endio+0xa4/0x1a0 block/bio.c:1818
 req_bio_endio block/blk-core.c:242 [inline]
 blk_update_request+0xf6/0x310 block/blk-core.c:1462
 blk_mq_end_request+0x1c/0x130 block/blk-mq.c:568
 virtblk_request_done+0x32/0x80 drivers/block/virtio_blk.c:226
 blk_done_softirq+0x98/0xc0 block/blk-softirq.c:37
 __do_softirq+0xc1/0x40d kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0xb3/0xc0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 do_IRQ+0x5b/0x110 arch/x86/kernel/irq.c:263
 common_interrupt+0xf/0xf arch/x86/entry/entry_64.S:607
 </IRQ>
RIP: 0010:native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
RIP: 0010:arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
RIP: 0010:default_idle+0x29/0x160 arch/x86/kernel/process.c:580
Code: 90 55 48 89 e5 41 55 41 54 65 44 8b 25 70 64 76 7e 53 0f 1f 44 00 00 e8 95 13 88 ff e9 07 00 00 00 0f 00 2d 8b c0 b
RSP: 0018:ffffc90000073e78 EFLAGS: 00000202 ORIG_RAX: ffffffffffffffdc
RAX: ffff88807d94e340 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000046 RSI: 0000000000000006 RDI: ffff88807d94e340
RBP: ffffc90000073e90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88807d94e340 R14: 0000000000000000 R15: 0000000000000000
 arch_cpu_idle+0xa/0x10 arch/x86/kernel/process.c:571
 default_idle_call+0x1e/0x30 kernel/sched/idle.c:94
 cpuidle_idle_call kernel/sched/idle.c:154 [inline]
 do_idle+0x1e4/0x210 kernel/sched/idle.c:263
 cpu_startup_entry+0x1b/0x20 kernel/sched/idle.c:355
 start_secondary+0x151/0x1a0 arch/x86/kernel/smpboot.c:264
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:241
CR2: 0000000000000182
---[ end trace 86328090a3179142 ]---
RIP: 0010:__queue_work+0x3e/0x5f0 kernel/workqueue.c:1409
Code: d4 53 48 83 ec 18 89 7d d4 8b 3d c1 bf 2a 01 85 ff 74 17 65 48 8b 04 25 80 5d 01 00 8b b0 0c 07 00 00 85 f6 0f 84 1
RSP: 0018:ffffc900000a8db0 EFLAGS: 00010046
RAX: ffff88807d94e340 RBX: 0000000000000246 RCX: 0000000000000000
RDX: ffff88807d9e0be8 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffc900000a8df0 R08: 0000000000000000 R09: 0000000000000001
R10: ffff888075f2bc68 R11: 0000000000000000 R12: ffff88807d9e0be8
R13: 0000000000000000 R14: 0000000000000030 R15: ffff88807c2c6780
FS:  0000000000000000(0000) GS:ffff88807fd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000182 CR3: 00000000757e3000 CR4: 00000000003406e0
Kernel panic - not syncing: Fatal exception in interrupt
Kernel Offset: disabled
Rebooting in 5 seconds..
