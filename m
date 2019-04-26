Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE2C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC1AB2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfDZAHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:07:07 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:50911 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZAHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:07:07 -0400
Received: by mail-io1-f70.google.com with SMTP id b26so1345158ioa.17
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 17:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ncsg7IXdsrfkQ0KmZEk6J1vVZHSi1l6+kyeA64/DwGw=;
        b=rUay8ykcB7NqpewHRS/XauJSZhjzkJJgSeotOzOrLC0kb7ED7daHc6zXdfC63HC212
         a3hud7VzpUjWSkQcZ0VMZlBL2LdcdQW8nGMuFLD03Pvli/9aLRK4FbndQgdu31RZD3oC
         Zl+2rvRE5Dv1XAwNcn5OQiEeGZro7ktVgPw2lPcHazoWoZio2mFy0N23zBx7Wiy9ZNOg
         sALPYIrqmtiVaQUj/hjn5eBMhzfBYqtAFPJNbj1CLxKa6XQKyw7haQIeVEksRyw5q4nK
         CRgYDpXRahO8KgA6oOirPQw1kLhGgxX/opEowdB7Sz2w2FV2N2wAol5lTDm4pW84Sgb2
         HVOA==
X-Gm-Message-State: APjAAAUQgZo4G4NlPuw++kOtXgfp+E4Bx3SO7/jUsRgMDPkdF8R3iIXu
        5RCi1/mfR4zgSecEBXoBgHRCHP5ETOrvCLHnbY0L5bZ0HDRG
X-Google-Smtp-Source: APXvYqzRaxQ9a/L1TNIL4VmzU7hmo/Ga4ufLTpRcgEaFev+WsdcgwEfKNCm0dPFxSDJIM4eCf5NTk+MZsT4109ryOTxzZQNB3tvJ
MIME-Version: 1.0
X-Received: by 2002:a5e:db02:: with SMTP id q2mr6442598iop.293.1556237225841;
 Thu, 25 Apr 2019 17:07:05 -0700 (PDT)
Date:   Thu, 25 Apr 2019 17:07:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000859f5058763b7c3@google.com>
Subject: general protection fault in vcpu_enter_guest (2)
From:   syzbot <syzbot+f7e65445a40d3e0e4ebf@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    76c938fc Add linux-next specific files for 20190423
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16863d28a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=62738d35457c577d
dashboard link: https://syzkaller.appspot.com/bug?extid=f7e65445a40d3e0e4ebf
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1364a6d4a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c25dc4a00000

Bisection is inconclusive: the first bad commit could be any of:

57bf67e7 KVM: lapic: Disable timer advancement if adaptive tuning goes  
haywire
39497d76 KVM: lapic: Track lapic timer advance per vCPU

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a32fc4a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f7e65445a40d3e0e4ebf@syzkaller.appspotmail.com

L1TF CPU bug present and SMT on, data leak possible. See CVE-2018-3646 and  
https://www.kernel.org/doc/html/latest/admin-guide/l1tf.html for details.
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7872 Comm: syz-executor233 Not tainted 5.1.0-rc6-next-20190423  
#29
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:vcpu_enter_guest+0xbcd/0x5fb0 arch/x86/kvm/x86.c:7895
Code: 48 c1 ea 03 80 3c 02 00 0f 85 6f 48 00 00 49 8b 9f b0 03 00 00 48 b8  
00 00 00 00 00 fc ff df 48 8d 7b 78 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e 39 48 00 00 8b 5b 78 31 ff 89
RSP: 0018:ffff88808bd4fa00 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff810d1ec9
RDX: 000000000000000f RSI: ffffffff810ceef2 RDI: 0000000000000078
RBP: ffff88808bd4fb10 R08: ffff8880a912e580 R09: ffffed1015d05dd0
R10: ffffed1015d05dcf R11: ffff8880ae82ee7b R12: ffff88808f3e006c
R13: 0000000000000001 R14: ffff88808f3e0070 R15: ffff88808f3e0040
FS:  00007f7adb927700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0427eb000 CR3: 00000000939e4000 CR4: 00000000001426f0
Call Trace:
  vcpu_run arch/x86/kvm/x86.c:8037 [inline]
  kvm_arch_vcpu_ioctl_run+0x425/0x1750 arch/x86/kvm/x86.c:8245
  kvm_vcpu_ioctl+0x4dc/0xf90 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2684
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xd6e/0x1390 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0x103/0x670 arch/x86/entry/common.c:298
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x446779
Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7adb926db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000006dbc48 RCX: 0000000000446779
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 00000000006dbc40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc4c
R13: 00007fff1cfa7c1f R14: 00007f7adb9279c0 R15: 20c49ba5e353f7cf
Modules linked in:
---[ end trace da6276bd16a5f99d ]---
RIP: 0010:vcpu_enter_guest+0xbcd/0x5fb0 arch/x86/kvm/x86.c:7895
Code: 48 c1 ea 03 80 3c 02 00 0f 85 6f 48 00 00 49 8b 9f b0 03 00 00 48 b8  
00 00 00 00 00 fc ff df 48 8d 7b 78 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e 39 48 00 00 8b 5b 78 31 ff 89
RSP: 0018:ffff88808bd4fa00 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff810d1ec9
RDX: 000000000000000f RSI: ffffffff810ceef2 RDI: 0000000000000078
RBP: ffff88808bd4fb10 R08: ffff8880a912e580 R09: ffffed1015d05dd0
R10: ffffed1015d05dcf R11: ffff8880ae82ee7b R12: ffff88808f3e006c
R13: 0000000000000001 R14: ffff88808f3e0070 R15: ffff88808f3e0040
FS:  00007f7adb927700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa0427eb000 CR3: 00000000939e4000 CR4: 00000000001426f0


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
