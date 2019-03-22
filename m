Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847B4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D11218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254738;
	bh=DXoT2AOza4eLUNi7essRUblbdjdDiDYU4vqS5hul7RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DUQ2ZC5Vc2JHjCpC9e+e4sBidgrXCUW5N7keIfndvhtpKmR2ojtku/0VTocBg7y5r
	 VJFVW3ch9sIitfJw9rNx945Q1JpZ3k2UzE5CH8YFl2TDaKHs/vOJEOghFJSdArfhjZ
	 DlnZKuMTfPkq0SompqWMzxj5wJ9TomgtBc1IImdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfCVLi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:38:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731035AbfCVLix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:38:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BB112183E;
        Fri, 22 Mar 2019 11:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254731;
        bh=DXoT2AOza4eLUNi7essRUblbdjdDiDYU4vqS5hul7RI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07yWAicm4uyEdwFNjK+0hYXbvoVYPdD9Vnvyebc/ajxAdIF8wgxXjrMacokIBR4Or
         4vGyi14t9OzfzzZY8tu6UtkRK1luKXxbp9vyseIh/aHPylFlGiJ1Qs3asdXCdxxiAp
         DZlHNo1DSSo1ez9yF0VmTR0KcLVJ7UAgG9fS/S0M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Theodore Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 4.4 208/230] jbd2: fix compile warning when using JBUFFER_TRACE
Date:   Fri, 22 Mar 2019 12:15:46 +0100
Message-Id: <20190322111251.486122442@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: zhangyi (F) <yi.zhang@huawei.com>

commit 01215d3edb0f384ddeaa5e4a22c1ae5ff634149f upstream.

The jh pointer may be used uninitialized in the two cases below and the
compiler complain about it when enabling JBUFFER_TRACE macro, fix them.

In file included from fs/jbd2/transaction.c:19:0:
fs/jbd2/transaction.c: In function ‘jbd2_journal_get_undo_access’:
./include/linux/jbd2.h:1637:38: warning: ‘jh’ is used uninitialized in this function [-Wuninitialized]
 #define JBUFFER_TRACE(jh, info) do { printk("%s: %d\n", __func__, jh->b_jcount);} while (0)
                                      ^
fs/jbd2/transaction.c:1219:23: note: ‘jh’ was declared here
  struct journal_head *jh;
                       ^
In file included from fs/jbd2/transaction.c:19:0:
fs/jbd2/transaction.c: In function ‘jbd2_journal_dirty_metadata’:
./include/linux/jbd2.h:1637:38: warning: ‘jh’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 #define JBUFFER_TRACE(jh, info) do { printk("%s: %d\n", __func__, jh->b_jcount);} while (0)
                                      ^
fs/jbd2/transaction.c:1332:23: note: ‘jh’ was declared here
  struct journal_head *jh;
                       ^

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/jbd2/transaction.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1215,11 +1215,12 @@ int jbd2_journal_get_undo_access(handle_
 	struct journal_head *jh;
 	char *committed_data = NULL;
 
-	JBUFFER_TRACE(jh, "entry");
 	if (jbd2_write_access_granted(handle, bh, true))
 		return 0;
 
 	jh = jbd2_journal_add_journal_head(bh);
+	JBUFFER_TRACE(jh, "entry");
+
 	/*
 	 * Do this first --- it can drop the journal lock, so we want to
 	 * make sure that obtaining the committed_data is done
@@ -1336,15 +1337,17 @@ int jbd2_journal_dirty_metadata(handle_t
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
-	if (!buffer_jbd(bh)) {
-		ret = -EUCLEAN;
-		goto out;
-	}
+	if (!buffer_jbd(bh))
+		return -EUCLEAN;
+
 	/*
 	 * We don't grab jh reference here since the buffer must be part
 	 * of the running transaction.
 	 */
 	jh = bh2jh(bh);
+	jbd_debug(5, "journal_head %p\n", jh);
+	JBUFFER_TRACE(jh, "entry");
+
 	/*
 	 * This and the following assertions are unreliable since we may see jh
 	 * in inconsistent state unless we grab bh_state lock. But this is
@@ -1378,9 +1381,6 @@ int jbd2_journal_dirty_metadata(handle_t
 	}
 
 	journal = transaction->t_journal;
-	jbd_debug(5, "journal_head %p\n", jh);
-	JBUFFER_TRACE(jh, "entry");
-
 	jbd_lock_bh_state(bh);
 
 	if (jh->b_modified == 0) {


