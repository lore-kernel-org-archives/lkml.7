Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55A3BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF06218FF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369076;
	bh=3WqY8Xf4x6FXZoliILF7BbVBmTd6Fz5xkzO+Rg7m89g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u6HJT/Gi1mr/0GC+DBUBMljGr3tvh1VI0AG149ZkGifOYbDFlcI3U2GCXbuaE5yWO
	 I8/2JVLd4oDBq1i5ikqbvHlS0UmYxb6dDIGRgBMoWBXsK3AJsx7YL320X/6YLYn18E
	 acq2FfeYYu5HRD6MHEXXZnLi3AEwUDrlmgBLuNmk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbfDDJLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:11:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732506AbfDDJLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:11:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3264F20652;
        Thu,  4 Apr 2019 09:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369069;
        bh=3WqY8Xf4x6FXZoliILF7BbVBmTd6Fz5xkzO+Rg7m89g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UfnLlSuz9ksSrP4GmJIg1day770jGYV+EZeutju7/ImveZFwGcYButPKDiUdqTltV
         DCF5dGxEzSrtuDC0b96U8NXQN/p9Zy6turFnFHfQo5bfX7GNMLV/dmASvRHMa8EalG
         1LDwMOhoa3YQkaR1Mwk+83nGrMGt3s+5fNW9F10s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 071/246] btrfs: save drop_progress if we drop refs at all
Date:   Thu,  4 Apr 2019 10:46:11 +0200
Message-Id: <20190404084621.627121550@linuxfoundation.org>
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

[ Upstream commit aea6f028d01d629eda2e958ccd1133e805cda159 ]

Previously we only updated the drop_progress key if we were in the
DROP_REFERENCE stage of snapshot deletion.  This is because the
UPDATE_BACKREF stage checks the flags of the blocks it's converting to
FULL_BACKREF, so if we go over a block we processed before it doesn't
matter, we just don't do anything.

The problem is in do_walk_down() we will go ahead and drop the roots
reference to any blocks that we know we won't need to walk into.

Given subvolume A and snapshot B.  The root of B points to all of the
nodes that belong to A, so all of those nodes have a refcnt > 1.  If B
did not modify those blocks it'll hit this condition in do_walk_down

if (!wc->update_ref ||
    generation <= root->root_key.offset)
	goto skip;

and in "goto skip" we simply do a btrfs_free_extent() for that bytenr
that we point at.

Now assume we modified some data in B, and then took a snapshot of B and
call it C.  C points to all the nodes in B, making every node the root
of B points to have a refcnt > 1.  This assumes the root level is 2 or
higher.

We delete snapshot B, which does the above work in do_walk_down,
free'ing our ref for nodes we share with A that we didn't modify.  Now
we hit a node we _did_ modify, thus we own.  We need to walk down into
this node and we set wc->stage == UPDATE_BACKREF.  We walk down to level
0 which we also own because we modified data.  We can't walk any further
down and thus now need to walk up and start the next part of the
deletion.  Now walk_up_proc is supposed to put us back into
DROP_REFERENCE, but there's an exception to this

if (level < wc->shared_level)
	goto out;

we are at level == 0, and our shared_level == 1.  We skip out of this
one and go up to level 1.  Since path->slots[1] < nritems we
path->slots[1]++ and break out of walk_up_tree to stop our transaction
and loop back around.  Now in btrfs_drop_snapshot we have this snippet

if (wc->stage == DROP_REFERENCE) {
	level = wc->level;
	btrfs_node_key(path->nodes[level],
		       &root_item->drop_progress,
		       path->slots[level]);
	root_item->drop_level = level;
}

our stage == UPDATE_BACKREF still, so we don't update the drop_progress
key.  This is a problem because we would have done btrfs_free_extent()
for the nodes leading up to our current position.  If we crash or
unmount here and go to remount we'll start over where we were before and
try to free our ref for blocks we've already freed, and thus abort()
out.

Fix this by keeping track of the last place we dropped a reference for
our block in do_walk_down.  Then if wc->stage == UPDATE_BACKREF we know
we'll start over from a place we meant to, and otherwise things continue
to work as they did before.

I have a complicated reproducer for this problem, without this patch
we'll fail to fsck the fs when replaying the log writes log.  With this
patch we can replay the whole log without any fsck or mount failures.

The steps to reproduce this easily are sort of tricky, I had to add a
couple of debug patches to the kernel in order to make it easy,
basically I just needed to make sure we did actually commit the
transaction every time we finished a walk_down_tree/walk_up_tree combo.

The reproducer:

1) Creates a base subvolume.
2) Creates 100k files in the subvolume.
3) Snapshots the base subvolume (snap1).
4) Touches files 5000-6000 in snap1.
5) Snapshots snap1 (snap2).
6) Deletes snap1.

I do this with dm-log-writes, and then replay to every FUA in the log
and fsck the fs.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ copy reproducer steps ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-tree.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 0a6615573351..a9656685a951 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8690,6 +8690,8 @@ struct walk_control {
 	u64 refs[BTRFS_MAX_LEVEL];
 	u64 flags[BTRFS_MAX_LEVEL];
 	struct btrfs_key update_progress;
+	struct btrfs_key drop_progress;
+	int drop_level;
 	int stage;
 	int level;
 	int shared_level;
@@ -9028,6 +9030,16 @@ skip:
 					     ret);
 			}
 		}
+
+		/*
+		 * We need to update the next key in our walk control so we can
+		 * update the drop_progress key accordingly.  We don't care if
+		 * find_next_key doesn't find a key because that means we're at
+		 * the end and are going to clean up now.
+		 */
+		wc->drop_level = level;
+		find_next_key(path, level, &wc->drop_progress);
+
 		ret = btrfs_free_extent(trans, root, bytenr, fs_info->nodesize,
 					parent, root->root_key.objectid,
 					level - 1, 0);
@@ -9378,12 +9390,14 @@ int btrfs_drop_snapshot(struct btrfs_root *root,
 		}
 
 		if (wc->stage == DROP_REFERENCE) {
-			level = wc->level;
-			btrfs_node_key(path->nodes[level],
-				       &root_item->drop_progress,
-				       path->slots[level]);
-			root_item->drop_level = level;
-		}
+			wc->drop_level = wc->level;
+			btrfs_node_key_to_cpu(path->nodes[wc->drop_level],
+					      &wc->drop_progress,
+					      path->slots[wc->drop_level]);
+		}
+		btrfs_cpu_key_to_disk(&root_item->drop_progress,
+				      &wc->drop_progress);
+		root_item->drop_level = wc->drop_level;
 
 		BUG_ON(wc->level == 0);
 		if (btrfs_should_end_transaction(trans) ||
-- 
2.19.1



