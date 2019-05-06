Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEAEC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04384204EC
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153405;
	bh=EQp7oXnTmCsCwvZ8Cp0LLZDWRQp/lNx09s7/4MGjgmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pIv8YlBGjkE4sg1ySx9Au2tGUC8WY7RvKqSQ71wYxnZluSXr5JUOG6VU6ajmF4vnN
	 O/TODbozSTgZcgP1uqqLPnob3DiWF0wpGvsviTGgaaYRvYmNvF65bgF7kWSmf03fkr
	 dUqjI9irXv9c/mm4/sNYTQhIkO+JzOAZaRwDOYlA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfEFOgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726755AbfEFOgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:36:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25A86204EC;
        Mon,  6 May 2019 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153400;
        bh=EQp7oXnTmCsCwvZ8Cp0LLZDWRQp/lNx09s7/4MGjgmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXpDTPIBa9DPYzuDhVc+GRh19XML8OFnL2Qp/7suWx21uUqVueWAnokvf2q9lzc+H
         +D4AqOFUxweK6JmIKbfBCCFh6KhN0rozNos+fFbWkWlo26va0q4fyYXUDozhipZzAT
         sPOw/VZZm1PDlSGi3LUeNq4LDZyu0xq449FZvBP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Varun Prakash <varun@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 073/122] libcxgb: fix incorrect ppmax calculation
Date:   Mon,  6 May 2019 16:32:11 +0200
Message-Id: <20190506143101.466252453@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143054.670334917@linuxfoundation.org>
References: <20190506143054.670334917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cc5a726c79158bd307150e8d4176ec79b52001ea ]

BITS_TO_LONGS() uses DIV_ROUND_UP() because of
this ppmax value can be greater than available
per cpu page pods.

This patch removes BITS_TO_LONGS() to fix this
issue.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
index 74849be5f004..e2919005ead3 100644
--- a/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
+++ b/drivers/net/ethernet/chelsio/libcxgb/libcxgb_ppm.c
@@ -354,7 +354,10 @@ static struct cxgbi_ppm_pool *ppm_alloc_cpu_pool(unsigned int *total,
 		ppmax = max;
 
 	/* pool size must be multiple of unsigned long */
-	bmap = BITS_TO_LONGS(ppmax);
+	bmap = ppmax / BITS_PER_TYPE(unsigned long);
+	if (!bmap)
+		return NULL;
+
 	ppmax = (bmap * sizeof(unsigned long)) << 3;
 
 	alloc_sz = sizeof(*pools) + sizeof(unsigned long) * bmap;
@@ -402,6 +405,10 @@ int cxgbi_ppm_init(void **ppm_pp, struct net_device *ndev,
 	if (reserve_factor) {
 		ppmax_pool = ppmax / reserve_factor;
 		pool = ppm_alloc_cpu_pool(&ppmax_pool, &pool_index_max);
+		if (!pool) {
+			ppmax_pool = 0;
+			reserve_factor = 0;
+		}
 
 		pr_debug("%s: ppmax %u, cpu total %u, per cpu %u.\n",
 			 ndev->name, ppmax, ppmax_pool, pool_index_max);
-- 
2.20.1



