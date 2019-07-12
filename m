Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4A2C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359D8208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934399;
	bh=eJjymPxfk4v/tQtwcZbiDbsMpBU0JnS1GnRSFIQMZ6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yWJgFcgIojEj5wkgf9b2JzXvMFIgytCfGSF/ntn+GFnsxmVNyL8vlntjMtMVD7JX6
	 QTWVTRX1oBGW8Edl8LtBM2T2wHzJyoF4BDIurW76q0asmZHdXV9NfT78Wb9FFQbekZ
	 9yogjzaYVdk0k7jwA2GwhDMq5TXPyQIrDf0UW5B4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbfGLM0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:26:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfGLM0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:26:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD992084B;
        Fri, 12 Jul 2019 12:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934395;
        bh=eJjymPxfk4v/tQtwcZbiDbsMpBU0JnS1GnRSFIQMZ6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cwu8oUiVJLKZNI5XFOKaFWsPT4jzvJagQMw+lp1Q2/lHZLSqNlqaOFbMim1YUMRW2
         i/zsZeC6cIsoCmimE005hXf26zPnCVq3jUOt/RLWGl2bgh1Ueho4hGyshruJXFW/v7
         9fTUogkmGYab42+6XQp8F92BijXV10wkT7sgH4Vo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 042/138] ibmvnic: Fix unchecked return codes of memory allocations
Date:   Fri, 12 Jul 2019 14:18:26 +0200
Message-Id: <20190712121630.284926636@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7c940b1a5291e5069d561f5b8f0e51db6b7a259a ]

The return values for these memory allocations are unchecked,
which may cause an oops if the driver does not handle them after
a failure. Fix by checking the function's return code.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 664e52fa7919..0e4029c54241 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -438,9 +438,10 @@ static int reset_rx_pools(struct ibmvnic_adapter *adapter)
 		if (rx_pool->buff_size != be64_to_cpu(size_array[i])) {
 			free_long_term_buff(adapter, &rx_pool->long_term_buff);
 			rx_pool->buff_size = be64_to_cpu(size_array[i]);
-			alloc_long_term_buff(adapter, &rx_pool->long_term_buff,
-					     rx_pool->size *
-					     rx_pool->buff_size);
+			rc = alloc_long_term_buff(adapter,
+						  &rx_pool->long_term_buff,
+						  rx_pool->size *
+						  rx_pool->buff_size);
 		} else {
 			rc = reset_long_term_buff(adapter,
 						  &rx_pool->long_term_buff);
@@ -706,9 +707,9 @@ static int init_tx_pools(struct net_device *netdev)
 			return rc;
 		}
 
-		init_one_tx_pool(netdev, &adapter->tso_pool[i],
-				 IBMVNIC_TSO_BUFS,
-				 IBMVNIC_TSO_BUF_SZ);
+		rc = init_one_tx_pool(netdev, &adapter->tso_pool[i],
+				      IBMVNIC_TSO_BUFS,
+				      IBMVNIC_TSO_BUF_SZ);
 		if (rc) {
 			release_tx_pools(adapter);
 			return rc;
-- 
2.20.1



