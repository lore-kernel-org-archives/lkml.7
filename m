Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD137CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA59321872
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438003AbfJYI1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:27:10 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:56133 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389356AbfJYI1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:27:10 -0400
Received: by mail-il1-f198.google.com with SMTP id n81so1519659ili.22
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 01:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=2Z+vWF41GYXH8//3OQ+PBbYTPKapgaj+4O6q+OjV10U=;
        b=LGkdJ/r+l6lMO4yqJUcoppyXZ2WbgMwm08Puux5TuzwGTD7ek0zf1QiVFMFd/qXhpW
         elF0jNd9sNMYTFMZFOMNv5vfk66PS3Ul12bkrWZr4Jczk02YJVnJESI3RsKreSLsN4Xg
         rKgKfjBGeDPEUMTsCs2lr4V81642GcuaezjC2EbR5euFxnRt+JjPlz1wgfR+xlhlnjoW
         /5WAGut4XlzAdHfv723QxwhOEat4yAsqy4D1C0vPy2ihwq7fjk0idEqtBgm8nql42his
         6PltyeOzm8sTNdpkRhHknbvckUnuGna52dRvmZsFNXkM46LsqLYMOqmHYgx/r7wmMX1M
         vEQw==
X-Gm-Message-State: APjAAAXRK7DMpOUY2D0j7MXxJKgFT2GoYIYOZCrtMpYhjTweQEobnInA
        zBjpoKmCZoOkYQNhEVSkharZTsIsMG1AjZ+x+wWwHTspnVXE
X-Google-Smtp-Source: APXvYqxSDwW6Tww3QwRy3e0hO/R9Au/K6Msz+XoPEzW0Senw0ypG/StxAOnzFDLiy4k24SsIAdrUvpSDKNBCgillkV5oQkEAttJH
MIME-Version: 1.0
X-Received: by 2002:a92:1907:: with SMTP id 7mr2888673ilz.72.1571992027666;
 Fri, 25 Oct 2019 01:27:07 -0700 (PDT)
Date:   Fri, 25 Oct 2019 01:27:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066214a0595b7ea86@google.com>
Subject: WARNING in collapse_file
From:   syzbot <syzbot+742a9c5d4ab05d343c49@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com, jglisse@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    a6fcdcd9 Add linux-next specific files for 20191021
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11145ed8e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32434321999f01e9
dashboard link: https://syzkaller.appspot.com/bug?extid=742a9c5d4ab05d343c49
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+742a9c5d4ab05d343c49@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1080 at mm/khugepaged.c:1643  
collapse_file+0x1f9d/0x4170 mm/khugepaged.c:1643
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 1080 Comm: khugepaged Not tainted 5.4.0-rc4-next-20191021 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x35 kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:collapse_file+0x1f9d/0x4170 mm/khugepaged.c:1643
Code: a1 c0 ff 31 c9 ba 01 00 00 00 4c 89 fe 48 8b bd c0 fe ff ff e8 e4 e9  
ec ff e9 b4 fd ff ff 4c 8b bd 88 fe ff ff e8 93 a1 c0 ff <0f> 0b 4c 8b a3  
50 ff ff ff c7 85 80 fe ff ff 00 00 00 00 e9 05 f6
RSP: 0018:ffff8880a7e57ad0 EFLAGS: 00010293
RAX: ffff8880a7e74440 RBX: ffff8880a7e57c88 RCX: ffffffff81b2a998
RDX: 0000000000000000 RSI: ffffffff81b2acbd RDI: 0000000000000001
RBP: ffff8880a7e57cb0 R08: ffff8880a7e74440 R09: fffff940004730b1
R10: fffff940004730b0 R11: ffffea0002398587 R12: 0000000000000001
R13: ffffea0002ffa848 R14: 0000000000000000 R15: ffffea0002230000
  khugepaged_scan_file mm/khugepaged.c:1881 [inline]
  khugepaged_scan_mm_slot mm/khugepaged.c:1979 [inline]
  khugepaged_do_scan mm/khugepaged.c:2063 [inline]
  khugepaged+0x2da9/0x4360 mm/khugepaged.c:2108
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
