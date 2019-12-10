Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2340BC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF54C2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 22:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576015484;
	bh=BbpxCoyvun3ZTlYPtQUKIrqp6jDkN0LqSuzOmQTuhJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jmxY0UkTSjLfg2XFlbATlF7aXWq0At6SQmDF2XsHVPOUgz9Bx9o/tW6XCD6bgfGXt
	 A3GQtNzhlw1bqGiiMT7A6cmWIiCFbjMeqnGZ5jMCtfAbRTZl79hcOypFA5Er9bi17H
	 /Dw+pZVTDZ3Axg0AJutbICEHc3n7cwc9BzTUj4GQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfLJWEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 17:04:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:35532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbfLJWEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 17:04:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEFBB2077B;
        Tue, 10 Dec 2019 22:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576015473;
        bh=BbpxCoyvun3ZTlYPtQUKIrqp6jDkN0LqSuzOmQTuhJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfGqeTYr8fYl3gElSKU7/OMX3EHQj4VvEZJLR0xz77PUEmRmnfvVVPvisi+lUB1My
         7KmSwB5qkpVSE2T2vkoASWzd33as9BgpgUNRtZZ/KhZGrjc+mEqbO+uSHstYPrrYAT
         faa2CzQ6yhh9y7aXpgb+39mQw7xFWjPy6e5Hs6i8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Chopra <manishc@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 078/130] bnx2x: Fix PF-VF communication over multi-cos queues.
Date:   Tue, 10 Dec 2019 17:02:09 -0500
Message-Id: <20191210220301.13262-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210220301.13262-1-sashal@kernel.org>
References: <20191210220301.13262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit dc5a3d79c345871439ffe72550b604fcde9770e1 ]

PF driver doesn't enable tx-switching for all cos queues/clients,
which causes packets drop from PF to VF. Fix this by enabling
tx-switching on all cos queues/clients.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/broadcom/bnx2x/bnx2x_sriov.c    | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
index 9ca994d0bab66..1977e0c552dff 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_sriov.c
@@ -2389,15 +2389,21 @@ static int bnx2x_set_pf_tx_switching(struct bnx2x *bp, bool enable)
 	/* send the ramrod on all the queues of the PF */
 	for_each_eth_queue(bp, i) {
 		struct bnx2x_fastpath *fp = &bp->fp[i];
+		int tx_idx;
 
 		/* Set the appropriate Queue object */
 		q_params.q_obj = &bnx2x_sp_obj(bp, fp).q_obj;
 
-		/* Update the Queue state */
-		rc = bnx2x_queue_state_change(bp, &q_params);
-		if (rc) {
-			BNX2X_ERR("Failed to configure Tx switching\n");
-			return rc;
+		for (tx_idx = FIRST_TX_COS_INDEX;
+		     tx_idx < fp->max_cos; tx_idx++) {
+			q_params.params.update.cid_index = tx_idx;
+
+			/* Update the Queue state */
+			rc = bnx2x_queue_state_change(bp, &q_params);
+			if (rc) {
+				BNX2X_ERR("Failed to configure Tx switching\n");
+				return rc;
+			}
 		}
 	}
 
-- 
2.20.1

