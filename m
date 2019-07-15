Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9514AC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63BCB206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563199654;
	bh=oYKsj8jNuFHz2L+yoDgxwgDjUnQosC79bOL9HB5ullk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gm6F5oNTo6nIlPPLnCkCr3KyWJ46I5Zpni6f/X5asEZBKjMXwbzwksw+KFVMkoiDQ
	 5k2YfXGJJr0mGI5MZZ3Yk1KrJkPdkcTcxY/8PPvOfSVniyQyVOxOaHPePArjhuFabx
	 tRi7EIceSWwMfF0h3sus53J2VrGPY4P92rqVcv1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387992AbfGOOHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733004AbfGOOHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:07:30 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A65492081C;
        Mon, 15 Jul 2019 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563199649;
        bh=oYKsj8jNuFHz2L+yoDgxwgDjUnQosC79bOL9HB5ullk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gMWdmyLq886T0v3z4Lr8l5Q1P5MnUTpZq/dA9xgKbftFE+doBbige74VpBxXei9M2
         0jiw8+GyFjkfoytJYEV23EvHfHnxZTXYF7s9homWLc5bgXqXOBU3St9YnkduIdVeTC
         rhXKldiKhs5Z0DskOREhw3f6OlzW4LeFMKBV8DoU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Eddie James <eajames@linux.ibm.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 061/219] media: aspeed: change irq to threaded irq
Date:   Mon, 15 Jul 2019 10:01:02 -0400
Message-Id: <20190715140341.6443-61-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
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
index 692e08ef38c0..668d8827e281 100644
--- a/drivers/media/platform/aspeed-video.c
+++ b/drivers/media/platform/aspeed-video.c
@@ -1600,8 +1600,9 @@ static int aspeed_video_init(struct aspeed_video *video)
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

