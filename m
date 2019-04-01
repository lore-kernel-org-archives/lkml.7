Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F38C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F0120896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140173;
	bh=1TAPsBCWrbQVTp+NlMn6q5zWWJRqzuSCWMW+RhwAvpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pdJUu6m9z2wnCsx0PaYkMJ5t2IWxTT9ZdSzpZFnYfnVcrAuNfbOIS0hNN0daZx+eO
	 4fgS8QczQv4ffTuqY8kBalzE/cQWmoaUOaSLS20c1GEehEfFoAXBw/OcBHXbkVZoQK
	 ZV/+CsF90OFfP6Q4Ven5Vtmt0lrDIhQvaq2Rl+Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388014AbfDARgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:36:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387990AbfDARgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:36:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EA682146E;
        Mon,  1 Apr 2019 17:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140170;
        bh=1TAPsBCWrbQVTp+NlMn6q5zWWJRqzuSCWMW+RhwAvpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUxJ0zs4eLsuVEJgrcDBoep/p7oTXkSP45xkSSAuWOu1ULi8q+szZf92IjG85rvAs
         LBhEdYKS+12jIGz2QaOln5lkKswMpON1hIWGE++O3AlZ3Vg6irWEe0Eahrp9Xv8MLc
         pKh9WwP35FmgcHOKDaI/dSLQfvpF+GSFVTJ9z78U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 087/131] mmc: mmc: fix switch timeout issue caused by jiffies precision
Date:   Mon,  1 Apr 2019 19:02:37 +0200
Message-Id: <20190401170059.312627080@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 987aa5f8059613bf85cbb6f64ffbd34f5cb7a9d1 ]

with CONFIG_HZ=100, the precision of jiffies is 10ms, and the
generic_cmd6_time of some card is also 10ms. then, may be current
time is only 5ms, but already timed out caused by jiffies precision.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/core/mmc_ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 1f444269ebbe..76b49b9772d0 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -542,7 +542,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		timeout_ms = MMC_OPS_TIMEOUT_MS;
 
 	/* Must check status to be sure of no errors. */
-	timeout = jiffies + msecs_to_jiffies(timeout_ms);
+	timeout = jiffies + msecs_to_jiffies(timeout_ms) + 1;
 	do {
 		if (send_status) {
 			err = __mmc_send_status(card, &status, ignore_crc);
-- 
2.19.1



