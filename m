Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61374C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190FE2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504273;
	bh=RfaDM+dzAwWn7oQbQuFGx8MXdvcnpISfOtSi9SC3+Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x9F70pNq8mEgonIx6ZDMawnbzxW53tiTLeCI9hJjTwCH24U8hiHYPNmHLySmwDjqq
	 eEX+ErKZWf+JdqncGqo7+pcXh3Lj2ZfHqsN4F/t0WCh2agB4lH7VXhvZ58ED1fZilP
	 C7wNTsJoYV1meYoQ8MDVhXioKafoV9extotD/b6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfCMTLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727342AbfCMTLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C58AD213A2;
        Wed, 13 Mar 2019 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504268;
        bh=RfaDM+dzAwWn7oQbQuFGx8MXdvcnpISfOtSi9SC3+Ws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EGu2LqQPaib9Zgf7VVlY8U7rCZWiRbKN9OHbnCF74pvJBpIwvXwfDTB7W8iBmtd0W
         h+JCjMknike33Z2dqbMnMXMTfYtikf6nHnXv1fofKlZJ6TIXyMpEjmW5FBGFm4Wsqd
         QIybmUBLz8rVQtfFt4OQ5cJ8ddEi5VLQyKe4dmSw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 22/60] mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush timeout issue
Date:   Wed, 13 Mar 2019 15:09:43 -0400
Message-Id: <20190313191021.158171-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
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
index d7a8ed7d8097..57cd7293fa51 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1396,9 +1396,9 @@ static void flexrm_shutdown(struct mbox_chan *chan)
 
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

