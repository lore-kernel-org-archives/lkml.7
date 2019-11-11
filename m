Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55D0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0A621925
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498366;
	bh=tY0oOqPs5y4Z3QzaxhFPBAKTG3CHb+oGU/zS+s/xIZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X0M946x1fcf0St934WkSvdGdoEc4S33X2Ww/sLaEwYXG/8RYbyij8QEjkwUvW9MQw
	 k25IdjbfgBmL4RdPw5toHWqjdqjmgOmnxfYVfjGwHup6UiJE0JDoZOd5mxS1PJW8FV
	 UIwKkaMqv3u6n3sUSQMynaQ1KbmSoOPmTJsP24qY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfKKSwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:52:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:47060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729650AbfKKSwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:52:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0829214E0;
        Mon, 11 Nov 2019 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573498360;
        bh=tY0oOqPs5y4Z3QzaxhFPBAKTG3CHb+oGU/zS+s/xIZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDzXOJNz9DfJIXQzHNOeAmvu3f3xKM4BnjPDCwY2+KzOvoq58UBxDhStzKwt3JpNk
         w2WYM9whr433IMApbL5QVcE4j4n2aWN6V0RCrUtwNQSIIQ9mVDjDbU4SGxTbUgiAhA
         eCPUES4JZPkyi79syrubUJgVKBDlXbOE7DWS2jlE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenfang Wang <zhenfang.wang@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 096/193] dmaengine: sprd: Fix the possible memory leak issue
Date:   Mon, 11 Nov 2019 19:27:58 +0100
Message-Id: <20191111181508.229679609@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191111181459.850623879@linuxfoundation.org>
References: <20191111181459.850623879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@linaro.org>

[ Upstream commit ec1ac309596a7bdf206743b092748205f6cd5720 ]

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
Link: https://lore.kernel.org/r/170dbbc6d5366b6fa974ce2d366652e23a334251.1570609788.git.baolin.wang@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/sprd-dma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index a4a91f233121a..8546ad0347208 100644
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
2.20.1



