Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86146C0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CA32147A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011298;
	bh=6XfijMtwq9SZKtYSWMc/VoRqeg2flrU9/CpoHveNHWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M4esQnpiGc6xv4puj5nlXAbI6xwKPiw0BTmXyIApzwP4dZoMPsIwsEvCv8JKoXK/z
	 wiKHxewPTd+cOpGkQ3S69vzpXqBaMNQbKNKfgW2MFmckYnvWrvhUNh9jiCLA7KRSbX
	 zmvPsQK6aazVE5JWckLlSqrAV8JN6gHs02gWBVic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbfHENVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729064AbfHENVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:21:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D592075B;
        Mon,  5 Aug 2019 13:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011290;
        bh=6XfijMtwq9SZKtYSWMc/VoRqeg2flrU9/CpoHveNHWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KuUrrfsu5ldmfMxAEmZjxW+7RGJMU3EcJhJad2SmLrHpiAfoBPeueVr4kXKCIBCLK
         M1mxCGbBBxb24NrVkrETdAj9EwCagwpgb2lDrSlpsc6PsGpPQZGKo8KHfOrAcPX1ZH
         A3nxUOVO1hfCWn5J6VScan25nCxbbTeg72BjXp+g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ihor Matushchak <ihor.matushchak@foobox.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Ivan T. Ivanov" <iivanov.xz@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 035/131] virtio-mmio: add error check for platform_get_irq
Date:   Mon,  5 Aug 2019 15:02:02 +0200
Message-Id: <20190805124953.780673514@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index f363fbeb5ab0c..e09edb5c5e065 100644
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



