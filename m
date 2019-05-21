Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A923CC04E87
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88089216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbfEUIbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:31:06 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:41880 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbfEUIbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:31:06 -0400
Received: by mail-io1-f71.google.com with SMTP id i7so11847218ioh.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 01:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wO+SNayuGRGORA/iNMIl13BvsLdE+BTs0PZ1vvmuPRk=;
        b=DGHfrlEcsti5oFNgUHWg4mgi4B9oWWrP+VGfedIcZ1Zf3A4igzuAlCGLEbvuMN2fps
         0GcdZ7nYkZIMybkNnYCu1Vk3Y8ynb776iN7bk80/f2mHOfDi3hysNzgB57A3tyIG5eVI
         Nu39FMMNDqTA6BJAGOboQgqZOLazTYXlXffCuh0jKZYS++Sn2VZnPBGTcxnnRor336ff
         AUZrhQg8sTvCt8qkLBntbNR2yyH/3NzTMgeZ4KhJuqQeeq53/0zA8RG790NhwwSFtr6z
         FNaKiM1HAafj4kYZOsfG0yyWVFC+3gtbV+NQI9u2fcGUMiyMtGAUqTCVWl0roLUbIsVA
         iSpA==
X-Gm-Message-State: APjAAAV9v6l53nRKCLmIyCd66zoRQLA+STDHP43TEO5wL1BVgd+K+hsO
        ZVjZ1d0orgasHDGG6CHfmiFwtefpnyGN2B0x1ez3xHCH9xgl
X-Google-Smtp-Source: APXvYqxLNOmJWzS0OQ/JEpStyrsvuk+TfHKloJXRpkAqRBq3AeDbkB2ONuThOugJAqv1ke3lyt7HZEjcWvTZtjIyuSd4E5XRArVu
MIME-Version: 1.0
X-Received: by 2002:a6b:da0f:: with SMTP id x15mr1036473iob.214.1558427465554;
 Tue, 21 May 2019 01:31:05 -0700 (PDT)
Date:   Tue, 21 May 2019 01:31:05 -0700
In-Reply-To: <00000000000033a0120588fac894@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e2260058961abd9@google.com>
Subject: Re: WARNING: locking bug in inet_autobind
From:   syzbot <syzbot+94cc2a66fc228b23f360@syzkaller.appspotmail.com>
To:     ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, kafai@fb.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    f49aa1de Merge tag 'for-5.2-rc1-tag' of git://git.kernel.o..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14e5b130a00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc045131472947d7
dashboard link: https://syzkaller.appspot.com/bug?extid=94cc2a66fc228b23f360
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=163731f8a00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+94cc2a66fc228b23f360@syzkaller.appspotmail.com

WARNING: CPU: 1 PID: 28592 at kernel/locking/lockdep.c:734  
arch_local_save_flags arch/x86/include/asm/paravirt.h:762 [inline]
WARNING: CPU: 1 PID: 28592 at kernel/locking/lockdep.c:734  
arch_local_save_flags arch/x86/include/asm/paravirt.h:760 [inline]
WARNING: CPU: 1 PID: 28592 at kernel/locking/lockdep.c:734  
look_up_lock_class kernel/locking/lockdep.c:725 [inline]
WARNING: CPU: 1 PID: 28592 at kernel/locking/lockdep.c:734  
register_lock_class+0xe10/0x1860 kernel/locking/lockdep.c:1078
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 28592 Comm: syz-executor.5 Not tainted 5.2.0-rc1+ #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  panic+0x2cb/0x744 kernel/panic.c:218
  __warn.cold+0x20/0x4d kernel/panic.c:575
  report_bug+0x263/0x2b0 lib/bug.c:186
  fixup_bug arch/x86/kernel/traps.c:179 [inline]
  fixup_bug arch/x86/kernel/traps.c:174 [inline]
  do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:272
  do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:291
  invalid_op+0x14/0x20 arch/x86/entry/entry_64.S:986
RIP: 0010:look_up_lock_class kernel/locking/lockdep.c:734 [inline]
RIP: 0010:register_lock_class+0xe10/0x1860 kernel/locking/lockdep.c:1078
Code: 00 48 89 da 4d 8b 76 c0 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80  
3c 02 00 0f 85 23 07 00 00 4c 89 33 e9 e3 f4 ff ff 0f 0b <0f> 0b e9 ea f3  
ff ff 44 89 e0 4c 8b 95 50 ff ff ff 83 c0 01 4c 8b
RSP: 0018:ffff888093d179e8 EFLAGS: 00010083
RAX: dffffc0000000000 RBX: ffff8880967cd160 RCX: 0000000000000000
RDX: 1ffff11012cf9a2f RSI: 0000000000000000 RDI: ffff8880967cd178
RBP: ffff888093d17ab0 R08: 1ffff110127a2f45 R09: ffffffff8a659d40
R10: ffffffff8a2e8440 R11: 0000000000000000 R12: ffffffff8a323030
R13: 0000000000000000 R14: 0000000000000000 R15: ffffffff88022ba0
  __lock_acquire+0x116/0x5490 kernel/locking/lockdep.c:3673
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4302
  __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
  _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:175
  spin_lock_bh include/linux/spinlock.h:343 [inline]
  lock_sock_nested+0x41/0x120 net/core/sock.c:2917
  lock_sock include/net/sock.h:1525 [inline]
  inet_autobind+0x20/0x1a0 net/ipv4/af_inet.c:183
  inet_dgram_connect+0x243/0x2d0 net/ipv4/af_inet.c:573
  __sys_connect+0x264/0x330 net/socket.c:1840
  __do_sys_connect net/socket.c:1851 [inline]
  __se_sys_connect net/socket.c:1848 [inline]
  __x64_sys_connect+0x73/0xb0 net/socket.c:1848
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x459279
Code: fd b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 cb b7 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f2321b1ac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459279
RDX: 000000000000001c RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2321b1b6d4
R13: 00000000004bf74d R14: 00000000004d0c18 R15: 00000000ffffffff
Kernel Offset: disabled
Rebooting in 86400 seconds..

