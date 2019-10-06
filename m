Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CFC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548E720673
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384401;
	bh=VHqFPei1l3XYQuzGwjYB6MtsKq7T/Rtc2e+h2ot99yM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AmatOZlS6IaR6hoKpZIMRGeuQvOWvgcBHDLWqSDGOO32S0ThZQhuAN4QUYPt/BmUr
	 4qsJ/ip6a9ziwvS0Rf2E3iDQ8lMf4Rg0ieyrh6YT9ThQ11JF8V1ALw8p/pN1AimjWo
	 DG1M8cqu1z9LVg1sXX8WQgHG3CRhau6tTlcL1Mvg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbfJFRxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:53:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729905AbfJFRiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:38:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31D7B20700;
        Sun,  6 Oct 2019 17:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383486;
        bh=VHqFPei1l3XYQuzGwjYB6MtsKq7T/Rtc2e+h2ot99yM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TY2FngfMl5H2kzecF5cBk86Hv6D2gXlcNCNlztPMDL88+bhzrHqV5NDNvK/FaYvw4
         CFXMv9l0NNrCEoGQEMks1eDSHw0pDA1GZEGdHjhln0zJ+3R1Pc+sCXYjrjvWnjL0l0
         UlTMkYGlURA9qM5UVa88Q9mmHXqarJyr1u5P+xXE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunfeng Ye <yeyunfeng@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 121/137] crypto: hisilicon - Fix double free in sec_free_hw_sgl()
Date:   Sun,  6 Oct 2019 19:21:45 +0200
Message-Id: <20191006171219.355393263@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171209.403038733@linuxfoundation.org>
References: <20191006171209.403038733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfeng Ye <yeyunfeng@huawei.com>

[ Upstream commit 24fbf7bad888767bed952f540ac963bc57e47e15 ]

There are two problems in sec_free_hw_sgl():

First, when sgl_current->next is valid, @hw_sgl will be freed in the
first loop, but it free again after the loop.

Second, sgl_current and sgl_current->next_sgl is not match when
dma_pool_free() is invoked, the third parameter should be the dma
address of sgl_current, but sgl_current->next_sgl is the dma address
of next chain, so use sgl_current->next_sgl is wrong.

Fix this by deleting the last dma_pool_free() in sec_free_hw_sgl(),
modifying the condition for while loop, and matching the address for
dma_pool_free().

Fixes: 915e4e8413da ("crypto: hisilicon - SEC security accelerator driver")
Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/sec/sec_algs.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec/sec_algs.c b/drivers/crypto/hisilicon/sec/sec_algs.c
index 02768af0dccdd..8c789b8671fc4 100644
--- a/drivers/crypto/hisilicon/sec/sec_algs.c
+++ b/drivers/crypto/hisilicon/sec/sec_algs.c
@@ -215,17 +215,18 @@ static void sec_free_hw_sgl(struct sec_hw_sgl *hw_sgl,
 			    dma_addr_t psec_sgl, struct sec_dev_info *info)
 {
 	struct sec_hw_sgl *sgl_current, *sgl_next;
+	dma_addr_t sgl_next_dma;
 
-	if (!hw_sgl)
-		return;
 	sgl_current = hw_sgl;
-	while (sgl_current->next) {
+	while (sgl_current) {
 		sgl_next = sgl_current->next;
-		dma_pool_free(info->hw_sgl_pool, sgl_current,
-			      sgl_current->next_sgl);
+		sgl_next_dma = sgl_current->next_sgl;
+
+		dma_pool_free(info->hw_sgl_pool, sgl_current, psec_sgl);
+
 		sgl_current = sgl_next;
+		psec_sgl = sgl_next_dma;
 	}
-	dma_pool_free(info->hw_sgl_pool, hw_sgl, psec_sgl);
 }
 
 static int sec_alg_skcipher_setkey(struct crypto_skcipher *tfm,
-- 
2.20.1



