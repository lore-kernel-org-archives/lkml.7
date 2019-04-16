Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA3DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285B322400
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555424423;
	bh=PM9cB3u6E0jV9mNsw91C+YufEQcVaQ/IBLLipHz/36Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HWKWsoQhoQRR49r2W/aZJfP+QAy5JTX6RFbnVy/RFLWkmjzuJZro6RR7d3yzqBRAK
	 1r7t+kOQqsRxIBqvhPziMU4hDGNrYemu6lQKzXWKFgKqZycBmtkLAIzGNjMiD8rSZm
	 l2/FNSocbeeIZCGfZuajyeJ620/kuRK43RvFuKLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfDPOUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:20:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbfDPOUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:20:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA9E42240F;
        Tue, 16 Apr 2019 14:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555424420;
        bh=PM9cB3u6E0jV9mNsw91C+YufEQcVaQ/IBLLipHz/36Y=;
        h=Date:From:To:Cc:Subject:From;
        b=lqIjGKJXK9g09oiiVq6hgO6BPtehWp0t9AsKswXxVok1XT8fbN8PUhSm+GXaZPu7C
         eY+dQqrLiiTeUcCpJrYSar96/pCWmfpXkglnCx8Kx7fpb84s+Zaygnl5wrZA/lZHq+
         zRyRSNriAzILDBibwDCDI8sMCLo1sFo+YYr0gkdA=
Date:   Tue, 16 Apr 2019 16:15:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: no need to check return value of debugfs_create
 functions
Message-ID: <20190416141554.GA30865@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mailbox/bcm-flexrm-mailbox.c | 27 +++++----------------------
 drivers/mailbox/bcm-pdc-mailbox.c    |  8 ++------
 2 files changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index a64116586b4c..d2053145f224 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -296,8 +296,6 @@ struct flexrm_mbox {
 	struct dma_pool *bd_pool;
 	struct dma_pool *cmpl_pool;
 	struct dentry *root;
-	struct dentry *config;
-	struct dentry *stats;
 	struct mbox_controller controller;
 };
 
@@ -1603,7 +1601,6 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 					  1 << RING_CMPL_ALIGN_ORDER, 0);
 	if (!mbox->cmpl_pool) {
 		ret = -ENOMEM;
-		goto fail_destroy_bd_pool;
 	}
 
 	/* Allocate platform MSIs for each ring */
@@ -1624,28 +1621,15 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 
 	/* Create debugfs root entry */
 	mbox->root = debugfs_create_dir(dev_name(mbox->dev), NULL);
-	if (IS_ERR_OR_NULL(mbox->root)) {
-		ret = PTR_ERR_OR_ZERO(mbox->root);
-		goto fail_free_msis;
-	}
 
 	/* Create debugfs config entry */
-	mbox->config = debugfs_create_devm_seqfile(mbox->dev,
-						   "config", mbox->root,
-						   flexrm_debugfs_conf_show);
-	if (IS_ERR_OR_NULL(mbox->config)) {
-		ret = PTR_ERR_OR_ZERO(mbox->config);
-		goto fail_free_debugfs_root;
-	}
+	debugfs_create_devm_seqfile(mbox->dev, "config", mbox->root,
+				    flexrm_debugfs_conf_show);
 
 	/* Create debugfs stats entry */
-	mbox->stats = debugfs_create_devm_seqfile(mbox->dev,
-						  "stats", mbox->root,
-						  flexrm_debugfs_stats_show);
-	if (IS_ERR_OR_NULL(mbox->stats)) {
-		ret = PTR_ERR_OR_ZERO(mbox->stats);
-		goto fail_free_debugfs_root;
-	}
+	debugfs_create_devm_seqfile(mbox->dev, "stats", mbox->root,
+				    flexrm_debugfs_stats_show);
+
 skip_debugfs:
 
 	/* Initialize mailbox controller */
@@ -1676,7 +1660,6 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
 
 fail_free_debugfs_root:
 	debugfs_remove_recursive(mbox->root);
-fail_free_msis:
 	platform_msi_domain_free_irqs(dev);
 fail_destroy_cmpl_pool:
 	dma_pool_destroy(mbox->cmpl_pool);
diff --git a/drivers/mailbox/bcm-pdc-mailbox.c b/drivers/mailbox/bcm-pdc-mailbox.c
index ccf3d62af7e7..a8c291386142 100644
--- a/drivers/mailbox/bcm-pdc-mailbox.c
+++ b/drivers/mailbox/bcm-pdc-mailbox.c
@@ -406,8 +406,6 @@ struct pdc_state {
 	 */
 	struct scatterlist *src_sg[PDC_RING_ENTRIES];
 
-	struct dentry *debugfs_stats;  /* debug FS stats file for this PDC */
-
 	/* counters */
 	u32  pdc_requests;     /* number of request messages submitted */
 	u32  pdc_replies;      /* number of reply messages received */
@@ -512,9 +510,8 @@ static void pdc_setup_debugfs(struct pdc_state *pdcs)
 		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
 
 	/* S_IRUSR == 0400 */
-	pdcs->debugfs_stats = debugfs_create_file(spu_stats_name, 0400,
-						  debugfs_dir, pdcs,
-						  &pdc_debugfs_stats);
+	debugfs_create_file(spu_stats_name, 0400, debugfs_dir, pdcs,
+			    &pdc_debugfs_stats);
 }
 
 static void pdc_free_debugfs(void)
@@ -1614,7 +1611,6 @@ static int pdc_probe(struct platform_device *pdev)
 	if (err)
 		goto cleanup_buf_pool;
 
-	pdcs->debugfs_stats = NULL;
 	pdc_setup_debugfs(pdcs);
 
 	dev_dbg(dev, "pdc_probe() successful");
-- 
2.21.0

