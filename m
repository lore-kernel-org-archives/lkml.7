Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95594C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B05820880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355147;
	bh=Qn+qeY7QsDrBSjDMgbLW46HKmISGD5usDVSxsTcLx9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=edyFeU7K5YwvQCWfogSJw0uIyjgqa78DIXzfBaOgOtSbSsMJpPHEn94oFQUCKHB/q
	 /pi9GmwTqBQv5kK6vWnyKgUd8aFQwU1aST6ggoWS//L8YyQlqpLLsOgaBWF1d4sMCZ
	 ML2ZP7AWEu/wxlG+kwfrKgdoeHFz2Ce1nmaza3IQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbfDOTFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:05:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfDOTFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 086002087C;
        Mon, 15 Apr 2019 19:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355143;
        bh=Qn+qeY7QsDrBSjDMgbLW46HKmISGD5usDVSxsTcLx9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jRpgK72XCxmLqnr9f6YusASdcV13R8NIl4YPZNSfyfBLsz58EdPAzx5VGHNs1Qp7F
         d3qezqk9CT/xK9EwOtK9/uyMYV+hEABuEY4ehwImkNYN1bRDJBQgytM2+vKMGqM5b1
         7PNtqe8+i2fgR+n89mPS7tedlyaP+9EsD3iwNrNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 029/101] bnxt_en: Reset device on RX buffer errors.
Date:   Mon, 15 Apr 2019 20:58:27 +0200
Message-Id: <20190415183741.975253374@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183740.341577907@linuxfoundation.org>
References: <20190415183740.341577907@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8e44e96c6c8e8fb80b84a2ca11798a8554f710f2 ]

If the RX completion indicates RX buffers errors, the RX ring will be
disabled by firmware and no packets will be received on that ring from
that point on.  Recover by resetting the device.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index a8abb47178be..581ad0a17d0c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1573,11 +1573,17 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_napi *bnapi, u32 *raw_cons,
 
 	rx_buf->data = NULL;
 	if (rxcmp1->rx_cmp_cfa_code_errors_v2 & RX_CMP_L2_ERRORS) {
+		u32 rx_err = le32_to_cpu(rxcmp1->rx_cmp_cfa_code_errors_v2);
+
 		bnxt_reuse_rx_data(rxr, cons, data);
 		if (agg_bufs)
 			bnxt_reuse_rx_agg_bufs(bnapi, cp_cons, agg_bufs);
 
 		rc = -EIO;
+		if (rx_err & RX_CMPL_ERRORS_BUFFER_ERROR_MASK) {
+			netdev_warn(bp->dev, "RX buffer error %x\n", rx_err);
+			bnxt_sched_reset(bp, rxr);
+		}
 		goto next_rx;
 	}
 
-- 
2.19.1



