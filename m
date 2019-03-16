Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B61C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF99218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 11:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfCPLwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 07:52:07 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40021 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfCPLwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 07:52:07 -0400
Received: by mail-io1-f71.google.com with SMTP id e72so3104744iof.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 04:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ygqu1itMuOm0u0AG9m1HWFzdKzhwT32U/hDwe/eoJR8=;
        b=HNxqr/B6asxZQZopI3Ft2uWse+6JI3vC5wqXQrXlXES/gGifWag9lItAqSs6faLmV0
         xK8E19OnNFhHCnRl+ToQ14aarJKXMV04gS8XXUTmBJz1nUKyUINWJE5VA73QJ1kcJY1i
         R9/W5vZKAVJ4L5Tali5xvr4pZBkzzDokxb2BmJL6Q2eUvDF24o9nO6ViE7LMffXTcJxF
         uf3lM4RuJwpyv8Whp1+HyfTjAB88Mw5j+CSavHNm9KGjqHi6cNzQwvS/WaHzeDP6Oh+K
         PVyLpz4KMzg0A95aM2bW6hwgt3CuOoCyggnQw6msrJQWr54lxXb7IVF4n2QuZzuO6THe
         6jCw==
X-Gm-Message-State: APjAAAUSxshSmfVMCkKsqgsVy9pxMsreVXSNywaX0A4ISggzWkuwMPLX
        N/lP+Tm8fa78QbCv/rWGBnvIn+x4IGsuj+/D2H+s9Xuj1sPL
X-Google-Smtp-Source: APXvYqzDwu1EK4QsTod9AUXUMNeU1CMHm2QgISJq6z69HHuJW8g1nth1XKxNKagUSquDziwnJGLvSdhp92w3RCgWHIUrgF70HmrL
MIME-Version: 1.0
X-Received: by 2002:a6b:3115:: with SMTP id j21mr5167822ioa.33.1552737124728;
 Sat, 16 Mar 2019 04:52:04 -0700 (PDT)
Date:   Sat, 16 Mar 2019 04:52:04 -0700
In-Reply-To: <00000000000052a5500584348100@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfc5f2058434c8dc@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in linear_transfer
From:   syzbot <syzbot+a39b5d3c50e55e24fb4d@syzkaller.appspotmail.com>
To:     alsa-devel-owner@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    6c83d0d5 Merge branch 'for-linus-5.1-rc1' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1013cad7200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7e1aaa1cfbfe1abf
dashboard link: https://syzkaller.appspot.com/bug?extid=a39b5d3c50e55e24fb4d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: amd64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113945fb200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ed3cf7200000

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
Read of size 1 at addr ffff88807ffcf3b8 by task syz-executor510/8466

CPU: 1 PID: 8466 Comm: syz-executor510 Not tainted 5.0.0+ #24
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
  __x64_sys_read+0x73/0xb0 fs/read_write.c:586
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446839
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f018eea3db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000006dbc38 RCX: 0000000000446839
RDX: 0000000000001000 RSI: 00000000200012c0 RDI: 0000000000000003
RBP: 00000000006dbc30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc3c
R13: 00007fff63b9986f R14: 00007f018eea49c0 R15: 0000000000000000

Allocated by task 8450:
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
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff88807ffce800
  which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 3000 bytes inside of
  4096-byte region [ffff88807ffce800, ffff88807ffcf800)
The buggy address belongs to the page:
page:ffffea0001fff380 count:1 mapcount:0 mapping:ffff88812c3f0dc0 index:0x0  
compound_mapcount: 0
flags: 0x1fffc0000010200(slab|head)
raw: 01fffc0000010200 ffffea0001e65408 ffffea00027e2408 ffff88812c3f0dc0
raw: 0000000000000000 ffff88807ffce800 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88807ffcf280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  ffff88807ffcf300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88807ffcf380: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
                                         ^
  ffff88807ffcf400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
  ffff88807ffcf480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

