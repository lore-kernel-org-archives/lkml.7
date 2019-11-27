Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E05AC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C1D20869
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574890673;
	bh=g6tQzpPav/HyLLUIHmdIMx0pZsXaRsRBu3POfBuvuyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xhufV5KUXRnc2TyoH++8d6uvPHoHYX+lKUrLrAn6cfYk1Pm4rJVJukBZchg0qxybs
	 ssSctah+3QBcxfyRxgVW39mP345SgcQMaepZJGL4e6ksZC+t5kjJ+/Q3ywtMfoVMba
	 YMfWvJP7M73LnLrs/icdOfmtawoI9aleMkrCQdLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfK0UqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:46:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbfK0UqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:46:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D316821775;
        Wed, 27 Nov 2019 20:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574887573;
        bh=g6tQzpPav/HyLLUIHmdIMx0pZsXaRsRBu3POfBuvuyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GGJctMCBNZiDzYGa0Y/3+XlpzFUp05O9WjHjpDppsG9/tJc4OXdFM1OQ82xYgfrpl
         5dfw6/32e29+8i7FJlQz2K4wwslq9zZEcLgFAiTbeWfXKfB3Qr9k2TFxvRal70VW4v
         v9G88O1vc6FSusylzVzyDjwNR1omCoeoFi0WFnac=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joseph Qi <joseph.qi@linux.alibaba.com>,
        Thomas Voegtle <tv@lio96.de>, Changwei Ge <gechangwei@live.cn>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 012/211] Revert "fs: ocfs2: fix possible null-pointer dereferences in ocfs2_xa_prepare_entry()"
Date:   Wed, 27 Nov 2019 21:29:05 +0100
Message-Id: <20191127203051.329138588@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203049.431810767@linuxfoundation.org>
References: <20191127203049.431810767@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Qi <joseph.qi@linux.alibaba.com>

commit 94b07b6f9e2e996afff7395de6b35f34f4cb10bf upstream.

This reverts commit 56e94ea132bb5c2c1d0b60a6aeb34dcb7d71a53d.

Commit 56e94ea132bb ("fs: ocfs2: fix possible null-pointer dereferences
in ocfs2_xa_prepare_entry()") introduces a regression that fail to
create directory with mount option user_xattr and acl.  Actually the
reported NULL pointer dereference case can be correctly handled by
loc->xl_ops->xlo_add_entry(), so revert it.

Link: http://lkml.kernel.org/r/1573624916-83825-1-git-send-email-joseph.qi@linux.alibaba.com
Fixes: 56e94ea132bb ("fs: ocfs2: fix possible null-pointer dereferences in ocfs2_xa_prepare_entry()")
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reported-by: Thomas Voegtle <tv@lio96.de>
Acked-by: Changwei Ge <gechangwei@live.cn>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/ocfs2/xattr.c |   56 ++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 23 deletions(-)

--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1497,6 +1497,18 @@ static int ocfs2_xa_check_space(struct o
 	return loc->xl_ops->xlo_check_space(loc, xi);
 }
 
+static void ocfs2_xa_add_entry(struct ocfs2_xa_loc *loc, u32 name_hash)
+{
+	loc->xl_ops->xlo_add_entry(loc, name_hash);
+	loc->xl_entry->xe_name_hash = cpu_to_le32(name_hash);
+	/*
+	 * We can't leave the new entry's xe_name_offset at zero or
+	 * add_namevalue() will go nuts.  We set it to the size of our
+	 * storage so that it can never be less than any other entry.
+	 */
+	loc->xl_entry->xe_name_offset = cpu_to_le16(loc->xl_size);
+}
+
 static void ocfs2_xa_add_namevalue(struct ocfs2_xa_loc *loc,
 				   struct ocfs2_xattr_info *xi)
 {
@@ -2128,31 +2140,29 @@ static int ocfs2_xa_prepare_entry(struct
 	if (rc)
 		goto out;
 
-	if (!loc->xl_entry) {
-		rc = -EINVAL;
-		goto out;
-	}
-
-	if (ocfs2_xa_can_reuse_entry(loc, xi)) {
-		orig_value_size = loc->xl_entry->xe_value_size;
-		rc = ocfs2_xa_reuse_entry(loc, xi, ctxt);
-		if (rc)
-			goto out;
-		goto alloc_value;
-	}
+	if (loc->xl_entry) {
+		if (ocfs2_xa_can_reuse_entry(loc, xi)) {
+			orig_value_size = loc->xl_entry->xe_value_size;
+			rc = ocfs2_xa_reuse_entry(loc, xi, ctxt);
+			if (rc)
+				goto out;
+			goto alloc_value;
+		}
 
-	if (!ocfs2_xattr_is_local(loc->xl_entry)) {
-		orig_clusters = ocfs2_xa_value_clusters(loc);
-		rc = ocfs2_xa_value_truncate(loc, 0, ctxt);
-		if (rc) {
-			mlog_errno(rc);
-			ocfs2_xa_cleanup_value_truncate(loc,
-							"overwriting",
-							orig_clusters);
-			goto out;
+		if (!ocfs2_xattr_is_local(loc->xl_entry)) {
+			orig_clusters = ocfs2_xa_value_clusters(loc);
+			rc = ocfs2_xa_value_truncate(loc, 0, ctxt);
+			if (rc) {
+				mlog_errno(rc);
+				ocfs2_xa_cleanup_value_truncate(loc,
+								"overwriting",
+								orig_clusters);
+				goto out;
+			}
 		}
-	}
-	ocfs2_xa_wipe_namevalue(loc);
+		ocfs2_xa_wipe_namevalue(loc);
+	} else
+		ocfs2_xa_add_entry(loc, name_hash);
 
 	/*
 	 * If we get here, we have a blank entry.  Fill it.  We grow our


