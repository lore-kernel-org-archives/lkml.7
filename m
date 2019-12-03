Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068DEC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06D020833
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 20:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfLCUPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 15:15:16 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:37684 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbfLCUPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 15:15:12 -0500
Received: by mail-io1-f71.google.com with SMTP id p2so3311983iof.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 12:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=375IDyMFW4MejdvoMpWS8V6PDUFkptYpRkin+xFsM7Y=;
        b=gGYCiFFr/X+wje583GQWr/EDHn5qiM8u94T68DvxVAEMSZJ/2qfywrhGCF54TRaccW
         /lWQRgY1cInzBS4ct04EGWi6uURCay550zBKcIBK8wMpMtkK/jPH2vLfgIDBL6XgnMf+
         EH81TLC8kHLhVi8NyQD+z8TiQEouw8hU+UAqi+TiH5ztvmvNec6Y7+4kZNgoFIDIQPXI
         ym3ZJDY4NxpoSi8WGzWcUcDBgaBHdsvm4xqse9fixgE6pEC0d1Aa6WYUReVEJGzAvg0t
         8iDqOWk9FfK2AKxJWbOXdR1VQM/Pr6jN1FdnpABTY6ZN2O9S5MFaOKkAavZT5JbQLJv6
         rV4w==
X-Gm-Message-State: APjAAAUer0N0KEkuf9lqnWkHUJUp5ycFH0WvCgCbObuwVEI4cZKvKsrF
        K9PHvpFBrIH5RPYuKzaTVua+DQHAloaOpsJEYV9Qiey7C2nT
X-Google-Smtp-Source: APXvYqzBiEdXZrIZ3CbPMZZZ6Hhwg/wZbA9ZrYz5Vgny9Xwb87pSklkCn3A+AD4jN/5zXbA5ePJGjE2R7JLXXgvyJwP9NNo90kaL
MIME-Version: 1.0
X-Received: by 2002:a92:9f9c:: with SMTP id z28mr6392450ilk.239.1575404111577;
 Tue, 03 Dec 2019 12:15:11 -0800 (PST)
Date:   Tue, 03 Dec 2019 12:15:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000072cb4c0598d25a69@google.com>
Subject: divide error in fbcon_switch
From:   syzbot <syzbot+13013adc4a234406c29e@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, ghalat@redhat.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1508781ee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
dashboard link: https://syzkaller.appspot.com/bug?extid=13013adc4a234406c29e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=132b742ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1568f97ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+13013adc4a234406c29e@syzkaller.appspotmail.com

divide error: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events console_callback
RIP: 0010:fbcon_update_softback drivers/video/fbdev/core/fbcon.c:378  
[inline]
RIP: 0010:fbcon_switch+0x20d/0x17f0 drivers/video/fbdev/core/fbcon.c:2247
Code: a4 3b 08 4c 89 3d 33 a4 3b 08 38 d0 7c 08 84 d2 0f 85 48 13 00 00 41  
8b 9d 3c 03 00 00 31 d2 bf 05 00 00 00 8b 05 f3 07 13 06 <f7> f3 41 89 c4  
89 c6 e8 67 48 c3 fd 41 83 fc 05 0f 8e d7 0b 00 00
RSP: 0018:ffffc90000d2f9d8 EFLAGS: 00010246
RAX: 0000000000008000 RBX: 0000000000000000 RCX: ffffffff83b1b314
RDX: 0000000000000000 RSI: ffffffff83b1b322 RDI: 0000000000000005
RBP: ffffc90000d2fb68 R08: ffff8880a9a06300 R09: fffffbfff14b0ac8
R10: fffffbfff14b0ac7 R11: ffffffff8a58563b R12: 0000000000000000
R13: ffff88809e21f000 R14: ffff8880a40fc000 R15: ffff8880a3860000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb4a5f9a000 CR3: 00000000a64af000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  redraw_screen+0x2b6/0x7d0 drivers/tty/vt/vt.c:997
  complete_change_console+0x105/0x3a0 drivers/tty/vt/vt_ioctl.c:1264
  change_console+0x19b/0x2c0 drivers/tty/vt/vt_ioctl.c:1389
  console_callback+0x3a1/0x400 drivers/tty/vt/vt.c:2824
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 074c38236abce447 ]---
RIP: 0010:fbcon_update_softback drivers/video/fbdev/core/fbcon.c:378  
[inline]
RIP: 0010:fbcon_switch+0x20d/0x17f0 drivers/video/fbdev/core/fbcon.c:2247
Code: a4 3b 08 4c 89 3d 33 a4 3b 08 38 d0 7c 08 84 d2 0f 85 48 13 00 00 41  
8b 9d 3c 03 00 00 31 d2 bf 05 00 00 00 8b 05 f3 07 13 06 <f7> f3 41 89 c4  
89 c6 e8 67 48 c3 fd 41 83 fc 05 0f 8e d7 0b 00 00
RSP: 0018:ffffc90000d2f9d8 EFLAGS: 00010246
RAX: 0000000000008000 RBX: 0000000000000000 RCX: ffffffff83b1b314
RDX: 0000000000000000 RSI: ffffffff83b1b322 RDI: 0000000000000005
RBP: ffffc90000d2fb68 R08: ffff8880a9a06300 R09: fffffbfff14b0ac8
R10: fffffbfff14b0ac7 R11: ffffffff8a58563b R12: 0000000000000000
R13: ffff88809e21f000 R14: ffff8880a40fc000 R15: ffff8880a3860000
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb4a5f9a000 CR3: 00000000a64af000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
