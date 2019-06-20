Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85773C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 657362080D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 13:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbfFTNRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 09:17:07 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52323 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731958AbfFTNRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 09:17:06 -0400
Received: by mail-io1-f72.google.com with SMTP id p12so5148038iog.19
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 06:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qnpm2ey2SaMdFsp844f8fqM6l7lFZy4hxhn4zu2c9Q0=;
        b=s5oZM7eaipPU6WIvFft/DZTQaiQAhz86kuhl71XEPlYb0ZkpBUjQtNUKuNPtLqokLX
         W8zWiDFw2jAlWUlS/U6PLM1AxxwloQ3hSXWnRjkwEZ5I22Oc37Mwa2sYDNY3LMjfv5hP
         Zzdblwy0378OVsAILcxI/yeF8DdM7NAPzp7EDMwiaNGTsKRCsbzVmiG62cjxMWeY5MFn
         YY4R1h6yjQBCJPRQ+Tf+vMPUpykZK4/2YxPWGLshexM2GKcIvj90ZUB6kq/k6xXr0S6j
         U3rK47n0cX2SQf+sa8b1NjBriZEd0DAYHDsHbXx0zswncNAte6eYH6ngaD8EexIcr+up
         O09g==
X-Gm-Message-State: APjAAAUqKfTaEw6Tw2tGMvWCN1LFnRpDbntjAsQwmIcM7ruuIax9UMdy
        67FF6MpvGhxLkeDjfizoLUrnx/FVDQmlCuwkDI/mz7OqR+AW
X-Google-Smtp-Source: APXvYqz5aZ3aKR/AVT0K9maciDso0v/J6cBLOy939L8NQzi44H2SoxoDLRpc5re9zZKKtPXX0im9kkZl2LTzEGPzwVpwenkSXcxE
MIME-Version: 1.0
X-Received: by 2002:a5e:cb43:: with SMTP id h3mr6987571iok.252.1561036626090;
 Thu, 20 Jun 2019 06:17:06 -0700 (PDT)
Date:   Thu, 20 Jun 2019 06:17:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000946842058bc1291d@google.com>
Subject: WARNING in add_event_to_ctx
From:   syzbot <syzbot+704bfe2c7d156640ad7a@syzkaller.appspotmail.com>
To:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        jolsa@redhat.com, kafai@fb.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org,
        peterz@infradead.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    abf02e29 Merge tag 'pm-5.2-rc6' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129072e6a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28ec3437a5394ee0
dashboard link: https://syzkaller.appspot.com/bug?extid=704bfe2c7d156640ad7a
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d8b732a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f7a5e6a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+704bfe2c7d156640ad7a@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 8131 at kernel/events/core.c:1835 perf_group_attach  
kernel/events/core.c:1835 [inline]
WARNING: CPU: 0 PID: 8131 at kernel/events/core.c:1835  
add_event_to_ctx+0x1351/0x1630 kernel/events/core.c:2393
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8131 Comm: syz-executor982 Not tainted 5.2.0-rc5+ #4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  panic+0x28a/0x7c9 kernel/panic.c:219
  __warn+0x216/0x220 kernel/panic.c:576
  report_bug+0x190/0x290 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0xd7/0x450 arch/x86/kernel/traps.c:272
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:perf_group_attach kernel/events/core.c:1835 [inline]
RIP: 0010:add_event_to_ctx+0x1351/0x1630 kernel/events/core.c:2393
Code: ff e8 d3 19 e6 ff 0f 0b e9 88 ed ff ff e8 c7 19 e6 ff 0f 0b e9 42 ed  
ff ff e8 bb 19 e6 ff 0f 0b e9 4f f8 ff ff e8 af 19 e6 ff <0f> 0b e9 d5 f8  
ff ff 48 c7 c1 a0 31 dd 88 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffff888094cdf900 EFLAGS: 00010093
RAX: ffffffff818f9841 RBX: ffff888085d7c418 RCX: ffff888099a064c0
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff888094cdf988 R08: ffffffff818f90aa R09: ffffed101299bf21
R10: ffffed101299bf20 R11: 1ffff1101299bf20 R12: dffffc0000000000
R13: ffff888085d7c200 R14: ffffe8ffffc15758 R15: ffff888085d7ca80
  __perf_install_in_context+0x54a/0x7e0 kernel/events/core.c:2544
  remote_function+0xeb/0x170 kernel/events/core.c:86
  generic_exec_single+0x114/0x420 kernel/smp.c:154
  smp_call_function_single+0x1a5/0x410 kernel/smp.c:300
  cpu_function_call kernel/events/core.c:140 [inline]
  perf_install_in_context+0x26b/0x5a0 kernel/events/core.c:2580
  __do_sys_perf_event_open kernel/events/core.c:11110 [inline]
  __se_sys_perf_event_open+0x224a/0x3270 kernel/events/core.c:10739
  __x64_sys_perf_event_open+0xbf/0xd0 kernel/events/core.c:10739
  do_syscall_64+0xfe/0x140 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446b69
Code: e8 8c 19 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b 0c fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2b0c7bddb8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00000000006dcc28 RCX: 0000000000446b69
RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 0000000020000000
RBP: 00000000006dcc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00000000006dcc2c
R13: 00007fff27b1f69f R14: 00007f2b0c7be9c0 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
