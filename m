Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4C5C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD0E20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbfCGXmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:42:07 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:43625 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGXmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:42:06 -0500
Received: by mail-io1-f72.google.com with SMTP id x22so14137968iob.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=vignibn2W+OI+kWbg6mB9Vrsv1VhCbzj6ULrA6+bXs8=;
        b=GXGk/Kn19HNMXwqP0r56quvoqmoktbErDSzG6cjJQHJhY8SvNaZU7KN9ts5Zt8w5so
         SIAzGZ+qx4G/bEtHDd0Su/Il8DTgw26gVgyjh+G/5lGH07bE4WWd+C0VIRWXMbq/qps7
         hUfMHlyx12bQr+wXWIkHm37FscMoZtTrO/YsS4XQ5afcDQyMeV4/4m83C1voTEwSjbEq
         28TwG98D6OEdEk5b+DtfXGAaw4vu7GAWjrAMNBdYzK9QIUUEOXXSYgIMZiL8uYz1rQf1
         3Umz3Fc1KjsosRLnnj2QKCBKwYfdhXAk88oc9ORWUIpYfleFLPdzNe8JMgSd7QEMkiDq
         KzRg==
X-Gm-Message-State: APjAAAXRFdzbGIayec4MteMfx1kY8VQyqJT6qM6EZlceKaJVut7tuYT9
        XrGWRzlguh3Cu8637ZZOqv55XXCz30U7CkpZVLruY8xmWLpa
X-Google-Smtp-Source: APXvYqx+6ctk+8L2//NNVP8RxFfagUYsHbLWxlXq8PBndXY+dCG16a0Xuglxahlb4iqNp5C4cCvFgUROTXRxl1zx9fpid0V3FWg5
MIME-Version: 1.0
X-Received: by 2002:a02:31d:: with SMTP id y29mr9384941jad.18.1552002124879;
 Thu, 07 Mar 2019 15:42:04 -0800 (PST)
Date:   Thu, 07 Mar 2019 15:42:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000581fa9058389a78d@google.com>
Subject: WARNING in __flush_work (2)
From:   syzbot <syzbot+03bd8ee354763fad396d@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        gustavo.padovan@collabora.com, hamohammed.sa@gmail.com,
        linux-kernel@vger.kernel.org, mahesh1.kumar@intel.com,
        rodrigosiqueiramelo@gmail.com, seanpaul@chromium.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1fc1cd8399ab Merge branch 'for-5.1' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10dab41b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=83f72881c3c30b7c
dashboard link: https://syzkaller.appspot.com/bug?extid=03bd8ee354763fad396d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15186357200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1502c533200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+03bd8ee354763fad396d@syzkaller.appspotmail.com

kauditd_printk_skb: 3 callbacks suppressed
audit: type=1400 audit(1552001909.747:35): avc:  denied  { map } for   
pid=8034 comm="bash" path="/bin/bash" dev="sda1" ino=1457  
scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=system_u:object_r:file_t:s0 tclass=file permissive=1
audit: type=1400 audit(1552001916.317:36): avc:  denied  { map } for   
pid=8046 comm="syz-executor642" path="/root/syz-executor642773801"  
dev="sda1" ino=16483 scontext=unconfined_u:system_r:insmod_t:s0-s0:c0.c1023  
tcontext=unconfined_u:object_r:user_home_t:s0 tclass=file permissive=1
WARNING: CPU: 0 PID: 8046 at kernel/workqueue.c:3020  
__flush_work+0x74c/0x8a0 kernel/workqueue.c:3020
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8046 Comm: syz-executor642 Not tainted 5.0.0+ #11
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
RIP: 0010:__flush_work+0x74c/0x8a0 kernel/workqueue.c:3020
Code: 74 58 e8 77 12 26 00 fb 66 0f 1f 44 00 00 45 31 e4 e9 86 fd ff ff e8  
63 12 26 00 0f 0b 45 31 e4 e9 77 fd ff ff e8 54 12 26 00 <0f> 0b 45 31 e4  
e9 68 fd ff ff e8 45 12 26 00 4c 89 ff 45 31 e4 e8
RSP: 0018:ffff888087e6f608 EFLAGS: 00010293
RAX: ffff888098292340 RBX: ffff8880a623f000 RCX: ffffffff814a14cb
RDX: 0000000000000000 RSI: ffffffff814a1b7c RDI: 0000000000000001
RBP: ffff888087e6f778 R08: ffff888098292340 R09: ffffed1010fcdedd
R10: ffffed1010fcdedc R11: 0000000000000003 R12: dffffc0000000000
R13: ffff888087e6f750 R14: 0000000000000000 R15: 0000000000000001
  flush_work+0x18/0x20 kernel/workqueue.c:3050
  vkms_atomic_crtc_destroy_state drivers/gpu/drm/vkms/vkms_crtc.c:133  
[inline]
  vkms_atomic_crtc_destroy_state+0x2d/0x40  
drivers/gpu/drm/vkms/vkms_crtc.c:125
  drm_atomic_state_default_clear+0x37c/0xd60 drivers/gpu/drm/drm_atomic.c:171
  drm_atomic_state_clear+0x9d/0xc0 drivers/gpu/drm/drm_atomic.c:240
  __drm_atomic_state_free+0x3c/0xf0 drivers/gpu/drm/drm_atomic.c:256
  kref_put include/linux/kref.h:67 [inline]
  drm_atomic_state_put include/drm/drm_atomic.h:385 [inline]
  drm_atomic_helper_set_config+0xe5/0x160  
drivers/gpu/drm/drm_atomic_helper.c:2956
  drm_mode_setcrtc+0x613/0x1490 drivers/gpu/drm/drm_crtc.c:748
  drm_ioctl_kernel+0x23b/0x2e0 drivers/gpu/drm/drm_ioctl.c:758
  drm_ioctl+0x545/0xa50 drivers/gpu/drm/drm_ioctl.c:858
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x443de9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffef4b0a4f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000443de9
RDX: 0000000020000000 RSI: 00000000c06864a2 RDI: 0000000000000003
RBP: 00000000006ce018 R08: 0000000000000000 R09: 00000000004002e0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401af0
R13: 0000000000401b80 R14: 0000000000000000 R15: 0000000000000000
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
