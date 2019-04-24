Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC38C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3CF21903
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116565;
	bh=036uDLZBpWFkIeUwwhsl8vJev4VbJtMq0NEC30qZVO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oj0opJgs8+MFppqPYKNxuZnx7lCgXtwx0Wel79ur0nxbvvRO1e2b92ZMbASimI4vO
	 Q/mQwkvaJJSNAwM8Lt5CBWn/YqNRJNZ9tnRm8X7DZAiyP1fVZRupJ+yxzN5wSkzRMV
	 iKbf81EQr7KHFE6RmvCmfBqbBmNsVHTJbhhQAvkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731519AbfDXOgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:36:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731457AbfDXOf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:35:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C6AC21900;
        Wed, 24 Apr 2019 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116556;
        bh=036uDLZBpWFkIeUwwhsl8vJev4VbJtMq0NEC30qZVO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k4aC8Hi/wfbpQeUcOFGepzWQuTDnTU3krdaX3i/21DIZDBOd7Ran+Uprue/qlkgdb
         CUnnKmCTvFQaz/fkKqFQHLrSqABTGeZLJ9Gji3VSU89ImpQ8LwgoJGegEAlIqqDuYo
         cT7FquTWntoFsR4Id5x5qkSTrh0NuPaRXR72X36s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Varun Prakash <varun@chelsio.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 51/66] libcxgb: fix incorrect ppmax calculation
Date:   Wed, 24 Apr 2019 10:33:25 -0400
Message-Id: <20190424143341.27665-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
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
2.19.1

