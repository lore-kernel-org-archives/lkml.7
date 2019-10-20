Return-Path: <SRS0=ATYp=YN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60ADCA9EA0
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 23:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CB9F21928
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Oct 2019 23:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfJTXdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Oct 2019 19:33:14 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38961 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbfJTXdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Oct 2019 19:33:14 -0400
Received: by mail-io1-f69.google.com with SMTP id f9so15819378ioh.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2019 16:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=LcnS/BPD4aOM4PxSo8Hv9J5ZaoK/k6pTFOh7ysR2NzA=;
        b=J3pWDkO6Nroh6IvHQEU7TbqcU9BXouP8FrsUJQNRz9W+bONMCLEnstv/ZiffnQdfIA
         +kWHqXGc9AFr5YaX3Z9mKRRavwHDjOcCJ5yq1obzB1/pXmFOQ3JNzlY9g5CPrqTbKrNF
         YeC2D1sneDPwOUOKI/jVuOOsteOGSGH8P4AXQXlwjX8uQkpsxqmGXUtg/aHNHxL8lwgp
         TVKrrIP8tcjuyRP5Hn9kH+QZy8QlFhBsfM1Jlp+ISkTQKBPv+7wGdqG9YCZkGpRLtDxA
         n7ff7px02WaEjZUBJ6vgHMy5QKmihPr76WTCjVl4psJw0KizWl4lGC4XMXGj7ENSkP1R
         rPdA==
X-Gm-Message-State: APjAAAV0rlk98osHuhUJP6bPdg+z/+TMkiZNSPWgvaO3phCnpQVwmXBE
        zZLaPIHHRo1rXtgPxy4143a34Az6w4G/w7vh0BKQCpjDJfOd
X-Google-Smtp-Source: APXvYqy69ZWKiOaduR7XD3ZyDqZK5jSo6DR/VXXqXiPU9YPMlYvsCItsg8muyIm41ImBvZ+3rVIakLvZj3kw5IN8BZGfV5lJQ8v3
MIME-Version: 1.0
X-Received: by 2002:a6b:7104:: with SMTP id q4mr2713358iog.129.1571614391673;
 Sun, 20 Oct 2019 16:33:11 -0700 (PDT)
Date:   Sun, 20 Oct 2019 16:33:11 -0700
In-Reply-To: <0000000000007523a60576e80a47@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008a279405955ffd35@google.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
From:   syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>
To:     dvyukov@google.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, will.deacon@arm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    4fe34d61 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1176cd40e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e0ac4d9b35046343
dashboard link: https://syzkaller.appspot.com/bug?extid=aaa6fa4949cc5d9b7b25
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14150b40e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12e122ff600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com

BUG: MAX_LOCKDEP_CHAINS too low!
turning off the locking correctness validator.
CPU: 0 PID: 11772 Comm: kworker/u5:486 Not tainted 5.4.0-rc3+ #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci1600 hci_power_on
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  add_chain_cache kernel/locking/lockdep.c:2816 [inline]
  lookup_chain_cache_add kernel/locking/lockdep.c:2915 [inline]
  validate_chain kernel/locking/lockdep.c:2936 [inline]
  __lock_acquire.cold+0x325/0x385 kernel/locking/lockdep.c:3955
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
  process_one_work+0x91c/0x1740 kernel/workqueue.c:2245
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

