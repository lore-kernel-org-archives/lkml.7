Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465B3C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146332077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 12:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfLIMBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 07:01:13 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:56902 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIMBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 07:01:10 -0500
Received: by mail-il1-f200.google.com with SMTP id 12so2249143iln.23
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 04:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SJ0GVzmPAzOvq+6N9VK8hhI7We1ywTvlvBhVQeJpAKE=;
        b=NI6BiSElRLEpRuCVjwrN5xET+BBah/k7+Gouab8fGNkR1FGgcteIRVNLxgh8v9t1kM
         nZyzNoLnQefdsWHvjTq+UqB15Du1K95gC+XdjV7+U5+HMY+ByEcCMjyKKOGb+ARIdcC3
         ShTrCTOmcPdB7XVxop94mKlvY04Ehhuoa/S9mdMKnXre6dOBah8dq/bmHTm66GS/g+Wx
         KYlFIbeNQZ0PGZuD7bzxx50g4L6PY3D7xeiLI6dNaTgUgYJKI23zpO3FakEsz1hgmopY
         VbcjHzMySuLn2ZZH0q1sp6vKOZQ3oFYZqN9R7WQh67BgPnMYXc9Ym4C9K2zFeLzRHkKr
         Qqsw==
X-Gm-Message-State: APjAAAU9eebvBkNp4bqkiipGZl7ZifaJWKbK3byQrM4KFgQ0oeDCR1GG
        ssucC3YhLv+uSVq0W/38dyPiJz7U6BW2YjQgQasMYRZ6h/q0
X-Google-Smtp-Source: APXvYqz91Jk5yn/EGeVk0NMY0mEPQ1f+W2uDC8Twg0bPAI05wsfEWQvGj1aSoGlPEEh50Wq0SROqVWQ383pN3Z72Zsh8bJxY4xQq
MIME-Version: 1.0
X-Received: by 2002:a5e:8612:: with SMTP id z18mr21197713ioj.206.1575892869013;
 Mon, 09 Dec 2019 04:01:09 -0800 (PST)
Date:   Mon, 09 Dec 2019 04:01:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a968ef059944263f@google.com>
Subject: BUG: unable to handle kernel paging request in do_con_trol
From:   syzbot <syzbot+9bce437b96dc287eafef@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net,
        okash.khawaja@gmail.com, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e42617b8 Linux 5.5-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13faf42ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3754e2c78c1adb82
dashboard link: https://syzkaller.appspot.com/bug?extid=9bce437b96dc287eafef
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9bce437b96dc287eafef@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 000000010000000e
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD a1d07067 P4D a1d07067 PUD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 29889 Comm: syz-executor.5 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:csi_K drivers/tty/vt/vt.c:1558 [inline]
RIP: 0010:do_con_trol+0x47ea/0x61b0 drivers/tty/vt/vt.c:2370
Code: 08 2c 01 0f 8e b1 00 00 00 4c 8b bd 08 ff ff ff 48 63 db 44 89 e9 41  
0f b7 84 24 c8 03 00 00 48 01 db d1 e9 49 01 df 4c 89 ff <f3> 66 ab 49 8d  
bc 24 78 04 00 00 b8 ff ff 37 00 48 89 fa 48 c1 e0
RSP: 0018:ffffc90001ce78b0 EFLAGS: 00010202
RAX: 0000000000000720 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 1ffff11004ead679 RSI: ffffffff83e103ed RDI: 000000010000000e
RBP: ffffc90001ce79d0 R08: ffff8880a7f8e5c0 R09: ffff8880a7f8ee50
R10: fffffbfff14f3330 R11: ffffffff8a799987 R12: ffff88802756b000
R13: 0000000000000002 R14: 0000000000000001 R15: 000000010000000e
FS:  00007f76d2ea3700(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 0000000098d0a000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  do_con_write.part.0+0xfd9/0x1ef0 drivers/tty/vt/vt.c:2797
  do_con_write drivers/tty/vt/vt.c:2565 [inline]
  con_write+0x46/0xd0 drivers/tty/vt/vt.c:3135
  process_output_block drivers/tty/n_tty.c:595 [inline]
  n_tty_write+0x40e/0x1080 drivers/tty/n_tty.c:2333
  do_tty_write drivers/tty/tty_io.c:962 [inline]
  tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
  __vfs_write+0x8a/0x110 fs/read_write.c:494
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a6f9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f76d2ea2c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a6f9
RDX: 0000000000000003 RSI: 0000000020000200 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f76d2ea36d4
R13: 00000000004cbbaf R14: 00000000004e5858 R15: 00000000ffffffff
Modules linked in:
CR2: 000000010000000e
---[ end trace 2efe1884df5826e9 ]---
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:csi_K drivers/tty/vt/vt.c:1558 [inline]
RIP: 0010:do_con_trol+0x47ea/0x61b0 drivers/tty/vt/vt.c:2370
Code: 08 2c 01 0f 8e b1 00 00 00 4c 8b bd 08 ff ff ff 48 63 db 44 89 e9 41  
0f b7 84 24 c8 03 00 00 48 01 db d1 e9 49 01 df 4c 89 ff <f3> 66 ab 49 8d  
bc 24 78 04 00 00 b8 ff ff 37 00 48 89 fa 48 c1 e0
RSP: 0018:ffffc90001ce78b0 EFLAGS: 00010202
RAX: 0000000000000720 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 1ffff11004ead679 RSI: ffffffff83e103ed RDI: 000000010000000e
RBP: ffffc90001ce79d0 R08: ffff8880a7f8e5c0 R09: ffff8880a7f8ee50
R10: fffffbfff14f3330 R11: ffffffff8a799987 R12: ffff88802756b000
R13: 0000000000000002 R14: 0000000000000001 R15: 000000010000000e
FS:  00007f76d2ea3700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001eaad40 CR3: 0000000098d0a000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
