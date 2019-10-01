Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401EFFA373E
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9C52133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbfJAIJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:09:08 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40637 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfJAIJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:09:08 -0400
Received: by mail-io1-f71.google.com with SMTP id r20so36865194ioh.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 01:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=+vGgDvKn1cMKLBMF1L69reyduTNPbvYJrDBpBof0mjY=;
        b=D6SmpCaz3y01RczrbiPX8dzWU9TIO1fivXyLSwPLOq7xf1l7hqsrT9PboHLvS/Hvsu
         2AUVnMYoECWb5G47A3iOa40fAIl1OFZtXDQZXeY9moR3CNMIFE79UAigW8xjwmJO7zv/
         S6W3lRp7O5/aFQzxarDHeR/8nlOisHtApKbgseAQo+C5lnu+TDz3JBBhqE8mXsBsGvDw
         Hmu++prVnP/lzWo7cgfKMzUbA8dRtMbCVcOLt0k7NBYccs3l4rKBXYVT/fBn8ATfiA1g
         sKqQNwYuqvDM9JgYeS0gE9IdhsFzmU2ydbqagyoYPY1xJmYD1BF43PvjTfsSgON1ea6y
         ihGw==
X-Gm-Message-State: APjAAAVpfzJfm/rYsBi5GulmTCSrDdeueNfyFM8nWFK8waVhB2R98Zpw
        IwtnquGTrb0l/QEXHPXUpqii0DQ2HPOrUJG6l1omgnp2fvuI
X-Google-Smtp-Source: APXvYqzmX5mWiVF2bglvt98koEoG94xVRIQT8dcIi0WrF9NPtLXSZl8Eg1XGNd6CSQ06E5nks/2M21Z3Pf0JCLBOoD5bcW13oz6i
MIME-Version: 1.0
X-Received: by 2002:a5e:da0a:: with SMTP id x10mr25852626ioj.286.1569917347210;
 Tue, 01 Oct 2019 01:09:07 -0700 (PDT)
Date:   Tue, 01 Oct 2019 01:09:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ceadfd0593d4dd55@google.com>
Subject: WARNING: lock held when returning to user space in membarrier_private_expedited
From:   syzbot <syzbot+6b6a46cc150b19f54ad6@syzkaller.appspotmail.com>
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

HEAD commit:    afb37288 Add linux-next specific files for 20191001
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17619635600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=659cb5bf73e72c6c
dashboard link: https://syzkaller.appspot.com/bug?extid=6b6a46cc150b19f54ad6
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176faa13600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b825cd600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6b6a46cc150b19f54ad6@syzkaller.appspotmail.com

================================================
WARNING: lock held when returning to user space!
5.4.0-rc1-next-20191001 #0 Not tainted
------------------------------------------------
syz-executor589/9088 is leaving the kernel with locks still held!
1 lock held by syz-executor589/9088:
  #0: ffffffff88faadc0 (rcu_read_lock){....}, at:  
membarrier_private_expedited+0x180/0x590 kernel/sched/membarrier.c:150
------------[ cut here ]------------
WARNING: CPU: 0 PID: 9088 at kernel/rcu/tree_plugin.h:293  
rcu_note_context_switch+0x373/0x1910 kernel/rcu/tree_plugin.h:293
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 9088 Comm: syz-executor589 Not tainted 5.4.0-rc1-next-20191001  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:220
  __warn.cold+0x2f/0x3c kernel/panic.c:581
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:rcu_note_context_switch+0x373/0x1910 kernel/rcu/tree_plugin.h:293
Code: 8b 13 48 85 d2 75 c3 48 8b 5d c8 65 ff 0d dd 75 a1 7e 0f 85 fa fc ff  
ff e8 4a df 9f ff e9 f0 fc ff ff 85 d2 0f 8e 62 fe ff ff <0f> 0b e9 1f fe  
ff ff 65 8b 1d ff 0a a1 7e 83 fb 3f 0f 87 0d 0e 00
RSP: 0000:ffff888090017d60 EFLAGS: 00010002
RAX: ffffffff89c60674 RBX: ffff8880ae835ac0 RCX: 1ffff110148334c7
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff8880a419a638
RBP: ffff888090017dd0 R08: 1ffffffff138ba90 R09: fffffbfff138ba91
R10: fffffbfff138ba90 R11: ffffffff89c5d487 R12: 0000000000000000
R13: ffff8880a419a2c0 R14: 0000000000000000 R15: ffff8880ae834d18
  __schedule+0x25e/0x1e70 kernel/sched/core.c:4007
  schedule+0xd9/0x260 kernel/sched/core.c:4136
  exit_to_usermode_loop+0x195/0x380 arch/x86/entry/common.c:149
  prepare_exit_to_usermode+0x2ff/0x370 arch/x86/entry/common.c:194
  retint_user+0x8/0x18
RIP: 0033:0x446ed9
Code: e8 5c 14 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 ab 0e fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f082bf04db8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 00000000006dcc38 RCX: 0000000000446ed9
RDX: 0000000000403494 RSI: 0000000000000000 RDI: 0000000100000008
RBP: 00000000006dcc30 R08: 00007f082bf05700 R09: 0000000000000000
R10: 00007f082bf05700 R11: 0000000000000246 R12: 00000000006dcc3c
R13: 00007ffef65e667f R14: 00007f082bf059c0 R15: 0000000000000001
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
