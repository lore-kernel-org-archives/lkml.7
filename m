Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4BFC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE9D24656
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 07:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbfLMHVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 02:21:10 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:51294 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfLMHVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 02:21:09 -0500
Received: by mail-il1-f200.google.com with SMTP id x2so1323600ilk.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 23:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UBhSC4Z1qFXXc2HUBCNu4A2Q6en5x0QfWiP2o1ZOWSQ=;
        b=ezAozMyDwjq7iegYgLMt0kNOFvIzA+S5wlHl8gBvaw2eN/RAr6f35u9Pv/fPZeLulH
         W5YqU4Dr+bywwWGHRU4ToIfpkG5/io429FLZEyPiKr5dTcEZ3C0ZqD2K9LTB6FSdOYC+
         TSyOg0hCMwtt1MsHbbZTSMIbGz4EZNFXVCidlL8opVHrviaYFphJtvJ2BmAdkZUrT99z
         G8+RwBRTqnWR1GpwuInCSH0xeIuPPovM7A0lPEtXbdIVJ6xLBO/4du971uiNxACOrSft
         OobZjTv0tpaPKfD5SR+np1TdLkyytCDbuiXnPdgj1ATY0dqbrSL8GRWU95zIff6ptcdI
         4mug==
X-Gm-Message-State: APjAAAX0hLw3R0gjCE1sD6zDpY8QAq5r6S56fmtuJcxmcX5oZKTrASH6
        EJ5AWj2en8kj71Eap6ruOhfD1eWvi99f8eUxZkLU8RwlT0he
X-Google-Smtp-Source: APXvYqzKKDdtoK2MWqr9l+ar5eCKKhGAGTth0kWrsd/T2k0/rM0mMhIfPpKbRcWtAyxzqqBE7fE2iwHx91u+IqjiYLKFy4qHT1NU
MIME-Version: 1.0
X-Received: by 2002:a92:902:: with SMTP id y2mr12186015ilg.196.1576221669031;
 Thu, 12 Dec 2019 23:21:09 -0800 (PST)
Date:   Thu, 12 Dec 2019 23:21:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ab87b6059990b486@google.com>
Subject: general protection fault in fbcon_cursor
From:   syzbot <syzbot+6acf28c23c81badd89a7@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ae4b064e Merge tag 'afs-fixes-20191211' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1218c1dee00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=6acf28c23c81badd89a7
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6acf28c23c81badd89a7@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 17 Comm: kworker/1:0 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events console_callback
RIP: 0010:fbcon_cursor+0x114/0x660 drivers/video/fbdev/core/fbcon.c:1380
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e6 04 00 00 4d 8b b4 24 a0 03  
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 14 02 4c  
89 f0 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 ba
RSP: 0018:ffffc90000d8fb00 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8880a4309400 RCX: ffffffff83e01590
RDX: 000000001fffffe7 RSI: ffffffff83b2804c RDI: ffff8880a282b3a0
RBP: ffffc90000d8fb40 R08: ffff8880a9a4a480 R09: ffffed10147a3e1c
R10: ffffed10147a3e1b R11: ffff8880a3d1f0df R12: ffff8880a282b000
R13: ffff888218c76000 R14: 00000000ffffff3a R15: ffff888218c76468
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004bf9b0 CR3: 000000008e75d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  set_cursor drivers/tty/vt/vt.c:908 [inline]
  set_cursor+0x1fb/0x280 drivers/tty/vt/vt.c:899
  redraw_screen+0x4e1/0x7d0 drivers/tty/vt/vt.c:1013
  complete_change_console+0x105/0x3a0 drivers/tty/vt/vt_ioctl.c:1264
  change_console+0x19b/0x2c0 drivers/tty/vt/vt_ioctl.c:1389
  console_callback+0x3a1/0x400 drivers/tty/vt/vt.c:2824
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace a825343a1e8757e1 ]---
RIP: 0010:fbcon_cursor+0x114/0x660 drivers/video/fbdev/core/fbcon.c:1380
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e6 04 00 00 4d 8b b4 24 a0 03  
00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 f2 48 c1 ea 03 <0f> b6 14 02 4c  
89 f0 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 ba
RSP: 0018:ffffc90000d8fb00 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8880a4309400 RCX: ffffffff83e01590
RDX: 000000001fffffe7 RSI: ffffffff83b2804c RDI: ffff8880a282b3a0
RBP: ffffc90000d8fb40 R08: ffff8880a9a4a480 R09: ffffed10147a3e1c
R10: ffffed10147a3e1b R11: ffff8880a3d1f0df R12: ffff8880a282b000
R13: ffff888218c76000 R14: 00000000ffffff3a R15: ffff888218c76468
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004bf9b0 CR3: 000000008e75d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
