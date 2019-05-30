Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECD0C28CC2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2C7244FF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559185879;
	bh=5RLysbjutLyy0H2j0S6gLUuxbUtDMbuWmcgwqXBZXwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bKcC9kgDmowE36pA173jy/fZAhi6XV6vw5jUtRxYqi2YNeCRAavqTOoFEU3JTR8DX
	 gRMbJSwR+IMGa3eTxU0SI67G35GjqbTDN5SO4jSBcxc7yiGoZM/u0F5meCtSqp3IyJ
	 RqrMPFoz2qqMG+XX+rqN9hZPI0VF0R4JtEo84xpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfE3DLS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:11:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:47344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbfE3DKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:10:24 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73BD52449D;
        Thu, 30 May 2019 03:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185823;
        bh=5RLysbjutLyy0H2j0S6gLUuxbUtDMbuWmcgwqXBZXwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeVyaBk7noXXXpkltzELKDpwqZqIWqHLtneyw5kaSEH2GdAZHsLMg3xwmqDLcDy1W
         ngrUGdmneiJSFzaYpI0CQAzaimnVXEyQzw7XIrBlqGiSr1v9pqGLw0A9pea4xx/IA/
         sh94pqRocIrtsHot6B7MLo9CRHqN7lkg0b4BO8YY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaoli Feng <fengxiaoli0714@gmail.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 121/405] Fix nfs4.2 return -EINVAL when do dedupe operation
Date:   Wed, 29 May 2019 20:01:59 -0700
Message-Id: <20190530030547.125038768@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ce96e888fe48ecfa868c9a39adc03292c78a80ff ]

dedupe_file_range operations is combiled into remap_file_range.
But in nfs42_remap_file_range, it's skiped for dedupe operations.
Before this patch:
  # dd if=/dev/zero of=nfs/file bs=1M count=1
  # xfs_io -c "dedupe nfs/file 4k 64k 4k" nfs/file
  XFS_IOC_FILE_EXTENT_SAME: Invalid argument
After this patch:
  # dd if=/dev/zero of=nfs/file bs=1M count=1
  # xfs_io -c "dedupe nfs/file 4k 64k 4k" nfs/file
  deduped 4096/4096 bytes at offset 65536
  4 KiB, 1 ops; 0.0046 sec (865.988 KiB/sec and 216.4971 ops/sec)

Signed-off-by: Xiaoli Feng <fengxiaoli0714@gmail.com>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs4file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 00d17198ee12a..f10b660805fc4 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -187,7 +187,7 @@ static loff_t nfs42_remap_file_range(struct file *src_file, loff_t src_off,
 	bool same_inode = false;
 	int ret;
 
-	if (remap_flags & ~REMAP_FILE_ADVISORY)
+	if (remap_flags & ~(REMAP_FILE_DEDUP | REMAP_FILE_ADVISORY))
 		return -EINVAL;
 
 	/* check alignment w.r.t. clone_blksize */
-- 
2.20.1



