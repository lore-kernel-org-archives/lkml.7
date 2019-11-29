Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12B9C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90A33217AB
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 08:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfK2IUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 03:20:11 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:53274 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfK2IUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 03:20:11 -0500
Received: by mail-il1-f197.google.com with SMTP id y9so8975560ilp.20
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 00:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xVR2E33E57gP3WHNwoEF1Nitw4WLWCmTkXaj4CCkoHA=;
        b=Fm65e5SW8UqbBE4g5p1n86YLlkyZeac2DwqJSvWzHmpEZArWvF3GBIf18gxENp5WVu
         BwtpuicZ4vQd5bG39+wVhhFy0Y0eXoVFeexlPywFyM4xxZXv9L6S5ScabUvBI1sDXQSs
         HdDzvASbhkryYZecP2aF1E0jgAjYOLo8hYSlXVBIuAHisljDkqKTQX707rBrPQiQ0eC0
         r8UqB5vkQHERRvHpjvGUbldu3OMg9y8zvRgrpun9h0HfnnyhiZslNoRVOCEXtFhVlREq
         jzjRqkGQjk573SXFa8zuGhLRE4uYs1TS7htQbmvV33M+yJO16ZlmFpjNQgf9CpWIMCUv
         93Ww==
X-Gm-Message-State: APjAAAVMamjEX4/+MCQfugTm0YlaGcdScMuy1BCXP58IGhHxT+q+jTQI
        ltRSAjbFD58kym0u8htcvixrjMRTLYgo+P26ZRVnM7siKaJ3
X-Google-Smtp-Source: APXvYqwdCe1U7S/I44jBVgKxlTWKlpY4ux151fW+V79MvqSdIt1FOf5+SuwPAbBxqB63sQx9SD86rmFajVIrgr/9PlCpcwd/3QQj
MIME-Version: 1.0
X-Received: by 2002:a5e:c20c:: with SMTP id v12mr31373543iop.35.1575015610408;
 Fri, 29 Nov 2019 00:20:10 -0800 (PST)
Date:   Fri, 29 Nov 2019 00:20:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f965b8059877e5e6@google.com>
Subject: WARNING in vcpu_enter_guest
From:   syzbot <syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com>
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

HEAD commit:    ad062195 Merge tag 'platform-drivers-x86-v5.4-1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154910ad600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9fc16a6374d5fd0
dashboard link: https://syzkaller.appspot.com/bug?extid=00be5da1d75f1cc95f6b
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 15173 at arch/x86/kvm/x86.c:8007  
vcpu_enter_guest+0x4b29/0x5e90 arch/x86/kvm/x86.c:8007
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 15173 Comm: syz-executor.5 Not tainted 5.3.0+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2dc/0x755 kernel/panic.c:219
  __warn.cold+0x20/0x4c kernel/panic.c:576
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1028
RIP: 0010:vcpu_enter_guest+0x4b29/0x5e90 arch/x86/kvm/x86.c:8007
Code: 00 fc ff df 48 c1 ea 03 0f b6 04 02 84 c0 74 08 3c 03 0f 8e e9 11 00  
00 41 83 a5 20 27 00 00 fb e9 5c bf ff ff e8 97 9e 65 00 <0f> 0b e9 98 be  
ff ff e8 8b 9e 65 00 31 ff be 07 00 00 00 e8 ef 97
RSP: 0018:ffff8880572bfa10 EFLAGS: 00010046
RAX: 0000000000040000 RBX: 0000000000000000 RCX: ffffc900109ce000
RDX: 0000000000040000 RSI: ffffffff810d3599 RDI: 0000000000000007
RBP: ffff8880572bfb20 R08: ffff8880576b62c0 R09: ffffed100aed6c59
R10: ffffed100aed6c58 R11: ffff8880576b62c7 R12: ffff88805fa9866c
R13: ffff88805fa98640 R14: 0000000000000001 R15: ffff88805fa98670
  vcpu_run arch/x86/kvm/x86.c:8159 [inline]
  kvm_arch_vcpu_ioctl_run+0x464/0x1750 arch/x86/kvm/x86.c:8367
  kvm_vcpu_ioctl+0x4dc/0xfd0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:2765
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4598e9
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f84f3c93c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000004598e9
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000005
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f84f3c946d4
R13: 00000000004c2c68 R14: 00000000004d6330 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
