Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE76EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB7B20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140843;
	bh=lr0BJbnQPIpB4+7vWHD9eMPfQwD1PL9E88YbH0ykHn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uBNJpHtelGQvIqpfgAFIGxmHFtc+8BQlNyUk3t+DG8kyaf68Ka557Y9NKqYeIl664
	 j+xTYFy9xSSPycN5xWj/QNzFwNaOVNq3Z3kIlhsypV4Yu8yfZUOEU3CdEUO/bcnuID
	 ToTm8wLBv4qNeH7IA6UGI+MXLpHiGx6tzwqvnlhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387506AbfDARrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:47:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbfDARcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:32:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4AE20830;
        Mon,  1 Apr 2019 17:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139938;
        bh=lr0BJbnQPIpB4+7vWHD9eMPfQwD1PL9E88YbH0ykHn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aG43ioqQq7TKhKn8dEqEEVTLP35vHge/BmERowtLp+VCWIYIt77sxeHF2vKdihwqm
         qVFYCnb4wbqD0tdKFePvu0tLghRNYFj2TSOeWANebp6q2KmbJ6ae/m7YKgmHyZF4JR
         LGL9B+18cKz5lhvXgssEE0CJL/csWAL6l6Msgu0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Chuanxiao Dong <chuanxiao.dong@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Austin S Hemmelgarn <ahferroin7@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Android Kernel Team <kernel-team@android.com>,
        linux-mmc@vger.kernel.org, Colin Cross <ccross@android.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 041/131] mmc: block: Allow more than 8 partitions per card
Date:   Mon,  1 Apr 2019 19:01:51 +0200
Message-Id: <20190401170055.758383574@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 382c55f88ffeb218c446bf0c46d0fc25d2795fe2 ]

It is quite common for Android devices to utilize more
then 8 partitions on internal eMMC storage.

The vanilla kernel can support this via
CONFIG_MMC_BLOCK_MINORS, however that solution caps the
system to 256 minors total, which limits the number of
mmc cards the system can support.

This patch, which has been carried for quite awhile in
the AOSP common tree, provides an alternative solution
that doesn't seem to limit the total card count. So I
wanted to submit it for consideration upstream.

This patch sets the GENHD_FL_EXT_DEVT flag, which will
allocate minor number in major 259 for partitions past
disk->minors.

It also removes the use of disk_devt to determine devidx
from md->disk. md->disk->first_minor is always initialized
from devidx and can always be used to recover it.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ben Hutchings <ben@decadent.org.uk>
Cc: Chuanxiao Dong <chuanxiao.dong@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Austin S Hemmelgarn <ahferroin7@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Android Kernel Team <kernel-team@android.com>
Cc: linux-mmc@vger.kernel.org
Signed-off-by: Colin Cross <ccross@android.com>
[jstultz: Added context to commit message]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/card/block.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index f2b733275a0a..c15b879c3070 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -171,11 +171,7 @@ static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
 
 static inline int mmc_get_devidx(struct gendisk *disk)
 {
-	int devmaj = MAJOR(disk_devt(disk));
-	int devidx = MINOR(disk_devt(disk)) / perdev_minors;
-
-	if (!devmaj)
-		devidx = disk->first_minor / perdev_minors;
+	int devidx = disk->first_minor / perdev_minors;
 	return devidx;
 }
 
@@ -2252,6 +2248,7 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 	md->disk->queue = md->queue.queue;
 	md->disk->driverfs_dev = parent;
 	set_disk_ro(md->disk, md->read_only || default_ro);
+	md->disk->flags = GENHD_FL_EXT_DEVT;
 	if (area_type & (MMC_BLK_DATA_AREA_RPMB | MMC_BLK_DATA_AREA_BOOT))
 		md->disk->flags |= GENHD_FL_NO_PART_SCAN;
 
-- 
2.19.1



