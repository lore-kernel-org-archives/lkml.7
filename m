Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B73C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBA62147C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfCKUmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:42:08 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:52803 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKUmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:42:07 -0400
Received: by mail-it1-f199.google.com with SMTP id z131so288246itb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 13:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=bItM+VRk6jJF0KAwdaT1c7fAc/vef/B+nUNuBS5+Pws=;
        b=Fc21SwC/knBzttm6oOByAYNF+Yb6tL9aW3G65YSy2pi/+HwSPqhwPIreWPTg5cHzKn
         A289NEqx4Oni6F0vFZX6ryk4FGEKdIS9jCIP6qOSOLGKErjp3H9E5YeAhFHez45/UAKn
         GZTPsAT5pCV4427kBlJSgFmKOWDGbR2YykD2N9noc9xY+5MJUQUmvceZwxjKtTDK9cTO
         PAPoJiKPCV5VyNTXPx2rPM9B+i6PRh1fYWCcfQPltYqUUyrJfWdyc0IYqljCp9UkmHko
         PKHs6DAfa9gvdaJPF1BEYttBejMe4rsZ/v430U+QIwAtXf++XSG4HmlK+bqpoTBgnwYi
         uaqw==
X-Gm-Message-State: APjAAAVR/qkckzTCAaIM7NTY4B1QKwK7QhtgmU1dHECGqYQjajne+kRn
        k+EJ9r4fZim4pgXAbFThds6mzHSvA9r50TYZyOrWj15HLwzI
X-Google-Smtp-Source: APXvYqxbPIFr1Mfb5vjlLrjnAaO/Uk3TTLwwI3GHCJogGZoS8MRorcajooh7DH8IjMszM5kiN3kYiOQxFOdGwYpcKiGOAUyhdazG
MIME-Version: 1.0
X-Received: by 2002:a24:37c6:: with SMTP id r189mr45971itr.13.1552336926731;
 Mon, 11 Mar 2019 13:42:06 -0700 (PDT)
Date:   Mon, 11 Mar 2019 13:42:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016f7d40583d79bd9@google.com>
Subject: WARNING: bad usercopy in fanotify_read
From:   syzbot <syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cai@lca.pw, crecklin@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    12ad143e Merge branch 'perf-urgent-for-linus' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12776f57200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9d91b7192a5e96e
dashboard link: https://syzkaller.appspot.com/bug?extid=2c49971e251e36216d1f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1287516f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ee410b200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2c49971e251e36216d1f@syzkaller.appspotmail.com

------------[ cut here ]------------
Bad or missing usercopy whitelist? Kernel memory exposure attempt detected  
from SLAB object 'fanotify_event' (offset 40, size 8)!
WARNING: CPU: 1 PID: 7649 at mm/usercopy.c:78 usercopy_warn+0xeb/0x110  
mm/usercopy.c:78
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 7649 Comm: syz-executor381 Not tainted 5.0.0+ #17
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  __warn.cold+0x20/0x45 kernel/panic.c:571
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:973
RIP: 0010:usercopy_warn+0xeb/0x110 mm/usercopy.c:78
Code: c8 e8 d9 88 c0 ff 4c 8b 45 c0 4d 89 e9 4c 89 e1 48 8b 55 c8 41 57 48  
89 de 48 c7 c7 e0 dc 74 87 ff 75 d0 41 56 e8 03 4b 93 ff <0f> 0b 48 83 c4  
18 e9 46 ff ff ff 49 c7 c5 e0 da 74 87 4d 89 ee 4d
RSP: 0018:ffff8880a417fb18 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffff8774dca0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815ad7b6 RDI: ffffed101482ff55
RBP: ffff8880a417fb70 R08: ffff888088d78580 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff8859408d
R13: ffffffff8775d500 R14: ffffffff8774db20 R15: 0000000000000008
  __check_heap_object+0x88/0xb3 mm/slab.c:4453
  check_heap_object mm/usercopy.c:238 [inline]
  __check_object_size mm/usercopy.c:284 [inline]
  __check_object_size+0x342/0x42f mm/usercopy.c:254
  check_object_size include/linux/thread_info.h:119 [inline]
  check_copy_size include/linux/thread_info.h:150 [inline]
  copy_to_user include/linux/uaccess.h:151 [inline]
  copy_fid_to_user fs/notify/fanotify/fanotify_user.c:236 [inline]
  copy_event_to_user fs/notify/fanotify/fanotify_user.c:294 [inline]
  fanotify_read+0xde0/0x1430 fs/notify/fanotify/fanotify_user.c:362
  __vfs_read+0x8d/0x110 fs/read_write.c:416
  vfs_read+0x194/0x3e0 fs/read_write.c:452
  ksys_read+0xea/0x1f0 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4456b9
Code: e8 6c b6 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2b 12 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fb296f31db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000006dac28 RCX: 00000000004456b9
RDX: 000000000000006b RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00000000006dac20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dac2c
R13: 00007ffd8eb3d16f R14: 00007fb296f329c0 R15: 20c49ba5e353f7cf
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
