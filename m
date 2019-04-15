Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1595C282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7479520651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555356487;
	bh=v+EuV75IoSVit2gNtdmgdDDt3iqHUEQwCcJ87e7GBOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xTJM6BcxwoCP+Vma5e6z5jJ++w2doTIC+u9HcCDVZubxMi8QiRM04EczIM5hyOT/x
	 XhZgUZpM3gp9caCASF3tvzqLw5kmOKYTRxGpu8Qvf8Nc1FU/Q9bUouhKo8od26LP+a
	 9/KZGjlFpzfmxLN5bDUFQem9BRZOQ4lXhi9biiA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729267AbfDOTDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbfDOTD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:03:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B669820880;
        Mon, 15 Apr 2019 19:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355006;
        bh=v+EuV75IoSVit2gNtdmgdDDt3iqHUEQwCcJ87e7GBOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fp9BopQMPYBlddZrokfpzJoV615012NMsPwd9vPyhf0HvYb4KTJ09cYbjdCUkzWLv
         fB8Ji/COX2a1hVTHUMegTINjBkaoO4sYxsL5C14zzOMpMfreh6GZzp+BwtqzfMS31z
         IuMMz82BY9j59P9qziat4scA3esyhFu3oSje/cck=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 32/69] bnxt_en: Reset device on RX buffer errors.
Date:   Mon, 15 Apr 2019 20:58:50 +0200
Message-Id: <20190415183731.688756152@linuxfoundation.org>
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

[ Upstream commit 8e44e96c6c8e8fb80b84a2ca11798a8554f710f2 ]

If the RX completion indicates RX buffers errors, the RX ring will be
disabled by firmware and no packets will be received on that ring from
that point on.  Recover by resetting the device.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1557,11 +1557,17 @@ static int bnxt_rx_pkt(struct bnxt *bp,
 
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
 


