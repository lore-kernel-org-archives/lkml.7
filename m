Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF5DCA9EC7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 00:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7E520663
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 00:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbfKCA1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 20:27:10 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:43921 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbfKCA1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 20:27:10 -0400
Received: by mail-io1-f72.google.com with SMTP id i2so10434665ioo.10
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 17:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=43PAAd5DFXqouo/qdBe/GRiW0b/rALk2NjJmB3iEVew=;
        b=A+VpDMPC4WF3C0dXH+TNtN2jHbL//LP0D84RHsoSHj0fBimuMKwnUVpzZKVPSuwziJ
         jBGMG72Pzs97LIBymef+hbVhMiG+t37vk5r54nAR+1Ey56YGVenJkkb/NyVzcUHgAY0j
         RYAuzdphiWCoPKjwyh8kkXBdo7rOJk0mkhaVvvp9RaAqZpvNUppwyvcZ1FHpd9pFjnp3
         M7fUJaeQaOVtLVNshRjeas4uht69PpNgvGR/Zjm34ou0ob2tixzhL1pPlIiQcx8arfTq
         fIDxIuGYwFrVUTv7tvzPnuMi4l3ke83eXSrBJXdcyWJ85o+wbpjYbYaP+Ozi62zWAQcr
         QBNA==
X-Gm-Message-State: APjAAAU9Jm3ql2mpLeAOGxF2XHwtFOrCZftZx1DzIKxUACwSvaEAHcKX
        En0WuQE0NDg7QOgcIpum8T1EWRIrJ1CSM2FPiPpu4G500KmN
X-Google-Smtp-Source: APXvYqyFE/g8ce3eQOpNPhHAlB4bc2H196GHPApJWaZ8g2trlWRrsAZclg6hDJm52CJZ8FWwo+oSTe6B6N7+oLR7+4AtAJRjHzKx
MIME-Version: 1.0
X-Received: by 2002:a92:9edd:: with SMTP id s90mr20815527ilk.244.1572740829259;
 Sat, 02 Nov 2019 17:27:09 -0700 (PDT)
Date:   Sat, 02 Nov 2019 17:27:09 -0700
In-Reply-To: <000000000000bd85b40596657dfa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073b15c05966642c3@google.com>
Subject: Re: WARNING: suspicious RCU usage in kvm_dev_ioctl
From:   syzbot <syzbot+75475908cd0910f141ee@syzkaller.appspotmail.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    9d234505 Merge tag 'hwmon-for-v5.4-rc6' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15bf068ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbbed3e8d4eb64bf
dashboard link: https://syzkaller.appspot.com/bug?extid=75475908cd0910f141ee
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e20268e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15209b84e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+75475908cd0910f141ee@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
5.4.0-rc5+ #0 Not tainted
-----------------------------
include/linux/kvm_host.h:534 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor978/9604.

stack backtrace:
CPU: 0 PID: 9604 Comm: syz-executor978 Not tainted 5.4.0-rc5+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5438
  kvm_get_bus include/linux/kvm_host.h:534 [inline]
  kvm_get_bus include/linux/kvm_host.h:532 [inline]
  kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:706 [inline]
  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3444  
[inline]
  kvm_dev_ioctl+0x100c/0x1610 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3496
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441159
Code: e8 fc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 9b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdef5e0888 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441159
RDX: 0000000000000002 RSI: 000000000000ae01 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000401f80
R13: 0000000000402010 R14: 0000000000000000 R15: 0000000000000000

=============================
WARNING: suspicious RCU usage
5.4.0-rc5+ #0 Not tainted
-----------------------------
include/linux/kvm_host.h:629 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by syz-executor978/9604.

stack backtrace:
CPU: 0 PID: 9604 Comm: syz-executor978 Not tainted 5.4.0-rc5+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  lockdep_rcu_suspicious+0x153/0x15d kernel/locking/lockdep.c:5438
  __kvm_memslots include/linux/kvm_host.h:629 [inline]
  __kvm_memslots include/linux/kvm_host.h:626 [inline]
  kvm_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:708 [inline]
  kvm_dev_ioctl_create_vm arch/x86/kvm/../../../virt/kvm/kvm_main.c:3444  
[inline]
  kvm_dev_ioctl+0x116c/0x1610 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3496
  vfs_ioctl fs/ioctl.c:46 [inline]
  file_ioctl fs/ioctl.c:509 [inline]
  do_vfs_ioctl+0xdb6/0x13e0 fs/ioctl.c:696
  ksys_ioctl+0xab/0xd0 fs/ioctl.c:713
  __do_sys_ioctl fs/ioctl.c:720 [inline]
  __se_sys_ioctl fs/ioctl.c:718 [inline]
  __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:718
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x441159
Code: e8 fc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 9b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffdef5e0888 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441159
RDX: 0000000000000002 RSI: 000000000000ae01 RDI: 0000000000000003
RBP: 00000000006cb018 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000401f80
R13: 0000000000402010 R14: 0000000000000000 R15: 0000000000000000

