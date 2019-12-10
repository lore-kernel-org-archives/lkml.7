Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC700C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8804020828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfLJSAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:00:15 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:55527 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbfLJSAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:00:15 -0500
Received: by mail-il1-f199.google.com with SMTP id d14so14991825ild.22
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 10:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LhCEwk1Iu3nauRg6OGPUcM7WjrLDy6Isqf3TuzEs7Cw=;
        b=O3kPArIaRZ1LI15zWRxDeITi4eo0zfnVrv50uxt6VQ6JvXt+RtU9dDno17rSWV41fb
         CX3WYEijF9vNf+TUvhDA++LnNQmVkSZpnvupAqw2TBKCplc4VV6v2UUtLFVOKfMA66Gw
         iHFNQCoV+fAG7FwgQhBarhlChEzBGV/CBRzarG555j1VUPngkbo/s7OFX5lY4o+wEhBf
         wfbK3piaNEMx2GJN+ZBxEAo5RqDKll1CTqhEt9jc1r/Gs2QSlpEiGkejvDxGCHJIVhWj
         8quHF0dhnlFTyl1pggMmcMbl257PoEElfyH+kzZBy7KE39dsDnJM+Whf5NNla+kxBpBh
         VySw==
X-Gm-Message-State: APjAAAW2sv2w3Et2tsKkBzI7/MO2vqMnSpiBB2hfPRs3Z21TQnEec046
        YiXCaAljKkwM9R1/VIMgSvby4TmAh0uMVej9jzdNOW6OrSsE
X-Google-Smtp-Source: APXvYqxiq79lrwLFJyRLtMsXcdR4skpdxqqxMhggPG3IHRw/b/npte7SNEl9Q8by3+6RkZfc4FStCWRqk7XA9PiT9kxU1WgaceNZ
MIME-Version: 1.0
X-Received: by 2002:a5d:9593:: with SMTP id a19mr24775928ioo.36.1576000810129;
 Tue, 10 Dec 2019 10:00:10 -0800 (PST)
Date:   Tue, 10 Dec 2019 10:00:10 -0800
In-Reply-To: <00000000000024db4105995c23cd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074253b05995d48bf@google.com>
Subject: Re: KASAN: user-memory-access Read in insert_char
From:   syzbot <syzbot+6ff38b320aa51ebe17e6@syzkaller.appspotmail.com>
To:     daniel.vetter@ffwll.ch, ghalat@redhat.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-kernel@vger.kernel.org, nico@fluxnic.net, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, textshell@uchuujin.de
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    6794862a Merge tag 'for-5.5-rc1-kconfig-tag' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=158d1282e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=6ff38b320aa51ebe17e6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=169de77ae00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116dd1bce00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6ff38b320aa51ebe17e6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: user-memory-access in memmove include/linux/string.h:395  
[inline]
BUG: KASAN: user-memory-access in scr_memmovew include/linux/vt_buffer.h:68  
[inline]
BUG: KASAN: user-memory-access in insert_char+0x206/0x400  
drivers/tty/vt/vt.c:839
Read of size 212 at addr 00000000ffffff3a by task syz-executor463/9049

CPU: 0 PID: 9049 Comm: syz-executor463 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  __kasan_report.cold+0x5/0x41 mm/kasan/report.c:510
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memmove+0x24/0x50 mm/kasan/common.c:116
  memmove include/linux/string.h:395 [inline]
  scr_memmovew include/linux/vt_buffer.h:68 [inline]
  insert_char+0x206/0x400 drivers/tty/vt/vt.c:839
  csi_at drivers/tty/vt/vt.c:1964 [inline]
  do_con_trol+0x41a6/0x61b0 drivers/tty/vt/vt.c:2431
  do_con_write.part.0+0xfd9/0x1ef0 drivers/tty/vt/vt.c:2797
  do_con_write drivers/tty/vt/vt.c:2565 [inline]
  con_write+0x46/0xd0 drivers/tty/vt/vt.c:3135
  process_output_block drivers/tty/n_tty.c:595 [inline]
  n_tty_write+0x40e/0x1080 drivers/tty/n_tty.c:2333
  do_tty_write drivers/tty/tty_io.c:962 [inline]
  tty_write+0x496/0x7f0 drivers/tty/tty_io.c:1046
  __vfs_write+0x8a/0x110 fs/read_write.c:494
  vfs_write+0x268/0x5d0 fs/read_write.c:558
  ksys_write+0x14f/0x290 fs/read_write.c:611
  __do_sys_write fs/read_write.c:623 [inline]
  __se_sys_write fs/read_write.c:620 [inline]
  __x64_sys_write+0x73/0xb0 fs/read_write.c:620
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4404f9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd81600d98 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004404f9
RDX: 0000000000000078 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401de0
R13: 0000000000401e70 R14: 0000000000000000 R15: 0000000000000000
==================================================================

