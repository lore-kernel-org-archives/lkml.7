Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431C1C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C6EE21849
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="FBEmjb0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfGSNbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:31:49 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36871 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728432AbfGSNbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:31:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so15651411plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 06:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mGGBQjuamiUtrVxadzRH0T3QChYv88JTRGFWYKUNnp4=;
        b=FBEmjb0qrVWLovbPmr7DSDJHa+ihZqziFBLKc/xL8I6kdno/oQgbE2eWdUGo1V4KIn
         keVyNUINecuyEzsF4Pz97IJAyu1G9NhmFr6XVQsfEgff2zWdlqlxMfY9CICQOuvud5X2
         BG2PDCVMRRwo3Ok7Atlz+hLmcIFNmVATqEBo2B9ffRxDN/v8U3HG6L1w5FsTCbyUKhso
         UzucxMWIBB/CfuBZYThIMoXLA8Qc0KWuAZtXcwoZ/MG3BfFPAlxyjntA3iTqXS4j96SM
         dOQgPr2eEl6FwRMRXcMFol9yqqITJPKljakK4E1ezN5mP/WIi4XCuH0G2eSx0i1yULa3
         eF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mGGBQjuamiUtrVxadzRH0T3QChYv88JTRGFWYKUNnp4=;
        b=uT0+tYYfGPCbxjhw1BoxF6eGw+PPX1P3X0b4oGkD/FcYNK9QdbmI9Ck4w+a3vFNLz3
         zEZujfOnEYs5hn531HuE89u7Bd2SF1QDxvLx0NbAzMr2g/jkhv5ZBex/4jFXiPaLdBzd
         6XSrpp10jRsNpDWF0tD/cNkSieh0DUdxZ7herQi6cX/fi+JBCrxEchy1ElSLgrZXsebq
         P/XZ1POeTHkFrNVvK9q+qf2ABNj/5pvI7Z0KLWkwNhwVCTKUVJXOhHbLlfo9FB3z56DO
         ywEWXL7nHvKlai2sBzowCDcag9xRPSkwwEvONoYdvjBbL2ifZV1o17El2iO7ij8K+bH/
         sfHA==
X-Gm-Message-State: APjAAAUkYiOrJ6x0MxMU7/D4q9FL/lAGCZTwObZexDdBERiabxMrw/0k
        KXl/+heoDNx2dq5piI7ns+95LhyYp3sUdA==
X-Google-Smtp-Source: APXvYqzejEADmz1oEMYuwz2STWJSzqbdGnEcAnx3Y/w6xRj0RFlUPU/CKmc4ymAW+ztfJM9WMDoFOw==
X-Received: by 2002:a17:902:be12:: with SMTP id r18mr54212293pls.341.1563543106635;
        Fri, 19 Jul 2019 06:31:46 -0700 (PDT)
Received: from bogon.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id x9sm37875954pfn.177.2019.07.19.06.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jul 2019 06:31:46 -0700 (PDT)
From:   Fei Li <lifei.shirley@bytedance.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, Pawel Moll <pawel.moll@arm.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fam Zheng <zhengfeiran@bytedance.com>
Subject: [PATCH 1/2] virtio-mmio: Process vrings more proactively
Date:   Fri, 19 Jul 2019 21:31:34 +0800
Message-Id: <20190719133135.32418-2-lifei.shirley@bytedance.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20190719133135.32418-1-lifei.shirley@bytedance.com>
References: <20190719133135.32418-1-lifei.shirley@bytedance.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fam Zheng <zhengfeiran@bytedance.com>

This allows the backend to _not_ trap mmio read of the status register
after injecting IRQ in the data path, which can improve the performance
significantly by avoiding a vmexit for each interrupt.

More importantly it also makes it possible for Firecracker to hook up
virtio-mmio with vhost-net, in which case there isn't a way to implement
proper status register handling.

For a complete backend that does set either INT_CONFIG bit or INT_VRING
bit upon generating irq, what happens hasn't changed.

Signed-off-by: Fam Zheng <zhengfeiran@bytedance.com>
---
 drivers/virtio/virtio_mmio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index e09edb5c5e06..9b42502b2204 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -295,9 +295,7 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 	if (unlikely(status & VIRTIO_MMIO_INT_CONFIG)) {
 		virtio_config_changed(&vm_dev->vdev);
 		ret = IRQ_HANDLED;
-	}
-
-	if (likely(status & VIRTIO_MMIO_INT_VRING)) {
+	} else {
 		spin_lock_irqsave(&vm_dev->lock, flags);
 		list_for_each_entry(info, &vm_dev->virtqueues, node)
 			ret |= vring_interrupt(irq, info->vq);
-- 
2.11.0

