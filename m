Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F004C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA8A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505091;
	bh=fM4vbKr4eP11lpxlD0KVyXPkXRyP14OWzycVv6G14eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LJ03eHZAK+NjKwGLbJ+NAhV5TyMsppoM47Ettpk7xVTy7dRku287nvfY3xPbbM5/J
	 o1rNalOeVCUsN6fmiH79meLvA1oJXNDBT6AH8WVRlzba9RO8uq0KANH/7u6PCbPXzr
	 LcfFyB3fLDK0D5KSSGbSQI2HuKXw8Mn2KltI5Z7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfCMTPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:15:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbfCMTPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:15:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78808217F5;
        Wed, 13 Mar 2019 19:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504548;
        bh=fM4vbKr4eP11lpxlD0KVyXPkXRyP14OWzycVv6G14eY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S9Fer96Qg6Ui8Kl8aGeDAABDCeKr2ApsuIqRX5numllGyPf7/zPA6Lhb0WuTWY0+m
         eZV3fOVLY1AiCjdug6Y70gyVx+TEy6VmooRvCYxt8dvDsC2gfyQF9wnogzj1ymKzHL
         0S8Be5uPW0pmQwdE9HnkK+BFtnFwlI4fR7BL2WgA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 14/33] mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue
Date:   Wed, 13 Mar 2019 15:14:47 -0400
Message-Id: <20190313191506.159677-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191506.159677-1-sashal@kernel.org>
References: <20190313191506.159677-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

[ Upstream commit d7bf31a0f85faaf63c63c39d55154825a1eaaea9 ]

RING_CONTROL reg was not written due to wrong address, hence all
the subsequent ring flush was timing out.

Fixes: a371c10ea4b3 ("mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush sequence")

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index f052a3eb2098..7e3ed2714630 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1381,9 +1381,9 @@ static void flexrm_shutdown(struct mbox_chan *chan)
 
 	/* Clear ring flush state */
 	timeout = 1000; /* timeout of 1s */
-	writel_relaxed(0x0, ring + RING_CONTROL);
+	writel_relaxed(0x0, ring->regs + RING_CONTROL);
 	do {
-		if (!(readl_relaxed(ring + RING_FLUSH_DONE) &
+		if (!(readl_relaxed(ring->regs + RING_FLUSH_DONE) &
 		      FLUSH_DONE_MASK))
 			break;
 		mdelay(1);
-- 
2.19.1

