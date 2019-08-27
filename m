Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EBCC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25D421883
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfH0DI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:08:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728025AbfH0DI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:08:57 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3522412DB11A24F44196;
        Tue, 27 Aug 2019 11:08:54 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 11:08:46 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <akpm@linux-foundation.org>, <sfr@canb.auug.org.au>,
        <jack@suse.cz>, <reiserfs-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 1/2] reiserfs: remove set but not used variable in journal.c
Date:   Tue, 27 Aug 2019 11:29:31 +0800
Message-ID: <20190827032932.46622-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

fs/reiserfs/journal.c: In function flush_used_journal_lists:
fs/reiserfs/journal.c:1791:6: warning: variable ret set but not used
[-Wunused-but-set-variable]

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/reiserfs/journal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 75d9d52d489f..4b3e3e73b512 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -1788,7 +1788,6 @@ static int flush_used_journal_lists(struct super_block *s,
 {
 	unsigned long len = 0;
 	unsigned long cur_len;
-	int ret;
 	int i;
 	int limit = 256;
 	struct reiserfs_journal_list *tjl;
@@ -1825,9 +1824,9 @@ static int flush_used_journal_lists(struct super_block *s,
 	 * transactions, but only bother if we've actually spanned
 	 * across multiple lists
 	 */
-	if (flush_jl != jl) {
-		ret = kupdate_transactions(s, jl, &tjl, &trans_id, len, i);
-	}
+	if (flush_jl != jl)
+		kupdate_transactions(s, jl, &tjl, &trans_id, len, i);
+
 	flush_journal_list(s, flush_jl, 1);
 	put_journal_list(s, flush_jl);
 	put_journal_list(s, jl);
-- 
2.17.2

