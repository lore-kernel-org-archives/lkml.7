Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A1AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D1020856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbfDBNns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:43:48 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43588 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731505AbfDBNkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:10 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe3-0002ob-U0; Tue, 02 Apr 2019 14:40:08 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdy-0004yD-6U; Tue, 02 Apr 2019 14:40:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Eric Dumazet" <edumazet@google.com>,
        "Andreas Koensgen" <ajk@comnets.uni-bremen.de>,
        "David S. Miller" <davem@davemloft.net>,
        "syzbot" <syzkaller@googlegroups.com>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.671795435@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 96/99] net/hamradio/6pack: use mod_timer() to rearm
 timers
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

commit 202700e30740c6568b5a6943662f3829566dd533 upstream.

Using del_timer() + add_timer() is generally unsafe on SMP,
as noticed by syzbot. Use mod_timer() instead.

kernel BUG at kernel/time/timer.c:1136!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1026 Comm: kworker/u4:4 Not tainted 4.20.0+ #2
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events_unbound flush_to_ldisc
RIP: 0010:add_timer kernel/time/timer.c:1136 [inline]
RIP: 0010:add_timer+0xa81/0x1470 kernel/time/timer.c:1134
Code: 4d 89 7d 40 48 c7 85 70 fe ff ff 00 00 00 00 c7 85 7c fe ff ff ff ff ff ff 48 89 85 90 fe ff ff e9 e6 f7 ff ff e8 cf 42 12 00 <0f> 0b e8 c8 42 12 00 0f 0b e8 c1 42 12 00 4c 89 bd 60 fe ff ff e9
RSP: 0018:ffff8880a7fdf5a8 EFLAGS: 00010293
RAX: ffff8880a7846340 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff816f3ee1 RDI: ffff88808a514ff8
RBP: ffff8880a7fdf760 R08: 0000000000000007 R09: ffff8880a7846c58
R10: ffff8880a7846340 R11: 0000000000000000 R12: ffff88808a514ff8
R13: ffff88808a514ff8 R14: ffff88808a514dc0 R15: 0000000000000030
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000061c500 CR3: 00000000994d9000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 decode_prio_command drivers/net/hamradio/6pack.c:903 [inline]
 sixpack_decode drivers/net/hamradio/6pack.c:971 [inline]
 sixpack_receive_buf drivers/net/hamradio/6pack.c:457 [inline]
 sixpack_receive_buf+0xf9c/0x1470 drivers/net/hamradio/6pack.c:434
 tty_ldisc_receive_buf+0x164/0x1c0 drivers/tty/tty_buffer.c:465
 tty_port_default_receive_buf+0x114/0x190 drivers/tty/tty_port.c:38
 receive_buf drivers/tty/tty_buffer.c:481 [inline]
 flush_to_ldisc+0x3b2/0x590 drivers/tty/tty_buffer.c:533
 process_one_work+0xd0c/0x1ce0 kernel/workqueue.c:2153
 worker_thread+0x143/0x14a0 kernel/workqueue.c:2296
 kthread+0x357/0x430 kernel/kthread.c:246
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: Andreas Koensgen <ajk@comnets.uni-bremen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: Move initialisation of resync_t.data and
 resync_t.function to sixpack_open(), as done by upstream commit
 8e763de0b91d "net/hamradio/6pack: Convert timers to use timer_setup()".]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -551,12 +551,7 @@ static void resync_tnc(unsigned long cha
 
 
 	/* Start resync timer again -- the TNC might be still absent */
-
-	del_timer(&sp->resync_t);
-	sp->resync_t.data	= (unsigned long) sp;
-	sp->resync_t.function	= resync_tnc;
-	sp->resync_t.expires	= jiffies + SIXP_RESYNC_TIMEOUT;
-	add_timer(&sp->resync_t);
+	mod_timer(&sp->resync_t, jiffies + SIXP_RESYNC_TIMEOUT);
 }
 
 static inline int tnc_init(struct sixpack *sp)
@@ -567,11 +562,7 @@ static inline int tnc_init(struct sixpac
 
 	sp->tty->ops->write(sp->tty, &inbyte, 1);
 
-	del_timer(&sp->resync_t);
-	sp->resync_t.data = (unsigned long) sp;
-	sp->resync_t.function = resync_tnc;
-	sp->resync_t.expires = jiffies + SIXP_RESYNC_TIMEOUT;
-	add_timer(&sp->resync_t);
+	mod_timer(&sp->resync_t, jiffies + SIXP_RESYNC_TIMEOUT);
 
 	return 0;
 }
@@ -654,6 +645,8 @@ static int sixpack_open(struct tty_struc
 	sp->tx_t.data = (unsigned long) sp;
 
 	init_timer(&sp->resync_t);
+	sp->resync_t.function = resync_tnc;
+	sp->resync_t.data = (unsigned long) sp;
 
 	spin_unlock_bh(&sp->lock);
 
@@ -947,13 +940,8 @@ static void decode_prio_command(struct s
         /* if the state byte has been received, the TNC is present,
            so the resync timer can be reset. */
 
-	if (sp->tnc_state == TNC_IN_SYNC) {
-		del_timer(&sp->resync_t);
-		sp->resync_t.data	= (unsigned long) sp;
-		sp->resync_t.function	= resync_tnc;
-		sp->resync_t.expires	= jiffies + SIXP_INIT_RESYNC_TIMEOUT;
-		add_timer(&sp->resync_t);
-	}
+	if (sp->tnc_state == TNC_IN_SYNC)
+		mod_timer(&sp->resync_t, jiffies + SIXP_INIT_RESYNC_TIMEOUT);
 
 	sp->status1 = cmd & SIXP_PRIO_DATA_MASK;
 }

