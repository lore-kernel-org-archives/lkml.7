Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD4FC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94FE20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557207826;
	bh=dL6rAOH5fTYZkLqGJXikIDn4M18h3IAezKwUhDlz4hY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NlIZtqUITP/iksX/Q4wepY7L7DZtkgmxhJvD4k8y4WrUnW5vEm8x1RbxjzJYhxS37
	 nIuDQ16P903GGdts0A6anBDjjyYpsf3C1lzoi000xpungxGlwccpiOBpfaQcYLwzia
	 3pudf+jZEC9nXlqsY2ZvUgi4kQW5fCq0o2uH3tNc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfEGFnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:43:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729662AbfEGFmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:42:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11CD9205ED;
        Tue,  7 May 2019 05:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207771;
        bh=dL6rAOH5fTYZkLqGJXikIDn4M18h3IAezKwUhDlz4hY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olCwDFlQF3y12iXiHnYVUzsvFzAo88s8zs9FKzb5Rb+nyW7BpwUPIBxv5CvGEURHP
         w7sSqH4MU4cI84uTxX4uU/dZZ8mg7u5kwtBLOH8c+MJUZgda1jO3mzMYeY05qBOKXN
         tiduHpIpUHbeGnvZmgFBXIxxGYOb2NoHSKOGogGo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 03/10] s390/dasd: Fix capacity calculation for large volumes
Date:   Tue,  7 May 2019 01:42:39 -0400
Message-Id: <20190507054247.537-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507054247.537-1-sashal@kernel.org>
References: <20190507054247.537-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oberparleiter <oberpar@linux.ibm.com>

[ Upstream commit 2cc9637ce825f3a9f51f8f78af7474e9e85bfa5f ]

The DASD driver incorrectly limits the maximum number of blocks of ECKD
DASD volumes to 32 bit numbers. Volumes with a capacity greater than
2^32-1 blocks are incorrectly recognized as smaller volumes.

This results in the following volume capacity limits depending on the
formatted block size:

  BLKSIZE  MAX_GB   MAX_CYL
      512    2047   5843492
     1024    4095   8676701
     2048    8191  13634816
     4096   16383  23860929

The same problem occurs when a volume with more than 17895697 cylinders
is accessed in raw-track-access mode.

Fix this problem by adding an explicit type cast when calculating the
maximum number of blocks.

Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 4bbcdf991c26..4856e5bbb42f 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2031,14 +2031,14 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 	blk_per_trk = recs_per_track(&private->rdc_data, 0, block->bp_block);
 
 raw:
-	block->blocks = (private->real_cyl *
+	block->blocks = ((unsigned long) private->real_cyl *
 			  private->rdc_data.trk_per_cyl *
 			  blk_per_trk);
 
 	dev_info(&device->cdev->dev,
-		 "DASD with %d KB/block, %d KB total size, %d KB/track, "
+		 "DASD with %u KB/block, %lu KB total size, %u KB/track, "
 		 "%s\n", (block->bp_block >> 10),
-		 ((private->real_cyl *
+		 (((unsigned long) private->real_cyl *
 		   private->rdc_data.trk_per_cyl *
 		   blk_per_trk * (block->bp_block >> 9)) >> 1),
 		 ((blk_per_trk * block->bp_block) >> 10),
-- 
2.20.1

