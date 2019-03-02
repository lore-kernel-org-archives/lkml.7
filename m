Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81C8C4360F
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 11:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD33220863
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 11:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfCBLpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 06:45:07 -0500
Received: from mail-it1-f198.google.com ([209.85.166.198]:42952 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCBLpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 06:45:06 -0500
Received: by mail-it1-f198.google.com with SMTP id j127so718725itj.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 03:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=s7R6v8IwdlGPxl0cTjVrsrNU/QmcK0RcG8SCwLlaGGw=;
        b=TflHsPlUaA6fdMo6/+DwrgA+eZTJmgGHYuIpCO8/BjbadWlkZ4291IUqgNGf4Nt6h8
         vC8RvWriHcVG3gQUVJFqlMnn3wBbG7a5mJR6mu3JdDsd4UnlH3qmzEmMHoliCacv8d/G
         k9/loXGZuOIznQ4YquRdBWdoRNp6BINTnnV5+stj3pB50JTK2zi/uNdxxnSkGxW5Az3t
         Z7qm9F3WS+6oISAwj5TTKkZCt4F72RN24IXMVMI6FT/asem5WNsQDvJ2tEm1Nt84KMA8
         QXxT0TPpLjrNrJ7g/neVoDP7o4DZjTT1p01LW+SqEuriuC05ejOAmTflil0glB3Rkhfa
         lXIw==
X-Gm-Message-State: APjAAAVj8gnbDeTtZsgviWHL3ETSbTiCYUpfDAB3sDYGP1Cit+K/ybvf
        RO+cBUH8t+wiLavYNj7PWzsyMYtm76dNG8IfmzZfWd9jyQp/
X-Google-Smtp-Source: AHgI3IZUM9RghBA+3GHZ32szWazgPOyJRqyblSbiX0/fKnGu1Cfi/kaCVUxP0Koavv1zJBTf1/kAi0ZlAUjk5rlh0D6H9OXBMXTD
MIME-Version: 1.0
X-Received: by 2002:a24:6cd5:: with SMTP id w204mr6212057itb.16.1551527105640;
 Sat, 02 Mar 2019 03:45:05 -0800 (PST)
Date:   Sat, 02 Mar 2019 03:45:05 -0800
In-Reply-To: <000000000000299b190583172880@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fdc7da05831b0df8@google.com>
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low!
From:   syzbot <syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com>
To:     darrick.wong@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    c63e9e91a254 Add linux-next specific files for 20190301
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10856157200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5875f9dc6e009b2
dashboard link: https://syzkaller.appspot.com/bug?extid=78923eea7cf44364f4fb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=149ae1eb200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ee41eb200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+78923eea7cf44364f4fb@syzkaller.appspotmail.com

BUG: MAX_STACK_TRACE_ENTRIES too low!
turning off the locking correctness validator.
CPU: 0 PID: 1176 Comm: kworker/u5:0 Not tainted 5.0.0-rc8-next-20190301 #1
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci1 hci_power_on
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  save_trace kernel/locking/lockdep.c:467 [inline]
  save_trace.cold+0x14/0x19 kernel/locking/lockdep.c:437
  mark_lock+0x2fb/0x1380 kernel/locking/lockdep.c:3401
  mark_irqflags kernel/locking/lockdep.c:3304 [inline]
  __lock_acquire+0xf2c/0x3fb0 kernel/locking/lockdep.c:3644
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4202
  process_one_work+0x8df/0x1790 kernel/workqueue.c:2244
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x357/0x430 kernel/kthread.c:253
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

