Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251EEC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA54020874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560342392;
	bh=pwRn6AXU7SWO1tJhlUuy4tZltJqtkI4L1pFotOCpAEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tazH9Eul6GrU7NbaMSSaiTTmOuz36xqf9wri4wi+stwW2r42ONs5tvbGDjIz0ud9P
	 RLtITI+5mdmJ/AZ4v3V0Dh4YM+YkjBG2n3JHjfe3e0asd7DOgIShMIYNE1nWb/nXtZ
	 Y+gwbdgkJkF62aTLoFjvD0KngE7abYWo70QMPzEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbfFLM0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:26:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:59854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfFLM0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:26:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00D69208C4;
        Wed, 12 Jun 2019 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560342384;
        bh=pwRn6AXU7SWO1tJhlUuy4tZltJqtkI4L1pFotOCpAEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1+/Xsan74f4XdgCu9VaU2vkspMbyBS8QvScp8jEVLqbpTrRML8fX+438U2RZ8BwdX
         sfckT6icVtnTgxnNGd4gf70cQmwQk64okzM1M6Q5IrWO56V0wCZ47SifU7dJ+0ucAA
         sX3IAgUh1x3CcIljR90kH0zUlAqcdikJl9zyx+aE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] dma: bcm-sba-raid: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:25:53 +0200
Message-Id: <20190612122557.24158-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612122557.24158-1-gregkh@linuxfoundation.org>
References: <20190612122557.24158-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Also, because there is no need to save the file dentry, remove the
variable that was saving it as it was never even being used once set.

Cc: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/bcm-sba-raid.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index fa81d0177765..275e90fa829d 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -164,7 +164,6 @@ struct sba_device {
 	struct list_head reqs_free_list;
 	/* DebugFS directory entries */
 	struct dentry *root;
-	struct dentry *stats;
 };
 
 /* ====== Command helper routines ===== */
@@ -1716,17 +1715,11 @@ static int sba_probe(struct platform_device *pdev)
 
 	/* Create debugfs root entry */
 	sba->root = debugfs_create_dir(dev_name(sba->dev), NULL);
-	if (IS_ERR_OR_NULL(sba->root)) {
-		dev_err(sba->dev, "failed to create debugfs root entry\n");
-		sba->root = NULL;
-		goto skip_debugfs;
-	}
 
 	/* Create debugfs stats entry */
-	sba->stats = debugfs_create_devm_seqfile(sba->dev, "stats", sba->root,
-						 sba_debugfs_stats_show);
-	if (IS_ERR_OR_NULL(sba->stats))
-		dev_err(sba->dev, "failed to create debugfs stats file\n");
+	debugfs_create_devm_seqfile(sba->dev, "stats", sba->root,
+				    sba_debugfs_stats_show);
+
 skip_debugfs:
 
 	/* Register DMA device with Linux async framework */
-- 
2.22.0

