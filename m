Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDE1C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3CCA217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 08:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="jJ5HWzFk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbfHJImz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 04:42:55 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:8529 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbfHJImy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 04:42:54 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 465FvN73bSzTl;
        Sat, 10 Aug 2019 10:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1565426481; bh=gINti00NJ8By4cKwRERuUvhJlC3OySsNBmv3HB0VDpY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=jJ5HWzFkvCI55yi5PBPZ8uMO3FivH3tog4wavco7MO0XvTMByG7IV1pEbqhga/fJj
         kHlYrsuj80DTSWbVqpILiUxQtdTVZND/9OLioh/iQKGSaZ8YPj4W5CKU4foAZmIOdU
         RYzasfHWBv8auObY7pGIBos7K2+cjSOFe5E1ZX+Hjl9jBj9q/tjTCxhTJMliShXjVQ
         LDAqbvXtJ7//3Y2aAjUOA1gB6DyaXFv+mCktxuIrVFFm/HNSrCIsqK45ixJCJj5pTM
         92hcJnAnj1Aie7OJFxJN+b4px8H5Z86ZwfllS1D11knT9l3kCN5hvHTc802q+7pA3Q
         u6zm7vGLil2SQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.100.3 at mail
Date:   Sat, 10 Aug 2019 10:42:49 +0200
Message-Id: <06933db6ec637d76928fbdbe5ffdcddd9b425251.1565426370.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
References: <cover.1565426370.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 2/7] usb: gadget: u_serial: reimplement console support
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

Rewrite console support to fix a few shortcomings of the old code
preventing its use with multiple ports. This removes some duplicated
code and replaces a custom kthread with simpler workqueue item.

Only port ttyGS0 gets to be a console for now.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Ladislav Michl <ladis@linux-mips.org>

---
  v6: rebased on balbi/testing/next
  v5: no changes
  v4: cosmetic change to __gs_console_push()
  v3: no changes
  v2: no changes

---
 drivers/usb/gadget/function/u_serial.c | 351 ++++++++++++-------------
 1 file changed, 164 insertions(+), 187 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index bb1e2e1d0076..94f6999e8262 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -82,14 +82,12 @@
 #define GS_CONSOLE_BUF_SIZE	8192
 
 /* console info */
-struct gscons_info {
-	struct gs_port		*port;
-	struct task_struct	*console_thread;
-	struct kfifo		con_buf;
-	/* protect the buf and busy flag */
-	spinlock_t		con_lock;
-	int			req_busy;
-	struct usb_request	*console_req;
+struct gs_console {
+	struct console		console;
+	struct work_struct	work;
+	spinlock_t		lock;
+	struct usb_request	*req;
+	struct kfifo		buf;
 };
 
 /*
@@ -101,6 +99,9 @@ struct gs_port {
 	spinlock_t		port_lock;	/* guard port_* access */
 
 	struct gserial		*port_usb;
+#ifdef CONFIG_U_SERIAL_CONSOLE
+	struct gs_console	*console;
+#endif
 
 	bool			openclose;	/* open/close in progress */
 	u8			port_num;
@@ -889,36 +890,9 @@ static struct tty_driver *gs_tty_driver;
 
 #ifdef CONFIG_U_SERIAL_CONSOLE
 
-static struct gscons_info gscons_info;
-static struct console gserial_cons;
-
-static struct usb_request *gs_request_new(struct usb_ep *ep)
+static void gs_console_complete_out(struct usb_ep *ep, struct usb_request *req)
 {
-	struct usb_request *req = usb_ep_alloc_request(ep, GFP_ATOMIC);
-	if (!req)
-		return NULL;
-
-	req->buf = kmalloc(ep->maxpacket, GFP_ATOMIC);
-	if (!req->buf) {
-		usb_ep_free_request(ep, req);
-		return NULL;
-	}
-
-	return req;
-}
-
-static void gs_request_free(struct usb_request *req, struct usb_ep *ep)
-{
-	if (!req)
-		return;
-
-	kfree(req->buf);
-	usb_ep_free_request(ep, req);
-}
-
-static void gs_complete_out(struct usb_ep *ep, struct usb_request *req)
-{
-	struct gscons_info *info = &gscons_info;
+	struct gs_console *cons = req->context;
 
 	switch (req->status) {
 	default:
@@ -927,12 +901,12 @@ static void gs_complete_out(struct usb_ep *ep, struct usb_request *req)
 		/* fall through */
 	case 0:
 		/* normal completion */
-		spin_lock(&info->con_lock);
-		info->req_busy = 0;
-		spin_unlock(&info->con_lock);
-
-		wake_up_process(info->console_thread);
+		spin_lock(&cons->lock);
+		req->length = 0;
+		schedule_work(&cons->work);
+		spin_unlock(&cons->lock);
 		break;
+	case -ECONNRESET:
 	case -ESHUTDOWN:
 		/* disconnect */
 		pr_vdebug("%s: %s shutdown\n", __func__, ep->name);
@@ -940,190 +914,190 @@ static void gs_complete_out(struct usb_ep *ep, struct usb_request *req)
 	}
 }
 
-static int gs_console_connect(int port_num)
+static void __gs_console_push(struct gs_console *cons)
 {
-	struct gscons_info *info = &gscons_info;
-	struct gs_port *port;
+	struct usb_request *req = cons->req;
 	struct usb_ep *ep;
+	size_t size;
 
-	if (port_num != gserial_cons.index) {
-		pr_err("%s: port num [%d] is not support console\n",
-		       __func__, port_num);
-		return -ENXIO;
-	}
+	if (!req)
+		return;	/* disconnected */
 
-	port = ports[port_num].port;
-	ep = port->port_usb->in;
-	if (!info->console_req) {
-		info->console_req = gs_request_new(ep);
-		if (!info->console_req)
-			return -ENOMEM;
-		info->console_req->complete = gs_complete_out;
-	}
+	if (req->length)
+		return;	/* busy */
 
-	info->port = port;
-	spin_lock(&info->con_lock);
-	info->req_busy = 0;
-	spin_unlock(&info->con_lock);
-	pr_vdebug("port[%d] console connect!\n", port_num);
-	return 0;
-}
-
-static void gs_console_disconnect(struct usb_ep *ep)
-{
-	struct gscons_info *info = &gscons_info;
-	struct usb_request *req = info->console_req;
-
-	gs_request_free(req, ep);
-	info->console_req = NULL;
-}
-
-static int gs_console_thread(void *data)
-{
-	struct gscons_info *info = &gscons_info;
-	struct gs_port *port;
-	struct usb_request *req;
-	struct usb_ep *ep;
-	int xfer, ret, count, size;
+	ep = cons->console.data;
+	size = kfifo_out(&cons->buf, req->buf, ep->maxpacket);
+	if (!size)
+		return;
 
-	do {
-		port = info->port;
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (!port || !port->port_usb
-		    || !port->port_usb->in || !info->console_req)
-			goto sched;
-
-		req = info->console_req;
-		ep = port->port_usb->in;
-
-		spin_lock_irq(&info->con_lock);
-		count = kfifo_len(&info->con_buf);
-		size = ep->maxpacket;
-
-		if (count > 0 && !info->req_busy) {
-			set_current_state(TASK_RUNNING);
-			if (count < size)
-				size = count;
-
-			xfer = kfifo_out(&info->con_buf, req->buf, size);
-			req->length = xfer;
-
-			spin_unlock(&info->con_lock);
-			ret = usb_ep_queue(ep, req, GFP_ATOMIC);
-			spin_lock(&info->con_lock);
-			if (ret < 0)
-				info->req_busy = 0;
-			else
-				info->req_busy = 1;
-
-			spin_unlock_irq(&info->con_lock);
-		} else {
-			spin_unlock_irq(&info->con_lock);
-sched:
-			if (kthread_should_stop()) {
-				set_current_state(TASK_RUNNING);
-				break;
-			}
-			schedule();
-		}
-	} while (1);
-
-	return 0;
+	req->length = size;
+	if (usb_ep_queue(ep, req, GFP_ATOMIC))
+		req->length = 0;
 }
 
-static int gs_console_setup(struct console *co, char *options)
+static void gs_console_work(struct work_struct *work)
 {
-	struct gscons_info *info = &gscons_info;
-	int status;
-
-	info->port = NULL;
-	info->console_req = NULL;
-	info->req_busy = 0;
-	spin_lock_init(&info->con_lock);
+	struct gs_console *cons = container_of(work, struct gs_console, work);
 
-	status = kfifo_alloc(&info->con_buf, GS_CONSOLE_BUF_SIZE, GFP_KERNEL);
-	if (status) {
-		pr_err("%s: allocate console buffer failed\n", __func__);
-		return status;
-	}
+	spin_lock_irq(&cons->lock);
 
-	info->console_thread = kthread_create(gs_console_thread,
-					      co, "gs_console");
-	if (IS_ERR(info->console_thread)) {
-		pr_err("%s: cannot create console thread\n", __func__);
-		kfifo_free(&info->con_buf);
-		return PTR_ERR(info->console_thread);
-	}
-	wake_up_process(info->console_thread);
+	__gs_console_push(cons);
 
-	return 0;
+	spin_unlock_irq(&cons->lock);
 }
 
 static void gs_console_write(struct console *co,
 			     const char *buf, unsigned count)
 {
-	struct gscons_info *info = &gscons_info;
+	struct gs_console *cons = container_of(co, struct gs_console, console);
 	unsigned long flags;
 
-	spin_lock_irqsave(&info->con_lock, flags);
-	kfifo_in(&info->con_buf, buf, count);
-	spin_unlock_irqrestore(&info->con_lock, flags);
+	spin_lock_irqsave(&cons->lock, flags);
 
-	wake_up_process(info->console_thread);
+	kfifo_in(&cons->buf, buf, count);
+
+	if (cons->req && !cons->req->length)
+		schedule_work(&cons->work);
+
+	spin_unlock_irqrestore(&cons->lock, flags);
 }
 
 static struct tty_driver *gs_console_device(struct console *co, int *index)
 {
-	struct tty_driver **p = (struct tty_driver **)co->data;
-
-	if (!*p)
-		return NULL;
-
 	*index = co->index;
-	return *p;
+	return gs_tty_driver;
 }
 
-static struct console gserial_cons = {
-	.name =		"ttyGS",
-	.write =	gs_console_write,
-	.device =	gs_console_device,
-	.setup =	gs_console_setup,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
-	.data =		&gs_tty_driver,
-};
-
-static void gserial_console_init(void)
+static int gs_console_connect(struct gs_port *port)
 {
-	register_console(&gserial_cons);
+	struct gs_console *cons = port->console;
+	struct usb_request *req;
+	struct usb_ep *ep;
+
+	if (!cons)
+		return 0;
+
+	ep = port->port_usb->in;
+	req = gs_alloc_req(ep, ep->maxpacket, GFP_ATOMIC);
+	if (!req)
+		return -ENOMEM;
+	req->complete = gs_console_complete_out;
+	req->context = cons;
+	req->length = 0;
+
+	spin_lock(&cons->lock);
+	cons->req = req;
+	cons->console.data = ep;
+	spin_unlock(&cons->lock);
+
+	pr_debug("ttyGS%d: console connected!\n", port->port_num);
+
+	schedule_work(&cons->work);
+
+	return 0;
+}
+
+static void gs_console_disconnect(struct gs_port *port)
+{
+	struct gs_console *cons = port->console;
+	struct usb_request *req;
+	struct usb_ep *ep;
+
+	if (!cons)
+		return;
+
+	spin_lock(&cons->lock);
+
+	req = cons->req;
+	ep = cons->console.data;
+	cons->req = NULL;
+
+	spin_unlock(&cons->lock);
+
+	if (!req)
+		return;
+
+	usb_ep_dequeue(ep, req);
+	gs_free_req(ep, req);
 }
 
-static void gserial_console_exit(void)
+static int gs_console_init(struct gs_port *port)
 {
-	struct gscons_info *info = &gscons_info;
+	struct gs_console *cons;
+	int err;
+
+	if (port->console)
+		return 0;
+
+	cons = kzalloc(sizeof(*port->console), GFP_KERNEL);
+	if (!cons)
+		return -ENOMEM;
+
+	strcpy(cons->console.name, "ttyGS");
+	cons->console.write = gs_console_write;
+	cons->console.device = gs_console_device;
+	cons->console.flags = CON_PRINTBUFFER;
+	cons->console.index = port->port_num;
+
+	INIT_WORK(&cons->work, gs_console_work);
+	spin_lock_init(&cons->lock);
+
+	err = kfifo_alloc(&cons->buf, GS_CONSOLE_BUF_SIZE, GFP_KERNEL);
+	if (err) {
+		pr_err("ttyGS%d: allocate console buffer failed\n", port->port_num);
+		kfree(cons);
+		return err;
+	}
+
+	port->console = cons;
+	register_console(&cons->console);
+
+	spin_lock_irq(&port->port_lock);
+	if (port->port_usb)
+		gs_console_connect(port);
+	spin_unlock_irq(&port->port_lock);
+
+	return 0;
+}
+
+static void gs_console_exit(struct gs_port *port)
+{
+	struct gs_console *cons = port->console;
+
+	if (!cons)
+		return;
+
+	unregister_console(&cons->console);
+
+	spin_lock_irq(&port->port_lock);
+	if (cons->req)
+		gs_console_disconnect(port);
+	spin_unlock_irq(&port->port_lock);
 
-	unregister_console(&gserial_cons);
-	if (!IS_ERR_OR_NULL(info->console_thread))
-		kthread_stop(info->console_thread);
-	kfifo_free(&info->con_buf);
+	cancel_work_sync(&cons->work);
+	kfifo_free(&cons->buf);
+	kfree(cons);
+	port->console = NULL;
 }
 
 #else
 
-static int gs_console_connect(int port_num)
+static int gs_console_connect(struct gs_port *port)
 {
 	return 0;
 }
 
-static void gs_console_disconnect(struct usb_ep *ep)
+static void gs_console_disconnect(struct gs_port *port)
 {
 }
 
-static void gserial_console_init(void)
+static int gs_console_init(struct gs_port *port)
 {
+	return -ENOSYS;
 }
 
-static void gserial_console_exit(void)
+static void gs_console_exit(struct gs_port *port)
 {
 }
 
@@ -1197,18 +1171,19 @@ void gserial_free_line(unsigned char port_num)
 		return;
 	}
 	port = ports[port_num].port;
+	gs_console_exit(port);
 	ports[port_num].port = NULL;
 	mutex_unlock(&ports[port_num].lock);
 
 	gserial_free_port(port);
 	tty_unregister_device(gs_tty_driver, port_num);
-	gserial_console_exit();
 }
 EXPORT_SYMBOL_GPL(gserial_free_line);
 
 int gserial_alloc_line(unsigned char *line_num)
 {
 	struct usb_cdc_line_coding	coding;
+	struct gs_port			*port;
 	struct device			*tty_dev;
 	int				ret;
 	int				port_num;
@@ -1231,23 +1206,24 @@ int gserial_alloc_line(unsigned char *line_num)
 
 	/* ... and sysfs class devices, so mdev/udev make /dev/ttyGS* */
 
-	tty_dev = tty_port_register_device(&ports[port_num].port->port,
+	port = ports[port_num].port;
+	tty_dev = tty_port_register_device(&port->port,
 			gs_tty_driver, port_num, NULL);
 	if (IS_ERR(tty_dev)) {
-		struct gs_port	*port;
 		pr_err("%s: failed to register tty for port %d, err %ld\n",
 				__func__, port_num, PTR_ERR(tty_dev));
 
 		ret = PTR_ERR(tty_dev);
 		mutex_lock(&ports[port_num].lock);
-		port = ports[port_num].port;
 		ports[port_num].port = NULL;
 		mutex_unlock(&ports[port_num].lock);
 		gserial_free_port(port);
 		goto err;
 	}
 	*line_num = port_num;
-	gserial_console_init();
+
+	if (!port_num)
+		gs_console_init(port);
 err:
 	return ret;
 }
@@ -1329,7 +1305,7 @@ int gserial_connect(struct gserial *gser, u8 port_num)
 			gser->disconnect(gser);
 	}
 
-	status = gs_console_connect(port_num);
+	status = gs_console_connect(port);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 
 	return status;
@@ -1361,6 +1337,8 @@ void gserial_disconnect(struct gserial *gser)
 	/* tell the TTY glue not to do I/O here any more */
 	spin_lock_irqsave(&port->port_lock, flags);
 
+	gs_console_disconnect(port);
+
 	/* REVISIT as above: how best to track this? */
 	port->port_line_coding = gser->port_line_coding;
 
@@ -1388,7 +1366,6 @@ void gserial_disconnect(struct gserial *gser)
 	port->read_allocated = port->read_started =
 		port->write_allocated = port->write_started = 0;
 
-	gs_console_disconnect(gser->in);
 	spin_unlock_irqrestore(&port->port_lock, flags);
 }
 EXPORT_SYMBOL_GPL(gserial_disconnect);
-- 
2.20.1

