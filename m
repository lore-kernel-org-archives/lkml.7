Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E13C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BBA3218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116934;
	bh=/Bp8dNBFUw1zFf0oSgL06Lz+3C1o0TfVKYdQyeFy1xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZC5sCOQrCH33WR/zxqn7H/6sTJa3ix02A7QFqGGyu9CT2gYLAS0OPr5v6Zwevq205
	 0nQfuHx2dwdPqNHI7fGtyEMX2GE25oNvr8qKbymj3UiqCcZw0EFEYY8rUm/95rvglW
	 MD2M4BRabo9sOfOymHlJTPNvwFWUFHXaqE0CPeZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbfDXOmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731503AbfDXOk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:40:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85B221909;
        Wed, 24 Apr 2019 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116857;
        bh=/Bp8dNBFUw1zFf0oSgL06Lz+3C1o0TfVKYdQyeFy1xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TwVL9noMDw7TmeGaS9/JhNOMfGeAi8P1gZtPDNIU6W366ORd3CcNRzTkZbu0bt4Na
         gKzNyM9ry70qPsUiCjrEAGo0aRL/rKPeGtn+hSPzqnT+uDRvJmkPpoJI5+LHgzBcW8
         UQ5kCJcpr8Vfn6SQGfxsCRyQWMTD8QRT26jzYbnE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Varun Prakash <varun@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 42/52] libcxgb: fix incorrect ppmax calculation
Date:   Wed, 24 Apr 2019 10:39:00 -0400
Message-Id: <20190424143911.28890-42-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143911.28890-1-sashal@kernel.org>
References: <20190424143911.28890-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Varun Prakash <varun@chelsio.com>

[ Upstream commit cc5a726c79158bd307150e8d4176ec79b52001ea ]

BITS_TO_LONGS() uses DIV_ROUND_UP() because of
this ppmax value can be greater than available
per cpu page pods.

This patch removes BITS_TO_LONGS() to fix this
issue.

Signed-off-by: Varun Prakash <varun@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.19.1

