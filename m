Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD303C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A35A2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbfHSOsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:48:24 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:47926 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfHSOsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:48:08 -0400
Received: by mail-io1-f72.google.com with SMTP id b22so4307518iod.14
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 07:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ac1Dd0f7myJD3f/lU85Q4qmz+h7RcpGISxCnHNtixgI=;
        b=tbI0k7DcamLrDmCEhSr4DaFIKRfR4gQ7TmGUDoU+nFqRWjaMnK4oe8411j+SgEOQy+
         9w1nL+WJO0tg57sjkyCldleZQO5yy78eIm8tRmy21XHq1vrh/KK5vU3JTVZHPi7PoD+z
         16HYqVnIoiWsEDkp5bQRATJuXjyI3kFs/mhHi+639/Kn2H0IqnHgUW23lrRJ6l0/2JDM
         Wvisz0LWRNay5ImI2Muc2t+J87KyVMRNb+cwIaChiwVWAgDfg0vCLSWNGVV1FvRrLA/J
         ToMKOaDcUlsPimbyKyCkiZxhf3xos12o7kggIRFKbHaz6qswdekJOAzbR4mVzn87HNz6
         TqDA==
X-Gm-Message-State: APjAAAX1bJ4N34Pw+5uzUo+OgDY4VicNumeot5TwD7dhIWf9KTmmXmEH
        p9kWKk2xo0Y1vW31YdDgSAEouS478kWPFitzsACXu/41vmyd
X-Google-Smtp-Source: APXvYqyXFwueIQASvMgxmZkzkAjChxFsXRZUB+LemFxWQH6OEY8O6Bg+kNn28zRX7YQKZnZP9HeohELxjT3rhG5KGV5Wwz1QrCbR
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1e5:: with SMTP id t5mr12626810jaq.79.1566226087715;
 Mon, 19 Aug 2019 07:48:07 -0700 (PDT)
Date:   Mon, 19 Aug 2019 07:48:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098afd80590796d14@google.com>
Subject: WARNING in wdm_write/usb_submit_urb
From:   syzbot <syzbot+d232cca6ec42c2edb3fc@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    d0847550 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=16462bba600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dbc9c80cc095da19
dashboard link: https://syzkaller.appspot.com/bug?extid=d232cca6ec42c2edb3fc
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fac696600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d232cca6ec42c2edb3fc@syzkaller.appspotmail.com

------------[ cut here ]------------
URB 00000000860a3d7f submitted while active
WARNING: CPU: 0 PID: 2801 at drivers/usb/core/urb.c:362  
usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:362
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 2801 Comm: syz-executor.5 Not tainted 5.3.0-rc4+ #26
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  panic+0x2a3/0x6da kernel/panic.c:219
  __warn.cold+0x20/0x4a kernel/panic.c:576
  report_bug+0x262/0x2a0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x12b/0x1e0 arch/x86/kernel/traps.c:272
  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:usb_submit_urb+0x10c1/0x13b0 drivers/usb/core/urb.c:362
Code: 89 de e8 62 b7 ef fd 84 db 0f 85 42 f6 ff ff e8 25 b6 ef fd 4c 89 fe  
48 c7 c7 c0 67 18 86 c6 05 07 29 3a 04 01 e8 14 9b c5 fd <0f> 0b e9 20 f6  
ff ff c7 44 24 14 01 00 00 00 e9 d7 f6 ff ff 41 bd
RSP: 0018:ffff8881d9647c98 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81288cfd RDI: ffffed103b2c8f85
RBP: ffff8881ca339220 R08: ffff8881d96bb000 R09: ffffed103b645d58
R10: ffffed103b645d57 R11: ffff8881db22eabf R12: 1ffff1103b2c8fa7
R13: 00000000fffffff0 R14: ffff8881ca339208 R15: ffff8881c8b53900
  wdm_write+0x828/0xd87 drivers/usb/class/cdc-wdm.c:423
  __vfs_write+0x76/0x100 fs/read_write.c:494
  vfs_write+0x262/0x5c0 fs/read_write.c:558
  ksys_write+0x127/0x250 fs/read_write.c:611
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459829
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f8693ebdc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459829
RDX: 0000000000000020 RSI: 0000000020000040 RDI: 0000000000000004
RBP: 000000000075c070 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8693ebe6d4
R13: 00000000004c99ec R14: 00000000004e1088 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
