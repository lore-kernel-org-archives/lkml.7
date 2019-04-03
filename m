Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8DFC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD132084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfDCUus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:50:48 -0400
Received: from gateway20.websitewelcome.com ([192.185.55.25]:29770 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbfDCUur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:50:47 -0400
X-Greylist: delayed 13687 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2019 16:50:47 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id EB50E400C4D08
        for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2019 15:50:46 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id BmqMhRknVdnCeBmqMhH6vv; Wed, 03 Apr 2019 15:50:46 -0500
X-Authority-Reason: nr=8
Received: from [189.250.114.183] (port=53266 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hBmqK-003zZu-38; Wed, 03 Apr 2019 15:50:46 -0500
Date:   Wed, 3 Apr 2019 15:50:43 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] staging: ralink-gdma: Use struct_size() in kzalloc()
Message-ID: <20190403205043.GA17320@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.114.183
X-Source-L: No
X-Exim-ID: 1hBmqK-003zZu-38
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.114.183]:53266
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = kzalloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

size = struct_size(instance, entry, count);

or

instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL)

Based on the above, replace gdma_dma_alloc_desc() with kzalloc() and
use the new struct_size() helper.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/staging/ralink-gdma/ralink-gdma.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/ralink-gdma/ralink-gdma.c b/drivers/staging/ralink-gdma/ralink-gdma.c
index b6d484532269..3228227776dc 100644
--- a/drivers/staging/ralink-gdma/ralink-gdma.c
+++ b/drivers/staging/ralink-gdma/ralink-gdma.c
@@ -169,12 +169,6 @@ static inline void gdma_dma_write(struct gdma_dma_dev *dma_dev,
 	writel(val, dma_dev->base + reg);
 }
 
-static struct gdma_dma_desc *gdma_dma_alloc_desc(unsigned int num_sgs)
-{
-	return kzalloc(sizeof(struct gdma_dma_desc) +
-		sizeof(struct gdma_dma_sg) * num_sgs, GFP_ATOMIC);
-}
-
 static enum gdma_dma_transfer_size gdma_dma_maxburst(u32 maxburst)
 {
 	if (maxburst < 2)
@@ -531,7 +525,7 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_slave_sg(
 	struct scatterlist *sg;
 	unsigned int i;
 
-	desc = gdma_dma_alloc_desc(sg_len);
+	desc = kzalloc(struct_size(desc, sg, sg_len), GFP_ATOMIC);
 	if (!desc) {
 		dev_err(c->device->dev, "alloc sg decs error\n");
 		return NULL;
@@ -586,7 +580,7 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_dma_memcpy(
 	xfer_count = GDMA_REG_CTRL0_TX_MASK;
 	num_periods = DIV_ROUND_UP(len, xfer_count);
 
-	desc = gdma_dma_alloc_desc(num_periods);
+	desc = kzalloc(struct_size(desc, sg, num_periods), GFP_ATOMIC);
 	if (!desc) {
 		dev_err(c->device->dev, "alloc memcpy decs error\n");
 		return NULL;
@@ -631,7 +625,7 @@ static struct dma_async_tx_descriptor *gdma_dma_prep_dma_cyclic(
 	}
 
 	num_periods = buf_len / period_len;
-	desc = gdma_dma_alloc_desc(num_periods);
+	desc = kzalloc(struct_size(desc, sg, num_periods), GFP_ATOMIC);
 	if (!desc) {
 		dev_err(c->device->dev, "alloc cyclic decs error\n");
 		return NULL;
-- 
2.21.0

