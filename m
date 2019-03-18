Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D00C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205C0217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901608;
	bh=uIzQmm7xwo6pjeutiBKDv294PNlt7yUiey2S8mUnKi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=idvbe06xnihmvQGysLtDInlwAkh9LkPx3y/jDdrmvVm/lj0G7QfZI93f3nWdE0r4Y
	 bXopjKAYbn6cCXzqOe92k9DBjY8RFlTnXVSrEwah4KBiY4maylOGVdupcjH1V5jflN
	 Nflok9tpp7Uh72uuDl3/7jv68ScvWtFshujmxsUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfCRJd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfCRJdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:33:23 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 999BA21741;
        Mon, 18 Mar 2019 09:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901602;
        bh=uIzQmm7xwo6pjeutiBKDv294PNlt7yUiey2S8mUnKi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nkh88uIG+9kFHJkeZSF/NI5QpS/JALN9iI+9NnsbiKKkiXl5ITbg54NQmwjrz4Kuc
         bKx42Mf2CHPuyPkuIPKqhF9peSLo97R6VibP+yNs9aUr5WsNsEWnb2gP/NJ+3gxxqE
         F753K7pMgvQJV6Ty0GoqG1d/3PfvOdYFfBoH6OLA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4.19 37/52] f2fs: wait on atomic writes to count F2FS_CP_WB_DATA
Date:   Mon, 18 Mar 2019 10:25:34 +0100
Message-Id: <20190318084017.896921136@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

commit 31867b23d7d1ee3535136c6a410a6cf56f666bfc upstream.

Otherwise, we can get wrong counts incurring checkpoint hang.

IO_W (CP:  -24, Data:   24, Flush: (   0    0    1), Discard: (   0    0))

Thread A                        Thread B
- f2fs_write_data_pages
 -  __write_data_page
  - f2fs_submit_page_write
   - inc_page_count(F2FS_WB_DATA)
     type is F2FS_WB_DATA due to file is non-atomic one
- f2fs_ioc_start_atomic_write
 - set_inode_flag(FI_ATOMIC_FILE)
                                - f2fs_write_end_io
                                 - dec_page_count(F2FS_WB_CP_DATA)
                                   type is F2FS_WB_DATA due to file becomes
                                   atomic one

Cc: <stable@vger.kernel.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/f2fs/file.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1736,10 +1736,12 @@ static int f2fs_ioc_start_atomic_write(s
 
 	down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 
-	if (!get_dirty_pages(inode))
-		goto skip_flush;
-
-	f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
+	/*
+	 * Should wait end_io to count F2FS_WB_CP_DATA correctly by
+	 * f2fs_is_atomic_file.
+	 */
+	if (get_dirty_pages(inode))
+		f2fs_msg(F2FS_I_SB(inode)->sb, KERN_WARNING,
 		"Unexpected flush for atomic writes: ino=%lu, npages=%u",
 					inode->i_ino, get_dirty_pages(inode));
 	ret = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
@@ -1747,7 +1749,7 @@ static int f2fs_ioc_start_atomic_write(s
 		up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		goto out;
 	}
-skip_flush:
+
 	set_inode_flag(inode, FI_ATOMIC_FILE);
 	clear_inode_flag(inode, FI_ATOMIC_REVOKE_REQUEST);
 	up_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);


