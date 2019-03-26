Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E85C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2476E20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582009;
	bh=D7PFooKSnDfFmtpvBHvj6/QS15GnMMvxLkNUacJEwhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EeoiQIEY0UuvT9mLFHT6i4hiFY1XbQsHlf8vmPntGJjNjjx3y5hTCskN1jI6zVVeb
	 75K01+hAQktipwG6stmkOB1ap9rlYWICiCKimv7Xu+lyeYQjLw2XpMmy0T/A5ASW+h
	 yC6AR5GExzAj7eGa3e7Q516wDclFOm877P3kqYVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbfCZGd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731639AbfCZGdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:33:25 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F6020823;
        Tue, 26 Mar 2019 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582004;
        bh=D7PFooKSnDfFmtpvBHvj6/QS15GnMMvxLkNUacJEwhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNJToB6nAcQi2H/7Nh6qsX8RCxqWyK0QiFL9WPNxFBEjlneRGsTynJ/Thc//3z0F4
         uuU7p56y2zuup+sVOgVNjY6s7lVURzC5lN+zPLtKulM4HI7Iou0iluGw0NYqRhPouK
         1DBgzlxZ6qM/DPDLnztYtlAxo3z0CAXwxE2rOpL4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Theodore Tso <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, stable@kernel.org
Subject: [PATCH 4.14 17/41] ext4: brelse all indirect buffer in ext4_ind_remove_space()
Date:   Tue, 26 Mar 2019 15:29:54 +0900
Message-Id: <20190326042650.873367823@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhangyi (F) <yi.zhang@huawei.com>

commit 674a2b27234d1b7afcb0a9162e81b2e53aeef217 upstream.

All indirect buffers get by ext4_find_shared() should be released no
mater the branch should be freed or not. But now, we forget to release
the lower depth indirect buffers when removing space from the same
higher depth indirect block. It will lead to buffer leak and futher
more, it may lead to quota information corruption when using old quota,
consider the following case.

 - Create and mount an empty ext4 filesystem without extent and quota
   features,
 - quotacheck and enable the user & group quota,
 - Create some files and write some data to them, and then punch hole
   to some files of them, it may trigger the buffer leak problem
   mentioned above.
 - Disable quota and run quotacheck again, it will create two new
   aquota files and write the checked quota information to them, which
   probably may reuse the freed indirect block(the buffer and page
   cache was not freed) as data block.
 - Enable quota again, it will invoke
   vfs_load_quota_inode()->invalidate_bdev() to try to clean unused
   buffers and pagecache. Unfortunately, because of the buffer of quota
   data block is still referenced, quota code cannot read the up to date
   quota info from the device and lead to quota information corruption.

This problem can be reproduced by xfstests generic/231 on ext3 file
system or ext4 file system without extent and quota features.

This patch fix this problem by releasing the missing indirect buffers,
in ext4_ind_remove_space().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ext4/indirect.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -1387,10 +1387,14 @@ end_range:
 					   partial->p + 1,
 					   partial2->p,
 					   (chain+n-1) - partial);
-			BUFFER_TRACE(partial->bh, "call brelse");
-			brelse(partial->bh);
-			BUFFER_TRACE(partial2->bh, "call brelse");
-			brelse(partial2->bh);
+			while (partial > chain) {
+				BUFFER_TRACE(partial->bh, "call brelse");
+				brelse(partial->bh);
+			}
+			while (partial2 > chain2) {
+				BUFFER_TRACE(partial2->bh, "call brelse");
+				brelse(partial2->bh);
+			}
 			return 0;
 		}
 


