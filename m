Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95327C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664822068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403369;
	bh=jcXj7HV4yf5/Cm5saoBjX27s47NqlAsf2IvWyuAQFSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aTUY09UTo8zUcBFvkG5IcZx6YVjJnDGr4qrtmYmHXi6OWTHCdUFGFtznHL1lS3tSg
	 3gKlX6ZsM6Mx4O7DELWMgFi9y9nKSjLiuYqjcmSL2rcHyv+JZbpcB6+F7Id7p4SLEZ
	 NqtU9+unKxEWVUXe9v5Iw3O3prYiHglKyfHOVcwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbfKVGQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:16:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:51528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729584AbfKVGOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:14:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1B1320707;
        Fri, 22 Nov 2019 06:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403239;
        bh=jcXj7HV4yf5/Cm5saoBjX27s47NqlAsf2IvWyuAQFSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ikODooyH21a99QhiqNx08eMRPyIeKN6G9xcNH2rENEwFiWRUOvfexpPg1xoHHMdOa
         vY5/E7kA59IgLR655kQWMttccXNDML2z/u1V8dgsMPqtQnk3+m9fSzFpWORpNzrRcy
         yLYv2Fw9bMiopJOtTD6UuG57VPxlyMxsP/Yg3DHQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Junxiao Bi <junxiao.bi@oracle.com>,
        Yiwen Jiang <jiangyiwen@huawei.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Jun Piao <piaojun@huawei.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Joel Becker <jlbec@evilplan.org>,
        Mark Fasheh <mfasheh@versity.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, ocfs2-devel@oss.oracle.com
Subject: [PATCH AUTOSEL 4.4 51/68] ocfs2: clear journal dirty flag after shutdown journal
Date:   Fri, 22 Nov 2019 01:12:44 -0500
Message-Id: <20191122061301.4947-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junxiao Bi <junxiao.bi@oracle.com>

[ Upstream commit d85400af790dba2aa294f0a77e712f166681f977 ]

Dirty flag of the journal should be cleared at the last stage of umount,
if do it before jbd2_journal_destroy(), then some metadata in uncommitted
transaction could be lost due to io error, but as dirty flag of journal
was already cleared, we can't find that until run a full fsck.  This may
cause system panic or other corruption.

Link: http://lkml.kernel.org/r/20181121020023.3034-3-junxiao.bi@oracle.com
Signed-off-by: Junxiao Bi <junxiao.bi@oracle.com>
Reviewed-by: Yiwen Jiang <jiangyiwen@huawei.com>
Reviewed-by: Joseph Qi <jiangqi903@gmail.com>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Mark Fasheh <mfasheh@versity.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/journal.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index 722eb5bc9b8f0..2301011428a1d 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -1017,7 +1017,8 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 			mlog_errno(status);
 	}
 
-	if (status == 0) {
+	/* Shutdown the kernel journal system */
+	if (!jbd2_journal_destroy(journal->j_journal) && !status) {
 		/*
 		 * Do not toggle if flush was unsuccessful otherwise
 		 * will leave dirty metadata in a "clean" journal
@@ -1026,9 +1027,6 @@ void ocfs2_journal_shutdown(struct ocfs2_super *osb)
 		if (status < 0)
 			mlog_errno(status);
 	}
-
-	/* Shutdown the kernel journal system */
-	jbd2_journal_destroy(journal->j_journal);
 	journal->j_journal = NULL;
 
 	OCFS2_I(inode)->ip_open_count--;
-- 
2.20.1

