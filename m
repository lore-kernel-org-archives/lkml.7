Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06EAC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04182072A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgAIIJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:09:12 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:39969 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbgAIIJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:09:12 -0500
Received: by mail-il1-f199.google.com with SMTP id e4so4092887ilm.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 00:09:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=e+d+e8nGm4aBm9xvvYGM+RbFjleehaxe1qFBJx6UrUY=;
        b=YqAz6tt1z89PYCJ6AhKoo+GwAf+ZM3690cD6l28yb1U8giLPH9Ewfv3xrDNCSnXDQs
         mrexgxhsteU5Y8NwQw8f+UcGY6OXiSelphvakd7F5JYUdodOWzXLR4+5W/Og/fvOHqru
         a83wLLnhkZjLsdH+0Z5KAKgJzhVNt8jdGX42akgH4+ulSZ/gY2wobpBB2gavPdKYarPp
         5n9/5pSSXQ8arbafZYYfg9AJ6ae7IQ4B44q1VDIrDasjyLBLDJXqGduoMViBHdtuc+6e
         Vw4jI09SRYX2EDKqBTUkJKR9z3ZXfz+LJ4C/GAr0YlG+BoBTfOXxbTFkeva2u9LfPA7c
         IJZw==
X-Gm-Message-State: APjAAAWM+gWJPKR0GHhkzEbb+zUQpQEIOMVbo1WbkdNjaljn6JPUoL9P
        Wp/jw7lQAQ5kIrYSGOGwnX0/rv6cSi+t90sioFDBIaCHbuY8
X-Google-Smtp-Source: APXvYqye2PGwKG0s6kHv8IwkWNUh5Iw1M8KVF+cnSnCCHxHiyksiziMz8AF4xEWD/kbsafaVbk/SsQFhC+uXQoXxX8VVRU5RXIRC
MIME-Version: 1.0
X-Received: by 2002:a92:c990:: with SMTP id y16mr8021354iln.105.1578557351976;
 Thu, 09 Jan 2020 00:09:11 -0800 (PST)
Date:   Thu, 09 Jan 2020 00:09:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038e517059bb08615@google.com>
Subject: KASAN: null-ptr-deref Read in insert_char
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

Hello,

syzbot found the following crash on:

HEAD commit:    b07f636f Merge tag 'tpmdd-next-20200108' of git://git.infr..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16214d15e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18698c0c240ba616
dashboard link: https://syzkaller.appspot.com/bug?extid=7416b988c249396c5e2c
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+7416b988c249396c5e2c@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in memmove include/linux/string.h:395 [inline]
BUG: KASAN: null-ptr-deref in scr_memmovew include/linux/vt_buffer.h:68  
[inline]
BUG: KASAN: null-ptr-deref in insert_char+0x206/0x400  
drivers/tty/vt/vt.c:839
Read of size 4294967294 at addr 0000000000000010 by task  
syz-executor.1/10976

CPU: 0 PID: 10976 Comm: syz-executor.1 Not tainted 5.5.0-rc5-syzkaller #0
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
RIP: 0033:0x45af49
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f540b476c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045af49
RDX: 0000000000000078 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f540b4776d4
R13: 00000000004cce19 R14: 00000000004e81c0 R15: 00000000ffffffff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
