Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DA4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E3A121881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404095AbfHHQqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:46:10 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:51086 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbfHHQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:46:10 -0400
Received: by mail-ot1-f71.google.com with SMTP id a21so62940123otk.17
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 09:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZGIgiQTWoMYwPm+fnbCtzG1XJueXYFaQuy0XIO2WPN0=;
        b=hQGzETvUUslc81UwdOKLAqyOlaGBLWca+y1lm/+LJCgSXbVH6qARTWuzlobzB9v63E
         MXVJupXheyVjslkjX22zkOjfICEAQhTavzS3Gk4gRW4ZEqMpgUSM9ww2fweoDje6WG+M
         ckxG62Tst5p1g051OyaDSeYYVoB/pOrMMcbEhJFOQ4qvNDSeE2I2gahAY8aIpmNkwt7+
         NTxXH1PW1lwybFgAAXlyhDn4RqWCv441tED5GxR9djR+p1cFml5on6JJwd/e1iY58wQ9
         BnZGjFuRTM0+KagKWail9yrcCAfNiOBfcpimhaN/UEbE9f5JJ7gEbTXHf71uarZhPPj2
         JRtA==
X-Gm-Message-State: APjAAAWSwpc7hPcf+IB3jmA8zXSZkXhB+GlZsJ0eA8vnzjqdzKGpp6ZK
        iQiOYlWWdYP0MpkxdJdhI4MMRAvbEaeDBYXlTHHTKhygpsdV
X-Google-Smtp-Source: APXvYqx/iTNSBE5WFTWV7cXVplqYv1wrMAOdvvEk20tq0gz0K3HY2pb98J4+Da/gWO2Y0m4IwTQ0tudBvprfP+oClDV0qvxQ/Z8s
MIME-Version: 1.0
X-Received: by 2002:a02:cc8e:: with SMTP id s14mr17932295jap.142.1565282769135;
 Thu, 08 Aug 2019 09:46:09 -0700 (PDT)
Date:   Thu, 08 Aug 2019 09:46:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d6e01058f9dcb42@google.com>
Subject: general protection fault in relay_switch_subbuf (2)
From:   syzbot <syzbot+c6e6fb9765b1f884106a@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    70f4b4ac Add linux-next specific files for 20190730
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=107f7fc8600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83083aa18c7fa5ce
dashboard link: https://syzkaller.appspot.com/bug?extid=c6e6fb9765b1f884106a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c6e6fb9765b1f884106a@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 6341 Comm: syz-executor.1 Not tainted 5.3.0-rc2-next-20190730  
#55
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:relay_switch_subbuf+0x216/0x920 kernel/relay.c:755
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bc 06 00 00 48 b8 00 00 00 00  
00 fc ff df 4c 8b 7b 58 49 8d 7f 50 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 7d 06 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
RSP: 0018:ffff888087a17568 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: ffff88808a6cb840 RCX: ffffc9000816e000
RDX: 000000000000000a RSI: ffffffff8172d57e RDI: 0000000000000050
RBP: ffff888087a175c0 R08: ffff8880601522c0 R09: 0000000000000010
R10: ffffed1010f42eb6 R11: 0000000000000003 R12: 0000000000000040
R13: 0000000000000000 R14: ffff88809f376dc0 R15: 0000000000000000
FS:  00007eff1049a700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000009797e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  relay_reserve include/linux/relay.h:261 [inline]
  trace_note.isra.0+0x5b8/0x6e0 kernel/trace/blktrace.c:93
  trace_note_tsk kernel/trace/blktrace.c:124 [inline]
  __blk_add_trace+0xb70/0xe10 kernel/trace/blktrace.c:264
  blk_add_trace_bio.isra.0+0x19c/0x220 kernel/trace/blktrace.c:865
  blk_add_trace_bio_queue+0x46/0x60 kernel/trace/blktrace.c:902
  trace_block_bio_queue include/trace/events/block.h:357 [inline]
  generic_make_request_checks+0x16c3/0x21a0 block/blk-core.c:954
  generic_make_request+0x8f/0xb50 block/blk-core.c:1006
  submit_bio+0x104/0x4d0 block/blk-core.c:1163
  submit_bh_wbc+0x6b6/0x900 fs/buffer.c:3132
  submit_bh fs/buffer.c:3138 [inline]
  __bread_slow fs/buffer.c:1214 [inline]
  __bread_gfp+0x164/0x370 fs/buffer.c:1396
  sb_bread include/linux/buffer_head.h:307 [inline]
  fat_fill_super+0x353/0x3880 fs/fat/inode.c:1653
  vfat_fill_super+0x32/0x40 fs/fat/namei_vfat.c:1050
  mount_bdev+0x304/0x3c0 fs/super.c:1405
  vfat_mount+0x35/0x40 fs/fat/namei_vfat.c:1057
  legacy_get_tree+0x113/0x220 fs/fs_context.c:651
  vfs_get_tree+0x8f/0x380 fs/super.c:1480
  do_new_mount fs/namespace.c:2791 [inline]
  do_mount+0x13b3/0x1c30 fs/namespace.c:3111
  ksys_mount+0xdb/0x150 fs/namespace.c:3320
  __do_sys_mount fs/namespace.c:3334 [inline]
  __se_sys_mount fs/namespace.c:3331 [inline]
  __x64_sys_mount+0xbe/0x150 fs/namespace.c:3331
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c27a
Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 9d 8d fb ff c3 66 2e 0f  
1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7a 8d fb ff c3 66 0f 1f 84 00 00 00 00 00
RSP: 002b:00007eff10499a88 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007eff10499b40 RCX: 000000000045c27a
RDX: 00007eff10499ae0 RSI: 00000000200002c0 RDI: 00007eff10499b00
RBP: 0000000000000000 R08: 00007eff10499b40 R09: 00007eff10499ae0
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000003
R13: 00000000004c8a98 R14: 00000000004df8d0 R15: 00000000ffffffff
Modules linked in:
---[ end trace 04681dc2b7471884 ]---
RIP: 0010:relay_switch_subbuf+0x216/0x920 kernel/relay.c:755
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 bc 06 00 00 48 b8 00 00 00 00  
00 fc ff df 4c 8b 7b 58 49 8d 7f 50 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 7d 06 00 00 48 ba 00 00 00 00 00 fc ff df 49 8b
RSP: 0018:ffff888087a17568 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: ffff88808a6cb840 RCX: ffffc9000816e000
RDX: 000000000000000a RSI: ffffffff8172d57e RDI: 0000000000000050
RBP: ffff888087a175c0 R08: ffff8880601522c0 R09: 0000000000000010
R10: ffffed1010f42eb6 R11: 0000000000000003 R12: 0000000000000040
R13: 0000000000000000 R14: ffff88809f376dc0 R15: 0000000000000000
FS:  00007eff1049a700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000009797e000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
