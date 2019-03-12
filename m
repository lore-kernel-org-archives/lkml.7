Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D567C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3945205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414074;
	bh=orjHneuR4SDTZKoPZbZotPAPuDr1KREzIr1WhF3Y8RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PepMKnAgNnStF+npbmrY8u0nI3qIowupml3PPOtPXmdsimwd5y3dWsVQOAwHygnAx
	 krMCxvVUnv7yCyMpCdHBEr/nPuEfk4gMi6xrfioxl5ApOMXzA61dYZo6hkySbC56s2
	 8m9OP2pKeHv1c8XFk82y5RXOILjy8zoyPUboxeIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfCLSHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 14:07:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727378AbfCLRMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:18 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B645217D4;
        Tue, 12 Mar 2019 17:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410738;
        bh=orjHneuR4SDTZKoPZbZotPAPuDr1KREzIr1WhF3Y8RQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQxWRdzxp4pW3z4elyad2cT2jMdqfqg5McsXBFKP82vjqJ4smEZyQf8aL3YY6RQ+k
         I5FYfFj0AF9g7GRXzg7DwW+qe2uCBN/254t64kRRLBx4U1Cg76FRvRixvL13ptiMs1
         Wm7tH0Glqgp3XLkSuINMDbKpdMglGNlUstL66CVM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 041/171] qed: Fix bug in tx promiscuous mode settings
Date:   Tue, 12 Mar 2019 10:07:01 -0700
Message-Id: <20190312170351.624564497@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 9e71a15d8b5bbce25c637f7f8833cd3f45b65646 ]

When running tx switched traffic between VNICs
created via a bridge(to which VFs are added),
adapter drops the unicast packets in tx flow due to
VNIC's ucast mac being unknown to it. But VF interfaces
being in promiscuous mode should have caused adapter
to accept all the unknown ucast packets. Later, it
was found that driver doesn't really configure tx
promiscuous mode settings to accept all unknown unicast macs.

This patch fixes tx promiscuous mode settings to accept all
unknown/unmatched unicast macs and works out the scenario.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qed/qed_l2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_l2.c b/drivers/net/ethernet/qlogic/qed/qed_l2.c
index 67c02ea93906..b8baa6fcef8e 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_l2.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_l2.c
@@ -609,6 +609,10 @@ qed_sp_update_accept_mode(struct qed_hwfn *p_hwfn,
 			  (!!(accept_filter & QED_ACCEPT_MCAST_MATCHED) &&
 			   !!(accept_filter & QED_ACCEPT_MCAST_UNMATCHED)));
 
+		SET_FIELD(state, ETH_VPORT_TX_MODE_UCAST_ACCEPT_ALL,
+			  (!!(accept_filter & QED_ACCEPT_UCAST_MATCHED) &&
+			   !!(accept_filter & QED_ACCEPT_UCAST_UNMATCHED)));
+
 		SET_FIELD(state, ETH_VPORT_TX_MODE_BCAST_ACCEPT_ALL,
 			  !!(accept_filter & QED_ACCEPT_BCAST));
 
@@ -2688,7 +2692,8 @@ static int qed_configure_filter_rx_mode(struct qed_dev *cdev,
 	if (type == QED_FILTER_RX_MODE_TYPE_PROMISC) {
 		accept_flags.rx_accept_filter |= QED_ACCEPT_UCAST_UNMATCHED |
 						 QED_ACCEPT_MCAST_UNMATCHED;
-		accept_flags.tx_accept_filter |= QED_ACCEPT_MCAST_UNMATCHED;
+		accept_flags.tx_accept_filter |= QED_ACCEPT_UCAST_UNMATCHED |
+						 QED_ACCEPT_MCAST_UNMATCHED;
 	} else if (type == QED_FILTER_RX_MODE_TYPE_MULTI_PROMISC) {
 		accept_flags.rx_accept_filter |= QED_ACCEPT_MCAST_UNMATCHED;
 		accept_flags.tx_accept_filter |= QED_ACCEPT_MCAST_UNMATCHED;
-- 
2.19.1



