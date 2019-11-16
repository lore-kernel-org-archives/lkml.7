Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18647C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5B6218BA
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 15:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573919720;
	bh=QuI3VVaRWCrB1tpl1EFxVmZ4OoG20UNiLVtP0YBWAT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wMNWSZJhrUECfJC74UaYnUzfrh9t4mUVa8rpVtmjTwSG42YC/xWSBFknguFGG2nMc
	 wa0WagWgLgpkazETlFnem3myK34t7+oMRj30e8SKqQNmwPNeRM2i/2u/H0WQMLGDQr
	 GQIG6ya/ksban+srtm89f7EVbAOw/rD4v0LxExTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfKPPzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:55:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730849AbfKPPzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:55:13 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 303C92184B;
        Sat, 16 Nov 2019 15:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919712;
        bh=QuI3VVaRWCrB1tpl1EFxVmZ4OoG20UNiLVtP0YBWAT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpgRt2o7pgHdNxbGcq7on04Sv8v2Ur4dOPIH+QIaQQWAIaoRujD94M4c6oU/KAjSX
         g88wnVD2I4P/i2sQf6SaLO+9UqWzrMpkk0b2M4eX6n/+xSoaeEUzsrzfmSuIhqqeLJ
         vPIWrMwKNzNfeVuuCY1hxGBobKQX9Id0kv95LFDc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Larry Chen <lchen@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 57/77] ocfs2: fix clusters leak in ocfs2_defrag_extent()
Date:   Sat, 16 Nov 2019 10:53:19 -0500
Message-Id: <20191116155339.11909-57-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116155339.11909-1-sashal@kernel.org>
References: <20191116155339.11909-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Chen <lchen@suse.com>

[ Upstream commit 6194ae4242dec0c9d604bc05df83aa9260a899e4 ]

ocfs2_defrag_extent() might leak allocated clusters.  When the file
system has insufficient space, the number of claimed clusters might be
less than the caller wants.  If that happens, the original code might
directly commit the transaction without returning clusters.

This patch is based on code in ocfs2_add_clusters_in_btree().

[akpm@linux-foundation.org: include localalloc.h, reduce scope of data_ac]
Link: http://lkml.kernel.org/r/20180904041621.16874-3-lchen@suse.com
Signed-off-by: Larry Chen <lchen@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/move_extents.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index c1a83c58456ef..725a870fd14fc 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -25,6 +25,7 @@
 #include "ocfs2_ioctl.h"
 
 #include "alloc.h"
+#include "localalloc.h"
 #include "aops.h"
 #include "dlmglue.h"
 #include "extent_map.h"
@@ -222,6 +223,7 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 	struct ocfs2_refcount_tree *ref_tree = NULL;
 	u32 new_phys_cpos, new_len;
 	u64 phys_blkno = ocfs2_clusters_to_blocks(inode->i_sb, phys_cpos);
+	int need_free = 0;
 
 	if ((ext_flags & OCFS2_EXT_REFCOUNTED) && *len) {
 
@@ -315,6 +317,7 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 		if (!partial) {
 			context->range->me_flags &= ~OCFS2_MOVE_EXT_FL_COMPLETE;
 			ret = -ENOSPC;
+			need_free = 1;
 			goto out_commit;
 		}
 	}
@@ -339,6 +342,20 @@ static int ocfs2_defrag_extent(struct ocfs2_move_extents_context *context,
 		mlog_errno(ret);
 
 out_commit:
+	if (need_free && context->data_ac) {
+		struct ocfs2_alloc_context *data_ac = context->data_ac;
+
+		if (context->data_ac->ac_which == OCFS2_AC_USE_LOCAL)
+			ocfs2_free_local_alloc_bits(osb, handle, data_ac,
+					new_phys_cpos, new_len);
+		else
+			ocfs2_free_clusters(handle,
+					data_ac->ac_inode,
+					data_ac->ac_bh,
+					ocfs2_clusters_to_blocks(osb->sb, new_phys_cpos),
+					new_len);
+	}
+
 	ocfs2_commit_trans(osb, handle);
 
 out_unlock_mutex:
-- 
2.20.1

