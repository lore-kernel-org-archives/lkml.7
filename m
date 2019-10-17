Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B9ECE599
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5268F21D7C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 01:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404182AbfJQBmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 21:42:14 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:35680 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394851AbfJQBmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 21:42:12 -0400
Received: by mail-io1-f71.google.com with SMTP id r5so1053534iop.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 18:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pdOKNCOT2iOd0L50ws0JTyqK1/1Fhbj5YOUIjEEtEeY=;
        b=Z05RsICm9e8WhNirZS5cD/J3YsWAobM8ExGSH0+0zX5FZ53PmIT83I5CewpSLQAa8x
         /KOzdSqote3ra1RAtzTMlCcZcWvrq+X5VFX7ZWSvwAWN0we3ACVM1R1lMkybmhZidwnq
         WzAYhpP7L9OGw3hUNnT0DODXblzdiDkTXF4fUonrkdcaymh5f8rT9a/RTIVzbUz953E7
         vc+evxRsTwhGM45LcVnoQFa5DOp8B4eBxBkVdy/fv2sSrbmsbtOX5dl8dHc6PLcCSchw
         9LAuzV5lFuGbAHA7uwtCrdY7CRW1L2LkpENnw+SlbNN55/gdRmravrRE3TbfgSSq+6hZ
         Fiew==
X-Gm-Message-State: APjAAAU9Dq2bIyh4k+ia4pdJDTRgEUXK5X1VVCN8L1hQE9WZbsTW9QUb
        TcpQTgrWEUjUaGVr1HJNADAwIAQNYkUXiFDmeeEYVIo+N/um
X-Google-Smtp-Source: APXvYqxRmR24P4tLC5wLsEg00RDdkwn7cpnlNWTm+TEe/kShLT//SftvZNePTw+Nh4AATG5JiMrDivqjLxZEhJOqaYYkYY/P7gSW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3f2:: with SMTP id s18mr958868jaq.91.1571276531630;
 Wed, 16 Oct 2019 18:42:11 -0700 (PDT)
Date:   Wed, 16 Oct 2019 18:42:11 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000830fe50595115344@google.com>
Subject: WARNING: refcount bug in find_key_to_update
From:   syzbot <syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, jarkko.sakkinen@linux.intel.com,
        jmorris@namei.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bc88f85c kthread: make __kthread_queue_delayed_work static
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1730584b600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0ac4d9b35046343
dashboard link: https://syzkaller.appspot.com/bug?extid=6455648abc28dbdd1e7f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11c8adab600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6455648abc28dbdd1e7f@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: increment on 0; use-after-free.
WARNING: CPU: 1 PID: 9064 at lib/refcount.c:156 refcount_inc_checked  
lib/refcount.c:156 [inline]
WARNING: CPU: 1 PID: 9064 at lib/refcount.c:156  
refcount_inc_checked+0x61/0x70 lib/refcount.c:154
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 9064 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2e3/0x75c kernel/panic.c:221
  __warn.cold+0x2f/0x35 kernel/panic.c:582
  report_bug+0x289/0x300 lib/bug.c:195
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:refcount_inc_checked lib/refcount.c:156 [inline]
RIP: 0010:refcount_inc_checked+0x61/0x70 lib/refcount.c:154
Code: 1d 58 46 7e 06 31 ff 89 de e8 0b cb 2e fe 84 db 75 dd e8 c2 c9 2e fe  
48 c7 c7 40 ad e6 87 c6 05 38 46 7e 06 01 e8 67 0c 00 fe <0f> 0b eb c1 90  
90 90 90 90 90 90 90 90 90 90 55 48 89 e5 41 57 41
RSP: 0018:ffff888081447c68 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815cb646 RDI: ffffed1010288f7f
RBP: ffff888081447c78 R08: ffff8880a231a080 R09: ffffed1015d26159
R10: ffffed1015d26158 R11: ffff8880ae930ac7 R12: ffff8880a4518940
R13: 0000000000000000 R14: ffff888081447e10 R15: ffff8880a4518c40
  __key_get include/linux/key.h:281 [inline]
  find_key_to_update+0x8b/0xc0 security/keys/keyring.c:1127
  key_create_or_update+0x588/0xbe0 security/keys/key.c:905
  __do_sys_add_key security/keys/keyctl.c:132 [inline]
  __se_sys_add_key security/keys/keyctl.c:72 [inline]
  __x64_sys_add_key+0x2bd/0x4f0 security/keys/keyctl.c:72
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459a59
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f22e3171c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000f8
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000000459a59
RDX: 0000000020000440 RSI: 0000000020000000 RDI: 0000000020000040
RBP: 000000000075bf20 R08: fffffffffffffffe R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000246 R12: 00007f22e31726d4
R13: 00000000004bfab8 R14: 00000000004d1ad8 R15: 00000000ffffffff
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
