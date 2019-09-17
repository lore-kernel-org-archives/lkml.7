Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D38C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3642053B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 16:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbfIQQGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 12:06:03 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:55498 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfIQQGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 12:06:03 -0400
Received: by mail-io1-f69.google.com with SMTP id r13so6343408ioj.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 09:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=tMVKoMSo143WvFLpbKtqPunkRQ5QruXJpLrlAkHe/bU=;
        b=NrZds6dF/fBkpgKKOlGEIZI8xJY3QvzIfArtcafvDIh+Qx8xKs4vjPbxSPS7j5AE6V
         5TDHVxUJLi+pAlMISduIOo+iQsZIQNjkjQVPpt3do4TF4LPIQlT8Kt6nZGOZl6hPJuUs
         +hhKpDRTCxSiuYjxVQQlYrvpYqCBfAFmIG/66z3TpbH6p+5f91QSclf4mfe9r+rMie3M
         90U0H4+zD/XfcgZFj5cC5GI0azMyNk9VY5+aLW7CP3/mtFmn9ynijl/03dw5yp+9XTpK
         +EzilmV/1PDMVg2CPLKFSrur9CJ7yJ71+zC/HWGcJRyiK1ct3ZdNgTGkMDUGExahx/9Z
         goCA==
X-Gm-Message-State: APjAAAUZgl/V6cTIiklRnv71/wbrCjHBofF+WgDPyXkNkp4ynsea8DQe
        SowNGAdbbQLnhH/nsGde9Qvr9qxym62LLu7OuLeC8RMQSIkV
X-Google-Smtp-Source: APXvYqw1D2p2pVGFPJwudQzoYsxbcbCyTnxThBiMA8Mg95bcXBIopp9fWUbHpO7XmmcFuVxtggFOKRUsSS+3YiN06KnxHh16VS4q
MIME-Version: 1.0
X-Received: by 2002:a6b:3b94:: with SMTP id i142mr227690ioa.212.1568736360976;
 Tue, 17 Sep 2019 09:06:00 -0700 (PDT)
Date:   Tue, 17 Sep 2019 09:06:00 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909171152520.1590-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ad92e0592c1e58f@google.com>
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
sysfs group 'power' not found for kobject 'radio3'
WARNING: CPU: 1 PID: 2883 at fs/sysfs/group.c:278 sysfs_remove_group  
fs/sysfs/group.c:278 [inline]
WARNING: CPU: 1 PID: 2883 at fs/sysfs/group.c:278  
sysfs_remove_group+0x155/0x1b0 fs/sysfs/group.c:269
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 2883 Comm: v4l_id Not tainted 5.3.0-rc7+ #0
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
RSP: 0018:ffff8881c6d17c50 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffffffff85f2d700 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff81288ddd RDI: ffffed1038da2f7c
RBP: 0000000000000000 R08: ffff8881d6243000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8881cf014cd8
R13: ffffffff85f2dca0 R14: 0000000000000000 R15: ffff8881cf015178
  dpm_sysfs_remove+0x97/0xb0 drivers/base/power/sysfs.c:735
  device_del+0x12a/0xb10 drivers/base/core.c:2316
  device_unregister+0x11/0x30 drivers/base/core.c:2371
  video_unregister_device+0xa2/0xc0 drivers/media/v4l2-core/v4l2-dev.c:1051
  usbvision_unregister_video+0x83/0x120  
drivers/media/usb/usbvision/usbvision-video.c:1243
  usbvision_release+0x10d/0x1c0  
drivers/media/usb/usbvision/usbvision-video.c:1356
  usbvision_radio_close.cold+0x2b/0x74  
drivers/media/usb/usbvision/usbvision-video.c:1129
  v4l2_release+0x2e7/0x390 drivers/media/v4l2-core/v4l2-dev.c:455
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f4fde8992b0
Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 32 08 00 e8 c0  
07 02 00 83 3d 45 a3 2b 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 ce 8a 01 00 48 89 04 24
RSP: 002b:00007ffcce3d65f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f4fde8992b0
RDX: 0000000000000013 RSI: 0000000080685600 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000400884
R13: 00007ffcce3d6750 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=178ba88d600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=7fa38a608b1075dfd634
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14ce1b59600000

