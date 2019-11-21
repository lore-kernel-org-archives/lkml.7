Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0634C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC02520692
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 16:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKUQZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 11:25:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:41579 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfKUQZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 11:25:11 -0500
Received: by mail-il1-f199.google.com with SMTP id o185so3358850ila.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 08:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OXioW4aOf5VAUC/ZpTDg9D13S+IQhnnvj2CsrPfBSc0=;
        b=XftjwZQeqeo4tJfYoWizZ1rHT3VKCTtqH3UaWdJHGqp/fNVrs46SekWD6oHBqpXYUx
         JBUNvqRc5+NF5A66lWrccHqKWyrTdBVgspnSPA8GFMFjTKio6mfVWKG10a2EiIEPmufe
         JDpg+Uw5xVQW4coRz5isqIlW4hvMq4UkrGpyJU1dlVHKouDz/WtUMtAI5NA30jMJNXiT
         selBFkAEkCJ3vrpm88+zYkpQfpNTY6RffKYrTq1ypL+vPTbmyWBhc1B5OoV5P4mss8wD
         7EbzlycspSrrSzIO/ObbzRhtkYlZqXE2SFaGTyc6b1rPYI7R6a/YHVBQYMDRiO4jUfGX
         Gajw==
X-Gm-Message-State: APjAAAV5DP3b8ViB2l9PtdJ3e39LJXvEZxRQ8P8RpVsRpUBIGoB0YZaR
        CKcYpFo1jNQ1UL5qmsZDbTpQvoiL1r2QAlRX6SFQF6ylFsgr
X-Google-Smtp-Source: APXvYqxVIlPdrWltz57TrA/L2dbyx5XttV+s4CA+/6H8aDkXZUvRzoSfZ24qbVgwwI+LjjA9XKmGaM6BxwerZo/tsO3MC2fTeRbi
MIME-Version: 1.0
X-Received: by 2002:a02:9307:: with SMTP id d7mr9155794jah.103.1574353510461;
 Thu, 21 Nov 2019 08:25:10 -0800 (PST)
Date:   Thu, 21 Nov 2019 08:25:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bdfc8e0597ddbde4@google.com>
Subject: linux-next test error: general protection fault in kernfs_find_ns
From:   syzbot <syzbot+0db470b751c87ee157c2@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9942eae4 Add linux-next specific files for 20191121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d36dd2e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a8c5754f140950c
dashboard link: https://syzkaller.appspot.com/bug?extid=0db470b751c87ee157c2
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0db470b751c87ee157c2@syzkaller.appspotmail.com

tipc: TX() has been purged, node left!
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted  
5.4.0-rc8-next-20191121-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: netns cleanup_net
RIP: 0010:kernfs_find_ns+0x36/0x380 fs/kernfs/dir.c:829
Code: 55 41 54 49 89 fc 53 48 83 ec 10 48 89 75 d0 e8 30 e1 91 ff 49 8d 7c  
24 68 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 24 03 00 00 49 8d bc 24 90 00 00 00 49 8b 5c 24
RSP: 0018:ffff8880a988f878 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff884a88e0 RCX: 0000000000000000
RDX: 000000000000000d RSI: ffffffff81e21280 RDI: 0000000000000068
RBP: ffff8880a988f8b0 R08: 1ffffffff1217d04 R09: fffffbfff1217d05
R10: ffff8880a988f8b0 R11: ffffffff890be827 R12: 0000000000000000
R13: ffffffff884a88a0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f36b3919000 CR3: 00000000a4606000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  kernfs_find_and_get_ns+0x34/0x70 fs/kernfs/dir.c:906
  kernfs_find_and_get include/linux/kernfs.h:541 [inline]
  sysfs_remove_group+0x76/0x1b0 fs/sysfs/group.c:276
  netdev_queue_update_kobjects+0x261/0x3e0 net/core/net-sysfs.c:1505
  remove_queue_kobjects net/core/net-sysfs.c:1560 [inline]
  netdev_unregister_kobject+0x15e/0x1f0 net/core/net-sysfs.c:1710
  rollback_registered_many+0xafe/0x10d0 net/core/dev.c:8770
  unregister_netdevice_many.part.0+0x1b/0x1f0 net/core/dev.c:9906
  unregister_netdevice_many+0x3b/0x50 net/core/dev.c:9905
  ip6gre_exit_batch_net+0x53c/0x760 net/ipv6/ip6_gre.c:1604
  ops_exit_list.isra.0+0x10c/0x160 net/core/net_namespace.c:175
  cleanup_net+0x538/0xaf0 net/core/net_namespace.c:597
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 2b89c7a6a0476a22 ]---
RIP: 0010:kernfs_find_ns+0x36/0x380 fs/kernfs/dir.c:829
Code: 55 41 54 49 89 fc 53 48 83 ec 10 48 89 75 d0 e8 30 e1 91 ff 49 8d 7c  
24 68 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 24 03 00 00 49 8d bc 24 90 00 00 00 49 8b 5c 24
RSP: 0018:ffff8880a988f878 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffffffff884a88e0 RCX: 0000000000000000
RDX: 000000000000000d RSI: ffffffff81e21280 RDI: 0000000000000068
RBP: ffff8880a988f8b0 R08: 1ffffffff1217d04 R09: fffffbfff1217d05
R10: ffff8880a988f8b0 R11: ffffffff890be827 R12: 0000000000000000
R13: ffffffff884a88a0 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f36b3919000 CR3: 000000009324f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
