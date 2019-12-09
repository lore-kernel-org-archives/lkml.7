Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C418C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7496C2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfLIMBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:01:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:53586 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfLIMBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:01:09 -0500
Received: by mail-il1-f197.google.com with SMTP id d3so11415913ilg.20
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 04:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/5KO4nUeYu8oKg0JMtTVjDN33PVQp5q5hi7dGA2Dw+E=;
        b=m3ekXLJYc4Q0MhYlxiAmLNlEkJ0+BDKLLdD0gcRZevpw8r7irlkjKK2oz4fo4yQx18
         daoyK0ipKRislhaLaypgkH40heZPiOXKmEaAVPz4tA7W+aH3JS5KNuarFn/aaAUlZmOh
         owY1BwOu7SLMcRiKXvYJ6uOXsC+n9qh58T58YalEYo070iC9Qtj30rQmQMUL1C3MHhRu
         g2Igo2ZWEcC1RjIqVtSFzF7cItY23U9eb6s1STo3jlD3VPTKkt0e9H4+W4gCSwBLqxVB
         aahMcX0lX9Sy8Y48WSHF8lmfsea/1AaRA/43laMYIuNky3hIsOzC+b8ioqybRP5RqFJf
         W14g==
X-Gm-Message-State: APjAAAUaPUBG8Y+X6Uf1CFH1WoO3o8JInIEbx8mvLmPiJuOWaCRmjxRc
        K538cTOV9m2q4lG2pD2SID/wiuYYt9g9j8wCyRq0t4BiDmzv
X-Google-Smtp-Source: APXvYqzBxWu+RmcQ2MNK/kctsW7tqs/FL8kvc71wAUOguT1glbySNTrZ/djfQYKZ6PEnxFw5501mtlu/6hJrAqkhJqqkIy1S6LzP
MIME-Version: 1.0
X-Received: by 2002:a92:9951:: with SMTP id p78mr10429663ili.208.1575892869300;
 Mon, 09 Dec 2019 04:01:09 -0800 (PST)
Date:   Mon, 09 Dec 2019 04:01:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adca7b0599442690@google.com>
Subject: general protection fault in fbcon_fb_blanked
From:   syzbot <syzbot+f457c8344e5a2a121e78@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, ghalat@redhat.com,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eea2d5da Merge tag 'for-linus' of git://git.armlinux.org.u..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1785042ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f07a23020fd7d21a
dashboard link: https://syzkaller.appspot.com/bug?extid=f457c8344e5a2a121e78
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f457c8344e5a2a121e78@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 12067 Comm: syz-executor.2 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fbcon_fb_blanked+0xe5/0x260 drivers/video/fbdev/core/fbcon.c:3272
Code: 0f 85 79 01 00 00 48 8d 04 db 4c 8b 3c c5 80 79 0f 8c 48 b8 00 00 00  
00 00 fc ff df 49 8d bf 7c 03 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 21 01 00 00
RSP: 0018:ffffc9000169fa30 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 000000000000003e RCX: ffffc9000dbd6000
RDX: 000000000000006f RSI: ffffffff83b2430a RDI: 000000000000037c
RBP: ffffc9000169fa60 R08: ffff8880a702c240 R09: ffffed10147fc003
R10: ffffc9000169fa60 R11: ffff8880a3fe0017 R12: ffff8880a3fe0000
R13: ffff8880a3f05400 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fe327bd5700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000400200 CR3: 0000000058b49000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  do_fb_ioctl+0x18b/0x7d0 drivers/video/fbdev/core/fbmem.c:1158
  fb_ioctl+0xe6/0x130 drivers/video/fbdev/core/fbmem.c:1180
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a6f9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe327bd4c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a6f9
RDX: 0000000000000000 RSI: 0000000000004611 RDI: 0000000000000004
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe327bd56d4
R13: 00000000004d09d8 R14: 00000000004dc698 R15: 00000000ffffffff
Modules linked in:
---[ end trace d8165df606abdd16 ]---
RIP: 0010:fbcon_fb_blanked+0xe5/0x260 drivers/video/fbdev/core/fbcon.c:3272
Code: 0f 85 79 01 00 00 48 8d 04 db 4c 8b 3c c5 80 79 0f 8c 48 b8 00 00 00  
00 00 fc ff df 49 8d bf 7c 03 00 00 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48  
89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 21 01 00 00
RSP: 0018:ffffc9000169fa30 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 000000000000003e RCX: ffffc9000dbd6000
RDX: 000000000000006f RSI: ffffffff83b2430a RDI: 000000000000037c
RBP: ffffc9000169fa60 R08: ffff8880a702c240 R09: ffffed10147fc003
R10: ffffc9000169fa60 R11: ffff8880a3fe0017 R12: ffff8880a3fe0000
R13: ffff8880a3f05400 R14: 0000000000000000 R15: 0000000000000000
FS:  00007fe327bd5700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa2ff0a3db8 CR3: 0000000058b49000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
