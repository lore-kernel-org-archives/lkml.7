Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F6EC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A316218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555354959;
	bh=n5zIPqcgnEyuOKbun8EqKo4ofJRZ2hzchfw0q0toRcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XmkT/1S24kus3aCe/mAOeSvcGylgn6M54YeEr2uoj2JbT7twXbW+i4gWaqmdb9RjP
	 RLfABFN1k6v7Ru/X0zgqMWFuxmaWkWgg5xLnIG8qxCvyQhV+NpQB8hZUM7Nn4caeGf
	 OTYyPqaEwpksTYLXONuzno2Pdv+Z8ggnfKMDKpTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfDOTCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728826AbfDOTCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:02:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B7A7218FE;
        Mon, 15 Apr 2019 19:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555354953;
        bh=n5zIPqcgnEyuOKbun8EqKo4ofJRZ2hzchfw0q0toRcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8K3BJ3Bt9IVgxsqi4DwMgpuEmvTFsksCGNKLcSEcVaGY5mgCkiltoR+/6r5otGaA
         Cj4wPAh/FdIoVAOP4ANwSio2hTWBoEmSQyqmQM3Qj7cEFT6USSmowprCpP4gerlqsI
         RVcdFnyowr6m27j/tJCMPJVdtcnfY3US/AOrAaYY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gilad Ben-Yossef <gilad@benyossef.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 12/69] stating: ccree: revert "staging: ccree: fix leak of import() after init()"
Date:   Mon, 15 Apr 2019 20:58:30 +0200
Message-Id: <20190415183729.200456534@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 293edc27f8bc8a44978e9e95902b07b74f1c7523 upstream

This reverts commit c5f39d07860c ("staging: ccree: fix leak of import()
after init()") and commit aece09024414 ("staging: ccree: Uninitialized
return in ssi_ahash_import()").

This is the wrong solution and ends up relying on uninitialized memory,
although it was not obvious to me at the time.

Cc: stable@vger.kernel.org
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/ccree/ssi_hash.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/ccree/ssi_hash.c b/drivers/staging/ccree/ssi_hash.c
index e266a70a1b32..13291aeaf350 100644
--- a/drivers/staging/ccree/ssi_hash.c
+++ b/drivers/staging/ccree/ssi_hash.c
@@ -1781,7 +1781,7 @@ static int ssi_ahash_import(struct ahash_request *req, const void *in)
 	struct device *dev = &ctx->drvdata->plat_dev->dev;
 	struct ahash_req_ctx *state = ahash_request_ctx(req);
 	u32 tmp;
-	int rc = 0;
+	int rc;
 
 	memcpy(&tmp, in, sizeof(u32));
 	if (tmp != CC_EXPORT_MAGIC) {
@@ -1790,12 +1790,9 @@ static int ssi_ahash_import(struct ahash_request *req, const void *in)
 	}
 	in += sizeof(u32);
 
-	/* call init() to allocate bufs if the user hasn't */
-	if (!state->digest_buff) {
-		rc = ssi_hash_init(state, ctx);
-		if (rc)
-			goto out;
-	}
+	rc = ssi_hash_init(state, ctx);
+	if (rc)
+		goto out;
 
 	dma_sync_single_for_cpu(dev, state->digest_buff_dma_addr,
 				ctx->inter_digestsize, DMA_BIDIRECTIONAL);
-- 
2.19.1



