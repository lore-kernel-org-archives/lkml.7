Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9E0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FD6E2173C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504364;
	bh=doyardt0JggkJhDO07+14ipJytUL+xswS+WNkZwYiVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SgZ5Xgbm00uVjLepJkgbhTYj3brJPZ5dhm+L8ctyKA+xuA3jDVyhKjqYS5x4E4cyt
	 +izUCmOxi9JlQ4yUg76HBrXH3tBb5zFmYgxjQzrAdfhm4o3ZgNK+4gYAiLLa1dl40L
	 MvW0fdfchcHHRc+SIev8C6r9A+pOic0hejnw4whM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfCMTMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:43282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfCMTMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDEB82177E;
        Wed, 13 Mar 2019 19:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504361;
        bh=doyardt0JggkJhDO07+14ipJytUL+xswS+WNkZwYiVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIYC2BuF9J50pQICE6SdC4FUHFfybYbtIgB4xwxPlMkuQboxqSpAj4OSTFe+5aQH4
         +xGP0Zacpn8oSeTaG/QDvkQmynaVRSHVuZsNvtYInMVpJYTMJ1ib7/5ybOpoeruJ3m
         aTk2uZBvnYcidbDfLe06WQxcwY+u2p7Fs/ZE6h3I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 57/60] bnxt_en: Wait longer for the firmware message response to complete.
Date:   Wed, 13 Mar 2019 15:10:18 -0400
Message-Id: <20190313191021.158171-57-sashal@kernel.org>
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

From: Michael Chan <michael.chan@broadcom.com>

[ Upstream commit 0000b81a063b5f3ab82fa18041c28327ce72c312 ]

The code waits up to 20 usec for the firmware response to complete
once we've seen the valid response header in the buffer.  It turns
out that in some scenarios, this wait time is not long enough.
Extend it to 150 usec and use usleep_range() instead of udelay().

Fixes: 9751e8e71487 ("bnxt_en: reduce timeout on initial HWRM calls")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 938ea8ada0da..7fbba28bc488 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3867,7 +3867,7 @@ static int bnxt_hwrm_do_send_msg(struct bnxt *bp, void *msg, u32 msg_len,
 			dma_rmb();
 			if (*valid)
 				break;
-			udelay(1);
+			usleep_range(1, 5);
 		}
 
 		if (j >= HWRM_VALID_BIT_DELAY_USEC) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3030931ccaf8..7bb9b4d8bf52 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -583,7 +583,7 @@ struct nqe_cn {
 	(HWRM_SHORT_TIMEOUT_COUNTER * HWRM_SHORT_MIN_TIMEOUT +		\
 	 ((n) - HWRM_SHORT_TIMEOUT_COUNTER) * HWRM_MIN_TIMEOUT))
 
-#define HWRM_VALID_BIT_DELAY_USEC	20
+#define HWRM_VALID_BIT_DELAY_USEC	150
 
 #define BNXT_RX_EVENT	1
 #define BNXT_AGG_EVENT	2
-- 
2.19.1

