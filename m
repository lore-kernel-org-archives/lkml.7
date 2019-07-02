Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151B7C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5FA205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Nu4e5+Rr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=foobox.net header.i=@foobox.net header.b="Cd5c12n9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfGBKAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:00:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64255 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGBKAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:00:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78F6F150648;
        Tue,  2 Jul 2019 06:00:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=jSkAOz/JekATy7foxdB+etb0MM8
        =; b=Nu4e5+Rr11XSEzSxsh1fblnkiCsBys6TGOx1H+wftnRg9w/DZc4S0LbDGRs
        IG7pJeYlsZv4HUFY6Vt9TyO2fU9RpsEUfj8b46vY1kRxKUkIche2CeJTSUt4FZzu
        01P+Z8Pz/VGptGyV9NL0Un0jaaXSRz9FYq0AICuFtTe3nyEw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F0FB150647;
        Tue,  2 Jul 2019 06:00:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=foobox.net;
 h=from:to:cc:subject:date:message-id; s=mesmtp;
 bh=+lliQuyIZpwTTjuKcii3RwNj8j3p9yrnj96NIgycEdI=;
 b=Cd5c12n9DuxQL3zSs6SvDOfTmku8Scl02n/j++sp6rYpuTMcRduQS17Devr9u2uztVFzZBuUdNgiqDtwIOy7cMeBvQD4zx+w7eyUR6JYAO9iFRXbxQ3OPb62WnMO8hXC8k6DigEHTq38cb1mCBgxT0FXknvEmVXgG9euUCv2F3w=
Received: from imatushchak-HP-ZBook-14u-G4.synapse.com (unknown [195.238.93.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFE20150646;
        Tue,  2 Jul 2019 06:00:06 -0400 (EDT)
From:   Ihor Matushchak <ihor.matushchak@foobox.net>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ihor.matushchak@foobox.net
Subject: [PATCH] virtio-mmio: add error check for platform_get_irq
Date:   Tue,  2 Jul 2019 12:59:18 +0300
Message-Id: <20190702095918.12852-1-ihor.matushchak@foobox.net>
X-Mailer: git-send-email 2.17.1
X-Pobox-Relay-ID: 2BE6FA06-9CB0-11E9-877C-46F8B7964D18-19565117!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in vm_find_vqs() irq has a wrong type
so, in case of no IRQ resource defined,
wrong parameter will be passed to request_irq()

Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>
---
 drivers/virtio/virtio_mmio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index f363fbeb5ab0..60dde8ed163b 100644
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
+		dev_err(&vdev->dev, "no IRQ resource defined\n");
+		return -ENODEV;
+	}
+
 	err = request_irq(irq, vm_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vm_dev);
 	if (err)
-- 
2.17.1

