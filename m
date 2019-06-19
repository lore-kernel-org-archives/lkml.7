Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C98C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E44C2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 15:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbfFSP5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:57:15 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:35208 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbfFSP5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 11:57:10 -0400
Received: by mail-io1-f70.google.com with SMTP id w17so21830208iom.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 08:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=whrjj59amrI/WUTR01FTExxTfGEXciTSFYOt1whA9CU=;
        b=bwq2vWHRwymCamKgirDwGwlr+Uk6myUIFq7HL8Fg9U+C7fe0SVD4qO1FmCjM+b9/5c
         VrBGEphz4AGitz7FX7R6IDYxbTuGZ/WvcM5tVj1pCjq+snhHhrVn8d1HC+yth+wYIgrr
         cxI0DiNFwfRIDaBofDoDEpOsDPKhafCISoEAkp3VtKioqdWYo9L1aTXtb7Fml2tW8fES
         SuiNdDxsMjS3BCDk4kBWqq9crsx+zz8zkbJ+IUvTVpKT2O2vwnPUjzB+Rs/fJh7ZY072
         RH4vFKCtxA0p3TFFJVkqgh+Gb7IhkaTaot+MOsCNsaFYTY49RRz/3+ccj7dE9aZwwAcc
         Z5yw==
X-Gm-Message-State: APjAAAVhahVkPdP7ObYJsIGhIMlCvN+gPnRDg10je/W/NFusLeCU9peS
        CKvTMs+vDtX1610/E0lfBEJ+vY3YrI3I2zpL/ErX5AvEnO59
X-Google-Smtp-Source: APXvYqwgq3ZoO8nl8EPCp61ZQoZRvF2dYbB3fA17qGK8KFpq0qdU3SPQv2tfLek0qOVTYXgsWbpZ/zdc12Ud5oZ20D77IRC3nxOi
MIME-Version: 1.0
X-Received: by 2002:a5d:8ccc:: with SMTP id k12mr1593639iot.141.1560959828602;
 Wed, 19 Jun 2019 08:57:08 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:57:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017c9e2058baf4825@google.com>
Subject: BUG: unable to handle kernel paging request in __do_softirq
From:   syzbot <syzbot+0b224895cb9454584de1@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jacob.jun.pan@linux.intel.com,
        konrad.wilk@oracle.com, len.brown@intel.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, puwen@hygon.cn,
        rppt@linux.vnet.ibm.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    29f785ff Merge branch 'fixes' of git://git.kernel.org/pub/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d7464ea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c77f8090a3b96b
dashboard link: https://syzkaller.appspot.com/bug?extid=0b224895cb9454584de1
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1076d132a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+0b224895cb9454584de1@syzkaller.appspotmail.com

kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
BUG: unable to handle page fault for address: ffff88808eb889e0
#PF: supervisor instruction fetch in kernel mode
#PF: error_code(0x0011) - permissions violation
PGD b401067 P4D b401067 PUD 21ffff067 PMD 800000008ea001e3
Oops: 0011 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 9056 Comm: udevd Not tainted 5.2.0-rc5+ #36
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:0xffff88808eb889e0
Code: 00 00 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff ff ff 80 20 a8 94 80  
88 ff ff 00 00 00 00 00 00 00 00 a0 a9 1d 8b ff ff ff ff <10> 8a b8 8e 80  
88 ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff
RSP: 0018:ffff8880ae809e00 EFLAGS: 00010246
RAX: 1ffff11011d71136 RBX: ffff88808eb889b0 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffff88808eb889a8
RBP: ffff8880ae809f00 R08: 000000001dda059f R09: ffff888098310d88
R10: ffff888098310d68 R11: ffff8880983104c0 R12: ffff8880ae809ed8
R13: ffff88808eb889a8 R14: ffff88808eb889e0 R15: ffff8880ae809e78
FS:  00007fa9e44d17a0(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88808eb889e0 CR3: 0000000093130000 CR4: 00000000001406f0
Call Trace:
  <IRQ>
  __do_softirq+0x25c/0x94c kernel/softirq.c:292
  invoke_softirq kernel/softirq.c:373 [inline]
  irq_exit+0x180/0x1d0 kernel/softirq.c:413
  exiting_irq arch/x86/include/asm/apic.h:536 [inline]
  smp_apic_timer_interrupt+0x13b/0x550 arch/x86/kernel/apic/apic.c:1068
  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:806
  </IRQ>
RIP: 0010:tomoyo_domain_quota_is_ok+0x460/0x540 security/tomoyo/util.c:1039
Code: 48 b9 00 00 00 00 00 fc ff df 48 89 f8 48 89 fa 48 c1 e8 03 83 e2 07  
0f b6 04 08 38 d0 7f 98 84 c0 74 94 e8 42 ca ab fe eb 8d <e8> 0b 1e 73 fe  
49 8d 7c 24 1a 48 b9 00 00 00 00 00 fc ff df 48 89
RSP: 0018:ffff88807a8f77e0 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff82fda05c
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000001
RBP: ffff88807a8f7820 R08: ffff8880983104c0 R09: ffffed100f51ef11
R10: ffffed100f51ef10 R11: 0000000000000000 R12: ffff8880a9a0d580
R13: 0000000000000000 R14: 0000000000000185 R15: 0000000000000000
  tomoyo_supervisor+0x2e8/0xef0 security/tomoyo/common.c:2087
  tomoyo_audit_path_log security/tomoyo/file.c:168 [inline]
  tomoyo_path_permission security/tomoyo/file.c:587 [inline]
  tomoyo_path_permission+0x263/0x360 security/tomoyo/file.c:573
  tomoyo_path_perm+0x31d/0x430 security/tomoyo/file.c:838
  tomoyo_inode_getattr+0x1d/0x30 security/tomoyo/tomoyo.c:129
  security_inode_getattr+0xf2/0x150 security/security.c:1179
  vfs_getattr+0x25/0x70 fs/stat.c:115
  vfs_statx+0x157/0x200 fs/stat.c:191
  vfs_stat include/linux/fs.h:3193 [inline]
  __do_sys_newstat+0xa4/0x130 fs/stat.c:341
  __se_sys_newstat fs/stat.c:337 [inline]
  __x64_sys_newstat+0x54/0x80 fs/stat.c:337
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fa9e3bd8c65
Code: 00 00 00 e8 5d 01 00 00 48 83 c4 18 c3 90 90 90 90 90 90 90 90 83 ff  
01 48 89 f0 77 18 48 89 c7 48 89 d6 b8 04 00 00 00 0f 05 <48> 3d 00 f0 ff  
ff 77 17 f3 c3 90 48 8b 05 a1 51 2b 00 64 c7 00 16
RSP: 002b:00007ffd19df2268 EFLAGS: 00000246 ORIG_RAX: 0000000000000004
RAX: ffffffffffffffda RBX: 00007ffd19df2300 RCX: 00007fa9e3bd8c65
RDX: 00007ffd19df2270 RSI: 00007ffd19df2270 RDI: 00007ffd19df2300
RBP: 000000000165cf70 R08: 00007ffd19df2310 R09: 00007fa9e3c2efc0
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000165b250
R13: 0000000000000000 R14: 000000000165b250 R15: 000000000000000b
Modules linked in:
CR2: ffff88808eb889e0
---[ end trace 9983c7ba6b20cddb ]---
RIP: 0010:0xffff88808eb889e0
Code: 00 00 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff ff ff 80 20 a8 94 80  
88 ff ff 00 00 00 00 00 00 00 00 a0 a9 1d 8b ff ff ff ff <10> 8a b8 8e 80  
88 ff ff 15 b8 0d 86 ff ff ff ff 00 b5 0d 86 ff ff
RSP: 0018:ffff8880ae809e00 EFLAGS: 00010246
RAX: 1ffff11011d71136 RBX: ffff88808eb889b0 RCX: dffffc0000000000
RDX: dffffc0000000000 RSI: dffffc0000000000 RDI: ffff88808eb889a8
RBP: ffff8880ae809f00 R08: 000000001dda059f R09: ffff888098310d88
R10: ffff888098310d68 R11: ffff8880983104c0 R12: ffff8880ae809ed8
R13: ffff88808eb889a8 R14: ffff88808eb889e0 R15: ffff8880ae809e78
FS:  00007fa9e44d17a0(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88808eb889e0 CR3: 0000000093130000 CR4: 00000000001406f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
