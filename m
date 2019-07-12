Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3FAC742BB
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC05721019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562935351;
	bh=1uVnsHHBw5afq9Empk66wTXSxb1ibIYZQmxhAneLeGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qewJDaWVUX1Crl5mpS7/k7LRF+xMl9DXGC9BnUgWxljjrzy3SzU8TmKFfflB6mgG9
	 jqHpCDDA7/s+OpIjHOiE5vdSdSet8o+nvabpc5d592iXgZAmc/OGZKVcekEEIgT2zE
	 9IiWTsupTiIIogCi0uDVtYbNYzziLrfDzV1QRi/o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfGLMUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727372AbfGLMUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:20:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30E6C2166E;
        Fri, 12 Jul 2019 12:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934036;
        bh=1uVnsHHBw5afq9Empk66wTXSxb1ibIYZQmxhAneLeGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2GU1rsRhLTui2i3Hu5CiHAzw3rl37GZfaH1r9gmmwiEhOPGC4WeeEpRrx6lfWhGz
         sMTZBjE17SEAEa7pI8HUHYP6J/qiAiVsWpaP2KoZSidygpneKge7qdh3mITq55f2wB
         i0lVGmepxnxCclfBSlIGuDNxQf3F5JYnSwyDRgaQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Falcon <tlfalcon@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 25/91] ibmvnic: Fix unchecked return codes of memory allocations
Date:   Fri, 12 Jul 2019 14:18:28 +0200
Message-Id: <20190712121622.756093346@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
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
index b88af81499e8..0ae43d27cdcf 100644
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



