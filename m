Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15522C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E14D220828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566892352;
	bh=Jly0xJPLcDO0et9XMg9aCAgvcZIyJiB73RIFKBqAzO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xwBZ9vyVB5KAVUjDTXM/1h/yypfGdFRF24sae5dDIh6XlL/k1oAyrzwLlxJvhtLTA
	 Sk5x4fdb88XvOngNNXkI6yY9ZSFMf7eD16YKmzeKcAweNerzMt32ybQ9EH63euhBkU
	 sSPaFDGqVknEk8TL9dZ9MvEYpW84jLVho5dFEKEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfH0Hwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 03:52:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729433AbfH0Hw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 03:52:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF422206BA;
        Tue, 27 Aug 2019 07:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566892345;
        bh=Jly0xJPLcDO0et9XMg9aCAgvcZIyJiB73RIFKBqAzO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WxgS87pfZoeB+koDUc4UKjVU5/DHRYBUyUr3oy8OXQ64EeCBzce/+pz6GzOm11Ohu
         vzsWOppIg5QPaKDZGDbZN05DXpsr7aJLZZVkUj1Bf4D1cIPmN1FIjnuRHNPHnQ0sSf
         2reNabuUszBCkowAtvoGhEg9d4zLxZzYiv2LC7rE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 24/62] net: cxgb3_main: Fix a resource leak in a error path in init_one()
Date:   Tue, 27 Aug 2019 09:50:29 +0200
Message-Id: <20190827072701.796451347@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190827072659.803647352@linuxfoundation.org>
References: <20190827072659.803647352@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit debea2cd3193ac868289e8893c3a719c265b0612 ]

A call to 'kfree_skb()' is missing in the error handling path of
'init_one()'.
This is already present in 'remove_one()' but is missing here.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 79053d2ce7a36..338683e5ef1e8 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -3270,7 +3270,7 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!adapter->regs) {
 		dev_err(&pdev->dev, "cannot map device registers\n");
 		err = -ENOMEM;
-		goto out_free_adapter;
+		goto out_free_adapter_nofail;
 	}
 
 	adapter->pdev = pdev;
@@ -3390,6 +3390,9 @@ out_free_dev:
 		if (adapter->port[i])
 			free_netdev(adapter->port[i]);
 
+out_free_adapter_nofail:
+	kfree_skb(adapter->nofail_skb);
+
 out_free_adapter:
 	kfree(adapter);
 
-- 
2.20.1



