Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7BBC2BD09
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A562071E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 06:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfLIGVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 01:21:12 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:51799 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfLIGVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 01:21:10 -0500
Received: by mail-io1-f70.google.com with SMTP id t18so9974918iob.18
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 22:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jmX0EBSuEVZ2xGMXr3U0seiKJuVfiQBe2jvEsaFHyNs=;
        b=NkgJetm+GkJqrYhpjex5s4myn2UBPVdxS8eOxXvOZu5AYsSS9GzWZyFj7gq2grRMSO
         L3pGjvmn+QCcQkQSydNM9wSoIrkU3/6u0FG1c0hE908At12l7SsKExIpxzZ1/yXMA6SY
         DRkQ1EOllCGdNVGqrS5ZdNEqlqQb1KiDeFnYdVUH79K/LU4aPYm94oVbxMXgTj50O9rn
         BNPo+qQlFhel3SErcTq9RmRxVi+tjAbfh9tIdZ32b03as7O+giv+FJ18ILLMfXJ74WJG
         ATYeDWf4rwfqypuI9uloo1uHUrGfhQ70U7LIeEA/xVKbGhNul/SA05Eqca9S7/4OC/CK
         x+rg==
X-Gm-Message-State: APjAAAXxxbTTiu+O+YymsPuekKcQqRPXlq1jh6EVIN7foy5kH8cRukXb
        lZ49rJhcC4ffzKDIlUh7e04jE4cQi//AAVrnf6jVajx1NHbs
X-Google-Smtp-Source: APXvYqyI1TrZxUj6TxCf2gGv7uNsKWW+9OQdANIMVHQJURQYaUPnb073YZeVPe9QilQL2BuwVrybM6KE2DfbxgMzo8tyDKCUS7dl
MIME-Version: 1.0
X-Received: by 2002:a92:178f:: with SMTP id 15mr25681536ilx.219.1575872469640;
 Sun, 08 Dec 2019 22:21:09 -0800 (PST)
Date:   Sun, 08 Dec 2019 22:21:09 -0800
In-Reply-To: <0000000000000b284d059906e13e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3afe805993f6657@google.com>
Subject: Re: KASAN: use-after-free Read in n_tty_receive_buf_common
From:   syzbot <syzbot+59997e8d5cbdc486e6f6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    9455d25f Merge tag 'ntb-5.5' of git://github.com/jonmason/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174b042ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3b8f5088d4043a
dashboard link: https://syzkaller.appspot.com/bug?extid=59997e8d5cbdc486e6f6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c641dae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110d477ae00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+59997e8d5cbdc486e6f6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in n_tty_check_throttle drivers/tty/n_tty.c:266  
[inline]
BUG: KASAN: use-after-free in n_tty_receive_buf_common+0x270f/0x2b70  
drivers/tty/n_tty.c:1761
Read of size 1 at addr ffff88809f900b01 by task syz-executor920/9030

CPU: 1 PID: 9030 Comm: syz-executor920 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
  n_tty_check_throttle drivers/tty/n_tty.c:266 [inline]
  n_tty_receive_buf_common+0x270f/0x2b70 drivers/tty/n_tty.c:1761
  n_tty_receive_buf2+0x34/0x40 drivers/tty/n_tty.c:1777
  tty_ldisc_receive_buf+0xad/0x1c0 drivers/tty/tty_buffer.c:461
  paste_selection+0x1ff/0x460 drivers/tty/vt/selection.c:372
  tioclinux+0x133/0x480 drivers/tty/vt/vt.c:3044
  vt_ioctl+0x1a41/0x26d0 drivers/tty/vt/vt_ioctl.c:364
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
RIP: 0033:0x441309
Code: e8 ac e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffea28a108 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441309
RDX: 0000000020000000 RSI: 000000000000541c RDI: 0000000000000003
RBP: 0000000000012d00 R08: 000000000000000d R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402080
R13: 0000000000402110 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 9027:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:513 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc+0x163/0x770 mm/slab.c:3665
  kmalloc_array include/linux/slab.h:598 [inline]
  set_selection_kernel+0x872/0x13b0 drivers/tty/vt/selection.c:305
  set_selection_user+0x95/0xd9 drivers/tty/vt/selection.c:177
  tioclinux+0x11c/0x480 drivers/tty/vt/vt.c:3039
  vt_ioctl+0x1a41/0x26d0 drivers/tty/vt/vt_ioctl.c:364
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

Freed by task 9028:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  kasan_set_free_info mm/kasan/common.c:335 [inline]
  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:474
  kasan_slab_free+0xe/0x10 mm/kasan/common.c:483
  __cache_free mm/slab.c:3426 [inline]
  kfree+0x10a/0x2c0 mm/slab.c:3757
  set_selection_kernel+0x88f/0x13b0 drivers/tty/vt/selection.c:312
  set_selection_user+0x95/0xd9 drivers/tty/vt/selection.c:177
  tioclinux+0x11c/0x480 drivers/tty/vt/vt.c:3039
  vt_ioctl+0x1a41/0x26d0 drivers/tty/vt/vt_ioctl.c:364
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

The buggy address belongs to the object at ffff88809f900b00
  which belongs to the cache kmalloc-96 of size 96
The buggy address is located 1 bytes inside of
  96-byte region [ffff88809f900b00, ffff88809f900b60)
The buggy address belongs to the page:
page:ffffea00027e4000 refcount:1 mapcount:0 mapping:ffff8880aa400540  
index:0x0
raw: 00fffe0000000200 ffffea0002871bc8 ffffea00027dc148 ffff8880aa400540
raw: 0000000000000000 ffff88809f900000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809f900a00: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
  ffff88809f900a80: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
> ffff88809f900b00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                    ^
  ffff88809f900b80: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
  ffff88809f900c00: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
==================================================================

