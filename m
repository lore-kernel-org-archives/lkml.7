Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765DEC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4514B2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563203569;
	bh=YkM8ZYn63XFy0CTvVK4KJbRkmbMTsQ2YxmnYXtb17BY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oxi7FK3qDJAInpU7xBuuFsfHRhjHkENk8l80oITs267XRkj19wJ1KxV/OVhZmZ8mT
	 AiZnZ0Iyv6li8uFLJMrI03OLGPfRmAhEnBmiQ9EVKl7p1GaHxl5pp+40EQXGVD1A6Z
	 grh1j5+NEPGeXgCtd5hMHJPrJsySwnoNh/S5Xops=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732041AbfGONu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:41290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730286AbfGONuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:50:50 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 837282067C;
        Mon, 15 Jul 2019 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198649;
        bh=YkM8ZYn63XFy0CTvVK4KJbRkmbMTsQ2YxmnYXtb17BY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HS/rn4R3jCKSSJEfkMYTi6djyNFy2U7iroe9TSSARk7e6WokyZ3FCJGRdnt+dTcBT
         /a0uSMz3Rz/YSs2nQafNdhTBsESAr69TLWSx97dX6cf50yUJDBiTcuTsC+8PoPivGN
         fM34c5gEgJrbvXZeU5ImQMxfI0KhtwtkSPiFlG5U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Eddie James <eajames@linux.ibm.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 070/249] media: aspeed: change irq to threaded irq
Date:   Mon, 15 Jul 2019 09:43:55 -0400
Message-Id: <20190715134655.4076-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

[ Upstream commit 12ae1c1bf5db2f33fcd9092a96f630291c4b181a ]

Differently from other Aspeed drivers, this driver calls clock
control APIs in interrupt context. Since ECLK is coupled with a
reset bit in clk-aspeed module, aspeed_clk_enable will make 10ms of
busy waiting delay for triggering the reset and it will eventually
disturb other drivers' interrupt handling. To fix this issue, this
commit changes this driver's irq to threaded irq so that the delay
can be happened in a thread context.

Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/aspeed-video.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
index 8144fe36ad48..76d7512c82a3 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1589,8 +1589,9 @@ static int aspeed_video_init(struct aspeed_video *video)
 		return -ENODEV;
 	}
 
-	rc = devm_request_irq(dev, irq, aspeed_video_irq, IRQF_SHARED,
-			      DEVICE_NAME, video);
+	rc = devm_request_threaded_irq(dev, irq, NULL, aspeed_video_irq,
+				       IRQF_ONESHOT | IRQF_SHARED, DEVICE_NAME,
+				       video);
 	if (rc < 0) {
 		dev_err(dev, "Unable to request IRQ %d\n", irq);
 		return rc;
-- 
2.20.1

