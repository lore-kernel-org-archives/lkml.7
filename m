Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E6AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBB420714
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nffuJSQG";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="ZF+jcD3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfKVKHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:07:07 -0500
Received: from a27-56.smtp-out.us-west-2.amazonses.com ([54.240.27.56]:45892
        "EHLO a27-56.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726568AbfKVKHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574417225;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=7u9hsnpcjlcApIq9QCZIdANWz5eWr5Ssz4EJpyZA6uM=;
        b=nffuJSQG3QqW0NxwulZv2/IzWSye6/fjLWQnxZc7kYCUIMuMbIE9kQ1JhNo/r29v
        TsmpBqvKRacZrtLfn8jM1pMcw2PpvLauaRtQ7hLM8SYDZKH/UjD+tiUybYAJz1hQo/v
        jjhgmOe5AlDLyuPzv8jiCz5m3Tsm/JDMWSbfh/TU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574417225;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=7u9hsnpcjlcApIq9QCZIdANWz5eWr5Ssz4EJpyZA6uM=;
        b=ZF+jcD3aZRrclafVvgo89E+r7ttXCGxgu67BJIl1h0A5t/Fz8y//w23I0o+nVkUJ
        9q0C3mZJ1aJL0kQwH420M67zyxg7A4xHKKrNS0HxMUfMQ4KVL7KsNjm0f/8Fcuw8gUm
        Abl2HTgA/RJTkn1aKlzdyhNNNQWrJ+/XuPC22+68=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A47C5C342D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [RESEND PATCH V4 4/4] rpmsg: char: Add signal callback and POLLPRI support
Date:   Fri, 22 Nov 2019 10:07:05 +0000
Message-ID: <0101016e92945567-e776b6a7-b9c4-4ccb-8737-dd9a56bc8e07-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1574417197-27817-1-git-send-email-aneela@codeaurora.org>
References: <1574417197-27817-1-git-send-email-aneela@codeaurora.org>
X-SES-Outgoing: 2019.11.22-54.240.27.56
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a callback to get the signal notifications from rpmsg and
send POLLPRI mask to indicate the signal change in POLL system call.

Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_char.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
index 07bce51..8446c0b 100644
--- a/drivers/rpmsg/rpmsg_char.c
+++ b/drivers/rpmsg/rpmsg_char.c
@@ -64,6 +64,7 @@ struct rpmsg_ctrldev {
  * @queue_lock:	synchronization of @queue operations
  * @queue:	incoming message queue
  * @readq:	wait object for incoming queue
+ * @sig_pending:state of signal notification
  */
 struct rpmsg_eptdev {
 	struct device dev;
@@ -78,6 +79,8 @@ struct rpmsg_eptdev {
 	spinlock_t queue_lock;
 	struct sk_buff_head queue;
 	wait_queue_head_t readq;
+
+	bool sig_pending;
 };
 
 static int rpmsg_eptdev_destroy(struct device *dev, void *data)
@@ -122,6 +125,18 @@ static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
 	return 0;
 }
 
+static int rpmsg_sigs_cb(struct rpmsg_device *rpdev, void *priv,
+			 u32 old, u32 new)
+{
+	struct rpmsg_eptdev *eptdev = priv;
+
+	eptdev->sig_pending = true;
+
+	/* wake up any blocking processes, waiting for signal notification */
+	wake_up_interruptible(&eptdev->readq);
+	return 0;
+}
+
 static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 {
 	struct rpmsg_eptdev *eptdev = cdev_to_eptdev(inode->i_cdev);
@@ -138,6 +153,7 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
 		return -EINVAL;
 	}
 
+	ept->sig_cb = rpmsg_sigs_cb;
 	eptdev->ept = ept;
 	filp->private_data = eptdev;
 
@@ -157,6 +173,7 @@ static int rpmsg_eptdev_release(struct inode *inode, struct file *filp)
 		eptdev->ept = NULL;
 	}
 	mutex_unlock(&eptdev->ept_lock);
+	eptdev->sig_pending = false;
 
 	/* Discard all SKBs */
 	while (!skb_queue_empty(&eptdev->queue)) {
@@ -268,6 +285,9 @@ static __poll_t rpmsg_eptdev_poll(struct file *filp, poll_table *wait)
 	if (!skb_queue_empty(&eptdev->queue))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
+	if (eptdev->sig_pending)
+		mask |= POLLPRI;
+
 	mask |= rpmsg_poll(eptdev->ept, filp, wait);
 
 	return mask;
@@ -311,6 +331,7 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
 
 	switch (cmd) {
 	case TIOCMGET:
+		eptdev->sig_pending = false;
 		ret = rpmsg_get_signals(eptdev->ept);
 		if (ret >= 0)
 			ret = put_user(ret, (int __user *)arg);
-- 
1.9.1

