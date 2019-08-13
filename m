Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FB7C32753
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61632067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565732035;
	bh=J48GpEZ8QRYVyddN1lygnXIUs4K1LE74CbpmtvB9zhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=d1kWDYshZdgQZgc9Dl4jOantvsBD8Zgqdi05mOBbBXyy2D6fCndBQmb5kOk/TsoMN
	 TSgxHq5feVb9GGF0Gpo7v0OYEYzRgKEO8U/JdduqYUOoNEcWDdvGVraglvu8CVz/9z
	 P0bJpe9XKiMEK2TQ97yKdWI1bDocQPAVBsavhdhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfHMVdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:33:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfHMVdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:33:53 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19B82206C2;
        Tue, 13 Aug 2019 21:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565732029;
        bh=J48GpEZ8QRYVyddN1lygnXIUs4K1LE74CbpmtvB9zhQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0UUoYquO0iRUw7FHqpFyYUZ5prCH/2I5CN5A4PkqhpOb9keOdAPh9jhq/BoQ6d3HX
         SulblEiWKMbbVUogjiKPmkmOJOELEKSPKc4rTfAHUp4VQA6dF25MbIg5v8nSgmG39o
         o4hI9gADLIPQc19ZrXbdO733tE54gzVFNhecJloM=
Date:   Tue, 13 Aug 2019 14:33:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+0265846a0cb9a0547905@syzkaller.appspotmail.com>
Cc:     baijiaju1990@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@suse.com, rppt@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: memory leak in bio_clone_fast
Message-Id: <20190813143348.faeb28c7f59eefc52875eb8f@linux-foundation.org>
In-Reply-To: <00000000000075fa50059006098c@google.com>
References: <00000000000075fa50059006098c@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc's added)

On Tue, 13 Aug 2019 14:08:06 -0700 syzbot <syzbot+0265846a0cb9a0547905@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    d45331b0 Linux 5.3-rc4
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1651e6d2600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6c5e70dcab57c6af
> dashboard link: https://syzkaller.appspot.com/bug?extid=0265846a0cb9a0547905
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c9c336600000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1766156a600000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+0265846a0cb9a0547905@syzkaller.appspotmail.com
> 
> executing program
> executing program
> executing program
> executing program
> BUG: memory leak
> unreferenced object 0xffff8881226da6c0 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 15.840s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da600 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 15.840s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da540 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 15.840s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da6c0 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 16.750s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da600 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 16.750s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da540 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 16.750s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da6c0 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 17.650s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da600 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 17.650s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da540 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 17.650s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da6c0 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 18.550s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da600 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 18.550s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da540 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 18.550s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da6c0 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.450s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da600 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.450s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da540 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.450s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da6c0 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.510s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da600 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.510s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da540 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.510s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da6c0 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.560s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da600 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.560s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> BUG: memory leak
> unreferenced object 0xffff8881226da540 (size 192):
>    comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.560s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
>      01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
>    backtrace:
>      [<00000000b06a638e>] kmemleak_alloc_recursive  
> include/linux/kmemleak.h:43 [inline]
>      [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
>      [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
>      [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
>      [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
>      [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
>      [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
>      [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
>      [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
>      [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
> [inline]
>      [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
>      [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
>      [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
>      [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
> block/blk-core.c:994
>      [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
>      [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
>      [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
>      [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
> mm/filemap.c:3230
>      [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
> mm/filemap.c:3413
>      [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
>      [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
>      [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
>      [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
>      [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
>      [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862
> 
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches
