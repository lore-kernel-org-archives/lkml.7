Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB06C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AAC20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgAIJEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:04:12 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:37649 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgAIJEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:04:11 -0500
Received: by mail-il1-f198.google.com with SMTP id l13so4182195ilj.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:04:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=q7IFi3rlnd6QovgdB12mRa4jgGBaf0v/r03gEJGH8nE=;
        b=g2ZWDBfwn0oyHlbvLYZUcfkckHezqzHt6LpWeFTgPv1IBkMgPJgrXoC/zOn8hezbst
         rSbZ8fQr/fETMwSa05iU9gfJ8tpcC+3RD31746tTOT8It2V+CgcR0GeT0JAf0hyvGeQ5
         UPIi+BK1BPbOn6xOQ+qiGpIozqUAkX0Ox5siM/DMMjBWSYKVD8I+eyulbgmyvg7d+gkc
         W0ee0zGku7QfHQOPOqz8Vb1XgZiwOBBNt8OdoRscGYVqDEqBDEOL6kAIsQLjRJPeu2FI
         iqrR5W+19ucM1Ixa1VdDgDrWsjudZrNUkU+QdvbxPG8x+pnuyq61LtbStzKihZa2+cfB
         XtzQ==
X-Gm-Message-State: APjAAAXXvC1cdkkeYV0GGZGXivN9sU6x5wUJqlacGhNKeNiQzuJ4l+8N
        0GRNt/jYgMokuuPxpdOJrQkg8NJqgGpd3i4w80UEAr7pXll+
X-Google-Smtp-Source: APXvYqy0MsFsnh2nmiX62MCQCKTj2Wul4oHQje4BVcUufBPs8y/6bdaWaVtPCmNgIcPNMUWcVibwVcopgapRIBGFvs2RN2imcanN
MIME-Version: 1.0
X-Received: by 2002:a92:d98e:: with SMTP id r14mr7134385iln.15.1578560650977;
 Thu, 09 Jan 2020 01:04:10 -0800 (PST)
Date:   Thu, 09 Jan 2020 01:04:10 -0800
In-Reply-To: <00000000000038e517059bb08615@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dba877059bb14a54@google.com>
Subject: Re: KASAN: null-ptr-deref Read in insert_char
From:   syzbot <syzbot+7416b988c249396c5e2c@syzkaller.appspotmail.com>
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

HEAD commit:    b07f636f Merge tag 'tpmdd-next-20200108' of git://git.infr..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102e1c85e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18698c0c240ba616
dashboard link: https://syzkaller.appspot.com/bug?extid=7416b988c249396c5e2c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1716da9ee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a9cc85e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7416b988c249396c5e2c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in memmove include/linux/string.h:395 [inline]
BUG: KASAN: null-ptr-deref in scr_memmovew include/linux/vt_buffer.h:68  
[inline]
BUG: KASAN: null-ptr-deref in insert_char+0x206/0x400  
drivers/tty/vt/vt.c:839
Read of size 4294967294 at addr 0000000000000010 by task  
syz-executor700/10454

CPU: 0 PID: 10454 Comm: syz-executor700 Not tainted 5.5.0-rc5-syzkaller #0
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
RIP: 0033:0x447b99
Code: e8 cc 14 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab 0e fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff82cd33db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000006ddc28 RCX: 0000000000447b99
RDX: 0000000000000078 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00000000006ddc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc2c
R13: 00007ffff0ce099f R14: 00007ff82cd349c0 R15: 0000000000000000
==================================================================

