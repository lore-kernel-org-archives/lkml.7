Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4B7C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9C220692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKUQZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:25:17 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:34385 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbfKUQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:25:11 -0500
Received: by mail-io1-f70.google.com with SMTP id a13so2656307iol.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 08:25:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OCLPduJlcDY35lmbRV7Z+GvbBWX59f8XlTByb6+mk3E=;
        b=B5slKsVKxND3oNSnbIK6qGBGljvgIw9VisZDqz8CP8EMltO9c2F9beWyDlz+D5Htwf
         guqoVf/daZ7cxwhm0WMf4HY0hnJsyubBW2nNZblDyT86yK4KlUhEjpg4IdlsCIUJE3/7
         A/YqsnqupaVmiDd65gwDzXrAimdVw8oHLazQYmjc9iUuohPZUSEydU1ff487MgV5XfvD
         OeXGvEOJRsfRyS1PiMHyrhAVI2RvFbbiIIr6PMzWd1VJZHSnsYYB0JdY91Glc1U2bNrn
         pxP4yAw8VeFvCjtIlA9+2DjXDVjpdFv3V+7ZOLMB5y32ALCPVJe1La+jP0/nmy+7Pyhs
         mXng==
X-Gm-Message-State: APjAAAW6VXYuRjiG8YOtDrY//+iLMu9JTwRrjwTW3Mx1KTdIqgcTDilf
        1NLVY7rhsWOBvPs5WuL5cxu3oEbN6WDbGphYCLpYhOQVynfX
X-Google-Smtp-Source: APXvYqz+aRPvGQJfzUTE3z9KBtc31Q8WdJoa00t0yOL4+JsK641UDZ4MK4QGTWRmAbwF/wye0Fa2RsnmkxCOkg9LPyo0L/Zy+LqS
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:d85:: with SMTP id i5mr11318199ilj.161.1574353510719;
 Thu, 21 Nov 2019 08:25:10 -0800 (PST)
Date:   Thu, 21 Nov 2019 08:25:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1e9090597ddbd9d@google.com>
Subject: net test error: general protection fault in kernfs_find_ns
From:   syzbot <syzbot+36275730ddc1625afdb5@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    064a1899 Merge tag 'mlx5-fixes-2019-11-20' of git://git.ke..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=124aee22e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1aab6d4187ddf667
dashboard link: https://syzkaller.appspot.com/bug?extid=36275730ddc1625afdb5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+36275730ddc1625afdb5@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 5.4.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:kernfs_find_ns+0x36/0x380 fs/kernfs/dir.c:836
Code: 55 41 54 49 89 fc 53 48 83 ec 10 48 89 75 d0 e8 d0 7d 94 ff 49 8d 7c  
24 68 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 24 03 00 00 49 8d bc 24 90 00 00 00 49 8b 5c 24
RSP: 0018:ffff8880a9897898 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff8848f7a0 RCX: 0000000000000000
RDX: 000000000000000d RSI: ffffffff81deda20 RDI: 0000000000000068
RBP: ffff8880a98978d0 R08: 1ffffffff1214718 R09: fffffbfff1214719
R10: ffff8880a98978d0 R11: ffffffff890a38c7 R12: 0000000000000000
R13: ffffffff8848f760 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c420800000 CR3: 00000000a8dc9000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kernfs_find_and_get_ns+0x34/0x70 fs/kernfs/dir.c:913
  kernfs_find_and_get include/linux/kernfs.h:522 [inline]
  sysfs_remove_group+0x76/0x1b0 fs/sysfs/group.c:276
  netdev_queue_update_kobjects+0x261/0x3e0 net/core/net-sysfs.c:1505
  remove_queue_kobjects net/core/net-sysfs.c:1560 [inline]
  netdev_unregister_kobject+0x15e/0x1f0 net/core/net-sysfs.c:1710
  rollback_registered_many+0x7c6/0xfc0 net/core/dev.c:8546
  unregister_netdevice_many.part.0+0x1b/0x1f0 net/core/dev.c:9675
  unregister_netdevice_many+0x3b/0x50 net/core/dev.c:9674
  ip6gre_exit_batch_net+0x541/0x760 net/ipv6/ip6_gre.c:1604
  ops_exit_list.isra.0+0x10c/0x160 net/core/net_namespace.c:175
  cleanup_net+0x538/0xaf0 net/core/net_namespace.c:597
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace b94ff3c5954003d3 ]---
RIP: 0010:kernfs_find_ns+0x36/0x380 fs/kernfs/dir.c:836
Code: 55 41 54 49 89 fc 53 48 83 ec 10 48 89 75 d0 e8 d0 7d 94 ff 49 8d 7c  
24 68 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 24 03 00 00 49 8d bc 24 90 00 00 00 49 8b 5c 24
RSP: 0018:ffff8880a9897898 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff8848f7a0 RCX: 0000000000000000
RDX: 000000000000000d RSI: ffffffff81deda20 RDI: 0000000000000068
RBP: ffff8880a98978d0 R08: 1ffffffff1214718 R09: fffffbfff1214719
R10: ffff8880a98978d0 R11: ffffffff890a38c7 R12: 0000000000000000
R13: ffffffff8848f760 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c420800000 CR3: 00000000a7903000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
