Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC01C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F7221A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfKEXwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:52:10 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:44895 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730464AbfKEXwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:52:10 -0500
Received: by mail-io1-f71.google.com with SMTP id q13so16727625iot.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CjtY7g/EqHOjNQQmwYuK/rZC/ASQOgB65CkeH9oNxXI=;
        b=UKUs4lGkti/S633txjEHKPNbItonwhLbUBFBClnWeoMwW/g4WGXwMfVGJ7eijPfbdb
         Le+Y6GwM+Jw8YBqJGHwHou/N3vmtjpFsOcl5uTWrXoiWwnQYq0UD4UvJlKzRciDWODW3
         lMB9HV+9G5HgJGc1/BiMD+CvMW267iaQqDsrXIHLFNLI52aOKlWDeZQ3l2jERBNDPHlo
         0yB4j/EGJpPhzN7wKxdAQODejE2mVbmsKrNdiGPEKparOqMJyjlBnOlg/QuB6ISgiey5
         dFv+1OqzVapz9PsJbfVo/z1fJFWpcJKbhhvk5STmaC6mvXZVSOzDTo5OV30LDCuNmsOx
         dPcw==
X-Gm-Message-State: APjAAAUTCPSvhz/cCW+qwhrh4wtRMNTq0XPXuFJV5u61oOMAPR9RMHRk
        8S2GOrXFtAUZn9XgTsnnB7gvz47YkRQCdKDDUBb4qTCWbQ81
X-Google-Smtp-Source: APXvYqwVkN0CadsC6BBfunsGllxXlvVFG9CMKQt3cdQr/eILv0c2i8nnKIT14d7Ll41X1CIxxSBCbTpLXlCKwCSnqzBZ4zSol3TI
MIME-Version: 1.0
X-Received: by 2002:a92:91d3:: with SMTP id e80mr38694444ill.77.1572997928995;
 Tue, 05 Nov 2019 15:52:08 -0800 (PST)
Date:   Tue, 05 Nov 2019 15:52:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca5b3f0596a21e0c@google.com>
Subject: general protection fault in pagemap_pmd_range
From:   syzbot <syzbot+a0fc447639c6ffa66b59@syzkaller.appspotmail.com>
To:     aarcange@redhat.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, alex@ghiti.fr,
        aneesh.kumar@linux.ibm.com, aou@eecs.berkeley.edu,
        ard.biesheuvel@linaro.org, arnd@arndb.de, aryabinin@virtuozzo.com,
        benh@kernel.crashing.org, borntraeger@de.ibm.com, bp@alien8.de,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        dave.jiang@intel.com, davem@davemloft.net, dvyukov@google.com,
        glider@google.com, gor@linux.ibm.com, guro@fb.com,
        heiko.carstens@de.ibm.com, hpa@zytor.com, ira.weiny@intel.com,
        james.morse@arm.com, jgg@ziepe.ca, jglisse@redhat.com,
        jhogan@kernel.org, kan.liang@linux.intel.com,
        khlebnikov@yandex-team.ru, ktkhai@virtuozzo.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, luto@kernel.org, mark.rutland@arm.com,
        mawilcox@microsoft.com, mhocko@suse.com, mingo@elte.hu,
        mingo@redhat.com, mpe@ellerman.id.au, n-horiguchi@ah.jp.nec.com,
        palmer@sifive.com, paul.burton@mips.com, paul.walmsley@sifive.com,
        paulus@samba.org, peterz@infradead.org, ralf@linux-mips.org,
        semenzato@chromium.org, sfr@canb.auug.org.au,
        shashim@codeaurora.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    51309b9d Add linux-next specific files for 20191105
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11ad1658e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9b1a641c1f1fc52
dashboard link: https://syzkaller.appspot.com/bug?extid=a0fc447639c6ffa66b59
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164e5f92e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c65bcce00000

The bug was bisected to:

commit 181be542ef3c9ca495500143d4c23f4d58beb5ab
Author: Steven Price <steven.price@arm.com>
Date:   Mon Nov 4 22:57:54 2019 +0000

     mm: pagewalk: allow walking without vma

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11341968e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13341968e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15341968e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a0fc447639c6ffa66b59@syzkaller.appspotmail.com
Fixes: 181be542ef3c ("mm: pagewalk: allow walking without vma")

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8839 Comm: syz-executor009 Not tainted 5.4.0-rc6-next-20191105  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:pmd_trans_huge_lock include/linux/huge_mm.h:219 [inline]
RIP: 0010:pagemap_pmd_range+0x83/0x1e40 fs/proc/task_mmu.c:1373
Code: c1 ea 03 80 3c 02 00 0f 85 ef 1a 00 00 48 8b 43 18 49 8d 7f 40 48 89  
fa 48 c1 ea 03 48 89 45 c8 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 0f  
85 be 1a 00 00 49 8b 5f 40 be 08 00 00 00 4c 8d ab
RSP: 0018:ffff8880a4e4f288 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880a4e4f438 RCX: ffff8880a4e4f438
RDX: 0000000000000008 RSI: ffffffff81dd1b94 RDI: 0000000000000040
RBP: ffff8880a4e4f300 R08: ffff8880992ee040 R09: ffffed1012180ad2
R10: ffffed1012180ad1 R11: ffff888090c0568b R12: ffff8880a53a2010
R13: 0000000000600000 R14: 00000000005fffff R15: 0000000000000000
FS:  000000000172c880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455150 CR3: 000000009f949000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  walk_pmd_range mm/pagewalk.c:78 [inline]
  walk_pud_range mm/pagewalk.c:149 [inline]
  walk_p4d_range mm/pagewalk.c:190 [inline]
  walk_pgd_range mm/pagewalk.c:223 [inline]
  __walk_page_range+0x10ff/0x1b40 mm/pagewalk.c:318
  walk_page_range+0x1c5/0x3b0 mm/pagewalk.c:406
  pagemap_read+0x4d1/0x650 fs/proc/task_mmu.c:1596
  do_loop_readv_writev fs/read_write.c:714 [inline]
  do_loop_readv_writev fs/read_write.c:701 [inline]
  do_iter_read+0x4a4/0x660 fs/read_write.c:935
  vfs_readv+0xf0/0x160 fs/read_write.c:997
  kernel_readv fs/splice.c:359 [inline]
  default_file_splice_read+0x482/0x8a0 fs/splice.c:414
  do_splice_to+0x127/0x180 fs/splice.c:877
  splice_direct_to_actor+0x2d3/0x970 fs/splice.c:955
  do_splice_direct+0x1da/0x2a0 fs/splice.c:1064
  do_sendfile+0x597/0xd00 fs/read_write.c:1464
  __do_sys_sendfile64 fs/read_write.c:1525 [inline]
  __se_sys_sendfile64 fs/read_write.c:1511 [inline]
  __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4401e9
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffcb2c0cd38 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004401e9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000012 R09: 65732f636f72702f
R10: 0000100000206201 R11: 0000000000000246 R12: 0000000000401ad0
R13: 0000000000401b60 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace d938329fe3462ca9 ]---
RIP: 0010:pmd_trans_huge_lock include/linux/huge_mm.h:219 [inline]
RIP: 0010:pagemap_pmd_range+0x83/0x1e40 fs/proc/task_mmu.c:1373
Code: c1 ea 03 80 3c 02 00 0f 85 ef 1a 00 00 48 8b 43 18 49 8d 7f 40 48 89  
fa 48 c1 ea 03 48 89 45 c8 48 b8 00 00 00 00 00 fc ff df <80> 3c 02 00 0f  
85 be 1a 00 00 49 8b 5f 40 be 08 00 00 00 4c 8d ab
RSP: 0018:ffff8880a4e4f288 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880a4e4f438 RCX: ffff8880a4e4f438
RDX: 0000000000000008 RSI: ffffffff81dd1b94 RDI: 0000000000000040
RBP: ffff8880a4e4f300 R08: ffff8880992ee040 R09: ffffed1012180ad2
R10: ffffed1012180ad1 R11: ffff888090c0568b R12: ffff8880a53a2010
R13: 0000000000600000 R14: 00000000005fffff R15: 0000000000000000
FS:  000000000172c880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000455150 CR3: 000000009f949000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
