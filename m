Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19B1C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 20:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A51C21873
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 20:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbfCWUQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 16:16:02 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:56233 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfCWUQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 16:16:01 -0400
Received: by mail-io1-f70.google.com with SMTP id z19so1144946ioc.22
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 13:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vT4OejOfLvmgbRROWwX6HFyawim6eShT5FuxRtVPx4E=;
        b=N2L03vGIToDtlX/SmNSbRFO26vnGH+Dyfn1Hv5K89ERpbmRQKzUQ5A/DpPK7o8cv7T
         o8DE63UPR3YV8oJKe3ReW0Rv3Uk1OTcMioMgzaXI1c0x7TIVGz0+YbdA6qdMi4ZjJEpt
         mCc1S9jf5/KSpEaueYGHeZOlw6L0C9Oh7qIskU8Nhe/4hRrrsj98AoauFwhtoY0CD8LZ
         1Z7bUa1faCYpL+a7o+NBWfCqmQMbBVb+8Uln6lEF7CwRIbr3QCxCP5gYOf+nIDXoSYjA
         VK684oLzzgoRxc+AONKYN/RFqAiEOFdZj7t6/OU28bX0JiJry8dYuwF/UPhcSgZqz4tM
         AUbg==
X-Gm-Message-State: APjAAAWVpkGRYMH9iSnsVdhGLpHijUpsmyDTBK9E+DVIQVw56rDEF8sr
        MRGMs12KrNskdWIumbrhr8aGu3vJ0VaS6LuL2pO7Cm+6jMF4
X-Google-Smtp-Source: APXvYqz6nx/DaHaeW3/I6fO+zWux7xGx6+uWbaJFXIWQxl9D/dxsT4CqcR6YmvB3to2zJFsPi6+PU9Y3U0vw2+EwI1Zc32lXGCdI
MIME-Version: 1.0
X-Received: by 2002:a6b:b797:: with SMTP id h145mr9380241iof.190.1553372160847;
 Sat, 23 Mar 2019 13:16:00 -0700 (PDT)
Date:   Sat, 23 Mar 2019 13:16:00 -0700
In-Reply-To: <CAOssrKcsXPqH-s-YLYdao3REpD=iQAeX9UvasB3n6RK84PuP=Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9f9ac0584c8a309@google.com>
Subject: Re: WARNING in request_end
From:   syzbot <syzbot+ef054c4d3f64cd7f7cec@syzkaller.appspotmail.com>
To:     dvyukov@google.com, ebiederm@xmission.com, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, mszeredi@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered  
crash:
WARNING in request_end

WARNING: CPU: 0 PID: 16992 at fs/fuse/dev.c:390 request_end+0x836/0xac0  
fs/fuse/dev.c:390
kobject: '0:49' (000000001562c524): kobject_uevent_env
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 16992 Comm: syz-executor3 Not tainted 4.19.0-rc5+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1db/0x2ce lib/dump_stack.c:113
  panic+0x263/0x51a kernel/panic.c:184
kobject: 'loop5' (0000000073db98f3): kobject_uevent_env
  __warn.cold+0x13b/0x1ba kernel/panic.c:536
  report_bug+0x263/0x2b0 lib/bug.c:186
kobject: 'loop5' (0000000073db98f3): fill_kobj_path: path  
= '/devices/virtual/block/loop5'
  fixup_bug arch/x86/kernel/traps.c:178 [inline]
  fixup_bug arch/x86/kernel/traps.c:173 [inline]
  do_error_trap+0x200/0x4e0 arch/x86/kernel/traps.c:296
kobject: '0:49' (000000001562c524): fill_kobj_path: path  
= '/devices/virtual/bdi/0:49'
  do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:316
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:993
kobject: '0:49' (000000001562c524): kobject_cleanup, parent           (null)
RIP: 0010:request_end+0x836/0xac0 fs/fuse/dev.c:390
Code: 3c 03 0f 8f 7d fe ff ff 48 8b bd 30 ff ff ff e8 b0 b4 3b ff e9 6c fe  
ff ff e8 a6 ad f8 fe 0f 0b e9 be fa ff ff e8 9a ad f8 fe <0f> 0b e9 fc fa  
ff ff e8 4e c7 c2 fe e8 a9 b4 3b ff e9 6a fb ff ff
RSP: 0018:ffff8801c099f5a8 EFLAGS: 00010293
RAX: ffff8801be90e040 RBX: 1ffff10038133eba RCX: ffffffff82858ce9
RDX: 0000000000000000 RSI: ffffffff828591f6 RDI: 0000000000000007
RBP: ffff8801c099f698 R08: ffff8801be90e040 R09: ffffed0037bc2c18
R10: ffffed0037bc2c17 R11: ffff8801bde160bb R12: ffff8801a5ca9800
R13: ffff8801bde16040 R14: ffff8801c099f670 R15: ffff8801a5ca9830
kobject: '0:49' (000000001562c524): calling ktype release
  fuse_dev_do_write+0x1888/0x3730 fs/fuse/dev.c:1917
kobject: '0:49': free name
kobject: '0:49' (000000005b47baa2): kobject_add_internal: parent: 'bdi',  
set: 'devices'
kobject: '0:49' (000000005b47baa2): kobject_uevent_env
  fuse_dev_write+0x191/0x240 fs/fuse/dev.c:1941
kobject: '0:49' (000000005b47baa2): fill_kobj_path: path  
= '/devices/virtual/bdi/0:49'
  call_write_iter include/linux/fs.h:1808 [inline]
  new_sync_write fs/read_write.c:474 [inline]
  __vfs_write+0x6e5/0xa80 fs/read_write.c:487
kobject: '0:56' (00000000a2a816b6): kobject_add_internal: parent: 'bdi',  
set: 'devices'
kobject: '0:56' (00000000a2a816b6): kobject_uevent_env
  vfs_write+0x20c/0x560 fs/read_write.c:549
  ksys_write+0x105/0x260 fs/read_write.c:598
kobject: '0:56' (00000000a2a816b6): fill_kobj_path: path  
= '/devices/virtual/bdi/0:56'
  __do_sys_write fs/read_write.c:610 [inline]
  __se_sys_write fs/read_write.c:607 [inline]
  __ia32_sys_write+0x71/0xb0 fs/read_write.c:607
  do_syscall_32_irqs_on arch/x86/entry/common.c:326 [inline]
  do_fast_syscall_32+0x333/0xf98 arch/x86/entry/common.c:397
kobject: '0:57' (000000002c3163ad): kobject_add_internal: parent: 'bdi',  
set: 'devices'
kobject: '0:57' (000000002c3163ad): kobject_uevent_env
  entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139
RIP: 0023:0xf7fa0cb9
Code: 85 d2 74 02 89 0a 5b 5d c3 8b 04 24 c3 8b 0c 24 c3 8b 1c 24 c3 90 90  
90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90  
90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f5a0cc EFLAGS: 00000296 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000200002c0
RDX: 0000000000000050 RSI: 0000000000000000 RDI: 0000000000000000
kobject: '0:57' (000000002c3163ad): fill_kobj_path: path  
= '/devices/virtual/bdi/0:57'
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


Tested on:

commit:         bc78abbd fuse: Fix use-after-free in fuse_dev_do_read()
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=175a556d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb49a17588446b34
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

