Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F1C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9EB208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 12:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfHHMGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 08:06:53 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55261 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbfHHMGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 08:06:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TYy50iH_1565266002;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TYy50iH_1565266002)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 08 Aug 2019 20:06:50 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tao.ma@linux.alibaba.com, gerry@linux.alibaba.com
Subject: [PATCH 2/2] vfio_pci: make use of update_irq_devid and optimize irq ops
Date:   Thu,  8 Aug 2019 20:07:32 +0800
Message-Id: <461a0d843c8ac4c31de61d08f4940884742f77b5.1565263723.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1565263723.git.luoben@linux.alibaba.com>
References: <cover.1565263723.git.luoben@linux.alibaba.com>
In-Reply-To: <cover.1565263723.git.luoben@linux.alibaba.com>
References: <cover.1565263723.git.luoben@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When userspace (e.g. qemu) triggers a switch between KVM
irqfd and userspace eventfd, only dev_id of irq action
(i.e. the "trigger" in this patch's context) will be
changed, but a free-then-request-irq action is taken in
current code. And, irq affinity setting in VM will also
trigger a free-then-request-irq action, which actully
changes nothing, but only fires a producer re-registration
to update irte in case that posted-interrupt is in use.

This patch makes use of update_irq_devid() and optimize
both cases above, which reduces the risk of losing interrupt
and also cuts some overhead.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
Reviewed-by: Liu Jiang <gerry@linux.alibaba.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 100 +++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 38 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 3fa3f72..1323dc8 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -285,69 +285,93 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
 				      int vector, int fd, bool msix)
 {
 	struct pci_dev *pdev = vdev->pdev;
-	struct eventfd_ctx *trigger;
+	struct eventfd_ctx *trigger = NULL;
 	int irq, ret;
 
 	if (vector < 0 || vector >= vdev->num_ctx)
 		return -EINVAL;
 
+	if (fd >= 0) {
+		trigger = eventfd_ctx_fdget(fd);
+		if (IS_ERR(trigger))
+			return PTR_ERR(trigger);
+	}
+
 	irq = pci_irq_vector(pdev, vector);
 
 	if (vdev->ctx[vector].trigger) {
-		free_irq(irq, vdev->ctx[vector].trigger);
-		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
-		kfree(vdev->ctx[vector].name);
-		eventfd_ctx_put(vdev->ctx[vector].trigger);
-		vdev->ctx[vector].trigger = NULL;
+		if (vdev->ctx[vector].trigger != trigger) {
+			if (trigger) {
+				ret = update_irq_devid(irq,
+						vdev->ctx[vector].trigger, trigger);
+				if (unlikely(ret)) {
+					dev_info(&pdev->dev,
+							"update_irq_devid %d (token %p) fails: %d\n",
+							irq, vdev->ctx[vector].trigger, ret);
+					eventfd_ctx_put(trigger);
+					return ret;
+				}
+				irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
+				eventfd_ctx_put(vdev->ctx[vector].trigger);
+				vdev->ctx[vector].producer.token = trigger;
+				vdev->ctx[vector].trigger = trigger;
+			} else {
+				free_irq(irq, vdev->ctx[vector].trigger);
+				irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
+				kfree(vdev->ctx[vector].name);
+				eventfd_ctx_put(vdev->ctx[vector].trigger);
+				vdev->ctx[vector].trigger = NULL;
+			}
+		} else
+			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
 	}
 
 	if (fd < 0)
 		return 0;
 
-	vdev->ctx[vector].name = kasprintf(GFP_KERNEL, "vfio-msi%s[%d](%s)",
-					   msix ? "x" : "", vector,
-					   pci_name(pdev));
-	if (!vdev->ctx[vector].name)
-		return -ENOMEM;
+	if (vdev->ctx[vector].trigger == NULL) {
+		vdev->ctx[vector].name = kasprintf(GFP_KERNEL, "vfio-msi%s[%d](%s)",
+						   msix ? "x" : "", vector,
+						   pci_name(pdev));
+		if (!vdev->ctx[vector].name) {
+			eventfd_ctx_put(trigger);
+			return -ENOMEM;
+		}
 
-	trigger = eventfd_ctx_fdget(fd);
-	if (IS_ERR(trigger)) {
-		kfree(vdev->ctx[vector].name);
-		return PTR_ERR(trigger);
-	}
+		/*
+		 * The MSIx vector table resides in device memory which may be cleared
+		 * via backdoor resets. We don't allow direct access to the vector
+		 * table so even if a userspace driver attempts to save/restore around
+		 * such a reset it would be unsuccessful. To avoid this, restore the
+		 * cached value of the message prior to enabling.
+		 */
+		if (msix) {
+			struct msi_msg msg;
 
-	/*
-	 * The MSIx vector table resides in device memory which may be cleared
-	 * via backdoor resets. We don't allow direct access to the vector
-	 * table so even if a userspace driver attempts to save/restore around
-	 * such a reset it would be unsuccessful. To avoid this, restore the
-	 * cached value of the message prior to enabling.
-	 */
-	if (msix) {
-		struct msi_msg msg;
+			get_cached_msi_msg(irq, &msg);
+			pci_write_msi_msg(irq, &msg);
+		}
 
-		get_cached_msi_msg(irq, &msg);
-		pci_write_msi_msg(irq, &msg);
-	}
+		ret = request_irq(irq, vfio_msihandler, 0,
+				  vdev->ctx[vector].name, trigger);
+		if (ret) {
+			kfree(vdev->ctx[vector].name);
+			eventfd_ctx_put(trigger);
+			return ret;
+		}
 
-	ret = request_irq(irq, vfio_msihandler, 0,
-			  vdev->ctx[vector].name, trigger);
-	if (ret) {
-		kfree(vdev->ctx[vector].name);
-		eventfd_ctx_put(trigger);
-		return ret;
+		vdev->ctx[vector].producer.token = trigger;
+		vdev->ctx[vector].producer.irq = irq;
+		vdev->ctx[vector].trigger = trigger;
 	}
 
-	vdev->ctx[vector].producer.token = trigger;
-	vdev->ctx[vector].producer.irq = irq;
+	/* always update irte for posted mode */
 	ret = irq_bypass_register_producer(&vdev->ctx[vector].producer);
 	if (unlikely(ret))
 		dev_info(&pdev->dev,
 		"irq bypass producer (token %p) registration fails: %d\n",
 		vdev->ctx[vector].producer.token, ret);
 
-	vdev->ctx[vector].trigger = trigger;
-
 	return 0;
 }
 
-- 
1.8.3.1

