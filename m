Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87252C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605292133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbfDBNoc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:44:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43444 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731475AbfDBNkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:08 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe0-0002oX-J4; Tue, 02 Apr 2019 14:40:04 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdx-0004wq-L9; Tue, 02 Apr 2019 14:40:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Date:   Tue, 02 Apr 2019 14:38:28 +0100
Message-ID: <lsq.1554212308.670738173@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 79/99] ext4: make sure enough credits are reserved
 for dioread_nolock writes
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

commit 812c0cab2c0dfad977605dbadf9148490ca5d93f upstream.

There are enough credits reserved for most dioread_nolock writes;
however, if the extent tree is sufficiently deep, and/or quota is
enabled, the code was not allowing for all eventualities when
reserving journal credits for the unwritten extent conversion.

This problem can be seen using xfstests ext4/034:

   WARNING: CPU: 1 PID: 257 at fs/ext4/ext4_jbd2.c:271 __ext4_handle_dirty_metadata+0x10c/0x180
   Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
   RIP: 0010:__ext4_handle_dirty_metadata+0x10c/0x180
   	...
   EXT4-fs: ext4_free_blocks:4938: aborting transaction: error 28 in __ext4_handle_dirty_metadata
   EXT4: jbd2_journal_dirty_metadata failed: handle type 11 started at line 4921, credits 4/0, errcode -28
   EXT4-fs error (device dm-1) in ext4_free_blocks:4950: error 28

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/ext4/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2579,7 +2579,8 @@ static int ext4_writepages(struct addres
 		 * We may need to convert up to one extent per block in
 		 * the page and we may dirty the inode.
 		 */
-		rsv_blocks = 1 + (PAGE_CACHE_SIZE >> inode->i_blkbits);
+		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
+					PAGE_CACHE_SIZE >> inode->i_blkbits);
 	}
 
 	/*

