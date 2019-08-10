Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122DAC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 13:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5521218A4
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 13:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfHJN6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 09:58:09 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72]:37666 "EHLO
        mail-ot1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfHJN6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 09:58:09 -0400
Received: by mail-ot1-f72.google.com with SMTP id x5so74795999otb.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 06:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=uc3VNp+TewZPyZ3FkDnqWeSl30hYHGj/clkPLdXhPfY=;
        b=MNo+8Nhq8j/ldYeovI5aJLeAHKVv4TCFMuQJMTVgyTYgOkpZWdKcmGgjCUrsoiAJkx
         FHr9lZk0M6ABoHRKzuVQ99RV8bfvSD9nPEiIZzgBWKvyffxirOlO3MEPOi+/sAnLSUIp
         uLvaA44c2nZzdi+uJGsuVdlfIDVDQPtV87MhxTp5yHv7SUDg6tRcXtaoZapzqnWqpCZ0
         doCQCaGa+2lQIW+tM1tNmrwlbgRMc77/awrPH3NngbQKrlltKxYrW2Wr39kOK7Xy1Xrs
         jOQmNR9Dwws9649xtZs5aNaKkP3kFhBfXi/xJWsQin1I4Cxd3snWJ3t0QU1yusohKvEn
         pgpQ==
X-Gm-Message-State: APjAAAVax6pNZL82y83KQAaJOVxzuVM1gD8QafGoccSDkHcinMo+BDO1
        de3MlBdaXheqnTdpWWFEA3c163E1cWBZ8ypcKYj+w3lkrRp3
X-Google-Smtp-Source: APXvYqyGCl4kLh2+OaYOuFKclw2UGl4pIYQBsbqEh0+Y9y58s40+a6DTfdIyqtv7lJMA+V6l7OTbmZ5eLRe78gLsQzExM3k/RQdf
MIME-Version: 1.0
X-Received: by 2002:a6b:3bc9:: with SMTP id i192mr14555228ioa.33.1565445486039;
 Sat, 10 Aug 2019 06:58:06 -0700 (PDT)
Date:   Sat, 10 Aug 2019 06:58:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c9515058fc3ae44@google.com>
Subject: memory leak in blkdev_direct_IO
From:   syzbot <syzbot+c6eabdef44048c808a74@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, baijiaju1990@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        rientjes@google.com, rppt@linux.ibm.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    0eb0ce0a Merge tag 'spi-fix-v5.3-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10cc073a600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=39113f5c48aea971
dashboard link: https://syzkaller.appspot.com/bug?extid=c6eabdef44048c808a74
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14561df6600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ee029a600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c6eabdef44048c808a74@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888110e63300 (size 256):
   comm "syz-executor817", pid 7066, jiffies 4294944591 (age 29.380s)
   hex dump (first 32 bytes):
     80 77 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .wM.............
     02 00 00 00 1b 51 49 ad 00 00 00 00 00 00 00 00  .....QI.........
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110c60f00 (size 256):
   comm "syz-executor817", pid 7076, jiffies 4294944620 (age 29.090s)
   hex dump (first 32 bytes):
     40 7b 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  @{M.............
     02 00 00 00 fb ff ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888111d24800 (size 256):
   comm "syz-executor817", pid 7084, jiffies 4294944640 (age 28.900s)
   hex dump (first 32 bytes):
     c0 73 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .sM.............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63200 (size 256):
   comm "syz-executor817", pid 7085, jiffies 4294944644 (age 28.860s)
   hex dump (first 32 bytes):
     80 4a 8c 10 81 88 ff ff 00 00 00 01 00 00 00 00  .J..............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63300 (size 256):
   comm "syz-executor817", pid 7066, jiffies 4294944591 (age 29.460s)
   hex dump (first 32 bytes):
     80 77 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .wM.............
     02 00 00 00 1b 51 49 ad 00 00 00 00 00 00 00 00  .....QI.........
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110c60f00 (size 256):
   comm "syz-executor817", pid 7076, jiffies 4294944620 (age 29.170s)
   hex dump (first 32 bytes):
     40 7b 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  @{M.............
     02 00 00 00 fb ff ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888111d24800 (size 256):
   comm "syz-executor817", pid 7084, jiffies 4294944640 (age 28.970s)
   hex dump (first 32 bytes):
     c0 73 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .sM.............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63200 (size 256):
   comm "syz-executor817", pid 7085, jiffies 4294944644 (age 28.930s)
   hex dump (first 32 bytes):
     80 4a 8c 10 81 88 ff ff 00 00 00 01 00 00 00 00  .J..............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63300 (size 256):
   comm "syz-executor817", pid 7066, jiffies 4294944591 (age 29.530s)
   hex dump (first 32 bytes):
     80 77 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .wM.............
     02 00 00 00 1b 51 49 ad 00 00 00 00 00 00 00 00  .....QI.........
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110c60f00 (size 256):
   comm "syz-executor817", pid 7076, jiffies 4294944620 (age 29.240s)
   hex dump (first 32 bytes):
     40 7b 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  @{M.............
     02 00 00 00 fb ff ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888111d24800 (size 256):
   comm "syz-executor817", pid 7084, jiffies 4294944640 (age 29.040s)
   hex dump (first 32 bytes):
     c0 73 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .sM.............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63200 (size 256):
   comm "syz-executor817", pid 7085, jiffies 4294944644 (age 29.000s)
   hex dump (first 32 bytes):
     80 4a 8c 10 81 88 ff ff 00 00 00 01 00 00 00 00  .J..............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63300 (size 256):
   comm "syz-executor817", pid 7066, jiffies 4294944591 (age 29.600s)
   hex dump (first 32 bytes):
     80 77 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .wM.............
     02 00 00 00 1b 51 49 ad 00 00 00 00 00 00 00 00  .....QI.........
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110c60f00 (size 256):
   comm "syz-executor817", pid 7076, jiffies 4294944620 (age 29.310s)
   hex dump (first 32 bytes):
     40 7b 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  @{M.............
     02 00 00 00 fb ff ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888111d24800 (size 256):
   comm "syz-executor817", pid 7084, jiffies 4294944640 (age 29.110s)
   hex dump (first 32 bytes):
     c0 73 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .sM.............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63200 (size 256):
   comm "syz-executor817", pid 7085, jiffies 4294944644 (age 29.070s)
   hex dump (first 32 bytes):
     80 4a 8c 10 81 88 ff ff 00 00 00 01 00 00 00 00  .J..............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63300 (size 256):
   comm "syz-executor817", pid 7066, jiffies 4294944591 (age 29.670s)
   hex dump (first 32 bytes):
     80 77 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .wM.............
     02 00 00 00 1b 51 49 ad 00 00 00 00 00 00 00 00  .....QI.........
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110c60f00 (size 256):
   comm "syz-executor817", pid 7076, jiffies 4294944620 (age 29.380s)
   hex dump (first 32 bytes):
     40 7b 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  @{M.............
     02 00 00 00 fb ff ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888111d24800 (size 256):
   comm "syz-executor817", pid 7084, jiffies 4294944640 (age 29.180s)
   hex dump (first 32 bytes):
     c0 73 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .sM.............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63200 (size 256):
   comm "syz-executor817", pid 7085, jiffies 4294944644 (age 29.140s)
   hex dump (first 32 bytes):
     80 4a 8c 10 81 88 ff ff 00 00 00 01 00 00 00 00  .J..............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63300 (size 256):
   comm "syz-executor817", pid 7066, jiffies 4294944591 (age 29.740s)
   hex dump (first 32 bytes):
     80 77 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .wM.............
     02 00 00 00 1b 51 49 ad 00 00 00 00 00 00 00 00  .....QI.........
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110c60f00 (size 256):
   comm "syz-executor817", pid 7076, jiffies 4294944620 (age 29.450s)
   hex dump (first 32 bytes):
     40 7b 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  @{M.............
     02 00 00 00 fb ff ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888111d24800 (size 256):
   comm "syz-executor817", pid 7084, jiffies 4294944640 (age 29.260s)
   hex dump (first 32 bytes):
     c0 73 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .sM.............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63200 (size 256):
   comm "syz-executor817", pid 7085, jiffies 4294944644 (age 29.220s)
   hex dump (first 32 bytes):
     80 4a 8c 10 81 88 ff ff 00 00 00 01 00 00 00 00  .J..............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63300 (size 256):
   comm "syz-executor817", pid 7066, jiffies 4294944591 (age 29.820s)
   hex dump (first 32 bytes):
     80 77 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .wM.............
     02 00 00 00 1b 51 49 ad 00 00 00 00 00 00 00 00  .....QI.........
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110c60f00 (size 256):
   comm "syz-executor817", pid 7076, jiffies 4294944620 (age 29.530s)
   hex dump (first 32 bytes):
     40 7b 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  @{M.............
     02 00 00 00 fb ff ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888111d24800 (size 256):
   comm "syz-executor817", pid 7084, jiffies 4294944640 (age 29.330s)
   hex dump (first 32 bytes):
     c0 73 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .sM.............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63200 (size 256):
   comm "syz-executor817", pid 7085, jiffies 4294944644 (age 29.290s)
   hex dump (first 32 bytes):
     80 4a 8c 10 81 88 ff ff 00 00 00 01 00 00 00 00  .J..............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63300 (size 256):
   comm "syz-executor817", pid 7066, jiffies 4294944591 (age 29.890s)
   hex dump (first 32 bytes):
     80 77 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .wM.............
     02 00 00 00 1b 51 49 ad 00 00 00 00 00 00 00 00  .....QI.........
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110c60f00 (size 256):
   comm "syz-executor817", pid 7076, jiffies 4294944620 (age 29.600s)
   hex dump (first 32 bytes):
     40 7b 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  @{M.............
     02 00 00 00 fb ff ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888111d24800 (size 256):
   comm "syz-executor817", pid 7084, jiffies 4294944640 (age 29.400s)
   hex dump (first 32 bytes):
     c0 73 4d 15 81 88 ff ff 00 00 00 01 00 00 00 00  .sM.............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff888110e63200 (size 256):
   comm "syz-executor817", pid 7085, jiffies 4294944644 (age 29.360s)
   hex dump (first 32 bytes):
     80 4a 8c 10 81 88 ff ff 00 00 00 01 00 00 00 00  .J..............
     02 00 00 00 83 88 ff ff 00 00 00 00 00 00 00 00  ................
   backtrace:
     [<00000000206002d6>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<00000000206002d6>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<00000000206002d6>] slab_alloc mm/slab.c:3319 [inline]
     [<00000000206002d6>] kmem_cache_alloc+0x13f/0x2c0 mm/slab.c:3483
     [<0000000057b30867>] mempool_alloc_slab+0x1e/0x30 mm/mempool.c:513
     [<00000000d1a36e4f>] mempool_alloc+0x64/0x1b0 mm/mempool.c:393
     [<000000003b11a2ab>] bio_alloc_bioset+0x180/0x2c0 block/bio.c:477
     [<0000000027ae1ad1>] __blkdev_direct_IO fs/block_dev.c:363 [inline]
     [<0000000027ae1ad1>] blkdev_direct_IO+0x148/0x730 fs/block_dev.c:519
     [<000000002a9323a7>] generic_file_read_iter+0xe9/0xff0 mm/filemap.c:2323
     [<000000006b5d1606>] blkdev_read_iter+0x55/0x80 fs/block_dev.c:2047
     [<000000006a628b40>] call_read_iter include/linux/fs.h:1864 [inline]
     [<000000006a628b40>] aio_read+0xe1/0x180 fs/aio.c:1543
     [<000000002a2e309e>] __io_submit_one fs/aio.c:1813 [inline]
     [<000000002a2e309e>] io_submit_one+0x5bb/0xe50 fs/aio.c:1862
     [<00000000104bc919>] __do_sys_io_submit fs/aio.c:1921 [inline]
     [<00000000104bc919>] __se_sys_io_submit fs/aio.c:1891 [inline]
     [<00000000104bc919>] __x64_sys_io_submit+0xac/0x1e0 fs/aio.c:1891
     [<0000000012cff7e6>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<00000000ee90ac70>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
