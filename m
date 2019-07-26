Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54185C76191
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2FC205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154892;
	bh=1LYdKt7mexBVKpAR/h1PZwfj5xri1vDdeHhjSJ+zSUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GkFmomZ2jx1PJSdzzQ3Fff/eAajUWIt+zIwHZQSmIwvkqOOMiiS5vwPm9Oq7Fpbjh
	 VW8II1GaQVuCrUd9ce2SGOh95CCWk/Fd8MJa6LVua5q00mzlSvhCTXFE1Mdzi1hl7J
	 Ifz490fBJLKaWtDn6xsZZZYn0eD+UmmAseYDaTCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388392AbfGZP2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:28:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388367AbfGZP2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:28:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC436205F4;
        Fri, 26 Jul 2019 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154888;
        bh=1LYdKt7mexBVKpAR/h1PZwfj5xri1vDdeHhjSJ+zSUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ic5hXtnZsNhsYerLR4dDmX1xCx8rrRVLKqlHvpCFupPZQAqwQ8WNgHbPc7MGl2yf3
         ADBoXK1Vw5MUyJYvxk7GNtn5XxKCKjfv6STCFEji9JtCZatsI9CCXzid2D1ZDx3G/Q
         JjnMJd0HTITJeaXjlsHI/TkG2dZw9A07jK6PZt3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5.2 60/66] ext4: use jbd2_inode dirty range scoping
Date:   Fri, 26 Jul 2019 17:24:59 +0200
Message-Id: <20190726152308.269580319@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
References: <20190726152301.936055394@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Zwisler <zwisler@chromium.org>

commit 73131fbb003b3691cfcf9656f234b00da497fcd6 upstream.

Use the newly introduced jbd2_inode dirty range scoping to prevent us
from waiting forever when trying to complete a journal transaction.

Signed-off-by: Ross Zwisler <zwisler@google.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/ext4_jbd2.h   |   12 ++++++------
 fs/ext4/inode.c       |   13 ++++++++++---
 fs/ext4/move_extent.c |    3 ++-
 3 files changed, 18 insertions(+), 10 deletions(-)

--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -361,20 +361,20 @@ static inline int ext4_journal_force_com
 }
 
 static inline int ext4_jbd2_inode_add_write(handle_t *handle,
-					    struct inode *inode)
+		struct inode *inode, loff_t start_byte, loff_t length)
 {
 	if (ext4_handle_valid(handle))
-		return jbd2_journal_inode_add_write(handle,
-						    EXT4_I(inode)->jinode);
+		return jbd2_journal_inode_ranged_write(handle,
+				EXT4_I(inode)->jinode, start_byte, length);
 	return 0;
 }
 
 static inline int ext4_jbd2_inode_add_wait(handle_t *handle,
-					   struct inode *inode)
+		struct inode *inode, loff_t start_byte, loff_t length)
 {
 	if (ext4_handle_valid(handle))
-		return jbd2_journal_inode_add_wait(handle,
-						   EXT4_I(inode)->jinode);
+		return jbd2_journal_inode_ranged_wait(handle,
+				EXT4_I(inode)->jinode, start_byte, length);
 	return 0;
 }
 
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -731,10 +731,16 @@ out_sem:
 		    !(flags & EXT4_GET_BLOCKS_ZERO) &&
 		    !ext4_is_quota_file(inode) &&
 		    ext4_should_order_data(inode)) {
+			loff_t start_byte =
+				(loff_t)map->m_lblk << inode->i_blkbits;
+			loff_t length = (loff_t)map->m_len << inode->i_blkbits;
+
 			if (flags & EXT4_GET_BLOCKS_IO_SUBMIT)
-				ret = ext4_jbd2_inode_add_wait(handle, inode);
+				ret = ext4_jbd2_inode_add_wait(handle, inode,
+						start_byte, length);
 			else
-				ret = ext4_jbd2_inode_add_write(handle, inode);
+				ret = ext4_jbd2_inode_add_write(handle, inode,
+						start_byte, length);
 			if (ret)
 				return ret;
 		}
@@ -4085,7 +4091,8 @@ static int __ext4_block_zero_page_range(
 		err = 0;
 		mark_buffer_dirty(bh);
 		if (ext4_should_order_data(inode))
-			err = ext4_jbd2_inode_add_write(handle, inode);
+			err = ext4_jbd2_inode_add_write(handle, inode, from,
+					length);
 	}
 
 unlock:
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -390,7 +390,8 @@ data_copy:
 
 	/* Even in case of data=writeback it is reasonable to pin
 	 * inode to transaction, to prevent unexpected data loss */
-	*err = ext4_jbd2_inode_add_write(handle, orig_inode);
+	*err = ext4_jbd2_inode_add_write(handle, orig_inode,
+			(loff_t)orig_page_offset << PAGE_SHIFT, replaced_size);
 
 unlock_pages:
 	unlock_page(pagep[0]);


