Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E1DC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B1826063
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559192395;
	bh=TFD9QtOmrEADc49mR+g0tRg0jNoao5ZKTnu6JPQhWPQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n8zU2Tnve5dCNOthCI9IbMXuhcEPzwL3ushAOTi7yb+jgpJT9T/POIFy4tI+7ZOZI
	 sO1GRcDjt/JpRbvXsFPOokVhQrKtEG1sI+SwnUyeHDWdl3ipUX3pDihe0LwsZEzOUI
	 yfA9XvGl2tvs0kBEqXnicriAJHxPab2+bc2YqRFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389358AbfE3E7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbfE3DJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:35 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 229B32447A;
        Thu, 30 May 2019 03:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185775;
        bh=TFD9QtOmrEADc49mR+g0tRg0jNoao5ZKTnu6JPQhWPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEGlzhz5o/PXVMvaGWj6W0H+Kp1LERZciywV/GOfUagdjlyahvEIHLiNpMvGPilxT
         zLL+xSIUvMbpokU0or1WBiY4ITJ79oUxJiVBhKH8UrP8d3+dmrkMxLyRegPHKjKmwX
         FsjO27jbKf5HRrX7x7GQQAqNFMSjFWorKocQjcqw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>
Subject: [PATCH 5.1 003/405] ext4: wait for outstanding dio during truncate in nojournal mode
Date:   Wed, 29 May 2019 20:00:01 -0700
Message-Id: <20190530030540.513497665@linuxfoundation.org>
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

From: Jan Kara <jack@suse.cz>

commit 82a25b027ca48d7ef197295846b352345853dfa8 upstream.

We didn't wait for outstanding direct IO during truncate in nojournal
mode (as we skip orphan handling in that case). This can lead to fs
corruption or stale data exposure if truncate ends up freeing blocks
and these get reallocated before direct IO finishes. Fix the condition
determining whether the wait is necessary.

CC: stable@vger.kernel.org
Fixes: 1c9114f9c0f1 ("ext4: serialize unlocked dio reads with truncate")
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/inode.c |   21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5624,20 +5624,17 @@ int ext4_setattr(struct dentry *dentry,
 				goto err_out;
 			}
 		}
-		if (!shrink)
+		if (!shrink) {
 			pagecache_isize_extended(inode, oldsize, inode->i_size);
-
-		/*
-		 * Blocks are going to be removed from the inode. Wait
-		 * for dio in flight.  Temporarily disable
-		 * dioread_nolock to prevent livelock.
-		 */
-		if (orphan) {
-			if (!ext4_should_journal_data(inode)) {
-				inode_dio_wait(inode);
-			} else
-				ext4_wait_for_tail_page_commit(inode);
+		} else {
+			/*
+			 * Blocks are going to be removed from the inode. Wait
+			 * for dio in flight.
+			 */
+			inode_dio_wait(inode);
 		}
+		if (orphan && ext4_should_journal_data(inode))
+			ext4_wait_for_tail_page_commit(inode);
 		down_write(&EXT4_I(inode)->i_mmap_sem);
 
 		rc = ext4_break_layouts(inode);


