Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2416C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36BF22525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004230;
	bh=wtmGKq4gh6D+PVyTFkCmv2SYRQfmZQki6Ddg5KynCq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DRG1DoJUtmgFR2dkzR0BlGG638LaNWLYY5dtHFMyV+WeeNVXes48p8gpxf7h0Pa+o
	 AzULuESoMiMvwm4ppInVEacuKARbEbFDwviG6Jvr4ztfdVj3maAb6/ZfKq9r2ouzZR
	 GO5yCwTlhXxftQZz3VO6vai3gRf2tLR857ECg0DM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgABWa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:30:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729907AbgABWa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:30:27 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5689621835;
        Thu,  2 Jan 2020 22:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004226;
        bh=wtmGKq4gh6D+PVyTFkCmv2SYRQfmZQki6Ddg5KynCq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWQ/dvHw7MWoQUUZG7hGXw5BWbUWnKrbaz2nGlnlFRHVis9aV+rGbh0IT+2ZsSD+F
         YalkLiofOh8115rEZyh+I3GvQsHMkqcj2RQfcnRtvaWfKCIm806YQuFZ+sWo1Fot8d
         dK7vwR6yQ2vJrhTcVC+RPvhCUzocNfCwXT73IjVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 090/171] btrfs: return error pointer from alloc_test_extent_buffer
Date:   Thu,  2 Jan 2020 23:07:01 +0100
Message-Id: <20200102220559.585238593@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102220546.960200039@linuxfoundation.org>
References: <20200102220546.960200039@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b6293c821ea8fa2a631a2112cd86cd435effeb8b ]

Callers of alloc_test_extent_buffer have not correctly interpreted the
return value as error pointer, as alloc_test_extent_buffer should behave
as alloc_extent_buffer. The self-tests were unaffected but
btrfs_find_create_tree_block could call both functions and that would
cause problems up in the call chain.

Fixes: faa2dbf004e8 ("Btrfs: add sanity tests for new qgroup accounting code")
CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c                   | 6 ++++--
 fs/btrfs/tests/free-space-tree-tests.c | 6 +++---
 fs/btrfs/tests/qgroup-tests.c          | 4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4d901200be13..37a28e2369b9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4994,12 +4994,14 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 		return eb;
 	eb = alloc_dummy_extent_buffer(fs_info, start, nodesize);
 	if (!eb)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	eb->fs_info = fs_info;
 again:
 	ret = radix_tree_preload(GFP_NOFS);
-	if (ret)
+	if (ret) {
+		exists = ERR_PTR(ret);
 		goto free_eb;
+	}
 	spin_lock(&fs_info->buffer_lock);
 	ret = radix_tree_insert(&fs_info->buffer_radix,
 				start >> PAGE_SHIFT, eb);
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index a724d9a79bd2..5e3b875d87e2 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -476,9 +476,9 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 
 	root->node = alloc_test_extent_buffer(root->fs_info,
 		nodesize, nodesize);
-	if (!root->node) {
-		test_msg("Couldn't allocate dummy buffer\n");
-		ret = -ENOMEM;
+	if (IS_ERR(root->node)) {
+		test_msg("couldn't allocate dummy buffer\n");
+		ret = PTR_ERR(root->node);
 		goto out;
 	}
 	btrfs_set_header_level(root->node, 0);
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index 9c6666692341..e0aa6b9786fa 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -488,9 +488,9 @@ int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
 	 */
 	root->node = alloc_test_extent_buffer(root->fs_info, nodesize,
 					nodesize);
-	if (!root->node) {
+	if (IS_ERR(root->node)) {
 		test_msg("Couldn't allocate dummy buffer\n");
-		ret = -ENOMEM;
+		ret = PTR_ERR(root->node);
 		goto out;
 	}
 	btrfs_set_header_level(root->node, 0);
-- 
2.20.1



