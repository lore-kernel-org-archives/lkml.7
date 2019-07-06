Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FDEC46499
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 00:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88913216B7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 00:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfGFAWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 20:22:38 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47702 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfGFAWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 20:22:38 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjYTM-0006nn-72; Sat, 06 Jul 2019 00:22:36 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] __detach_mounts(): lookup_mountpoint() can't return ERR_PTR() anymore
Date:   Sat,  6 Jul 2019 01:22:31 +0100
Message-Id: <20190706002236.26113-1-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190706001612.GM17978@ZenIV.linux.org.uk>
References: <20190706001612.GM17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... not since 1e9c75fb9c47 ("mnt: fix __detach_mounts infinite loop")

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 6fbc9126367a..746e3fd1f430 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1625,7 +1625,7 @@ void __detach_mounts(struct dentry *dentry)
 	namespace_lock();
 	lock_mount_hash();
 	mp = lookup_mountpoint(dentry);
-	if (IS_ERR_OR_NULL(mp))
+	if (!mp)
 		goto out_unlock;
 
 	event++;
-- 
2.11.0

