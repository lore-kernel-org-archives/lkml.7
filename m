Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51142C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD9E21744
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfHLMaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:30:08 -0400
Received: from mail-ot1-f70.google.com ([209.85.210.70]:49152 "EHLO
        mail-ot1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728417AbfHLMaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:30:07 -0400
Received: by mail-ot1-f70.google.com with SMTP id g8so3514606otj.16
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ELYwS94xLY2nHdUeXkoqu1sYFAwq9kviLiiNnHS1ELM=;
        b=e7+aCK1H2y3csWinvy0Ec1hfnp6cWEnvo9ud4HrSNydg4+msJtvhaBwKpsfoWkYC2D
         1TUR3/r4WoU7UdohwrUSi/gT5LiKb0FPoDZth5uRcydyo4wUop7uodssBXlFt/5vH1vW
         s8SzR6zUFBnbQO06CHEx76NX4346x9JRxBfF4yaELdLGq4mrtoYk+VPZKFHehNdHrmPP
         m+nVo4O/VH4+NMShDFVxjeAh0vf6JQkQKBojA9ETjlAOysybNpdY+9f/x+N+CSYiYKoC
         XniZ8LNzAeSwkYSOCIvr7YpM89Y6CTlaZZ3Wzq6mw6i4d7se31C9WD2Nt7aWYvuOryty
         SEgg==
X-Gm-Message-State: APjAAAVMXVVRzkilu93LM8HuUrCDW9fHFHvjfTk69s76zEGgYc6PDIsb
        BRF/+f38xvVAtE94IY9PETyChCbQ0dgFDyNE1KYt+nUtBJlf
X-Google-Smtp-Source: APXvYqwRGsm7zD3z2cToxZ+wsGWANpaVcj4IoJpefC4BUYWT307oa9WVFva7bpbSBxQLnHdBdne5ppAO14V7WaThajS2sXLssbcj
MIME-Version: 1.0
X-Received: by 2002:a05:6638:310:: with SMTP id w16mr15319849jap.136.1565613006907;
 Mon, 12 Aug 2019 05:30:06 -0700 (PDT)
Date:   Mon, 12 Aug 2019 05:30:06 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000021eea2058feaaf82@google.com>
Subject: WARNING in aa_sock_msg_perm
From:   syzbot <syzbot+cda1ac91660a61b51495@syzkaller.appspotmail.com>
To:     jmorris@namei.org, john.johansen@canonical.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    fcc32a21 liquidio: Use pcie_flr() instead of reimplementin..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11233726600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4cf1ffb87d590d7
dashboard link: https://syzkaller.appspot.com/bug?extid=cda1ac91660a61b51495
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+cda1ac91660a61b51495@syzkaller.appspotmail.com

------------[ cut here ]------------
AppArmor WARN aa_sock_msg_perm: ((!sock)):
WARNING: CPU: 0 PID: 11187 at security/apparmor/lsm.c:920  
aa_sock_msg_perm.isra.0+0xdd/0x170 security/apparmor/lsm.c:920
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 11187 Comm: kworker/0:5 Not tainted 5.3.0-rc3+ #124
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: krxrpcd rxrpc_peer_keepalive_worker
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
RIP: 0010:aa_sock_msg_perm.isra.0+0xdd/0x170 security/apparmor/lsm.c:920
Code: 89 ef e8 66 e6 02 00 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 16 25 68 fe  
48 c7 c6 a0 8f c0 87 48 c7 c7 a0 7a c0 87 e8 db 97 39 fe <0f> 0b e9 43 ff  
ff ff e8 f7 24 68 fe 48 c7 c6 a0 8f c0 87 48 c7 c7
RSP: 0018:ffff8880689f79b0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff815c3ba6 RDI: ffffed100d13ef28
RBP: ffff8880689f79d8 R08: ffff88806916e300 R09: fffffbfff11b42c5
R10: fffffbfff11b42c4 R11: ffffffff88da1623 R12: ffff8880689f7b20
R13: ffffffff87c07ee0 R14: 0000000000000002 R15: 000000000000001d
  apparmor_socket_sendmsg+0x2a/0x30 security/apparmor/lsm.c:936
  security_socket_sendmsg+0x77/0xc0 security/security.c:1973
  sock_sendmsg+0x45/0x130 net/socket.c:654
  kernel_sendmsg+0x44/0x50 net/socket.c:677
  rxrpc_send_keepalive+0x1ff/0x940 net/rxrpc/output.c:656
  rxrpc_peer_keepalive_dispatch net/rxrpc/peer_event.c:369 [inline]
  rxrpc_peer_keepalive_worker+0x7be/0xd02 net/rxrpc/peer_event.c:430
  process_one_work+0x9af/0x1740 kernel/workqueue.c:2269
  worker_thread+0x98/0xe40 kernel/workqueue.c:2415
  kthread+0x361/0x430 kernel/kthread.c:255
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
