Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA898C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DEE3208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729287AbfICMIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:08:47 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:33590 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbfICMIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:08:12 -0400
Received: by mail-io1-f69.google.com with SMTP id 5so22859755ion.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 05:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ufskAussPh0U+0iuwMt9h1YK9P3m4VpUKAVXjfgSIKo=;
        b=Hn6OJH2wuxclGluppZ55C2I5imqkqzTuxZlqoDW7+JYrGigxNjzlDPm9NPRGqDTcoT
         dZ1Oy8A6cKYSWQ7XAXQCJVoLcM3v3OlvWL4jpMfdLnw6MwkMYwUpDBdVXXeWyg8AY251
         4DEzObt3rnyedp/kiel+dTIXZW18EZNXVMdMQhsU/8iXcyB+x+rOMJf4Qq9NbMzDCUgl
         Vy+e53eABpc0jDYA+uIvK6lUHOSQ/nm/HKoIpz94/2sAqSTE8mjezJjbeo9U77xUWt1G
         F0ML6+vyrJnKEsmHZq4I4ChfnSmAEPXEoI/n8uT0GudQl+SLEforcsQoahERtsw4AnBA
         02MA==
X-Gm-Message-State: APjAAAXV/7z8kQ1Dy0Wpp+JKSMP2KOtwb7wnpgtye0cL69ThV8AxYu71
        W9QaMFUbUr8ymQBz3aDKTz+m2yEIeXxR4kXoDWQySSgjMSmo
X-Google-Smtp-Source: APXvYqxF+89rFho6bmGYQ/vrHVDtNtGErWijaAEretAzIBl5jhyENrNzLDva5Q1XaZwitY+fZjjkPp212tb8bsjq1T5oRemcwxrq
MIME-Version: 1.0
X-Received: by 2002:a02:a99d:: with SMTP id q29mr38592616jam.80.1567512491480;
 Tue, 03 Sep 2019 05:08:11 -0700 (PDT)
Date:   Tue, 03 Sep 2019 05:08:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c64c70591a4f141@google.com>
Subject: general protection fault in usb_autopm_put_interface
From:   syzbot <syzbot+3b6d4df4497100308c69@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=165e551e600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6d4df4497100308c69
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3b6d4df4497100308c69@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 0 PID: 8426 Comm: syz-executor.3 Not tainted 5.3.0-rc5+ #28
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:usb_autopm_put_interface+0x23/0x90 drivers/usb/core/driver.c:1629
Code: 1f 84 00 00 00 00 00 55 53 48 89 fb 48 83 ec 08 e8 b2 fa ee fd 48 8d  
7b 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
42 48 8b 6b 70 e8 6e ec e0 fd 48 ba 00 00 00 00 00
RSP: 0018:ffff8881cf9e7d98 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff84633936
RDX: 000000000000000e RSI: ffffffff834edf2e RDI: 0000000000000070
RBP: ffff8881ca020000 R08: ffff8881c7ec0000 R09: ffffed10398ed3bb
R10: ffffed10398ed3ba R11: ffff8881cc769dd7 R12: 0000000000000000
R13: ffffffff89a84fe8 R14: 0000000000000246 R15: ffff8881c7e13718
FS:  0000555556d07940(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ff21000 CR3: 00000001d3e92000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  usbhid_power+0xb8/0xe0 drivers/hid/usbhid/hid-core.c:1238
  hid_hw_power include/linux/hid.h:1038 [inline]
  drop_ref.part.0+0xa5/0xe0 drivers/hid/hidraw.c:338
  drop_ref drivers/hid/hidraw.c:360 [inline]
  hidraw_release+0x34f/0x440 drivers/hid/hidraw.c:356
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x413561
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffd906f2400 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000413561
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000001 R08: 0000000055395a94 R09: 0000000055395a98
R10: 00007ffd906f24e0 R11: 0000000000000293 R12: 000000000075bf20
R13: 000000000006c6a9 R14: 0000000000764788 R15: ffffffffffffffff
Modules linked in:
---[ end trace 4e657ab43d479d9c ]---
RIP: 0010:usb_autopm_put_interface+0x23/0x90 drivers/usb/core/driver.c:1629
Code: 1f 84 00 00 00 00 00 55 53 48 89 fb 48 83 ec 08 e8 b2 fa ee fd 48 8d  
7b 70 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75  
42 48 8b 6b 70 e8 6e ec e0 fd 48 ba 00 00 00 00 00
RSP: 0018:ffff8881cf9e7d98 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff84633936
RDX: 000000000000000e RSI: ffffffff834edf2e RDI: 0000000000000070
RBP: ffff8881ca020000 R08: ffff8881c7ec0000 R09: ffffed10398ed3bb
R10: ffffed10398ed3ba R11: ffff8881cc769dd7 R12: 0000000000000000
R13: ffffffff89a84fe8 R14: 0000000000000246 R15: ffff8881c7e13718
FS:  0000555556d07940(0000) GS:ffff8881db200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2ff21000 CR3: 00000001d3e92000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
