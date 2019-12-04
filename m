Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF59C432C0
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1842073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 04:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfLDEPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 23:15:10 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:54904 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726835AbfLDEPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 23:15:09 -0500
Received: by mail-il1-f197.google.com with SMTP id t4so4813707ili.21
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 20:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=VdLPHplMVsVl+WlOVsGf2sKVRxVRuxnwgs0jCt2nif4=;
        b=Uctm1OAstpcnbtBclr6tiZdvupLWO8hXbv+U5tTZ34g4j6bNDG8NXG/O2SExnWKU96
         BC8LlQE2U+rD5YLez6M9HLxBP3a+tli/kEZRFXBAVhd5iYx3AOz9m/K288k1J9uw/50y
         CNC1JuZT4gQEyxin2UdletNLy7ZqiNYInQ8SktX/R93oolmsHp2JUvCPKVmvOTr3YDP0
         0PGbpWyJzw70stYcgJqFfJLFr1kqjeVy5NuwAXn1abRWT0ImpSvZLyJ28bcU1o4ebSZR
         nf6Tqv/G8uyov52AV9/4SEfGtbhlJ8el+ycl2vJZ6OpXphGvnOL7MVCyMjU5gBSTMzoh
         J+Bw==
X-Gm-Message-State: APjAAAUYyawOYiLib1yMVkIhhUyUVJmQeJ/ReWz4JOp3qlESK7U5odP9
        Yv5xl582E8DuDT1Q9JHroi4xvhLWH2CBF/32SL4uptZDeOk0
X-Google-Smtp-Source: APXvYqzeIvGu/yNE0BUV2pKlhsrk2vzxeUv9IQ64GsXDF0KB5XQbnNvLZAyOqS9dnWMwMWmCQDWTNeZRvItsw9hi1x8sW58C5vyf
MIME-Version: 1.0
X-Received: by 2002:a5d:9f05:: with SMTP id q5mr683388iot.295.1575432909116;
 Tue, 03 Dec 2019 20:15:09 -0800 (PST)
Date:   Tue, 03 Dec 2019 20:15:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ea5ec20598d90e50@google.com>
Subject: KASAN: vmalloc-out-of-bounds Write in kvm_dev_ioctl_get_cpuid
From:   syzbot <syzbot+e3f4897236c4eeb8af4f@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    596cf45c Merge branch 'akpm' (patches from Andrew)
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=103acb7ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8eb54eee6e6ca4a7
dashboard link: https://syzkaller.appspot.com/bug?extid=e3f4897236c4eeb8af4f
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b87c82e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11250f36e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e3f4897236c4eeb8af4f@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in __do_cpuid_func_emulated  
arch/x86/kvm/cpuid.c:323 [inline]
BUG: KASAN: vmalloc-out-of-bounds in do_cpuid_func arch/x86/kvm/cpuid.c:814  
[inline]
BUG: KASAN: vmalloc-out-of-bounds in do_cpuid_func arch/x86/kvm/cpuid.c:810  
[inline]
BUG: KASAN: vmalloc-out-of-bounds in kvm_dev_ioctl_get_cpuid+0xad7/0xb0b  
arch/x86/kvm/cpuid.c:891
Write of size 4 at addr ffffc90000d36050 by task syz-executor490/9767

CPU: 1 PID: 9767 Comm: syz-executor490 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0x5/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:638
  __asan_report_store4_noabort+0x17/0x20 mm/kasan/generic_report.c:139
  __do_cpuid_func_emulated arch/x86/kvm/cpuid.c:323 [inline]
  do_cpuid_func arch/x86/kvm/cpuid.c:814 [inline]
  do_cpuid_func arch/x86/kvm/cpuid.c:810 [inline]
  kvm_dev_ioctl_get_cpuid+0xad7/0xb0b arch/x86/kvm/cpuid.c:891
  kvm_arch_dev_ioctl+0x300/0x4b0 arch/x86/kvm/x86.c:3387
  kvm_dev_ioctl+0x127/0x17d0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3593
  vfs_ioctl fs/ioctl.c:47 [inline]
  file_ioctl fs/ioctl.c:539 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:726
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:743
  __do_sys_ioctl fs/ioctl.c:750 [inline]
  __se_sys_ioctl fs/ioctl.c:748 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:748
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440159
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffd106332c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440159
RDX: 0000000020000080 RSI: 00000000c008ae09 RDI: 0000000000000003
RBP: 00000000006ca018 R08: 0000000000000000 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004019e0
R13: 0000000000401a70 R14: 0000000000000000 R15: 0000000000000000


Memory state around the buggy address:
  ffffc90000d35f00: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90000d35f80: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
> ffffc90000d36000: 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
                                                  ^
  ffffc90000d36080: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
  ffffc90000d36100: f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9 f9
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
