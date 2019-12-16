Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4F8C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AFE20717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfLPVjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:39:51 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38155 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727602AbfLPVjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:39:09 -0500
Received: by mail-il1-f197.google.com with SMTP id g74so6127337ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 13:39:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=N9WiHnm9wwtUvpgImrOs1mRA/unlisOniA8Ntsa8qCU=;
        b=r8bW2XLyUk+SUIXOLb2E2KDZ1+QVmIFp66vUUl8/jcqv+p8X5h0Rj9sVc7e+SpRXcZ
         nWJGo4fI8azw4aYXkB8wH2yAGXvRzunw8g572BuC5+Az2/hY2Pp+mkjeAidxONvzGI6V
         aMUTaYhmrgh1o1lcNjO1cdQ0beE7nWe1xb+mQWTLrC+mGkfpRADFCkM8w7AODrVrYWQM
         pO9mGluHI9tkwlShk9feTOxR4YllJDgMjVP89ZzyTwowi0Gxy+m76g7CjQpkUVJ/xaeI
         /kygFTHSg7o75n/k+LRujMWFTn2EiM1ZrRTd6F7hkGONfcRVAMccF2z/B4LOpu2Vq37/
         fg8Q==
X-Gm-Message-State: APjAAAW68LNRPAmBAEBY8rdbpZlZvexGtIrkegcsNLgzDu+gMc0IXD40
        ZynD6rP5CFG9pS44HTkjIPaHLdL4i4Ma+jIT3akTD5WXaecR
X-Google-Smtp-Source: APXvYqwF19iT61R3c2FHIdUQTgO9WEazMKCftC13szP2/Y786dNtHXyFREVkNXCiY7URphTiiN0sS2NmaljZVVkRytzv7wXdc3lx
MIME-Version: 1.0
X-Received: by 2002:a92:de05:: with SMTP id x5mr13579412ilm.74.1576532347102;
 Mon, 16 Dec 2019 13:39:07 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:39:07 -0800
In-Reply-To: <000000000000dbe36f05996858db@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086ad330599d90aa6@google.com>
Subject: Re: BUG: unable to handle kernel paging request in insert_char
From:   syzbot <syzbot+6a8d618862e1fc55313d@syzkaller.appspotmail.com>
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

HEAD commit:    510c9788 Merge tag 'Wimplicit-fallthrough-5.5-rc2' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16b8c1b6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=6a8d618862e1fc55313d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f695a9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158e0d1ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6a8d618862e1fc55313d@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: 000000010000000e
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 9793b067 P4D 9793b067 PUD 0
Oops: 0002 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 9320 Comm: syz-executor815 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:insert_char+0x23d/0x400 drivers/tty/vt/vt.c:840
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 01 0f 8e  
1e 01 00 00 d1 eb 41 0f b7 85 c8 03 00 00 4c 89 ff 89 d9 <f3> 66 ab 49 8d  
bd 78 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffffc90001dd7858 EFLAGS: 00010202
RAX: 0000000000000720 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 1ffff11011e78679 RSI: 000000010000000e RDI: 000000010000000e
RBP: ffffc90001dd78a0 R08: ffff888095018400 R09: ffff888095018c90
R10: fffffbfff14f3388 R11: ffffffff8a799c47 R12: 0000000000000000
R13: ffff88808f3c3000 R14: ffff88808f3c3334 R15: 000000010000000e
FS:  00000000021de880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 00000000a91a0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
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
RSP: 002b:00007ffd7f172088 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004404f9
RDX: 0000000000000078 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000401de0
R13: 0000000000401e70 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
CR2: 000000010000000e
---[ end trace 609e8edb17a11e0f ]---
RIP: 0010:memset16 arch/x86/include/asm/string_64.h:25 [inline]
RIP: 0010:scr_memsetw include/linux/vt_buffer.h:36 [inline]
RIP: 0010:insert_char+0x23d/0x400 drivers/tty/vt/vt.c:840
Code: 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 01 0f 8e  
1e 01 00 00 d1 eb 41 0f b7 85 c8 03 00 00 4c 89 ff 89 d9 <f3> 66 ab 49 8d  
bd 78 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffffc90001dd7858 EFLAGS: 00010202
RAX: 0000000000000720 RBX: 0000000000000001 RCX: 0000000000000001
RDX: 1ffff11011e78679 RSI: 000000010000000e RDI: 000000010000000e
RBP: ffffc90001dd78a0 R08: ffff888095018400 R09: ffff888095018c90
R10: fffffbfff14f3388 R11: ffffffff8a799c47 R12: 0000000000000000
R13: ffff88808f3c3000 R14: ffff88808f3c3334 R15: 000000010000000e
FS:  00000000021de880(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000010000000e CR3: 00000000a91a0000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

