Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1EAECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6A3218DE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394411AbfJQBmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:42:11 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:56509 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfJQBmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:42:11 -0400
Received: by mail-io1-f69.google.com with SMTP id a22so833047ioq.23
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 18:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=c+/W7PtNRLYMAumQPSj2+lTREnQ1B5FgENo3ueNmxr0=;
        b=VmQArxzdz9dv5yvpwjLqZk1NasFvz3vqovJ2HUuPjcfun/Xv5eCEcxcyHLUr0dhW/o
         GjmL4qFZYWqcUYgp8joKx7Sqj8E2iqMBFZUitgBfcIJM25Ey6s1DoTBbdEnS6Q58QaI7
         BvIUWBCL0MLZEcbanr7KxkW2Mxm2xT++34D0pN4jQzAXNxXsfgoQ5YIA887tLEsNQVod
         MC/yljk4P3JcYG5pw2R3bsZkZ8lv7arSgmZpNKLuyn9Oam8yculuRp26XczviOhbXIkI
         aO0pgFWODowXdGy/iB/JDyuu00kFAghMKoheUzmYr2t+KIaGi9r396/TflB4LJ1GYj3F
         T3nA==
X-Gm-Message-State: APjAAAULEtmDnn3czXv7qilqzGF0vSWYTeaYZxLrSHX9Gb4Jajlew0ph
        KBfPF/9/EK6RT2fN72XhlL7Nj4hP/v1ymd9aDCOzefyp2VS1
X-Google-Smtp-Source: APXvYqy7CVv/UIN/GUWAS7Syffhmzin1EXRNZnA3epFNO2oJKKVLlSSpze70HYuTSbZUmNzkMFcKy/7TY2q9w6n0/qLIeDJl4Qs9
MIME-Version: 1.0
X-Received: by 2002:a5e:dd4d:: with SMTP id u13mr678477iop.7.1571276530385;
 Wed, 16 Oct 2019 18:42:10 -0700 (PDT)
Date:   Wed, 16 Oct 2019 18:42:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070102d059511537d@google.com>
Subject: KASAN: slab-out-of-bounds Read in ld_usb_read (3)
From:   syzbot <syzbot+6fe95b826644f7f12b0b@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, enric.balletbo@collabora.com,
        gregkh@linuxfoundation.org, johan@kernel.org, kirr@nexedi.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux@roeck-us.net, logang@deltatee.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    22be26f7 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=14f6dc5f600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=387eccb7ac68ec5
dashboard link: https://syzkaller.appspot.com/bug?extid=6fe95b826644f7f12b0b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=102c3227600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12a503a0e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6fe95b826644f7f12b0b@syzkaller.appspotmail.com

ldusb 1-1:0.28: Read buffer overflow, -131383859965943 bytes dropped
==================================================================
BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x124/0x150  
lib/usercopy.c:28
Read of size 102391 at addr ffff8881cfb40008 by task syz-executor372/1737

CPU: 0 PID: 1737 Comm: syz-executor372 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description.constprop.0+0x36/0x50 mm/kasan/report.c:374
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:506
  kasan_report+0xe/0x20 mm/kasan/common.c:634
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x128/0x190 mm/kasan/generic.c:192
  _copy_to_user+0x124/0x150 lib/usercopy.c:28
  copy_to_user include/linux/uaccess.h:152 [inline]
  ld_usb_read+0x329/0x760 drivers/usb/misc/ldusb.c:492
  __vfs_read+0x76/0x100 fs/read_write.c:425
  vfs_read+0x1ea/0x430 fs/read_write.c:461
  ksys_read+0x1e8/0x250 fs/read_write.c:587
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4421d9
Code: e8 7c e7 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc08eb0888 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007ffc08eb0ae0 RCX: 00000000004421d9
RDX: 0000000000018ff7 RSI: 0000000020000a80 RDI: 0000000000000004
RBP: 0000000000000000 R08: 000000000000000f R09: 0000000000402eb0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000402eb0 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea00073ed000 refcount:1 mapcount:0 mapping:0000000000000000  
index:0x0 compound_mapcount: 0
flags: 0x200000000010000(head)
raw: 0200000000010000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881cfb55500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881cfb55580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8881cfb55600: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                    ^
  ffff8881cfb55680: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  ffff8881cfb55700: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
