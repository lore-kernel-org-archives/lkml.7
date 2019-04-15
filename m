Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA87C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D1420651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356309;
	bh=BzuP6qCwvSJOVzQETo8lWEzdUux06hzxkSnIfsPZHR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hw2vZCxuSI2kgx0+6N3n25cMK+s8cr8Vkd8IDji4nrlo/LIZad8au6KZ73a16xveG
	 dI0sSKTMZsp8cRFi4VGfwpn9usNkbLChsEt7JQAmCbr69WxTEjyc7+SV2RpXp+DiDZ
	 tdfBrM7Ty8lubAdGOAMDb+84qcS0IcF+ij1QkPSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfDOTZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:25:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729724AbfDOTFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:05:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475832087C;
        Mon, 15 Apr 2019 19:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355140;
        bh=BzuP6qCwvSJOVzQETo8lWEzdUux06hzxkSnIfsPZHR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8bi6qxYLkUA05ZeCTELqL/CSLcLn2rjo4iSDXGKGftDjmc2A4p1nZ3BQBy/3WOon
         Yj7Wd/5xdQFKS7wc+suTY1+nP/NvmwS6AVntTR4fIEt4p3rsfNc+MqSl2aYY9VcbRF
         4cMGvkjZf7TFMgChtRPG+2w+dfavu7cZZ503fPxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 028/101] bnxt_en: Improve RX consumer index validity check.
Date:   Mon, 15 Apr 2019 20:58:26 +0200
Message-Id: <20190415183741.904003577@linuxfoundation.org>
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

[ Upstream commit a1b0e4e684e9c300b9e759b46cb7a0147e61ddff ]

There is logic to check that the RX/TPA consumer index is the expected
index to work around a hardware problem.  However, the potentially bad
consumer index is first used to index into an array to reference an entry.
This can potentially crash if the bad consumer index is beyond legal
range.  Improve the logic to use the consumer index for dereferencing
after the validity check and log an error message.

Fixes: fa7e28127a5a ("bnxt_en: Add workaround to detect bad opaque in rx completion (part 2)")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0bd93bb7d1a2..a8abb47178be 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1092,6 +1092,8 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	tpa_info = &rxr->rx_tpa[agg_id];
 
 	if (unlikely(cons != rxr->rx_next_cons)) {
+		netdev_warn(bp->dev, "TPA cons %x != expected cons %x\n",
+			    cons, rxr->rx_next_cons);
 		bnxt_sched_reset(bp, rxr);
 		return;
 	}
@@ -1544,15 +1546,17 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_napi *bnapi, u32 *raw_cons,
 	}
 
 	cons = rxcmp->rx_cmp_opaque;
-	rx_buf = &rxr->rx_buf_ring[cons];
-	data = rx_buf->data;
-	data_ptr = rx_buf->data_ptr;
 	if (unlikely(cons != rxr->rx_next_cons)) {
 		int rc1 = bnxt_discard_rx(bp, bnapi, raw_cons, rxcmp);
 
+		netdev_warn(bp->dev, "RX cons %x != expected cons %x\n",
+			    cons, rxr->rx_next_cons);
 		bnxt_sched_reset(bp, rxr);
 		return rc1;
 	}
+	rx_buf = &rxr->rx_buf_ring[cons];
+	data = rx_buf->data;
+	data_ptr = rx_buf->data_ptr;
 	prefetch(data_ptr);
 
 	misc = le32_to_cpu(rxcmp->rx_cmp_misc_v1);
-- 
2.19.1



