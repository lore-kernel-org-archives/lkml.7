Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE190C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B9D2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 13:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfKHNQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 08:16:09 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:43235 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfKHNQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 08:16:09 -0500
Received: by mail-il1-f199.google.com with SMTP id d11so6820615ild.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 05:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=FffDQgwn/dW+1508K0LBJAZybRGysdymW5Wy11WbKVA=;
        b=NT0OTtTFSTmP26wPlvVWivIm1UnRZA3YdORAPEmJW/8ftD104/MeqzdOqnmiezP9JJ
         o3iIHCrm1jECXw85V2pSPJO4WFpaIFANMENOf30YvS94shxkVpvSMD5RWvq0E+9zlDhp
         KRRMcb0kZolhYvNk2yxb5TGBfPSmwg2C1ha6hrGoE5E4v4HHQSwN6BFTEZlfVNBAETRD
         Z+5bZ5hb0JuNPDDBWl//+ZLmvnFl7Us5k0qnbGKP1Kg8j9IazG3BD1I7+1+zOi4y3qC+
         RgTylbUW/vXee5iuf6nKaKSeWTp44ldHS5NtbMcwRRFnsFjOZVS+y94gjwCd1Cu+pg6m
         jUrw==
X-Gm-Message-State: APjAAAVGCic4wj0nNexfKutNX2Y3apbWxJl1KEdVTcZ7S5FU7ZkAkpBG
        mj2XwtAKN6I9xveg7zo8C+phZaiaXZ9Vbj+W65JXk1pl7krb
X-Google-Smtp-Source: APXvYqz8qoOQm5P+K+lDeq1WdI8t8mYMNJE9ma8BuofwhXEctYACRVzeDkXyr18rofd0qRiLq1Xi8pCgXI7idZc0oY/aXpF/BDMt
MIME-Version: 1.0
X-Received: by 2002:a6b:bd86:: with SMTP id n128mr9904815iof.214.1573218968409;
 Fri, 08 Nov 2019 05:16:08 -0800 (PST)
Date:   Fri, 08 Nov 2019 05:16:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c422a80596d595ee@google.com>
Subject: KCSAN: data-race in __alloc_file / __alloc_file
From:   syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>
To:     elver@google.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    05f22368 x86, kcsan: Enable KCSAN for x86
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=10d7fd88e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=87d111955f40591f
dashboard link: https://syzkaller.appspot.com/bug?extid=3ef049d50587836c0606
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __alloc_file / __alloc_file

write to 0xffff8880bb157398 of 4 bytes by task 10993 on cpu 0:
  get_cred include/linux/cred.h:253 [inline]
  __alloc_file+0x74/0x210 fs/file_table.c:105
  alloc_empty_file+0x8f/0x180 fs/file_table.c:151
  alloc_file+0x4e/0x2b0 fs/file_table.c:193
  alloc_file_pseudo+0x11c/0x1b0 fs/file_table.c:232
  anon_inode_getfile fs/anon_inodes.c:91 [inline]
  anon_inode_getfile+0x103/0x1d0 fs/anon_inodes.c:74
  __do_sys_perf_event_open+0xd32/0x1ac0 kernel/events/core.c:11100
  __se_sys_perf_event_open kernel/events/core.c:10867 [inline]
  __x64_sys_perf_event_open+0x70/0x90 kernel/events/core.c:10867
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

write to 0xffff8880bb157398 of 4 bytes by task 11004 on cpu 1:
  get_cred include/linux/cred.h:253 [inline]
  __alloc_file+0x74/0x210 fs/file_table.c:105
  alloc_empty_file+0x8f/0x180 fs/file_table.c:151
  path_openat+0x74/0x36e0 fs/namei.c:3514
  do_filp_open+0x11e/0x1b0 fs/namei.c:3555
  do_sys_open+0x3b3/0x4f0 fs/open.c:1097
  __do_sys_open fs/open.c:1115 [inline]
  __se_sys_open fs/open.c:1110 [inline]
  __x64_sys_open+0x55/0x70 fs/open.c:1110
  do_syscall_64+0xcc/0x370 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 11004 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
