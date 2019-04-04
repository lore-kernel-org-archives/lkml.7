Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB51C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D947420820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 00:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cL7/byBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfDDAcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 20:32:12 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50504 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDDAcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 20:32:12 -0400
Received: by mail-it1-f194.google.com with SMTP id q14so989563itk.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 17:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BH9RopVgNqPSm5RRDTvrEZf/waLWlt54p9lPySKcTfs=;
        b=cL7/byBgtMAoQeSVzPKHghxauQAM0sdMCdVE2ihfn4Eh9riIo+l6q33Wn22CMZ/HVr
         Cen/BCUFk9MgFwSz4eer8cwmplxvwZQ1eu8mAf4Va8piJKJbQp6/QmYm96qymkeN2It0
         vyIAN0npybttdDebfkLSf3sKdoev+/GGT1xog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BH9RopVgNqPSm5RRDTvrEZf/waLWlt54p9lPySKcTfs=;
        b=PLWV7wWnraB445JiaNbbIEM1RDBnC+6puTd0dpSeMtPgZtrvjl+OTpHaPbQt+A3YEn
         6laWrfXVAtLGFGiRxOgXAbrRqKLkFZly0qHu8J1xoyebma9329WIszDaxMDPXiBzF3LX
         h9lOdlB/PIIeMBQZh3C+NM1fGfOHPdIcuUA2wt6wG1bjR5oFcU971Nx00Jkg2cJtH7KA
         ypn3c+yMwYn3RpjERFDSaTWNsNR2ksXx3VJy/jFmpldwZmr+vt8RJkxizWbQQTS5VtZw
         Zom6hJGPjyGWC0Q1AHnvsF/C/QAV1pvpy9XmCGANG0nhPJe5cx4CwijmCWp/4LIdVpR0
         aXNQ==
X-Gm-Message-State: APjAAAVA5EnLku+VO/pHLx9PlplLjgsBnBXWy50vo+sIWkhXyxdHPgu5
        nxIHhVxzkOyMz1lpusoC4FRzug==
X-Google-Smtp-Source: APXvYqzY0Wfr6o/mTNPnxjovyjArxWCMzOtYodeGZ24U+ltvWObPyBvdE+AXrew4R74dZWGw/npitA==
X-Received: by 2002:a02:3d04:: with SMTP id n4mr2724529jan.96.1554337930652;
        Wed, 03 Apr 2019 17:32:10 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:8140:8e3f:aea5:bcdf])
        by smtp.gmail.com with ESMTPSA id a8sm7385954iol.35.2019.04.03.17.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 03 Apr 2019 17:32:09 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        lamzin@google.com, bartfab@google.com, groeck@google.com,
        dtor@google.com, Nick Crews <ncrews@chromium.org>
Subject: [PATCH v3] platform/chrome: Add Wilco EC Event Handling
Date:   Wed,  3 Apr 2019 18:31:56 -0600
Message-Id: <20190404003156.205051-1-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Wilco Embedded Controller can create custom events that
are not handled as standard ACPI objects. These events can
contain information about changes in EC controlled features,
such as errors and events in the dock or display. For example,
an event is triggered if the dock is plugged into a display
incorrectly. These events are needed for telemetry and
diagnostics reasons, and for possibly alerting the user.

These events are triggered by the EC with an ACPI Notify(0x90),
and then the BIOS reads the event buffer from EC RAM via an
ACPI method. When the OS receives these events via ACPI,
it passes them along to this driver. The events are put into
a queue which can be read by a userspace daemon via a char device
that implements read() and poll(). The char device will appear at
/dev/wilco_event{n}, where n is some small non-negative integer,
starting from 0. Standard ACPI events such as the battery getting
plugged/unplugged can also come through this path, but they are
dealt with via other paths, and are ignored here.

To test, you can tail the binary data with
$ cat /dev/wilco_event0 | hexdump -ve '1/1 "%x\n"'
and then create an event by pressing fn+Esc.

v3 changes:
- Made commit description more accurate and useful.
- Added an exclusive lock for opening the char device,
  so only one userspace process can read events at a time.

Signed-off-by: Nick Crews <ncrews@chromium.org>
---
 drivers/platform/chrome/wilco_ec/Kconfig  |  10 +
 drivers/platform/chrome/wilco_ec/Makefile |   2 +
 drivers/platform/chrome/wilco_ec/event.c  | 522 ++++++++++++++++++++++
 3 files changed, 534 insertions(+)
 create mode 100644 drivers/platform/chrome/wilco_ec/event.c

diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
index e09e4cebe9b4..023fdbf79be6 100644
--- a/drivers/platform/chrome/wilco_ec/Kconfig
+++ b/drivers/platform/chrome/wilco_ec/Kconfig
@@ -18,3 +18,13 @@ config WILCO_EC_DEBUGFS
 	  manipulation and allow for testing arbitrary commands.  This
 	  interface is intended for debug only and will not be present
 	  on production devices.
+
+config WILCO_EC_EVENTS
+	tristate "Enable event forwarding from EC to userspace"
+	depends on WILCO_EC
+	help
+	  If you say Y here, you get support for the EC to send events
+	  (such as power state changes) to userspace. The EC sends the events
+	  over ACPI, and a driver queues up the events to be read by a
+	  userspace daemon from /dev/wilco_eventN (where N is some small
+	  positive integer) using read() and poll().
diff --git a/drivers/platform/chrome/wilco_ec/Makefile b/drivers/platform/chrome/wilco_ec/Makefile
index 063e7fb4ea17..37452ab953de 100644
--- a/drivers/platform/chrome/wilco_ec/Makefile
+++ b/drivers/platform/chrome/wilco_ec/Makefile
@@ -4,3 +4,5 @@ wilco_ec-objs				:= core.o mailbox.o
 obj-$(CONFIG_WILCO_EC)			+= wilco_ec.o
 wilco_ec_debugfs-objs			:= debugfs.o
 obj-$(CONFIG_WILCO_EC_DEBUGFS)		+= wilco_ec_debugfs.o
+wilco_ec_events-objs			:= event.o
+obj-$(CONFIG_WILCO_EC_EVENTS)		+= wilco_ec_events.o
diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
new file mode 100644
index 000000000000..dd4e43ce1d30
--- /dev/null
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -0,0 +1,522 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Event handling for Wilco Embedded Controller
+ *
+ * Copyright 2019 Google LLC
+ *
+ * The Wilco Embedded Controller can create custom events that
+ * are not handled as standard ACPI objects. These events can
+ * contain information about changes in EC controlled features,
+ * such as errors and events in the dock or display. For example,
+ * an event is triggered if the dock is plugged into a display
+ * incorrectly. These events are needed for telemetry and
+ * diagnostics reasons, and for possibly alerting the user.
+ *
+ * These events are triggered by the EC with an ACPI Notify(0x90),
+ * and then the BIOS reads the event buffer from EC RAM via an
+ * ACPI method. When the OS receives these events via ACPI,
+ * it passes them along to this driver. The events are put into
+ * a queue which can be read by a userspace daemon via a char device
+ * that implements read() and poll(). The char device will appear at
+ * /dev/wilco_event{n}, where n is some small non-negative integer,
+ * starting from 0. Standard ACPI events such as the battery getting
+ * plugged/unplugged can also come through this path, but they are
+ * dealt with via other paths, and are ignored here.
+ *
+ * To test, you can tail the binary data with
+ * $ cat /dev/wilco_event0 | hexdump -ve '1/1 "%x\n"'
+ * and then create an event by pressing fn+Esc.
+ */
+
+#include <linux/acpi.h>
+#include <linux/cdev.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/idr.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/uaccess.h>
+#include <linux/wait.h>
+
+/* ACPI Notify event code indicating event data is available. */
+#define EC_ACPI_NOTIFY_EVENT		0x90
+/* ACPI Method to execute to retrieve event data buffer from the EC. */
+#define EC_ACPI_GET_EVENT		"QSET"
+/* Maximum number of words in event data returned by the EC. */
+#define EC_ACPI_MAX_EVENT_DATA		6
+#define EC_ACPI_MAX_EVENT_SIZE \
+	(sizeof(struct ec_event) + (EC_ACPI_MAX_EVENT_DATA) * sizeof(u16))
+
+/* Node will appear in /dev/EVENT_DEV_NAME */
+#define EVENT_DEV_NAME		"wilco_event"
+#define EVENT_CLASS_NAME	EVENT_DEV_NAME
+#define DRV_NAME		EVENT_DEV_NAME
+#define EVENT_DEV_NAME_FMT	(EVENT_DEV_NAME "%d")
+static struct class event_class = {
+	.owner	= THIS_MODULE,
+	.name	= EVENT_CLASS_NAME,
+};
+
+/* Keep track of all the device numbers used. */
+#define EVENT_MAX_DEV 128
+static int event_major;
+static DEFINE_IDA(event_ida);
+
+/**
+ * struct event_device_data - Data for a Wilco EC device that responds to ACPI.
+ * @events: Queue of EC events to be provided to userspace.
+ * @lock: Mutex to guard the queue.
+ * @wq: Wait queue to notify processes when events or available or the
+ *	device has been removed.
+ * @cdev: Char dev that userspace reads() and polls() from.
+ * @dev: Device associated with the %cdev.
+ * @exist: Has the device been not been removed? Once a device has been removed,
+ *	   writes, reads, and new opens will fail.
+ * @available: Guarantee only one client can open() file and read from queue.
+ *
+ * There will be one of these structs for each ACPI device registered. This data
+ * is the queue of events received from ACPI that still need to be read from
+ * userspace (plus a supporting lock and wait queue), as well as the device and
+ * char device that userspace is using, plus a flag on whether the ACPI device
+ * has been removed.
+ */
+struct event_device_data {
+	struct list_head events;
+	struct mutex lock;
+	wait_queue_head_t wq;
+	struct device dev;
+	struct cdev cdev;
+	bool exist;
+	atomic_t available;
+};
+
+/**
+ * struct ec_event - Extended event returned by the EC.
+ * @size: Number of words in structure after the size word.
+ * @type: Extended event type from &enum ec_event_type.
+ * @event: Event data words.  Max count is %EC_ACPI_MAX_EVENT_DATA.
+ */
+struct ec_event {
+	u16 size;
+	u16 type;
+	u16 event[0];
+} __packed;
+
+/**
+ * struct ec_event_entry - Event queue entry.
+ * @list: List node.
+ * @size: Number of bytes in event structure.
+ * @event: Extended event returned by the EC.  This should be the last
+ *         element because &struct ec_event includes a zero length array.
+ */
+struct ec_event_entry {
+	struct list_head list;
+	size_t size;
+	struct ec_event event;
+};
+
+/**
+ * enqueue_events() - Place EC events in queue to be read by userspace.
+ * @adev: Device the events came from.
+ * @buf: Buffer of event data.
+ * @length: Length of event data buffer.
+ *
+ * %buf contains a number of ec_event's, packed one after the other.
+ * Each ec_event is of variable length. Start with the first event, copy it
+ * into a containing ev_event_entry, store that entry in a list, move on
+ * to the next ec_event in buf, and repeat.
+ *
+ * Return: 0 on success or negative error code on failure.
+ */
+static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
+{
+	struct event_device_data *dev_data = adev->driver_data;
+	struct ec_event *event;
+	struct ec_event_entry *entry;
+	size_t event_size, num_words, word_size;
+	u32 offset = 0;
+
+	while (offset < length) {
+		event = (struct ec_event *)(buf + offset);
+		if (!event)
+			return -EINVAL;
+
+		/* Number of 16bit event data words is size - 1 */
+		num_words = event->size - 1;
+		word_size = num_words * sizeof(u16);
+		event_size = sizeof(*event) + word_size;
+		if (num_words > EC_ACPI_MAX_EVENT_DATA) {
+			dev_err(&adev->dev, "Too many event words: %zu > %d\n",
+				num_words, EC_ACPI_MAX_EVENT_DATA);
+			return -EOVERFLOW;
+		};
+
+		/* Ensure event does not overflow the available buffer */
+		if ((offset + event_size) > length) {
+			dev_err(&adev->dev, "Event exceeds buffer: %zu > %d\n",
+				offset + event_size, length);
+			return -EOVERFLOW;
+		}
+
+		/* Point to the next event in the buffer */
+		offset += event_size;
+
+		/* Create event entry for the queue */
+		entry = kzalloc(sizeof(struct ec_event_entry) + word_size,
+				GFP_KERNEL);
+		if (!entry)
+			return -ENOMEM;
+		entry->size = event_size;
+		memcpy(&entry->event, event, entry->size);
+
+		/* Add this event to the queue */
+		mutex_lock(&dev_data->lock);
+		list_add_tail(&entry->list, &dev_data->events);
+		mutex_unlock(&dev_data->lock);
+	}
+
+	return 0;
+}
+
+/**
+ * event_device_notify() - Callback when EC generates an event over ACPI.
+ * @adev: The device that the event is coming from.
+ * @value: Value passed to Notify() in ACPI.
+ *
+ * This function will read the events from the device and enqueue them.
+ */
+static void event_device_notify(struct acpi_device *adev, u32 value)
+{
+	struct acpi_buffer event_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct event_device_data *dev_data = adev->driver_data;
+	union acpi_object *obj;
+	acpi_status status;
+
+	if (value != EC_ACPI_NOTIFY_EVENT) {
+		dev_err(&adev->dev, "Invalid event: 0x%08x\n", value);
+		return;
+	}
+
+	/* Execute ACPI method to get event data buffer. */
+	status = acpi_evaluate_object(adev->handle, EC_ACPI_GET_EVENT,
+				      NULL, &event_buffer);
+	if (ACPI_FAILURE(status)) {
+		dev_err(&adev->dev, "Error executing ACPI method %s()\n",
+			EC_ACPI_GET_EVENT);
+		return;
+	}
+
+	obj = (union acpi_object *)event_buffer.pointer;
+	if (!obj) {
+		dev_err(&adev->dev, "Nothing returned from %s()\n",
+			EC_ACPI_GET_EVENT);
+		return;
+	}
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		dev_err(&adev->dev, "Invalid object returned from %s()\n",
+			EC_ACPI_GET_EVENT);
+		kfree(obj);
+		return;
+	}
+	if (obj->buffer.length < sizeof(struct ec_event)) {
+		dev_err(&adev->dev, "Invalid buffer length %d from %s()\n",
+			obj->buffer.length, EC_ACPI_GET_EVENT);
+		kfree(obj);
+		return;
+	}
+
+	enqueue_events(adev, obj->buffer.pointer, obj->buffer.length);
+	kfree(obj);
+
+	if (!list_empty(&dev_data->events))
+		wake_up_interruptible(&dev_data->wq);
+}
+
+static int event_open(struct inode *inode, struct file *filp)
+{
+	struct event_device_data *dev_data;
+
+	dev_data = container_of(inode->i_cdev, struct event_device_data, cdev);
+	if (!dev_data->exist)
+		return -ENODEV;
+
+	if (atomic_cmpxchg(&dev_data->available, 1, 0) == 0)
+		return -EBUSY;
+
+	/* Increase refcount on device so dev_data is not freed */
+	get_device(&dev_data->dev);
+	nonseekable_open(inode, filp);
+	filp->private_data = dev_data;
+
+	return 0;
+}
+
+static __poll_t event_poll(struct file *filp, poll_table *wait)
+{
+	struct event_device_data *dev_data = filp->private_data;
+	__poll_t mask = 0;
+
+	poll_wait(filp, &dev_data->wq, wait);
+	if (!dev_data->exist)
+		return EPOLLHUP;
+	if (!list_empty(&dev_data->events))
+		mask |= EPOLLIN | EPOLLRDNORM | EPOLLPRI;
+	return mask;
+}
+
+/**
+ * event_read() - Callback for passing event data to userspace via read().
+ * @filp: The file we are reading from.
+ * @buf: Pointer to userspace buffer to fill with one event.
+ * @count: Number of bytes requested. Must be at least EC_ACPI_MAX_EVENT_SIZE.
+ * @pos: File position pointer, irrelevant since we don't support seeking.
+ *
+ * Fills the passed buffer with the data from the first event in the queue,
+ * removes that event from the queue. On error, the event remains in the queue.
+ *
+ * If there are no events in the the queue, then one of two things happens,
+ * depending on if the file was opened in nonblocking mode: If in nonblocking
+ * mode, then return -EAGAIN to say there's no data. If in blocking mode, then
+ * block until an event is available.
+ *
+ * Return: Number of bytes placed in buffer, negative error code on failure.
+ */
+static ssize_t event_read(struct file *filp, char __user *buf, size_t count,
+			  loff_t *pos)
+{
+	struct event_device_data *dev_data = filp->private_data;
+	struct ec_event_entry *entry;
+	ssize_t n_bytes_written = 0;
+	int err;
+
+	/* We only will give them the entire event at once */
+	if (count != 0 && count < EC_ACPI_MAX_EVENT_SIZE)
+		return -EINVAL;
+
+	mutex_lock(&dev_data->lock);
+
+	while (list_empty(&dev_data->events)) {
+		if (filp->f_flags & O_NONBLOCK) {
+			mutex_unlock(&dev_data->lock);
+			return -EAGAIN;
+		}
+		/* Need to unlock so that data can actually get added to the
+		 * queue, and since we recheck before use and it's just
+		 * comparing pointers, this is safe unlocked.
+		 */
+		mutex_unlock(&dev_data->lock);
+		err = wait_event_interruptible(dev_data->wq,
+					       !list_empty(&dev_data->events));
+		if (err)
+			return err;
+
+		/* Device was removed as we waited? */
+		if (!dev_data->exist)
+			return -ENODEV;
+		mutex_lock(&dev_data->lock);
+	}
+
+	entry = list_first_entry(&dev_data->events,
+				 struct ec_event_entry, list);
+	n_bytes_written = entry->size;
+	if (copy_to_user(buf, &entry->event, n_bytes_written))
+		return -EFAULT;
+	list_del(&entry->list);
+	kfree(entry);
+
+	mutex_unlock(&dev_data->lock);
+
+	return n_bytes_written;
+}
+
+static int event_release(struct inode *inode, struct file *filp)
+{
+	struct event_device_data *dev_data = filp->private_data;
+
+	atomic_set(&dev_data->available, 1);
+	put_device(&dev_data->dev);
+
+	return 0;
+}
+
+static const struct file_operations event_fops = {
+	.open = event_open,
+	.poll  = event_poll,
+	.read = event_read,
+	.release = event_release,
+	.llseek = no_llseek,
+	.owner = THIS_MODULE,
+};
+
+/**
+ * free_device_data() - Callback to free the event_device_data structure.
+ * @d: The device embedded in our device data, which we have been ref counting.
+ *
+ * This is called only after event_device_remove() has been called and all
+ * userspace programs have called event_release() on all the open file
+ * descriptors.
+ */
+static void free_device_data(struct device *d)
+{
+	struct event_device_data *dev_data;
+
+	dev_data = container_of(d, struct event_device_data, dev);
+	kfree(dev_data);
+}
+
+static void hangup_device(struct event_device_data *dev_data)
+{
+	mutex_lock(&dev_data->lock);
+	dev_data->exist = false;
+	mutex_unlock(&dev_data->lock);
+
+	/* Wake up the waiting processes so they can close. */
+	wake_up_interruptible(&dev_data->wq);
+	put_device(&dev_data->dev);
+}
+
+/**
+ * event_device_add() - Callback when creating a new device.
+ * @adev: ACPI device that we will be receiving events from.
+ *
+ * This finds a free minor number for the device, allocates and initializes
+ * some device data, and creates a new device and char dev node.
+ *
+ * The device data is freed in free_device_data(), which is called when
+ * %dev_data->dev is release()ed. This happens after all references to
+ * %dev_data->dev are dropped, which happens once both event_device_remove()
+ * has been called and every open()ed file descriptor has been release()ed.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int event_device_add(struct acpi_device *adev)
+{
+	struct event_device_data *dev_data;
+	dev_t dev_num;
+	int error, minor;
+
+	minor = ida_alloc_max(&event_ida, EVENT_MAX_DEV-1, GFP_KERNEL);
+	if (minor < 0) {
+		error = minor;
+		dev_err(&adev->dev, "Failed to find minor number: %d", error);
+		return error;
+	}
+
+	dev_data = kzalloc(sizeof(*dev_data), GFP_KERNEL);
+	if (!dev_data) {
+		error = -ENOMEM;
+		goto free_minor;
+	}
+
+	/* Initialize the device data. */
+	adev->driver_data = dev_data;
+	INIT_LIST_HEAD(&dev_data->events);
+	mutex_init(&dev_data->lock);
+	init_waitqueue_head(&dev_data->wq);
+	dev_data->exist = true;
+	atomic_set(&dev_data->available, 1);
+
+	/* Initialize the device. */
+	dev_num = MKDEV(event_major, minor);
+	dev_data->dev.devt = dev_num;
+	dev_data->dev.class = &event_class;
+	dev_data->dev.release = free_device_data;
+	dev_set_name(&dev_data->dev, EVENT_DEV_NAME_FMT, minor);
+	device_initialize(&dev_data->dev);
+
+	/* Initialize the character device, and add it to userspace. */
+	cdev_init(&dev_data->cdev, &event_fops);
+	error = cdev_device_add(&dev_data->cdev, &dev_data->dev);
+	if (error)
+		goto free_dev_data;
+
+	return 0;
+
+free_dev_data:
+	hangup_device(dev_data);
+free_minor:
+	ida_simple_remove(&event_ida, minor);
+	return error;
+}
+
+static int event_device_remove(struct acpi_device *adev)
+{
+	struct event_device_data *dev_data = adev->driver_data;
+
+	cdev_device_del(&dev_data->cdev, &dev_data->dev);
+	ida_simple_remove(&event_ida, MINOR(dev_data->dev.devt));
+	hangup_device(dev_data);
+
+	return 0;
+}
+
+static const struct acpi_device_id event_acpi_ids[] = {
+	{ "GOOG000D", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, event_acpi_ids);
+
+static struct acpi_driver event_driver = {
+	.name = DRV_NAME,
+	.class = DRV_NAME,
+	.ids = event_acpi_ids,
+	.ops = {
+		.add = event_device_add,
+		.notify = event_device_notify,
+		.remove = event_device_remove,
+	},
+	.owner = THIS_MODULE,
+};
+
+static int __init event_module_init(void)
+{
+	dev_t dev_num = 0;
+	int ret;
+
+	ret = class_register(&event_class);
+	if (ret) {
+		pr_warn(DRV_NAME ": Failed registering class: %d", ret);
+		return ret;
+	}
+
+	/* Request device numbers, starting with minor=0. Save the major num. */
+	ret = alloc_chrdev_region(&dev_num, 0, EVENT_MAX_DEV, EVENT_DEV_NAME);
+	if (ret) {
+		pr_warn(DRV_NAME ": Failed allocating dev numbers: %d", ret);
+		goto destroy_class;
+	}
+	event_major = MAJOR(dev_num);
+
+	ret = acpi_bus_register_driver(&event_driver);
+	if (ret < 0) {
+		pr_warn(DRV_NAME ": Failed registering driver: %d\n", ret);
+		goto unregister_region;
+	}
+
+	return 0;
+
+unregister_region:
+	unregister_chrdev_region(MKDEV(event_major, 0), EVENT_MAX_DEV);
+destroy_class:
+	class_unregister(&event_class);
+	ida_destroy(&event_ida);
+	return ret;
+}
+
+static void __exit event_module_exit(void)
+{
+	acpi_bus_unregister_driver(&event_driver);
+	unregister_chrdev_region(MKDEV(event_major, 0), EVENT_MAX_DEV);
+	class_unregister(&event_class);
+	ida_destroy(&event_ida);
+}
+
+module_init(event_module_init);
+module_exit(event_module_exit);
+
+MODULE_AUTHOR("Nick Crews <ncrews@chromium.org>");
+MODULE_DESCRIPTION("Wilco EC ACPI event driver");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.20.1

