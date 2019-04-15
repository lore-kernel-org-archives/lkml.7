Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC761C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7251E20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356490;
	bh=sDrm8jyvBa7A+2cNEmb9S0o2rOBZtu44DqzSyuXNTr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gRRvHSl6d0Ky5vSrNuXK3itFEIdXvi1RibtPN/i0mYYWIYOzvdz8BQInwEFQy9Zna
	 JE6uLa28lnu42xsJWgeRdYD2ArL2xHpND/BwS9cQaYQOibsAGTR1wQb7L7Cx6KOyGO
	 pel+Zcq/V4VxuR7nkSuVZO5qKEJ99Pnez4q+fHy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfDOTDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729214AbfDOTDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:03:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1099721919;
        Mon, 15 Apr 2019 19:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355003;
        bh=sDrm8jyvBa7A+2cNEmb9S0o2rOBZtu44DqzSyuXNTr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TX7Y2kIZ8lAT2YIiE0cJ0vrM83VlBE0HZ2c/BlKofsCt9Jxv7CfzhKKYH59G88dc7
         VhBvcDh5fWaCNYwrroxibkWbgJPK+Qg3xoiyf/Bvj28V9K6MGDA8cH5TPBPpTSXv3N
         vpSiPPrepGdevsMvH5Nz0mW1xLMZIn3TAhbE6wIg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 31/69] bnxt_en: Improve RX consumer index validity check.
Date:   Mon, 15 Apr 2019 20:58:49 +0200
Message-Id: <20190415183731.578234487@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Chan <michael.chan@broadcom.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1076,6 +1076,8 @@ static void bnxt_tpa_start(struct bnxt *
 	tpa_info = &rxr->rx_tpa[agg_id];
 
 	if (unlikely(cons != rxr->rx_next_cons)) {
+		netdev_warn(bp->dev, "TPA cons %x != expected cons %x\n",
+			    cons, rxr->rx_next_cons);
 		bnxt_sched_reset(bp, rxr);
 		return;
 	}
@@ -1528,15 +1530,17 @@ static int bnxt_rx_pkt(struct bnxt *bp,
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


