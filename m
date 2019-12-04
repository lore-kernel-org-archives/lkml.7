Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C84C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52E22468D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfLDGhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 01:37:10 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:55610 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbfLDGhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 01:37:10 -0500
Received: by mail-io1-f72.google.com with SMTP id z21so4320534iob.22
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 22:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=j0gq/2gGYT4L1Q+bpX6PwWBD0674R9BZnHG5rWPn0xk=;
        b=dTKyj0fISq1jb5fOHi4lU8fzl7pyoreTCNGuR/Gg/GhH0G0/USiAF2U6L9zBtSr7RX
         8GerJ5W6Xt3K4INH8AB5iUH3McKr9DnVH2pgvYDgFJKQyuVfDQk8hlAkZ0NHin2FLIa8
         whqj300gPbeXNumhDz1ZF4f1E6bksxwMXAUeZil1WkjanIFtxqInjiRXqfa7OSmeDr9X
         pd6pHu/EnMAWRrsSvCb0uL1uAEVZs2uMn74y4k8eIFFoNH6H8hZxN+1I+pDbEyMqSZnX
         OLRWSf529f8vruuCAP/ys/dIR3xcZa2UPmobZqx47c3LFR/DuapX/myTUxxk9Hy8Mfl1
         pASw==
X-Gm-Message-State: APjAAAW46ox06MJNGFsL0KxTFQu2j9Rr4tN9lp8Mh/FWycoxbZ3EUh26
        FstgaQfn2L+mCO8uY9vS05+Pn032UdLL6g1gEN/APb9PXi34
X-Google-Smtp-Source: APXvYqz2elRUjqdBYAGygCnebDlcZAd5kvfX5JkZr0/lvExB95JFzMvzqAhHpqBKiqAAfkRTkkI4PZQWWJm0UsQHzn5aOK/1tdVX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1002:: with SMTP id n2mr1992378ilj.249.1575441429856;
 Tue, 03 Dec 2019 22:37:09 -0800 (PST)
Date:   Tue, 03 Dec 2019 22:37:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca89a80598db0ae5@google.com>
Subject: general protection fault in gcmaes_crypt_by_sg (2)
From:   syzbot <syzbot+675c45cea768b3819803@syzkaller.appspotmail.com>
To:     bp@alien8.de, davem@davemloft.net, herbert@gondor.apana.org.au,
        hpa@zytor.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    76bb8b05 Merge tag 'kbuild-v5.5' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=148a7aeae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd226651cb0f364b
dashboard link: https://syzkaller.appspot.com/bug?extid=675c45cea768b3819803
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+675c45cea768b3819803@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 560 Comm: kworker/u4:10 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: pencrypt_parallel padata_parallel_worker
RIP: 0010:scatterwalk_start include/crypto/scatterwalk.h:68 [inline]
RIP: 0010:scatterwalk_pagedone include/crypto/scatterwalk.h:93 [inline]
RIP: 0010:scatterwalk_done include/crypto/scatterwalk.h:101 [inline]
RIP: 0010:gcmaes_crypt_by_sg.constprop.0+0x1035/0x1aa0  
arch/x86/crypto/aesni-intel_glue.c:786
Code: e8 b0 02 52 02 48 89 84 24 a8 00 00 00 48 83 c0 08 48 89 c2 48 89 84  
24 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 04 02 84  
c0 74 08 3c 03 0f 8e 30 09 00 00 48 8b 84 24 a8 00
RSP: 0000:ffffc90002cb7750 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000003006 RCX: ffffffff838ba9f9
RDX: 0000000000000001 RSI: ffffffff838baa4b RDI: 0000000000000007
RBP: ffffc90002cb7b20 R08: ffff8880a8332000 R09: 0000000000000005
R10: 0000000000000000 R11: 0000000000000ffb R12: 0000000000003006
R13: 0000000000000000 R14: ffff888053c33300 R15: 0000000000003006
FS:  0000000000000000(0000) GS:ffff8880ae900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa6ece55330 CR3: 0000000094c3d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  gcmaes_encrypt arch/x86/crypto/aesni-intel_glue.c:840 [inline]
  generic_gcmaes_encrypt+0x10d/0x160 arch/x86/crypto/aesni-intel_glue.c:1019
  crypto_aead_encrypt+0xaf/0xf0 crypto/aead.c:94
  simd_aead_encrypt+0x1a6/0x2b0 crypto/simd.c:335
  crypto_aead_encrypt+0xaf/0xf0 crypto/aead.c:94
  pcrypt_aead_enc+0x19/0x80 crypto/pcrypt.c:76
  padata_parallel_worker+0x28f/0x470 kernel/padata.c:81
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2264
  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
------------[ cut here ]------------
WARNING: CPU: 1 PID: 560 at kernel/locking/mutex.c:1419  
mutex_trylock+0x279/0x2f0 kernel/locking/mutex.c:1427


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
