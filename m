Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C054AECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BB6F21721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 09:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LoukXlwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbfJIJLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 05:11:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34066 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfJIJLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 05:11:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id y35so1018482pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=O5t0e/gQse8Qw5vCIuQfPPdmME+fzFWGPG6GN+mUsd8=;
        b=LoukXlwGXcDpo42+DF7QA/ampXViZ8/qogRylR7ilMVvqTBR5C9prHUwp/JSDEPfHL
         wsxGbIsyAs24d6jeOL6KuV/JtF+Bv0Ynez+O/OD1IreIVHoI6xvNB3GNlyzXYHlwOlSN
         qs6kclNoibg5qb4HjCbyCz4nrnD4jp51YnY7Vtez7bL2fs8xoHY/Lu483aW2/OhTtrFU
         RkGQp/OlYBo8hzcukAFIAdhIkaiWkCN+pyCR4jwmvA13SyWGlgYSF83Vzk9BBLK64K9D
         ZxKnipZJPSwWSUr0wT+CLOGLFFiTLomqkczZR2ZISQd2W5jqsOVJZ+zRORQdSr6zul80
         Ozew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O5t0e/gQse8Qw5vCIuQfPPdmME+fzFWGPG6GN+mUsd8=;
        b=M5iNPKeeNyXq3MNYBtQdIJMAAqVC/wDJ5hsz6J3Kcu2soeGzWuXaCAANTdCi5t+8gF
         sIyYobNirwJZbQbkfIF/WXxIK+GiLRr3smSI95wgS1k3qJMjBS5FB194YQZXaEP6E5h/
         P/2oUdEk7qcS2gGxH4+7SZDs+VwS90cLSgT6n6J8K0YZ9O0SCZNs622FLceHyZSvTxZd
         Fan3E1ePuAyy0jfNQDP0va+UYdAug0i11nwASVg1kuAfk+Mwvtq7uzYzWrP8KGWfUuLH
         QCr6qv5pKOaYiKr2Tx7Kkvu1AwqKXW8Hhy4cF06ZGCJeQLCxinKqPY3Db3f8oaT3U6b9
         4aDQ==
X-Gm-Message-State: APjAAAWvoASYP0PvxefSlJVXc71iHYaJ2HKcuPbyQSvVWH4rOBGqFvNx
        u5THMpNfSpzBiN6bJCWgWYhqNA==
X-Google-Smtp-Source: APXvYqxPWJdd3eHAZx5Pc7xZksg/1PPFQsG0t5tP1r8W/zu+GmFmqzZFAeJt4f4hsNbkHKos3Ja/ag==
X-Received: by 2002:a63:1c06:: with SMTP id c6mr3153861pgc.417.1570612306950;
        Wed, 09 Oct 2019 02:11:46 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id m68sm1642818pfb.122.2019.10.09.02.11.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Oct 2019 02:11:46 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     vkoul@kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, eric.long@unisoc.com,
        zhenfang.wang@unisoc.com, baolin.wang@linaro.org
Subject: [PATCH] dmaengine: sprd: Fix the possible memory leak issue
Date:   Wed,  9 Oct 2019 17:11:30 +0800
Message-Id: <170dbbc6d5366b6fa974ce2d366652e23a334251.1570609788.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we terminate the channel to free all descriptors associated with this
channel, we will leak the memory of current descriptor if the current
descriptor is not completed, since it had been deteled from the desc_issued
list and have not been added into the desc_completed list.

Thus we should check if current descriptor is completed or not, when freeing
the descriptors associated with one channel, if not, we should free it to
avoid this issue.

Fixes: 9b3b8171f7f4 ("dmaengine: sprd: Add Spreadtrum DMA driver")
Reported-by: Zhenfang Wang <zhenfang.wang@unisoc.com>
Tested-by: Zhenfang Wang <zhenfang.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/dma/sprd-dma.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 60d2c6b..32402c2 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -212,6 +212,7 @@ struct sprd_dma_dev {
 	struct sprd_dma_chn	channels[0];
 };
 
+static void sprd_dma_free_desc(struct virt_dma_desc *vd);
 static bool sprd_dma_filter_fn(struct dma_chan *chan, void *param);
 static struct of_dma_filter_info sprd_dma_info = {
 	.filter_fn = sprd_dma_filter_fn,
@@ -613,12 +614,19 @@ static int sprd_dma_alloc_chan_resources(struct dma_chan *chan)
 static void sprd_dma_free_chan_resources(struct dma_chan *chan)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct virt_dma_desc *cur_vd = NULL;
 	unsigned long flags;
 
 	spin_lock_irqsave(&schan->vc.lock, flags);
+	if (schan->cur_desc)
+		cur_vd = &schan->cur_desc->vd;
+
 	sprd_dma_stop(schan);
 	spin_unlock_irqrestore(&schan->vc.lock, flags);
 
+	if (cur_vd)
+		sprd_dma_free_desc(cur_vd);
+
 	vchan_free_chan_resources(&schan->vc);
 	pm_runtime_put(chan->device->dev);
 }
@@ -1031,15 +1039,22 @@ static int sprd_dma_resume(struct dma_chan *chan)
 static int sprd_dma_terminate_all(struct dma_chan *chan)
 {
 	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
+	struct virt_dma_desc *cur_vd = NULL;
 	unsigned long flags;
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&schan->vc.lock, flags);
+	if (schan->cur_desc)
+		cur_vd = &schan->cur_desc->vd;
+
 	sprd_dma_stop(schan);
 
 	vchan_get_all_descriptors(&schan->vc, &head);
 	spin_unlock_irqrestore(&schan->vc.lock, flags);
 
+	if (cur_vd)
+		sprd_dma_free_desc(cur_vd);
+
 	vchan_dma_desc_free_list(&schan->vc, &head);
 	return 0;
 }
-- 
1.7.9.5

