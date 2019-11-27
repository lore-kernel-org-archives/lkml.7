Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817FBC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461692068E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="tD8cJcpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfK0Nfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:35:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55639 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfK0Nfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:35:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id a131so2811031wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 05:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fy67Y05T0C5Cm45dLc4bZf5nJLsPtm+jXf2fKppU1oY=;
        b=tD8cJcpr0FF5Pg8L6klW/Cm34IW1tXuZSRzqiJeBr6ve9mfs0iZtLoSg5OqO3LiCvD
         QaZ8IldsakTI/HgK/ckldaEv7W24/odp+HokkLDwMv1d2DjgSUJwLjGJf6IFARMInVtM
         DCiS6QKfBjn2QQ11Cx4sJ2kAJRyDnm0Ux8rPKISCd3z1v/tPfrk4N5dYwLXgwqSm24f1
         vmjV7yxb9SkuPBkTdDIgH1LoSgEPlX5xTr6/PAGBkIvQoxlTcfzWzwHyjAr6ZxEZMBNY
         W9l6QH9iOfFd4uzYKdjya4ffNYxv5vyL1jyrzFPfg3kpdzvubmA2ShechqKisEJ03zJj
         Icpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fy67Y05T0C5Cm45dLc4bZf5nJLsPtm+jXf2fKppU1oY=;
        b=Tpi3wkbNCTzBAze7JL7jVIUdgyCIjfwFRuv/RbcLVK+lZxfsYWOeCsu+683LfEDBdy
         rhxuVbPFemhdR+Whfz+c0RAQLvV9J6eMXBukA8Ych3a6nSxwPq+0cVVcaXQuUTKAlGQA
         IbhY8bukT0hOiXKAqmazSa5luQHOY02AcA9utedhtL61Q79WZp9LcXb0rhTHPBz1tg1j
         Tri3OkeGEi3YZ8HvFPFHLMm1Cn+0BJtPJbcI1Y/FyBUorsz3u/d7vnPLDNp1iBiPx+Cl
         +8YOTw7rW5QM4R5ZniyiSRL8Sg4txOrg7NSr4b6ztk1CpjjY36v16JCQo17726ynGtrj
         6D4A==
X-Gm-Message-State: APjAAAXyFCF4iqDaDNmO5eQ8Q1icDUNuqoctRqRxe6n+6Q80D6l9pCE2
        FVHe8cKIDM8vzfwCOLjzGYbflA==
X-Google-Smtp-Source: APXvYqycDXul1VuUvwrPL8Svh7X8RCpRJ2uNCXU5AwS9+A/fzu0vnjy7mxK7r/85+rwbHmvp5xmtCA==
X-Received: by 2002:a1c:9602:: with SMTP id y2mr4158842wmd.23.1574861728100;
        Wed, 27 Nov 2019 05:35:28 -0800 (PST)
Received: from debian-brgl.home (lfbn-1-7087-108.w90-116.abo.wanadoo.fr. [90.116.255.108])
        by smtp.gmail.com with ESMTPSA id k18sm19663687wrm.82.2019.11.27.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 05:35:27 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 7/8] gpiolib: add new ioctl() for monitoring changes in line info
Date:   Wed, 27 Nov 2019 14:35:09 +0100
Message-Id: <20191127133510.10614-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127133510.10614-1-brgl@bgdev.pl>
References: <20191127133510.10614-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently there is no way for user-space to be informed about changes
in status of GPIO lines e.g. when someone else requests the line or its
config changes. We can only periodically re-read the line-info. This
is fine for simple one-off user-space tools, but any daemon that provides
a centralized access to GPIO chips would benefit hugely from an event
driven line info synchronization.

This patch adds a new ioctl() that allows user-space processes to retrieve
a file-descriptor for given GPIO lines which can be polled for line status
change events.

Currently the events are generated on three types of status changes: when
a line is requested, when it's released and when its config is changed.
The first two are self-explanatory. For the third one: this will only
happen when another user-space process calls the new SET_CONFIG ioctl()
as any changes that can happen from within the kernel (i.e.
set_transitory() or set_debounce()) are of no interest to user-space.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c    | 218 ++++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.h    |   1 +
 include/uapi/linux/gpio.h |  36 +++++++
 3 files changed, 255 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d094b1be334d..be5df4bdf44b 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -547,6 +547,9 @@ static long linehandle_set_config(struct linehandle_state *lh,
 			if (ret)
 				return ret;
 		}
+
+		atomic_notifier_call_chain(&desc->gdev->notifier,
+					   GPIOLINE_CHANGED_CONFIG, desc);
 	}
 	return 0;
 }
@@ -1148,6 +1151,212 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 	return ret;
 }
 
+struct linechanged_fd_state {
+	struct gpio_device *gdev;
+	struct gpio_desc *descs[GPIOHANDLES_MAX];
+	size_t numdescs;
+	wait_queue_head_t waitqueue;
+	DECLARE_KFIFO(events, struct gpioline_changed, 16);
+	struct mutex lock;
+	struct notifier_block changed_nb;
+};
+
+static int linechanged_fd_release(struct inode *inode, struct file *filep)
+{
+	struct linechanged_fd_state *lc_state = filep->private_data;
+
+	atomic_notifier_chain_unregister(&lc_state->gdev->notifier,
+					 &lc_state->changed_nb);
+	put_device(&lc_state->gdev->dev);
+	kfree(lc_state);
+
+	return 0;
+}
+
+static __poll_t linechanged_fd_poll(struct file *filep,
+				    struct poll_table_struct *pollt)
+{
+	struct linechanged_fd_state *lc_state = filep->private_data;
+	__poll_t events = 0;
+
+	poll_wait(filep, &lc_state->waitqueue, pollt);
+
+	mutex_lock(&lc_state->lock);
+	if (!kfifo_is_empty(&lc_state->events))
+		events = EPOLLIN | EPOLLRDNORM;
+	mutex_unlock(&lc_state->lock);
+
+	return events;
+}
+
+static ssize_t linechanged_fd_read(struct file *filep, char __user *buf,
+				   size_t count, loff_t *off)
+{
+	struct linechanged_fd_state *lc_state = filep->private_data;
+	unsigned int copied;
+	int ret;
+
+	if (count < sizeof(struct gpioline_changed))
+		return -EINVAL;
+
+	do {
+		mutex_lock(&lc_state->lock);
+		if (kfifo_is_empty(&lc_state->events)) {
+			mutex_unlock(&lc_state->lock);
+			if (filep->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			ret = wait_event_interruptible(lc_state->waitqueue,
+					!kfifo_is_empty(&lc_state->events));
+			if (ret)
+				return ret;
+		} else {
+			mutex_unlock(&lc_state->lock);
+		}
+
+		if (mutex_lock_interruptible(&lc_state->lock))
+			return -ERESTARTSYS;
+
+		ret = kfifo_to_user(&lc_state->events, buf, count, &copied);
+		mutex_unlock(&lc_state->lock);
+		if (ret)
+			return ret;
+
+		if (copied == 0 && (filep->f_flags & O_NONBLOCK))
+			return -EAGAIN;
+	} while (copied == 0);
+
+	return copied;
+}
+
+static const struct file_operations linechanged_fd_fileops = {
+	.release = linechanged_fd_release,
+	.owner = THIS_MODULE,
+	.llseek = noop_llseek,
+	.poll = linechanged_fd_poll,
+	.read = linechanged_fd_read,
+};
+
+static struct linechanged_fd_state *
+to_linechanged_fd_state(struct notifier_block *nb)
+{
+	return container_of(nb, struct linechanged_fd_state, changed_nb);
+}
+
+static int linechanged_fd_notify(struct notifier_block *nb,
+				 unsigned long action, void *data)
+{
+	struct linechanged_fd_state *lc_state = to_linechanged_fd_state(nb);
+	struct gpio_desc *desc = data;
+	struct gpioline_changed chg;
+	int i, ret;
+
+	for (i = 0; i < lc_state->numdescs; i++) {
+		/* Are we watching this desc? */
+		if (desc == lc_state->descs[i]) {
+			/* Yes - prepare the event. */
+			memset(&chg, 0, sizeof(chg));
+			chg.line_offset = gpio_chip_hwgpio(desc);
+			chg.event_type = action;
+
+			mutex_lock(&lc_state->lock);
+			ret = kfifo_put(&lc_state->events, chg);
+			mutex_unlock(&lc_state->lock);
+			if (ret)
+				wake_up_poll(&lc_state->waitqueue, EPOLLIN);
+
+			return NOTIFY_OK;
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static int linechanged_fd_create(struct gpio_device *gdev, void __user *ip)
+{
+	struct gpioline_changed_fd_request changed_req;
+	struct linechanged_fd_state *lc_state;
+	struct gpio_desc *desc;
+	struct file *file;
+	int ret, i, fd;
+	u32 offset;
+
+	ret = copy_from_user(&changed_req, ip, sizeof(changed_req));
+	if (ret)
+		return -EFAULT;
+
+	if ((changed_req.num_lines == 0) ||
+	    (changed_req.num_lines > GPIOHANDLES_MAX))
+		return -EINVAL;
+
+	lc_state = kzalloc(sizeof(*lc_state), GFP_KERNEL);
+	if (!lc_state)
+		return -ENOMEM;
+
+	lc_state->gdev = gdev;
+	get_device(&gdev->dev);
+
+	for (i = 0; i < changed_req.num_lines; i++) {
+		offset = changed_req.lineoffsets[i];
+		desc = gpiochip_get_desc(gdev->chip, offset);
+		if (IS_ERR(desc)) {
+			ret = PTR_ERR(desc);
+			goto out_free_lc_state;
+		}
+
+		lc_state->descs[i] = desc;
+	}
+
+	lc_state->numdescs = changed_req.num_lines;
+
+	init_waitqueue_head(&lc_state->waitqueue);
+	INIT_KFIFO(lc_state->events);
+	mutex_init(&lc_state->lock);
+
+	lc_state->changed_nb.notifier_call = linechanged_fd_notify;
+
+	ret = atomic_notifier_chain_register(&gdev->notifier,
+					     &lc_state->changed_nb);
+	if (ret)
+		goto out_free_lc_state;
+
+	fd = get_unused_fd_flags(O_RDONLY | O_CLOEXEC);
+	if (fd < 0) {
+		ret = fd;
+		goto out_unregister_notifier;
+	}
+
+	file = anon_inode_getfile("gpio-line-changed-fd",
+				  &linechanged_fd_fileops,
+				  lc_state, O_RDONLY | O_CLOEXEC);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto out_put_unused_fd;
+	}
+
+	changed_req.fd = fd;
+	ret = copy_to_user(ip, &changed_req, sizeof(changed_req));
+	if (ret) {
+		fput(file);
+		put_unused_fd(fd);
+		return -EFAULT;
+	}
+
+	fd_install(fd, file);
+
+	return 0;
+
+out_put_unused_fd:
+	put_unused_fd(fd);
+out_unregister_notifier:
+	atomic_notifier_chain_unregister(&gdev->notifier,
+					 &lc_state->changed_nb);
+out_free_lc_state:
+	kfree(lc_state);
+
+	return ret;
+}
+
 /*
  * gpio_ioctl() - ioctl handler for the GPIO chardev
  */
@@ -1238,6 +1447,8 @@ static long gpio_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return linehandle_create(gdev, ip);
 	} else if (cmd == GPIO_GET_LINEEVENT_IOCTL) {
 		return lineevent_create(gdev, ip);
+	} else if (cmd == GPIO_GET_LINECHANGED_FD_IOCTL) {
+		return linechanged_fd_create(gdev, ip);
 	}
 	return -EINVAL;
 }
@@ -1499,6 +1710,8 @@ int gpiochip_add_data_with_key(struct gpio_chip *chip, void *data,
 	for (i = 0; i < chip->ngpio; i++)
 		gdev->descs[i].gdev = gdev;
 
+	ATOMIC_INIT_NOTIFIER_HEAD(&gdev->notifier);
+
 #ifdef CONFIG_PINCTRL
 	INIT_LIST_HEAD(&gdev->pin_ranges);
 #endif
@@ -2837,6 +3050,8 @@ static int gpiod_request_commit(struct gpio_desc *desc, const char *label)
 		spin_lock_irqsave(&gpio_lock, flags);
 	}
 done:
+	atomic_notifier_call_chain(&desc->gdev->notifier,
+				   GPIOLINE_CHANGED_REQUESTED, desc);
 	spin_unlock_irqrestore(&gpio_lock, flags);
 	return ret;
 }
@@ -2934,6 +3149,8 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 		ret = true;
 	}
 
+	atomic_notifier_call_chain(&desc->gdev->notifier,
+				   GPIOLINE_CHANGED_RELEASED, desc);
 	spin_unlock_irqrestore(&gpio_lock, flags);
 	return ret;
 }
@@ -3097,6 +3314,7 @@ static int gpio_set_bias(struct gpio_chip *chip, struct gpio_desc *desc)
 		if (ret != -ENOTSUPP)
 			return ret;
 	}
+
 	return 0;
 }
 
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index a1cbeabadc69..8e3969616cfe 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -54,6 +54,7 @@ struct gpio_device {
 	const char		*label;
 	void			*data;
 	struct list_head        list;
+	struct atomic_notifier_head notifier;
 
 #ifdef CONFIG_PINCTRL
 	/*
diff --git a/include/uapi/linux/gpio.h b/include/uapi/linux/gpio.h
index 799cf823d493..c61429467dd4 100644
--- a/include/uapi/linux/gpio.h
+++ b/include/uapi/linux/gpio.h
@@ -59,6 +59,40 @@ struct gpioline_info {
 /* Maximum number of requested handles */
 #define GPIOHANDLES_MAX 64
 
+/**
+ * struct gpioline_changed_fd_request - Information about a linechanged fd
+ * request
+ * @lineoffsets: an array of desired lines, specified by offset index for the
+ * associated GPIO device
+ * @num_lines: number of lines requested in this request, i.e. the number of
+ * valid fields in the above arrays, set to 1 to request a single line
+ * @fd: if successful this field will contain a valid anonymous file handle
+ */
+struct gpioline_changed_fd_request {
+	__u32 lineoffsets[GPIOHANDLES_MAX];
+	__u32 num_lines;
+	int fd;
+};
+
+/* Possible line status change events */
+enum {
+	GPIOLINE_CHANGED_REQUESTED = 1,
+	GPIOLINE_CHANGED_RELEASED,
+	GPIOLINE_CHANGED_CONFIG,
+};
+
+/**
+ * struct gpioline_changed - Information about a change in status
+ * of a GPIO line
+ * @line_offset: offset of the line that changed relative to the gpiochip
+ * @event_type: one of GPIOLINE_CHANGED_REQUESTED, GPIOLINE_CHANGED_RELEASED
+ * and GPIOLINE_CHANGED_CONFIG
+ */
+struct gpioline_changed {
+	__u32 line_offset;
+	__u32 event_type;
+};
+
 /* Linerequest flags */
 #define GPIOHANDLE_REQUEST_INPUT	(1UL << 0)
 #define GPIOHANDLE_REQUEST_OUTPUT	(1UL << 1)
@@ -176,6 +210,8 @@ struct gpioevent_data {
 
 #define GPIO_GET_CHIPINFO_IOCTL _IOR(0xB4, 0x01, struct gpiochip_info)
 #define GPIO_GET_LINEINFO_IOCTL _IOWR(0xB4, 0x02, struct gpioline_info)
+#define GPIO_GET_LINECHANGED_FD_IOCTL \
+		_IOWR(0xB4, 0x0b, struct gpioline_changed_fd_request)
 #define GPIO_GET_LINEHANDLE_IOCTL _IOWR(0xB4, 0x03, struct gpiohandle_request)
 #define GPIO_GET_LINEEVENT_IOCTL _IOWR(0xB4, 0x04, struct gpioevent_request)
 
-- 
2.23.0

