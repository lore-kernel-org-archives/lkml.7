Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89127C4CECE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680D020882
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 08:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfIRIFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 04:05:09 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56691 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfIRIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 04:05:09 -0400
Received: by mail-io1-f69.google.com with SMTP id n8so9873198ioh.23
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 01:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ubJJB30ecHhfDnwFouG6Yr0iuss4T3eoAZ0lI9nGqK0=;
        b=BODZCb4V7x8i7+3Pgsi817irIErZENj1Wq1pYuLEHGaLRkzn7Z3n6Oen69+ACKgYtq
         zjks8P8rcUrvnvD/28FR+h85CIx7hHpFDd41lRSFS/nf5+oWmnEhBbiQ868/9ymwGI5y
         asDXmgbAmaxqjS7SJnF7oGRT05sNarkOHm0OmJJhMWRh9BeoPr2bvv6+cHEX00WUHV8H
         2D/+Jjp/KhchaH/E2PBIsUmP5UxDjZYFIiq6aNuYpjnIn7+Ur8u6Irz3R+EWbVbrNmEP
         z1sjgBvvj+M9luTkM97RjjR1m7zpKzcCiflL6E340HtmnCqz0NmZdiniulY2wCXinFVx
         zAdw==
X-Gm-Message-State: APjAAAXUEXbE08iG3wdBOtw0KDgY/Ox+0QTii3KVcRqtGSxAktT5i0+1
        49sK0DH8xKjdo6fm+a5tM9G3YifyHuEk2PI7oqIefeJmAzUL
X-Google-Smtp-Source: APXvYqzpxHtMg+BUgJCSyFiebeV4rxOlfbcNLIE/bfKzlleXz/ZHoVr1hhiQ7d0r8V22inRFPnBNOnIL4yNrGD5IuSYUaSqRjI3S
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2596:: with SMTP id p22mr3691745ioo.251.1568793906918;
 Wed, 18 Sep 2019 01:05:06 -0700 (PDT)
Date:   Wed, 18 Sep 2019 01:05:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c3e590592cf4b7f@google.com>
Subject: KASAN: use-after-free Read in key_put
From:   syzbot <syzbot+f3745a1dc2a5eb5040ef@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jmorris@namei.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a7f89616 Merge branch 'for-5.3-fixes' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=175eae11600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=861a6f31647968de
dashboard link: https://syzkaller.appspot.com/bug?extid=f3745a1dc2a5eb5040ef
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f3745a1dc2a5eb5040ef@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in atomic_read  
include/asm-generic/atomic-instrumented.h:26 [inline]
BUG: KASAN: use-after-free in refcount_sub_and_test_checked+0x87/0x200  
lib/refcount.c:182
Read of size 4 at addr ffff88805b89fc80 by task kworker/1:1/23

CPU: 1 PID: 23 Comm: kworker/1:1 Not tainted 5.3.0-rc8+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events key_garbage_collector
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0xd4/0x306 mm/kasan/report.c:351
  __kasan_report.cold+0x1b/0x36 mm/kasan/report.c:482
  kasan_report+0x12/0x17 mm/kasan/common.c:618
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  __kasan_check_read+0x11/0x20 mm/kasan/common.c:92
  atomic_read include/asm-generic/atomic-instrumented.h:26 [inline]
  refcount_sub_and_test_checked+0x87/0x200 lib/refcount.c:182
  refcount_dec_and_test_checked+0x1b/0x20 lib/refcount.c:220
  key_put+0x20/0x90 security/keys/key.c:646
  keyring_free_object+0x19/0x20 security/keys/keyring.c:389
  assoc_array_destroy_subtree.part.0+0x1c5/0x4b0 lib/assoc_array.c:393
  assoc_array_destroy_subtree lib/assoc_array.c:354 [inline]
  assoc_array_destroy+0x43/0x90 lib/assoc_array.c:444
  keyring_destroy+0x259/0x2f0 security/keys/keyring.c:431
  key_gc_unused_keys.constprop.0+0x313/0x5b0 security/keys/gc.c:136
  key_garbage_collector+0x3f3/0x940 security/keys/gc.c:292
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 28788:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_kmalloc mm/kasan/common.c:493 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:466
  kasan_slab_alloc+0xf/0x20 mm/kasan/common.c:501
  slab_post_alloc_hook mm/slab.h:520 [inline]
  slab_alloc mm/slab.c:3319 [inline]
  kmem_cache_alloc+0x121/0x710 mm/slab.c:3483
  kmem_cache_zalloc include/linux/slab.h:738 [inline]
  key_alloc+0x426/0x1110 security/keys/key.c:276
  key_create_or_update+0x652/0xbe0 security/keys/key.c:924
  __do_sys_add_key security/keys/keyctl.c:132 [inline]
  __se_sys_add_key security/keys/keyctl.c:72 [inline]
  __x64_sys_add_key+0x2bd/0x4f0 security/keys/keyctl.c:72
  do_syscall_64+0xfd/0x6a0 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 10344:
  save_stack+0x23/0x90 mm/kasan/common.c:69
  set_track mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:455
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:463
  __cache_free mm/slab.c:3425 [inline]
  kmem_cache_free+0x86/0x320 mm/slab.c:3693
  key_gc_unused_keys.constprop.0+0x192/0x5b0 security/keys/gc.c:157
  key_garbage_collector+0x3f3/0x940 security/keys/gc.c:292
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88805b89fc80
  which belongs to the cache key_jar of size 304
The buggy address is located 0 bytes inside of
  304-byte region [ffff88805b89fc80, ffff88805b89fdb0)
The buggy address belongs to the page:
page:ffffea00016e27c0 refcount:1 mapcount:0 mapping:ffff88821bc461c0  
index:0x0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00025c63c8 ffffea00023378c8 ffff88821bc461c0
raw: 0000000000000000 ffff88805b89f080 000000010000000a 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88805b89fb80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88805b89fc00: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
> ffff88805b89fc80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                    ^
  ffff88805b89fd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88805b89fd80: fb fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
