Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662A5C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3402075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554370255;
	bh=NZHwJHAtqPSQbuHknju41mfXyfSWeczpwIwzIQwcNvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BSAmXZRweGXrNdQZnNC/qpeoforAYJ41Frp7qijyIg/i3ICWK0WXDYZo7imnfptym
	 zoibCK9eNgMQfRPKnc4gHPd4L4EoQZFAp8gLlZXgXiVIAJcZpknlU+STT/tJE8uZYb
	 nTId91cRGLGOe18vzcApF4dgo8eOBAEwxEIJLTeg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732882AbfDDJJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:09:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:49014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731719AbfDDJJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:09:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9292A214AF;
        Thu,  4 Apr 2019 09:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368983;
        bh=NZHwJHAtqPSQbuHknju41mfXyfSWeczpwIwzIQwcNvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zetvo7DVmPJAwDAFMNdLrXdQboI5fETU6uHeDjGU55TRLKJ37umLbV3oiHAoyNwL+
         rHs0dHx+ASVlMIO4hQ/7ozN0e1aMf/qTx4qElbTXMQwmmhl7NJth2azRCU204J540O
         NzBj9G3sJhzeVjmYLmHLj9X0yra72jQAdtsHetJQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 054/246] ext4: fix bigalloc cluster freeing when hole punching under load
Date:   Thu,  4 Apr 2019 10:45:54 +0200
Message-Id: <20190404084620.908464492@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7bd75230b43727b258a4f7a59d62114cffe1b6c8 ]

Ext4 may not free clusters correctly when punching holes in bigalloc
file systems under high load conditions.  If it's not possible to
extend and restart the journal in ext4_ext_rm_leaf() when preparing to
remove blocks from a punched region, a retry of the entire punch
operation is triggered in ext4_ext_remove_space().  This causes a
partial cluster to be set to the first cluster in the extent found to
the right of the punched region.  However, if the punch operation
prior to the retry had made enough progress to delete one or more
extents and a partial cluster candidate for freeing had already been
recorded, the retry would overwrite the partial cluster.  The loss of
this information makes it impossible to correctly free the original
partial cluster in all cases.

This bug can cause generic/476 to fail when run as part of
xfstests-bld's bigalloc and bigalloc_1k test cases.  The failure is
reported when e2fsck detects bad iblocks counts greater than expected
in units of whole clusters and also detects a number of negative block
bitmap differences equal to the iblocks discrepancy in cluster units.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 240b6dea5441..252bbbb5a2f4 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2956,14 +2956,17 @@ again:
 			if (err < 0)
 				goto out;
 
-		} else if (sbi->s_cluster_ratio > 1 && end >= ex_end) {
+		} else if (sbi->s_cluster_ratio > 1 && end >= ex_end &&
+			   partial.state == initial) {
 			/*
-			 * If there's an extent to the right its first cluster
-			 * contains the immediate right boundary of the
-			 * truncated/punched region.  Set partial_cluster to
-			 * its negative value so it won't be freed if shared
-			 * with the current extent.  The end < ee_block case
-			 * is handled in ext4_ext_rm_leaf().
+			 * If we're punching, there's an extent to the right.
+			 * If the partial cluster hasn't been set, set it to
+			 * that extent's first cluster and its state to nofree
+			 * so it won't be freed should it contain blocks to be
+			 * removed. If it's already set (tofree/nofree), we're
+			 * retrying and keep the original partial cluster info
+			 * so a cluster marked tofree as a result of earlier
+			 * extent removal is not lost.
 			 */
 			lblk = ex_end + 1;
 			err = ext4_ext_search_right(inode, path, &lblk, &pblk,
-- 
2.19.1



