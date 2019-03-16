Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C778C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAEF821871
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCPLcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 07:32:08 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54464 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfCPLcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 07:32:07 -0400
Received: by mail-io1-f69.google.com with SMTP id i24so9176911iol.21
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 04:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7c3uGhFJdZUYYg0dKyttpCtHB5TPZkKE6Oe78gVcke8=;
        b=kNZX5sTlii1AbfCEj7VtEG1F6ZcqVuJXsJNS5oogq1+bYEToDXwYUppOECWQyXzk1b
         waftM2egcuRGp5f2rByU3Z6t0sfVb3KDs/gtIchO1PfUne0HZ8e9dAddvrWmQQ33t+Hp
         +73YV7BZ6krfUh3ooPVnF86nT+UUqjx1SJDv8gS+YDSFT1U5r/askG+ABzfhe46RQ1k5
         gLN4J9D0+tPSofI6uWB4v0sx6AONsF/g340nfslhVUcrXlrNpFxkdZ9QIW509YZ4Ld05
         kLDmSnF1vbO34+YbOmMPghUOIfjqQdanhxhf1aZRfhGK96QSCETWiKs66tDNmUjKJCSx
         lWmw==
X-Gm-Message-State: APjAAAUtStCz4yZUl23neOvJnIyFVQcbUbT0Jw1rn7kYtKibRtQKzBqH
        QumMpzTTzNDHBJbyNrexLq4LbLE5VWiEa+iLVX3Xt4Sm17RP
X-Google-Smtp-Source: APXvYqyJTBP8lS1qIf0oU2RsfsfskmjC9AnlPGmD10mgE1tApyicM5UWZ7w2BY3tVPV6FVt95etH6F9hTROJ9+rOZ9VWxdMzN6LJ
MIME-Version: 1.0
X-Received: by 2002:a05:660c:150:: with SMTP id r16mr4381278itk.39.1552735926392;
 Sat, 16 Mar 2019 04:32:06 -0700 (PDT)
Date:   Sat, 16 Mar 2019 04:32:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052a5500584348100@google.com>
Subject: KASAN: slab-out-of-bounds Read in linear_transfer
From:   syzbot <syzbot+a39b5d3c50e55e24fb4d@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6c83d0d5 Merge branch 'for-linus-5.1-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15765b0b200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1aaa1cfbfe1abf
dashboard link: https://syzkaller.appspot.com/bug?extid=a39b5d3c50e55e24fb4d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122294a3200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a39b5d3c50e55e24fb4d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:352 [inline]
BUG: KASAN: slab-out-of-bounds in do_convert sound/core/oss/linear.c:48  
[inline]
BUG: KASAN: slab-out-of-bounds in convert sound/core/oss/linear.c:81  
[inline]
BUG: KASAN: slab-out-of-bounds in linear_transfer  
sound/core/oss/linear.c:110 [inline]
BUG: KASAN: slab-out-of-bounds in linear_transfer+0x6de/0x970  
sound/core/oss/linear.c:88
Read of size 1 at addr ffff88809899f0b8 by task syz-executor.2/7877

CPU: 1 PID: 7877 Comm: syz-executor.2 Not tainted 5.0.0+ #24
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_address_description.cold+0x7c/0x20d mm/kasan/report.c:187
  kasan_report.cold+0x1b/0x40 mm/kasan/report.c:317
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x123/0x190 mm/kasan/generic.c:191
  memcpy+0x24/0x50 mm/kasan/common.c:132
  memcpy include/linux/string.h:352 [inline]
  do_convert sound/core/oss/linear.c:48 [inline]
  convert sound/core/oss/linear.c:81 [inline]
  linear_transfer sound/core/oss/linear.c:110 [inline]
  linear_transfer+0x6de/0x970 sound/core/oss/linear.c:88
  snd_pcm_plug_read_transfer+0x1a1/0x2f0 sound/core/oss/pcm_plugin.c:651
  snd_pcm_oss_read2+0x1f0/0x3f0 sound/core/oss/pcm_oss.c:1474
  snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1531 [inline]
  snd_pcm_oss_read+0x53a/0x6a0 sound/core/oss/pcm_oss.c:2751
  __vfs_read+0x8d/0x110 fs/read_write.c:416
  vfs_read+0x194/0x3e0 fs/read_write.c:452
  ksys_read+0xea/0x1f0 fs/read_write.c:578
  __do_sys_read fs/read_write.c:588 [inline]
  __se_sys_read fs/read_write.c:586 [inline]
  __ia32_sys_read+0x71/0xb0 fs/read_write.c:586
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7f66869
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 14 24 c3 8b 3c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f620cc EFLAGS: 00000296 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000200012c0
RDX: 0000000000001000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

Allocated by task 7877:
  save_stack+0x45/0xd0 mm/kasan/common.c:75
  set_track mm/kasan/common.c:87 [inline]
  __kasan_kmalloc mm/kasan/common.c:497 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:470
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:511
  __do_kmalloc_node mm/slab.c:3686 [inline]
  __kmalloc_node+0x4e/0x70 mm/slab.c:3693
  kmalloc_node include/linux/slab.h:588 [inline]
  kvmalloc_node+0x68/0x100 mm/util.c:430
  kvmalloc include/linux/mm.h:605 [inline]
  kvzalloc include/linux/mm.h:613 [inline]
  snd_pcm_plugin_alloc+0x585/0x770 sound/core/oss/pcm_plugin.c:70
  snd_pcm_plug_alloc+0x148/0x330 sound/core/oss/pcm_plugin.c:129
  snd_pcm_oss_change_params_locked+0x2118/0x3750  
sound/core/oss/pcm_oss.c:1038
  snd_pcm_oss_change_params+0x7b/0xd0 sound/core/oss/pcm_oss.c:1101
  snd_pcm_oss_get_active_substream+0x136/0x190 sound/core/oss/pcm_oss.c:1118
  snd_pcm_oss_get_rate sound/core/oss/pcm_oss.c:1768 [inline]
  snd_pcm_oss_set_rate sound/core/oss/pcm_oss.c:1760 [inline]
  snd_pcm_oss_ioctl+0x8f7/0x3430 sound/core/oss/pcm_oss.c:2607
  snd_pcm_oss_ioctl_compat+0x24/0x30 sound/core/oss/pcm_oss.c:2734
  __do_compat_sys_ioctl fs/compat_ioctl.c:1052 [inline]
  __se_compat_sys_ioctl fs/compat_ioctl.c:998 [inline]
  __ia32_compat_sys_ioctl+0x197/0x620 fs/compat_ioctl.c:998
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x281/0xc98 arch/x86/entry/common.c:397
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff88809899e500
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 3000 bytes inside of
  4096-byte region [ffff88809899e500, ffff88809899f500)
The buggy address belongs to the page:
page:ffffea0002626780 count:1 mapcount:0 mapping:ffff88812c3f0dc0 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea00022bc088 ffffea0002841208 ffff88812c3f0dc0
raw: 0000000000000000 ffff88809899e500 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809899ef80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88809899f000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88809899f080: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
                                         ^
  ffff88809899f100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88809899f180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
