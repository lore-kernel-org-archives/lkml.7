Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE877C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8BA21744
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557436120;
	bh=XILdQ+D024p0eiOqPV0zQVQ24DjYnyMwDWIZGe43PXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RRPfxgil0VTeaQDyE94XX2xCaxCF1PJBiW1iTUbmghzg9nCcDse0YSsBE1feOS+p5
	 RPCnta5Av++qFiBF3hVFE3QvmzbNxB92zuoQmihZzFV+l1Kak9hiuMMS9x1eJRQ87s
	 h4HFdEbQGR7WMA173kn7WCN4U97sSeNMRCKcj5fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfEIVIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:43586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbfEIVIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:08:37 -0400
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27CEA21744;
        Thu,  9 May 2019 21:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557436116;
        bh=XILdQ+D024p0eiOqPV0zQVQ24DjYnyMwDWIZGe43PXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q1KUu20M4YAGg1Yhg1dPXd2xyFd0lENBwfjERpsyxFAwcbGgOVG9FFx5hXMTKnNi0
         rn2RCLujpaYhT5zbCaWaNYq+15fu1v5+R372oSpzI4/66cWkzkBC+T4hfnjImhJD1C
         btPtPfQqU4fpuSQ1dyhW0h+gyaiW134Pq8obeiAQ=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Scott Wood <swood@redhat.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH 2/4] fpga: dfl: afu: Pass the correct device to dma_mapping_error()
Date:   Thu,  9 May 2019 16:08:27 -0500
Message-Id: <20190509210829.31815-3-atull@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509210829.31815-1-atull@kernel.org>
References: <20190509210829.31815-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

dma_mapping_error() was being called on a different device struct than
what was passed to map/unmap.  Besides rendering the error checking
ineffective, it caused a debug splat with CONFIG_DMA_API_DEBUG.

Signed-off-by: Scott Wood <swood@redhat.com>
Acked-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
 drivers/fpga/dfl-afu-dma-region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fpga/dfl-afu-dma-region.c b/drivers/fpga/dfl-afu-dma-region.c
index 0bbc7142f1dc..f7d268f45df0 100644
--- a/drivers/fpga/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl-afu-dma-region.c
@@ -391,7 +391,7 @@ int afu_dma_map_region(struct dfl_feature_platform_data *pdata,
 				    region->pages[0], 0,
 				    region->length,
 				    DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(&pdata->dev->dev, region->iova)) {
+	if (dma_mapping_error(dfl_fpga_pdata_to_parent(pdata), region->iova)) {
 		dev_err(&pdata->dev->dev, "failed to map for dma\n");
 		ret = -EFAULT;
 		goto unpin_pages;
-- 
2.21.0

