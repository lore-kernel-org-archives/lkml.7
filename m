Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49303C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2271421848
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 12:30:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731265AbfKFMaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 07:30:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:45272 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbfKFMaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 07:30:10 -0500
Received: by mail-il1-f197.google.com with SMTP id n84so21350677ila.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 04:30:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=iRhI5NwnBLucK2zozAdK0bz0+ws3CagjTnecUEM3SuU=;
        b=ObLmYGUtp1QEGBF+hl5ACBA0WrP/eYrRPePLkCw64LGgwGws/Gk8stAlaUiOZZ1pOV
         5CF9mYqfyPjGcW0wJQnVoouEt7PRPZi4Ydf20EnMvd+DiffYfP5WorPfpIKvulY0T31P
         S6gtkDe6dlwOEQU9WyTymhEsKz+CbOIU26lgyWrjpm7s+UmIEVQOeQeVoPD6lcFlqOtK
         Ngw1MyDi7ivN88T2itlc4woHUKguxNOWkLFOb1J32bDnyNpoldxMSxfxxBs4jvdU6ziO
         m/iOHcjI1oHDri33KTYeaFnchEgsLiNEeG2vNFypHCxDZOn8L+ho29yV+OUGzyLjLWMk
         vVRg==
X-Gm-Message-State: APjAAAV5qz3IaP2nYfXDOADtINLoLH69GrccAq/uPxdkmQMl/avSMWYH
        e/eQk8vHm8gwA6AySif4lnsyvItZEHyxfohVQlLUgIMj0QWY
X-Google-Smtp-Source: APXvYqyugGD4OFrvktm1f/c9de8OeBgencviDpDWhJjtAxOyUpp629Pyg+KPjHDS8+yGrqEJt6HcrXRA6lDQDJjRcf7MiFynny/C
MIME-Version: 1.0
X-Received: by 2002:a6b:3b50:: with SMTP id i77mr8192919ioa.241.1573043409910;
 Wed, 06 Nov 2019 04:30:09 -0800 (PST)
Date:   Wed, 06 Nov 2019 04:30:09 -0800
In-Reply-To: <000000000000b2de3a0594d8b4ca@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa02cb0596acb5fc@google.com>
Subject: Re: WARNING in drm_mode_createblob_ioctl
From:   syzbot <syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        dvyukov@google.com, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    51309b9d Add linux-next specific files for 20191105
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f5c078e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9b1a641c1f1fc52
dashboard link: https://syzkaller.appspot.com/bug?extid=fb77e97ebf0612ee6914
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1212dc3ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145f604ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fb77e97ebf0612ee6914@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8842 at include/linux/thread_info.h:150  
check_copy_size include/linux/thread_info.h:150 [inline]
WARNING: CPU: 0 PID: 8842 at include/linux/thread_info.h:150 copy_from_user  
include/linux/uaccess.h:143 [inline]
WARNING: CPU: 0 PID: 8842 at include/linux/thread_info.h:150  
drm_mode_createblob_ioctl+0x398/0x490 drivers/gpu/drm/drm_property.c:800
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8842 Comm: syz-executor938 Not tainted 5.4.0-rc6-next-20191105  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x35 kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:check_copy_size include/linux/thread_info.h:150 [inline]
RIP: 0010:copy_from_user include/linux/uaccess.h:143 [inline]
RIP: 0010:drm_mode_createblob_ioctl+0x398/0x490  
drivers/gpu/drm/drm_property.c:800
Code: c1 ea 03 80 3c 02 00 0f 85 ed 00 00 00 49 89 5d 00 e8 0c f2 c6 fd 4c  
89 f7 e8 24 af aa 03 31 c0 e9 75 fd ff ff e8 f8 f1 c6 fd <0f> 0b e8 f1 f1  
c6 fd 4d 85 e4 b8 f2 ff ff ff 0f 84 5b fd ff ff 89
RSP: 0018:ffff8880a5e07aa8 EFLAGS: 00010293
RAX: ffff88809f3a0440 RBX: ffff8880a387c000 RCX: ffffffff83ac75e2
RDX: 0000000000000000 RSI: ffffffff83ac77a8 RDI: 0000000000000007
RBP: ffff8880a5e07ae8 R08: ffff88809f3a0440 R09: ffffed101470f910
R10: ffffed101470f90f R11: ffff8880a387c87f R12: ffffc90005f5d000
R13: ffff8880a4d78000 R14: 0000000096e170d0 R15: ffffc90005f5d058
  drm_ioctl_kernel+0x244/0x300 drivers/gpu/drm/drm_ioctl.c:786
  drm_ioctl+0x54e/0xa60 drivers/gpu/drm/drm_ioctl.c:886
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x449659
Code: e8 fc b8 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab d6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f6951f91db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dac38 RCX: 0000000000449659
RDX: 0000000020000000 RSI: ffffffffffffffbd RDI: 0000000000000004
RBP: 00000000006dac30 R08: 00007f6951f92700 R09: 0000000000000000
R10: 00007f6951f92700 R11: 0000000000000246 R12: 00000000006dac3c
R13: 00007ffeae0e7e9f R14: 00007f6951f929c0 R15: 20c49ba5e353f7cf
Kernel Offset: disabled
Rebooting in 86400 seconds..

