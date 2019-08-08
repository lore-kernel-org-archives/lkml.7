Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695CDC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464BA21881
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 16:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390207AbfHHQoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 12:44:07 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72]:36231 "EHLO
        mail-ot1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732775AbfHHQoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 12:44:07 -0400
Received: by mail-ot1-f72.google.com with SMTP id f11so62950409otq.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 09:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=iMvZ/m27+Coh4q2kypY8c+/9YvSWV25rvuLfoAzVCWs=;
        b=IBkBGgx2cZnH4lqe4Ma9lYVPXe9ECLBW9sjOdlY8dKD76Ds+fXU3JVelHvAfGf22Hn
         TQjPvSAnHjtboxP5Gj2FZUHTSUynb3s5EGKxdjvhxRhhX7/Gp/KmAdNKgJKwZiInS/+C
         C3NzJO/3B+N9TyHcqYsU7rxWtSC1aBrs/UsmSSzmBvNazoKyG6wLD9fVnrVLXIlOA+tv
         sMBS54q35Wpfu/X1s7YkNPDvjg44X9HS/jm3uCU1mzlmREiPbp1nQswsdV/ZwG2/RI0j
         rJAda2qc4lv9cMmW5hLUb7Hwov738tDoLKZHAm/2ZZxYjwGzyURl7ldR0x7qPlOxtMyn
         sVSg==
X-Gm-Message-State: APjAAAW1JUAZOiYmle7DZGezXnsBwHZX+xLUjFlP+8wp9XKfoyozSk3A
        pWpbL0lX29HmZ5x5phTH4iAfUJmUN5RWqAGLT0a/IK7H8MhN
X-Google-Smtp-Source: APXvYqxHcP/FOawJxr9LBBv9fK/CPNC9T6++eJmBhZKGUxshGNO+LS58yl82k11uwsGUTDeHVj8QS2XhutJbJo0fT9vyrn6iS11V
MIME-Version: 1.0
X-Received: by 2002:a5d:8d15:: with SMTP id p21mr15404757ioj.219.1565282646712;
 Thu, 08 Aug 2019 09:44:06 -0700 (PDT)
Date:   Thu, 08 Aug 2019 09:44:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000216779058f9dc40e@google.com>
Subject: general protection fault in tls_tx_records
From:   syzbot <syzbot+97d0cf528b9c8e9be7f4@syzkaller.appspotmail.com>
To:     ast@kernel.org, aviadye@mellanox.com, borisp@mellanox.com,
        bpf@vger.kernel.org, daniel@iogearbox.net, davejwatson@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, kafai@fb.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ce96e791 Add linux-next specific files for 20190731
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13ce4fd0600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fca5b9d53db6585c
dashboard link: https://syzkaller.appspot.com/bug?extid=97d0cf528b9c8e9be7f4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+97d0cf528b9c8e9be7f4@syzkaller.appspotmail.com

kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.3.0-rc2-next-20190731 #56
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: events tx_work_handler
RIP: 0010:tls_tx_records+0x5e/0x740 net/tls/tls_sw.c:365
Code: 80 3c 02 00 0f 85 31 06 00 00 49 8b 87 b0 06 00 00 48 8d 78 28 48 89  
45 c0 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 1b 06 00 00 48 8b 45 c0 48 8d 78 60 48 8b 58 28
RSP: 0018:ffff8880a98d7cb0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 1ffffffff134c016
RDX: 0000000000000005 RSI: ffffffff862e74fc RDI: 0000000000000028
RBP: ffff8880a98d7d00 R08: ffff8880a98c8300 R09: 0000000000000000
R10: fffffbfff134b9d8 R11: ffff8880a98c8300 R12: ffff88808eb47cc0
R13: ffff8880a9ac4c40 R14: ffff88808eb47de8 R15: ffff8880a9ac4c40
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001b30e80 CR3: 000000009c1a0000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  tx_work_handler+0x134/0x180 net/tls/tls_sw.c:2176
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace c75bda97ceb541bf ]---
RIP: 0010:tls_tx_records+0x5e/0x740 net/tls/tls_sw.c:365
Code: 80 3c 02 00 0f 85 31 06 00 00 49 8b 87 b0 06 00 00 48 8d 78 28 48 89  
45 c0 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f  
85 1b 06 00 00 48 8b 45 c0 48 8d 78 60 48 8b 58 28
RSP: 0018:ffff8880a98d7cb0 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 1ffffffff134c016
RDX: 0000000000000005 RSI: ffffffff862e74fc RDI: 0000000000000028
RBP: ffff8880a98d7d00 R08: ffff8880a98c8300 R09: 0000000000000000
R10: fffffbfff134b9d8 R11: ffff8880a98c8300 R12: ffff88808eb47cc0
R13: ffff8880a9ac4c40 R14: ffff88808eb47de8 R15: ffff8880a9ac4c40
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd4f4eadac CR3: 00000000987e6000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
