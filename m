Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0243C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B85204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 08:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfDQI65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 04:58:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:44330 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfDQI65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 04:58:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D177B03A;
        Wed, 17 Apr 2019 08:58:55 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Li RongQing <lirongqing@baidu.com>,
        Wang Li <wangli39@baidu.com>, Zhang Yu <zhangyu31@baidu.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] TTY: serial_core, add ->install
Date:   Wed, 17 Apr 2019 10:58:53 +0200
Message-Id: <20190417085853.21708-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to compute the uart state only on the first open. This is
usually what is done in the ->install hook. serial_core used to do this
in ->open on every open. So move it to ->install.

As a side effect, it ensures the state is set properly in the window
after tty_init_dev is called, but before uart_open. This fixes a bunch
of races between tty_open and flush_to_ldisc we were dealing with
recently.

One of such bugs was attempted to fix in commit fedb5760648a (serial:
fix race between flush_to_ldisc and tty_open), but it only took care of
a couple of functions (uart_start and uart_unthrottle).  I was able to
reproduce the crash on a SLE system, but in uart_write_room which is
also called from flush_to_ldisc via process_echoes. I was *unable* to
reproduce the bug locally. It is due to having this patch in my queue
since 2012!

 general protection fault: 0000 [#1] SMP KASAN PTI
 CPU: 1 PID: 5 Comm: kworker/u4:0 Tainted: G             L 4.12.14-396-default #1 SLE15-SP1 (unreleased)
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-0-ga698c89-prebuilt.qemu.org 04/01/2014
 Workqueue: events_unbound flush_to_ldisc
 task: ffff8800427d8040 task.stack: ffff8800427f0000
 RIP: 0010:uart_write_room+0xc4/0x590
 RSP: 0018:ffff8800427f7088 EFLAGS: 00010202
 RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
 RDX: 000000000000002f RSI: 00000000000000ee RDI: ffff88003888bd90
 RBP: ffffffffb9545850 R08: 0000000000000001 R09: 0000000000000400
 R10: ffff8800427d825c R11: 000000000000006e R12: 1ffff100084fee12
 R13: ffffc900004c5000 R14: ffff88003888bb28 R15: 0000000000000178
 FS:  0000000000000000(0000) GS:ffff880043300000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000561da0794148 CR3: 000000000ebf4000 CR4: 00000000000006e0
 Call Trace:
  tty_write_room+0x6d/0xc0
  __process_echoes+0x55/0x870
  n_tty_receive_buf_common+0x105e/0x26d0
  tty_ldisc_receive_buf+0xb7/0x1c0
  tty_port_default_receive_buf+0x107/0x180
  flush_to_ldisc+0x35d/0x5c0
...

0 in rbx means tty->driver_data is NULL in uart_write_room. 0x178 is
tried to be dereferenced (0x178 >> 3 is 0x2f in rdx) at
uart_write_room+0xc4. 0x178 is exactly (struct uart_state *)NULL->refcount
used in uart_port_lock from uart_write_room.

So revert the upstream commit here as my local patch should fix the
whole family.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Li RongQing <lirongqing@baidu.com>
Cc: Wang Li <wangli39@baidu.com>
Cc: Zhang Yu <zhangyu31@baidu.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
---

============================= NOTE =============================

Could you test your use-case at Baidu, guys, please?


 drivers/tty/serial/serial_core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7c787e517fa5..33319544d9d2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -130,9 +130,6 @@ static void uart_start(struct tty_struct *tty)
 	struct uart_port *port;
 	unsigned long flags;
 
-	if (!state)
-		return;
-
 	port = uart_port_lock(state, flags);
 	__uart_start(tty);
 	uart_port_unlock(port, flags);
@@ -730,9 +727,6 @@ static void uart_unthrottle(struct tty_struct *tty)
 	upstat_t mask = UPSTAT_SYNC_FIFO;
 	struct uart_port *port;
 
-	if (!state)
-		return;
-
 	port = uart_port_ref(state);
 	if (!port)
 		return;
@@ -1732,6 +1726,16 @@ static void uart_dtr_rts(struct tty_port *port, int raise)
 	uart_port_deref(uport);
 }
 
+static int uart_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+	struct uart_driver *drv = driver->driver_state;
+	struct uart_state *state = drv->state + tty->index;
+
+	tty->driver_data = state;
+
+	return tty_standard_install(driver, tty);
+}
+
 /*
  * Calls to uart_open are serialised by the tty_lock in
  *   drivers/tty/tty_io.c:tty_open()
@@ -1744,11 +1748,8 @@ static void uart_dtr_rts(struct tty_port *port, int raise)
  */
 static int uart_open(struct tty_struct *tty, struct file *filp)
 {
-	struct uart_driver *drv = tty->driver->driver_state;
-	int retval, line = tty->index;
-	struct uart_state *state = drv->state + line;
-
-	tty->driver_data = state;
+	struct uart_state *state = tty->driver_data;
+	int retval;
 
 	retval = tty_port_open(&state->port, tty, filp);
 	if (retval > 0)
@@ -2433,6 +2434,7 @@ static void uart_poll_put_char(struct tty_driver *driver, int line, char ch)
 #endif
 
 static const struct tty_operations uart_ops = {
+	.install	= uart_install,
 	.open		= uart_open,
 	.close		= uart_close,
 	.write		= uart_write,
-- 
2.21.0

