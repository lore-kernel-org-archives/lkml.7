Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C209C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 482282070B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 21:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfJBVgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 17:36:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49346 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfJBVgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 17:36:10 -0400
Received: by mail-io1-f72.google.com with SMTP id e14so1186764iot.16
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 14:36:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=U6yNaCDsE4C1a0nqy2EzS05kA23AzgH1kqOijvBxX34=;
        b=mBbtGaNKyMFdfGoYMKRBSTinxTlu9w71Sz+O10oDRT7UxrylbZc5r1tjULVnMSXVS/
         to6161GrMFuGxkmCNREwqvBMzGDRI7wy5TOyS6ctT9TU0q/hzTWPabOqWfGlCTrxPylj
         iy9YX7h4ga4rQefCZ237C4L/qF/kHJ8WLXDTrlz+PFKtpw4Ihpdsx6fFIaLqidUIa/4b
         TkRWdDL2xyTZPLRVAeftmiKxcbQhVUwlG1DP4F738FdmNrTMZ4FxAcQTc8vT/IUXTtW/
         ZyQphNIwYvIIQf+Zjqn/6QwqG746KHds3/1/A/yWTMawxqwbLlBr63+2eMoK+t0xebZm
         BEOA==
X-Gm-Message-State: APjAAAUuPVO06M+1UmkWm0m03lBba/nDlZ68lRIyKfdmMVgznnPePxQF
        ZmjupsZ0PQrzvuk591xKmnuea58wDSfl1kednQtWNYFpLuFA
X-Google-Smtp-Source: APXvYqz84p004yWghPZveHBFK3yktOp+B+HGXF1JsVCRYIW9aAb7UHeKwGrNH3CJuRv2mGNrrkSNJI7WCnvD/Ci3aaxjBdUgq/m4
MIME-Version: 1.0
X-Received: by 2002:a02:3786:: with SMTP id r128mr6274031jar.76.1570052169345;
 Wed, 02 Oct 2019 14:36:09 -0700 (PDT)
Date:   Wed, 02 Oct 2019 14:36:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d537cc0593f441db@google.com>
Subject: WARNING: lock held when returning to user space in rcu_lock_acquire
From:   syzbot <syzbot+fef86971c84310f1c8cd@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    54ecb8f7 Linux 5.4-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c03fcd600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fb0b431ccdf08c1c
dashboard link: https://syzkaller.appspot.com/bug?extid=fef86971c84310f1c8cd
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d52e33600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1582402b600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+fef86971c84310f1c8cd@syzkaller.appspotmail.com

================================================
WARNING: lock held when returning to user space!
5.4.0-rc1 #0 Not tainted
------------------------------------------------
syz-executor670/7923 is leaving the kernel with locks still held!
1 lock held by syz-executor670/7923:
  #0: ffffffff888d3cc0 (rcu_read_lock){....}, at: rcu_lock_acquire+0x4/0x30  
include/linux/rcupdate.h:207
------------[ cut here ]------------
WARNING: CPU: 0 PID: 7923 at kernel/rcu/tree_plugin.h:293  
rcu_note_context_switch+0xdde/0xee0 kernel/rcu/tree_plugin.h:293
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 7923 Comm: syz-executor670 Not tainted 5.4.0-rc1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x1d8/0x2f8 lib/dump_stack.c:113
  panic+0x25c/0x799 kernel/panic.c:220
  __warn+0x20e/0x210 kernel/panic.c:581
  report_bug+0x1b6/0x2f0 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  do_error_trap+0xd7/0x440 arch/x86/kernel/traps.c:272
  do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:rcu_note_context_switch+0xdde/0xee0 kernel/rcu/tree_plugin.h:293
Code: c8 73 4b 00 e9 b8 f3 ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 22 f3  
ff ff 48 89 df e8 4b 73 4b 00 83 3b 00 0f 8e 1a f3 ff ff <0f> 0b e9 13 f3  
ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c c9 f2 ff
RSP: 0000:ffff8880921bfd20 EFLAGS: 00010002
RAX: 1ffff11012bc6100 RBX: ffff888095e30978 RCX: ffffffff81608604
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff88be39a0
RBP: ffff8880921bfe00 R08: dffffc0000000000 R09: fffffbfff117c735
R10: fffffbfff117c735 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff888095e30600 R14: 0000000000000000 R15: ffff8880aea35740
  __schedule+0xce/0xb80 kernel/sched/core.c:4007
  schedule+0x131/0x1e0 kernel/sched/core.c:4136
  exit_to_usermode_loop arch/x86/entry/common.c:149 [inline]
  prepare_exit_to_usermode+0x2aa/0x580 arch/x86/entry/common.c:194
  retint_user+0x8/0x18
RIP: 0033:0x446fb9
Code: e8 8c 19 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4b 0e fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fd680470db8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 00000000006ddc28 RCX: 0000000000446fb9
RDX: 0000000000446fb9 RSI: 0000000000000000 RDI: 0000000100000008
RBP: 00000000006ddc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006ddc2c
R13: 00007fffb42e414f R14: 00007fd6804719c0 R15: 0000000000000000
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
