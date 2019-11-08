Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2B1C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9E020679
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 18:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m3GbuJhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfKHS1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 13:27:11 -0500
Received: from mail-wm1-f73.google.com ([209.85.128.73]:40469 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfKHS1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 13:27:10 -0500
Received: by mail-wm1-f73.google.com with SMTP id o202so2766880wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 10:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6vFGUQiqQMnsGREmYmUmTv8HnSBoEzS1qKK1z6j5VRE=;
        b=m3GbuJhCxd4t7IBFMAIuM1h4yKpIsnGeJZOWIQjcsOZREHhan4XEjF9nFS6Vlz/8EY
         SsLq9b5gF+fANSpkd8lSXue5mkewpm8jAqFZO45OrvR9C0ZOyuT/natMMFF+7ep2HF50
         F4/zjDBnicJioXIqHibf6aykLWv8Z9EVrmmf7H1n7TKyXxosLbQ89CfZ1vX3FsB8IuGB
         W8kQvmbQcZiHTi3wJpHqIvWcxJk2bW5lNjvuK1RvaSuAvi4PYd3a/HrVX/sfy+2hOPdt
         z6bppZfNKc9fJb5kxBp7cE3vhm0VcoDJLmVnTJ/Kbl4b8XskqPTFTUirV6QBbaFuzlZx
         FrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6vFGUQiqQMnsGREmYmUmTv8HnSBoEzS1qKK1z6j5VRE=;
        b=ox7d/Zdk6NN6EiKsbiXHJYoXeaXY6D62/s10iKAunATFq4mCZYKH0pqCzkkQX7lHOx
         6kZlBnjspz2Wd7+HAQ459eWmQgFe0BylmSqvsmHuZGlJhRmVNI8WorrUGEGD8UFIk6ff
         MjAtyuNC3AJKY8Q7H68e9x6dVPOvhbNw/tbGW5nX+ZgGjZO6i5ND1imf+EemwFjm2f+v
         /O4sgJwJXLsag60oM6i3Yh/p0Lv6ktZwvDdfXYPFRmSZ7jWPa7VxKeo+dZpYTDUh3Hlb
         Y+XgYIJF5KKz8VBKNKIBbXD/Fepo0jJbIczh4BRHZBBsocOsj05QN8MjRkX/9mFKQRi4
         vpTQ==
X-Gm-Message-State: APjAAAVLsSbkw4VI5S8gadbzBXESg2nJEEBVORjqniIYfww2OSGEQ14E
        yS+BVjEFuPb+zK1TvmYC4NSu6cCoCY9gYk+d
X-Google-Smtp-Source: APXvYqxtiMmwcvDvV4I8tun9TS2AiC6gm7lES61cFBAmPSnrC1oFn7jCuLCyYGRiNlFWTEloNgXZ4J28b9kUkkaD
X-Received: by 2002:a5d:640b:: with SMTP id z11mr4582188wru.195.1573237624073;
 Fri, 08 Nov 2019 10:27:04 -0800 (PST)
Date:   Fri,  8 Nov 2019 19:26:55 +0100
In-Reply-To: <cover.1573236684.git.andreyknvl@google.com>
Message-Id: <282c5da077ad53ce4e5ff9b4350bbf62b33bb6a9.1573236684.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1573236684.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH 1/1] usb: gadget: add raw-gadget interface
From:   Andrey Konovalov <andreyknvl@google.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonathan Corbet <corbet@lwn.net>, Felipe Balbi <balbi@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB Raw Gadget is a kernel module that provides a userspace interface for
the USB Gadget subsystem. Essentially it allows to emulate USB devices
from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
currently a strictly debugging feature and shouldn't be used in
production.

Raw Gadget is similar to GadgetFS, but provides a more low-level and
direct access to the USB Gadget layer for the userspace. The key
differences are:

1. Every USB request is passed to the userspace to get a response, while
   GadgetFS responds to some USB requests internally based on the provided
   descriptors. However note, that the UDC driver might respond to some
   requests on its own and never forward them to the Gadget layer.

2. GadgetFS performs some sanity checks on the provided USB descriptors,
   while Raw Gadget allows you to provide arbitrary data as responses to
   USB requests.

3. Raw Gadget provides a way to select a UDC device/driver to bind to,
   while GadgetFS currently binds to the first available UDC.

4. Raw Gadget uses predictable endpoint names (handles) across different
   UDCs (as long as UDCs have enough endpoints of each required transfer
   type).

5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/usb/index.rst         |    1 +
 Documentation/usb/raw-gadget.rst    |   60 ++
 drivers/usb/gadget/Kconfig          |    9 +
 drivers/usb/gadget/Makefile         |    2 +
 drivers/usb/gadget/raw.c            | 1150 +++++++++++++++++++++++++++
 include/uapi/linux/usb/raw_gadget.h |  164 ++++
 6 files changed, 1386 insertions(+)
 create mode 100644 Documentation/usb/raw-gadget.rst
 create mode 100644 drivers/usb/gadget/raw.c
 create mode 100644 include/uapi/linux/usb/raw_gadget.h

diff --git a/Documentation/usb/index.rst b/Documentation/usb/index.rst
index e55386a4abfb..90310e2a0c1f 100644
--- a/Documentation/usb/index.rst
+++ b/Documentation/usb/index.rst
@@ -22,6 +22,7 @@ USB support
     misc_usbsevseg
     mtouchusb
     ohci
+    raw-gadget
     rio
     usbip_protocol
     usbmon
diff --git a/Documentation/usb/raw-gadget.rst b/Documentation/usb/raw-gadget.rst
new file mode 100644
index 000000000000..8595cd7278df
--- /dev/null
+++ b/Documentation/usb/raw-gadget.rst
@@ -0,0 +1,60 @@
+==============
+USB Raw Gadget
+==============
+
+USB Raw Gadget is a kernel module that provides a userspace interface for
+the USB Gadget subsystem. Essentially it allows to emulate USB devices
+from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
+currently a strictly debugging feature and shouldn't be used in
+production, use GadgetFS instead.
+
+Comparison to GadgetFS
+~~~~~~~~~~~~~~~~~~~~~~
+
+Raw Gadget is similar to GadgetFS, but provides a more low-level and
+direct access to the USB Gadget layer for the userspace. The key
+differences are:
+
+1. Every USB request is passed to the userspace to get a response, while
+   GadgetFS responds to some USB requests internally based on the provided
+   descriptors. However note, that the UDC driver might respond to some
+   requests on its own and never forward them to the Gadget layer.
+
+2. GadgetFS performs some sanity checks on the provided USB descriptors,
+   while Raw Gadget allows you to provide arbitrary data as responses to
+   USB requests.
+
+3. Raw Gadget provides a way to select a UDC device/driver to bind to,
+   while GadgetFS currently binds to the first available UDC.
+
+4. Raw Gadget uses predictable endpoint names (handles) across different
+   UDCs (as long as UDCs have enough endpoints of each required transfer
+   type).
+
+5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.
+
+Userspace interface
+~~~~~~~~~~~~~~~~~~~
+
+To create a Raw Gadget instance open /sys/kernel/debug/usb/raw-gadget
+(debugfs should be enabled and mounted). Multiple raw-gadget instances
+(bound to different UDCs) can be used at the same time. The interaction
+with the opened file happens through the ioctl() calls, see comments in
+include/uapi/linux/usb/raw_gadget.h for details.
+
+The typical usage of Raw Gadget looks like:
+
+1. Open Raw Gadget instance via /sys/kernel/debug/usb/raw-gadget.
+2. Initialize the instance via USB_RAW_IOCTL_INIT.
+3. Launch the instance with USB_RAW_IOCTL_RUN.
+4. In a loop issue USB_RAW_IOCTL_EVENT_FETCH calls to receive events from
+   Raw Gadget and react to those depending on what kind of USB device
+   needs to be emulated.
+
+Potential future improvements
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+- Implement ioctl's for setting/clearing halt status on endpoints.
+
+- Reporting more events (suspend, resume, etc.) through
+  USB_RAW_IOCTL_EVENT_FETCH.
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 02ff850278b1..6b21f1982ed1 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -513,4 +513,13 @@ source "drivers/usb/gadget/legacy/Kconfig"
 
 endchoice
 
+config USB_RAW_GADGET
+	tristate "USB Raw Gadget"
+	depends on DEBUG_FS
+	help
+	  USB Raw Gadget is a kernel module that provides a userspace interface
+	  for the USB Gadget subsystem. Essentially it allows to emulate USB
+	  devices from userspace. See Documentation/usb/raw-gadget.rst for
+	  details.
+
 endif # USB_GADGET
diff --git a/drivers/usb/gadget/Makefile b/drivers/usb/gadget/Makefile
index 130dad7130b6..ea90b5fdd116 100644
--- a/drivers/usb/gadget/Makefile
+++ b/drivers/usb/gadget/Makefile
@@ -11,3 +11,5 @@ libcomposite-y			:= usbstring.o config.o epautoconf.o
 libcomposite-y			+= composite.o functions.o configfs.o u_f.o
 
 obj-$(CONFIG_USB_GADGET)	+= udc/ function/ legacy/
+
+obj-$(CONFIG_USB_RAW_GADGET)	+= raw.o
diff --git a/drivers/usb/gadget/raw.c b/drivers/usb/gadget/raw.c
new file mode 100644
index 000000000000..99d9bc2e4735
--- /dev/null
+++ b/drivers/usb/gadget/raw.c
@@ -0,0 +1,1150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB Raw Gadget driver.
+ * See Documentation/usb/raw-gadget.rst for more details.
+ *
+ * Andrey Konovalov <andreyknvl@gmail.com>
+ */
+
+#define pr_fmt(fmt) "raw: %s: " fmt, __func__
+
+#include <linux/compiler.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/refcount.h>
+#include <linux/semaphore.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+
+#include <linux/usb.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/ch11.h>
+#include <linux/usb/gadgetfs.h>
+#include <linux/usb/gadget.h>
+#include <uapi/linux/usb/raw_gadget.h>
+
+#define	DRIVER_DESC "USB Raw Gadget"
+#define DRIVER_NAME "raw-gadget"
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_AUTHOR("Andrey Konovalov");
+MODULE_LICENSE("GPL");
+
+/*----------------------------------------------------------------------*/
+
+#define RAW_EVENT_QUEUE_SIZE	128
+
+struct raw_event_queue {
+	spinlock_t		lock;
+	struct semaphore	sema;
+	struct usb_raw_event	*events[RAW_EVENT_QUEUE_SIZE];
+	int			size;
+};
+
+static void raw_event_queue_init(struct raw_event_queue *queue)
+{
+	spin_lock_init(&queue->lock);
+	sema_init(&queue->sema, 0);
+	queue->size = 0;
+}
+
+static int raw_event_queue_add(struct raw_event_queue *queue,
+	enum usb_raw_event_type type, size_t length, const void *data)
+{
+	unsigned long flags;
+	struct usb_raw_event *event;
+
+	spin_lock_irqsave(&queue->lock, flags);
+	if (queue->size >= RAW_EVENT_QUEUE_SIZE) {
+		pr_err("too many events\n");
+		spin_unlock_irqrestore(&queue->lock, flags);
+		return -ENOMEM;
+	}
+	pr_debug("event type = %d\n", (int)type);
+	event = kmalloc(sizeof(*event) + length, GFP_ATOMIC);
+	if (!event) {
+		spin_unlock_irqrestore(&queue->lock, flags);
+		return -ENOMEM;
+	}
+	event->type = type;
+	event->length = length;
+	if (event->length)
+		memcpy(&event->data[0], data, length);
+	queue->events[queue->size] = event;
+	queue->size++;
+	up(&queue->sema);
+	pr_debug("added event[%u] = %px\n", queue->size - 1, event);
+	spin_unlock_irqrestore(&queue->lock, flags);
+	return 0;
+}
+
+static struct usb_raw_event *raw_event_queue_fetch(
+				struct raw_event_queue *queue)
+{
+	unsigned long flags;
+	struct usb_raw_event *event;
+
+	if (down_interruptible(&queue->sema))
+		return NULL;
+	spin_lock_irqsave(&queue->lock, flags);
+	if (WARN_ON(!queue->size))
+		return NULL;
+	event = queue->events[0];
+	queue->size--;
+	memmove(&queue->events[0], &queue->events[1],
+			queue->size * sizeof(queue->events[0]));
+	pr_debug("fetched event[0] = %px\n", event);
+	spin_unlock_irqrestore(&queue->lock, flags);
+	return event;
+}
+
+static void raw_event_queue_destroy(struct raw_event_queue *queue)
+{
+	int i;
+
+	for (i = 0; i < queue->size; i++) {
+		pr_debug("freeing event[%d] = %px\n", i, queue->events[i]);
+		kfree(queue->events[i]);
+	}
+	queue->size = 0;
+}
+
+/*----------------------------------------------------------------------*/
+
+struct raw_dev;
+
+#define USB_RAW_MAX_ENDPOINTS 32
+
+enum ep_state {
+	STATE_EP_DISABLED,
+	STATE_EP_ENABLED,
+};
+
+struct raw_ep {
+	struct raw_dev		*dev;
+	enum ep_state		state;
+	struct usb_ep		*ep;
+	struct usb_request	*req;
+	bool			urb_queued;
+	bool			disabling;
+	ssize_t			status;
+};
+
+enum dev_state {
+	STATE_DEV_INVALID = 0,
+	STATE_DEV_OPENED,
+	STATE_DEV_INITIALIZED,
+	STATE_DEV_RUNNING,
+	STATE_DEV_CLOSED,
+	STATE_DEV_FAILED
+};
+
+struct raw_dev {
+	refcount_t			count;
+	spinlock_t			lock;
+
+	const char			*udc_name;
+	struct usb_gadget_driver	driver;
+
+	/* Protected by lock: */
+	enum dev_state			state;
+	bool				gadget_registered;
+	struct usb_gadget		*gadget;
+	struct usb_request		*req;
+	bool				ep0_in_pending;
+	bool				ep0_out_pending;
+	bool				ep0_urb_queued;
+	ssize_t				ep0_status;
+	struct raw_ep			eps[USB_RAW_MAX_ENDPOINTS];
+
+	struct completion		ep0_done;
+	struct raw_event_queue		queue;
+};
+
+static struct raw_dev *dev_new(void)
+{
+	struct raw_dev *dev;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return NULL;
+	refcount_set(&dev->count, 1); /* Matches dev_put() in raw_release(). */
+	spin_lock_init(&dev->lock);
+	init_completion(&dev->ep0_done);
+	raw_event_queue_init(&dev->queue);
+	pr_debug("device created\n");
+	return dev;
+}
+
+static inline void dev_get(struct raw_dev *dev)
+{
+	refcount_inc(&dev->count);
+}
+
+static void dev_put(struct raw_dev *dev)
+{
+	int i;
+
+	if (likely(!refcount_dec_and_test(&dev->count)))
+		return;
+	kfree(dev->udc_name);
+	kfree(dev->driver.udc_name);
+	if (dev->req) {
+		if (dev->ep0_urb_queued)
+			usb_ep_dequeue(dev->gadget->ep0, dev->req);
+		usb_ep_free_request(dev->gadget->ep0, dev->req);
+	}
+	raw_event_queue_destroy(&dev->queue);
+	for (i = 0; i < USB_RAW_MAX_ENDPOINTS; i++) {
+		if (dev->eps[i].state != STATE_EP_ENABLED)
+			continue;
+		usb_ep_disable(dev->eps[i].ep);
+		usb_ep_free_request(dev->eps[i].ep, dev->eps[i].req);
+		kfree(dev->eps[i].ep->desc);
+		dev->eps[i].state = STATE_EP_DISABLED;
+	}
+	kfree(dev);
+	pr_debug("device freed\n");
+}
+
+/*----------------------------------------------------------------------*/
+
+static int raw_queue_event(struct raw_dev *dev,
+	enum usb_raw_event_type type, size_t length, const void *data)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	ret = raw_event_queue_add(&dev->queue, type, length, data);
+	if (ret < 0) {
+		spin_lock_irqsave(&dev->lock, flags);
+		dev->state = STATE_DEV_FAILED;
+		spin_unlock_irqrestore(&dev->lock, flags);
+	}
+	return ret;
+}
+
+static void gadget_ep0_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct raw_dev *dev = req->context;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	pr_debug("length: %d, status: %d\n", req->actual, req->status);
+	if (req->status)
+		dev->ep0_status = req->status;
+	else
+		dev->ep0_status = req->actual;
+	if (dev->ep0_in_pending) {
+		dev->ep0_in_pending = false;
+		pr_debug("ep0_in_pending <= false\n");
+	} else {
+		dev->ep0_out_pending = false;
+		pr_debug("ep0_out_pending <= false\n");
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	complete(&dev->ep0_done);
+}
+
+static int gadget_bind(struct usb_gadget *gadget,
+			struct usb_gadget_driver *driver)
+{
+	int ret = 0;
+	struct raw_dev *dev = container_of(driver, struct raw_dev, driver);
+	struct usb_request *req;
+	unsigned long flags;
+
+	pr_debug("matching %s vs %s\n", gadget->name, dev->udc_name);
+	if (strcmp(gadget->name, dev->udc_name) != 0)
+		return -ENODEV;
+
+	set_gadget_data(gadget, dev);
+	req = usb_ep_alloc_request(gadget->ep0, GFP_KERNEL);
+	if (!req) {
+		pr_err("usb_ep_alloc_request failed\n");
+		set_gadget_data(gadget, NULL);
+		return -ENOMEM;
+	}
+
+	spin_lock_irqsave(&dev->lock, flags);
+	dev->req = req;
+	dev->req->context = dev;
+	dev->req->complete = gadget_ep0_complete;
+	dev->gadget = gadget;
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	dev_get(dev); /* Matches dev_put() in gadget_unbind(). */
+	pr_debug("bound to %s gadget\n", gadget->name);
+
+	ret = raw_queue_event(dev, USB_RAW_EVENT_CONNECT, 0, NULL);
+	if (ret < 0)
+		pr_err("failed to queue event\n");
+	pr_debug("event queued\n");
+
+	return ret;
+}
+
+static void gadget_unbind(struct usb_gadget *gadget)
+{
+	struct raw_dev *dev = get_gadget_data(gadget);
+	unsigned long flags;
+
+	if (WARN_ON(!dev))
+		return;
+	spin_lock_irqsave(&dev->lock, flags);
+	set_gadget_data(gadget, NULL);
+	spin_unlock_irqrestore(&dev->lock, flags);
+	dev_put(dev); /* Matches dev_get() in gadget_bind(). */
+	pr_debug("unbound\n");
+}
+
+static int gadget_setup(struct usb_gadget *gadget,
+			const struct usb_ctrlrequest *ctrl)
+{
+	int ret = 0;
+	struct raw_dev *dev = get_gadget_data(gadget);
+	unsigned long flags;
+
+	pr_debug("bRequestType: 0x%x (%s), bRequest: 0x%x,\n"
+		"                   wValue: 0x%x, wIndex: 0x%x, wLength: %d\n",
+		ctrl->bRequestType,
+		(ctrl->bRequestType & USB_DIR_IN) ? "IN" : "OUT",
+		ctrl->bRequest, ctrl->wValue, ctrl->wIndex, ctrl->wLength);
+
+	if (WARN_ON(!dev))
+		return -ENODEV;
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_RUNNING) {
+		pr_err("ignoring, device is not running\n");
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+	pr_debug("in_pending: %d, out_pending: %d\n",
+			dev->ep0_in_pending, dev->ep0_out_pending);
+	if (dev->ep0_in_pending || dev->ep0_out_pending) {
+		pr_debug("stalling, already have pending request\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if ((ctrl->bRequestType & USB_DIR_IN) && ctrl->wLength) {
+		pr_debug("ep0_in_pending <= true\n");
+		dev->ep0_in_pending = true;
+	} else {
+		pr_debug("ep0_out_pending <= true\n");
+		dev->ep0_out_pending = true;
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	ret = raw_queue_event(dev, USB_RAW_EVENT_CONTROL, sizeof(*ctrl), ctrl);
+	if (ret < 0)
+		pr_err("failed to queue event\n");
+	pr_debug("event queued\n");
+	goto out;
+
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+out:
+	return ret;
+}
+
+static void gadget_disconnect(struct usb_gadget *gadget)
+{
+	pr_debug("ignoring\n");
+}
+
+static void gadget_suspend(struct usb_gadget *gadget)
+{
+	pr_debug("ignoring\n");
+}
+
+static void gadget_resume(struct usb_gadget *gadget)
+{
+	pr_debug("ignoring\n");
+}
+
+static void gadget_reset(struct usb_gadget *gadget)
+{
+	pr_debug("ignoring\n");
+}
+
+/*----------------------------------------------------------------------*/
+
+static int raw_open(struct inode *inode, struct file *fd)
+{
+	struct raw_dev *dev;
+
+	dev = dev_new();
+	if (!dev) {
+		pr_err("failed to created device");
+		return -ENOMEM;
+	}
+	fd->private_data = dev;
+	dev->state = STATE_DEV_OPENED;
+	pr_debug("device opened");
+	return 0;
+}
+
+static int raw_release(struct inode *inode, struct file *fd)
+{
+	int ret = 0;
+	struct raw_dev *dev = fd->private_data;
+	unsigned long flags;
+	bool unregister = false;
+
+	if (!dev)
+		return -EBUSY;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	dev->state = STATE_DEV_CLOSED;
+	pr_debug("device is closed\n");
+	if (!dev->gadget) {
+		spin_unlock_irqrestore(&dev->lock, flags);
+		goto out_put;
+	}
+	if (dev->gadget_registered)
+		unregister = true;
+	dev->gadget_registered = false;
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	if (unregister) {
+		ret = usb_gadget_unregister_driver(&dev->driver);
+		WARN_ON(ret != 0);
+		dev_put(dev); /* Matches dev_get() in raw_ioctl_run(). */
+	}
+
+out_put:
+	dev_put(dev); /* Matches dev_new() in raw_open(). */
+	pr_debug("device released");
+	return ret;
+}
+
+/*----------------------------------------------------------------------*/
+
+#define UDC_NAME_LENGTH_MAX 128
+
+static int raw_ioctl_init(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0;
+	struct usb_raw_init arg;
+	char *udc_driver_name;
+	char *udc_device_name;
+	unsigned long flags;
+
+	ret = copy_from_user(&arg, (void __user *)value, sizeof(arg));
+	if (ret)
+		return ret;
+
+	switch (arg.speed) {
+	case USB_SPEED_LOW:
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+		break;
+	default:
+		arg.speed = USB_SPEED_HIGH;
+	}
+
+	udc_driver_name = kmalloc(UDC_NAME_LENGTH_MAX, GFP_KERNEL);
+	if (!udc_driver_name)
+		return -ENOMEM;
+	ret = strncpy_from_user(udc_driver_name, arg.driver_name,
+					UDC_NAME_LENGTH_MAX);
+	if (ret < 0) {
+		kfree(udc_driver_name);
+		return ret;
+	}
+	ret = 0;
+	pr_debug("udc_driver_name: %s\n", udc_driver_name);
+
+	udc_device_name = kmalloc(UDC_NAME_LENGTH_MAX, GFP_KERNEL);
+	if (!udc_device_name) {
+		kfree(udc_driver_name);
+		return -ENOMEM;
+	}
+	ret = strncpy_from_user(udc_device_name, arg.device_name,
+					UDC_NAME_LENGTH_MAX);
+	if (ret < 0) {
+		kfree(udc_driver_name);
+		kfree(udc_device_name);
+		return ret;
+	}
+	ret = 0;
+	pr_debug("udc_device_name: %s\n", udc_device_name);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_OPENED) {
+		pr_debug("fail, device is not opened\n");
+		kfree(udc_driver_name);
+		kfree(udc_device_name);
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	dev->udc_name = udc_driver_name;
+
+	dev->driver.function = DRIVER_DESC;
+	dev->driver.max_speed = arg.speed;
+	dev->driver.setup = gadget_setup;
+	dev->driver.disconnect = gadget_disconnect;
+	dev->driver.bind = gadget_bind;
+	dev->driver.unbind = gadget_unbind;
+	dev->driver.suspend = gadget_suspend;
+	dev->driver.resume = gadget_resume;
+	dev->driver.reset = gadget_reset;
+	dev->driver.driver.name = DRIVER_NAME;
+	dev->driver.udc_name = udc_device_name;
+	dev->driver.match_existing_only = 1;
+
+	dev->state = STATE_DEV_INITIALIZED;
+	pr_debug("device is initialized\n");
+
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
+}
+
+static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	if (value)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_INITIALIZED) {
+		pr_debug("fail, device is not initialized\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	ret = usb_gadget_probe_driver(&dev->driver);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (ret) {
+		pr_err("fail, usb_gadget_probe_driver returned %d\n", ret);
+		dev->state = STATE_DEV_FAILED;
+		goto out_unlock;
+	}
+	dev->gadget_registered = true;
+	dev->state = STATE_DEV_RUNNING;
+	pr_debug("device is running\n");
+	dev_get(dev); /* Matches dev_put() in raw_release(). */
+
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
+}
+
+static int raw_ioctl_event_fetch(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0;
+	struct usb_raw_event arg;
+	unsigned long flags;
+	struct usb_raw_event *event;
+	uint32_t length;
+
+	ret = copy_from_user(&arg, (void __user *)value, sizeof(arg));
+	if (ret)
+		return ret;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_RUNNING) {
+		pr_debug("fail, device is not running\n");
+		spin_unlock_irqrestore(&dev->lock, flags);
+		return -EINVAL;
+	}
+	if (!dev->gadget) {
+		pr_debug("fail, gadget is not bound\n");
+		spin_unlock_irqrestore(&dev->lock, flags);
+		return -EBUSY;
+	}
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	event = raw_event_queue_fetch(&dev->queue);
+	if (!event) {
+		pr_debug("event fetching interrupted\n");
+		return -EINTR;
+	}
+	pr_debug("got event, length: %u\n", event->length);
+	length = min(arg.length, event->length);
+	ret = copy_to_user((void __user *)value, event,
+				sizeof(*event) + length);
+	return ret;
+}
+
+static void *raw_alloc_io_data(struct usb_raw_ep_io *io, void __user *ptr,
+				bool get_from_user)
+{
+	int ret;
+	void *data;
+
+	ret = copy_from_user(io, ptr, sizeof(*io));
+	if (ret)
+		return ERR_PTR(ret);
+	if (io->ep >= USB_RAW_MAX_ENDPOINTS)
+		return ERR_PTR(-EINVAL);
+	if (!usb_raw_io_flags_valid(io->flags))
+		return ERR_PTR(-EINVAL);
+	if (io->length > PAGE_SIZE)
+		return ERR_PTR(-EINVAL);
+	if (get_from_user)
+		data = memdup_user(ptr + sizeof(*io), io->length);
+	else {
+		data = kmalloc(io->length, GFP_KERNEL);
+		if (!data)
+			data = ERR_PTR(-ENOMEM);
+	}
+	return data;
+}
+
+static int raw_process_ep0_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
+				void *data, bool in)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_RUNNING) {
+		pr_debug("fail, device is not running\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (!dev->gadget) {
+		pr_debug("fail, gadget is not bound\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (dev->ep0_urb_queued) {
+		pr_debug("fail, urb already queued\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if ((in && !dev->ep0_in_pending) ||
+			(!in && !dev->ep0_out_pending)) {
+		pr_debug("fail, wrong direction\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (WARN_ON(in && dev->ep0_out_pending)) {
+		ret = -ENODEV;
+		dev->state = STATE_DEV_FAILED;
+		goto out_done;
+	}
+	if (WARN_ON(!in && dev->ep0_in_pending)) {
+		ret = -ENODEV;
+		dev->state = STATE_DEV_FAILED;
+		goto out_done;
+	}
+
+	dev->req->buf = data;
+	dev->req->length = io->length;
+	dev->req->zero = usb_raw_io_flags_zero(io->flags);
+	dev->ep0_urb_queued = true;
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	ret = usb_ep_queue(dev->gadget->ep0, dev->req, GFP_ATOMIC);
+	if (ret) {
+		pr_err("fail, usb_ep_queue returned %d\n", ret);
+		spin_lock_irqsave(&dev->lock, flags);
+		dev->state = STATE_DEV_FAILED;
+		goto out_done;
+	}
+	pr_debug("urb queued, length: %u\n", io->length);
+
+	ret = wait_for_completion_interruptible(&dev->ep0_done);
+	if (ret) {
+		pr_debug("wait interrupted\n");
+		usb_ep_dequeue(dev->gadget->ep0, dev->req);
+		wait_for_completion(&dev->ep0_done);
+		spin_lock_irqsave(&dev->lock, flags);
+		goto out_done;
+	}
+
+	spin_lock_irqsave(&dev->lock, flags);
+	ret = dev->ep0_status;
+	pr_debug("urb completed: status: %d\n", ret);
+
+out_done:
+	dev->ep0_urb_queued = false;
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
+}
+
+static int raw_ioctl_ep0_write(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0;
+	void *data;
+	struct usb_raw_ep_io io;
+
+	data = raw_alloc_io_data(&io, (void __user *)value, true);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+	ret = raw_process_ep0_io(dev, &io, data, true);
+	kfree(data);
+	return ret;
+}
+
+static int raw_ioctl_ep0_read(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0;
+	void *data;
+	struct usb_raw_ep_io io;
+	unsigned int length;
+
+	data = raw_alloc_io_data(&io, (void __user *)value, false);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+	ret = raw_process_ep0_io(dev, &io, data, false);
+	if (ret < 0) {
+		kfree(data);
+		return ret;
+	}
+	length = min(io.length, (unsigned int)ret);
+	ret = copy_to_user((void __user *)(value + sizeof(io)), data, length);
+	kfree(data);
+	return ret;
+}
+
+static bool check_ep_caps(struct usb_ep *ep,
+				struct usb_endpoint_descriptor *desc)
+{
+	switch (desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) {
+	case USB_ENDPOINT_XFER_ISOC:
+		if (!ep->caps.type_iso)
+			return false;
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		if (!ep->caps.type_bulk)
+			return false;
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		if (!ep->caps.type_int)
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	switch (desc->bEndpointAddress & USB_ENDPOINT_DIR_MASK) {
+	case USB_DIR_IN:
+		if (!ep->caps.dir_in)
+			return false;
+		break;
+	case USB_DIR_OUT:
+		if (!ep->caps.dir_out)
+			return false;
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static int raw_ioctl_ep_enable(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0, i;
+	unsigned long flags;
+	struct usb_endpoint_descriptor *desc;
+	struct usb_ep *ep = NULL;
+
+	desc = memdup_user((void __user *)value, sizeof(*desc));
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_RUNNING) {
+		pr_debug("fail, device is not running\n");
+		ret = -EINVAL;
+		goto out_free;
+	}
+	if (!dev->gadget) {
+		pr_debug("fail, gadget is not bound\n");
+		ret = -EBUSY;
+		goto out_free;
+	}
+
+	for (i = 0; i < USB_RAW_MAX_ENDPOINTS; i++) {
+		if (dev->eps[i].state == STATE_EP_ENABLED)
+			continue;
+		break;
+	}
+	if (i == USB_RAW_MAX_ENDPOINTS) {
+		pr_debug("fail, no device endpoints available\n");
+		ret = -EBUSY;
+		goto out_free;
+	}
+	pr_debug("found available device endpoint #%d\n", i);
+
+	gadget_for_each_ep(ep, dev->gadget) {
+		if (ep->enabled)
+			continue;
+		if (!check_ep_caps(ep, desc))
+			continue;
+		ep->desc = desc;
+		ret = usb_ep_enable(ep);
+		if (ret < 0) {
+			pr_err("fail, usb_ep_enable returned %d\n", ret);
+			goto out_free;
+		}
+		dev->eps[i].req = usb_ep_alloc_request(ep, GFP_ATOMIC);
+		if (!dev->eps[i].req) {
+			pr_err("fail, usb_ep_alloc_request failed\n");
+			usb_ep_disable(ep);
+			ret = -ENOMEM;
+			goto out_free;
+		}
+		dev->eps[i].ep = ep;
+		dev->eps[i].state = STATE_EP_ENABLED;
+		ep->driver_data = &dev->eps[i];
+		ret = i;
+		pr_debug("enabled endpoint #%d\n", i);
+		goto out_unlock;
+	}
+
+	pr_debug("fail, no gadget endpoints available\n");
+	ret = -EBUSY;
+
+out_free:
+	kfree(desc);
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
+}
+
+static int raw_ioctl_ep_disable(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0, i = value;
+	unsigned long flags;
+	const void *desc;
+
+	if (i < 0 || i >= USB_RAW_MAX_ENDPOINTS)
+		return -EINVAL;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_RUNNING) {
+		pr_debug("fail, device is not running\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (!dev->gadget) {
+		pr_debug("fail, gadget is not bound\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (dev->eps[i].state != STATE_EP_ENABLED) {
+		pr_debug("fail, endpoint is not enabled\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (dev->eps[i].disabling) {
+		pr_debug("disable already in progress\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	dev->eps[i].disabling = true;
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	usb_ep_disable(dev->eps[i].ep);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	usb_ep_free_request(dev->eps[i].ep, dev->eps[i].req);
+	desc = dev->eps[i].ep->desc;
+	dev->eps[i].ep = NULL;
+	dev->eps[i].state = STATE_EP_DISABLED;
+	kfree(desc);
+	dev->eps[i].disabling = false;
+	pr_debug("disabled endpoint #%d\n", i);
+
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
+}
+
+static void gadget_ep_complete(struct usb_ep *ep, struct usb_request *req)
+{
+	struct raw_ep *r_ep = (struct raw_ep *)ep->driver_data;
+	struct raw_dev *dev = r_ep->dev;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	pr_debug("length: %d, status: %d\n", req->actual, req->status);
+	if (req->status)
+		r_ep->status = req->status;
+	else
+		r_ep->status = req->actual;
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	complete((struct completion *)req->context);
+}
+
+static int raw_process_ep_io(struct raw_dev *dev, struct usb_raw_ep_io *io,
+				void *data, bool in)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct raw_ep *ep = &dev->eps[io->ep];
+	DECLARE_COMPLETION_ONSTACK(done);
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_RUNNING) {
+		pr_debug("fail, device is not running\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (!dev->gadget) {
+		pr_debug("fail, gadget is not bound\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (ep->state != STATE_EP_ENABLED) {
+		pr_debug("fail, endpoint is not enabled\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (ep->disabling) {
+		pr_debug("fail, endpoint is being disabled\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if (ep->urb_queued) {
+		pr_debug("fail, urb already queued\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	if ((in && !ep->ep->caps.dir_in) || (!in && ep->ep->caps.dir_in)) {
+		pr_debug("fail, wrong direction\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ep->dev = dev;
+	ep->req->context = &done;
+	ep->req->complete = gadget_ep_complete;
+	ep->req->buf = data;
+	ep->req->length = io->length;
+	ep->req->zero = usb_raw_io_flags_zero(io->flags);
+	ep->urb_queued = true;
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	ret = usb_ep_queue(ep->ep, ep->req, GFP_ATOMIC);
+	if (ret) {
+		pr_err("fail, usb_ep_queue returned %d\n", ret);
+		spin_lock_irqsave(&dev->lock, flags);
+		dev->state = STATE_DEV_FAILED;
+		goto out_done;
+	}
+	pr_debug("urb queued, length: %d\n", io->length);
+
+	ret = wait_for_completion_interruptible(&done);
+	if (ret) {
+		pr_debug("wait interrupted\n");
+		usb_ep_dequeue(ep->ep, ep->req);
+		wait_for_completion(&done);
+		spin_lock_irqsave(&dev->lock, flags);
+		goto out_done;
+	}
+
+	spin_lock_irqsave(&dev->lock, flags);
+	ret = ep->status;
+	pr_debug("urb completed: status: %d\n", ret);
+
+out_done:
+	ep->urb_queued = false;
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
+}
+
+static int raw_ioctl_ep_write(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0;
+	char *data;
+	struct usb_raw_ep_io io;
+
+	data = raw_alloc_io_data(&io, (void __user *)value, true);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+	ret = raw_process_ep_io(dev, &io, data, true);
+	kfree(data);
+	return ret;
+}
+
+static int raw_ioctl_ep_read(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0;
+	char *data;
+	struct usb_raw_ep_io io;
+	unsigned int length;
+
+	data = raw_alloc_io_data(&io, (void __user *)value, false);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+	ret = raw_process_ep_io(dev, &io, data, false);
+	if (ret < 0) {
+		kfree(data);
+		return ret;
+	}
+	length = min(io.length, (unsigned int)ret);
+	ret = copy_to_user((void __user *)(value + sizeof(io)), data, length);
+	kfree(data);
+	return ret;
+}
+
+static int raw_ioctl_configure(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	if (value)
+		return -EINVAL;
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_RUNNING) {
+		pr_debug("fail, device is not running\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (!dev->gadget) {
+		pr_debug("fail, gadget is not bound\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	usb_gadget_set_state(dev->gadget, USB_STATE_CONFIGURED);
+
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
+}
+
+static int raw_ioctl_vbus_draw(struct raw_dev *dev, unsigned long value)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->lock, flags);
+	if (dev->state != STATE_DEV_RUNNING) {
+		pr_debug("fail, device is not running\n");
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+	if (!dev->gadget) {
+		pr_debug("fail, gadget is not bound\n");
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+	usb_gadget_vbus_draw(dev->gadget, 2 * value);
+
+out_unlock:
+	spin_unlock_irqrestore(&dev->lock, flags);
+	return ret;
+}
+
+static long raw_ioctl(struct file *fd, unsigned int cmd, unsigned long value)
+{
+	struct raw_dev *dev = fd->private_data;
+	int ret = 0;
+
+	if (!dev)
+		return -EBUSY;
+
+	switch (cmd) {
+	case USB_RAW_IOCTL_INIT:
+		pr_debug("USB_RAW_IOCTL_INIT: %lx\n", value);
+		ret = raw_ioctl_init(dev, value);
+		pr_debug("USB_RAW_IOCTL_INIT = %d\n", ret);
+		break;
+	case USB_RAW_IOCTL_RUN:
+		pr_debug("USB_RAW_IOCTL_RUN: %lx\n", value);
+		ret = raw_ioctl_run(dev, value);
+		pr_debug("USB_RAW_IOCTL_RUN = %d\n", ret);
+		break;
+	case USB_RAW_IOCTL_EVENT_FETCH:
+		pr_debug("USB_RAW_IOCTL_EVENT_FETCH: %lx\n", value);
+		ret = raw_ioctl_event_fetch(dev, value);
+		pr_debug("USB_RAW_IOCTL_EVENT_FETCH = %d\n", ret);
+		break;
+	case USB_RAW_IOCTL_EP0_WRITE:
+		pr_debug("USB_RAW_IOCTL_EP0_WRITE: %lx\n", value);
+		ret = raw_ioctl_ep0_write(dev, value);
+		pr_debug("USB_RAW_IOCTL_EP0_WRITE = %d\n", ret);
+		break;
+	case USB_RAW_IOCTL_EP0_READ:
+		pr_debug("USB_RAW_IOCTL_EP0_READ: %lx\n", value);
+		ret = raw_ioctl_ep0_read(dev, value);
+		pr_debug("USB_RAW_IOCTL_EP0_READ = %d\n", ret);
+		break;
+	case USB_RAW_IOCTL_EP_ENABLE:
+		pr_debug("USB_RAW_IOCTL_EP_ENABLE: %lx\n", value);
+		ret = raw_ioctl_ep_enable(dev, value);
+		pr_debug("USB_RAW_IOCTL_EP_ENABLE = %d\n", ret);
+		break;
+	case USB_RAW_IOCTL_EP_DISABLE:
+		pr_debug("USB_RAW_IOCTL_EP_DISABLE: %lx\n", value);
+		ret = raw_ioctl_ep_disable(dev, value);
+		pr_debug("USB_RAW_IOCTL_EP_DISABLE = %d\n", ret);
+		break;
+	case USB_RAW_IOCTL_EP_WRITE:
+		pr_debug("USB_RAW_IOCTL_EP_WRITE: %lx\n", value);
+		ret = raw_ioctl_ep_write(dev, value);
+		pr_debug("USB_RAW_IOCTL_EP_WRITE = %d\n", ret);
+		break;
+	case USB_RAW_IOCTL_EP_READ:
+		pr_debug("USB_RAW_IOCTL_EP_READ: %lx\n", value);
+		ret = raw_ioctl_ep_read(dev, value);
+		pr_debug("USB_RAW_IOCTL_EP_READ = %d\n", ret);
+		break;
+	case USB_RAW_IOCTL_CONFIGURE:
+		pr_debug("USB_RAW_IOCTL_CONFIGURE: %lx\n", value);
+		ret = raw_ioctl_configure(dev, value);
+		pr_debug("USB_RAW_IOCTL_CONFIGURE = %d\n", ret);
+		break;
+	case USB_RAW_IOCTL_VBUS_DRAW:
+		pr_debug("USB_RAW_IOCTL_VBUS_DRAW: %lx\n", value);
+		ret = raw_ioctl_vbus_draw(dev, value);
+		pr_debug("USB_RAW_IOCTL_VBUS_DRAW = %d\n", ret);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/*----------------------------------------------------------------------*/
+
+static const struct file_operations raw_ops = {
+	.open =			raw_open,
+	.unlocked_ioctl =	raw_ioctl,
+	.release =		raw_release,
+	.llseek =		no_llseek,
+};
+
+static struct dentry *raw_file;
+
+static int __init raw_init(void)
+{
+	raw_file = debugfs_create_file("raw-gadget", 0600,
+			usb_debug_root, NULL, &raw_ops);
+	if (!raw_file) {
+		pr_err("failed to create raw-gadget in debugfs\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void __exit raw_exit(void)
+{
+	if (!raw_file)
+		return;
+	debugfs_remove(raw_file);
+	raw_file = NULL;
+}
+
+device_initcall(raw_init);
+module_exit(raw_exit);
diff --git a/include/uapi/linux/usb/raw_gadget.h b/include/uapi/linux/usb/raw_gadget.h
new file mode 100644
index 000000000000..40910b3e7b9a
--- /dev/null
+++ b/include/uapi/linux/usb/raw_gadget.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * USB Raw Gadget driver.
+ *
+ * See Documentation/usb/raw-gadget.rst for more details.
+ */
+
+#ifndef _UAPI__LINUX_USB_RAW_GADGET_H
+#define _UAPI__LINUX_USB_RAW_GADGET_H
+
+#include <asm/ioctl.h>
+#include <linux/types.h>
+#include <linux/usb/ch9.h>
+
+/*
+ * struct usb_raw_init - argument for USB_RAW_IOCTL_INIT ioctl.
+ * @speed: The speed of the emulated USB device, takes the same values as
+ *     the usb_device_speed enum: USB_SPEED_FULL, USB_SPEED_HIGH, etc.
+ * @driver_name: The name of the UDC driver.
+ * @device_name: The name of a UDC instance.
+ *
+ * The last two fields identify a UDC the gadget driver should bind to.
+ * For example, Dummy UDC has "dummy_udc" as its driver_name and "dummy_udc.N"
+ * as its device_name, where N in the index of the Dummy UDC instance.
+ * At the same time the dwc2 driver that is used on Raspberry Pi Zero, has
+ * "20980000.usb" as both driver_name and device_name.
+ */
+struct usb_raw_init {
+	uint64_t	speed;
+	const char	*driver_name;
+	const char	*device_name;
+};
+
+/* The type of event fetched with the USB_RAW_IOCTL_EVENT_FETCH ioctl. */
+enum usb_raw_event_type {
+	USB_RAW_EVENT_INVALID,
+
+	/* This event is queued when the driver has bound to a UDC. */
+	USB_RAW_EVENT_CONNECT,
+
+	/* This event is queued when a new control request arrived to ep0. */
+	USB_RAW_EVENT_CONTROL,
+
+	/* The list might grow in the future. */
+};
+
+/*
+ * struct usb_raw_event - argument for USB_RAW_IOCTL_EVENT_FETCH ioctl.
+ * @type: The type of the fetched event.
+ * @length: Length of the data buffer. Updated by the driver and set to the
+ *     actual length of the fetched event data.
+ * @data: A buffer to store the fetched event data.
+ *
+ * Currently the fetched data buffer is empty for USB_RAW_EVENT_CONNECT,
+ * and contains struct usb_ctrlrequest for USB_RAW_EVENT_CONTROL.
+ */
+struct usb_raw_event {
+	uint32_t	type;
+	uint32_t	length;
+	char		data[0];
+};
+
+#define USB_RAW_IO_FLAGS_ZERO	0x0001
+#define USB_RAW_IO_FLAGS_MASK	0x0001
+
+static int usb_raw_io_flags_valid(uint16_t flags)
+{
+	return (flags & ~USB_RAW_IO_FLAGS_MASK) == 0;
+}
+
+static int usb_raw_io_flags_zero(uint16_t flags)
+{
+	return (flags & USB_RAW_IO_FLAGS_ZERO);
+}
+
+/*
+ * struct usb_raw_ep_io - argument for USB_RAW_IOCTL_EP0/EP_WRITE/READ ioctls.
+ * @ep: Endpoint handle as returned by USB_RAW_IOCTL_EP_ENABLE for
+ *     USB_RAW_IOCTL_EP_WRITE/READ. Ignored for USB_RAW_IOCTL_EP0_WRITE/READ.
+ * @flags: When USB_RAW_IO_FLAGS_ZERO is specified, the zero flag is set on
+ *     the submitted USB request, see include/linux/usb/gadget.h for details.
+ * @length: Length of data.
+ * @data: Data to send for USB_RAW_IOCTL_EP0/EP_WRITE. Buffer to store received
+ *     data for USB_RAW_IOCTL_EP0/EP_READ.
+ */
+struct usb_raw_ep_io {
+	uint16_t	ep;
+	uint16_t	flags;
+	uint32_t	length;
+	char		data[0];
+};
+
+/*
+ * Initializes a Raw Gadget instance.
+ * Accepts a pointer to the usb_raw_init struct as an argument.
+ * Returns 0 on success or negative error code on failure.
+ */
+#define USB_RAW_IOCTL_INIT		_IOW('U', 0, struct usb_raw_init)
+
+/*
+ * Instructs Raw Gadget to bind to a UDC and start emulating a USB device.
+ * Returns 0 on success or negative error code on failure.
+ */
+#define USB_RAW_IOCTL_RUN		_IO('U', 1)
+
+/*
+ * A blocking ioctl that waits for an event and returns fetched event data to
+ * the user.
+ * Accepts a pointer to the usb_raw_event struct.
+ * Returns 0 on success or negative error code on failure.
+ */
+#define USB_RAW_IOCTL_EVENT_FETCH	_IOR('U', 2, struct usb_raw_event)
+
+/*
+ * Queues an IN (OUT for READ) urb as a response to the last control request
+ * received on endpoint 0, provided that was an IN (OUT for READ) request and
+ * waits until the urb is completed. Copies received data to user for READ.
+ * Accepts a pointer to the usb_raw_ep_io struct as an argument.
+ * Returns length of trasferred data on success or negative error code on
+ * failure.
+ */
+#define USB_RAW_IOCTL_EP0_WRITE		_IOW('U', 3, struct usb_raw_ep_io)
+#define USB_RAW_IOCTL_EP0_READ		_IOWR('U', 4, struct usb_raw_ep_io)
+
+/*
+ * Finds an endpoint that supports the transfer type specified in the
+ * descriptor and enables it.
+ * Accepts a pointer to the usb_endpoint_descriptor struct as an argument.
+ * Returns enabled endpoint handle on success or negative error code on failure.
+ */
+#define USB_RAW_IOCTL_EP_ENABLE		_IOW('U', 5, struct usb_endpoint_descriptor)
+
+/* Disables specified endpoint.
+ * Accepts endpoint handle as an argument.
+ * Returns 0 on success or negative error code on failure.
+ */
+#define USB_RAW_IOCTL_EP_DISABLE	_IOW('U', 6, int)
+
+/*
+ * Queues an IN (OUT for READ) urb as a response to the last control request
+ * received on endpoint usb_raw_ep_io.ep, provided that was an IN (OUT for READ)
+ * request and waits until the urb is completed. Copies received data to user
+ * for READ.
+ * Accepts a pointer to the usb_raw_ep_io struct as an argument.
+ * Returns length of trasferred data on success or negative error code on
+ * failure.
+ */
+#define USB_RAW_IOCTL_EP_WRITE		_IOW('U', 7, struct usb_raw_ep_io)
+#define USB_RAW_IOCTL_EP_READ		_IOWR('U', 8, struct usb_raw_ep_io)
+
+/*
+ * Switches the gadget into the configured state.
+ * Returns 0 on success or negative error code on failure.
+ */
+#define USB_RAW_IOCTL_CONFIGURE		_IO('U', 9)
+
+/*
+ * Constrains UDC VBUS power usage.
+ * Accepts current limit in 2 mA units as an argument.
+ * Returns 0 on success or negative error code on failure.
+ */
+#define USB_RAW_IOCTL_VBUS_DRAW		_IOW('U', 10, uint32_t)
+
+#endif /* _UAPI__LINUX_USB_RAW_GADGET_H */
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

