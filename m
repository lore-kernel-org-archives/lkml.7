Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C76DC00319
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE76E2085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 07:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfCBHFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 02:05:07 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:35223 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfCBHFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 02:05:07 -0500
Received: by mail-it1-f198.google.com with SMTP id 142so298950itx.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 23:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OM7CbXXR1xx2ZuezkNYRjNje+DBv6SzYf50ZfbqkGB4=;
        b=lSFH2rhONkq37q2n6s9ByOmxt18o2yO+ReKV4SBqz5xbR19XGsSDsNK2D9M3T/gxT2
         ZU6c4zcnPtFzTaWwSjlMCSfh23LMwRxUcX3ZIMtYf/OJtpVKysv+6IBxdD8WocB+3ex1
         1R0GYM1kCusR0kfEYRX0v4O3t7wXsv10LPpg0vP2BgrkrgeVYRkfsORnXlggsGq4KtkZ
         ABv3+9lHrWagt4+OQENxaT19sPCFbaKTby9z2pLi+j5+USfidRetiAuv+xUnhH9j8K/7
         VO4gM9fkNteUI2w4G9HtJDvkx5bmL14roRa5f5jcxUKvc4lxr1pIoQ7OiHjyNB7tsZ1M
         jltQ==
X-Gm-Message-State: APjAAAUiGqvQA/uEyGjv+cT6piWRudxP+ISAGcahQByrE8zA+vsYe9h1
        wRFaAvvzEuGDYF2KWAvxZ6y6znG3BcjjV2roi0x8FxRvBjej
X-Google-Smtp-Source: APXvYqyeTaopmkDVAsOvK3XhqcsAHGXrcC786pkyHMXfd6xAEzCzuuUZpi9Mai0r8rYfyOVYRBpEXSDP1ApvAcwBXNrQaC+pHP/v
MIME-Version: 1.0
X-Received: by 2002:a6b:f215:: with SMTP id q21mr5120096ioh.25.1551510305383;
 Fri, 01 Mar 2019 23:05:05 -0800 (PST)
Date:   Fri, 01 Mar 2019 23:05:05 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e31600583172454@google.com>
Subject: BUG: spinlock bad magic in flush_workqueue_prep_pwqs
From:   syzbot <syzbot+130f0c441448a93a166b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, isdn@linux-pingi.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7d762d69145a afs: Fix manually set volume location server ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13044284c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b76ec970784287c
dashboard link: https://syzkaller.appspot.com/bug?extid=130f0c441448a93a166b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+130f0c441448a93a166b@syzkaller.appspotmail.com

BUG: spinlock bad magic on CPU#1, syz-executor.2/18168
  lock: 0xffff8880ae92cd2d, .magic: 00000000, .owner: <none>/-1, .owner_cpu:  
0
CPU: 1 PID: 18168 Comm: syz-executor.2 Not tainted 5.0.0-rc8+ #88
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  spin_dump.cold+0x81/0xe6 kernel/locking/spinlock_debug.c:67
  spin_bug kernel/locking/spinlock_debug.c:75 [inline]
  debug_spin_lock_before kernel/locking/spinlock_debug.c:83 [inline]
  do_raw_spin_lock+0x231/0x2e0 kernel/locking/spinlock_debug.c:112
  __raw_spin_lock_irq include/linux/spinlock_api_smp.h:129 [inline]
  _raw_spin_lock_irq+0x68/0x80 kernel/locking/spinlock.c:160
  spin_lock_irq include/linux/spinlock.h:354 [inline]
  flush_workqueue_prep_pwqs+0x1c5/0x590 kernel/workqueue.c:2633
  flush_workqueue+0x54b/0x14c0 kernel/workqueue.c:2704
  capi20_release+0x1e7/0x290 drivers/isdn/capi/kcapi.c:748
  capi_release+0x1cd/0x230 drivers/isdn/capi/capi.c:975
  __fput+0x2df/0x8d0 fs/file_table.c:278
  ____fput+0x16/0x20 fs/file_table.c:309
  task_work_run+0x14a/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x273/0x2c0 arch/x86/entry/common.c:166
  prepare_exit_to_usermode arch/x86/entry/common.c:197 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:268 [inline]
  do_syscall_64+0x52d/0x610 arch/x86/entry/common.c:293
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x457e29
Code: ad b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2440e7dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000457e29
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 000000000073bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2440e7e6d4
R13: 00000000004f4d52 R14: 00000000004ce8f8 R15: 00000000ffffffff
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (00000000cd9c1962): kobject_uevent_env
kobject: 'loop2' (00000000cd9c1962): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop3' (00000000f8ccfb34): kobject_uevent_env
kobject: 'loop3' (00000000f8ccfb34): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop5' (00000000522745e2): kobject_uevent_env
kobject: 'loop5' (00000000522745e2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000a4ac2be3): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop2' (00000000cd9c1962): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (00000000cd9c1962): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (00000000cd9c1962): kobject_uevent_env
kobject: 'loop2' (00000000cd9c1962): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop4' (00000000a4ac2be3): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000f8ccfb34): kobject_uevent_env
kobject: 'loop3' (00000000f8ccfb34): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000a4ac2be3): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop5' (00000000522745e2): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop5' (00000000522745e2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'loop4' (00000000a4ac2be3): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000f8ccfb34): kobject_uevent_env
kobject: 'loop3' (00000000f8ccfb34): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
net_ratelimit: 23 callbacks suppressed
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop5' (00000000522745e2): kobject_uevent_env
kobject: 'loop5' (00000000522745e2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop2' (00000000cd9c1962): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (00000000cd9c1962): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'loop2' (00000000cd9c1962): kobject_uevent_env
kobject: 'loop2' (00000000cd9c1962): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (00000000cd9c1962): kobject_uevent_env
kobject: 'loop2' (00000000cd9c1962): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop3' (00000000f8ccfb34): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop3' (00000000f8ccfb34): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop5' (00000000522745e2): kobject_uevent_env
kobject: 'loop5' (00000000522745e2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000a4ac2be3): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000a4ac2be3): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000f8ccfb34): kobject_uevent_env
kobject: 'loop3' (00000000f8ccfb34): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
kobject: 'loop5' (00000000522745e2): kobject_uevent_env
kobject: 'loop5' (00000000522745e2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop2' (00000000cd9c1962): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop2' (00000000cd9c1962): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop2' (00000000cd9c1962): kobject_uevent_env
kobject: 'loop2' (00000000cd9c1962): fill_kobj_path: path  
= '/devices/virtual/block/loop2'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
net_ratelimit: 16 callbacks suppressed
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000a4ac2be3): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000a4ac2be3): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop3' (00000000f8ccfb34): kobject_uevent_env
kobject: 'loop3' (00000000f8ccfb34): fill_kobj_path: path  
= '/devices/virtual/block/loop3'
protocol 88fb is buggy, dev hsr_slave_0
kobject: 'loop5' (00000000522745e2): kobject_uevent_env
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'loop5' (00000000522745e2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
protocol 88fb is buggy, dev hsr_slave_0
protocol 88fb is buggy, dev hsr_slave_1
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop1' (00000000dacfac08): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop1' (00000000dacfac08): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): kobject_uevent_env
kobject: 'loop0' (0000000006336e0b): fill_kobj_path: path  
= '/devices/virtual/block/loop0'
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'kvm' (00000000400fec10): kobject_uevent_env
kobject: 'kvm' (00000000400fec10): fill_kobj_path: path  
= '/devices/virtual/misc/kvm'
kobject: 'loop4' (00000000a4ac2be3): kobject_uevent_env
kobject: 'loop4' (00000000a4ac2be3): fill_kobj_path: path  
= '/devices/virtual/block/loop4'
kobject: 'loop5' (00000000522745e2): kobject_uevent_env
kobject: 'loop5' (00000000522745e2): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
kobject: 'loop3' (00000000f8ccfb34): kobject_uevent_env
kobject: 'loop3' (00000000f8ccfb34): fill_kobj_path: path  
= '/devices/virtual/block/loop3'


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
