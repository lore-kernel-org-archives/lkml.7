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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D78AC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6682218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyZggC58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfGCNST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:18:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44173 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbfGCNST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:18:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id t16so1265730pfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 06:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OWDPGe6tZjA1ZZEdo2HJ+MoOn08G0gVe3rmUgt2yGp0=;
        b=hyZggC58Rxch+GACWSx41usrigkIMgWGQDdkcsotR58aFZftEmhMUI3yi4iSud/h2a
         oIWUTjjhx1e0LP0YJu/SkSukvDXl0ALOjbFObkk51tSHgE4CcyPQolfYkzERRM5SunwZ
         dLbh8ScLb937V8i94JoAkGq1Gqr1cwUryU9ACwULocPYad1jlmJdxoNTQ+3IBbgfLiaW
         JPWoJFb4w/mzjZOtLU/7agKPUbfceFGQYMjsmCgmSC6lf5HMbA2V+ptSuXm00QY/G+fv
         a3GneB8POaFJQoUb264EaXiZCRBRGi98ob0T3+gHE3ck5MySNzm6AHnAocZuWg7/fQUV
         ELOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OWDPGe6tZjA1ZZEdo2HJ+MoOn08G0gVe3rmUgt2yGp0=;
        b=RfUJ8fqqJPIeSe7ODhU+OPc6h2bjI4uKvqfkv3VP+/0fKuSi6x7puH1v/PVGwAZARh
         UddYwr2StxLSNG0eAO+nZilHSq47eNix//zNKheYxnKAaYv+iU6yeCxeHMa4n+rA6y62
         LgFt3UEJuoIP47l+0xqXZiaY0is/rk01j986KU+pDVXlT0RRiFBHEkJZ0XjuxxB5S30X
         rSHfYAoSAXwclxVro0Fj5npVJ/IFH3g3D8+7slaS4+Zn8kPa4mAGNLu29Sg9nk7iGgKu
         CMUQA9lZNeeB7v33giwSSHxUpV6LVrQMwROaUSab4HMAe+SBSc0GP1ZaZfHzLvdS8fLg
         Cn0Q==
X-Gm-Message-State: APjAAAVF1GSB468ncz5XrM2f/wAm0mvsZJTbHL3rUSXFIkhy2KSvz+3i
        pkA1YyNfTJazPxeK3utXKPg=
X-Google-Smtp-Source: APXvYqzmKIEmMpeylFjnLE21xCZcmp44jGsi5N0UZivd5lHnrB+j/X7IcnFWkTYy6TSmtgF1UzW4oQ==
X-Received: by 2002:a17:90a:23ce:: with SMTP id g72mr12845778pje.77.1562159898441;
        Wed, 03 Jul 2019 06:18:18 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id o95sm2058389pjb.4.2019.07.03.06.18.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:18:17 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 27/30] ocfs2: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:18:08 +0800
Message-Id: <20190703131808.25921-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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

