Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE274C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9492070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RkYfRxPO";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HO0ckzgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfKVKG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:06:56 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:44274
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726568AbfKVKG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574417214;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=+qftsKlK2B86/YAVSIckuuC7U5me8Jw9J55AWHA7I5M=;
        b=RkYfRxPOaLS/0vydHS4odbDR7WwiurWK6CgCzmugmaSt+LWnlj7DjwnfLtWVBKUN
        kebdgKsetf3tmIhJnDofdYWdtlzJ4PyhzcrnvXOSmnc7PGnxZnQEjdWgRngYmIJvwih
        B5P79Qk+zmKBiK038Rqb1IGj0gEXc8HsmP3amb0s=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574417214;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=+qftsKlK2B86/YAVSIckuuC7U5me8Jw9J55AWHA7I5M=;
        b=HO0ckzgrrAp44Obw3Ac2KGKFPVJcmPouKpnB0ZxziI5NSZxBPaX6KAiZID4+H/QF
        hFwbIkgXhfaba9rmypCkNqJAGjfTQGgOHtXFrqlcDX+llQtxGhQvVitoYyAX8iUtNG+
        3Qe7NV4hkEHM6xSVCXj/tmRHm7y3Cw7T3EmkHSxI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBA53C447BC
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=aneela@codeaurora.org
From:   Arun Kumar Neelakantam <aneela@codeaurora.org>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arun Kumar Neelakantam <aneela@codeaurora.org>
Subject: [RESEND PATCH V4 1/4] rpmsg: core: Add signal API support
Date:   Fri, 22 Nov 2019 10:06:54 +0000
Message-ID: <0101016e92942d16-9c3095c2-c336-4c23-aed3-709ad4136ad3-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1574417197-27817-1-git-send-email-aneela@codeaurora.org>
References: <1574417197-27817-1-git-send-email-aneela@codeaurora.org>
X-SES-Outgoing: 2019.11.22-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some transports like Glink support the state notifications between
clients using signals similar to serial protocol signals.

Signed-off-by: Chris Lew <clew@codeaurora.org>
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
---
 drivers/rpmsg/rpmsg_core.c     | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/rpmsg/rpmsg_internal.h |  5 +++++
 include/linux/rpmsg.h          | 26 ++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index d6c3275..453790b 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -2,6 +2,7 @@
 /*
  * remote processor messaging bus
  *
+ * Copyright (c) 2018, The Linux Foundation.
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
  *
@@ -283,6 +284,42 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 }
 EXPORT_SYMBOL(rpmsg_trysend_offchannel);
 
+/**
+ * rpmsg_get_signals() - get the signals for this endpoint
+ * @ept:	the rpmsg endpoint
+ *
+ * Returns signal bits on success and an appropriate error value on failure.
+ */
+int rpmsg_get_signals(struct rpmsg_endpoint *ept)
+{
+	if (WARN_ON(!ept))
+		return -EINVAL;
+	if (!ept->ops->get_signals)
+		return -EOPNOTSUPP;
+
+	return ept->ops->get_signals(ept);
+}
+EXPORT_SYMBOL(rpmsg_get_signals);
+
+/**
+ * rpmsg_set_signals() - set the remote signals for this endpoint
+ * @ept:	the rpmsg endpoint
+ * @set:	set mask for signals
+ * @clear:	clear mask for signals
+ *
+ * Returns 0 on success and an appropriate error value on failure.
+ */
+int rpmsg_set_signals(struct rpmsg_endpoint *ept, u32 set, u32 clear)
+{
+	if (WARN_ON(!ept))
+		return -EINVAL;
+	if (!ept->ops->set_signals)
+		return -EOPNOTSUPP;
+
+	return ept->ops->set_signals(ept, set, clear);
+}
+EXPORT_SYMBOL(rpmsg_set_signals);
+
 /*
  * match an rpmsg channel with a channel info struct.
  * this is used to make sure we're not creating rpmsg devices for channels
@@ -468,6 +505,10 @@ static int rpmsg_dev_probe(struct device *dev)
 
 		rpdev->ept = ept;
 		rpdev->src = ept->addr;
+
+		if (rpdrv->signals)
+			ept->sig_cb = rpdrv->signals;
+
 	}
 
 	err = rpdrv->probe(rpdev);
diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index 3fc83cd..8958d6c 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -2,6 +2,7 @@
 /*
  * remote processor messaging bus internals
  *
+ * Copyright (c) 2018, The Linux Foundation.
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
  *
@@ -47,6 +48,8 @@ struct rpmsg_device_ops {
  * @trysendto:		see @rpmsg_trysendto(), optional
  * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
  * @poll:		see @rpmsg_poll(), optional
+ * @get_signals:	see @rpmsg_get_signals(), optional
+ * @set_signals:	see @rpmsg_set_signals(), optional
  *
  * Indirection table for the operations that a rpmsg backend should implement.
  * In addition to @destroy_ept, the backend must at least implement @send and
@@ -66,6 +69,8 @@ struct rpmsg_endpoint_ops {
 			     void *data, int len);
 	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
 			     poll_table *wait);
+	int (*get_signals)(struct rpmsg_endpoint *ept);
+	int (*set_signals)(struct rpmsg_endpoint *ept, u32 set, u32 clear);
 };
 
 int rpmsg_register_device(struct rpmsg_device *rpdev);
diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
index 9fe156d..48c8ae3 100644
--- a/include/linux/rpmsg.h
+++ b/include/linux/rpmsg.h
@@ -2,6 +2,7 @@
 /*
  * Remote processor messaging
  *
+ * Copyright (c) 2018 The Linux Foundation.
  * Copyright (C) 2011 Texas Instruments, Inc.
  * Copyright (C) 2011 Google, Inc.
  * All rights reserved.
@@ -60,6 +61,7 @@ struct rpmsg_device {
 };
 
 typedef int (*rpmsg_rx_cb_t)(struct rpmsg_device *, void *, int, void *, u32);
+typedef int (*rpmsg_rx_sig_t)(struct rpmsg_device *, void *, u32, u32);
 
 /**
  * struct rpmsg_endpoint - binds a local rpmsg address to its user
@@ -67,6 +69,7 @@ struct rpmsg_device {
  * @refcount: when this drops to zero, the ept is deallocated
  * @cb: rx callback handler
  * @cb_lock: must be taken before accessing/changing @cb
+ * @sig_cb: rx serial signal handler
  * @addr: local rpmsg address
  * @priv: private data for the driver's use
  *
@@ -89,6 +92,7 @@ struct rpmsg_endpoint {
 	struct kref refcount;
 	rpmsg_rx_cb_t cb;
 	struct mutex cb_lock;
+	rpmsg_rx_sig_t sig_cb;
 	u32 addr;
 	void *priv;
 
@@ -102,6 +106,7 @@ struct rpmsg_endpoint {
  * @probe: invoked when a matching rpmsg channel (i.e. device) is found
  * @remove: invoked when the rpmsg channel is removed
  * @callback: invoked when an inbound message is received on the channel
+ * @signals: invoked when a serial signal change is received on the channel
  */
 struct rpmsg_driver {
 	struct device_driver drv;
@@ -109,6 +114,7 @@ struct rpmsg_driver {
 	int (*probe)(struct rpmsg_device *dev);
 	void (*remove)(struct rpmsg_device *dev);
 	int (*callback)(struct rpmsg_device *, void *, int, void *, u32);
+	int (*signals)(struct rpmsg_device *, void *, u32, u32);
 };
 
 #if IS_ENABLED(CONFIG_RPMSG)
@@ -135,6 +141,9 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
 __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
 			poll_table *wait);
 
+int rpmsg_get_signals(struct rpmsg_endpoint *ept);
+int rpmsg_set_signals(struct rpmsg_endpoint *ept, u32 set, u32 clear);
+
 #else
 
 static inline int register_rpmsg_device(struct rpmsg_device *dev)
@@ -242,6 +251,23 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
 	return 0;
 }
 
+static inline int rpmsg_get_signals(struct rpmsg_endpoint *ept)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return -ENXIO;
+}
+
+static inline int rpmsg_set_signals(struct rpmsg_endpoint *ept,
+				    u32 set, u32 clear)
+{
+	/* This shouldn't be possible */
+	WARN_ON(1);
+
+	return -ENXIO;
+}
+
 #endif /* IS_ENABLED(CONFIG_RPMSG) */
 
 /* use a macro to avoid include chaining to get THIS_MODULE */
-- 
1.9.1

