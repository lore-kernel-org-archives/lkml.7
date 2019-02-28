Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B94AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CEE218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 06:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfB1GmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 01:42:05 -0500
Received: from mail-it1-f200.google.com ([209.85.166.200]:41138 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbfB1GmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 01:42:05 -0500
Received: by mail-it1-f200.google.com with SMTP id q184so7455002itd.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 22:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=5HdRhn6bZ4Wmiuk71bjpk8k0oy68YBXu4A3FQsmwrRU=;
        b=WYeq5qv7MUYGAHRsP7HsVZQzOdU0VJ42l/F8MikI9Lvw2/wLpiMZIW+qNZnuYc1Os4
         6qAhNBO0wht6BuM2/9/nbpRjApdMjsh8H2acPEylVGvL6pi/ZgjmkFMFZgBqKyTqxE0l
         eEYbB9aroqW7PNAvvFnuYmn52X5AsCNUmeuXNzRePlTWtdMm7l93KQRrm0EN/1Kqi8Fn
         AhqSSGQ+TAqWujXN2zD58OQi+U0t5NO1ZPY79De4HuPb3CmoIF7ql9pHklLT1SitUlth
         U28HSL9EnqRLdnasAwjV3WmgjMah7vCR70cd+Y2DqL/YGYZSP6a7XESRI59A7MWSp7Ti
         h6Hg==
X-Gm-Message-State: AHQUAuZTDbALTSnll6vcsoSv0MXTXbAPC7y1dlTwbt8tmnWM12uMjE2j
        HnaUPcLY5BrIVYp33w+J7J5bz+anf7jP+DuJvw/PAk+RpvCl
X-Google-Smtp-Source: AHgI3IbORpxDuMVNcc8yYW+jCH/2jiuIXsIt+geWoHAsc3dyOjESQ9FPoLMJRDz2/CKIlCnZaUIeuhag9xVezTi7ls9AOAhEJE2+
MIME-Version: 1.0
X-Received: by 2002:a24:334a:: with SMTP id k71mr2062587itk.14.1551336124220;
 Wed, 27 Feb 2019 22:42:04 -0800 (PST)
Date:   Wed, 27 Feb 2019 22:42:04 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009c92240582ee96ce@google.com>
Subject: kernel panic: MAC Initialization failed. (2)
From:   syzbot <syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com>
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

HEAD commit:    7b827ff9af88 Add linux-next specific files for 20190227
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10f71894c00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5fa6b8975759dcc5
dashboard link: https://syzkaller.appspot.com/bug?extid=29569ed06425fcf67a95
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113a8242c00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154d6bd0c00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+29569ed06425fcf67a95@syzkaller.appspotmail.com

Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffca1453958 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000440ff9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00007ffca1453970 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
ERROR: Out of memory at tomoyo_realpath_from_path.
Kernel panic - not syncing: MAC Initialization failed.
CPU: 0 PID: 7505 Comm: syz-executor695 Not tainted 5.0.0-rc8-next-20190227  
#44
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
  do_execve fs/exec.c:1882 [inline]
  __do_sys_execve fs/exec.c:1958 [inline]
  __se_sys_execve fs/exec.c:1953 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1953
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440ff9
Code: e8 0c ad 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffca1453958 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000440ff9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00007ffca1453970 R08: 0000000000000002 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
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
