Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02BAC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F3A21951
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 15:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387674AbfGXPqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 11:46:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41706 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfGXPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 11:46:06 -0400
Received: by mail-io1-f71.google.com with SMTP id x17so51099417iog.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 08:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gBxbRh6nlrBNpWP3ExOiafKZxK2mH6DReoxncqT8HEc=;
        b=DOKcYstqNlmMfM38rhMzHd7s94T+wBCveRtB3IWdbP4BxjFUqYeTnM5l2l4szYkdgZ
         gPTzktb151XZICFYZ7Io2U9QzprmFzTBoVKQw+XjGngxdFIBSXhIInLMHXZ49WHNO5Iw
         rQgAaOH+fV+A9uTS9racsUnJZEyMu2IHCxLLK6daezrJjZvEf5RlGQ+tjKr4NrKEWTyg
         UN6szZtjtTsUVv6xZfx1vT7y8bL9xON9HwkIc1V9f08unXELvmIh/T34RhKKs5ULicUv
         HLCcvWeridfYYrq6D2ZfybBwl9HFE7O65aK1GKqxDY0e1/hzAP4DH3QQVnaKoozE+3/u
         Po+Q==
X-Gm-Message-State: APjAAAUTWiuYu3yr4IlNnewTBtQYvCMhoAeSvbesHwMikAVr0EmCXz2P
        iiFbxkL5lZrgEnmqHim80aJCVsi03gcX2vyfrd+R1Qf/32mj
X-Google-Smtp-Source: APXvYqxp2+T2DzTNfWYH2VMXXMkYl0SM6vAOOaHPL9Jzmf+FjmswkWfYBl2xELojIfx7Nr+4mY5Z4Oe1ogNCLNzthnScyU+0l5Ev
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2183:: with SMTP id b3mr65164579iob.249.1563983165490;
 Wed, 24 Jul 2019 08:46:05 -0700 (PDT)
Date:   Wed, 24 Jul 2019 08:46:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000038ef6058e6f3592@google.com>
Subject: KASAN: use-after-free Read in keyring_compare_object
From:   syzbot <syzbot+9a02c5074e2307825994@syzkaller.appspotmail.com>
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

HEAD commit:    abdfd52a Merge tag 'armsoc-defconfig' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11be4894600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8e53b1e149c0183
dashboard link: https://syzkaller.appspot.com/bug?extid=9a02c5074e2307825994
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9a02c5074e2307825994@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in keyring_compare_object+0x1cb/0x220  
/security/keys/keyring.c:314
Read of size 8 at addr ffff88806b52f130 by task syz-executor.1/11908

CPU: 1 PID: 11908 Comm: syz-executor.1 Not tainted 5.2.0+ #64
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack /lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 /lib/dump_stack.c:113
  print_address_description.cold+0xd4/0x306 /mm/kasan/report.c:351
  __kasan_report.cold+0x1b/0x36 /mm/kasan/report.c:482
  kasan_report+0x12/0x17 /mm/kasan/common.c:612
  __asan_report_load8_noabort+0x14/0x20 /mm/kasan/generic_report.c:132
  keyring_compare_object+0x1cb/0x220 /security/keys/keyring.c:314
  assoc_array_find+0x14b/0x1f0 /lib/assoc_array.c:331
  search_keyring /security/keys/keyring.c:655 [inline]
  search_nested_keyrings+0xb15/0xea0 /security/keys/keyring.c:722
  keyring_search_rcu+0x1b4/0x290 /security/keys/keyring.c:926
  search_cred_keyrings_rcu+0x17d/0x2e0 /security/keys/process_keys.c:480
  search_process_keyrings_rcu+0x1d/0x320 /security/keys/process_keys.c:544
  request_key_and_link+0x264/0x12b0 /security/keys/request_key.c:602
  __do_sys_request_key /security/keys/keyctl.c:223 [inline]
  __se_sys_request_key /security/keys/keyctl.c:168 [inline]
  __ia32_sys_request_key+0x288/0x430 /security/keys/keyctl.c:168
  do_syscall_32_irqs_on /arch/x86/entry/common.c:332 [inline]
  do_fast_syscall_32+0x27b/0xdb3 /arch/x86/entry/common.c:403
  entry_SYSENTER_compat+0x70/0x7f /arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f309c9
Code: d3 83 c4 10 5b 5e 5d c3 ba 80 96 98 00 eb a9 8b 04 24 c3 8b 34 24 c3  
8b 3c 24 c3 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5d2c0cc EFLAGS: 00000296 ORIG_RAX: 000000000000011f
RAX: ffffffffffffffda RBX: 0000000020000000 RCX: 00000000200001c0
RDX: 0000000020000200 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 20965:
  save_stack+0x23/0x90 /mm/kasan/common.c:69
  set_track /mm/kasan/common.c:77 [inline]
  __kasan_kmalloc /mm/kasan/common.c:487 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 /mm/kasan/common.c:460
  kasan_slab_alloc+0xf/0x20 /mm/kasan/common.c:495
  slab_post_alloc_hook /mm/slab.h:520 [inline]
  slab_alloc /mm/slab.c:3319 [inline]
  kmem_cache_alloc+0x121/0x710 /mm/slab.c:3483
  kmem_cache_zalloc /./include/linux/slab.h:738 [inline]
  key_alloc+0x426/0x1110 /security/keys/key.c:276
  key_create_or_update+0x651/0xbe0 /security/keys/key.c:924
  __do_sys_add_key /security/keys/keyctl.c:132 [inline]
  __se_sys_add_key /security/keys/keyctl.c:72 [inline]
  __ia32_sys_add_key+0x2c2/0x4f0 /security/keys/keyctl.c:72
  do_syscall_32_irqs_on /arch/x86/entry/common.c:332 [inline]
  do_fast_syscall_32+0x27b/0xdb3 /arch/x86/entry/common.c:403
  entry_SYSENTER_compat+0x70/0x7f /arch/x86/entry/entry_64_compat.S:139

Freed by task 2951:
  save_stack+0x23/0x90 /mm/kasan/common.c:69
  set_track /mm/kasan/common.c:77 [inline]
  __kasan_slab_free+0x102/0x150 /mm/kasan/common.c:449
  kasan_slab_free+0xe/0x10 /mm/kasan/common.c:457
  __cache_free /mm/slab.c:3425 [inline]
  kmem_cache_free+0x86/0x320 /mm/slab.c:3693
  key_gc_unused_keys.constprop.0+0x192/0x5b0 /security/keys/gc.c:157
  key_garbage_collector+0x3f3/0x940 /security/keys/gc.c:292
  process_one_work+0x9af/0x1740 /kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 /kernel/workqueue.c:2415
  kthread+0x361/0x430 /kernel/kthread.c:255
  ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88806b52f040
  which belongs to the cache key_jar of size 304
The buggy address is located 240 bytes inside of
  304-byte region [ffff88806b52f040, ffff88806b52f170)
The buggy address belongs to the page:
page:ffffea0001ad4bc0 refcount:1 mapcount:0 mapping:ffff88821bc461c0  
index:0xffff88806b52f7c0
flags: 0x1fffc0000000200(slab)
raw: 01fffc0000000200 ffffea00019b3648 ffffea0001a834c8 ffff88821bc461c0
raw: ffff88806b52f7c0 ffff88806b52f040 0000000100000005 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88806b52f000: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
  ffff88806b52f080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff88806b52f100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc
                                      ^
  ffff88806b52f180: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
  ffff88806b52f200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
