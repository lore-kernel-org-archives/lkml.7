Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77049C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4969E20651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563200416;
	bh=rE8nMy7/vOHU+or2H8AqaI7hPew1k1Ln1/KnOmdeNQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uI/Wk3/4IeFTcYiH0Qp3iGZBb+WU3qGApUBgZgI4Cjpes6y1ojfLz4zYnDJVtIn9K
	 X5+tPiTobw2XvP7YYDg3MHvzEFthsAFVkI6zLT29fXltxABb6eQLRwNARu1Wvu+Kvw
	 KdTxHL9caqnzslful6eXqlmLaCJow1zXjG3zrFiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390410AbfGOOUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:20:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390392AbfGOOUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:20:11 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B8F221530;
        Mon, 15 Jul 2019 14:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563200406;
        bh=rE8nMy7/vOHU+or2H8AqaI7hPew1k1Ln1/KnOmdeNQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W/D8SilwHvqbEuXU7iCf+tN7HXvZB0+LWqqNTYtKnLg9/5VAtqyE2JFJlMnk43kgd
         KvoAB/DAExSbaYYR2EbhysCCytSRjJTXIzXHPK4zLXDqALUrTXs1S/UuuUtonLccmk
         Nia9oGFkVpRIPmzbNliTYVQzKQRTkTiW1RTR5EtU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 039/158] net: hns3: set ops to null when unregister ad_dev
Date:   Mon, 15 Jul 2019 10:16:10 -0400
Message-Id: <20190715141809.8445-39-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715141809.8445-1-sashal@kernel.org>
References: <20190715141809.8445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weihang Li <liweihang@hisilicon.com>

[ Upstream commit 594a81b39525f0a17e92c2e0b167ae1400650380 ]

The hclge/hclgevf and hns3 module can be unloaded independently,
when hclge/hclgevf unloaded firstly, the ops of ae_dev should
be set to NULL, otherwise it will cause an use-after-free problem.

Fixes: 38caee9d3ee8 ("net: hns3: Add support of the HNAE3 framework")
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index fff5be8078ac..0594a6c3dccd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -229,6 +229,7 @@ void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo)
 
 		ae_algo->ops->uninit_ae_dev(ae_dev);
 		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
+		ae_dev->ops = NULL;
 	}
 
 	list_del(&ae_algo->node);
@@ -316,6 +317,7 @@ void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 		ae_algo->ops->uninit_ae_dev(ae_dev);
 		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
+		ae_dev->ops = NULL;
 	}
 
 	list_del(&ae_dev->node);
-- 
2.20.1

