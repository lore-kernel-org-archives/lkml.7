Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD75C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94F8218D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355466;
	bh=tT6UrmnX7B2aB3BfZl7ICn98fI2BjaJsD+80LTzYmes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gv7Bhevg99MDRrHwGaOBO9x+R/EVo625AFwDvtZM9PsdwrZaZD9uJmWD3GylNV+CK
	 f1rgk+HuziOzMagB/E4z6hvfkvhSguBSaLDnF4tKcD8hmd/Gvz6n8/lAPeYTzJlEQl
	 nHplh/MD1uM3liIT4LGhvF96HQ61BwK4DJmXtCpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbfDOTLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731147AbfDOTLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E384218A1;
        Mon, 15 Apr 2019 19:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355462;
        bh=tT6UrmnX7B2aB3BfZl7ICn98fI2BjaJsD+80LTzYmes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AEznW6rj51gINKkaJAwHRjTYFqooSpyPkkc845q+TkJty7TfVg/dCWpp0pSjyaOWN
         ubeTzdFOSZY6gkq1FO7TH5lx2ASQoIeoJShaWQ10GgT+mjMi2khOFwTrLOAlYxL6Ro
         rdCBy4n+OmkrxKpj52mu1+QOHDdnhBwr8ZAkGjkA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 030/117] bnxt_en: Improve RX consumer index validity check.
Date:   Mon, 15 Apr 2019 21:00:00 +0200
Message-Id: <20190415183746.444527302@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
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
index 803f7990d32b..351417e74ae2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1129,6 +1129,8 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 	tpa_info = &rxr->rx_tpa[agg_id];
 
 	if (unlikely(cons != rxr->rx_next_cons)) {
+		netdev_warn(bp->dev, "TPA cons %x != expected cons %x\n",
+			    cons, rxr->rx_next_cons);
 		bnxt_sched_reset(bp, rxr);
 		return;
 	}
@@ -1581,15 +1583,17 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 	}
 
 	cons = rxcmp->rx_cmp_opaque;
-	rx_buf = &rxr->rx_buf_ring[cons];
-	data = rx_buf->data;
-	data_ptr = rx_buf->data_ptr;
 	if (unlikely(cons != rxr->rx_next_cons)) {
 		int rc1 = bnxt_discard_rx(bp, cpr, raw_cons, rxcmp);
 
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



