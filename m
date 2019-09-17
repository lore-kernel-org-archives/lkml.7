Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767FBC4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50824206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 15:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfIQP2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 11:28:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36429 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfIQP2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 11:28:02 -0400
Received: by mail-io1-f70.google.com with SMTP id g126so6316243iof.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 08:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Lzofq4xPIQXczbIqDkIH6JArDXWhDuAAg+Z/kAV0sq8=;
        b=Wsc8t9NdAhe8SHnV/o7713JL9X72aZjUQE1NI9I8i+v7oR9pxVoSjkYaPESR+Jy1b4
         JWQ7BAfIodpAmabJ84VphrHQJPFfl8iT0zwqDVRX8PZm4t4+A/mRjToYoHcU4MDAt7tr
         5tKTyy7hZ2AZbe/7Vcm4aORf8dS/Vi5lEDlwXCVqs9lV4c1eYeURQd/9Kt+/xCZuL2+s
         veJy2Ym2/OOkt7KII/EED5wxS4/o2G2vThvLsRHXZZcLozh4Ji/vx1f48ulKGr7CH1wK
         jMLmW0ElhOlrroODUKC0QVP484OMWRPtQaecXdaliowDbhM5P3WkwiIM1CR7OtBLqHGC
         T6XQ==
X-Gm-Message-State: APjAAAXeZLHzzYQ+Ql8HdHeIA5RgR+6jnNnjTdoBDPNJN0ETmihwo2MM
        pqJw4yowU+WsncZSQzoMN5LyCyA0WCjpYe65tInXqeRO5zxi
X-Google-Smtp-Source: APXvYqyLTV8elUmeAG7div/A5qaTCYovaMk++Q3Zd5quAbkt6djbFw0SFfwznCg3hU9dmByT/aZyJZgd6WlTdihkVvQEL3N97D7P
MIME-Version: 1.0
X-Received: by 2002:a5d:9dd4:: with SMTP id 20mr4217338ioo.1.1568734081310;
 Tue, 17 Sep 2019 08:28:01 -0700 (PDT)
Date:   Tue, 17 Sep 2019 08:28:01 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909171115310.1590-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9f2870592c15dd3@google.com>
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
possible deadlock in vidioc_querycap

============================================
WARNING: possible recursive locking detected
5.3.0-rc7+ #0 Not tainted
--------------------------------------------
v4l_id/3016 is trying to acquire lock:
0000000069c3004e (&usbvision->v4l2_lock){+.+.}, at:  
vidioc_querycap+0x62/0x3b0 drivers/media/usb/usbvision/usbvision-video.c:456

but task is already holding lock:
0000000069c3004e (&usbvision->v4l2_lock){+.+.}, at:  
__video_do_ioctl+0x3ba/0xba0 drivers/media/v4l2-core/v4l2-ioctl.c:2846

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(&usbvision->v4l2_lock);
   lock(&usbvision->v4l2_lock);

  *** DEADLOCK ***

  May be due to missing lock nesting notation

1 lock held by v4l_id/3016:
  #0: 0000000069c3004e (&usbvision->v4l2_lock){+.+.}, at:  
__video_do_ioctl+0x3ba/0xba0 drivers/media/v4l2-core/v4l2-ioctl.c:2846

stack backtrace:
CPU: 0 PID: 3016 Comm: v4l_id Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0xca/0x13e lib/dump_stack.c:113
  print_deadlock_bug kernel/locking/lockdep.c:2301 [inline]
  check_deadlock kernel/locking/lockdep.c:2342 [inline]
  validate_chain kernel/locking/lockdep.c:2881 [inline]
  __lock_acquire.cold+0x148/0x29b kernel/locking/lockdep.c:3880
  lock_acquire+0x127/0x320 kernel/locking/lockdep.c:4412
  __mutex_lock_common kernel/locking/mutex.c:930 [inline]
  __mutex_lock+0x158/0x1360 kernel/locking/mutex.c:1077
  vidioc_querycap+0x62/0x3b0  
drivers/media/usb/usbvision/usbvision-video.c:456
  v4l_querycap+0x121/0x340 drivers/media/v4l2-core/v4l2-ioctl.c:1058
  __video_do_ioctl+0x969/0xba0 drivers/media/v4l2-core/v4l2-ioctl.c:2878
  video_usercopy+0x446/0xf40 drivers/media/v4l2-core/v4l2-ioctl.c:3060
  v4l2_ioctl+0x1a2/0x220 drivers/media/v4l2-core/v4l2-dev.c:360
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd2d/0x1330 fs/ioctl.c:696
  ksys_ioctl+0x9b/0xc0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:718
  do_syscall_64+0xb7/0x580 arch/x86/entry/common.c:296
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f642b0b9347
Code: 90 90 90 48 8b 05 f1 fa 2a 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff  
ff c3 90 90 90 90 90 90 90 90 90 90 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 01 c3 48 8b 0d c1 fa 2a 00 31 d2 48 29 c2 64
RSP: 002b:00007ffc2fc62b28 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f642b0b9347
RDX: 00007ffc2fc62b30 RSI: 0000000080685600 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000400884
R13: 00007ffc2fc62c80 R14: 0000000000000000 R15: 0000000000000000


Tested on:

commit:         f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=160d95c3600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=7fa38a608b1075dfd634
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125290b1600000

