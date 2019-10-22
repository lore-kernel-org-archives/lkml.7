Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE89CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2886120B7C
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 22:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389523AbfJVWoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 18:44:16 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52329 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389139AbfJVWoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 18:44:13 -0400
Received: by mail-il1-f199.google.com with SMTP id h22so10838943ild.19
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 15:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=4/WCKvnAqzDaDL12Bhh7UvH0NJCk0RkWjjsx/whG8ZM=;
        b=WNKiIjJIvW8DSlSuXd49E2QRgGs1AxE8goVnIYASDD+1n9N8LtQEasjyXLDLa0o96o
         YVGCvYKAIFq3lSu/IUuk0haCtYAuyq81sjk5ivxDcg62KN5CGeF4T30exfwlITYBCkCB
         YdHmaEaPz2ybVgnqpfHPOIUwmHE7JZn878Di5aGNOg44nPLhP8NEtXtf9wPWyzDJxQmh
         +5kIQxYPk+s4rPWeSuwhZdt6zmpiP5FBFJFrCAeQhvjcBcqL4jO4rZhq5vzHMeXV8eo+
         oOIAQzshO0DyulX8IwtUZAj+wchJFBoyRn3FU/aeS6Mkijb89bApHbj511IGLlyjVNk2
         UX5g==
X-Gm-Message-State: APjAAAVTCybcSF9FepYka+4rgmze0K0X2KmGwrXMkOdal4+XE6PGYFIp
        V/7jbuSgR5KE8METR1THKkaDbrTbyWbcTlYe6/av6t3XMfVh
X-Google-Smtp-Source: APXvYqzC897uqVhegwaruTsaLD8YtovbI5/bp3lBEAQ2A5tfdg0flpoCccIvkepMLFKVqJy1o120cjJ/yqARBtV+1988Jjftiypn
MIME-Version: 1.0
X-Received: by 2002:a6b:ba82:: with SMTP id k124mr191815iof.92.1571784252679;
 Tue, 22 Oct 2019 15:44:12 -0700 (PDT)
Date:   Tue, 22 Oct 2019 15:44:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000b75de0595878a3e@google.com>
Subject: linux-next test error: WARNING in collapse_file
From:   syzbot <syzbot+667740df862911577d63@syzkaller.appspotmail.com>
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

HEAD commit:    a722f75b Add linux-next specific files for 20191022
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=126aea5b600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=32434321999f01e9
dashboard link: https://syzkaller.appspot.com/bug?extid=667740df862911577d63
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+667740df862911577d63@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1080 at mm/khugepaged.c:1643  
collapse_file+0x1f9d/0x4170 mm/khugepaged.c:1643
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 1080 Comm: khugepaged Not tainted 5.4.0-rc4-next-20191022 #0
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
RSP: 0018:ffff8880a818fad0 EFLAGS: 00010293
RAX: ffff8880a7dd8440 RBX: ffff8880a818fc88 RCX: ffffffff81b2b688
RDX: 0000000000000000 RSI: ffffffff81b2b9ad RDI: 0000000000000001
RBP: ffff8880a818fcb0 R08: ffff8880a7dd8440 R09: fffff940004942b9
R10: fffff940004942b8 R11: ffffea00024a15c7 R12: 0000000000000001
R13: ffffea0002383a08 R14: 0000000000000000 R15: ffffea0002338000
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
