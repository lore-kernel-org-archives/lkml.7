Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F3C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83DE8206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 16:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560098926;
	bh=bvmGVxDktvuZtgkDpHt1Zo5XSOeIlP4VhxJB8X4IWPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TSYoCX7dFG4Imm79WHyLIxPGhEMEDwQvub31R/guiEHkpTJ1187tUKqJjCdn4SQg6
	 Ia5LawHCFofdAA4KlNvK5JnRzYPhjM8/s+5k3NVkUg5iAJViAsk/OlMTm6CozuoihL
	 9/IXSoZ27cUJaYqh+9RPoIiK/Qm/mGOZvjdUMVOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbfFIQsp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:48:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731232AbfFIQsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:48:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61063206C3;
        Sun,  9 Jun 2019 16:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560098922;
        bh=bvmGVxDktvuZtgkDpHt1Zo5XSOeIlP4VhxJB8X4IWPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmU2stW+baaMDV9p9nw+vjaexsxeaKyDrpGxYr0V2RFvPU+84IGTeYgaa5WxuuY8Q
         qCOXwqpLdXuoUWRePuqpc9fYy92tyedy7dILriPVnIiQyemFjTLyg5Io75WjgpW1yS
         noEvM7j2r7mMhqMGgz8hDc5zGUMU66ZVSKzy3pkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 06/51] net: ethernet: ti: cpsw_ethtool: fix ethtool ring param set
Date:   Sun,  9 Jun 2019 18:41:47 +0200
Message-Id: <20190609164127.486751888@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164127.123076536@linuxfoundation.org>
References: <20190609164127.123076536@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

[ Upstream commit 09faf5a7d7c0bcb07faba072f611937af9dd5788 ]

Fix ability to set RX descriptor number, the reason - initially
"tx_max_pending" was set incorrectly, but the issue appears after
adding sanity check, so fix is for "sanity" patch.

Fixes: 37e2d99b59c476 ("ethtool: Ensure new ring parameters are within bounds during SRINGPARAM")
Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/ti/cpsw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -2978,7 +2978,7 @@ static void cpsw_get_ringparam(struct ne
 	struct cpsw_common *cpsw = priv->cpsw;
 
 	/* not supported */
-	ering->tx_max_pending = 0;
+	ering->tx_max_pending = descs_pool_size - CPSW_MAX_QUEUES;
 	ering->tx_pending = cpdma_get_num_tx_descs(cpsw->dma);
 	ering->rx_max_pending = descs_pool_size - CPSW_MAX_QUEUES;
 	ering->rx_pending = cpdma_get_num_rx_descs(cpsw->dma);


