Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F826C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC21205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413994;
	bh=uHtJVKX2MUA3u+U/1SGUUR8FVtxRyRdIInzvhHfyh5c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oA9Eg40u4/gol72oo4jy3penpaE5I14DwKxZtSAKHpKbrTNDgoP63mqlr1wY8s5oW
	 LsJ/MtJpkllWLMclgPh0QlFcoKFR75+xCW+YrQAE4OAiJ+m7e3A3yWxgr4u3WwRUof
	 0IoL9g63vrfFP4MFLI3L/NIUU4tdRwf9HtQPNYWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfCLRM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727313AbfCLRMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:10 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2292087C;
        Tue, 12 Mar 2019 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410729;
        bh=uHtJVKX2MUA3u+U/1SGUUR8FVtxRyRdIInzvhHfyh5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SAydgxoT2Po/fZj1Sh7RSrZWU6LOtG+srbT9t24sLChtAGwO/AAF+XFSqEov+Dx2J
         z6Uqimajmd7yymx53bZN/Yp2z7AWYSUEvOEZxdCraKW3zYWDpOfq/9QTvLSS1BVt+0
         MWALglUjIGAwqgEYGX6a+RYXJxxyPn8EUSCGzGb4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 049/171] scsi: 53c700: pass correct "dev" to dma_alloc_attrs()
Date:   Tue, 12 Mar 2019 10:07:09 -0700
Message-Id: <20190312170352.344633198@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 8437fcf14deed67e5ad90b5e8abf62fb20f30881 ]

The "hostdata->dev" pointer is NULL here.  We set "hostdata->dev = dev;"
later in the function and we also use "hostdata->dev" when we call
dma_free_attrs() in NCR_700_release().

This bug predates git version control.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/53c700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index 6be77b3aa8a5..ac79f2088b31 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -295,7 +295,7 @@ NCR_700_detect(struct scsi_host_template *tpnt,
 	if(tpnt->sdev_attrs == NULL)
 		tpnt->sdev_attrs = NCR_700_dev_attrs;
 
-	memory = dma_alloc_attrs(hostdata->dev, TOTAL_MEM_SIZE, &pScript,
+	memory = dma_alloc_attrs(dev, TOTAL_MEM_SIZE, &pScript,
 				 GFP_KERNEL, DMA_ATTR_NON_CONSISTENT);
 	if(memory == NULL) {
 		printk(KERN_ERR "53c700: Failed to allocate memory for driver, detaching\n");
-- 
2.19.1



