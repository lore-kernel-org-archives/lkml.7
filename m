Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCF4C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DAC2214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380429;
	bh=Bd8Qequ8n2mZaBqAuBld6JpPLMWGNs9uxKxrnYRPmAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Re9VoAEOA/G2xhuQmZatE1AgUT7dFsD5jbp2t19flp+VdK6cwN+0Fze4LVKijrA/O
	 pXZg9ApMRV/0TztZy1PfR4HYCcyBFqlth0c5kMoh70IoctQPlynaMcwPNJiyo+2ODB
	 KD9IJMKx58DOq2HE0vO8YKnfENsHUhsPWOLG5f0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbfIMNNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:13:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389375AbfIMNNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:13:43 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5241720CC7;
        Fri, 13 Sep 2019 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380422;
        bh=Bd8Qequ8n2mZaBqAuBld6JpPLMWGNs9uxKxrnYRPmAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4QLQQxPd/aHBhfdFYZ0X2z4R7ujVMn54BNEijbv2pWPJzfj7oh1MI+qqQTLjHTUq
         tI+9lJDZhBceIvbqdUpkKp+j7leEoklDRC0JHyXaegN1xGZ+LSrnjguoukxX6hCkW1
         RCQjVjZtENw00CleRi9gL75H2XsvztO+tPRSIcqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/190] media: vim2m: use workqueue
Date:   Fri, 13 Sep 2019 14:05:15 +0100
Message-Id: <20190913130604.552595407@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 144bd0ee304c7d0690eec285aee93019d3f30fc8 ]

v4l2_ctrl uses mutexes, so we can't setup a ctrl_handler in
interrupt context. Switch to a workqueue instead and drop the timer.

Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vim2m.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/vim2m.c b/drivers/media/platform/vim2m.c
index 462099a141e4a..6f87ef025ff19 100644
--- a/drivers/media/platform/vim2m.c
+++ b/drivers/media/platform/vim2m.c
@@ -3,7 +3,8 @@
  *
  * This is a virtual device driver for testing mem-to-mem videobuf framework.
  * It simulates a device that uses memory buffers for both source and
- * destination, processes the data and issues an "irq" (simulated by a timer).
+ * destination, processes the data and issues an "irq" (simulated by a delayed
+ * workqueue).
  * The device is capable of multi-instance, multi-buffer-per-transaction
  * operation (via the mem2mem framework).
  *
@@ -19,7 +20,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/fs.h>
-#include <linux/timer.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 
@@ -148,7 +148,7 @@ struct vim2m_dev {
 	struct mutex		dev_mutex;
 	spinlock_t		irqlock;
 
-	struct timer_list	timer;
+	struct delayed_work	work_run;
 
 	struct v4l2_m2m_dev	*m2m_dev;
 };
@@ -336,12 +336,6 @@ static int device_process(struct vim2m_ctx *ctx,
 	return 0;
 }
 
-static void schedule_irq(struct vim2m_dev *dev, int msec_timeout)
-{
-	dprintk(dev, "Scheduling a simulated irq\n");
-	mod_timer(&dev->timer, jiffies + msecs_to_jiffies(msec_timeout));
-}
-
 /*
  * mem2mem callbacks
  */
@@ -387,13 +381,14 @@ static void device_run(void *priv)
 
 	device_process(ctx, src_buf, dst_buf);
 
-	/* Run a timer, which simulates a hardware irq  */
-	schedule_irq(dev, ctx->transtime);
+	/* Run delayed work, which simulates a hardware irq  */
+	schedule_delayed_work(&dev->work_run, msecs_to_jiffies(ctx->transtime));
 }
 
-static void device_isr(struct timer_list *t)
+static void device_work(struct work_struct *w)
 {
-	struct vim2m_dev *vim2m_dev = from_timer(vim2m_dev, t, timer);
+	struct vim2m_dev *vim2m_dev =
+		container_of(w, struct vim2m_dev, work_run.work);
 	struct vim2m_ctx *curr_ctx;
 	struct vb2_v4l2_buffer *src_vb, *dst_vb;
 	unsigned long flags;
@@ -805,6 +800,7 @@ static void vim2m_stop_streaming(struct vb2_queue *q)
 	struct vb2_v4l2_buffer *vbuf;
 	unsigned long flags;
 
+	flush_scheduled_work();
 	for (;;) {
 		if (V4L2_TYPE_IS_OUTPUT(q->type))
 			vbuf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
@@ -1015,6 +1011,7 @@ static int vim2m_probe(struct platform_device *pdev)
 	vfd = &dev->vfd;
 	vfd->lock = &dev->dev_mutex;
 	vfd->v4l2_dev = &dev->v4l2_dev;
+	INIT_DELAYED_WORK(&dev->work_run, device_work);
 
 	ret = video_register_device(vfd, VFL_TYPE_GRABBER, 0);
 	if (ret) {
@@ -1026,7 +1023,6 @@ static int vim2m_probe(struct platform_device *pdev)
 	v4l2_info(&dev->v4l2_dev,
 			"Device registered as /dev/video%d\n", vfd->num);
 
-	timer_setup(&dev->timer, device_isr, 0);
 	platform_set_drvdata(pdev, dev);
 
 	dev->m2m_dev = v4l2_m2m_init(&m2m_ops);
@@ -1083,7 +1079,6 @@ static int vim2m_remove(struct platform_device *pdev)
 	media_device_cleanup(&dev->mdev);
 #endif
 	v4l2_m2m_release(dev->m2m_dev);
-	del_timer_sync(&dev->timer);
 	video_unregister_device(&dev->vfd);
 	v4l2_device_unregister(&dev->v4l2_dev);
 
-- 
2.20.1



