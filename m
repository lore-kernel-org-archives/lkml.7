Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BBCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5BF92082C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255792;
	bh=2YWEHmJf4CDL1yzr0qRA0UpSMJxGOgw9CZDCe2mvRUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oy0o5CLY2gSup1lXNoYZTERxz5oH49dvjR1/+jb6wxpwqPlQCcomZfuf81H8z9Zvo
	 vCItL+/cbFpoCDUhooQKv6Bog5/+N18/i7FfVDaBE7vv59Xpn6nr/fWbkRdo8jJK0F
	 uVcUIgYl4n+y3o/gK1U7dKcsvg2sTfYXsNo3lwUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387533AbfCVL4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:56:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:32916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732975AbfCVL43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:56:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F06A42082C;
        Fri, 22 Mar 2019 11:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255788;
        bh=2YWEHmJf4CDL1yzr0qRA0UpSMJxGOgw9CZDCe2mvRUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VExKhvs/a18KtyEt3jQv3xpviLg4MYSEk6sf5yF7tIcLDzRSvDOGreGEYD2+uzjW7
         NGqIYzUQIy/dGD1SBpbxjt63Ql8YNJuQ6zpveXFIsPEkCWlTy7mPDzvEo7qUXdlnDC
         wbJsjsM3Z2wpZhln1AUEfnqN1dr7ivfnpKZSshXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hadar Gat <hadar.gat@arm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.19 015/280] crypto: ccree - fix free of unallocated mlli buffer
Date:   Fri, 22 Mar 2019 12:12:48 +0100
Message-Id: <20190322111307.163819813@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hadar Gat <hadar.gat@arm.com>

commit a49411959ea6d4915a9fd2a7eb5ba220e6284e9a upstream.

In cc_unmap_aead_request(), call dma_pool_free() for mlli buffer only
if an item is allocated from the pool and not always if there is a
pool allocated.
This fixes a kernel panic when trying to free a non-allocated item.

Cc: stable@vger.kernel.org
Signed-off-by: Hadar Gat <hadar.gat@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccree/cc_buffer_mgr.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -614,10 +614,10 @@ void cc_unmap_aead_request(struct device
 				 hw_iv_size, DMA_BIDIRECTIONAL);
 	}
 
-	/*In case a pool was set, a table was
-	 *allocated and should be released
-	 */
-	if (areq_ctx->mlli_params.curr_pool) {
+	/* Release pool */
+	if ((areq_ctx->assoc_buff_type == CC_DMA_BUF_MLLI ||
+	     areq_ctx->data_buff_type == CC_DMA_BUF_MLLI) &&
+	    (areq_ctx->mlli_params.mlli_virt_addr)) {
 		dev_dbg(dev, "free MLLI buffer: dma=%pad virt=%pK\n",
 			&areq_ctx->mlli_params.mlli_dma_addr,
 			areq_ctx->mlli_params.mlli_virt_addr);


