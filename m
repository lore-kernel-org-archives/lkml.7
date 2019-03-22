Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85EFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32A22075D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfCVFXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:23:18 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45654 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbfCVFXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-000162-RW; Fri, 22 Mar 2019 05:23:13 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-0001ow-Lb; Fri, 22 Mar 2019 05:23:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Benjamin Tissoires" <benjamin.tissoires@redhat.com>,
        "Vladis Dronov" <vdronov@redhat.com>
Date:   Fri, 22 Mar 2019 05:20:18 +0000
Message-ID: <lsq.1553232018.289608661@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 10/16] HID: debug: fix the ring buffer implementation
In-Reply-To: <lsq.1553232017.771830163@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.64-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vladis Dronov <vdronov@redhat.com>

commit 13054abbaa4f1fd4e6f3b4b63439ec033b4c8035 upstream.

Ring buffer implementation in hid_debug_event() and hid_debug_events_read()
is strange allowing lost or corrupted data. After commit 717adfdaf147
("HID: debug: check length before copy_to_user()") it is possible to enter
an infinite loop in hid_debug_events_read() by providing 0 as count, this
locks up a system. Fix this by rewriting the ring buffer implementation
with kfifo and simplify the code.

This fixes CVE-2019-3819.

v2: fix an execution logic and add a comment
v3: use __set_current_state() instead of set_current_state()

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1669187
Fixes: cd667ce24796 ("HID: use debugfs for events/reports dumping")
Fixes: 717adfdaf147 ("HID: debug: check length before copy_to_user()")
Signed-off-by: Vladis Dronov <vdronov@redhat.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hid-debug.c   | 120 +++++++++++++++-----------------------
 include/linux/hid-debug.h |   9 ++-
 2 files changed, 51 insertions(+), 78 deletions(-)

--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -30,6 +30,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/kfifo.h>
 #include <linux/sched.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -658,17 +659,12 @@ EXPORT_SYMBOL_GPL(hid_dump_device);
 /* enqueue string to 'events' ring buffer */
 void hid_debug_event(struct hid_device *hdev, char *buf)
 {
-	unsigned i;
 	struct hid_debug_list *list;
 	unsigned long flags;
 
 	spin_lock_irqsave(&hdev->debug_list_lock, flags);
-	list_for_each_entry(list, &hdev->debug_list, node) {
-		for (i = 0; buf[i]; i++)
-			list->hid_debug_buf[(list->tail + i) % HID_DEBUG_BUFSIZE] =
-				buf[i];
-		list->tail = (list->tail + i) % HID_DEBUG_BUFSIZE;
-        }
+	list_for_each_entry(list, &hdev->debug_list, node)
+		kfifo_in(&list->hid_debug_fifo, buf, strlen(buf));
 	spin_unlock_irqrestore(&hdev->debug_list_lock, flags);
 
 	wake_up_interruptible(&hdev->debug_wait);
@@ -719,8 +715,7 @@ void hid_dump_input(struct hid_device *h
 	hid_debug_event(hdev, buf);
 
 	kfree(buf);
-        wake_up_interruptible(&hdev->debug_wait);
-
+	wake_up_interruptible(&hdev->debug_wait);
 }
 EXPORT_SYMBOL_GPL(hid_dump_input);
 
@@ -1085,8 +1080,8 @@ static int hid_debug_events_open(struct
 		goto out;
 	}
 
-	if (!(list->hid_debug_buf = kzalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_KERNEL))) {
-		err = -ENOMEM;
+	err = kfifo_alloc(&list->hid_debug_fifo, HID_DEBUG_FIFOSIZE, GFP_KERNEL);
+	if (err) {
 		kfree(list);
 		goto out;
 	}
@@ -1106,77 +1101,57 @@ static ssize_t hid_debug_events_read(str
 		size_t count, loff_t *ppos)
 {
 	struct hid_debug_list *list = file->private_data;
-	int ret = 0, len;
+	int ret = 0, copied;
 	DECLARE_WAITQUEUE(wait, current);
 
 	mutex_lock(&list->read_mutex);
-	while (ret == 0) {
-		if (list->head == list->tail) {
-			add_wait_queue(&list->hdev->debug_wait, &wait);
-			set_current_state(TASK_INTERRUPTIBLE);
-
-			while (list->head == list->tail) {
-				if (file->f_flags & O_NONBLOCK) {
-					ret = -EAGAIN;
-					break;
-				}
-				if (signal_pending(current)) {
-					ret = -ERESTARTSYS;
-					break;
-				}
-
-				if (!list->hdev || !list->hdev->debug) {
-					ret = -EIO;
-					set_current_state(TASK_RUNNING);
-					goto out;
-				}
-
-				/* allow O_NONBLOCK from other threads */
-				mutex_unlock(&list->read_mutex);
-				schedule();
-				mutex_lock(&list->read_mutex);
-				set_current_state(TASK_INTERRUPTIBLE);
+	if (kfifo_is_empty(&list->hid_debug_fifo)) {
+		add_wait_queue(&list->hdev->debug_wait, &wait);
+		set_current_state(TASK_INTERRUPTIBLE);
+
+		while (kfifo_is_empty(&list->hid_debug_fifo)) {
+			if (file->f_flags & O_NONBLOCK) {
+				ret = -EAGAIN;
+				break;
 			}
 
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&list->hdev->debug_wait, &wait);
-		}
-
-		if (ret)
-			goto out;
-
-		/* pass the ringbuffer contents to userspace */
-copy_rest:
-		if (list->tail == list->head)
-			goto out;
-		if (list->tail > list->head) {
-			len = list->tail - list->head;
-			if (len > count)
-				len = count;
-
-			if (copy_to_user(buffer + ret, &list->hid_debug_buf[list->head], len)) {
-				ret = -EFAULT;
-				goto out;
+			if (signal_pending(current)) {
+				ret = -ERESTARTSYS;
+				break;
 			}
-			ret += len;
-			list->head += len;
-		} else {
-			len = HID_DEBUG_BUFSIZE - list->head;
-			if (len > count)
-				len = count;
 
-			if (copy_to_user(buffer, &list->hid_debug_buf[list->head], len)) {
-				ret = -EFAULT;
+			/* if list->hdev is NULL we cannot remove_wait_queue().
+			 * if list->hdev->debug is 0 then hid_debug_unregister()
+			 * was already called and list->hdev is being destroyed.
+			 * if we add remove_wait_queue() here we can hit a race.
+			 */
+			if (!list->hdev || !list->hdev->debug) {
+				ret = -EIO;
+				set_current_state(TASK_RUNNING);
 				goto out;
 			}
-			list->head = 0;
-			ret += len;
-			count -= len;
-			if (count > 0)
-				goto copy_rest;
+
+			/* allow O_NONBLOCK from other threads */
+			mutex_unlock(&list->read_mutex);
+			schedule();
+			mutex_lock(&list->read_mutex);
+			set_current_state(TASK_INTERRUPTIBLE);
 		}
 
+		__set_current_state(TASK_RUNNING);
+		remove_wait_queue(&list->hdev->debug_wait, &wait);
+
+		if (ret)
+			goto out;
 	}
+
+	/* pass the fifo content to userspace, locking is not needed with only
+	 * one concurrent reader and one concurrent writer
+	 */
+	ret = kfifo_to_user(&list->hid_debug_fifo, buffer, count, &copied);
+	if (ret)
+		goto out;
+	ret = copied;
 out:
 	mutex_unlock(&list->read_mutex);
 	return ret;
@@ -1187,7 +1162,7 @@ static unsigned int hid_debug_events_pol
 	struct hid_debug_list *list = file->private_data;
 
 	poll_wait(file, &list->hdev->debug_wait, wait);
-	if (list->head != list->tail)
+	if (!kfifo_is_empty(&list->hid_debug_fifo))
 		return POLLIN | POLLRDNORM;
 	if (!list->hdev->debug)
 		return POLLERR | POLLHUP;
@@ -1202,7 +1177,7 @@ static int hid_debug_events_release(stru
 	spin_lock_irqsave(&list->hdev->debug_list_lock, flags);
 	list_del(&list->node);
 	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
-	kfree(list->hid_debug_buf);
+	kfifo_free(&list->hid_debug_fifo);
 	kfree(list);
 
 	return 0;
@@ -1253,4 +1228,3 @@ void hid_debug_exit(void)
 {
 	debugfs_remove_recursive(hid_debug_root);
 }
-
--- a/include/linux/hid-debug.h
+++ b/include/linux/hid-debug.h
@@ -24,7 +24,10 @@
 
 #ifdef CONFIG_DEBUG_FS
 
+#include <linux/kfifo.h>
+
 #define HID_DEBUG_BUFSIZE 512
+#define HID_DEBUG_FIFOSIZE 512
 
 void hid_dump_input(struct hid_device *, struct hid_usage *, __s32);
 void hid_dump_report(struct hid_device *, int , u8 *, int);
@@ -37,11 +40,8 @@ void hid_debug_init(void);
 void hid_debug_exit(void);
 void hid_debug_event(struct hid_device *, char *);
 
-
 struct hid_debug_list {
-	char *hid_debug_buf;
-	int head;
-	int tail;
+	DECLARE_KFIFO_PTR(hid_debug_fifo, char);
 	struct fasync_struct *fasync;
 	struct hid_device *hdev;
 	struct list_head node;
@@ -64,4 +64,3 @@ struct hid_debug_list {
 #endif
 
 #endif
-

