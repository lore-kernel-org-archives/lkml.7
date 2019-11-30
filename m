Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F151AC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0CD2073C
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 19:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbfK3TvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 14:51:09 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:38239 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbfK3TvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 14:51:09 -0500
Received: by mail-io1-f69.google.com with SMTP id q4so22808182ion.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2019 11:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=N9tfN3qXh1nim/ONWEuXOYplZXsxxiAUSxKXDJcWegs=;
        b=U3ENKreHSkAovwSO+bqM5aDgCKnKkLl6LDmxkuPqC0b6V7vu095cGe8N1ZNFFLpi5o
         R39Q8t5lU7n24CS4kA4eFHphJflAUhtSEMkU4KtBpPVTjs9lYKBXM9r7xMgAaSKsjslr
         J4F+lsMGArPrS3pIuQquskbxfy+qpcOGbZiUCiCTDjWy0bPQLizMkqEAuyAIcIfmN+VC
         rVBY3QQ57gDdIMk9AgDbtd1r+ghP1kcOgebc/VVuL24PyUPyj1Wb8tobBy2+Vcj7fFC9
         ERLi+C7bAAY1Wt4nCz0J8wU17zo9s/QQudehUi+K4vO1KzDfqU8X6s/aMkGqAK+rafYr
         Ajyw==
X-Gm-Message-State: APjAAAVKtl0gcnyWYrfkOm7eizG39t1gABfIJHjCYMIwjehlWdOB2cyl
        KBAim/N1u1cB+VogBJOG1mBCFJ5svXHAWCP5LEpBCCKlZPPe
X-Google-Smtp-Source: APXvYqzt7/++NFmLHVSdLkd0VbgMT24DiahmSpV4smSgpnwwmFIeEMB102THMO+a12HTYtPMK0aufWqqPSOLvJCI0nu3WIO3wT/2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5c8:: with SMTP id l8mr10026679ils.287.1575143467310;
 Sat, 30 Nov 2019 11:51:07 -0800 (PST)
Date:   Sat, 30 Nov 2019 11:51:07 -0800
In-Reply-To: <0000000000007cace40598282858@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d6e755059895aad8@google.com>
Subject: Re: WARNING: refcount bug in smc_release (2)
From:   syzbot <syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kgraul@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        ubraun@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    81b6b964 Merge branch 'master' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ce0abce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333b76551307b2a0
dashboard link: https://syzkaller.appspot.com/bug?extid=96d3f9ff6a86d37e44c8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175a767ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+96d3f9ff6a86d37e44c8@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 9419 at lib/refcount.c:28  
refcount_warn_saturate+0x1dc/0x1f0 lib/refcount.c:28
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9419 Comm: syz-executor.0 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x3e kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  fixup_bug arch/x86/kernel/traps.c:169 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:refcount_warn_saturate+0x1dc/0x1f0 lib/refcount.c:28
Code: e9 d8 fe ff ff 48 89 df e8 31 65 25 fe e9 85 fe ff ff e8 07 37 e8 fd  
48 c7 c7 60 53 4f 88 c6 05 7d b6 a5 06 01 e8 73 eb b8 fd <0f> 0b e9 ac fe  
ff ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 55 48
RSP: 0018:ffff88808963fd50 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815e4316 RDI: ffffed10112c7f9c
RBP: ffff88808963fd60 R08: ffff8880977a64c0 R09: ffffed1015d26621
R10: ffffed1015d26620 R11: ffff8880ae933107 R12: 0000000000000003
R13: 0000000000000000 R14: ffff8880965c0100 R15: ffff888094244a98
  refcount_sub_and_test include/linux/refcount.h:261 [inline]
  refcount_dec_and_test include/linux/refcount.h:281 [inline]
  sock_put include/net/sock.h:1728 [inline]
  smc_release+0x445/0x520 net/smc/af_smc.c:202
  __sock_release+0xce/0x280 net/socket.c:591
  sock_close+0x1e/0x30 net/socket.c:1269
  __fput+0x2ff/0x890 fs/file_table.c:280
  ____fput+0x16/0x20 fs/file_table.c:313
  task_work_run+0x145/0x1c0 kernel/task_work.c:113
  tracehook_notify_resume include/linux/tracehook.h:188 [inline]
  exit_to_usermode_loop+0x316/0x380 arch/x86/entry/common.c:164
  prepare_exit_to_usermode arch/x86/entry/common.c:195 [inline]
  syscall_return_slowpath arch/x86/entry/common.c:278 [inline]
  do_syscall_64+0x676/0x790 arch/x86/entry/common.c:304
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x414211
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48  
83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48  
89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffc46c3b260 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000414211
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 0000000000000000 R08: ffffffffffffffff R09: ffffffffffffffff
R10: 00007ffc46c3b340 R11: 0000000000000293 R12: 000000000075bfc8
R13: 00000000000ee743 R14: 0000000000760458 R15: 000000000075bfd4
Kernel Offset: disabled
Rebooting in 86400 seconds..

