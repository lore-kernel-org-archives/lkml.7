Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F467C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C3720652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 04:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfLJE0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 23:26:12 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:46467 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbfLJE0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 23:26:09 -0500
Received: by mail-il1-f197.google.com with SMTP id s85so13438659ild.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 20:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dIyJGQ3B3clY9DtQmNbtYZwIFkxAsZhR+iSPfPXlII0=;
        b=CKt0eHnY2UTVHq0VYgBtnU4OEnysQyDBNnM9rcgejOyaLdwmkgPJzINm2vKrWXzYXd
         zIaUz3xUhBExRqC8UV6FXB8OXi/d3Y2dEYEgQRx5zqmA+zFO3fLM4pUAYa7nl3gXqtoY
         Wres7IC+2txubWPzBtPJ164efyU9e9Gxak6DeAwMtEU2zxgzsbgnMj5ahM9scO9m2S5b
         UJln59UM7znYgxyH6gZwr8SSBfBqesvX8KmzVFzDfi8CXwMD0faDelnVM4tX1SLDTU8H
         jRsRMHr+n64w1XQ/yosEul0SEMfO0cWHjCWbOAMJKRZcahCskC3+b6q00G4GvqB13Eda
         XZGg==
X-Gm-Message-State: APjAAAUS0kuuPTlGJF2DY4n3LOoNNaVT9LxlOPdc7Gt19o7Hj5Q+Lzfz
        BldAlII027I9y87b9k84vMeF+sai2Rn50XCywi/6gRckTi+Y
X-Google-Smtp-Source: APXvYqyZVf+qEL5eXjQ+tURaI6HmSW7Qv83MNMLwuQC1DxTt3dQrnPV/EYK9HIvwRLYhEmLbufFgnKBJg/TMPE5joMeKseE8+Y8h
MIME-Version: 1.0
X-Received: by 2002:a6b:fc01:: with SMTP id r1mr9849017ioh.33.1575951968510;
 Mon, 09 Dec 2019 20:26:08 -0800 (PST)
Date:   Mon, 09 Dec 2019 20:26:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000442b12059951e9f7@google.com>
Subject: general protection fault in fbcon_modechanged
From:   syzbot <syzbot+d396a0ae28ab4507bc89@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, daniel.thompson@linaro.org,
        daniel.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
        ghalat@redhat.com, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        sam@ravnborg.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e42617b8 Linux 5.5-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15229c2ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3754e2c78c1adb82
dashboard link: https://syzkaller.appspot.com/bug?extid=d396a0ae28ab4507bc89
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d396a0ae28ab4507bc89@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 24279 Comm: syz-executor.0 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:fbcon_modechanged+0xeb/0x790 drivers/video/fbdev/core/fbcon.c:2967
Code: 8d 14 ff 4c 8b 2c d5 80 19 10 8c 48 ba 00 00 00 00 00 fc ff df 49 8d  
85 7c 03 00 00 48 89 c1 48 89 45 c8 83 e0 07 48 c1 e9 03 <0f> b6 14 11 38  
c2 7f 08 84 d2 0f 85 61 05 00 00 41 0f b6 b5 7c 03
RSP: 0018:ffffc90002b27828 EFLAGS: 00010207
RAX: 0000000000000004 RBX: ffff888218cc2400 RCX: 000000000000006f
RDX: dffffc0000000000 RSI: ffffffff83b22859 RDI: ffffffff8c102af0
RBP: ffffc90002b27878 R08: ffff888093236040 R09: ffffed1015d2703d
R10: ffffed1015d2703c R11: ffff8880ae9381e3 R12: ffff888218d25000
R13: 0000000000000000 R14: ffff888218d25468 R15: 000000000000003e
FS:  0000000000000000(0000) GS:ffff8880ae900000(0063) knlGS:00000000f5de3b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000000812a0f0 CR3: 000000008f8fb000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  fbcon_update_vcs+0x42/0x50 drivers/video/fbdev/core/fbcon.c:3038
  fb_set_var+0xb32/0xdd0 drivers/video/fbdev/core/fbmem.c:1051
  do_fb_ioctl+0x390/0x7d0 drivers/video/fbdev/core/fbmem.c:1104
  fb_compat_ioctl+0x305/0xc50 drivers/video/fbdev/core/fbmem.c:1310
  __do_compat_sys_ioctl fs/compat_ioctl.c:214 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:142 [inline]
  __ia32_compat_sys_ioctl+0x233/0x610 fs/compat_ioctl.c:142
  do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
  do_fast_syscall_32+0x27b/0xe16 arch/x86/entry/common.c:408
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fe7a39
Code: 00 00 00 89 d3 5b 5e 5f 5d c3 b8 80 96 98 00 eb c4 8b 04 24 c3 8b 1c  
24 c3 8b 34 24 c3 8b 3c 24 c3 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f5de30cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000004601
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 500a2104f8ca30f5 ]---
RIP: 0010:fbcon_modechanged+0xeb/0x790 drivers/video/fbdev/core/fbcon.c:2967
Code: 8d 14 ff 4c 8b 2c d5 80 19 10 8c 48 ba 00 00 00 00 00 fc ff df 49 8d  
85 7c 03 00 00 48 89 c1 48 89 45 c8 83 e0 07 48 c1 e9 03 <0f> b6 14 11 38  
c2 7f 08 84 d2 0f 85 61 05 00 00 41 0f b6 b5 7c 03
RSP: 0018:ffffc90002b27828 EFLAGS: 00010207
RAX: 0000000000000004 RBX: ffff888218cc2400 RCX: 000000000000006f
RDX: dffffc0000000000 RSI: ffffffff83b22859 RDI: ffffffff8c102af0
RBP: ffffc90002b27878 R08: ffff888093236040 R09: ffffed1015d2703d
R10: ffffed1015d2703c R11: ffff8880ae9381e3 R12: ffff888218d25000
R13: 0000000000000000 R14: ffff888218d25468 R15: 000000000000003e
FS:  0000000000000000(0000) GS:ffff8880ae900000(0063) knlGS:00000000f5de3b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000000bf2fd0 CR3: 000000008f8fb000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
