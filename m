Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AF8C2BC73
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A3BB2086D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="rmBYXtdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfLDP7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:59:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45364 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbfLDP7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:59:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so9179386wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CdsiFTfek5xLI09RRog+58+WxPNQjw5a0l6zl3ADLU8=;
        b=rmBYXtduNWBjbJdBB+q6r8IPnN9IU+yx+mQDtMjrL6H4bTPot1sIMDnhXMoAJg8zR1
         MWtQXlxfH1Lo+XbbhWyVrezj+c8MS5InDMMXyMEkMFKiwiZ3jxn214vTKImaqO814FHS
         ML5WqrnkJaDMVU9EvxqemBXs7quBnEfMdz5rpNlXNxspdd7N4Zhtx0W5Gl4Vl9iTlrzr
         aBB+6xVLC+Rg2FJcTlkkgXyzMHveem+THF9aBXQo0fvoq/AKIQQzXLt0DGSaP7mnrVHf
         qs4X4sIz7Ylf3KCih22Pl+za7oHFWJuoNuREYki9j/GxBoQ9+9uuthx2b2ud7hAR9iyI
         bRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CdsiFTfek5xLI09RRog+58+WxPNQjw5a0l6zl3ADLU8=;
        b=kfoc0g6lDLNtVLiSfBbQp8QnWZNaTlUSgTuEBs0tJuLTUTth+cJbCN/UagC96E6efU
         zcxuklqC8KKryzODq+AzqM/5mmjL6f2K/xqsPhjGzsDI3zABemSwZ/qsam/yU+IveMDc
         om8L5rb+0U5R1eVx8hVXeqQ16kv3C4A4sjdsFhlbOSytvzGaw79MX3qwxMOjdk4jHq4Y
         4s+7putYfSggzmGluqsFq3icwAAdF4PqyX27fWy8O9wnrJnjKmilm4BZC4VN0e1eGQJ7
         JXgBzQ9nnWjj6oRISDFWQRuPz+qRcbMH9ZJ1D2/qQJeNfo7+w6ZL9I52u11horjApzrq
         UMQA==
X-Gm-Message-State: APjAAAXWcJrK27audmeQbEsQIaeIo17kO8JOI7blkgBX6KnyMtMiCrLL
        3OhmZRsanr/3QSg84Mi5Ovwmkg==
X-Google-Smtp-Source: APXvYqzgSN35FsKw+z4ACL3rPKUl4UEmfcPcuA9exxMvkFs/K/t3RLZn3dchtV+0t9ZL9bpN7xdjUg==
X-Received: by 2002:adf:ec48:: with SMTP id w8mr4976853wrn.19.1575475167360;
        Wed, 04 Dec 2019 07:59:27 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id u18sm8640508wrt.26.2019.12.04.07.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 07:59:26 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 07/11] gpiolib: rework the locking mechanism for lineevent kfifo
Date:   Wed,  4 Dec 2019 16:59:10 +0100
Message-Id: <20191204155912.17590-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191204155912.17590-1-brgl@bgdev.pl>
References: <20191204155912.17590-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The read_lock mutex is supposed to prevent collisions between reading
and writing to the line event kfifo but it's actually only taken when
the events are being read from it.

Drop the mutex entirely and reuse the spinlock made available to us in
the waitqueue struct. Take the lock whenever the fifo is modified or
inspected. Drop the call to kfifo_to_user() and instead first extract
the new element from kfifo when the lock is taken and only then pass
it on to the user after the spinlock is released.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpiolib.c | 54 ++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index b7043946c029..43f90eca6d45 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -788,8 +788,6 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
  * @irq: the interrupt that trigger in response to events on this GPIO
  * @wait: wait queue that handles blocking reads of events
  * @events: KFIFO for the GPIO events
- * @read_lock: mutex lock to protect reads from colliding with adding
- * new events to the FIFO
  * @timestamp: cache for the timestamp storing it between hardirq
  * and IRQ thread, used to bring the timestamp close to the actual
  * event
@@ -802,7 +800,6 @@ struct lineevent_state {
 	int irq;
 	wait_queue_head_t wait;
 	DECLARE_KFIFO(events, struct gpioevent_data, 16);
-	struct mutex read_lock;
 	u64 timestamp;
 };
 
@@ -818,8 +815,10 @@ static __poll_t lineevent_poll(struct file *filep,
 
 	poll_wait(filep, &le->wait, wait);
 
+	spin_lock(&le->wait.lock);
 	if (!kfifo_is_empty(&le->events))
 		events = EPOLLIN | EPOLLRDNORM;
+	spin_unlock(&le->wait.lock);
 
 	return events;
 }
@@ -831,43 +830,47 @@ static ssize_t lineevent_read(struct file *filep,
 			      loff_t *f_ps)
 {
 	struct lineevent_state *le = filep->private_data;
-	unsigned int copied;
+	struct gpioevent_data event;
 	int ret;
 
-	if (count < sizeof(struct gpioevent_data))
+	if (count < sizeof(event))
 		return -EINVAL;
 
-	do {
+	for (;;) {
+		spin_lock(&le->wait.lock);
 		if (kfifo_is_empty(&le->events)) {
-			if (filep->f_flags & O_NONBLOCK)
+			if (filep->f_flags & O_NONBLOCK) {
+				spin_unlock(&le->wait.lock);
 				return -EAGAIN;
+			}
 
-			ret = wait_event_interruptible(le->wait,
+			ret = wait_event_interruptible_locked(le->wait,
 					!kfifo_is_empty(&le->events));
-			if (ret)
+			if (ret) {
+				spin_unlock(&le->wait.lock);
 				return ret;
-		}
+			}
 
-		if (mutex_lock_interruptible(&le->read_lock))
-			return -ERESTARTSYS;
-		ret = kfifo_to_user(&le->events, buf, count, &copied);
-		mutex_unlock(&le->read_lock);
+		}
 
-		if (ret)
-			return ret;
+		ret = kfifo_out(&le->events, &event, 1);
+		spin_unlock(&le->wait.lock);
+		if (ret == 1)
+			break;
 
 		/*
-		 * If we couldn't read anything from the fifo (a different
-		 * thread might have been faster) we either return -EAGAIN if
-		 * the file descriptor is non-blocking, otherwise we go back to
-		 * sleep and wait for more data to arrive.
+		 * We should never get here since we're holding the lock from
+		 * the moment we noticed a new event until calling kfifo_out()
+		 * but we must check the return value. On the off-chance - just
+		 * go back to waiting.
 		 */
-		if (copied == 0 && (filep->f_flags & O_NONBLOCK))
-			return -EAGAIN;
+	}
 
-	} while (copied == 0);
+	ret = copy_to_user(buf, &event, sizeof(event));
+	if (ret)
+		return -EFAULT;
 
-	return copied;
+	return sizeof(event);
 }
 
 static int lineevent_release(struct inode *inode, struct file *filep)
@@ -969,7 +972,7 @@ static irqreturn_t lineevent_irq_thread(int irq, void *p)
 		return IRQ_NONE;
 	}
 
-	ret = kfifo_put(&le->events, ge);
+	ret = kfifo_in_spinlocked(&le->events, &ge, 1, &le->wait.lock);
 	if (ret)
 		wake_up_poll(&le->wait, EPOLLIN);
 
@@ -1084,7 +1087,6 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
 
 	INIT_KFIFO(le->events);
 	init_waitqueue_head(&le->wait);
-	mutex_init(&le->read_lock);
 
 	/* Request a thread to read the events */
 	ret = request_threaded_irq(le->irq,
-- 
2.23.0

