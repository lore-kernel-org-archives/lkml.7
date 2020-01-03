Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF974C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B05B4206DB
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewY9NTJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgACRhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:37:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22207 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726077AbgACRhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578073059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=lE502Wp8axSPxP1a0NqFJAAmRZDHUYV86o+n/g9pdRs=;
        b=ewY9NTJSQB249mZKC/BXgKY9dXKDBciJ1+8g23m2rolbsQVWh4Vw1A+QGwPG+1toojy6XX
        zQvY9BzfviyW3lnsUYtEUG6QVFYcKFdjjs6cktkN2R9Rw1BQJqrdbIxCmSUN2oaK27aIW2
        vwXAVc6FjpsBZFOZu/gLF5vHtxaC6/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-97xtMnvZM9OIJ9L2EblzHQ-1; Fri, 03 Jan 2020 12:37:36 -0500
X-MC-Unique: 97xtMnvZM9OIJ9L2EblzHQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCA571005514;
        Fri,  3 Jan 2020 17:37:34 +0000 (UTC)
Received: from dustball.brq.redhat.com (unknown [10.43.17.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A09321001281;
        Fri,  3 Jan 2020 17:37:33 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, jstancek@redhat.com
Subject: [PATCH] mm/hugetlbfs: fix for_each_hstate() loop in init_hugetlbfs_fs()
Date:   Fri,  3 Jan 2020 18:37:18 +0100
Message-Id: <a14b944b6e5e207d2f84f43227c98ed1f68290a2.1578072927.git.jstancek@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP memfd_create04 started failing for some huge page sizes
after v5.4-10135-gc3bfc5dd73c6.

Problem is check introduced to for_each_hstate() loop that should
skip default_hstate_idx. Since it doesn't update 'i' counter, all
subsequent huge page sizes are skipped as well.

Fixes: 8fc312b32b25 ("mm/hugetlbfs: fix error handling when setting up mounts")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 fs/hugetlbfs/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d5c2a3158610..a66e425884d1 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1498,8 +1498,10 @@ static int __init init_hugetlbfs_fs(void)
 	/* other hstates are optional */
 	i = 0;
 	for_each_hstate(h) {
-		if (i == default_hstate_idx)
+		if (i == default_hstate_idx) {
+			i++;
 			continue;
+		}
 
 		mnt = mount_one_hugetlbfs(h);
 		if (IS_ERR(mnt))
-- 
1.8.3.1

