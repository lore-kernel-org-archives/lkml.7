Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26CAC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743CB229F9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 10:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Euo5xzhi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfGZKPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 06:15:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40416 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfGZKPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 06:15:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so24570838pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 03:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M9pnPqM6bt2hdIJ4IxtJ5Zv2VYOfZFm6pG5drvI0pp0=;
        b=Euo5xzhiRCA8Hz/63/lvgO3o2lXGgb+X1DuKd2urtiQfkVuvWpY3bL795/UunVYn79
         NXm+AA7qPaIj9zmrufY+P/Fqlpoo8PFvPevBd2jkM4MNHPGVqxM5Ikf6t6rcdilrDSZK
         MnQEhdDwxRT2Lq+pf965lqtDl5SvnW7CdnrQGo7R0EBOK30/voxzyMDvUPx2cFRB+zHR
         HMamOzfaAhvyXfpNrggbNWc6qd/LZxsnTlh6zxXwJbOo+IvC4Ts7SLf8SuNTZY2gQr9K
         HlBDL6UBfMn67IxZbOL5vBXzOAkE1IiRbfJdMPFmOVT+Ex01YFHT1UZ5XyLqvx2jObxx
         AdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M9pnPqM6bt2hdIJ4IxtJ5Zv2VYOfZFm6pG5drvI0pp0=;
        b=ZQfR6y7HeK/tF19DMmKSInP5oLnY5lyqhdIYKZQxXF079eDAEmPrCufDoNrh3SfQfw
         KjyucfnmuDZ/bDcDaTfCZhNNjiBy3bHubD3+1whTlciN6gnWDPxDKMftQ7K+1ZGHkCn9
         yZ/Kq5acm69OhgwxD/3YniNEY17vPkBbC7feyOja/8dj9RpUDsCsUzaN47IjS13iWZvT
         rx0zggYKNICOTozuqF0/XHA1MerjG/g8BrpWjthUqExulByX1Z8m/NAkj+Le1cc0AHvU
         OYlfssKAup6FV9ohrV8D4dx8Oe6m7U+TL8y+6UabS0vlqfi+T7TBoXCLGPT9wFtHGnA8
         Xysw==
X-Gm-Message-State: APjAAAXgUSgReDGkAgSUrlV0hUFWYKYjQkniTaKBOs/PDVHO8noV0lu0
        hiqeTv9mu//Ebi/frc3R5+k=
X-Google-Smtp-Source: APXvYqxvhBWlScGmrxvVVaulkMxcZBoXSjNIWboBDpn3bUPIQjcuH3fw1tK1O/3OxtXB2yZHylo/Vg==
X-Received: by 2002:a63:bf01:: with SMTP id v1mr88736412pgf.278.1564136105888;
        Fri, 26 Jul 2019 03:15:05 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id 21sm51365965pjh.25.2019.07.26.03.15.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 03:15:05 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/3 v2] fs: ocfs2: Fix possible null-pointer dereferences in ocfs2_xa_prepare_entry()
Date:   Fri, 26 Jul 2019 18:14:47 +0800
Message-Id: <20190726101447.9153-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
v2:
* Directly return -EINVAL if loc-xl_entry is NULL.
  Thank Joseph for helpful advice.

---
 fs/ocfs2/xattr.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 385f3aaa2448..4b876c82a35c 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -2133,29 +2133,31 @@ static int ocfs2_xa_prepare_entry(struct ocfs2_xa_loc *loc,
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
2.17.0

