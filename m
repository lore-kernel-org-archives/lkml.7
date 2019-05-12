Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4BFC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921452084E
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3klsWCM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfELXkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 19:40:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38375 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELXkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 19:40:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id j26so5783863pgl.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 16:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5ePTpEWgDcOSDGAH32g8BCVncBtJB0/VW+eQtoUEHsQ=;
        b=L3klsWCMw9d5uQTz6imvbsGSjpeIBsgx0Swuaia5KN2LYI0KC4axbT8dAMlbYDAEm2
         TK/OHnQHXyGYtVJECc9zLLHWu6NU3Av+s321uaBNYGHQepRAE1GM5GdgDkfbkQ9Vp3i0
         /LKmN9dUikAFeZszm9oRjk9Bz3uty1+bkwdoDvm+jxy3enynoNWEU49/+xr4K4Ke0JbP
         EqxtS9pUcXCF7V6sidsIJL1t9nUbYNrJ1kQssIbSfEngfSc73nbhVgp1XO8vQ2aDhqW6
         8kQwMOULFGJQeNVjDx2bwhdGPqGYSL+/1SYO6WLZfPRv0ySKPuSIqfk8znpvirIoQKHX
         hmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5ePTpEWgDcOSDGAH32g8BCVncBtJB0/VW+eQtoUEHsQ=;
        b=ZQjX10WyH3DfJlWJGBuY+oje3My7kLfYAhu7c9mWYvksQI4laNlJ3CGXSzHPI7X1yH
         SrHHZ6QqSiJZYb7UflKFGl71a/TynGyYSeQW668frgqi2wL8i9Bzb9be78FaZoMSnOC+
         jP1Dz1Tg8aEScNobleJtnGdCNofBba2enTs5MxIafU/V+7TBNvi13gtEQ/JkB7QKREIT
         8+hfHogmB2H56hzzY1PSlDZOC84I+fWIUi3xNXFBnfmISWS7PX/Bky16vK5cLL1kPZ2H
         nuOmfXh+DFH6PooQpNZBtOoRXpHpCaon6y5Zb9+ZVwps25UXhHk9OfQdnM+2pPQIU/3P
         P7sA==
X-Gm-Message-State: APjAAAXTjiZqYChjxsRvG92VUyGwGvBA3Y+hBIHSUV2TBbM6OqDPetid
        DbERpou5LqAtxRhqrguV8fo=
X-Google-Smtp-Source: APXvYqzPKZL7P9YpPl7Ir0BOuZnxpbdz15zkMlnEVao2/Fa7zZWpdYeKmr7FG5Pls/dHCFoRM9KpWw==
X-Received: by 2002:a63:6884:: with SMTP id d126mr27932552pgc.154.1557704423832;
        Sun, 12 May 2019 16:40:23 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.241.202.125])
        by smtp.gmail.com with ESMTPSA id e29sm13528376pgb.37.2019.05.12.16.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 16:40:23 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v2 2/8] Staging: kpc2000: kpc_dma: Resolve coding style errors reported by checkpatch.
Date:   Mon, 13 May 2019 05:09:54 +0530
Message-Id: <20190512234000.16555-2-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512234000.16555-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190512234000.16555-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves below errors reported by checkpatch
ERROR: "(foo*)" should be "(foo *)"
ERROR: "foo * bar" should be "foo *bar"
ERROR: "foo __init  bar" should be "foo __init bar"
ERROR: "foo __exit  bar" should be "foo __exit bar"

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/dma.c            |  8 ++++----
 drivers/staging/kpc2000/kpc_dma/fileops.c        |  2 +-
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 12 ++++++------
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h |  6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/dma.c b/drivers/staging/kpc2000/kpc_dma/dma.c
index ba987307d898..488b9b81debc 100644
--- a/drivers/staging/kpc2000/kpc_dma/dma.c
+++ b/drivers/staging/kpc2000/kpc_dma/dma.c
@@ -14,7 +14,7 @@
 static
 irqreturn_t  ndd_irq_handler(int irq, void *dev_id)
 {
-	struct kpc_dma_device *ldev = (struct kpc_dma_device*)dev_id;
+	struct kpc_dma_device *ldev = (struct kpc_dma_device *)dev_id;
 
 	if ((GetEngineControl(ldev) & ENG_CTL_IRQ_ACTIVE) || (ldev->desc_completed->MyDMAAddr != GetEngineCompletePtr(ldev)))
 		schedule_work(&ldev->irq_work);
@@ -85,8 +85,8 @@ void  start_dma_engine(struct kpc_dma_device *eng)
 int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 {
 	u32 caps;
-	struct kpc_dma_descriptor * cur;
-	struct kpc_dma_descriptor * next;
+	struct kpc_dma_descriptor *cur;
+	struct kpc_dma_descriptor *next;
 	dma_addr_t next_handle;
 	dma_addr_t head_handle;
 	unsigned int i;
@@ -208,7 +208,7 @@ void  stop_dma_engine(struct kpc_dma_device *eng)
 
 void  destroy_dma_engine(struct kpc_dma_device *eng)
 {
-	struct kpc_dma_descriptor * cur;
+	struct kpc_dma_descriptor *cur;
 	dma_addr_t cur_handle;
 	unsigned int i;
 
diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 6c38c3f978c3..61927b313a26 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -55,7 +55,7 @@ int  kpc_dma_transfer(struct dev_private_data *priv, struct kiocb *kcb, unsigned
 	ldev = priv->ldev;
 	BUG_ON(ldev == NULL);
 
-	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_transfer(priv = [%p], kcb = [%p], iov_base = [%p], iov_len = %ld) ldev = [%p]\n", priv, kcb, (void*)iov_base, iov_len, ldev);
+	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_transfer(priv = [%p], kcb = [%p], iov_base = [%p], iov_len = %ld) ldev = [%p]\n", priv, kcb, (void *)iov_base, iov_len, ldev);
 
 	acd = (struct aio_cb_data *) kzalloc(sizeof(struct aio_cb_data), GFP_KERNEL);
 	if (!acd){
diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index dece60e6e3f3..004d91b5ad00 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -21,7 +21,7 @@ static LIST_HEAD(kpc_dma_list);
 
 
 /**********  kpc_dma_list list management  **********/
-struct kpc_dma_device *  kpc_dma_lookup_device(int minor)
+struct kpc_dma_device *kpc_dma_lookup_device(int minor)
 {
 	struct kpc_dma_device *c;
 	mutex_lock(&kpc_dma_mtx);
@@ -36,14 +36,14 @@ struct kpc_dma_device *  kpc_dma_lookup_device(int minor)
 	return c;
 }
 
-void  kpc_dma_add_device(struct kpc_dma_device * ldev)
+void  kpc_dma_add_device(struct kpc_dma_device *ldev)
 {
 	mutex_lock(&kpc_dma_mtx);
 	list_add(&ldev->list, &kpc_dma_list);
 	mutex_unlock(&kpc_dma_mtx);
 }
 
-void kpc_dma_del_device(struct kpc_dma_device * ldev)
+void kpc_dma_del_device(struct kpc_dma_device *ldev)
 {
 	mutex_lock(&kpc_dma_mtx);
 	list_del(&ldev->list);
@@ -80,7 +80,7 @@ static ssize_t  show_engine_regs(struct device *dev, struct device_attribute *at
 }
 DEVICE_ATTR(engine_regs, 0444, show_engine_regs, NULL);
 
-static const struct attribute *  ndd_attr_list[] = {
+static const struct attribute *ndd_attr_list[] = {
 	&dev_attr_engine_regs.attr,
 	NULL,
 };
@@ -203,7 +203,7 @@ struct platform_driver kpc_dma_plat_driver_i = {
 };
 
 static
-int __init  kpc_dma_driver_init(void)
+int __init kpc_dma_driver_init(void)
 {
 	int err;
 
@@ -239,7 +239,7 @@ int __init  kpc_dma_driver_init(void)
 module_init(kpc_dma_driver_init);
 
 static
-void __exit  kpc_dma_driver_exit(void)
+void __exit kpc_dma_driver_exit(void)
 {
 	platform_driver_unregister(&kpc_dma_plat_driver_i);
 	class_destroy(kpc_dma_class);
diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
index 67c0ea31acab..8101601736a2 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
@@ -56,7 +56,7 @@ struct dev_private_data {
 	u64                         user_sts;
 };
 
-struct kpc_dma_device *  kpc_dma_lookup_device(int minor);
+struct kpc_dma_device *kpc_dma_lookup_device(int minor);
 
 extern struct file_operations  kpc_dma_fops;
 
@@ -172,12 +172,12 @@ void  SetClearEngineControl(struct kpc_dma_device *eng, u32 set_bits, u32 clear_
 }
 
 static inline
-void  SetEngineNextPtr(struct kpc_dma_device *eng, struct kpc_dma_descriptor * desc)
+void  SetEngineNextPtr(struct kpc_dma_device *eng, struct kpc_dma_descriptor *desc)
 {
 	writel(desc->MyDMAAddr, eng->eng_regs + 2);
 }
 static inline
-void  SetEngineSWPtr(struct kpc_dma_device *eng, struct kpc_dma_descriptor * desc)
+void  SetEngineSWPtr(struct kpc_dma_device *eng, struct kpc_dma_descriptor *desc)
 {
 	writel(desc->MyDMAAddr, eng->eng_regs + 3);
 }
-- 
2.17.1

