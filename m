Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE8CC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E95208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560342382;
	bh=hapQOj2oV7lQmVlqOLUMvP5SDFlMe6BD5fHLQJfjJL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=djFQN/PC6ZT6AKWMe7pZPFA/zUL+9nMc7zBB/j+L9zfAOjQ6GHCUsBi6xo1/y7oPw
	 3iQ2jc1hzVBQ1CzPi6ZfuFzJULJZ9o+gWdWhayBVpdVKhD4spwUQuBq+S57mHxEl3+
	 f5vwSM+pBbehkYyk6k0c+xZluONppfHULYu1+EKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438685AbfFLM0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbfFLM0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:26:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26965208CA;
        Wed, 12 Jun 2019 12:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560342378;
        bh=hapQOj2oV7lQmVlqOLUMvP5SDFlMe6BD5fHLQJfjJL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qlVHyjhoutddiPVuU37MsTDl/etrcfE/rThCBroetqyu1eMVEqDUPYPgO9FSKfrVW
         q6UqidoZDJ1rYvU7vlG/fRU1SI5LqfKhFuD75u5e/N0JiFEpiHGqTtEBPNwJ3Q0xrd
         67lmJduvIq5J4y5xJV+vZVmh9v6vBTEuKoLVDBpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dan.j.williams@intel.com, vkoul@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] dma: mic_x100_dma: no need to check return value of debugfs_create functions
Date:   Wed, 12 Jun 2019 14:25:56 +0200
Message-Id: <20190612122557.24158-5-gregkh@linuxfoundation.org>
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

Cc: Sudeep Dutt <sudeep.dutt@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/mic_x100_dma.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/mic_x100_dma.c b/drivers/dma/mic_x100_dma.c
index 6a91e28d537d..584e09661507 100644
--- a/drivers/dma/mic_x100_dma.c
+++ b/drivers/dma/mic_x100_dma.c
@@ -728,10 +728,8 @@ static int mic_dma_driver_probe(struct mbus_device *mbdev)
 	if (mic_dma_dbg) {
 		mic_dma_dev->dbg_dir = debugfs_create_dir(dev_name(&mbdev->dev),
 							  mic_dma_dbg);
-		if (mic_dma_dev->dbg_dir)
-			debugfs_create_file("mic_dma_reg", 0444,
-					    mic_dma_dev->dbg_dir, mic_dma_dev,
-					    &mic_dma_reg_fops);
+		debugfs_create_file("mic_dma_reg", 0444, mic_dma_dev->dbg_dir,
+				    mic_dma_dev, &mic_dma_reg_fops);
 	}
 	return 0;
 }
-- 
2.22.0

