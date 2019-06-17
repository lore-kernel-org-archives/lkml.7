Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A69EC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C8B208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806465;
	bh=Ze0tQg+VYoEJTS66SX6YjnPROS4quAqXyFUgMLVNzW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fDlVaS4w1VmXis+bBXw4z7q7zlaUEJb7F/7CBgSC6U3eMTpG9tRETtsl3LR7HReZE
	 FyWs9LxVbuUP6oEE2vTsZsWBJUki0cldxSjdL50FnRIUD8L06f6zbcMtqHW3oCrfot
	 0JKS82Y33GwqPW6ZbR1lwrlsnleZc0sGrPY3u4Wk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbfFQVVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729255AbfFQVU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:20:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C056620652;
        Mon, 17 Jun 2019 21:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806459;
        bh=Ze0tQg+VYoEJTS66SX6YjnPROS4quAqXyFUgMLVNzW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TX7XVNJ9agtiY/gUFqTRLiSkNXlAxAhAWn1Z8KILP5RWgtXWBEPpAdxAe4dCkjUtU
         Kgh1q97/uYJVk02s7EZaN1OVjd7jl+0t4IQ3t6rlxO9qqRD0HfC5RcPOIwRxZFjgu2
         /1tTkucg+y5C+URk1qqmEV5qb8gugmUh95DgVJ5A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 060/115] enetc: Fix NULL dma address unmap for Tx BD extensions
Date:   Mon, 17 Jun 2019 23:09:20 +0200
Message-Id: <20190617210803.334871153@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f4a0be84d73ec648628bf8094600ceb73cb6073f ]

For the unlikely case of TxBD extensions (i.e. ptp)
the driver tries to unmap the tx_swbd corresponding
to the extension, which is bogus as it has no buffer
attached.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 5bb9eb35d76d..491475d87736 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -313,7 +313,9 @@ static bool enetc_clean_tx_ring(struct enetc_bdr *tx_ring, int napi_budget)
 	while (bds_to_clean && tx_frm_cnt < ENETC_DEFAULT_TX_WORK) {
 		bool is_eof = !!tx_swbd->skb;
 
-		enetc_unmap_tx_buff(tx_ring, tx_swbd);
+		if (likely(tx_swbd->dma))
+			enetc_unmap_tx_buff(tx_ring, tx_swbd);
+
 		if (is_eof) {
 			napi_consume_skb(tx_swbd->skb, napi_budget);
 			tx_swbd->skb = NULL;
-- 
2.20.1



