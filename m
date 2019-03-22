Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DAAC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3315F21900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257178;
	bh=Ywc/NQSdLK8iNVsXW/hPln9KJrG7vNvT6Mz5sOyQnes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uuEShR6y2Xh/UfD+61Dpc0tGOT2gX+2m0x+fjnUvLxlC1n6cO2HKZBYP+1wiYcA5z
	 IXWZbID6EfahY8yypJWDz7ZMz8yEhtjVNcIkTsJ4R3tgiuCt1jxJHB7B3H+Ruskuy+
	 +Na5IJAmMcksFOWPuTSSdeNHHKF5lSwvOEDKXJMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390632AbfCVMTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:19:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390082AbfCVMTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:19:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8708B21900;
        Fri, 22 Mar 2019 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257170;
        bh=Ywc/NQSdLK8iNVsXW/hPln9KJrG7vNvT6Mz5sOyQnes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqsoc0oQ+h/lt9030EoiMWco+BaQaTYV32EoiH4gjRox7Fph8O/bW1K9n2Nr1DDh9
         +j1aZk69EBZJduhnZlfRTCehvYxQVvebQj7pUYSDB6LJpXtfD0osm02CBKMyJ2zuov
         b+S6O7nNJMxlwWmJDF+zGyCXae7ZjwYATKd+AlLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5.0 152/238] jbd2: clear dirty flag when revoking a buffer from an older transaction
Date:   Fri, 22 Mar 2019 12:16:11 +0100
Message-Id: <20190322111307.317830241@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

From: zhangyi (F) <yi.zhang@huawei.com>

commit 904cdbd41d749a476863a0ca41f6f396774f26e4 upstream.

Now, we capture a data corruption problem on ext4 while we're truncating
an extent index block. Imaging that if we are revoking a buffer which
has been journaled by the committing transaction, the buffer's jbddirty
flag will not be cleared in jbd2_journal_forget(), so the commit code
will set the buffer dirty flag again after refile the buffer.

fsx                               kjournald2
                                  jbd2_journal_commit_transaction
jbd2_journal_revoke                commit phase 1~5...
 jbd2_journal_forget
   belongs to older transaction    commit phase 6
   jbddirty not clear               __jbd2_journal_refile_buffer
                                     __jbd2_journal_unfile_buffer
                                      test_clear_buffer_jbddirty
                                       mark_buffer_dirty

Finally, if the freed extent index block was allocated again as data
block by some other files, it may corrupt the file data after writing
cached pages later, such as during unmount time. (In general,
clean_bdev_aliases() related helpers should be invoked after
re-allocation to prevent the above corruption, but unfortunately we
missed it when zeroout the head of extra extent blocks in
ext4_ext_handle_unwritten_extents()).

This patch mark buffer as freed and set j_next_transaction to the new
transaction when it already belongs to the committing transaction in
jbd2_journal_forget(), so that commit code knows it should clear dirty
bits when it is done with the buffer.

This problem can be reproduced by xfstests generic/455 easily with
seeds (3246 3247 3248 3249).

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/transaction.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1609,14 +1609,21 @@ int jbd2_journal_forget (handle_t *handl
 		/* However, if the buffer is still owned by a prior
 		 * (committing) transaction, we can't drop it yet... */
 		JBUFFER_TRACE(jh, "belongs to older transaction");
-		/* ... but we CAN drop it from the new transaction if we
-		 * have also modified it since the original commit. */
+		/* ... but we CAN drop it from the new transaction through
+		 * marking the buffer as freed and set j_next_transaction to
+		 * the new transaction, so that not only the commit code
+		 * knows it should clear dirty bits when it is done with the
+		 * buffer, but also the buffer can be checkpointed only
+		 * after the new transaction commits. */
 
-		if (jh->b_next_transaction) {
-			J_ASSERT(jh->b_next_transaction == transaction);
+		set_buffer_freed(bh);
+
+		if (!jh->b_next_transaction) {
 			spin_lock(&journal->j_list_lock);
-			jh->b_next_transaction = NULL;
+			jh->b_next_transaction = transaction;
 			spin_unlock(&journal->j_list_lock);
+		} else {
+			J_ASSERT(jh->b_next_transaction == transaction);
 
 			/*
 			 * only drop a reference if this transaction modified


