Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95AEAC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B94217AB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888580;
	bh=u4cMk57GJBtPgUj1fNsMhqxtKdBQxEFX5HaDeTIiLZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dxOjyPeZWqrzaRuEy1LG61Gx4IQcOMtlY6oao/68GFbIk2TfJavNSTpLl7P0DHsTo
	 TPC8kn/4iUG0xhToGoX9wTWS4N9mt7seqY9g9CJe5DeanJhsHHk3r2PqlSkYkrchVu
	 OzhHILX19qV6Xtr7XaYKEJ8LFGOumy+CcplRA+9w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731977AbfK0VC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:02:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731965AbfK0VCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:02:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30766215F1;
        Wed, 27 Nov 2019 21:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888574;
        bh=u4cMk57GJBtPgUj1fNsMhqxtKdBQxEFX5HaDeTIiLZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yogMqxOpMb9ikIaCe4VJwwzLao76teY/to9TGdCvbfJJBwvOgcsUrmZzPuUPU9f3T
         7lOCDichO+gPLIqWpVvTdYr8cG6hO7MLQedKXl80fIXqE/mPfJq/s1zAQNMYZ5J416
         Dhr8Z1kjHl5DQXh/+1PcI1xKWyJx46ZyEiegzbZg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 185/306] net: hns3: bugfix for buffer not free problem during resetting
Date:   Wed, 27 Nov 2019 21:30:35 +0100
Message-Id: <20191127203128.798931840@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit 73b907a083b8a8c1c62cb494bc9fbe6ae086c460 ]

When hns3_get_ring_config()/hns3_queue_to_ring()/
hns3_get_vector_ring_chain() failed during resetting, the allocated
memory has not been freed before these three functions return. So
this patch adds error handler in these functions to fix it.

Fixes: 76ad4f0ee747 ("net: hns3: Add support of HNS3 Ethernet Driver for hip08 SoC")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index e11a7de20b8f4..3708f149d0a6a 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2547,7 +2547,7 @@ static int hns3_get_vector_ring_chain(struct hns3_enet_tqp_vector *tqp_vector,
 			chain = devm_kzalloc(&pdev->dev, sizeof(*chain),
 					     GFP_KERNEL);
 			if (!chain)
-				return -ENOMEM;
+				goto err_free_chain;
 
 			cur_chain->next = chain;
 			chain->tqp_index = tx_ring->tqp->tqp_index;
@@ -2577,7 +2577,7 @@ static int hns3_get_vector_ring_chain(struct hns3_enet_tqp_vector *tqp_vector,
 	while (rx_ring) {
 		chain = devm_kzalloc(&pdev->dev, sizeof(*chain), GFP_KERNEL);
 		if (!chain)
-			return -ENOMEM;
+			goto err_free_chain;
 
 		cur_chain->next = chain;
 		chain->tqp_index = rx_ring->tqp->tqp_index;
@@ -2592,6 +2592,16 @@ static int hns3_get_vector_ring_chain(struct hns3_enet_tqp_vector *tqp_vector,
 	}
 
 	return 0;
+
+err_free_chain:
+	cur_chain = head->next;
+	while (cur_chain) {
+		chain = cur_chain->next;
+		devm_kfree(&pdev->dev, chain);
+		cur_chain = chain;
+	}
+
+	return -ENOMEM;
 }
 
 static void hns3_free_vector_ring_chain(struct hns3_enet_tqp_vector *tqp_vector,
@@ -2836,8 +2846,10 @@ static int hns3_queue_to_ring(struct hnae3_queue *tqp,
 		return ret;
 
 	ret = hns3_ring_get_cfg(tqp, priv, HNAE3_RING_TYPE_RX);
-	if (ret)
+	if (ret) {
+		devm_kfree(priv->dev, priv->ring_data[tqp->tqp_index].ring);
 		return ret;
+	}
 
 	return 0;
 }
@@ -2864,6 +2876,12 @@ static int hns3_get_ring_config(struct hns3_nic_priv *priv)
 
 	return 0;
 err:
+	while (i--) {
+		devm_kfree(priv->dev, priv->ring_data[i].ring);
+		devm_kfree(priv->dev,
+			   priv->ring_data[i + h->kinfo.num_tqps].ring);
+	}
+
 	devm_kfree(&pdev->dev, priv->ring_data);
 	return ret;
 }
-- 
2.20.1



