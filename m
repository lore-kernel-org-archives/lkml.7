Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC300C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5D321B18
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256102;
	bh=IKqa6s6GD4IuiJaYj1kpc+pRjy16JhWkpqhMRUQ8DQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jdWV2xi/V12CuKUJhRq2NsxRglEUBI3x6YgHR2EaLjXH8a5Wy8qov1DVf9518NqXr
	 mPRZzT+DVD4HjzrV6UM/8JCheikjtRs/Vgxn2PZ3yviHo0lP/IE67lGbh3YInVlOS0
	 dnmxYX4yT5sjltzLl06QVZGS20L07/Z3fjU3MrZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388252AbfCVMBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388238AbfCVMBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D496204FD;
        Fri, 22 Mar 2019 12:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256098;
        bh=IKqa6s6GD4IuiJaYj1kpc+pRjy16JhWkpqhMRUQ8DQ0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1mxdNl9wqJBssA6n3uHzJL9upnjcip2ksTA576VbvqQgghWIieLk0gZU7aqsndGwU
         iOwPKZ48q0xP4MhIEDyACuH1aHCMF1Jjl3xH70vHhZNmYvETAv+Qrcx2csUgaouoGl
         p9yR6R4LiYYYmCVvcAd3LVgoJ4TMTMcWiPe+VT0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 108/280] bnxt_en: Wait longer for the firmware message response to complete.
Date:   Fri, 22 Mar 2019 12:14:21 +0100
Message-Id: <20190322111313.096001380@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 63b97289f4fe..0bd93bb7d1a2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -3565,7 +3565,7 @@ static int bnxt_hwrm_do_send_msg(struct bnxt *bp, void *msg, u32 msg_len,
 			dma_rmb();
 			if (*valid)
 				break;
-			udelay(1);
+			usleep_range(1, 5);
 		}
 
 		if (j >= HWRM_VALID_BIT_DELAY_USEC) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index bde384630a75..cf2d4a6583d5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -548,7 +548,7 @@ struct rx_tpa_end_cmp_ext {
 	(HWRM_SHORT_TIMEOUT_COUNTER * HWRM_SHORT_MIN_TIMEOUT +		\
 	 ((n) - HWRM_SHORT_TIMEOUT_COUNTER) * HWRM_MIN_TIMEOUT))
 
-#define HWRM_VALID_BIT_DELAY_USEC	20
+#define HWRM_VALID_BIT_DELAY_USEC	150
 
 #define BNXT_RX_EVENT	1
 #define BNXT_AGG_EVENT	2
-- 
2.19.1



