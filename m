Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B5C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E40E20679
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560441900;
	bh=VbiQpM1EDRF7mWpHDc7VlyU2NWnMot2MNCxyXyGDy2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hpvFlraZ3DyQ5AqTjCA51W/5pMIAiOEJ84ZkNQkjCPkg11V+OYdrkCHp7E9qA4D8h
	 Jctcs52jEtyveXzWZMd9bZoStb2RXulrgTqJDJjrhMj5p1xTtZNjipb53H4RKryand
	 1p+Xarz1kMOeW73fhUiBB0TmwJlcI5SwRZaRe3zQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390462AbfFMQEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:04:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731353AbfFMIq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:46:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D86062173C;
        Thu, 13 Jun 2019 08:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415615;
        bh=VbiQpM1EDRF7mWpHDc7VlyU2NWnMot2MNCxyXyGDy2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bfGeaXHtWWAFaIiCxVQxeWEySeIRnQW0w8AAVUB/owqvR82ZfUlRTLFrn4dME6YEV
         AbZ/kr6lKPyXVKtBlFs1vZF+M48v/zBk7XL3fL+XGnJrqSD/l9C+W7YJpXhPnbjRyM
         BASFlzmrIFmdtRO2QnjR5VSsoysLqsS2aTqlOtRU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 064/155] netfilter: nf_flow_table: fix missing error check for rhashtable_insert_fast
Date:   Thu, 13 Jun 2019 10:32:56 +0200
Message-Id: <20190613075656.612439190@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075652.691765927@linuxfoundation.org>
References: <20190613075652.691765927@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 43c8f131184faf20c07221f3e09724611c6525d8 ]

rhashtable_insert_fast() may return an error value when memory
allocation fails, but flow_offload_add() does not check for errors.
This patch just adds missing error checking.

Fixes: ac2a66665e23 ("netfilter: add generic flow table infrastructure")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_flow_table_core.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 7aabfd4b1e50..a9e4f74b1ff6 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -185,14 +185,25 @@ static const struct rhashtable_params nf_flow_offload_rhash_params = {
 
 int flow_offload_add(struct nf_flowtable *flow_table, struct flow_offload *flow)
 {
-	flow->timeout = (u32)jiffies;
+	int err;
 
-	rhashtable_insert_fast(&flow_table->rhashtable,
-			       &flow->tuplehash[FLOW_OFFLOAD_DIR_ORIGINAL].node,
-			       nf_flow_offload_rhash_params);
-	rhashtable_insert_fast(&flow_table->rhashtable,
-			       &flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].node,
-			       nf_flow_offload_rhash_params);
+	err = rhashtable_insert_fast(&flow_table->rhashtable,
+				     &flow->tuplehash[0].node,
+				     nf_flow_offload_rhash_params);
+	if (err < 0)
+		return err;
+
+	err = rhashtable_insert_fast(&flow_table->rhashtable,
+				     &flow->tuplehash[1].node,
+				     nf_flow_offload_rhash_params);
+	if (err < 0) {
+		rhashtable_remove_fast(&flow_table->rhashtable,
+				       &flow->tuplehash[0].node,
+				       nf_flow_offload_rhash_params);
+		return err;
+	}
+
+	flow->timeout = (u32)jiffies;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(flow_offload_add);
-- 
2.20.1



