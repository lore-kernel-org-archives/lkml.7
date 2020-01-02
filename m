Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F80C2D0DE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6995620866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 02:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbgABCZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 21:25:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:38972 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABCZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 21:25:10 -0500
Received: by mail-il1-f197.google.com with SMTP id n6so34295922ile.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 18:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=SfIhuLbC24ynjx58AFxhyPbsZxx1hf2f9u1ZhYuHwj0=;
        b=btTRZccnZT/imUHSdroiMkI5g9/lIRLkqiLYlz1t9AbLD9TimaVjR3tbCy5euAdFxP
         fOUd7XzS3gC/nfNQLVjGE9A+jS8guMSbvePoBl5JAsBDhOuNxzAZ16s/oEilkxHBQjeq
         CMQmJzaejxBss8uRrlDTg8VqLewCsKjE3xDz5g9mtAma0rm/KThQIgFvCvWypWjxLDiz
         35n5gHowdPlov8ePibQO2PiPwXVUNOPSEqePuBX9tYvxNlQ698JHMDAUsOQ8+Zdf59BU
         DEl9B1/pZNWCrzPLNxmZXHtbKTkF9Z7iI0IZ4JWBPEJ6+0XMh9DQiy7YTbECUD8ySZgP
         6idQ==
X-Gm-Message-State: APjAAAUmXm5NIPjAxOF3BY/A/uqMLxChpU6ssOIPVsFf6/N4fLcxkJJY
        TreTDiCp4DbVRZQn28kjFth/ZPwchR2Qc0FErghCU2m/6w2e
X-Google-Smtp-Source: APXvYqxtGAkYwGxU+YwjnPpYA0l7rbT3DIx8K8DfEGULGb5nLA2z7z1HkUZDJHJfhtyn+d4eShVbXi9sVQTJvyU//3CLyeQxBRrR
MIME-Version: 1.0
X-Received: by 2002:a92:ad0b:: with SMTP id w11mr70064430ilh.241.1577931909382;
 Wed, 01 Jan 2020 18:25:09 -0800 (PST)
Date:   Wed, 01 Jan 2020 18:25:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f04e43059b1ee697@google.com>
Subject: WARNING in switch_fpu_return
From:   syzbot <syzbot+f2ca20d4aa1408b0385a@syzkaller.appspotmail.com>
To:     alexander.deucher@amd.com, bigeasy@linutronix.de, bp@alien8.de,
        dave.hansen@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, nicholas.kazlauskas@amd.com, riel@surriel.com,
        sunpeng.li@amd.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org, zhan.liu@amd.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bf8d1cd4 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a4ce15e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ed9d672709340e35
dashboard link: https://syzkaller.appspot.com/bug?extid=f2ca20d4aa1408b0385a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cc8971e00000

The bug was bisected to:

commit 92e6475ae0a0383b012eb21c1aaf0e5456b1a3d9
Author: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Date:   Wed Jul 3 14:02:39 2019 +0000

     drm/amd/display: Set enabled to false at start of audio disable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15614e3ee00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13614e3ee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f2ca20d4aa1408b0385a@syzkaller.appspotmail.com
Fixes: 92e6475ae0a0 ("drm/amd/display: Set enabled to false at start of  
audio disable")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 2862 at arch/x86/include/asm/fpu/internal.h:539  
__fpregs_load_activate arch/x86/include/asm/fpu/internal.h:539 [inline]
WARNING: CPU: 0 PID: 2862 at arch/x86/include/asm/fpu/internal.h:539  
switch_fpu_return+0x437/0x4f0 arch/x86/kernel/fpu/core.c:343
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 2862 Comm: kworker/0:3 Not tainted 5.5.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events async_pf_execute
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
RIP: 0010:__fpregs_load_activate arch/x86/include/asm/fpu/internal.h:539  
[inline]
RIP: 0010:switch_fpu_return+0x437/0x4f0 arch/x86/kernel/fpu/core.c:343
Code: 0f 94 c6 31 ff 44 89 f6 e8 06 8f 4a 00 45 84 f6 0f 84 7f fd ff ff e8  
b8 8d 4a 00 e8 a4 c9 d5 ff e9 70 fd ff ff e8 a9 8d 4a 00 <0f> 0b e9 b6 fd  
ff ff e8 9d 8d 4a 00 0f 0b e9 18 fd ff ff e8 91 8d
RSP: 0018:ffffc90007ecfa80 EFLAGS: 00010293
RAX: ffff88809f60e0c0 RBX: ffff88809f60e0c0 RCX: ffffffff812a9ccf
RDX: 0000000000000000 RSI: ffffffff812aa047 RDI: 0000000000000005
RBP: ffffc90007ecfb10 R08: ffff88809f60e0c0 R09: ffffed1013ec1c19
R10: ffffed1013ec1c18 R11: ffff88809f60e0c7 R12: 1ffff92000fd9f51
R13: ffff88809f60f5c0 R14: 0000000000200000 R15: ffffc90007ecfae8
  kvm_arch_vcpu_load+0x66e/0x950 arch/x86/kvm/x86.c:3463
  vcpu_load+0x43/0x90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:201
  kvm_unload_vcpu_mmu arch/x86/kvm/x86.c:9543 [inline]
  kvm_free_vcpus arch/x86/kvm/x86.c:9558 [inline]
  kvm_arch_destroy_vm+0x184/0x5f0 arch/x86/kvm/x86.c:9663
  kvm_destroy_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:816 [inline]
  kvm_put_kvm+0x5a5/0xcc0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:837
  async_pf_execute+0x3bf/0x800 arch/x86/kvm/../../../virt/kvm/async_pf.c:101
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
