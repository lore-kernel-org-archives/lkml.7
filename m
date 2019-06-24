Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFDDC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4D420665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BpeumnrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfFXTBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:01:45 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41935 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbfFXTBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:01:45 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so3965251ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 12:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9QYQJbPB20T8ldPJw4hNlMgF/ArMfB62eToo7KOREs=;
        b=BpeumnrRYxIRPF0f6R1voIp/MXhcSUegthp2EFvbP2Igzxks4Xx64hiB7J2S9VN0TW
         gygl41rcUJN9l2PUmw6KbCJav+HlmFbWMqv8tFpL+80nqz1bpHCyCn16UdStSEeKjxx3
         7B+XG2d7W6islAv4fWVMI0Nub3qIE4gfTOgyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9QYQJbPB20T8ldPJw4hNlMgF/ArMfB62eToo7KOREs=;
        b=hxJ8++25PcOjDilA0ovzhHrJR80uYxyfJRewiCUVx6LD8fKH/0F0sv4ZdPr40Ncu9z
         5MUZ/Z29eahxlzq9tl9OteGyRAomQMXCLFGhuhZ6+hdUy2p4DcEMlf6F5AceV0AXTHhW
         zhB/vYtgae9uedm04QSwlpUFavvRNDylIhcQh5LlJD4lgu/8pqUsxWBKp7c726q8IfwR
         IrVjCDUZewzyEzGcNWPUFUGGtoDyeWR6FTVZgg8PFLXRZfY1cKoYPeJ2EpzHEjfZImNN
         xojEVzx83yVKa70/bz5jdLJ9vnLxFLBcGOF09ZxgaKS/GiNtzkAn8v8i4IB/fFeDdHlU
         eCsA==
X-Gm-Message-State: APjAAAXIIZ8fXLp4BMenn2u1dkEHfOR1nugUwOAcvDoZIwVRg+loAkeB
        /q1L2D/ortnBFyxeUoswSKSFLg==
X-Google-Smtp-Source: APXvYqyuY/gXIa7/aa+3VhGU9df99vVGLJpEBpaSiV6RD1QI5GDVu4dG6Sld9nqX6jZh9hfhMi9gMA==
X-Received: by 2002:a6b:3102:: with SMTP id j2mr3661974ioa.5.1561402904081;
        Mon, 24 Jun 2019 12:01:44 -0700 (PDT)
Received: from ncrews2.bld.corp.google.com ([2620:15c:183:200:cb43:2cd4:65f5:5c84])
        by smtp.gmail.com with ESMTPSA id n17sm12577120iog.63.2019.06.24.12.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jun 2019 12:01:43 -0700 (PDT)
From:   Nick Crews <ncrews@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        djkurtz@chromium.org, dtor@google.com, sjg@chromium.org,
        yuehaibing@huawei.com, colin.king@canonical.com,
        dan.carpenter@oracle.com, Nick Crews <ncrews@chromium.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] platform/chrome: wilco_ec: Add circular buffer as event queue
Date:   Mon, 24 Jun 2019 13:00:42 -0600
Message-Id: <20190624190040.132120-2-ncrews@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624190040.132120-1-ncrews@chromium.org>
References: <20190624190040.132120-1-ncrews@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation of the event queue both
wastes space using a doubly linked list and isn't super
obvious in how it behaves. This converts the queue to an
actual circular buffer. The size of the queue is a
tunable module parameter. This also fixes a few other things:

- A memory leak that occurred when the ACPI device was
  removed, but the events were not freed from the queue.
- Now kfree() the oldest event from outside all locks.
- Add newline to logging messages.
- Add helper macros to calculate size of events.
- Remove unneeded lock around a check for dev_data->exist
  in hangup_device().
- Remove an unneeded null event pointer check in enqueue_events().
- Correct some comments.

Signed-off-by: Nick Crews <ncrews@chromium.org>
Reported-by: kbuild test robot <lkp@intel.com>
---

A v1 of this was applied to the chrome-platform-5.3 branch, but then
several errors were found, so Enric and Benson reverted the two commits.

v2 changes:
- Check if kmalloc() of queue fails (Colin Ian King)
- Use struct_size() macro when allocating the queue (Dan Carpenter)
- Remove unneeded semicolon after "if" in enqueue_events() (kbuild bot)
- Change nonseekable_open() to stream_open() (kbuild bot)
- Use kmemdup() for copying events to queue (YueHaibing)
- Wake up threads in enqueue_events() after every event, not
  event_device_notify(), so listeners are guaranteed to be woken
  (Dmitry Torokhov and Daniel Kurtz)
- Move lock back outside the queue, remove "full" boolean,
  streamline pop() and push(), fix race condition where an queue
  of size 1 could get doubly popped, move kfree() of oldest event
  to outside the lock (Daniel Kurtz)

 drivers/platform/chrome/wilco_ec/event.c | 258 +++++++++++++----------
 1 file changed, 149 insertions(+), 109 deletions(-)

diff --git a/drivers/platform/chrome/wilco_ec/event.c b/drivers/platform/chrome/wilco_ec/event.c
index 1eed55681598..dba3d445623f 100644
--- a/drivers/platform/chrome/wilco_ec/event.c
+++ b/drivers/platform/chrome/wilco_ec/event.c
@@ -39,6 +39,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/poll.h>
+#include <linux/spinlock.h>
 #include <linux/uaccess.h>
 #include <linux/wait.h>
 
@@ -69,12 +70,110 @@ static DEFINE_IDA(event_ida);
 /* Size of circular queue of events. */
 #define MAX_NUM_EVENTS 64
 
+/**
+ * struct ec_event - Extended event returned by the EC.
+ * @size: Number of 16bit words in structure after the size word.
+ * @type: Extended event type, meaningless for us.
+ * @event: Event data words.  Max count is %EC_ACPI_MAX_EVENT_WORDS.
+ */
+struct ec_event {
+	u16 size;
+	u16 type;
+	u16 event[0];
+} __packed;
+
+#define ec_event_num_words(ev) (ev->size - 1)
+#define ec_event_size(ev) (sizeof(*ev) + (ec_event_num_words(ev) * sizeof(u16)))
+
+/**
+ * struct ec_event_queue - Circular queue for events.
+ * @capacity: Number of elements the queue can hold.
+ * @head: Next index to write to.
+ * @tail: Next index to read from.
+ * @entries: Array of events.
+ */
+struct ec_event_queue {
+	int capacity;
+	int head;
+	int tail;
+	struct ec_event *entries[0];
+};
+
+/* Maximum number of events to store in ec_event_queue */
+static int queue_size = 64;
+module_param(queue_size, int, 0644);
+
+static struct ec_event_queue *event_queue_new(int capacity)
+{
+	struct ec_event_queue *q;
+
+	q = kzalloc(struct_size(q, entries, capacity), GFP_KERNEL);
+	if (!q)
+		return NULL;
+
+	q->capacity = capacity;
+
+	return q;
+}
+
+static inline bool event_queue_empty(struct ec_event_queue *q)
+{
+	/* head==tail when both full and empty, but head==NULL when empty */
+	return q->head == q->tail && !q->entries[q->head];
+}
+
+static inline bool event_queue_full(struct ec_event_queue *q)
+{
+	/* head==tail when both full and empty, but head!=NULL when full */
+	return q->head == q->tail && q->entries[q->head];
+}
+
+static struct ec_event *event_queue_pop(struct ec_event_queue *q)
+{
+	struct ec_event *ev;
+
+	if (event_queue_empty(q))
+		return NULL;
+
+	ev = q->entries[q->tail];
+	q->entries[q->tail] = NULL;
+	q->tail = (q->tail + 1) % q->capacity;
+
+	return ev;
+}
+
+/*
+ * If full, overwrite the oldest event and return it so the caller
+ * can kfree it. If not full, return NULL.
+ */
+static struct ec_event *event_queue_push(struct ec_event_queue *q,
+					 struct ec_event *ev)
+{
+	struct ec_event *popped = NULL;
+
+	if (event_queue_full(q))
+		popped = event_queue_pop(q);
+	q->entries[q->head] = ev;
+	q->head = (q->head + 1) % q->capacity;
+
+	return popped;
+}
+
+static void event_queue_free(struct ec_event_queue *q)
+{
+	struct ec_event *event;
+
+	while ((event = event_queue_pop(q)) != NULL)
+		kfree(event);
+
+	kfree(q);
+}
+
 /**
  * struct event_device_data - Data for a Wilco EC device that responds to ACPI.
  * @events: Circular queue of EC events to be provided to userspace.
- * @num_events: Number of events in the queue.
- * @lock: Mutex to guard the queue.
- * @wq: Wait queue to notify processes when events or available or the
+ * @queue_lock: Protect the queue from simultaneous read/writes.
+ * @wq: Wait queue to notify processes when events are available or the
  *	device has been removed.
  * @cdev: Char dev that userspace reads() and polls() from.
  * @dev: Device associated with the %cdev.
@@ -84,14 +183,13 @@ static DEFINE_IDA(event_ida);
  *
  * There will be one of these structs for each ACPI device registered. This data
  * is the queue of events received from ACPI that still need to be read from
- * userspace (plus a supporting lock and wait queue), as well as the device and
- * char device that userspace is using, plus a flag on whether the ACPI device
- * has been removed.
+ * userspace, the device and char device that userspace is using, a wait queue
+ * used to notify different threads when something has changed, plus a flag
+ * on whether the ACPI device has been removed.
  */
 struct event_device_data {
-	struct list_head events;
-	size_t num_events;
-	struct mutex lock;
+	struct ec_event_queue *events;
+	spinlock_t queue_lock;
 	wait_queue_head_t wq;
 	struct device dev;
 	struct cdev cdev;
@@ -99,31 +197,6 @@ struct event_device_data {
 	atomic_t available;
 };
 
-/**
- * struct ec_event - Extended event returned by the EC.
- * @size: Number of words in structure after the size word.
- * @type: Extended event type from &enum ec_event_type.
- * @event: Event data words.  Max count is %EC_ACPI_MAX_EVENT_WORDS.
- */
-struct ec_event {
-	u16 size;
-	u16 type;
-	u16 event[0];
-} __packed;
-
-/**
- * struct ec_event_entry - Event queue entry.
- * @list: List node.
- * @size: Number of bytes in event structure.
- * @event: Extended event returned by the EC.  This should be the last
- *         element because &struct ec_event includes a zero length array.
- */
-struct ec_event_entry {
-	struct list_head list;
-	size_t size;
-	struct ec_event event;
-};
-
 /**
  * enqueue_events() - Place EC events in queue to be read by userspace.
  * @adev: Device the events came from.
@@ -132,7 +205,7 @@ struct ec_event_entry {
  *
  * %buf contains a number of ec_event's, packed one after the other.
  * Each ec_event is of variable length. Start with the first event, copy it
- * into a containing ev_event_entry, store that entry in a list, move on
+ * into a persistent ec_event, store that entry in the queue, move on
  * to the next ec_event in buf, and repeat.
  *
  * Return: 0 on success or negative error code on failure.
@@ -140,25 +213,20 @@ struct ec_event_entry {
 static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
 {
 	struct event_device_data *dev_data = adev->driver_data;
-	struct ec_event *event;
-	struct ec_event_entry *entry, *oldest_entry;
-	size_t event_size, num_words, word_size;
+	struct ec_event *event, *queue_event, *old_event;
+	size_t num_words, event_size;
 	u32 offset = 0;
 
 	while (offset < length) {
 		event = (struct ec_event *)(buf + offset);
-		if (!event)
-			return -EINVAL;
 
-		/* Number of 16bit event data words is size - 1 */
-		num_words = event->size - 1;
-		word_size = num_words * sizeof(u16);
-		event_size = sizeof(*event) + word_size;
+		num_words = ec_event_num_words(event);
+		event_size = ec_event_size(event);
 		if (num_words > EC_ACPI_MAX_EVENT_WORDS) {
 			dev_err(&adev->dev, "Too many event words: %zu > %d\n",
 				num_words, EC_ACPI_MAX_EVENT_WORDS);
 			return -EOVERFLOW;
-		};
+		}
 
 		/* Ensure event does not overflow the available buffer */
 		if ((offset + event_size) > length) {
@@ -170,31 +238,15 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
 		/* Point to the next event in the buffer */
 		offset += event_size;
 
-		/* Create event entry for the queue */
-		entry = kzalloc(sizeof(struct ec_event_entry) + word_size,
-				GFP_KERNEL);
-		if (!entry)
+		/* Copy event into the queue */
+		queue_event = kmemdup(event, event_size, GFP_KERNEL);
+		if (!queue_event)
 			return -ENOMEM;
-		entry->size = event_size;
-		memcpy(&entry->event, event, entry->size);
-
-		mutex_lock(&dev_data->lock);
-
-		/* If the queue is full, delete the oldest event */
-		if (dev_data->num_events >= MAX_NUM_EVENTS) {
-			oldest_entry = list_first_entry(&dev_data->events,
-						      struct ec_event_entry,
-						      list);
-			list_del(&oldest_entry->list);
-			kfree(oldest_entry);
-			dev_data->num_events--;
-		}
-
-		/* Add this event to the queue */
-		list_add_tail(&entry->list, &dev_data->events);
-		dev_data->num_events++;
-
-		mutex_unlock(&dev_data->lock);
+		spin_lock(&dev_data->queue_lock);
+		old_event = event_queue_push(dev_data->events, queue_event);
+		spin_unlock(&dev_data->queue_lock);
+		kfree(old_event);
+		wake_up_interruptible(&dev_data->wq);
 	}
 
 	return 0;
@@ -210,7 +262,6 @@ static int enqueue_events(struct acpi_device *adev, const u8 *buf, u32 length)
 static void event_device_notify(struct acpi_device *adev, u32 value)
 {
 	struct acpi_buffer event_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct event_device_data *dev_data = adev->driver_data;
 	union acpi_object *obj;
 	acpi_status status;
 
@@ -249,9 +300,6 @@ static void event_device_notify(struct acpi_device *adev, u32 value)
 
 	enqueue_events(adev, obj->buffer.pointer, obj->buffer.length);
 	kfree(obj);
-
-	if (dev_data->num_events)
-		wake_up_interruptible(&dev_data->wq);
 }
 
 static int event_open(struct inode *inode, struct file *filp)
@@ -267,7 +315,7 @@ static int event_open(struct inode *inode, struct file *filp)
 
 	/* Increase refcount on device so dev_data is not freed */
 	get_device(&dev_data->dev);
-	nonseekable_open(inode, filp);
+	stream_open(inode, filp);
 	filp->private_data = dev_data;
 
 	return 0;
@@ -281,7 +329,7 @@ static __poll_t event_poll(struct file *filp, poll_table *wait)
 	poll_wait(filp, &dev_data->wq, wait);
 	if (!dev_data->exist)
 		return EPOLLHUP;
-	if (dev_data->num_events)
+	if (!event_queue_empty(dev_data->events))
 		mask |= EPOLLIN | EPOLLRDNORM | EPOLLPRI;
 	return mask;
 }
@@ -293,8 +341,7 @@ static __poll_t event_poll(struct file *filp, poll_table *wait)
  * @count: Number of bytes requested. Must be at least EC_ACPI_MAX_EVENT_SIZE.
  * @pos: File position pointer, irrelevant since we don't support seeking.
  *
- * Fills the passed buffer with the data from the first event in the queue,
- * removes that event from the queue. On error, the event remains in the queue.
+ * Removes the first event from the queue, places it in the passed buffer.
  *
  * If there are no events in the the queue, then one of two things happens,
  * depending on if the file was opened in nonblocking mode: If in nonblocking
@@ -307,7 +354,7 @@ static ssize_t event_read(struct file *filp, char __user *buf, size_t count,
 			  loff_t *pos)
 {
 	struct event_device_data *dev_data = filp->private_data;
-	struct ec_event_entry *entry;
+	struct ec_event *event;
 	ssize_t n_bytes_written = 0;
 	int err;
 
@@ -315,39 +362,29 @@ static ssize_t event_read(struct file *filp, char __user *buf, size_t count,
 	if (count != 0 && count < EC_ACPI_MAX_EVENT_SIZE)
 		return -EINVAL;
 
-	mutex_lock(&dev_data->lock);
-
-	while (dev_data->num_events == 0) {
-		if (filp->f_flags & O_NONBLOCK) {
-			mutex_unlock(&dev_data->lock);
+	spin_lock(&dev_data->queue_lock);
+	while (event_queue_empty(dev_data->events)) {
+		spin_unlock(&dev_data->queue_lock);
+		if (filp->f_flags & O_NONBLOCK)
 			return -EAGAIN;
-		}
-		/* Need to unlock so that data can actually get added to the
-		 * queue, and since we recheck before use and it's just
-		 * comparing pointers, this is safe unlocked.
-		 */
-		mutex_unlock(&dev_data->lock);
+
 		err = wait_event_interruptible(dev_data->wq,
-					       dev_data->num_events);
+					!event_queue_empty(dev_data->events) ||
+					!dev_data->exist);
 		if (err)
 			return err;
 
 		/* Device was removed as we waited? */
 		if (!dev_data->exist)
 			return -ENODEV;
-		mutex_lock(&dev_data->lock);
+		spin_lock(&dev_data->queue_lock);
 	}
-
-	entry = list_first_entry(&dev_data->events,
-				 struct ec_event_entry, list);
-	n_bytes_written = entry->size;
-	if (copy_to_user(buf, &entry->event, n_bytes_written))
+	event = event_queue_pop(dev_data->events);
+	spin_unlock(&dev_data->queue_lock);
+	n_bytes_written = ec_event_size(event);
+	if (copy_to_user(buf, event, n_bytes_written))
 		n_bytes_written = -EFAULT;
-	list_del(&entry->list);
-	kfree(entry);
-	dev_data->num_events--;
-
-	mutex_unlock(&dev_data->lock);
+	kfree(event);
 
 	return n_bytes_written;
 }
@@ -384,15 +421,13 @@ static void free_device_data(struct device *d)
 	struct event_device_data *dev_data;
 
 	dev_data = container_of(d, struct event_device_data, dev);
+	event_queue_free(dev_data->events);
 	kfree(dev_data);
 }
 
 static void hangup_device(struct event_device_data *dev_data)
 {
-	mutex_lock(&dev_data->lock);
 	dev_data->exist = false;
-	mutex_unlock(&dev_data->lock);
-
 	/* Wake up the waiting processes so they can close. */
 	wake_up_interruptible(&dev_data->wq);
 	put_device(&dev_data->dev);
@@ -420,7 +455,7 @@ static int event_device_add(struct acpi_device *adev)
 	minor = ida_alloc_max(&event_ida, EVENT_MAX_DEV-1, GFP_KERNEL);
 	if (minor < 0) {
 		error = minor;
-		dev_err(&adev->dev, "Failed to find minor number: %d", error);
+		dev_err(&adev->dev, "Failed to find minor number: %d\n", error);
 		return error;
 	}
 
@@ -432,8 +467,13 @@ static int event_device_add(struct acpi_device *adev)
 
 	/* Initialize the device data. */
 	adev->driver_data = dev_data;
-	INIT_LIST_HEAD(&dev_data->events);
-	mutex_init(&dev_data->lock);
+	dev_data->events = event_queue_new(queue_size);
+	if (!dev_data->events) {
+		kfree(dev_data);
+		error = -ENOMEM;
+		goto free_minor;
+	}
+	spin_lock_init(&dev_data->queue_lock);
 	init_waitqueue_head(&dev_data->wq);
 	dev_data->exist = true;
 	atomic_set(&dev_data->available, 1);
@@ -496,14 +536,14 @@ static int __init event_module_init(void)
 
 	ret = class_register(&event_class);
 	if (ret) {
-		pr_err(DRV_NAME ": Failed registering class: %d", ret);
+		pr_err(DRV_NAME ": Failed registering class: %d\n", ret);
 		return ret;
 	}
 
 	/* Request device numbers, starting with minor=0. Save the major num. */
 	ret = alloc_chrdev_region(&dev_num, 0, EVENT_MAX_DEV, EVENT_DEV_NAME);
 	if (ret) {
-		pr_err(DRV_NAME ": Failed allocating dev numbers: %d", ret);
+		pr_err(DRV_NAME ": Failed allocating dev numbers: %d\n", ret);
 		goto destroy_class;
 	}
 	event_major = MAJOR(dev_num);
-- 
2.20.1

