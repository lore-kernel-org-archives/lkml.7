Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0387C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3BAD21743
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 15:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389588AbfHVPfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 11:35:18 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42658 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731907AbfHVPfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:35:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07417;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ta8soXe_1566488105;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Ta8soXe_1566488105)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 22 Aug 2019 23:35:12 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        gerry@linux.alibaba.com, nanhai.zou@linux.alibaba.com,
        linyunsheng@huawei.com
Subject: [PATCH v4 3/3] vfio/pci: make use of irq_update_devid and optimize irq ops
Date:   Thu, 22 Aug 2019 23:34:43 +0800
Message-Id: <8721e56f15dbcb1e0a1d8fc645def7b9bc752988.1566486156.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1566486156.git.luoben@linux.alibaba.com>
References: <cover.1566486156.git.luoben@linux.alibaba.com>
In-Reply-To: <cover.1566486156.git.luoben@linux.alibaba.com>
References: <cover.1566486156.git.luoben@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When userspace (e.g. qemu) triggers a switch between KVM
irqfd and userspace eventfd, only dev_id of irq action
(i.e. the "trigger" in this patch's context) will be
changed, but a free-then-request-irq action is taken in
current code. And, irq affinity setting in VM will also
trigger a free-then-request-irq action, which actually
changes nothing, but only fires a producer re-registration
to update irte in case that posted-interrupt is in use.

This patch makes use of irq_update_devid() and optimize
both cases above, which reduces the risk of losing interrupt
and also cuts some overhead.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 112 +++++++++++++++++++++++++-------------
 1 file changed, 74 insertions(+), 38 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 3fa3f72..60d3023 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -284,70 +284,106 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
 static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
 				      int vector, int fd, bool msix)
 {
+	struct eventfd_ctx *trigger = NULL;
 	struct pci_dev *pdev = vdev->pdev;
-	struct eventfd_ctx *trigger;
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
 
+	/*
+	 * For KVM-VFIO case, interrupt from passthrough device will be directly
+	 * delivered to VM after producer and consumer connected successfully.
+	 * If producer and consumer are disconnected, this interrupt process
+	 * will fall back to remap mode, where interrupt handler uses 'trigger'
+	 * to find the right way to deliver the interrupt to VM. So, it is safe
+	 * to do irq_update_devid() before irq_bypass_unregister_producer() which
+	 * switches interrupt process to remap mode. To producer and consumer,
+	 * 'trigger' is only a token used for pairing them togather.
+	 */
 	if (vdev->ctx[vector].trigger) {
-		free_irq(irq, vdev->ctx[vector].trigger);
-		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
-		kfree(vdev->ctx[vector].name);
-		eventfd_ctx_put(vdev->ctx[vector].trigger);
-		vdev->ctx[vector].trigger = NULL;
+		if (vdev->ctx[vector].trigger == trigger) {
+			/* switch back to remap mode */
+			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
+		} else if (trigger) {
+			ret = irq_update_devid(irq,
+					       vdev->ctx[vector].trigger, trigger);
+			if (unlikely(ret)) {
+				dev_info(&pdev->dev,
+					 "update devid of %d (token %p) failed: %d\n",
+					 irq, vdev->ctx[vector].trigger, ret);
+				eventfd_ctx_put(trigger);
+				return ret;
+			}
+			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
+			eventfd_ctx_put(vdev->ctx[vector].trigger);
+			vdev->ctx[vector].producer.token = trigger;
+			vdev->ctx[vector].trigger = trigger;
+		} else {
+			free_irq(irq, vdev->ctx[vector].trigger);
+			irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
+			kfree(vdev->ctx[vector].name);
+			eventfd_ctx_put(vdev->ctx[vector].trigger);
+			vdev->ctx[vector].trigger = NULL;
+		}
 	}
 
 	if (fd < 0)
 		return 0;
 
-	vdev->ctx[vector].name = kasprintf(GFP_KERNEL, "vfio-msi%s[%d](%s)",
-					   msix ? "x" : "", vector,
-					   pci_name(pdev));
-	if (!vdev->ctx[vector].name)
-		return -ENOMEM;
+	if (!vdev->ctx[vector].trigger) {
+		vdev->ctx[vector].name = kasprintf(GFP_KERNEL,
+						   "vfio-msi%s[%d](%s)",
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
+		 * The MSIx vector table resides in device memory which may be
+		 * cleared via backdoor resets. We don't allow direct access to
+		 * the vector table so even if a userspace driver attempts to
+		 * save/restore around such a reset it would be unsuccessful.
+		 * To avoid this, restore the cached value of the message prior
+		 * to enabling.
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
+	/* setup bypass connection and make irte updated */
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

