Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDA7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C0FF20854
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571436718;
	bh=fry4oSyHeunB2T5myi7abXI9AvaNsGHVM56HfHU+S0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dVB9R+UrCu7LpHs+dzvfbvpe/dXcYPUY1cv6Ftqi96U0HYXTxoU35zhhbHOHFQ5e4
	 Qgx05XG0yvrKOuXf8G9Hs+hE966cotkBseUymFd/g9zZ62z5k7KbRflranKz0yyvaK
	 2EqyS6bMKy36IB72gEXvDYaL7Dftsxi4KiNfuUM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391362AbfJRWL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:11:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:43480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390229AbfJRWKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABA8F22479;
        Fri, 18 Oct 2019 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571436630;
        bh=fry4oSyHeunB2T5myi7abXI9AvaNsGHVM56HfHU+S0s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dK86aC9VpbsxcwE2oJa3dnuQSdwAYgj392FCaHMdu5ul3HmKuDlf/l8JLyfIkjbaR
         lPbSBCF5RBgmF4/x78ULdb5qg6ccsvOQYHI/BwsaHNJiAKLB8cPKNE1NsaVyM+5B/J
         zbIdZSt8JGVg4Oe41fqSAqyjOQ6fKlww2RsPp4aA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Changwei Ge <gechangwei@live.cn>, Gang He <ghe@suse.com>,
        Jun Piao <piaojun@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 14/21] fs: ocfs2: fix possible null-pointer dereferences in ocfs2_xa_prepare_entry()
Date:   Fri, 18 Oct 2019 18:10:00 -0400
Message-Id: <20191018221007.10851-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191018221007.10851-1-sashal@kernel.org>
References: <20191018221007.10851-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 56e94ea132bb5c2c1d0b60a6aeb34dcb7d71a53d ]

In ocfs2_xa_prepare_entry(), there is an if statement on line 2136 to
check whether loc->xl_entry is NULL:

    if (loc->xl_entry)

When loc->xl_entry is NULL, it is used on line 2158:

    ocfs2_xa_add_entry(loc, name_hash);
        loc->xl_entry->xe_name_hash = cpu_to_le32(name_hash);
        loc->xl_entry->xe_name_offset = cpu_to_le16(loc->xl_size);

and line 2164:

    ocfs2_xa_add_namevalue(loc, xi);
        loc->xl_entry->xe_value_size = cpu_to_le64(xi->xi_value_len);
        loc->xl_entry->xe_name_len = xi->xi_name_len;

Thus, possible null-pointer dereferences may occur.

To fix these bugs, if loc-xl_entry is NULL, ocfs2_xa_prepare_entry()
abnormally returns with -EINVAL.

These bugs are found by a static analysis tool STCheck written by us.

[akpm@linux-foundation.org: remove now-unused ocfs2_xa_add_entry()]
Link: http://lkml.kernel.org/r/20190726101447.9153-1-baijiaju1990@gmail.com
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/xattr.c | 56 ++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 33 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 06faa608e5622..dfa6d45dc4dc4 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1475,18 +1475,6 @@ static int ocfs2_xa_check_space(struct ocfs2_xa_loc *loc,
 	return loc->xl_ops->xlo_check_space(loc, xi);
 }
 
-static void ocfs2_xa_add_entry(struct ocfs2_xa_loc *loc, u32 name_hash)
-{
-	loc->xl_ops->xlo_add_entry(loc, name_hash);
-	loc->xl_entry->xe_name_hash = cpu_to_le32(name_hash);
-	/*
-	 * We can't leave the new entry's xe_name_offset at zero or
-	 * add_namevalue() will go nuts.  We set it to the size of our
-	 * storage so that it can never be less than any other entry.
-	 */
-	loc->xl_entry->xe_name_offset = cpu_to_le16(loc->xl_size);
-}
-
 static void ocfs2_xa_add_namevalue(struct ocfs2_xa_loc *loc,
 				   struct ocfs2_xattr_info *xi)
 {
@@ -2118,29 +2106,31 @@ static int ocfs2_xa_prepare_entry(struct ocfs2_xa_loc *loc,
 	if (rc)
 		goto out;
 
-	if (loc->xl_entry) {
-		if (ocfs2_xa_can_reuse_entry(loc, xi)) {
-			orig_value_size = loc->xl_entry->xe_value_size;
-			rc = ocfs2_xa_reuse_entry(loc, xi, ctxt);
-			if (rc)
-				goto out;
-			goto alloc_value;
-		}
+	if (!loc->xl_entry) {
+		rc = -EINVAL;
+		goto out;
+	}
 
-		if (!ocfs2_xattr_is_local(loc->xl_entry)) {
-			orig_clusters = ocfs2_xa_value_clusters(loc);
-			rc = ocfs2_xa_value_truncate(loc, 0, ctxt);
-			if (rc) {
-				mlog_errno(rc);
-				ocfs2_xa_cleanup_value_truncate(loc,
-								"overwriting",
-								orig_clusters);
-				goto out;
-			}
+	if (ocfs2_xa_can_reuse_entry(loc, xi)) {
+		orig_value_size = loc->xl_entry->xe_value_size;
+		rc = ocfs2_xa_reuse_entry(loc, xi, ctxt);
+		if (rc)
+			goto out;
+		goto alloc_value;
+	}
+
+	if (!ocfs2_xattr_is_local(loc->xl_entry)) {
+		orig_clusters = ocfs2_xa_value_clusters(loc);
+		rc = ocfs2_xa_value_truncate(loc, 0, ctxt);
+		if (rc) {
+			mlog_errno(rc);
+			ocfs2_xa_cleanup_value_truncate(loc,
+							"overwriting",
+							orig_clusters);
+			goto out;
 		}
-		ocfs2_xa_wipe_namevalue(loc);
-	} else
-		ocfs2_xa_add_entry(loc, name_hash);
+	}
+	ocfs2_xa_wipe_namevalue(loc);
 
 	/*
 	 * If we get here, we have a blank entry.  Fill it.  We grow our
-- 
2.20.1

