Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD2CC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B838222CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149545;
	bh=WBmTu2Fyi8tNJWqCNIYXELdgtJfwsS2xAvJNFYw9wIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZCpmu5GQrUL55O0PUDOb4IfNxfbBBPpOmCTqBGTC1b1RksWJvmyFgwAlkwb6Eg+/v
	 CNmib+fCbVYRE64+e7B6Z6dc2JjN5cyLs8przvPUcaqoC3iD0CugD343ATMWDi/8R6
	 kxCi8PuzrOpmd/XVhgW9npEOv+OLmumiXXR6T5Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbfGZN7E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:59:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387494AbfGZNkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:40:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 797172238C;
        Fri, 26 Jul 2019 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148434;
        bh=WBmTu2Fyi8tNJWqCNIYXELdgtJfwsS2xAvJNFYw9wIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1yPRYtubYFSggdm+E/P83d+WPHhZsP+FRv+X0zI0Ee6XduTBoj9IRm/a7d71sktza
         vpqzwOY4Ibd+/PUylw6dcIqMAJg/YQiiem58HAF3dMjvD3mpTY3bdF+aUxgTvt5EYu
         gJGm/Iq8FgYtRnXdyVR5ZsUeCB4HsfMmriOUZCtE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ihor Matushchak <ihor.matushchak@foobox.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Ivan T . Ivanov" <iivanov.xz@gmail.com>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.2 36/85] virtio-mmio: add error check for platform_get_irq
Date:   Fri, 26 Jul 2019 09:38:46 -0400
Message-Id: <20190726133936.11177-36-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ihor Matushchak <ihor.matushchak@foobox.net>

[ Upstream commit 5e663f0410fa2f355042209154029842ba1abd43 ]

in vm_find_vqs() irq has a wrong type
so, in case of no IRQ resource defined,
wrong parameter will be passed to request_irq()

Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Ivan T. Ivanov <iivanov.xz@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mmio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index f363fbeb5ab0..e09edb5c5e06 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -463,9 +463,14 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		       struct irq_affinity *desc)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	unsigned int irq = platform_get_irq(vm_dev->pdev, 0);
+	int irq = platform_get_irq(vm_dev->pdev, 0);
 	int i, err, queue_idx = 0;
 
+	if (irq < 0) {
+		dev_err(&vdev->dev, "Cannot get IRQ resource\n");
+		return irq;
+	}
+
 	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
 	if (err)
-- 
2.20.1

