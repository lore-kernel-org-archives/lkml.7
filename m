Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FFCC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C75522073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354160;
	bh=OA1hSrW6M3hQwKtYysC6eRk0anbuLQQpLqiKlAFncfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XtT79rY/FdpW8TQKUvj1LI/1QIfDSmnLRJUlGeHrJd2oZgYiTPtEVjYpq4rHWunJB
	 YJZ3wo454Fqcnfr5LKa2NpftP20BqGqQegKqLi286oWbJozyN6dcD5ktA0KMrRW7BB
	 Ov/bLqKXfgdAnXS+yFspultrtLoPeShtHUB0i2KA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfDOSrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:47:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728444AbfDOSr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:47:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38371218EA;
        Mon, 15 Apr 2019 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354045;
        bh=OA1hSrW6M3hQwKtYysC6eRk0anbuLQQpLqiKlAFncfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Y0hF3U/zjfVVMeXs3Pvenni1XJTApo6W+5RpVxbVd9ttXGeEDr5u3Kalt48QE7yP
         TdHtTzTr2Z4asF5KbYaQsBpK7l/u3Z4EpabeH/MC+MenHv/06pM9N2wJrqbpZGZoRK
         BB0hxf2mdjokUJUjNLPykRxpp4BJtx5m7hR1rQ7E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 58/76] bnxt_en: Improve RX consumer index validity check.
Date:   Mon, 15 Apr 2019 20:44:22 +0200
Message-Id: <20190415183724.574617059@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -959,6 +959,8 @@ static void bnxt_tpa_start(struct bnxt *
 	tpa_info = &rxr->rx_tpa[agg_id];
 
 	if (unlikely(cons != rxr->rx_next_cons)) {
+		netdev_warn(bp->dev, "TPA cons %x != expected cons %x\n",
+			    cons, rxr->rx_next_cons);
 		bnxt_sched_reset(bp, rxr);
 		return;
 	}
@@ -1377,14 +1379,16 @@ static int bnxt_rx_pkt(struct bnxt *bp,
 	}
 
 	cons = rxcmp->rx_cmp_opaque;
-	rx_buf = &rxr->rx_buf_ring[cons];
-	data = rx_buf->data;
 	if (unlikely(cons != rxr->rx_next_cons)) {
 		int rc1 = bnxt_discard_rx(bp, bnapi, raw_cons, rxcmp);
 
+		netdev_warn(bp->dev, "RX cons %x != expected cons %x\n",
+			    cons, rxr->rx_next_cons);
 		bnxt_sched_reset(bp, rxr);
 		return rc1;
 	}
+	rx_buf = &rxr->rx_buf_ring[cons];
+	data = rx_buf->data;
 	prefetch(data);
 
 	agg_bufs = (le32_to_cpu(rxcmp->rx_cmp_misc_v1) & RX_CMP_AGG_BUFS) >>


