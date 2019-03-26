Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A612C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F05F420856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbfCZJe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:34:26 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:53652 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfCZJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:34:26 -0400
Received: by mail-wm1-f46.google.com with SMTP id q16so11795186wmj.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 02:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yHdQF/7qP/SMxd79G8nKNRC7WlF4liI1QjjSSpTdTxY=;
        b=r+4CuDzCuunzN9XXnj1Bg/HZMzyRXr8WCCzhlH/YImDQa0pOzn71OO2Z6VDO0De7Eu
         pfvBVF1JLXcG5ZEo5T1cT9go1oDBakp6iC6cd4eUYjiSCAsnxzkGfpcPQ5isC85W//39
         9OHwuTdmuA8xUT2FZfxtnbgYm6k9yxprteOZRe6zd+DSnkvHMXaRiYOV3rRT4BLvfJzz
         7SF4C2SjA9xcaWsTlEF1AYjc/C5NXi1ntLjwqVbZn3Zh136CJCtTHCJmBsLUt/UjsjhL
         8VxcPTHJOvXQhNVL18ig6wsa2z/9z9J1bo1gnNF9H+bUxn6b8rUNIMwG12F4uH/ObeWf
         JXVA==
X-Gm-Message-State: APjAAAU4BUDvla72JHHTgpU0cO/k8Mgxp7ukiFdeAu+88726wPI3gqYT
        y72cWg+kOxDM1VjGD+cer9hbdQ==
X-Google-Smtp-Source: APXvYqz4EEWZG15AzeBrSFdJhWTmutTRSMvcR4mceA7n0Uv7TTyitI+qR58fu+CWzHaQPi6FW4REgQ==
X-Received: by 2002:a1c:3944:: with SMTP id g65mr13851898wma.34.1553592863879;
        Tue, 26 Mar 2019 02:34:23 -0700 (PDT)
Received: from localhost.localdomain ([151.15.240.16])
        by smtp.gmail.com with ESMTPSA id t17sm1033172wrr.26.2019.03.26.02.34.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 02:34:23 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:34:21 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [RT WARNING] DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
 with fsfreeze (4.19.25-rt16)
Message-ID: <20190326093421.GA29508@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Running this reproducer on a 4.19.25-rt16 kernel (with lock debugging
turned on) produces warning below.

 --->8---
 # dd if=/dev/zero of=fsfreezetest count=999999
 # mkfs -t xfs -q ./fsfreezetest
 # mkdir testmount
 # mount -t xfs -o loop ./fsfreezetest ./testmount
 # for I in `seq 10`; do fsfreeze -f ./testmount; sleep 1; fsfreeze -u ./testmount; done
 --->8---

 ------------[ cut here ]------------
 DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
 WARNING: CPU: 10 PID: 1226 at kernel/locking/rtmutex-debug.c:145 debug_rt_mutex_unlock+0x9b/0xb0
 Modules linked in: xfs [...]
 CPU: 10 PID: 1226 Comm: fsfreeze Not tainted 4.19.25-rt16 #2
 Hardware name: LENOVO 30B6S2F900/1030, BIOS S01KT61A 09/28/2018
 RIP: 0010:debug_rt_mutex_unlock+0x9b/0xb0
 Code: e8 aa af 3c 00 4c 8b 04 24 85 c0 74 a9 8b 05 3c 9c a6 02 85 c0 75 9f 48 c7 c6 b8 b4 2d 98 48 c7 c7 9b d2 2b 98 e8 d9 e5 f8 ff <0f> 0b 4c 8b 04 24 eb 84 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 c3
 RSP: 0018:ffffa7efa60cbdd0 EFLAGS: 00010086
 RAX: 0000000000000000 RBX: ffff991b72813920 RCX: 0000000000000000
 RDX: 0000000000000007 RSI: ffffffff98318de2 RDI: 00000000ffffffff
 RBP: 0000000000000246 R08: 0000000000000000 R09: 0000000000024200
 R10: 0000000000000000 R11: 0000000000000000 R12: ffffa7efa60cbe08
 R13: ffffa7efa60cbe18 R14: ffff991b72813478 R15: ffffffff9730718d
 FS:  00007f19baf6a540(0000) GS:ffff991b9fb00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f19bae87040 CR3: 000000103c6ee002 CR4: 00000000001606e0
 Call Trace:
  rt_mutex_slowunlock+0x24/0x70
  __rt_mutex_unlock+0x45/0x80
  percpu_up_write+0x4b/0x60
  thaw_super_locked+0xdb/0x110
  do_vfs_ioctl+0x647/0x6f0
  ksys_ioctl+0x60/0x90
  __x64_sys_ioctl+0x16/0x20
  do_syscall_64+0x60/0x1f0
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
 RIP: 0033:0x7f19bae9704b
 Code: 0f 1e fa 48 8b 05 3d be 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 0d be 0c 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffc6d275358 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
 RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f19bae9704b
 RDX: 0000000000000000 RSI: 00000000c0045878 RDI: 0000000000000003
 RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc6d275755
 R13: 00007ffc6d275500 R14: 0000000000000000 R15: 0000000000000000
 irq event stamp: 8002
 hardirqs last  enabled at (8001): [<ffffffff97a25981>] _raw_spin_unlock_irqrestore+0x81/0x90
 hardirqs last disabled at (8002): [<ffffffff97a25aa0>] _raw_spin_lock_irqsave+0x20/0x60
 softirqs last  enabled at (0): [<ffffffff970c04ad>] copy_process.part.36+0x89d/0x2170
 softirqs last disabled at (0): [<0000000000000000>]           (null)
 ---[ end trace 0000000000000002 ]---

AFAIU, this is a legit warning, since

 fsfreeze -f ./testmount grabs rt_mutexes embedded into
 sb->s_writers.rw_sem[SB_FREEZE_LEVELS] (rt-rwsem) as part of executing
 sb_wait_write() (for each FREEZE_LEVEL) in freeze_super().

 We then return to userspace.

 fsfreeze -u ./testmount unlocks the rt_mutexes while doing
 sb_freeze_unlock() in thaw_super_locked(). This is a different process
 w.r.t. the one that did the freeze above.

I noticed that a very similar problem was fixed (for !rt rwsem) by
5a817641f68a ("locking/percpu-rwsem: Annotate rwsem ownership transfer
by setting RWSEM_OWNER_UNKNOWN"). However, RT has of course to deal with
PI, so I wonder if there is an easy fix for this problem.

Suggestions?

Thanks,

- Juri
