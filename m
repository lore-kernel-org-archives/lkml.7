Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC364C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D36F2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564739148;
	bh=ppr5BAOLZkqvQ0hhuWwGlJX9zzXOdBVO8hauVU+jdio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q4LfAGDZ6tCIR+f8fgwOL9MsZrjgHJ2M6q8s6HQ+67xWF7Eq6YQsamMMTJ6yIyQiF
	 c9ff1JhUHcr1kwxwpwVNGJeWTp/achJIsoSS6HxG6Xn+mf6hSO19lyqgYU1BPW9Mlg
	 TLO0f6aLne7nh4j6gpbmEnv8beg33Zd/jyk7SuEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392011AbfHBJpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391999AbfHBJpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:45:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B84F206A2;
        Fri,  2 Aug 2019 09:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564739142;
        bh=ppr5BAOLZkqvQ0hhuWwGlJX9zzXOdBVO8hauVU+jdio=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TxVeltpAJOdRUenZMO+363gmBVH0/3/eWYdsxi4zsxzjf8U90QU+0J7bqJQcNhslx
         a5ABcnKvFkq1OPWivS+gOrMNi2yYcjVN/tLDULo/fJs2r0mr7P/kHyFroP//XYGBSQ
         IqyEZo/03qljbBJ6Z+TMI6zLkTHiBAuRkPyC34sM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian King <brking@linux.vnet.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 129/223] bnx2x: Prevent load reordering in tx completion processing
Date:   Fri,  2 Aug 2019 11:35:54 +0200
Message-Id: <20190802092247.364104604@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092238.692035242@linuxfoundation.org>
References: <20190802092238.692035242@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian King <brking@linux.vnet.ibm.com>

[ Upstream commit ea811b795df24644a8eb760b493c43fba4450677 ]

This patch fixes an issue seen on Power systems with bnx2x which results
in the skb is NULL WARN_ON in bnx2x_free_tx_pkt firing due to the skb
pointer getting loaded in bnx2x_free_tx_pkt prior to the hw_cons
load in bnx2x_tx_int. Adding a read memory barrier resolves the issue.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -286,6 +286,9 @@ int bnx2x_tx_int(struct bnx2x *bp, struc
 	hw_cons = le16_to_cpu(*txdata->tx_cons_sb);
 	sw_cons = txdata->tx_pkt_cons;
 
+	/* Ensure subsequent loads occur after hw_cons */
+	smp_rmb();
+
 	while (sw_cons != hw_cons) {
 		u16 pkt_cons;
 


