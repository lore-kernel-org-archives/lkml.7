Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E11C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F62D21D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611381;
	bh=gZnYs58YiVe5TChW7bml8wRKh6KmwgwD+XgFFTEa1qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P7v/6TVJRfBDBHL+3N5DrBCd/HSmJHvUK5CA25s4ihpyZxTn7N2oJISHcGeNy2xuA
	 v7EpPKBMuotgzsBMPleMMQ79KPy78Uy7FGI150yQ/Tmv+9TVSAkbR2LW8ssLgAcr5L
	 toKQCVaZCFR0z7BZYlvXq96SAPjakGwM5gdbPa1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfKMCQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:16:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:49034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbfKMB4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:56:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01F732245A;
        Wed, 13 Nov 2019 01:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610196;
        bh=gZnYs58YiVe5TChW7bml8wRKh6KmwgwD+XgFFTEa1qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qbg5xJFc4p2cUe/WAHxmj3wKuL9VaT9b7wz59uUQzvqLlkQ8BYSbkx4o9VCM6kPgk
         UvMYp6khjkkKaqnRV/xbFHxqoJF/RWXlXI16QjAp7aV0UC8dsULANMVRDPFsLFTm70
         Y7S9NP6OFIvz23A1ckTDuNnimzMOXY/atizqmtWA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 4.14 010/115] iommu/io-pgtable-arm: Fix race handling in split_blk_unmap()
Date:   Tue, 12 Nov 2019 20:54:37 -0500
Message-Id: <20191113015622.11592-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015622.11592-1-sashal@kernel.org>
References: <20191113015622.11592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit 85c7a0f1ef624ef58173ef52ea77780257bdfe04 ]

In removing the pagetable-wide lock, we gained the possibility of the
vanishingly unlikely case where we have a race between two concurrent
unmappers splitting the same block entry. The logic to handle this is
fairly straightforward - whoever loses the race frees their partial
next-level table and instead dereferences the winner's newly-installed
entry in order to fall back to a regular unmap, which intentionally
echoes the pre-existing case of recursively splitting a 1GB block down
to 4KB pages by installing a full table of 2MB blocks first.

Unfortunately, the chump who implemented that logic failed to update the
condition check for that fallback, meaning that if said race occurs at
the last level (where the loser's unmap_idx is valid) then the unmap
won't actually happen. Fix that to properly account for both the race
and recursive cases.

Fixes: 2c3d273eabe8 ("iommu/io-pgtable-arm: Support lockless operation")
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[will: re-jig control flow to avoid duplicate cmpxchg test]
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/io-pgtable-arm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index e8018a308868e..17a9225283dd1 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -551,13 +551,12 @@ static int arm_lpae_split_blk_unmap(struct arm_lpae_io_pgtable *data,
 			return 0;
 
 		tablep = iopte_deref(pte, data);
+	} else if (unmap_idx >= 0) {
+		io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
+		return size;
 	}
 
-	if (unmap_idx < 0)
-		return __arm_lpae_unmap(data, iova, size, lvl, tablep);
-
-	io_pgtable_tlb_add_flush(&data->iop, iova, size, size, true);
-	return size;
+	return __arm_lpae_unmap(data, iova, size, lvl, tablep);
 }
 
 static int __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
-- 
2.20.1

