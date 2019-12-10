Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD861C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9F520828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 16:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="IIsAjOb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfLJQk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 11:40:28 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:39864 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbfLJQk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 11:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1575996020; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oHIHumJmVtEPcfAf/Z9Ju7ihtGPsBSI1g15WabA/CLA=;
        b=IIsAjOb/nO4cGC29QUS3NZv30/UtHHKPfJurqZdAKh5YtqqltZrSbxow5DQX/CDteajlhi
        VfskX8vL+erSEDtS3ekEqBni2HQeYToO/RKLsmLiUnX2aWFlbPB84oFsN4RKgz8tTqiEgH
        kkTahYrdUmgUqBMKrbTjx6SwFT7L+Sc=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 2/5] remoteproc: Add device-managed variants of rproc_alloc/rproc_add
Date:   Tue, 10 Dec 2019 17:40:11 +0100
Message-Id: <20191210164014.50739-2-paul@crapouillou.net>
In-Reply-To: <20191210164014.50739-1-paul@crapouillou.net>
References: <20191210164014.50739-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add API functions devm_rproc_alloc() and devm_rproc_add(), which behave
like rproc_alloc() and rproc_add() respectively, but register their
respective cleanup function to be called on driver detach.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v3: New patch
    v4: No change

 drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++++++++++
 include/linux/remoteproc.h           |  5 +++
 2 files changed, 72 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 307df98347ba..0a9fc7fdd1c3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1932,6 +1932,33 @@ int rproc_add(struct rproc *rproc)
 }
 EXPORT_SYMBOL(rproc_add);
 
+static void devm_rproc_remove(void *rproc)
+{
+	rproc_del(rproc);
+}
+
+/**
+ * devm_rproc_add() - resource managed rproc_add()
+ * @dev: the underlying device
+ * @rproc: the remote processor handle to register
+ *
+ * This function performs like rproc_add() but the registered rproc device will
+ * automatically be removed on driver detach.
+ *
+ * Returns 0 on success and an appropriate error code otherwise.
+ */
+int devm_rproc_add(struct device *dev, struct rproc *rproc)
+{
+	int err;
+
+	err = rproc_add(rproc);
+	if (err)
+		return err;
+
+	return devm_add_action_or_reset(dev, devm_rproc_remove, rproc);
+}
+EXPORT_SYMBOL(devm_rproc_add);
+
 /**
  * rproc_type_release() - release a remote processor instance
  * @dev: the rproc's device
@@ -2149,6 +2176,46 @@ int rproc_del(struct rproc *rproc)
 }
 EXPORT_SYMBOL(rproc_del);
 
+static void devm_rproc_free(struct device *dev, void *res)
+{
+	rproc_free(*(struct rproc **)res);
+}
+
+/**
+ * devm_rproc_alloc() - resource managed rproc_alloc()
+ * @dev: the underlying device
+ * @name: name of this remote processor
+ * @ops: platform-specific handlers (mainly start/stop)
+ * @firmware: name of firmware file to load, can be NULL
+ * @len: length of private data needed by the rproc driver (in bytes)
+ *
+ * This function performs like rproc_alloc() but the acuired rproc device will
+ * automatically be released on driver detach.
+ *
+ * On success the new rproc is returned, and on failure, NULL.
+ */
+struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
+			       const struct rproc_ops *ops,
+			       const char *firmware, int len)
+{
+	struct rproc **ptr, *rproc;
+
+	ptr = devres_alloc(devm_rproc_free, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	rproc = rproc_alloc(dev, name, ops, firmware, len);
+	if (rproc) {
+		*ptr = rproc;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return rproc;
+}
+EXPORT_SYMBOL(devm_rproc_alloc);
+
 /**
  * rproc_add_subdev() - add a subdevice to a remoteproc
  * @rproc: rproc handle to add the subdevice to
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad66683ad0..5f201f0c86c3 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -595,6 +595,11 @@ int rproc_add(struct rproc *rproc);
 int rproc_del(struct rproc *rproc);
 void rproc_free(struct rproc *rproc);
 
+struct rproc *devm_rproc_alloc(struct device *dev, const char *name,
+			       const struct rproc_ops *ops,
+			       const char *firmware, int len);
+int devm_rproc_add(struct device *dev, struct rproc *rproc);
+
 void rproc_add_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
 
 struct rproc_mem_entry *
-- 
2.24.0

