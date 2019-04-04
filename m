Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF1EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390F0205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370858;
	bh=FRUkwshiMCUG19k+zRit9g5iQKYiRiWVSggY4gD9Nck=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W5Yvy4I4S67d+t0t8T9cwCP1+lEiDkaMgHWnqAMpGti9BmWRySGHaJWjg6zJx8HUI
	 5LFQa+Lpf7ET7eSmKoQ/acuQYmLbHe4PnWKVKknNBebMwv+CoYPnSQ3fsO2jJQSJZr
	 UICQzoTALekPCFwOV4zdd8tsC3SuwNeWok0FtqF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbfDDJCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731600AbfDDJCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:02:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C976421741;
        Thu,  4 Apr 2019 09:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368543;
        bh=FRUkwshiMCUG19k+zRit9g5iQKYiRiWVSggY4gD9Nck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UTiSmKSxuLNRL69S7pDFbIq5zS18cMMUvMvn04Bhgkv3SAcMe8DCfGW5tr2OaMP99
         M/3wm8sTYXPqy/48VGC92XhAXHnDpDGRye41ZpvHhvqReGSGTeAMe8urhsY6RxTVY6
         UG0Li+yMuEoCcePZ+3VsTvZV6Zk/l+QM0wkQXZ6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/187] btrfs: qgroup: Make qgroup async transaction commit more aggressive
Date:   Thu,  4 Apr 2019 10:46:39 +0200
Message-Id: <20190404084605.994708096@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit f5fef4593653dfa2a865c485bb81415de51d5c99 ]

[BUG]
Btrfs qgroup will still hit EDQUOT under the following case:

  $ dev=/dev/test/test
  $ mnt=/mnt/btrfs
  $ umount $mnt &> /dev/null
  $ umount $dev &> /dev/null

  $ mkfs.btrfs -f $dev
  $ mount $dev $mnt -o nospace_cache

  $ btrfs subv create $mnt/subv
  $ btrfs quota enable $mnt
  $ btrfs quota rescan -w $mnt
  $ btrfs qgroup limit -e 1G $mnt/subv

  $ fallocate -l 900M $mnt/subv/padding
  $ sync

  $ rm $mnt/subv/padding

  # Hit EDQUOT
  $ xfs_io -f -c "pwrite 0 512M" $mnt/subv/real_file

[CAUSE]
Since commit a514d63882c3 ("btrfs: qgroup: Commit transaction in advance
to reduce early EDQUOT"), btrfs is not forced to commit transaction to
reclaim more quota space.

Instead, we just check pertrans metadata reservation against some
threshold and try to do asynchronously transaction commit.

However in above case, the pertrans metadata reservation is pretty small
thus it will never trigger asynchronous transaction commit.

[FIX]
Instead of only accounting pertrans metadata reservation, we calculate
how much free space we have, and if there isn't much free space left,
commit transaction asynchronously to try to free some space.

This may slow down the fs when we have less than 32M free qgroup space,
but should reduce a lot of false EDQUOT, so the cost should be
acceptable.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index e1fcb28ad4cc..e46e83e87600 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2427,16 +2427,15 @@ out:
 /*
  * Two limits to commit transaction in advance.
  *
- * For RATIO, it will be 1/RATIO of the remaining limit
- * (excluding data and prealloc meta) as threshold.
+ * For RATIO, it will be 1/RATIO of the remaining limit as threshold.
  * For SIZE, it will be in byte unit as threshold.
  */
-#define QGROUP_PERTRANS_RATIO		32
-#define QGROUP_PERTRANS_SIZE		SZ_32M
+#define QGROUP_FREE_RATIO		32
+#define QGROUP_FREE_SIZE		SZ_32M
 static bool qgroup_check_limits(struct btrfs_fs_info *fs_info,
 				const struct btrfs_qgroup *qg, u64 num_bytes)
 {
-	u64 limit;
+	u64 free;
 	u64 threshold;
 
 	if ((qg->lim_flags & BTRFS_QGROUP_LIMIT_MAX_RFER) &&
@@ -2455,20 +2454,21 @@ static bool qgroup_check_limits(struct btrfs_fs_info *fs_info,
 	 */
 	if ((qg->lim_flags & (BTRFS_QGROUP_LIMIT_MAX_RFER |
 			      BTRFS_QGROUP_LIMIT_MAX_EXCL))) {
-		if (qg->lim_flags & BTRFS_QGROUP_LIMIT_MAX_EXCL)
-			limit = qg->max_excl;
-		else
-			limit = qg->max_rfer;
-		threshold = (limit - qg->rsv.values[BTRFS_QGROUP_RSV_DATA] -
-			    qg->rsv.values[BTRFS_QGROUP_RSV_META_PREALLOC]) /
-			    QGROUP_PERTRANS_RATIO;
-		threshold = min_t(u64, threshold, QGROUP_PERTRANS_SIZE);
+		if (qg->lim_flags & BTRFS_QGROUP_LIMIT_MAX_EXCL) {
+			free = qg->max_excl - qgroup_rsv_total(qg) - qg->excl;
+			threshold = min_t(u64, qg->max_excl / QGROUP_FREE_RATIO,
+					  QGROUP_FREE_SIZE);
+		} else {
+			free = qg->max_rfer - qgroup_rsv_total(qg) - qg->rfer;
+			threshold = min_t(u64, qg->max_rfer / QGROUP_FREE_RATIO,
+					  QGROUP_FREE_SIZE);
+		}
 
 		/*
 		 * Use transaction_kthread to commit transaction, so we no
 		 * longer need to bother nested transaction nor lock context.
 		 */
-		if (qg->rsv.values[BTRFS_QGROUP_RSV_META_PERTRANS] > threshold)
+		if (free < threshold)
 			btrfs_commit_transaction_locksafe(fs_info);
 	}
 
-- 
2.19.1



