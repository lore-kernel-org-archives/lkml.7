Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7BDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0102089E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566493837;
	bh=VLvssIs057l9kxGVR3E5TdDzghmgW5FyKU+CmVHp3FQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FPssHJIHRx0M1rUyFG7xb6U9AtNiX+iNx8xivn5SkKfibSkzjS248MUPVELoaMrka
	 DyX4i1hc2oAmKhq0hWkuxU4OYo4I0wJ8m2DCn50C5dMvVJ92U+WIS7dG+ScWnnnFRR
	 ZMDZ1eMRbtw9YqTE3dXjMoXbvE+lifK9Xl47OKoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390844AbfHVRKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390757AbfHVRJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:09:24 -0400
Received: from sasha-vm.mshome.net (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89A5023405;
        Thu, 22 Aug 2019 17:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566493763;
        bh=VLvssIs057l9kxGVR3E5TdDzghmgW5FyKU+CmVHp3FQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dXUchJVgvb1qO0bFQuu2+E4H3JEmRXA/veFt2LW8uH9xJOsWDuX6kQ4zQZwGToNPh
         gf9a2tyqXb2EKva2b+eL9cXmmJGVDFHM/LfFlWogYMu1FY78or5tXfTNZFafd3Ba05
         gnuJybhf+iyhM7ydRoXqPbxuQSXdperF/5Yxi76M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aya Levin <ayal@mellanox.com>, Tariq Toukan <tariqt@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.2 129/135] net/mlx5e: Fix false negative indication on tx reporter CQE recovery
Date:   Thu, 22 Aug 2019 13:08:05 -0400
Message-Id: <20190822170811.13303-130-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190822170811.13303-1-sashal@kernel.org>
References: <20190822170811.13303-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.2.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.2.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.2.10-rc1
X-KernelTest-Deadline: 2019-08-24T17:07+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit d9a2fcf53c76a7edb2bcf99e94507935561a83d5 ]

Remove wrong error return value when SQ is not in error state.
CQE recovery on TX reporter queries the sq state. If the sq is not in
error state, the sq is either in ready or reset state. Ready state is
good state which doesn't require recovery and reset state is a temporal
state which ends in ready state. With this patch, CQE recovery in this
scenario is successful.

Fixes: de8650a82071 ("net/mlx5e: Add tx reporter support")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index f3d98748b2117..b307234b4e05b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -86,10 +86,8 @@ static int mlx5e_tx_reporter_err_cqe_recover(struct mlx5e_txqsq *sq)
 		return err;
 	}
 
-	if (state != MLX5_SQC_STATE_ERR) {
-		netdev_err(dev, "SQ 0x%x not in ERROR state\n", sq->sqn);
-		return -EINVAL;
-	}
+	if (state != MLX5_SQC_STATE_ERR)
+		return 0;
 
 	mlx5e_tx_disable_queue(sq->txq);
 
-- 
2.20.1

