Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF0C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3008215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 09:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgAFJVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 04:21:10 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:37759 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgAFJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 04:21:09 -0500
Received: by mail-il1-f199.google.com with SMTP id t19so4382515ila.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 01:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=GjNdGReWbjB9kPwSCZVvgY8hPYvlyzp2JV+wGoSvZxY=;
        b=Itwq8pmbe7/DjtHs0GpN4s6/D6uEN1GMWNCNbOHPCW0UFmu6ANdd/7Hkf6H3JFYzKC
         n+6qOiSQEeoaPNtdBJ7+1PMXMFcnqoNEQKFIyr4ktWiHhjHfAzRCIlYHTtbN2ZiNv+Vu
         qM4c5goaqSjKWp3OashTqnrXuPYKYwf3zMge+BXhkOEEaXlELm68XA8MqaDIciBuIALq
         l+RxfjdBrBc/lPPn+GK7XoRd1UOc9UpXOSa9jYzZGluRTs8EF5oNRidiBrBHHUPIkf9p
         58dmSvDXG8nJiZ0TPJQ4TUM8dLciT8K/tcBDLnB+MHoq/csveSlqmIkPSYeq1vShIuAm
         YsXQ==
X-Gm-Message-State: APjAAAULCjW256c6PgZ+EIoNeUCJfvNs3M1R6SCfh/p7l8b1h2ZC8vO1
        WAWYyU2i++d4gaXEvWTMVCZqaJ+E3f3r9h26BAuZjRBShpG8
X-Google-Smtp-Source: APXvYqzRUOYtI7Hdzhse7UC57o8mfIwW0bKPENrYOU99qtVXW/NW8DRoJoZSXNpADImK8Lv1T84Vwfl8+7RwSTd7h7XJxehJc0m6
MIME-Version: 1.0
X-Received: by 2002:a92:390c:: with SMTP id g12mr82884490ila.246.1578302468894;
 Mon, 06 Jan 2020 01:21:08 -0800 (PST)
Date:   Mon, 06 Jan 2020 01:21:08 -0800
In-Reply-To: <0000000000008731130598e35a2e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001bae8059b752ec6@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in soft_cursor
From:   syzbot <syzbot+16469b5e8e5a72e9131e@syzkaller.appspotmail.com>
To:     b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    c79f46a2 Linux 5.5-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131bcee1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42c82694f792b2f5
dashboard link: https://syzkaller.appspot.com/bug?extid=16469b5e8e5a72e9131e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1371ba56e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13423e3ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+16469b5e8e5a72e9131e@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:380 [inline]
BUG: KASAN: slab-out-of-bounds in soft_cursor+0x439/0xa30  
drivers/video/fbdev/core/softcursor.c:70
Read of size 16 at addr ffff88809fbb1740 by task syz-executor427/9732

CPU: 0 PID: 9732 Comm: syz-executor427 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memcpy+0x24/0x50 mm/kasan/common.c:125
  memcpy include/linux/string.h:380 [inline]
  soft_cursor+0x439/0xa30 drivers/video/fbdev/core/softcursor.c:70
  bit_cursor+0x12fc/0x1a60 drivers/video/fbdev/core/bitblit.c:386
  fbcon_cursor+0x487/0x660 drivers/video/fbdev/core/fbcon.c:1402
  hide_cursor+0x9d/0x2b0 drivers/tty/vt/vt.c:895
  redraw_screen+0x60b/0x7d0 drivers/tty/vt/vt.c:988
  vc_do_resize+0x10c9/0x1460 drivers/tty/vt/vt.c:1284
  vc_resize+0x4d/0x60 drivers/tty/vt/vt.c:1304
  vt_ioctl+0x2076/0x26d0 drivers/tty/vt/vt_ioctl.c:887
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440249
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdd43faf18 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440249
RDX: 0000000020000000 RSI: 000000000000560a RDI: 0000000000000004
RBP: 00000000006cb018 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401b30
R13: 0000000000401bc0 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9732:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc include/linux/slab.h:561 [inline]
  fbcon_set_font+0x32d/0x860 drivers/video/fbdev/core/fbcon.c:2663
  con_font_set drivers/tty/vt/vt.c:4538 [inline]
  con_font_op+0xe30/0x1270 drivers/tty/vt/vt.c:4603
  do_fontx_ioctl drivers/tty/vt/vt_ioctl.c:244 [inline]
  vt_ioctl+0x35a/0x26d0 drivers/tty/vt/vt_ioctl.c:930
  tty_ioctl+0xa37/0x14f0 drivers/tty/tty_io.c:2660
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:545 [inline]
  do_vfs_ioctl+0x977/0x14e0 fs/ioctl.c:732
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:749
  __do_sys_ioctl fs/ioctl.c:756 [inline]
  __se_sys_ioctl fs/ioctl.c:754 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:754
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 9473:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  tomoyo_supervisor+0x360/0xef0 security/tomoyo/common.c:2149
  tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
  tomoyo_env_perm+0x18e/0x210 security/tomoyo/environ.c:63
  tomoyo_environ security/tomoyo/domain.c:674 [inline]
  tomoyo_find_next_domain+0x1354/0x1f6c security/tomoyo/domain.c:881
  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:107 [inline]
  tomoyo_bprm_check_security+0x124/0x1a0 security/tomoyo/tomoyo.c:97
  security_bprm_check+0x63/0xb0 security/security.c:784
  search_binary_handler+0x71/0x570 fs/exec.c:1645
  exec_binprm fs/exec.c:1701 [inline]
  __do_execve_file.isra.0+0x1329/0x22b0 fs/exec.c:1821
  do_execveat_common fs/exec.c:1867 [inline]
  do_execve fs/exec.c:1884 [inline]
  __do_sys_execve fs/exec.c:1960 [inline]
  __se_sys_execve fs/exec.c:1955 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1955
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff88809fbb1000
  which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1856 bytes inside of
  2048-byte region [ffff88809fbb1000, ffff88809fbb1800)
The buggy address belongs to the page:
page:ffffea00027eec40 refcount:1 mapcount:0 mapping:ffff8880aa400e00  
index:0x0
raw: 00fffe0000000200 ffffea00027d0ac8 ffffea00027645c8 ffff8880aa400e00
raw: 0000000000000000 ffff88809fbb1000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809fbb1600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88809fbb1680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ffff88809fbb1700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                            ^
  ffff88809fbb1780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88809fbb1800: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

