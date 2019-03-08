Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5BFC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9552085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfCHMhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:37:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43308 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfCHMhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:37:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 41C0027F167
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        Vincent Palatin <vpalatin@chromium.org>
Subject: [PATCH] mfd: cros_ec_dev: Add a poll handler to receive MKBP events
Date:   Fri,  8 Mar 2019 13:36:59 +0100
Message-Id: <20190308123659.16101-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Palatin <vpalatin@chromium.org>

Allow to poll on the cros_ec device to receive the MKBP events.

The /dev/cros_[ec|fp|..] file operations now implements the poll
operation. The userspace can now receive specific MKBP events by doing the
following:
- Open the /dev/cros_XX file.
- Call the CROS_EC_DEV_IOCEVENTMASK ioctl with the bitmap of the MKBP
  events it wishes to receive as argument.
- Poll on the file descriptor.
- When it gets POLLIN, do a read on the file descriptor, the first
  queued event will be returned (using the struct
  ec_response_get_next_event format: one byte of event type, then
  the payload).

The read() operation returns at most one event even if there are several
queued, and it might be truncated if the buffer is smaller than the
event (but the caller should know the maximum size of the events it is
reading).

read() used to return the EC version string, it still does it when no
event mask or an empty event is set for backward compatibility (despite
nobody really using this feature).

This will be used, for example, by the userspace daemon to receive and
treat the EC_MKBP_EVENT_FINGERPRINT sent by the FP MCU.

Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/mfd/cros_ec_dev.c | 163 +++++++++++++++++++++++++++++++++++++-
 drivers/mfd/cros_ec_dev.h |   1 +
 2 files changed, 160 insertions(+), 4 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 85f05cb648f8..0638a0d82d97 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -21,9 +21,11 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/notifier.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
@@ -33,6 +35,9 @@
 
 /* Device variables */
 #define CROS_MAX_DEV 128
+/* Arbitrary bounded size for the event queue */
+#define CROS_MAX_EVENT_LEN	PAGE_SIZE
+
 static int ec_major;
 
 static struct class cros_class = {
@@ -40,6 +45,22 @@ static struct class cros_class = {
 	.name           = "chromeos",
 };
 
+struct cros_ec_priv {
+	struct cros_ec_dev *ec;
+	struct notifier_block notifier;
+	struct list_head events;
+	wait_queue_head_t wait_event;
+	unsigned long event_mask;
+	size_t event_len;
+};
+
+struct ec_priv_event {
+	struct list_head node;
+	size_t size;
+	u8 event_type;
+	u8 data[0];
+};
+
 /* Basic communication */
 static int ec_get_version(struct cros_ec_dev *ec, char *str, int maxlen)
 {
@@ -120,30 +141,159 @@ static int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
 }
 
+static int ec_device_mkbp_event(struct notifier_block *nb,
+				unsigned long queued_during_suspend,
+				void *_notify)
+{
+	struct cros_ec_priv *priv = container_of(nb, struct cros_ec_priv,
+						 notifier);
+	struct cros_ec_device *ec_dev = priv->ec->ec_dev;
+	struct ec_priv_event *event;
+	unsigned long event_bit = 1 << ec_dev->event_data.event_type;
+	int total_size = sizeof(*event) + ec_dev->event_size;
+
+	if (!(event_bit & priv->event_mask) ||
+	    (priv->event_len + total_size) > CROS_MAX_EVENT_LEN)
+		return NOTIFY_DONE;
+
+	event = kzalloc(total_size, GFP_KERNEL);
+	if (!event)
+		return NOTIFY_DONE;
+
+	event->size = ec_dev->event_size;
+	event->event_type = ec_dev->event_data.event_type;
+	memcpy(event->data, &ec_dev->event_data.data, ec_dev->event_size);
+
+	spin_lock(&priv->wait_event.lock);
+	list_add_tail(&event->node, &priv->events);
+	priv->event_len += total_size;
+	wake_up_locked(&priv->wait_event);
+	spin_unlock(&priv->wait_event.lock);
+
+	return NOTIFY_OK;
+}
+
 /* Device file ops */
 static int ec_device_open(struct inode *inode, struct file *filp)
 {
 	struct cros_ec_dev *ec = container_of(inode->i_cdev,
 					      struct cros_ec_dev, cdev);
-	filp->private_data = ec;
+	struct cros_ec_priv *priv;
+	int ret;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->ec = ec;
+	filp->private_data = priv;
+	INIT_LIST_HEAD(&priv->events);
+	init_waitqueue_head(&priv->wait_event);
 	nonseekable_open(inode, filp);
-	return 0;
+
+	priv->notifier.notifier_call = ec_device_mkbp_event;
+	ret = blocking_notifier_chain_register(&ec->ec_dev->event_notifier,
+					       &priv->notifier);
+	if (ret) {
+		dev_err(ec->dev, "failed to register event notifier\n");
+		kfree(priv);
+	}
+
+	return ret;
+}
+
+static __poll_t ec_device_poll(struct file *filp, poll_table *wait)
+{
+	struct cros_ec_priv *priv = filp->private_data;
+
+	poll_wait(filp, &priv->wait_event, wait);
+
+	if (list_empty(&priv->events))
+		return 0;
+
+	return EPOLLIN | EPOLLRDNORM;
 }
 
 static int ec_device_release(struct inode *inode, struct file *filp)
 {
+	struct cros_ec_priv *priv = filp->private_data;
+	struct cros_ec_dev *ec = priv->ec;
+	struct ec_priv_event *evt, *tmp;
+
+	blocking_notifier_chain_unregister(&ec->ec_dev->event_notifier,
+					   &priv->notifier);
+	list_for_each_entry_safe(evt, tmp, &priv->events, node) {
+		list_del(&evt->node);
+		kfree(evt);
+	}
+	kfree(priv);
+
 	return 0;
 }
 
+static struct ec_priv_event *ec_fetch_event(struct cros_ec_priv *priv,
+					    bool fetch, bool block)
+{
+	struct ec_priv_event *event;
+	int err;
+
+	spin_lock(&priv->wait_event.lock);
+	if (!block && list_empty(&priv->events)) {
+		event = ERR_PTR(-EWOULDBLOCK);
+		goto out;
+	}
+	if (!fetch) {
+		event = NULL;
+		goto out;
+	}
+	err = wait_event_interruptible_locked(priv->wait_event,
+					      !list_empty(&priv->events));
+	if (err) {
+		event = ERR_PTR(err);
+		goto out;
+	}
+	event = list_first_entry(&priv->events, struct ec_priv_event, node);
+	list_del(&event->node);
+	priv->event_len -= sizeof(*event) + event->size;
+out:
+	spin_unlock(&priv->wait_event.lock);
+	return event;
+}
+
 static ssize_t ec_device_read(struct file *filp, char __user *buffer,
 			      size_t length, loff_t *offset)
 {
-	struct cros_ec_dev *ec = filp->private_data;
+	struct cros_ec_priv *priv = filp->private_data;
+	struct cros_ec_dev *ec = priv->ec;
 	char msg[sizeof(struct ec_response_get_version) +
 		 sizeof(CROS_EC_DEV_VERSION)];
 	size_t count;
 	int ret;
 
+	if (priv->event_mask) { /* queued MKBP event */
+		struct ec_priv_event *event;
+
+		event = ec_fetch_event(priv, length != 0,
+				       !(filp->f_flags & O_NONBLOCK));
+		if (IS_ERR(event))
+			return PTR_ERR(event);
+		/*
+		 * length == 0 is special - no IO is done but we check
+		 * for error conditions.
+		 */
+		if (length == 0)
+			return 0;
+
+		/* the event is 1 byte of type plus the payload */
+		count = min(length, event->size + 1);
+		ret = copy_to_user(buffer, &event->event_type, count);
+		kfree(event);
+		if (ret) /* the copy failed */
+			return -EFAULT;
+		*offset = count;
+		return count;
+	}
+	/* legacy behavior if no event mask is defined */
 	if (*offset != 0)
 		return 0;
 
@@ -230,7 +380,8 @@ static long ec_device_ioctl_readmem(struct cros_ec_dev *ec, void __user *arg)
 static long ec_device_ioctl(struct file *filp, unsigned int cmd,
 			    unsigned long arg)
 {
-	struct cros_ec_dev *ec = filp->private_data;
+	struct cros_ec_priv *priv = filp->private_data;
+	struct cros_ec_dev *ec = priv->ec;
 
 	if (_IOC_TYPE(cmd) != CROS_EC_DEV_IOC)
 		return -ENOTTY;
@@ -240,6 +391,9 @@ static long ec_device_ioctl(struct file *filp, unsigned int cmd,
 		return ec_device_ioctl_xcmd(ec, (void __user *)arg);
 	case CROS_EC_DEV_IOCRDMEM:
 		return ec_device_ioctl_readmem(ec, (void __user *)arg);
+	case CROS_EC_DEV_IOCEVENTMASK:
+		priv->event_mask = arg;
+		return 0;
 	}
 
 	return -ENOTTY;
@@ -248,6 +402,7 @@ static long ec_device_ioctl(struct file *filp, unsigned int cmd,
 /* Module initialization */
 static const struct file_operations fops = {
 	.open = ec_device_open,
+	.poll = ec_device_poll,
 	.release = ec_device_release,
 	.read = ec_device_read,
 	.unlocked_ioctl = ec_device_ioctl,
diff --git a/drivers/mfd/cros_ec_dev.h b/drivers/mfd/cros_ec_dev.h
index ec750433455a..e8c5ee8dd18f 100644
--- a/drivers/mfd/cros_ec_dev.h
+++ b/drivers/mfd/cros_ec_dev.h
@@ -43,5 +43,6 @@ struct cros_ec_readmem {
 #define CROS_EC_DEV_IOC       0xEC
 #define CROS_EC_DEV_IOCXCMD   _IOWR(CROS_EC_DEV_IOC, 0, struct cros_ec_command)
 #define CROS_EC_DEV_IOCRDMEM  _IOWR(CROS_EC_DEV_IOC, 1, struct cros_ec_readmem)
+#define CROS_EC_DEV_IOCEVENTMASK _IO(CROS_EC_DEV_IOC, 2)
 
 #endif /* _CROS_EC_DEV_H_ */
-- 
2.20.1

