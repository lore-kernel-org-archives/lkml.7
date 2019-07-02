Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B947FC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A403206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m5DbVkGc";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=foobox.net header.i=@foobox.net header.b="FNrVrwbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfGBOtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:49:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63365 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfGBOtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:49:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C46416D894;
        Tue,  2 Jul 2019 10:49:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=iuSC
        QH936PalZ9sl8D0wOAB5/XY=; b=m5DbVkGciCn5BhProSSHQyKURPn08TD/oOV9
        n9ypbv/aQyHbhCqQh1ZbtcZp3Lv/EVhrjEB4hDWXHp6jhFjFbStuTYYnGYeU4XsG
        a4dzj7x6zc/t+Ti22COnS7cwxVFujK89dJKV4qXjkKmMHCe28qnSN164joG47hce
        u9pyYWI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 842C916D893;
        Tue,  2 Jul 2019 10:49:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=foobox.net;
 h=from:to:cc:subject:date:message-id:in-reply-to:references; s=mesmtp;
 bh=ruAx3BEDVnp34U2vU44ihcx7aAUaxt7IiCC+TdX+HDg=;
 b=FNrVrwbKKseslOXVKSfBcO245Z0WYyp8uhNrfJ068us5oGFMH/LTptbl6nO94kFbBr0OMDmFanTtypwWuXBUAgm2WDKvmcwbvN8vjwUBOT3d9FWSzI07+D21m0QWKli0YuwnVKfkzh7vRVTBkCVgLnteTOeTP8B19mhq+fTqpaE=
Received: from imatushchak-HP-ZBook-14u-G4.synapse.com (unknown [195.238.93.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1B4D516D890;
        Tue,  2 Jul 2019 10:49:07 -0400 (EDT)
From:   Ihor Matushchak <ihor.matushchak@foobox.net>
To:     mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ihor.matushchak@foobox.net,
        iivanov.xz@gmail.com
Subject: [PATCH v2] virtio-mmio: add error check for platform_get_irq
Date:   Tue,  2 Jul 2019 17:48:18 +0300
Message-Id: <20190702144818.32648-1-ihor.matushchak@foobox.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <156207429000.5051.5975712347598980745@silver>
References: <156207429000.5051.5975712347598980745@silver>
X-Pobox-Relay-ID: 8C16B0BA-9CD8-11E9-800F-72EEE64BB12D-19565117!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in vm_find_vqs() irq has a wrong type
so, in case of no IRQ resource defined,
wrong parameter will be passed to request_irq()

Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>
---
Changes in v2:
Don't overwrite error code value.

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
2.17.1

