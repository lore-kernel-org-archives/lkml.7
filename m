Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1350C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99DF20693
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbfC2PgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:36:08 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:59430 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfC2PgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:36:07 -0400
Received: by mail-it1-f200.google.com with SMTP id q192so2407497itb.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 08:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Oc245fybSc0T4O7T54xX7AwUdVmu/tW4J8w/2a5WmsI=;
        b=fi5ObelcCePo6QM+HJCb7ecrN/j+G76ek7piSO4CRCW4OY4oXh3ZzZogyaHthEu0A+
         kaSVrS7oMw6BZSA+wQbXlu4mSA9K8QYeG2YJBjDM3yvV5wCZHtCh58XxOIiPh8tzDl0A
         lmR1obK8vXKCP8nysaQNmsePDn9dk9D6cYu1k9Ynb5qZnN41O42T9vaChr/YZxX8gApA
         whLzwuwGh5a5UN8ToXttPk6opkz7wiNQiUzz8yidBnKwQpizQIg2oUlPK1t9luXB5b/0
         0VUMg+nw5XoJTNNLetsy0TxIRG9bvcIGpjm8E3FkSSW4y3mPr0U6e34y+eBrW6tsxEEQ
         phrA==
X-Gm-Message-State: APjAAAVn8Rfxu3FPWSH8Oa33kmos5uQZYfhx1F90cIZiv8W0nw2QG1p6
        4wvnmtx2sT4gSR5gWZCRLV4HPjBnTMCpFLQhl05Zl0C/K1NP
X-Google-Smtp-Source: APXvYqx8tjRjN30oVeGO/83+kYvIW2FrwKJV9xH+a4hr73we0oamoVjI9FTR9y3ktGk8ymYpT2Hl+guSfhKhgTulj6zsQ1Qkf45y
MIME-Version: 1.0
X-Received: by 2002:a5d:899a:: with SMTP id m26mr5532666iol.5.1553873766301;
 Fri, 29 Mar 2019 08:36:06 -0700 (PDT)
Date:   Fri, 29 Mar 2019 08:36:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ddc91405853d6de3@google.com>
Subject: general protection fault in load_elf_binary
From:   syzbot <syzbot+0d1fcd7268b21baced4a@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1baf02ec Add linux-next specific files for 20190329
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=107d8e53200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d8e70f94f3533a7
dashboard link: https://syzkaller.appspot.com/bug?extid=0d1fcd7268b21baced4a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125ca12f200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e1123f200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0d1fcd7268b21baced4a@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7588 Comm: syz-executor559 Not tainted 5.1.0-rc2-next-20190329  
#14
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:allow_write_access include/linux/fs.h:2871 [inline]
RIP: 0010:load_elf_binary+0x167c/0x5b10 fs/binfmt_elf.c:1179
Code: b8 fe ff ff e8 65 8c db ff e8 70 23 a3 ff 48 8b 85 f8 fe ff ff 48 8d  
78 20 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 b2 3e 00 00 4c 8b bd f8 fe ff ff be 04 00 00 00
RSP: 0018:ffff88808db17bf8 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 00000000fffffffe RCX: 1ffffffff12be8fb
RDX: 0000000000000003 RSI: ffffffff81cd3e10 RDI: 000000000000001e
RBP: ffff88808db17d78 R08: ffff88808fc746c0 R09: fffffbfff11a6d55
R10: fffffbfff11a6d54 R11: ffffffff88d36aa3 R12: 0000000000000000
R13: ffff8880905992c0 R14: ffff8880962d7240 R15: ffff88809433aac0
FS:  00007f00b549e700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001140 CR3: 00000000902b1000 CR4: 00000000001406f0
Call Trace:
  search_binary_handler fs/exec.c:1656 [inline]
  search_binary_handler+0x17f/0x570 fs/exec.c:1634
  exec_binprm fs/exec.c:1698 [inline]
  __do_execve_file.isra.0+0x1394/0x23f0 fs/exec.c:1818
  do_execveat_common fs/exec.c:1865 [inline]
  do_execve fs/exec.c:1882 [inline]
  __do_sys_execve fs/exec.c:1958 [inline]
  __se_sys_execve fs/exec.c:1953 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1953
  do_syscall_64+0x103/0x610 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x447139
Code: e8 4c 15 03 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 eb 0e fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f00b549dce8 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000006dcc28 RCX: 0000000000447139
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00000000006dcc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dcc2c
R13: 00007ffcb2d5610f R14: 00007f00b549e9c0 R15: 0000000000000000
Modules linked in:
---[ end trace 2e60703d22657961 ]---
RIP: 0010:allow_write_access include/linux/fs.h:2871 [inline]
RIP: 0010:load_elf_binary+0x167c/0x5b10 fs/binfmt_elf.c:1179
Code: b8 fe ff ff e8 65 8c db ff e8 70 23 a3 ff 48 8b 85 f8 fe ff ff 48 8d  
78 20 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 b2 3e 00 00 4c 8b bd f8 fe ff ff be 04 00 00 00
RSP: 0018:ffff88808db17bf8 EFLAGS: 00010207
RAX: dffffc0000000000 RBX: 00000000fffffffe RCX: 1ffffffff12be8fb
RDX: 0000000000000003 RSI: ffffffff81cd3e10 RDI: 000000000000001e
RBP: ffff88808db17d78 R08: ffff88808fc746c0 R09: fffffbfff11a6d55
R10: fffffbfff11a6d54 R11: ffffffff88d36aa3 R12: 0000000000000000
R13: ffff8880905992c0 R14: ffff8880962d7240 R15: ffff88809433aac0
FS:  00007f00b549e700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001140 CR3: 00000000902b1000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
