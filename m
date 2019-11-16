Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A050C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A617206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920619;
	bh=d9nxKcst+qQU3OV1rFInKjs+FqAyZY6FfLLPYATbVhY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YUhCl+CdXzrDRLcvbG4hJGgb0yvU+d3PyRYvGoDGyVCQ1DYXntfbim0zSnq6WHEKG
	 atebCIlHghsuYUoHmWDAlw22REyMuMT05lG034ciG7mjSDZfWLwDpEy8Y9BJ4dgKCq
	 Djo5+SPN5dWK50g+IkmsHieDo1kFdiAoe1kdFUYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfKPPtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728876AbfKPPtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Nov 2019 10:49:14 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3367120729;
        Sat, 16 Nov 2019 15:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919353;
        bh=d9nxKcst+qQU3OV1rFInKjs+FqAyZY6FfLLPYATbVhY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ob4PYnxUVAgOBua7y69qsoy0bpFZw8aNCDS4+oTxN/u7pgMDFa7Oqzk8vclyhtLc5
         1WEUvq8LEeUXY3axIvgi/QmiOJ4HFialrwjRriLVGR5dWIm7uiVVkRmd3XmusxediF
         G7i6KexGXmq17gsHN2NwRXslCmSHPGJJ2vGUNucc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Junxiao Bi <junxiao.bi@oracle.com>,
        Joseph Qi <jiangqi903@gmail.com>,
        Changwei Ge <ge.changwei@h3c.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 079/150] fs/ocfs2/dlm/dlmdebug.c: fix a sleep-in-atomic-context bug in dlm_print_one_mle()
Date:   Sat, 16 Nov 2019 10:46:17 -0500
Message-Id: <20191116154729.9573-79-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 999865764f5f128896402572b439269acb471022 ]

The kernel module may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] get_zeroed_page(GFP_NOFS)
fs/ocfs2/dlm/dlmdebug.c, 332: get_zeroed_page in dlm_print_one_mle
fs/ocfs2/dlm/dlmmaster.c, 240: dlm_print_one_mle in __dlm_put_mle
fs/ocfs2/dlm/dlmmaster.c, 255: __dlm_put_mle in dlm_put_mle
fs/ocfs2/dlm/dlmmaster.c, 254: spin_lock in dlm_put_ml

[FUNC] get_zeroed_page(GFP_NOFS)
fs/ocfs2/dlm/dlmdebug.c, 332: get_zeroed_page in dlm_print_one_mle
fs/ocfs2/dlm/dlmmaster.c, 240: dlm_print_one_mle in __dlm_put_mle
fs/ocfs2/dlm/dlmmaster.c, 222: __dlm_put_mle in dlm_put_mle_inuse
fs/ocfs2/dlm/dlmmaster.c, 219: spin_lock in dlm_put_mle_inuse

To fix this bug, GFP_NOFS is replaced with GFP_ATOMIC.

This bug is found by my static analysis tool DSAC.

Link: http://lkml.kernel.org/r/20180901112528.27025-1-baijiaju1990@gmail.com
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Joseph Qi <jiangqi903@gmail.com>
Cc: Changwei Ge <ge.changwei@h3c.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/dlm/dlmdebug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index 9b984cae4c4e0..1d6dc8422899b 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -329,7 +329,7 @@ void dlm_print_one_mle(struct dlm_master_list_entry *mle)
 {
 	char *buf;
 
-	buf = (char *) get_zeroed_page(GFP_NOFS);
+	buf = (char *) get_zeroed_page(GFP_ATOMIC);
 	if (buf) {
 		dump_mle(mle, buf, PAGE_SIZE - 1);
 		free_page((unsigned long)buf);
-- 
2.20.1

