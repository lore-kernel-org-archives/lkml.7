Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9903C00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A07207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 11:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfLILQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:16:09 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:35009 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbfLILQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 06:16:09 -0500
Received: by mail-il1-f199.google.com with SMTP id t15so11389944ilh.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 03:16:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ajT3D1Os5iKGeC5P4Qsk03YVLFhdx/JW0RgTUFoWDIk=;
        b=nOjzfQiEnfP2HLdLpl9GLYXxStTKVcT3KnzhbprCX0XfNWkIF7iPfKkmYTU0H8CmE0
         9hdtVQMuC0eknxw98xvF7vdKh1MUMYgHTy23HfliLBOOr/tJmjq4+IsJ/Xu7xegJ4MzE
         2AKnnxTHa6qei5+G/voH0EYJsXg9XyMV5nD363DWsQsIIRSQkpFcbrAAgZDFVzj1tR22
         us2MiULfNs7vLDbdQZ4n6Gt7268O4jCxQcAM0t4mKIUFRzy8HdMD547+0/MxWzTx9z11
         MTd7Uf6qMBS2+fy0bR2V3VIsq+9uZutyce0gTSi1sdTZu5JP5/56Byq6REf3Z6hR7uY/
         G9Ig==
X-Gm-Message-State: APjAAAWh6u04JP3E0LpiFDCtVNDJc7XwL0sjelxzRGkhaRJfFrIoTmcO
        8ggNFUXO8rCWM6diG/GqdxqIoDKs2po0YX2AF55jQe33JxTz
X-Google-Smtp-Source: APXvYqwxeexU2etQ1Podf0pBdSWQY1TFMdYdF3jJGHRbmqae38yASMxPelQ3Src5x5S+FJG0YqbX4MivuUPBBG+kXhVNQBFa1Mzm
MIME-Version: 1.0
X-Received: by 2002:a92:5e4b:: with SMTP id s72mr26985910ilb.211.1575890168802;
 Mon, 09 Dec 2019 03:16:08 -0800 (PST)
Date:   Mon, 09 Dec 2019 03:16:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7773d0599438538@google.com>
Subject: BUG: unable to handle kernel paging request in drm_fb_helper_dirty_work
From:   syzbot <syzbot+8a2039467425e497e64a@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e42617b8 Linux 5.5-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126dc282e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3754e2c78c1adb82
dashboard link: https://syzkaller.appspot.com/bug?extid=8a2039467425e497e64a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a2039467425e497e64a@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffff520015a7200
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 7ffcd067 P4D 7ffcd067 PUD 2cd1c067 PMD 76d10067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 18 Comm: kworker/1:0 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS  
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events drm_fb_helper_dirty_work
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:121 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
RIP: 0010:check_memory_region+0x9c/0x1a0 mm/kasan/generic.c:192
Code: c9 4d 0f 49 c1 49 c1 f8 03 45 85 c0 0f 84 10 01 00 00 41 83 e8 01 4e  
8d 44 c0 08 eb 0d 48 83 c0 08 4c 39 c0 0f 84 a7 00 00 00 <48> 83 38 00 74  
ed 4c 8d 40 08 eb 09 48 83 c0 01 49 39 c0 74 53 80
RSP: 0018:ffffc900004cfc30 EFLAGS: 00010216
RAX: fffff520015a7200 RBX: fffff520015a7400 RCX: ffffffff83f94dec
RDX: 0000000000000001 RSI: 0000000000001000 RDI: ffffc9000ad39000
RBP: ffffc900004cfc48 R08: fffff520015a7400 R09: 0000000000000200
R10: fffff520015a73ff R11: ffffc9000ad39fff R12: fffff520015a7200
R13: ffffc9000ad39000 R14: ffffc9000a53a000 R15: ffffc9000a53a000
FS:  0000000000000000(0000) GS:ffff88802d100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff520015a7200 CR3: 0000000052ea7000 CR4: 0000000000340ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
  memcpy+0x38/0x50 mm/kasan/common.c:126
  memcpy include/linux/string.h:380 [inline]
  drm_fb_helper_dirty_blit_real drivers/gpu/drm/drm_fb_helper.c:399 [inline]
  drm_fb_helper_dirty_work+0x44c/0x780 drivers/gpu/drm/drm_fb_helper.c:428
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: fffff520015a7200
---[ end trace 1682650b38de1096 ]---
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:121 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:135 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:166 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:182 [inline]
RIP: 0010:check_memory_region+0x9c/0x1a0 mm/kasan/generic.c:192
Code: c9 4d 0f 49 c1 49 c1 f8 03 45 85 c0 0f 84 10 01 00 00 41 83 e8 01 4e  
8d 44 c0 08 eb 0d 48 83 c0 08 4c 39 c0 0f 84 a7 00 00 00 <48> 83 38 00 74  
ed 4c 8d 40 08 eb 09 48 83 c0 01 49 39 c0 74 53 80
RSP: 0018:ffffc900004cfc30 EFLAGS: 00010216
RAX: fffff520015a7200 RBX: fffff520015a7400 RCX: ffffffff83f94dec
RDX: 0000000000000001 RSI: 0000000000001000 RDI: ffffc9000ad39000
RBP: ffffc900004cfc48 R08: fffff520015a7400 R09: 0000000000000200
R10: fffff520015a73ff R11: ffffc9000ad39fff R12: fffff520015a7200
R13: ffffc9000ad39000 R14: ffffc9000a53a000 R15: ffffc9000a53a000
FS:  0000000000000000(0000) GS:ffff88802d100000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff520015a7200 CR3: 0000000052ea7000 CR4: 0000000000340ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
