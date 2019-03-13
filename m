Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D5AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F412177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504373;
	bh=qjJJI4+d5v2AvIUSdKoW+tK0QAIb07HMo0jTon7AonY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qtJKmO8lTiOKtatmfTIv3V4APV9NhDhI0jIPAe/VWR/nWTHnPmP8HF0kY9Xh4bwnn
	 KsGTXrp1rPHipZ/DTKnqSVxoxe0N7tsWBbHtMenLXQuytLXLqaKoE3FqaVUVN5EmDB
	 39Sw9tFOHp/1zU1ayBZZLMQUSyMwwxXy7U36FTMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfCMTMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbfCMTMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:12:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10D942173C;
        Wed, 13 Mar 2019 19:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504366;
        bh=qjJJI4+d5v2AvIUSdKoW+tK0QAIb07HMo0jTon7AonY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzrUYB1oYWjIB1fiTxQOFkzv4NGJNxw9wPIgKmupzV8CauFB7qA3DQ2ZNzx7SzvGE
         7yUg4MO65g8j0W1w48kjvzplH2FWp2g2b8PPXqAQ72vdg6MjONW5ZFTLo1Fa4qwgOQ
         YlMk26N9wRyA4LgAMCHb2SCSWhCY9KCH7e/p/+ME=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Wenan <maowenan@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 59/60] net: set static variable an initial value in atl2_probe()
Date:   Wed, 13 Mar 2019 15:10:20 -0400
Message-Id: <20190313191021.158171-59-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit 4593403fa516a5a4cffe6883c5062d60932cbfbe ]

cards_found is a static variable, but when it enters atl2_probe(),
cards_found is set to zero, the value is not consistent with last probe,
so next behavior is not our expect.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/atlx/atl2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index bb41becb6609..31ff1e0d1baa 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1335,13 +1335,11 @@ static int atl2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct net_device *netdev;
 	struct atl2_adapter *adapter;
-	static int cards_found;
+	static int cards_found = 0;
 	unsigned long mmio_start;
 	int mmio_len;
 	int err;
 
-	cards_found = 0;
-
 	err = pci_enable_device(pdev);
 	if (err)
 		return err;
-- 
2.19.1

