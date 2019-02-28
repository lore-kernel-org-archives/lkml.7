Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A807C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327102171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbfB1OMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:12:07 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:41227 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732456AbfB1OMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:12:05 -0500
Received: by mail-io1-f70.google.com with SMTP id p17so15588123ios.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 06:12:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ekxuPCiwzgIqznbM3XZuOlpyXhdKAEjkhYfaE2wcIO0=;
        b=PqZKZYIT6dLxoiXBH5UdQQCTdxswIlQLH4ReI6a3gKgsy3rXqCxUu98xfZWBOZpYsH
         /LU1vzpuIpmSFQgiIif0YWKAqlZDxhKi8GiTUDXmL3pjX6t6MIkQ0g6cCgexqsWK7ajI
         GaWxC4KSHTAlwYpR0KeGXTuPE+zxyY4Gl0SUHc+XYGby61orjEewYs0IGqaNpOz2Ribd
         IKkzxnaEMlyZ68h/yF9l5DC7Q7/UjkV3qMmeXsVBJvWMnm6K53KwKrAw+GPDw8uF9XWW
         KpIN+EOgsgo9Uhq9hJaILv34I2GDtfLItQI+fJhnoQ9Zd4YmcG54wCVPo3V4cCKKsCyV
         8ZzA==
X-Gm-Message-State: AHQUAuaTjxu+RZVWMp+e6pA6Ox4EfcMOTjoE0tmVGCCDJPzEEGQY98dl
        f5Nc4bjtmHBB01n44rGGE3fzIdSzZRr2LbIutxP/btzxrqF7
X-Google-Smtp-Source: AHgI3IbhdcAiLY0VfbsNuoQQIcnNG03vd7RzyyTt6EsmPDZEGGSYGy7aXh0JDVti6y8nZdw9cwzWs+Z9RSDx1+Ix6KKiF64fvqoR
MIME-Version: 1.0
X-Received: by 2002:a02:5c0f:: with SMTP id q15mr5086034jab.22.1551363124742;
 Thu, 28 Feb 2019 06:12:04 -0800 (PST)
Date:   Thu, 28 Feb 2019 06:12:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7d1840582f4df63@google.com>
Subject: kernel panic: MAC Initialization failed. (3)
From:   syzbot <syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com>
To:     jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    42fd8df9d1d9 Add linux-next specific files for 20190228
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=179e9b6cc00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0f38652d28b522f
dashboard link: https://syzkaller.appspot.com/bug?extid=2ee3f8974c2e7dc69feb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c68242c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17190c8ac00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2ee3f8974c2e7dc69feb@syzkaller.appspotmail.com

RIP: 0033:0x440fe9
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc37062bd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000440fe9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007ffc37062bf0 R08: 0000000000001000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
ERROR: Out of memory at tomoyo_realpath_from_path.
Kernel panic - not syncing: MAC Initialization failed.
CPU: 0 PID: 7764 Comm: syz-executor980 Not tainted 5.0.0-rc8-next-20190228  
#45
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x65c kernel/panic.c:214
  tomoyo_warn_oom.cold+0x35/0x43 security/tomoyo/memory.c:28
  tomoyo_realpath_from_path+0x3a8/0x730 security/tomoyo/realpath.c:320
  tomoyo_realpath_nofollow+0xc8/0xdb security/tomoyo/realpath.c:336
  tomoyo_find_next_domain+0x28c/0x1f8a security/tomoyo/domain.c:725
  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:107 [inline]
  tomoyo_bprm_check_security+0x12a/0x1b0 security/tomoyo/tomoyo.c:97
  security_bprm_check+0x69/0xb0 security/security.c:751
  search_binary_handler+0x77/0x570 fs/exec.c:1644
  exec_binprm fs/exec.c:1698 [inline]
  __do_execve_file.isra.0+0x1394/0x23f0 fs/exec.c:1818
  do_execveat_common fs/exec.c:1865 [inline]
  do_execveat fs/exec.c:1893 [inline]
  __do_sys_execveat fs/exec.c:1969 [inline]
  __se_sys_execveat fs/exec.c:1961 [inline]
  __x64_sys_execveat+0xed/0x130 fs/exec.c:1961
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440fe9
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc37062bd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000142
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000440fe9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007ffc37062bf0 R08: 0000000000001000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000004 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with  
syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
