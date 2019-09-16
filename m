Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C6FC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D94214DE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 13:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbfIPN3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 09:29:36 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51030 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733225AbfIPN3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 09:29:12 -0400
Received: by mail-io1-f69.google.com with SMTP id f5so12843501iob.17
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 06:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=egJ9RlFuiaHOZXvDZ4i02K/0CianNMU6PJTp1Wkrn6U=;
        b=YvNnjQjCBR3f4ZhsKM84YJsH7yUXmiEHtBSkdkqPLDXqzoxuSguV2g4Dr3yiHTl7cJ
         xamlZcc3K44nQkU6MKTWA+urVDR4PZZd0LJC4H1I1hMmBty8YoVicVTOdVbc++S7+HCe
         6XdI36gqx4PRli+Bh/XJH7Q18K+gBwws/rjgo4D+0N7shc6hC/SLacVOWHGeE40lzeIG
         ZxmH45lIVWmUZvIArTJQqKlNbJnbeVzWdcbLH4Wccyj+URyB09u/yGgQ6T0gKPJtXuQW
         16eUZeYIh3i22H/LCgUCsUkH3BrSFHbZWLIgleVz0wfn/sNTdQRpOwKCm+8KBD0WDIsg
         MUTQ==
X-Gm-Message-State: APjAAAVEenfmAXp4+wJKrIfRDsJv8bJ9UjBjUCGDb/5Iws8YLrXVaK0f
        rowbmgsI739oCOl/cCLLzQ5ENwldWgz+t+7yIhH2eP1NLnCA
X-Google-Smtp-Source: APXvYqwPAY8C2PSeu+AfTYRHsarRuhhvGYvnZQldDpncPnOCUfnCIcMFF1MaSHGKVQtq3cxFH3I4hGg0UDi9qAnTIjRo2wzkcY+z
MIME-Version: 1.0
X-Received: by 2002:a5d:9859:: with SMTP id p25mr15815937ios.142.1568640549930;
 Mon, 16 Sep 2019 06:29:09 -0700 (PDT)
Date:   Mon, 16 Sep 2019 06:29:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2531f0592ab96fb@google.com>
Subject: general protection fault in usb_set_interface
From:   syzbot <syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mans@mansr.com, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    f0df5c1b usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
console output: https://syzkaller.appspot.com/x/log.txt?x=158b66f1600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6633fa4ed00be5
dashboard link: https://syzkaller.appspot.com/bug?extid=7fa38a608b1075dfd634
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f57db9600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=127b61a5600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7fa38a608b1075dfd634@syzkaller.appspotmail.com

usb 3-1: usbvision_write_reg: failed: error -2
usbvision_set_audio: can't write iopin register for audio switching
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN
CPU: 1 PID: 1955 Comm: v4l_id Not tainted 5.3.0-rc7+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:usb_set_interface+0x34/0xa50 drivers/usb/core/message.c:1362
Code: fc 55 53 48 83 ec 40 89 54 24 18 89 74 24 10 e8 22 1c ef fd 49 8d 7c  
24 48 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 fb 08 00 00 49 8b 44 24 48 49 8d 7c 24 18 48 89
RSP: 0018:ffff8881cb19fd50 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000009 RSI: ffffffff834ebe7e RDI: 0000000000000048
RBP: ffff8881cb8e4200 R08: ffffffff88d21878 R09: ffffed103971cb43
R10: ffff8881cb19fdc8 R11: ffff8881cb8e5a17 R12: 0000000000000000
R13: ffff8881cb8e5a10 R14: ffff8881cb8e4cc8 R15: ffff8881cb8e5178
FS:  00007f4f60b6d700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f6060c330 CR3: 00000001cc3a8000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  usbvision_radio_close+0x105/0x250  
drivers/media/usb/usbvision/usbvision-video.c:1114
  v4l2_release+0x2e7/0x390 drivers/media/v4l2-core/v4l2-dev.c:455
  __fput+0x2d7/0x840 fs/file_table.c:280
  task_work_run+0x13f/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x1d2/0x200 arch/x86/entry/common.c:163
  prepare_exit_to_usermode arch/x86/entry/common.c:194 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:274 [inline]
  do_syscall_64+0x45f/0x580 arch/x86/entry/common.c:299
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f4f6069b2b0
Code: 40 75 0b 31 c0 48 83 c4 08 e9 0c ff ff ff 48 8d 3d c5 32 08 00 e8 c0  
07 02 00 83 3d 45 a3 2b 00 00 75 10 b8 03 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 73 31 c3 48 83 ec 08 e8 ce 8a 01 00 48 89 04 24
RSP: 002b:00007ffde2d50ee8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007f4f6069b2b0
RDX: 00007f4f60951df0 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f4f60951df0 R09: 000000000000000a
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000400884
R13: 00007ffde2d51040 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 62bd2b7512ab49ee ]---
RIP: 0010:usb_set_interface+0x34/0xa50 drivers/usb/core/message.c:1362
Code: fc 55 53 48 83 ec 40 89 54 24 18 89 74 24 10 e8 22 1c ef fd 49 8d 7c  
24 48 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 fb 08 00 00 49 8b 44 24 48 49 8d 7c 24 18 48 89
RSP: 0018:ffff8881cb19fd50 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000009 RSI: ffffffff834ebe7e RDI: 0000000000000048
RBP: ffff8881cb8e4200 R08: ffffffff88d21878 R09: ffffed103971cb43
R10: ffff8881cb19fdc8 R11: ffff8881cb8e5a17 R12: 0000000000000000
R13: ffff8881cb8e5a10 R14: ffff8881cb8e4cc8 R15: ffff8881cb8e5178
FS:  00007f4f60b6d700(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4f6060c330 CR3: 00000001cc3a8000 CR4: 00000000001406e0
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
