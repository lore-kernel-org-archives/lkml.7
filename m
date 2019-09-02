Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834CFC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5868321744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729341AbfIBECH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 00:02:07 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:43383 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728329AbfIBECH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 00:02:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tb4LMGb_1567396921;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Tb4LMGb_1567396921)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Sep 2019 12:02:04 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        gerry@linux.alibaba.com, nanhai.zou@linux.alibaba.com
Subject: [PATCH v6 3/3] vfio/pci: make use of irq_update_devid() and optimize irq ops
Date:   Mon,  2 Sep 2019 12:01:52 +0800
Message-Id: <670c992437dc83e988cf383b2e4ec4d7f448e151.1567394624.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567394624.git.luoben@linux.alibaba.com>
References: <cover.1567394624.git.luoben@linux.alibaba.com>
In-Reply-To: <cover.1567394624.git.luoben@linux.alibaba.com>
References: <cover.1567394624.git.luoben@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When userspace (e.g. qemu) triggers a switch between KVM
irqfd and userspace eventfd, only dev_id of irqaction
(i.e. the "trigger" in this patch's context) will be
changed, but a free-then-request-irq action is taken in
current code. And, interrupt affinity setting in VM will
also trigger a free-then-request-irq action, which actually
changes nothing in irqaction.

This patch makes use of irq_update_devid() and optimize
both cases above, which reduces the risk of losing interrupt
and also cuts some overhead.

Signed-off-by: Ben Luo <luoben@linux.alibaba.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 118 ++++++++++++++++++++++++++------------
 1 file changed, 81 insertions(+), 37 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 3fa3f72..57b2de3 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -284,8 +284,8 @@ static int vfio_msi_enable(struct vfio_pci_device *vdev, int nvec, bool msix)
 static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
 				      int vector, int fd, bool msix)
 {
+	struct eventfd_ctx *trigger = NULL;
 	struct pci_dev *pdev = vdev->pdev;
-	struct eventfd_ctx *trigger;
 	int irq, ret;
 
 	if (vector < 0 || vector >= vdev->num_ctx)
@@ -293,61 +293,105 @@ static int vfio_msi_set_vector_signal(struct vfio_pci_device *vdev,
 
 	irq = pci_irq_vector(pdev, vector);
 
+	if (fd >= 0)
+		trigger = eventfd_ctx_fdget(fd);
+
+	/*
+	 * 'trigger' is NULL or invalid, disable the interrupt
+	 * 'trigger' is same as before, only bounce the bypass registration
+	 * 'trigger' is a new valid one, update it to irqaction and other
+	 * data structures referencing to the old one; fallback to disable
+	 * the interrupt on error
+	 */
 	if (vdev->ctx[vector].trigger) {
-		free_irq(irq, vdev->ctx[vector].trigger);
+		/*
+		 * even if the trigger is unchanged, we need to bounce the
+		 * interrupt bypass connection to allow affinity changes in
+		 * the guest to be realized.
+		 */
 		irq_bypass_unregister_producer(&vdev->ctx[vector].producer);
-		kfree(vdev->ctx[vector].name);
-		eventfd_ctx_put(vdev->ctx[vector].trigger);
-		vdev->ctx[vector].trigger = NULL;
+
+		if (vdev->ctx[vector].trigger == trigger) {
+			/* avoid duplicated referencing to the same trigger */
+			eventfd_ctx_put(trigger);
+
+		} else if (trigger && !IS_ERR(trigger)) {
+			ret = irq_update_devid(irq,
+					       vdev->ctx[vector].trigger,
+					       trigger);
+			if (unlikely(ret)) {
+				dev_info(&pdev->dev,
+					 "update devid of %d (token %p) failed: %d\n",
+					 irq, vdev->ctx[vector].trigger, ret);
+				eventfd_ctx_put(trigger);
+				free_irq(irq, vdev->ctx[vector].trigger);
+				kfree(vdev->ctx[vector].name);
+				eventfd_ctx_put(vdev->ctx[vector].trigger);
+				vdev->ctx[vector].trigger = NULL;
+				return ret;
+			}
+			eventfd_ctx_put(vdev->ctx[vector].trigger);
+			vdev->ctx[vector].producer.token = trigger;
+			vdev->ctx[vector].trigger = trigger;
+
+		} else {
+			free_irq(irq, vdev->ctx[vector].trigger);
+			kfree(vdev->ctx[vector].name);
+			eventfd_ctx_put(vdev->ctx[vector].trigger);
+			vdev->ctx[vector].trigger = NULL;
+		}
 	}
 
 	if (fd < 0)
 		return 0;
+	else if (IS_ERR(trigger))
+		return PTR_ERR(trigger);
 
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

