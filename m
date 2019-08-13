Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04628C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA37420844
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfHMVIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:08:09 -0400
Received: from mail-oi1-f199.google.com ([209.85.167.199]:47607 "EHLO
        mail-oi1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfHMVII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:08:08 -0400
Received: by mail-oi1-f199.google.com with SMTP id g204so400026oif.14
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 14:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mCvcXc2rClVVP29gxTet4gxy92I90eC1AEZNFxdO40I=;
        b=ne5LHuXqJbh8tKpFIouoxVUiiJH8RNaC9+2PDJ4wWGbhUOB6wgB4qJVozL+yS5LcRe
         LmkLoR1UvikcFidkvnWsdjnpS0s9QJ+VCIko0B8t7t6bAmMtQ44kNyOC46ujFLlmPvdI
         dGGlgLoFEb2tS0u0TBWhcyR7wRPFATjDtX804PvtyxL3JAktd2wBMev4+J86ujDrWhpB
         wossyyWBR2P5TTnk0GQfX7RtXNOkDFVl1bVQCKsmHeS94ZHOSjEv43lbxrtwD0jqtPmn
         WR/gR9Kr0/ngX1+MvKocW0E19amhseZt4auJTxfGIhqbHBRr4ty2bQG8/LF5vjV0E2PC
         gXBA==
X-Gm-Message-State: APjAAAUuPVP3R+cFduw1CXoPgis+QsnODD2y6kF/XNTzRTBzoGUoiDTb
        fXf/WNIH1ZWZ9lLzSlUimutTOjon/My+OkkK+ZHBK274Cz/F
X-Google-Smtp-Source: APXvYqz0S9DUOiX+LxngFnA8kSoOw62sD4BX3kqFTwNERIr0M7U4Yn05DRwqD7VJPVXLKUMC221+YhKN9BQwrZ1bQPex4fspFiJP
MIME-Version: 1.0
X-Received: by 2002:a5d:888d:: with SMTP id d13mr2909822ioo.135.1565730486477;
 Tue, 13 Aug 2019 14:08:06 -0700 (PDT)
Date:   Tue, 13 Aug 2019 14:08:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000075fa50059006098c@google.com>
Subject: memory leak in bio_clone_fast
From:   syzbot <syzbot+0265846a0cb9a0547905@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, baijiaju1990@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        rppt@linux.ibm.com, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d45331b0 Linux 5.3-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1651e6d2600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c5e70dcab57c6af
dashboard link: https://syzkaller.appspot.com/bug?extid=0265846a0cb9a0547905
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c9c336600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1766156a600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0265846a0cb9a0547905@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff8881226da6c0 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 15.840s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da600 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 15.840s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da540 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 15.840s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da6c0 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 16.750s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da600 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 16.750s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da540 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 16.750s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da6c0 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 17.650s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da600 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 17.650s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da540 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 17.650s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da6c0 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 18.550s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da600 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 18.550s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da540 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 18.550s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da6c0 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.450s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da600 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.450s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da540 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.450s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da6c0 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.510s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da600 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.510s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da540 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.510s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da6c0 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.560s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da600 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.560s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862

BUG: memory leak
unreferenced object 0xffff8881226da540 (size 192):
   comm "syz-executor332", pid 6977, jiffies 4294941214 (age 19.560s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 f0 bc 28 81 88 ff ff  ...........(....
     01 c8 60 00 02 0b 00 00 00 00 00 00 00 00 00 00  ..`.............
   backtrace:
     [<00000000b06a638e>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000b06a638e>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000b06a638e>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000b06a638e>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<00000000950a289d>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000bfcc27e2>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<00000000cdf95a4a>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<00000000b239bb68>] bio_clone_fast+0x25/0x90 block/bio.c:609
     [<000000005d58c2dc>] bio_split+0x4a/0xd0 block/bio.c:1856
     [<00000000ab943734>] blk_bio_segment_split block/blk-merge.c:250  
[inline]
     [<00000000ab943734>] __blk_queue_split+0x355/0x730 block/blk-merge.c:272
     [<00000000e702c0ac>] blk_mq_make_request+0xb0/0x890 block/blk-mq.c:1943
     [<000000003c89773a>] generic_make_request block/blk-core.c:1052 [inline]
     [<000000003c89773a>] generic_make_request+0xf6/0x4a0  
block/blk-core.c:994
     [<00000000a4dcaf78>] submit_bio+0x5a/0x1e0 block/blk-core.c:1163
     [<000000003e1ce7f8>] __blkdev_direct_IO fs/block_dev.c:459 [inline]
     [<000000003e1ce7f8>] blkdev_direct_IO+0x2b3/0x6d0 fs/block_dev.c:515
     [<0000000087ec76a4>] generic_file_direct_write+0xb0/0x1a0  
mm/filemap.c:3230
     [<00000000ff259b44>] __generic_file_write_iter+0xec/0x230  
mm/filemap.c:3413
     [<00000000223d9b6c>] blkdev_write_iter fs/block_dev.c:2026 [inline]
     [<00000000223d9b6c>] blkdev_write_iter+0xbe/0x160 fs/block_dev.c:2003
     [<000000003c4a5c94>] call_write_iter include/linux/fs.h:1870 [inline]
     [<000000003c4a5c94>] aio_write+0x10b/0x1d0 fs/aio.c:1583
     [<00000000581f0c84>] __io_submit_one fs/aio.c:1815 [inline]
     [<00000000581f0c84>] io_submit_one+0x59b/0xe50 fs/aio.c:1862



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
