Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96670C46460
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEF9208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 23:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qB/y0p4c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfELXkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 19:40:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41937 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELXko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 19:40:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id l132so6154028pfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 16:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LNVIn/bEhLUK18Rhnoam0doZR6AF6d7xiD4N7C/Vzng=;
        b=qB/y0p4cDhSAH/SiVyS38DeTT4J+U/kGyAXydyTXwIk0G+9NzI9ngEhM1GV3xZJOfJ
         74+WZWaVvYXRZXcV3L/vUZhZ+1oFX72+icAJcavUJsrafpf6wFdNX5wLKzw93CLBS5mi
         mAybFi7zuYh8VYe44MsBD7hK/0V3dHXM0NozfG8Xuu25swOM22m3lgGaxGhtPww71721
         j+DfHJP5bBDq2HjeI27z5VyLXmdEm8sqbEm7ireV7j9hAcqHhmA6VcQnQNd06t3iNjlA
         442j+ZuP/fMwZVN3gaqh3O7plRS5Vdu2298VwOiKCNrl7NuZu40ra5AWwkT0rciP95y2
         XzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LNVIn/bEhLUK18Rhnoam0doZR6AF6d7xiD4N7C/Vzng=;
        b=IIcBBPUkIPXd3pcz0sZZZOuvHS8epzeai9FpO3B1JMVAVUrUlEsUdShnZ5Cwa3t169
         Sys6AdGCszndF35Q0Mh8Dh+Dn81Ukw363exRVrYM8D+Qt5w9fqULXdCocUgACFzKatrV
         tn3hB9eI/Fv1Vr5ZJE71gM/1DhIuW6hxwJyzimQfrDkKWs51t6ayVGeamQ5RQjrKMpcS
         qsBo5xKhdAOziE3WyixnLRlcRLCk3Qe+bNUCiB6iBHvnB9/fCtw9qSony4mBMWgDaJRT
         0Wv1vfLmmpi2HWdgz837g8Qkp6xJJUBjsHd4qHJXliUowguKttqLSnupyNuLhb/a0UQt
         Nnkg==
X-Gm-Message-State: APjAAAV9I7GgL/F3oCOIGzdF9pRlQIVk6yojSrOsu7YtURZpZ/MerU91
        li6nnQqBZVOsHFRjly7omEIH86t3wQ8=
X-Google-Smtp-Source: APXvYqzlBX4XyCW9VcN9bSvnGobUeez0nH2jCuGzWUQiSgVdQ9j3IkkRDMQvzZFyqS2SCKaxtKj8qQ==
X-Received: by 2002:a62:2703:: with SMTP id n3mr29672375pfn.199.1557704443172;
        Sun, 12 May 2019 16:40:43 -0700 (PDT)
Received: from bnva-HP-Pavilion-g6-Notebook-PC.domain.name ([117.241.202.125])
        by smtp.gmail.com with ESMTPSA id e29sm13528376pgb.37.2019.05.12.16.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 16:40:42 -0700 (PDT)
From:   Vandana BN <bnvandana@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vandana BN <bnvandana@gmail.com>
Subject: [PATCH v2 6/8] Staging: kpc2000: kpc_dma: Resolve coding style warning reported by checkpatch
Date:   Mon, 13 May 2019 05:09:58 +0530
Message-Id: <20190512234000.16555-6-bnvandana@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190512234000.16555-1-bnvandana@gmail.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190512234000.16555-1-bnvandana@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resloves below warnings reported by checkpath in kpc_dma
WARNING: Missing a blank line after declarations
WARNING: labels should not be indented
CHECK: Please don't use multiple blank lines
CHECK: Please use a blank line after function/struct/union/enum
declarations

Signed-off-by: Vandana BN <bnvandana@gmail.com>
---
 drivers/staging/kpc2000/kpc_dma/dma.c            |  8 +++++---
 drivers/staging/kpc2000/kpc_dma/fileops.c        | 11 ++++++++++-
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c | 15 ++++++++-------
 drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h |  8 ++++++--
 4 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/dma.c b/drivers/staging/kpc2000/kpc_dma/dma.c
index 2053316009bc..ac842fa38c64 100644
--- a/drivers/staging/kpc2000/kpc_dma/dma.c
+++ b/drivers/staging/kpc2000/kpc_dma/dma.c
@@ -27,6 +27,7 @@ void  ndd_irq_worker(struct work_struct *ws)
 {
 	struct kpc_dma_descriptor *cur;
 	struct kpc_dma_device *eng = container_of(ws, struct kpc_dma_device, irq_work);
+
 	lock_engine(eng);
 
 	if (GetEngineCompletePtr(eng) == 0)
@@ -67,7 +68,6 @@ void  ndd_irq_worker(struct work_struct *ws)
 	unlock_engine(eng);
 }
 
-
 /**********  DMA Engine Init/Teardown  **********/
 void  start_dma_engine(struct kpc_dma_device *eng)
 {
@@ -91,6 +91,7 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 	dma_addr_t head_handle;
 	unsigned int i;
 	int rv;
+
 	dev_dbg(&eng->pldev->dev, "Setting up DMA engine [%p]\n", eng);
 
 	caps = GetEngineCapabilities(eng);
@@ -159,6 +160,7 @@ int  setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt)
 void  stop_dma_engine(struct kpc_dma_device *eng)
 {
 	unsigned long timeout;
+
 	dev_dbg(&eng->pldev->dev, "Destroying DMA engine [%p]\n", eng);
 
 	// Disable the descriptor engine
@@ -220,6 +222,7 @@ void  destroy_dma_engine(struct kpc_dma_device *eng)
 	for (i = 0 ; i < eng->desc_pool_cnt ; i++) {
 		struct kpc_dma_descriptor *next = cur->Next;
 		dma_addr_t next_handle = cur->DescNextDescPtr;
+
 		dma_pool_free(eng->desc_pool, cur, cur_handle);
 		cur_handle = next_handle;
 		cur = next;
@@ -230,13 +233,12 @@ void  destroy_dma_engine(struct kpc_dma_device *eng)
 	free_irq(eng->irq, eng);
 }
 
-
-
 /**********  Helper Functions  **********/
 int  count_descriptors_available(struct kpc_dma_device *eng)
 {
 	u32 count = 0;
 	struct kpc_dma_descriptor *cur = eng->desc_next;
+
 	while (cur != eng->desc_completed) {
 		BUG_ON(cur == NULL);
 		count++;
diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index c09147aaa4ef..13c0e532437e 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -21,6 +21,7 @@ unsigned int  count_pages(unsigned long iov_base, size_t iov_len)
 {
 	unsigned long first = (iov_base             & PAGE_MASK) >> PAGE_SHIFT;
 	unsigned long last  = ((iov_base+iov_len-1) & PAGE_MASK) >> PAGE_SHIFT;
+
 	return last - first + 1;
 }
 
@@ -28,6 +29,7 @@ static inline
 unsigned int  count_parts_for_sge(struct scatterlist *sg)
 {
 	unsigned int sg_length = sg_dma_len(sg);
+
 	sg_length += (0x80000-1);
 	return (sg_length / 0x80000);
 }
@@ -262,6 +264,7 @@ int  kpc_dma_open(struct inode *inode, struct file *filp)
 {
 	struct dev_private_data *priv;
 	struct kpc_dma_device *ldev = kpc_dma_lookup_device(iminor(inode));
+
 	if (ldev == NULL)
 		return -ENODEV;
 
@@ -287,6 +290,7 @@ int  kpc_dma_close(struct inode *inode, struct file *filp)
 	struct kpc_dma_descriptor *cur;
 	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
 	struct kpc_dma_device *eng = priv->ldev;
+
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_close(inode = [%p], filp = [%p]) priv = [%p], ldev = [%p]\n", inode, filp, priv, priv->ldev);
 
 	lock_engine(eng);
@@ -321,6 +325,7 @@ static
 int  kpc_dma_aio_cancel(struct kiocb *kcb)
 {
 	struct dev_private_data *priv = (struct dev_private_data *)kcb->ki_filp->private_data;
+
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_aio_cancel(kcb = [%p]) priv = [%p], ldev = [%p]\n", kcb, priv, priv->ldev);
 	return 0;
 }
@@ -329,6 +334,7 @@ static
 ssize_t   kpc_dma_aio_read(struct kiocb *kcb, const struct iovec *iov, unsigned long iov_count, loff_t pos)
 {
 	struct dev_private_data *priv = (struct dev_private_data *)kcb->ki_filp->private_data;
+
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_aio_read(kcb = [%p], iov = [%p], iov_count = %ld, pos = %lld) priv = [%p], ldev = [%p]\n", kcb, iov, iov_count, pos, priv, priv->ldev);
 
 	if (priv->ldev->dir != DMA_FROM_DEVICE)
@@ -348,6 +354,7 @@ static
 ssize_t  kpc_dma_aio_write(struct kiocb *kcb, const struct iovec *iov, unsigned long iov_count, loff_t pos)
 {
 	struct dev_private_data *priv = (struct dev_private_data *)kcb->ki_filp->private_data;
+
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_aio_write(kcb = [%p], iov = [%p], iov_count = %ld, pos = %lld) priv = [%p], ldev = [%p]\n", kcb, iov, iov_count, pos, priv, priv->ldev);
 
 	if (priv->ldev->dir != DMA_TO_DEVICE)
@@ -368,6 +375,7 @@ static
 ssize_t  kpc_dma_read(struct file *filp,       char __user *user_buf, size_t count, loff_t *ppos)
 {
 	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
+
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_read(filp = [%p], user_buf = [%p], count = %zu, ppos = [%p]) priv = [%p], ldev = [%p]\n", filp, user_buf, count, ppos, priv, priv->ldev);
 
 	if (priv->ldev->dir != DMA_FROM_DEVICE)
@@ -380,6 +388,7 @@ static
 ssize_t  kpc_dma_write(struct file *filp, const char __user *user_buf, size_t count, loff_t *ppos)
 {
 	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
+
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_write(filp = [%p], user_buf = [%p], count = %zu, ppos = [%p]) priv = [%p], ldev = [%p]\n", filp, user_buf, count, ppos, priv, priv->ldev);
 
 	if (priv->ldev->dir != DMA_TO_DEVICE)
@@ -392,6 +401,7 @@ static
 long  kpc_dma_ioctl(struct file *filp, unsigned int ioctl_num, unsigned long ioctl_param)
 {
 	struct dev_private_data *priv = (struct dev_private_data *)filp->private_data;
+
 	dev_dbg(&priv->ldev->pldev->dev, "kpc_dma_ioctl(filp = [%p], ioctl_num = 0x%x, ioctl_param = 0x%lx) priv = [%p], ldev = [%p]\n", filp, ioctl_num, ioctl_param, priv, priv->ldev);
 
 	switch (ioctl_num) {
@@ -408,7 +418,6 @@ long  kpc_dma_ioctl(struct file *filp, unsigned int ioctl_num, unsigned long ioc
 	return -ENOTTY;
 }
 
-
 struct file_operations  kpc_dma_fops = {
 	.owner      = THIS_MODULE,
 	.open           = kpc_dma_open,
diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
index e996ced77bd6..135428e62f8e 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.c
@@ -19,11 +19,11 @@ static DEFINE_MUTEX(kpc_dma_mtx);
 static int assigned_major_num;
 static LIST_HEAD(kpc_dma_list);
 
-
 /**********  kpc_dma_list list management  **********/
 struct kpc_dma_device *kpc_dma_lookup_device(int minor)
 {
 	struct kpc_dma_device *c;
+
 	mutex_lock(&kpc_dma_mtx);
 	list_for_each_entry(c, &kpc_dma_list, list) {
 		if (c->pldev->id == minor) {
@@ -31,7 +31,7 @@ struct kpc_dma_device *kpc_dma_lookup_device(int minor)
 		}
 	}
 	c = NULL; // not-found case
-  out:
+out:
 	mutex_unlock(&kpc_dma_mtx);
 	return c;
 }
@@ -55,6 +55,7 @@ static ssize_t  show_engine_regs(struct device *dev, struct device_attribute *at
 {
 	struct kpc_dma_device *ldev;
 	struct platform_device *pldev = to_platform_device(dev);
+
 	if (!pldev)
 		return 0;
 	ldev = platform_get_drvdata(pldev);
@@ -89,7 +90,6 @@ static const struct attribute *ndd_attr_list[] = {
 
 struct class *kpc_dma_class;
 
-
 /**********  Platform Driver Functions  **********/
 static
 int  kpc_dma_probe(struct platform_device *pldev)
@@ -99,6 +99,7 @@ int  kpc_dma_probe(struct platform_device *pldev)
 	dev_t dev;
 
 	struct kpc_dma_device *ldev = kzalloc(sizeof(struct kpc_dma_device), GFP_KERNEL);
+
 	if (!ldev) {
 		dev_err(&pldev->dev, "kpc_dma_probe: unable to kzalloc space for kpc_dma_device\n");
 		rv = -ENOMEM;
@@ -178,6 +179,7 @@ static
 int  kpc_dma_remove(struct platform_device *pldev)
 {
 	struct kpc_dma_device *ldev = platform_get_drvdata(pldev);
+
 	if (!ldev)
 		return -ENXIO;
 
@@ -193,7 +195,6 @@ int  kpc_dma_remove(struct platform_device *pldev)
 	return 0;
 }
 
-
 /**********  Driver Functions  **********/
 struct platform_driver kpc_dma_plat_driver_i = {
 	.probe        = kpc_dma_probe,
@@ -231,11 +232,11 @@ int __init kpc_dma_driver_init(void)
 
 	return err;
 
-  fail_platdriver_register:
+fail_platdriver_register:
 	class_destroy(kpc_dma_class);
-  fail_class_create:
+fail_class_create:
 	__unregister_chrdev(KPC_DMA_CHAR_MAJOR, 0, KPC_DMA_NUM_MINORS, "kpc_dma");
-  fail_chrdev_register:
+fail_chrdev_register:
 	return err;
 }
 module_init(kpc_dma_driver_init);
diff --git a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
index 8101601736a2..cf781940ac1b 100644
--- a/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
+++ b/drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.h
@@ -18,7 +18,6 @@
 #include <linux/bitops.h>
 #include "../kpc.h"
 
-
 struct kp2000_device;
 struct kpc_dma_device {
 	struct list_head            list;
@@ -157,15 +156,18 @@ void  WriteEngineControl(struct kpc_dma_device *eng, u32 value)
 {
 	writel(value, eng->eng_regs + 1);
 }
+
 static inline
 u32  GetEngineControl(struct kpc_dma_device *eng)
 {
 	return readl(eng->eng_regs + 1);
 }
+
 static inline
 void  SetClearEngineControl(struct kpc_dma_device *eng, u32 set_bits, u32 clear_bits)
 {
 	u32 val = GetEngineControl(eng);
+
 	val |= set_bits;
 	val &= ~clear_bits;
 	WriteEngineControl(eng, val);
@@ -176,16 +178,19 @@ void  SetEngineNextPtr(struct kpc_dma_device *eng, struct kpc_dma_descriptor *de
 {
 	writel(desc->MyDMAAddr, eng->eng_regs + 2);
 }
+
 static inline
 void  SetEngineSWPtr(struct kpc_dma_device *eng, struct kpc_dma_descriptor *desc)
 {
 	writel(desc->MyDMAAddr, eng->eng_regs + 3);
 }
+
 static inline
 void  ClearEngineCompletePtr(struct kpc_dma_device *eng)
 {
 	writel(0, eng->eng_regs + 4);
 }
+
 static inline
 u32  GetEngineCompletePtr(struct kpc_dma_device *eng)
 {
@@ -206,7 +211,6 @@ void  unlock_engine(struct kpc_dma_device *eng)
 	mutex_unlock(&eng->sem);
 }
 
-
 /// Shared Functions
 void  start_dma_engine(struct kpc_dma_device *eng);
 int   setup_dma_engine(struct kpc_dma_device *eng, u32 desc_cnt);
-- 
2.17.1

