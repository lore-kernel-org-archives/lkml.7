Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7325C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8685A2067B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 17:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfJKRWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 13:22:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49169 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbfJKRWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 13:22:34 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iIyca-00061J-9D; Fri, 11 Oct 2019 17:22:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: b44: remove redundant assignment to variable reg
Date:   Fri, 11 Oct 2019 18:22:32 +0100
Message-Id: <20191011172232.14430-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable reg is being assigned a value that is never read
and is being re-assigned in the following for-loop. The
assignment is redundant and hence can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/broadcom/b44.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/b44.c b/drivers/net/ethernet/broadcom/b44.c
index 97ab0dd25552..035dbb1b2c98 100644
--- a/drivers/net/ethernet/broadcom/b44.c
+++ b/drivers/net/ethernet/broadcom/b44.c
@@ -511,9 +511,6 @@ static void b44_stats_update(struct b44 *bp)
 		*val++ += br32(bp, reg);
 	}
 
-	/* Pad */
-	reg += 8*4UL;
-
 	for (reg = B44_RX_GOOD_O; reg <= B44_RX_NPAUSE; reg += 4UL) {
 		*val++ += br32(bp, reg);
 	}
-- 
2.20.1

