Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B1EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E73214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKKQjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:39:11 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:42286 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfKKQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:39:10 -0500
Received: by mail-io1-f70.google.com with SMTP id w1so13898512ioj.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 08:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/zegXvvBfn/8NivNj035Ns8LaxibNFZ37GX89KDpfAE=;
        b=ICStBEAHuTC11SBCE0wKQHEI2YT9FufhjmwqQAnEc28EwvBn2fUX64/2vLmxjmFHig
         OYFffe/XJTFTnBo3QGkeSU+xiMsUCupAXoHYqUQ7/MD3TcLor/LfgavGK4gaLNgyumEF
         csfLfFaaukf/DHPAd9qkwy4D91BcBeqFKcWLEssmqyB2UZ7UCEuZLRkoUIQ1GB8gy/Jh
         BniDoyyMruj0M/wFlnATXrjFl7w+fh37byYQeDauMKzvleSH8QIE82UsonQKAFzIqBKo
         a/uDX3g/QHuMGg1ogzXw3c3BzIyRWecf0yfyLqhmxDaOUlod8e/uBTkrkQLMtlJtNnMX
         MCjw==
X-Gm-Message-State: APjAAAXCZHNkZQ7AycxJi/7EsdQ4VcXU5+arygiRFcMAuG5d/R+cLJRl
        qaU5uEGtolmqqa+r+EAHsBRctsa0nHmsYDosKCvusvEmjcOb
X-Google-Smtp-Source: APXvYqwS23U7Ms7ca8ZBxpyqTo6oDZ7pvYAwbX+k/Eyth9OjQOdRvrGIRum6xPhd68VpRe/eantNLetTzJSDEisBjiZqx9BOoDu9
MIME-Version: 1.0
X-Received: by 2002:a05:6602:228e:: with SMTP id d14mr13854303iod.122.1573490349867;
 Mon, 11 Nov 2019 08:39:09 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:39:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c8bdf059714c5a5@google.com>
Subject: general protection fault in snd_timer_open
From:   syzbot <syzbot+7a0ab45b9c1dc81c9e6b@syzkaller.appspotmail.com>
To:     alexandre.belloni@bootlin.com, allison@lohutok.net,
        alsa-devel@alsa-project.org, enric.balletbo@collabora.com,
        gregkh@linuxfoundation.org, kirr@nexedi.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6980b7f6 Add linux-next specific files for 20191111
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=149fae72e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2af7db1972ec750e
dashboard link: https://syzkaller.appspot.com/bug?extid=7a0ab45b9c1dc81c9e6b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7a0ab45b9c1dc81c9e6b@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 26749 Comm: syz-executor.4 Not tainted 5.4.0-rc6-next-20191111  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:snd_timer_check_master sound/core/timer.c:228 [inline]
RIP: 0010:snd_timer_open+0x943/0x1150 sound/core/timer.c:326
Code: 48 89 85 58 ff ff ff 4c 89 f0 48 c1 e8 03 4c 01 e8 48 89 85 50 ff ff  
ff eb 36 e8 38 1e ee fb 48 8d 7b 78 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00  
0f 85 f4 05 00 00 48 8b 43 78 49 89 dc 48 83 e8 78
RSP: 0018:ffff888057d978f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffff88 RCX: ffffc9000e7ad000
RDX: 0000000000007655 RSI: ffffffff85855cd8 RDI: 0000000000000000
RBP: ffff888057d979c0 R08: ffff8880a180c240 R09: ffff8880a1b0f008
R10: ffffed1014361e08 R11: ffff8880a1b0f047 R12: ffff8880a8f40000
R13: dffffc0000000000 R14: ffff888097688600 R15: ffffffff00000002
FS:  00007f1c13a0a700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000075c000 CR3: 000000009f897000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  snd_seq_timer_open+0x27f/0x590 sound/core/seq/seq_timer.c:281
  queue_use+0xf1/0x270 sound/core/seq/seq_queue.c:489
  snd_seq_queue_alloc+0x2c5/0x4d0 sound/core/seq/seq_queue.c:176
  snd_seq_ioctl_create_queue+0xb0/0x330 sound/core/seq/seq_clientmgr.c:1548
  snd_seq_ioctl+0x21e/0x3e0 sound/core/seq/seq_clientmgr.c:2157
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a219
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f1c13a09c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a219
RDX: 00000000200001c0 RSI: 00000000c08c5332 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f1c13a0a6d4
R13: 00000000004ceed0 R14: 00000000004d93d0 R15: 00000000ffffffff
Modules linked in:
---[ end trace fd34b5665372895c ]---
RIP: 0010:snd_timer_check_master sound/core/timer.c:228 [inline]
RIP: 0010:snd_timer_open+0x943/0x1150 sound/core/timer.c:326
Code: 48 89 85 58 ff ff ff 4c 89 f0 48 c1 e8 03 4c 01 e8 48 89 85 50 ff ff  
ff eb 36 e8 38 1e ee fb 48 8d 7b 78 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00  
0f 85 f4 05 00 00 48 8b 43 78 49 89 dc 48 83 e8 78
RSP: 0018:ffff888057d978f8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffffffffffff88 RCX: ffffc9000e7ad000
RDX: 0000000000007655 RSI: ffffffff85855cd8 RDI: 0000000000000000
RBP: ffff888057d979c0 R08: ffff8880a180c240 R09: ffff8880a1b0f008
R10: ffffed1014361e08 R11: ffff8880a1b0f047 R12: ffff8880a8f40000
R13: dffffc0000000000 R14: ffff888097688600 R15: ffffffff00000002
FS:  00007f1c13a0a700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f750abec110 CR3: 000000009f897000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
