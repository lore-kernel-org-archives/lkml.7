Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DB0C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1853C215F1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574888135;
	bh=e5pyDpsZtfKwjUDv8u4P8+VPc27Xg3pQgZsiY3RfjZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kNNNhGALeWxlmUAmj2t2fTF9icYhkgUMbrBirFxn7fIlirVsjnboSKX13NwIMt0NN
	 WDgoIwZFG7G/vd3Qg5WuZy31QkMAIHAUBwyKCdxdSCG/iSDR5bgh5MnhEuH3TqPelj
	 fTP8aRZToEKPxOFFriR1nDiY83xrMxvevSdK6XSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfK0Uzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:55:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:45982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730654AbfK0Uza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:55:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD3E2070B;
        Wed, 27 Nov 2019 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888129;
        bh=e5pyDpsZtfKwjUDv8u4P8+VPc27Xg3pQgZsiY3RfjZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f8zyovgOUm9tO0NDCGaBA6QyvfOUcZcbGHaP1Vh+DvW6nD/XI32NEm9nU031DmFQa
         7dv0Lfv7uM7eL3zg0X4uWiIIq79GmIDIK7d7IYU0TTEkguJrS4zcahONKaGTgXjTNT
         SKwLu2iD3f+On+WyMvdjSNr/zoAje5GbmsEggEf4=
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
Subject: [PATCH 4.19 016/306] Revert "fs: ocfs2: fix possible null-pointer dereferences in ocfs2_xa_prepare_entry()"
Date:   Wed, 27 Nov 2019 21:27:46 +0100
Message-Id: <20191127203115.887290625@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
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
@@ -1498,6 +1498,18 @@ static int ocfs2_xa_check_space(struct o
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
@@ -2129,31 +2141,29 @@ static int ocfs2_xa_prepare_entry(struct
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


