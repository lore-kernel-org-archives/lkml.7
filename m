Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93DB2C32758
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A12B217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="BjYC8ivD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfHJInA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:43:00 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:38123 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbfHJIm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:42:57 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 465FvS6stYzfH;
        Sat, 10 Aug 2019 10:41:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1565426485; bh=C+9Erl6/2fjjlTshmwRgC3WjqRobpDMKu9Dc2cO33B8=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=BjYC8ivDX5FV9PuRKHdA045kGCbOOu01YRyyB+aBja91errK4Aqq9KgFkpGipczLI
         gVKrLMTSHBRuywRT/oIMFe/f2gTp1EGM2R6ov1blA4lIyFbg9KSKRE1aulUjF0n4sj
         3K1NRBUwtdxuLw8k3De9hheAiqynSOTfUQ49kvn5svvF1t+hxnt1DFXBM6/piOrI9w
         X+pC0ZF2b3hOkd84JLg+07sAxZEvwYuOqlP/CCFsx6F7s7ezuEypTHv/QIMCR2pZ6V
         7Zy1K04Jo75YYhewsGrqOELCC1C+nzZqHaK7/MLBFla+2Ix1LsiUFO6bhrG4gov2GW
         SP2chTKR2U3ww==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Sat, 10 Aug 2019 10:42:53 +0200
Message-Id: <b94e4fc52570e1aef9ab1eb01c72044a942255b8.1565426370.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
References: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 7/7] usb: gadget: u_serial: use mutex for serialising
 open()s
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove home-made waiting mechanism from gs_open() and rely on
portmaster's mutex to do the job.

Note: This releases thread waiting on close() when another thread
open()s simultaneously.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>

---
  v6: initial revision, new in the patchset

---
 drivers/usb/gadget/function/u_serial.c | 112 ++++++++-----------------
 1 file changed, 37 insertions(+), 75 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index a248ed0fd5d2..f986e5c55974 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -104,7 +104,6 @@ struct gs_port {
 	struct gs_console	*console;
 #endif
 
-	bool			openclose;	/* open/close in progress */
 	u8			port_num;
 
 	struct list_head	read_pool;
@@ -588,82 +587,45 @@ static int gs_open(struct tty_struct *tty, struct file *file)
 {
 	int		port_num = tty->index;
 	struct gs_port	*port;
-	int		status;
+	int		status = 0;
 
-	do {
-		mutex_lock(&ports[port_num].lock);
-		port = ports[port_num].port;
-		if (!port)
-			status = -ENODEV;
-		else {
-			spin_lock_irq(&port->port_lock);
+	mutex_lock(&ports[port_num].lock);
+	port = ports[port_num].port;
+	if (!port) {
+		status = -ENODEV;
+		goto out;
+	}
 
-			/* already open?  Great. */
-			if (port->port.count) {
-				status = 0;
-				port->port.count++;
-
-			/* currently opening/closing? wait ... */
-			} else if (port->openclose) {
-				status = -EBUSY;
-
-			/* ... else we do the work */
-			} else {
-				status = -EAGAIN;
-				port->openclose = true;
-			}
-			spin_unlock_irq(&port->port_lock);
-		}
-		mutex_unlock(&ports[port_num].lock);
-
-		switch (status) {
-		default:
-			/* fully handled */
-			return status;
-		case -EAGAIN:
-			/* must do the work */
-			break;
-		case -EBUSY:
-			/* wait for EAGAIN task to finish */
-			msleep(1);
-			/* REVISIT could have a waitchannel here, if
-			 * concurrent open performance is important
-			 */
-			break;
-		}
-	} while (status != -EAGAIN);
-
-	/* Do the "real open" */
 	spin_lock_irq(&port->port_lock);
 
 	/* allocate circular buffer on first open */
 	if (!kfifo_initialized(&port->port_write_buf)) {
 
 		spin_unlock_irq(&port->port_lock);
+
+		/*
+		 * portmaster's mutex still protects from simultaneous open(),
+		 * and close() can't happen, yet.
+		 */
+
 		status = kfifo_alloc(&port->port_write_buf,
 				     WRITE_BUF_SIZE, GFP_KERNEL);
-		spin_lock_irq(&port->port_lock);
-
 		if (status) {
 			pr_debug("gs_open: ttyGS%d (%p,%p) no buffer\n",
-				port->port_num, tty, file);
-			port->openclose = false;
-			goto exit_unlock_port;
+				 port_num, tty, file);
+			goto out;
 		}
+
+		spin_lock_irq(&port->port_lock);
 	}
 
-	/* REVISIT if REMOVED (ports[].port NULL), abort the open
-	 * to let rmmod work faster (but this way isn't wrong).
-	 */
-
-	/* REVISIT maybe wait for "carrier detect" */
+	/* already open?  Great. */
+	if (port->port.count++)
+		goto exit_unlock_port;
 
 	tty->driver_data = port;
 	port->port.tty = tty;
 
-	port->port.count = 1;
-	port->openclose = false;
-
 	/* if connected, start the I/O stream */
 	if (port->port_usb) {
 		struct gserial	*gser = port->port_usb;
@@ -677,20 +639,21 @@ static int gs_open(struct tty_struct *tty, struct file *file)
 
 	pr_debug("gs_open: ttyGS%d (%p,%p)\n", port->port_num, tty, file);
 
-	status = 0;
-
 exit_unlock_port:
 	spin_unlock_irq(&port->port_lock);
+out:
+	mutex_unlock(&ports[port_num].lock);
 	return status;
 }
 
-static int gs_writes_finished(struct gs_port *p)
+static int gs_close_flush_done(struct gs_port *p)
 {
 	int cond;
 
-	/* return true on disconnect or empty buffer */
+	/* return true on disconnect or empty buffer or if raced with open() */
 	spin_lock_irq(&p->port_lock);
-	cond = (p->port_usb == NULL) || !kfifo_len(&p->port_write_buf);
+	cond = p->port_usb == NULL || !kfifo_len(&p->port_write_buf) ||
+		p->port.count > 1;
 	spin_unlock_irq(&p->port_lock);
 
 	return cond;
@@ -704,6 +667,7 @@ static void gs_close(struct tty_struct *tty, struct file *file)
 	spin_lock_irq(&port->port_lock);
 
 	if (port->port.count != 1) {
+raced_with_open:
 		if (port->port.count == 0)
 			WARN_ON(1);
 		else
@@ -713,12 +677,6 @@ static void gs_close(struct tty_struct *tty, struct file *file)
 
 	pr_debug("gs_close: ttyGS%d (%p,%p) ...\n", port->port_num, tty, file);
 
-	/* mark port as closing but in use; we can drop port lock
-	 * and sleep if necessary
-	 */
-	port->openclose = true;
-	port->port.count = 0;
-
 	gser = port->port_usb;
 	if (gser && gser->disconnect)
 		gser->disconnect(gser);
@@ -729,9 +687,13 @@ static void gs_close(struct tty_struct *tty, struct file *file)
 	if (kfifo_len(&port->port_write_buf) > 0 && gser) {
 		spin_unlock_irq(&port->port_lock);
 		wait_event_interruptible_timeout(port->drain_wait,
-					gs_writes_finished(port),
+					gs_close_flush_done(port),
 					GS_CLOSE_TIMEOUT * HZ);
 		spin_lock_irq(&port->port_lock);
+
+		if (port->port.count != 1)
+			goto raced_with_open;
+
 		gser = port->port_usb;
 	}
 
@@ -744,10 +706,9 @@ static void gs_close(struct tty_struct *tty, struct file *file)
 	else
 		kfifo_reset(&port->port_write_buf);
 
+	port->port.count = 0;
 	port->port.tty = NULL;
 
-	port->openclose = false;
-
 	pr_debug("gs_close: ttyGS%d (%p,%p) done!\n",
 			port->port_num, tty, file);
 
@@ -1207,8 +1168,9 @@ static int gs_closed(struct gs_port *port)
 	int cond;
 
 	spin_lock_irq(&port->port_lock);
-	cond = (port->port.count == 0) && !port->openclose;
+	cond = port->port.count == 0;
 	spin_unlock_irq(&port->port_lock);
+
 	return cond;
 }
 
@@ -1413,7 +1375,7 @@ void gserial_disconnect(struct gserial *gser)
 
 	port->port_usb = NULL;
 	gser->ioport = NULL;
-	if (port->port.count > 0 || port->openclose) {
+	if (port->port.count > 0) {
 		wake_up_interruptible(&port->drain_wait);
 		if (port->port.tty)
 			tty_hangup(port->port.tty);
@@ -1426,7 +1388,7 @@ void gserial_disconnect(struct gserial *gser)
 
 	/* finally, free any unused/unusable I/O buffers */
 	spin_lock_irqsave(&port->port_lock, flags);
-	if (port->port.count == 0 && !port->openclose)
+	if (port->port.count == 0)
 		kfifo_free(&port->port_write_buf);
 	gs_free_requests(gser->out, &port->read_pool, NULL);
 	gs_free_requests(gser->out, &port->read_queue, NULL);
-- 
2.20.1

