Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6A7C49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604A720665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 18:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390662AbfIPStg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 14:49:36 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:50024 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390519AbfIPStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 14:49:12 -0400
Received: by mail-io1-f69.google.com with SMTP id j23so1108769iog.16
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 11:49:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qC0xNuCFT2K5WnrI4/kA6JnBcvDth6gxH5fcwxA7nY8=;
        b=sBEyVRdBX+n130yDrRkI+vnoOeky8juyNDnJ2HEJlWZuSDtrYYZR9R3VjAqA9oEeeo
         ntGeux26t/mEZhWz5e/MyLJU6IdHvBRyetVeQ0tY1h66rsbyH6s/urhMMRj7DmmgAej3
         KpflQTdV2UfMbBF+V9W1nZetwH4S3lLR96BjSivlFjFMdFN0LSoc/z8hRfQMgzl696WH
         b+smaHFFJ9HesLAEDvgiCWtBPsvQXsYmDbROvCvyZ24hrgBYSx/7RtPyb2qBLrBUytUy
         EvUuSMjwrp7GD4yLGTBJ3TsRj+AfMEE8Yt7Mdv1LsZlwteTbwBwqTBpfL03tkQ1c4/5a
         ylHQ==
X-Gm-Message-State: APjAAAWN73vkQ1yIBFC02lr+rRD56IGEM4f526P5LlxDU411fxEj4Yi6
        KIDWA8q7/eFJL5XQdxPEbfGmME/+FSPhJc+NemC7rAC/yrwo
X-Google-Smtp-Source: APXvYqzKw6FgH6xAMwPcLI9wdVOOeC8ZFRLFEAJBBwP7sr2c4k62ShnUES16SzVQEDbsJCYL7dFaZuIncdwozN4VTNO9UUIPgDA5
MIME-Version: 1.0
X-Received: by 2002:a02:5585:: with SMTP id e127mr1524963jab.25.1568659751315;
 Mon, 16 Sep 2019 11:49:11 -0700 (PDT)
Date:   Mon, 16 Sep 2019 11:49:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000402f3a0592b00f13@google.com>
Subject: KASAN: slab-out-of-bounds Read in ld_usb_read (2)
From:   syzbot <syzbot+4a52dbcef08fddbc887e@syzkaller.appspotmail.com>
To:     alexandre.belloni@bootlin.com, andreyknvl@google.com,
        bhelgaas@google.com, enric.balletbo@collabora.com,
        gregkh@linuxfoundation.org, kirr@nexedi.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        lkundrak@v3.sk, logang@deltatee.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=1462f9a5600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=4a52dbcef08fddbc887e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4a52dbcef08fddbc887e@syzkaller.appspotmail.com

ldusb 3-1:0.98: Read buffer overflow, -2576376864 bytes dropped
==================================================================
BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x124/0x150  
lib/usercopy.c:27
Read of size 536879616 at addr ffff8881ab680008 by task syz-executor.2/12817

CPU: 0 PID: 12817 Comm: syz-executor.2 Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_address_description+0x6a/0x32c mm/kasan/report.c:351
  __kasan_report.cold+0x1a/0x33 mm/kasan/report.c:482
  kasan_report+0xe/0x12 mm/kasan/common.c:618
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x128/0x190 mm/kasan/generic.c:192
  _copy_to_user+0x124/0x150 lib/usercopy.c:27
  copy_to_user include/linux/uaccess.h:152 [inline]
  ld_usb_read+0x31a/0x780 drivers/usb/misc/ldusb.c:495
  __vfs_read+0x76/0x100 fs/read_write.c:425
  vfs_read+0x1ea/0x430 fs/read_write.c:461
  ksys_read+0x1e8/0x250 fs/read_write.c:587
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4598e9
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fad75925c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004598e9
RDX: 0000000020002200 RSI: 0000000020001200 RDI: 0000000000000004
RBP: 000000000075bfc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fad759266d4
R13: 00000000004c6d1a R14: 00000000004dc0c0 R15: 00000000ffffffff

The buggy address belongs to the page:
page:ffffea0006ada000 refcount:1 mapcount:0 mapping:0000000000000000  
index:0x0 compound_mapcount: 0
flags: 0x200000000010000(head)
raw: 0200000000010000 dead000000000100 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff8881ab6a0300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff8881ab6a0380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff8881ab6a0400: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                    ^
  ffff8881ab6a0480: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
  ffff8881ab6a0500: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
