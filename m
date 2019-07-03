Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04C8C06511
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750E92187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JkAbphqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfGCQb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:31:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43813 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfGCQbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:31:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id f25so1502065pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pljruynMiLYPXmgVTw1tJ3KNixvuPTUOaZWUF7N5ujA=;
        b=JkAbphqDO0v5PZx34e11f0uDlFeruOXsaHcHKFb84Gdzcnxj5IZ+kp2wpI+oIupWgh
         ck7aUrQJcMDv15yLN9xV1znt/kYxtnETaCx045bgrayTBRZNiBVuU3hWfNc6DL50bB3I
         wPyj/MgAx+MyAMc0hkN2cjl0EcSERPa97nSeQTi4AFivJB14bFfl8u/as+5toxuZEJON
         3k4BOXL5qkVlErmqIUBRjpV29ld19nKwVEkhT26kSdgJwJOSSMuOHIrAAJEodSB02Vsc
         2ZBKybMUI1KWLVFAn9V/xaMueE8xqyRaRipIhlnCcRysg3v6W3fRbjWMZmROOlVdqk6U
         h8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pljruynMiLYPXmgVTw1tJ3KNixvuPTUOaZWUF7N5ujA=;
        b=lMTyF9P+fo0+y3Y/GpARN7MoOnNWwo9jJPfrehFh7kNrA6X6XdBR3/HfAhVF1RfBDl
         K8J4On/2z7X3KZ8F09lchXx6svZqv1QGD6HKk9qQmW1fjBeG+oc0/A4mNR+QxZbnttjl
         lj6wsU3Esm50TJjUBRYNU+/+OOHpZ3txW8FVbpEhPA6LiB35Yg0DkYew8yUFCC4vYl3L
         yKiAN63GjkWK8bz41RCwHqlNmPYehOxgZR7NQ41fckbTNpLoacKY0LldKIlpnboOEQ11
         ufudi1O6sQ7xpxUVKa6NczPBtgUEzwwQq4xbHgKrIFfaGoEVrlAkyFsTYVmM/qEKmbX2
         Bf/g==
X-Gm-Message-State: APjAAAUgmKwDyLz1uY+Jo5q6jQeCMlMF9Y9V/Y569KX0wDZ9bXsSSOv/
        Y/B0FKi3qh2byNMUCkphmESvG5XoTE8=
X-Google-Smtp-Source: APXvYqyp+vowYIamWS/rUs94TZ6sNxciNm3WH96pOpdZPejljL5hDFvY3sVtjl/vKluwzts0gdsz5w==
X-Received: by 2002:a63:f349:: with SMTP id t9mr36445957pgj.296.1562171515276;
        Wed, 03 Jul 2019 09:31:55 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 196sm3130312pfy.167.2019.07.03.09.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:31:54 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 31/35] ocfs2: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:31:47 +0800
Message-Id: <20190703163147.881-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 fs/ocfs2/alloc.c      | 8 +++-----
 fs/ocfs2/localalloc.c | 6 ++----
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index d1348fc4ca6d..d4911d70c326 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -6191,17 +6191,15 @@ int ocfs2_begin_truncate_log_recovery(struct ocfs2_super *osb,
 	if (le16_to_cpu(tl->tl_used)) {
 		trace_ocfs2_truncate_log_recovery_num(le16_to_cpu(tl->tl_used));
 
-		*tl_copy = kmalloc(tl_bh->b_size, GFP_KERNEL);
+		/* Assuming the write-out below goes well, this copy
+		 * will be passed back to recovery for processing. */
+		*tl_copy = kmemdup(tl_bh->b_data, tl_bh->b_size, GFP_KERNEL);
 		if (!(*tl_copy)) {
 			status = -ENOMEM;
 			mlog_errno(status);
 			goto bail;
 		}
 
-		/* Assuming the write-out below goes well, this copy
-		 * will be passed back to recovery for processing. */
-		memcpy(*tl_copy, tl_bh->b_data, tl_bh->b_size);
-
 		/* All we need to do to clear the truncate log is set
 		 * tl_used. */
 		tl->tl_used = 0;
diff --git a/fs/ocfs2/localalloc.c b/fs/ocfs2/localalloc.c
index f03674afbd30..158e5af767fd 100644
--- a/fs/ocfs2/localalloc.c
+++ b/fs/ocfs2/localalloc.c
@@ -424,12 +424,11 @@ void ocfs2_shutdown_local_alloc(struct ocfs2_super *osb)
 	bh = osb->local_alloc_bh;
 	alloc = (struct ocfs2_dinode *) bh->b_data;
 
-	alloc_copy = kmalloc(bh->b_size, GFP_NOFS);
+	alloc_copy = kmemdup(alloc, bh->b_size, GFP_NOFS);
 	if (!alloc_copy) {
 		status = -ENOMEM;
 		goto out_commit;
 	}
-	memcpy(alloc_copy, alloc, bh->b_size);
 
 	status = ocfs2_journal_access_di(handle, INODE_CACHE(local_alloc_inode),
 					 bh, OCFS2_JOURNAL_ACCESS_WRITE);
@@ -1272,13 +1271,12 @@ static int ocfs2_local_alloc_slide_window(struct ocfs2_super *osb,
 	 * local alloc shutdown won't try to double free main bitmap
 	 * bits. Make a copy so the sync function knows which bits to
 	 * free. */
-	alloc_copy = kmalloc(osb->local_alloc_bh->b_size, GFP_NOFS);
+	alloc_copy = kmemdup(alloc, osb->local_alloc_bh->b_size, GFP_NOFS);
 	if (!alloc_copy) {
 		status = -ENOMEM;
 		mlog_errno(status);
 		goto bail;
 	}
-	memcpy(alloc_copy, alloc, osb->local_alloc_bh->b_size);
 
 	status = ocfs2_journal_access_di(handle,
 					 INODE_CACHE(local_alloc_inode),
-- 
2.11.0

