Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D3BC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7940206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfIQSnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:43:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35440 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727613AbfIQSnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:43:01 -0400
Received: by mail-io1-f70.google.com with SMTP id r5so35039iop.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 11:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/F0kKipYWqaYBt3M3avLzKPNE6WRe87ru2I5XGId8tY=;
        b=Vhl7BYPHDsweSeccAci9DhNGeyX7bP87SRLnwKVjatWznI71zfIdhpEANeyZ8SfzZ6
         qkCg2ACIIsjp6wYTl2vIqN1l0nR7Mu32lIMpzkVLauQkLbgXJEUYJc/6lGMBsaqD/ydr
         3mKgl6G64Hs8+bkX8l0pnEwxuOUT6TUwpB9DOU6Hm/PQhbaLIF1YTTF7KvMn3flIOu3V
         mypLaKwu19Wb+zYtdYQsf5lvLwXPpH9aHB4Ar6M4YawZpDpxGsFa7h1NnDyUB3QOdYiu
         ijLq25+rTDBIERL4RbB4zP18H+D2VRjBUOid5akGoNj+kSoeh+imoTb96GmS/Agm+/9R
         a5GQ==
X-Gm-Message-State: APjAAAVSkNMZ3Mof3UNBrC8PTOJjHUmrB22Iap8X7dY9AMfAVUko0b6q
        Kl9ymWTW3W0wSySklr0HCLHtBq2FrRhUpWjxHMdg70B5hI2a
X-Google-Smtp-Source: APXvYqxQPZotl0l2IVOv3ERHpbOUR2+bKKqThcD/MS6ZsPgmd0BwKvwh2+4xsKlssE3P2h8aZ/I5HGOdVWNuLXW9VP+Qml9sfJlj
MIME-Version: 1.0
X-Received: by 2002:a6b:7510:: with SMTP id l16mr251470ioh.2.1568745780760;
 Tue, 17 Sep 2019 11:43:00 -0700 (PDT)
Date:   Tue, 17 Sep 2019 11:43:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909171428160.1590-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001595b0592c41731@google.com>
Subject: Re: general protection fault in usb_set_interface
From:   syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mans@mansr.com, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
WARNING in sysfs_remove_group

------------[ cut here ]------------
sysfs group 'power' not found for kobject 'radio0'
WARNING: CPU: 0 PID: 2871 at fs/sysfs/group.c:278 sysfs_remove_group  
fs/sysfs/group.c:278 [inline]
WARNING: CPU: 0 PID: 2871 at fs/sysfs/group.c:278  
sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 2871 Comm: v4l_id Not tainted 5.3.0-rc7+ #0
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
RIP: 0010:sysfs_remove_group fs/sysfs/group.c:278 [inline]
RIP: 0010:sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
Code: 48 89 d9 49 8b 14 24 48 b8 00 00 00 00 00 fc ff df 48 c1 e9 03 80 3c  
01 00 75 41 48 8b 33 48 c7 c7 e0 c8 d0 85 e8 a0 0e 8b ff <0f> 0b eb 95 e8  
e2 d1 db ff e9 d2 fe ff ff 48 89 df e8 d5 d1 db ff
RSP: 0018:ffff8881c6c37c50 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff85f2d700 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81288ddd RDI: ffffed1038d86f7c
RBP: 0000000000000000 R08: ffff8881d5dab000 R09: ffffed103b643ee7
R10: ffffed103b643ee6 R11: ffff8881db21f737 R12: ffff8881cf7e2bd8
R13: ffffffff85f2dca0 R14: 0000000000000000 R15: ffff8881cf7e3078
  dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:735
  device_del+0x12a/0xb10 drivers/base/core.c:2316
  device_unregister+0x11/0x30 drivers/base/core.c:2371
  video_unregister_device+0xa2/0xc0 drivers/media/v4l2-core/v4l2-dev.c:1051
  usbvision_unregister_video+0x83/0x120  
drivers/media/usb/usbvision/usbvision-video.c:1256
  usbvision_release+0x10d/0x1c0  
drivers/media/usb/usbvision/usbvision-video.c:1369
  usbvision_radio_close.cold+0x2b/0x74  
drivers/media/usb/usbvision/usbvision-video.c:1142
  v4l2_release+0x2e7/0x390 drivers/media/v4l2-core/v4l2-dev.c:455
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fa3a6eac2b0
Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 32 08 00 e8 c0  
07 02 00 83 3d 45 a3 2b 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 ce 8a 01 00 48 89 04 24
RSP: 002b:00007ffe36ff6c28 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007fa3a6eac2b0
RDX: 0000000000000013 RSI: 0000000080685600 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000400884
R13: 00007ffe36ff6d80 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10621965600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=7fa38a608b1075dfd634
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15fea979600000

