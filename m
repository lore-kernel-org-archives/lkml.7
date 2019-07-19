Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E58C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE63521849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="X8pzVNN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfGSNby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:31:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33005 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfGSNbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:31:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id f20so5252892pgj.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LDfiHhfm1VeYjc3x9ETkPx6mUuqXdeK8Z+k7FQXBEDA=;
        b=X8pzVNN1Ck1WUp1udQaO55Zsbrlcxh9vYvbnDZbzU7x9DzcqaWb5Y21AYwyhFFW3tM
         cww3bVg+ZQSjd7CC0DrGfS2bTIVZR7tAHdSqz/sI+fmTVgZ75xoch7L047Uf9ejicPKu
         3FkTxpWPgWskhBiNbaysFwkU4jVkQ/G/DfV+Y0TqaPj7jIGP7lRMEBBOxiN9mBJABO73
         A2zx+n05pmjXI7/YRXpnagR5w6UT7H7WSmE49/C927rdqXlPXfgBVj8e5wKT7ARfTmZu
         1i02ZC/APpm7i5LsDJCvF3ycNjkMzy5W/uGcQX5uc/H9psbkXgJNT054Q3cSEwOCRfkH
         BSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LDfiHhfm1VeYjc3x9ETkPx6mUuqXdeK8Z+k7FQXBEDA=;
        b=pt4Lt04470F+YKXe2Q3WdRIakLQr11jOEc1dvLrdOOEswTVs1fxfkZZte9I++mFbBh
         O972RkHquuuA0Hv/VffP1IQi7czE7Urw9fmiH1IGf0v3lZ38ZVyWaSK6SMkd4Bg+6fKp
         WeUy7vvRgwtX4R6vsiBIFivf08OnVARDd8OY7VCps6GwbPH4qlpOWScF4PLqUpHkpi8q
         n8BXOU9P9HeK6OCLXe2jYi385r8ij+tCHzcJOg9MMXtQGACxrpzZGhenPOqHoVJCHt0J
         8Zyop+hahJu8uzhdu4Q+zVTKq5uOVS6bkS+tKsBmx3ybBDKavboV6A4iqgV7dmAG9f7x
         apjQ==
X-Gm-Message-State: APjAAAU/AFAu2h3Ob1Uj5CThn+M6eQOP3qfNchN4gt8eVz8PsrbdsFXu
        i/l9Hd5zRdGF8+avtwIJnwCeqH7eSgOztg==
X-Google-Smtp-Source: APXvYqwG8iRy6UQIWcF5Pfv3kiq3iwLK2HcGwSegESvjrVjnVZLQztIMsH67cvhFupfNSwdLw3jfLw==
X-Received: by 2002:a63:4e58:: with SMTP id o24mr53189694pgl.366.1563543110286;
        Fri, 19 Jul 2019 06:31:50 -0700 (PDT)
Received: from bogon.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id x9sm37875954pfn.177.2019.07.19.06.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 06:31:49 -0700 (PDT)
From:   Fei Li <lifei.shirley@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, Pawel Moll <pawel.moll@arm.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>,
        Fei Li <lifei.shirley@bytedance.com>
Subject: [PATCH 2/2] virtio-mmio: support multiple interrupt vectors
Date:   Fri, 19 Jul 2019 21:31:35 +0800
Message-Id: <20190719133135.32418-3-lifei.shirley@bytedance.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190719133135.32418-1-lifei.shirley@bytedance.com>
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework vm_find_vqs() to support multiple interrupt vectors for
virtio-mmio device. Considering without msi/msi-x only limited irq
routing entries (only 24) are allocated, to support more interrupts
for device, esp. virtio-net device with multi rx/tx queue pairs, this
patch requests one vector for the config change and one vector for
two continuous vqs (e.g. each rx/tx queue pair).

If failing to request multiple interrupt vectors, fall back to the
old style: request only one irq for both the config and all vqs.

Add irq_first & irq_last to store the irq information when
processing the device command line.

Signed-off-by: Fei Li <lifei.shirley@bytedance.com>
---
 drivers/virtio/virtio_mmio.c | 237 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 194 insertions(+), 43 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 9b42502b2204..92d16c86ea8f 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -75,7 +75,7 @@
  * Currently hardcoded to the page size. */
 #define VIRTIO_MMIO_VRING_ALIGN		PAGE_SIZE
 
-
+#define VQ_NAME_LEN     20
 
 #define to_virtio_mmio_device(_plat_dev) \
 	container_of(_plat_dev, struct virtio_mmio_device, vdev)
@@ -90,6 +90,9 @@ struct virtio_mmio_device {
 	/* a list of queues so we can dispatch IRQs */
 	spinlock_t lock;
 	struct list_head virtqueues;
+
+	/* Add name for each virtqueue, can be used for the callback. */
+	char *vq_names;
 };
 
 struct virtio_mmio_vq_info {
@@ -279,7 +282,16 @@ static bool vm_notify(struct virtqueue *vq)
 	return true;
 }
 
-/* Notify all virtqueues on an interrupt. */
+/* Only handle the config change, then return. */
+static irqreturn_t vm_config_changed(int irq, void *opaque)
+{
+	struct virtio_mmio_device *vm_dev = opaque;
+
+	virtio_config_changed(&vm_dev->vdev);
+	return IRQ_HANDLED;
+}
+
+/* For old style: only one interrupt for both the config and all virtqueues. */
 static irqreturn_t vm_interrupt(int irq, void *opaque)
 {
 	struct virtio_mmio_device *vm_dev = opaque;
@@ -336,11 +348,31 @@ static void vm_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct virtqueue *vq, *n;
+	unsigned int start;
+	int i = 0, shared = 0;
+	struct resource *res = platform_get_resource(vm_dev->pdev,
+						     IORESOURCE_IRQ, 0);
 
-	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
-		vm_del_vq(vq);
+	if (res == NULL)
+		return;
+	start = res->start;
+	if (res->end == start) {
+		free_irq(start, vm_dev);
+	} else {
+		/* Try to free_irq for vq[i] */
+		list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
+			free_irq(start + shared + 1, vq);
+			if (i % 2 != 0)
+				shared++;
+			vm_del_vq(vq);
+			i++;
+		}
+		/* Try to free_irq for config */
+		free_irq(start, vdev);
+	}
 
-	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
+	kfree(vm_dev->vq_names);
+	vm_dev->vq_names = NULL;
 }
 
 static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
@@ -453,26 +485,66 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 	return ERR_PTR(err);
 }
 
-static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
-		       struct virtqueue *vqs[],
-		       vq_callback_t *callbacks[],
-		       const char * const names[],
-		       const bool *ctx,
-		       struct irq_affinity *desc)
+static int vm_request_multi_vectors(struct virtio_device *vdev,
+				    unsigned int start, int nvectors)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	int irq = platform_get_irq(vm_dev->pdev, 0);
-	int i, err, queue_idx = 0;
+	int err = -ENOMEM;
 
-	if (irq < 0) {
-		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
-		return irq;
-	}
+	vm_dev->vq_names = kmalloc(nvectors * VQ_NAME_LEN, GFP_KERNEL);
+	if (!vm_dev->vq_names)
+		goto error;
 
-	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
-			dev_name(&vdev->dev), vm_dev);
+	/* Firstly, request one irq vector for config */
+	snprintf(vm_dev->vq_names, VQ_NAME_LEN,
+		"%s-config", dev_name(&vdev->dev));
+	err = request_irq(start, vm_config_changed, 0,
+			vm_dev->vq_names, vm_dev);
 	if (err)
-		return err;
+		goto error;
+
+	return 0;
+error:
+	vm_del_vqs(vdev);
+	return err;
+}
+
+static int vm_try_to_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
+			      struct virtqueue *vqs[],
+			      vq_callback_t *callbacks[],
+			      const char * const names[],
+			      const bool *ctx,
+			      struct irq_affinity *desc,
+			      bool multi_vectors)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	unsigned int start, shared = 0;
+	int i, err = 0, nvectors = 0, queue_idx = 0;
+	struct resource *res = platform_get_resource(vm_dev->pdev,
+						     IORESOURCE_IRQ, 0);
+
+	if (res == NULL)
+		return -EINVAL;
+
+	start = res->start;
+	if (!multi_vectors) {
+		/* Old style: only one interrupt for config and all vqs. */
+		err = request_irq(start, vm_interrupt, IRQF_SHARED,
+				  dev_name(&vdev->dev), vm_dev);
+		if (err)
+			goto error_request;
+		res->end = start;
+	} else {
+		/* Optimizing: one for config change, one per vq pair. */
+		nvectors = 1;
+		for (i = 0; i < nvqs; i++)
+			if (callbacks[i])
+				++nvectors;
+
+		err = vm_request_multi_vectors(vdev, start, nvectors);
+		if (err)
+			goto error_request;
+	}
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
@@ -483,14 +555,65 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		vqs[i] = vm_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false);
 		if (IS_ERR(vqs[i])) {
-			vm_del_vqs(vdev);
-			return PTR_ERR(vqs[i]);
+			err = PTR_ERR(vqs[i]);
+			goto error_vq;
 		}
+
+		/* Do not request_irq for vq without a callback, e.i. control */
+		if (!callbacks[i])
+			continue;
+
+		/* If multi-vectors not supported: don't request more vectors */
+		if (start == res->end)
+			break;
+
+		/* For multi-vectors: choose vq as the dev_id for request_irq */
+		snprintf(vm_dev->vq_names + (i + 1) * VQ_NAME_LEN, VQ_NAME_LEN,
+			 "%s-%s", dev_name(&vdev->dev), names[i]);
+		err = request_irq(start + shared + 1, vring_interrupt,
+				  IRQF_SHARED,
+				  vm_dev->vq_names + (i + 1) * VQ_NAME_LEN,
+				  vqs[i]);
+		if (err)
+			goto error_vq;
+
+		if (i % 2 != 0)
+			shared += 1;
 	}
+	return err;
+error_vq:
+	vm_del_vqs(vdev);
+error_request:
+	return err;
+}
 
-	return 0;
+static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
+		       struct virtqueue *vqs[],
+		       vq_callback_t *callbacks[],
+		       const char * const names[],
+		       const bool *ctx,
+		       struct irq_affinity *desc)
+{
+	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	struct resource *res = platform_get_resource(vm_dev->pdev,
+						     IORESOURCE_IRQ, 0);
+
+	if (res == NULL)
+		return -EINVAL;
+	/* If supports multi-vectors: request more vectors for config and vqs */
+	if (res->start < res->end)
+		if (!vm_try_to_find_vqs(vdev, nvqs, vqs, callbacks,
+					names, ctx, desc, true))
+			return 0;
+	/* Only request one vector for both the config and all vqs:
+	 * 1. Handle for devices not supporting multi vectors;
+	 * 2. Fallback to the old style in case requesting multi-vectors failed
+	 */
+	return vm_try_to_find_vqs(vdev, nvqs, vqs, callbacks, names,
+				  ctx, desc, false);
 }
 
+
 static const char *vm_bus_name(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
@@ -637,32 +760,42 @@ static int vm_cmdline_set(const char *device,
 	struct resource resources[2] = {};
 	char *str;
 	long long int base, size;
-	unsigned int irq;
+	unsigned int irq_first, irq_last;
 	int processed, consumed = 0;
 	struct platform_device *pdev;
 
 	/* Consume "size" part of the command line parameter */
 	size = memparse(device, &str);
 
-	/* Get "@<base>:<irq>[:<id>]" chunks */
-	processed = sscanf(str, "@%lli:%u%n:%d%n",
-			&base, &irq, &consumed,
-			&vm_cmdline_id, &consumed);
-
-	/*
-	 * sscanf() must processes at least 2 chunks; also there
-	 * must be no extra characters after the last chunk, so
-	 * str[consumed] must be '\0'
-	 */
-	if (processed < 2 || str[consumed])
-		return -EINVAL;
+	if (strchr(str, '[') == NULL && strchr(str, ']') == NULL) {
+		/* For old style: parse as "@<base>:<irq>[:<id>]" chunks */
+		processed = sscanf(str, "@%lli:%u%n:%d%n",
+				&base, &irq_first, &consumed,
+				&vm_cmdline_id, &consumed);
+		/*
+		 * sscanf() must processes at least 2 chunks; also there
+		 * must be no extra characters after the last chunk, so
+		 * str[consumed] must be '\0'
+		 */
+		if (processed < 2 || str[consumed])
+			return -EINVAL;
+		irq_last = irq_first;
+	} else {
+		/* For multi-vectors: @<base>:[<irq_first>-<irq_last>][:<id>] */
+		processed = sscanf(str, "@%lli:[%u-%u]%n:%d%n",
+				&base, &irq_first, &irq_last, &consumed,
+				&vm_cmdline_id, &consumed);
+		if (processed < 3 || str[consumed])
+			return -EINVAL;
+	}
 
 	resources[0].flags = IORESOURCE_MEM;
 	resources[0].start = base;
 	resources[0].end = base + size - 1;
 
 	resources[1].flags = IORESOURCE_IRQ;
-	resources[1].start = resources[1].end = irq;
+	resources[1].start = irq_first;
+	resources[1].end = irq_last;
 
 	if (!vm_cmdline_parent_registered) {
 		err = device_register(&vm_cmdline_parent);
@@ -673,11 +806,19 @@ static int vm_cmdline_set(const char *device,
 		vm_cmdline_parent_registered = 1;
 	}
 
-	pr_info("Registering device virtio-mmio.%d at 0x%llx-0x%llx, IRQ %d.\n",
-		       vm_cmdline_id,
-		       (unsigned long long)resources[0].start,
-		       (unsigned long long)resources[0].end,
-		       (int)resources[1].start);
+	if (resources[1].end > resources[1].start)
+		pr_info("Registering device virtio-mmio.%d at 0x%llx-0x%llx, IRQs %d-%d.\n",
+			vm_cmdline_id,
+			(unsigned long long)resources[0].start,
+			(unsigned long long)resources[0].end,
+			(int)resources[1].start,
+			(int)resources[1].end);
+	else
+		pr_info("Registering device virtio-mmio.%d at 0x%llx-0x%llx, IRQ %d.\n",
+			vm_cmdline_id,
+			(unsigned long long)resources[0].start,
+			(unsigned long long)resources[0].end,
+			(int)resources[1].start);
 
 	pdev = platform_device_register_resndata(&vm_cmdline_parent,
 			"virtio-mmio", vm_cmdline_id++,
@@ -692,7 +833,17 @@ static int vm_cmdline_get_device(struct device *dev, void *data)
 	unsigned int len = strlen(buffer);
 	struct platform_device *pdev = to_platform_device(dev);
 
-	snprintf(buffer + len, PAGE_SIZE - len, "0x%llx@0x%llx:%llu:%d\n",
+	if (pdev->resource[1].end > pdev->resource[1].start)
+		snprintf(buffer + len, PAGE_SIZE - len,
+			"0x%llx@0x%llx:[%llu-%llu]:%d\n",
+			pdev->resource[0].end - pdev->resource[0].start + 1ULL,
+			(unsigned long long)pdev->resource[0].start,
+			(unsigned long long)pdev->resource[1].start,
+			(unsigned long long)pdev->resource[1].end,
+			pdev->id);
+	else
+		snprintf(buffer + len, PAGE_SIZE - len,
+			"0x%llx@0x%llx:%llu:%d\n",
 			pdev->resource[0].end - pdev->resource[0].start + 1ULL,
 			(unsigned long long)pdev->resource[0].start,
 			(unsigned long long)pdev->resource[1].start,
-- 
2.11.0

