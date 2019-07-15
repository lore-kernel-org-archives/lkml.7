Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE42C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481DD2054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563203593;
	bh=tylYfJ8qe9eWn4vawkymXaytyEEvLSMul1aeM0MOwh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i73yZ8HptJJf2JDXOd81l3I0QoLlGE/lH24nISRZBTaZ3OWOcq+dS+UdN8HMTOYLS
	 /zpfipXGY4ndZxM3tuMdw9n/wa3NuF15odpiav7qLtmExQqUMoTcqMRSaFDZZptYw4
	 FbhzFGsFPrjSp6WGh2ZWfwGcLsoLYglUcvV94ioc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730769AbfGONug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 09:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:40576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731005AbfGONub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 09:50:31 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8F4020896;
        Mon, 15 Jul 2019 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563198630;
        bh=tylYfJ8qe9eWn4vawkymXaytyEEvLSMul1aeM0MOwh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixZSPSSU8dfT9/2xIBBP//M9m3VP7q37d1Gv8xPj0soojIpj7UNM3qmzXJmITl20F
         /n0WoAqRLK4Fy3ucYFYleeFaL+U+3PRE4SKOMCjjjliDYq4N+wASpZBH/uWM53shnP
         7zkNbf7rBmWjpQtbqwffIS3mPMwvaFuK/TtOemuk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 065/249] net: hns3: set ops to null when unregister ad_dev
Date:   Mon, 15 Jul 2019 09:43:50 -0400
Message-Id: <20190715134655.4076-65-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715134655.4076-1-sashal@kernel.org>
References: <20190715134655.4076-1-sashal@kernel.org>
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
index fa8b8506b120..738e01393b68 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -251,6 +251,7 @@ void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo)
 
 		ae_algo->ops->uninit_ae_dev(ae_dev);
 		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
+		ae_dev->ops = NULL;
 	}
 
 	list_del(&ae_algo->node);
@@ -351,6 +352,7 @@ void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 		ae_algo->ops->uninit_ae_dev(ae_dev);
 		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
+		ae_dev->ops = NULL;
 	}
 
 	list_del(&ae_dev->node);
-- 
2.20.1

