Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7307C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF92217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504689;
	bh=1ksWpowktPFU9b+CbANnhXbA8OZTnbVrxRVwq2jrdCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r1erUBX0Iw3FCS4Tiqm2i1rf5C7nJxKdh8NF0H0m/iDgFmTq91GEY7CTKuXpPAEjl
	 itXhr2Nd88h/TfYJPbxXTU7Mw+HVfxx1dUyVhu07O1/IzqCQiCsRkEfEjDKY4Imd0z
	 vYCdbuMSxzwaY0NMFxQwM/d151jzs73NvbRwSrQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfCMTSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728997AbfCMTSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:18:01 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 689312184E;
        Wed, 13 Mar 2019 19:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504680;
        bh=1ksWpowktPFU9b+CbANnhXbA8OZTnbVrxRVwq2jrdCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qi6cq4itz/4ML7dzA1Qx5gjnl8PdoCR6T3LhXmiZtQ8JVo+s8qkOsMwsLNAEOwLOx
         L7wUR4GM2a+zJNHC/2wVKzCLH6/R+w507YW4N+WYijkjE5+iugv6s0+Ap9M+uCtbgD
         XerDxXDIQakwElkd0Jetbm6luk3N6iCEjxfG0N4o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Wenan <maowenan@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 24/24] net: set static variable an initial value in atl2_probe()
Date:   Wed, 13 Mar 2019 15:16:47 -0400
Message-Id: <20190313191647.160171-24-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191647.160171-1-sashal@kernel.org>
References: <20190313191647.160171-1-sashal@kernel.org>
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
index 2ff465848b65..097a0bf592ab 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1338,13 +1338,11 @@ static int atl2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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

