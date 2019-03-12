Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FC3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C5C2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552413104;
	bh=ItRofSm2Fi8QdGu6dwPVpy8on1OCLu75yezgumCrZYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wkoxbYUZTwqplkFlegHnM57ZUZvznyJcU8tihPwdddaJZ0vn2N8qX0ptkpWQHytHw
	 s6uKqwlJExbbbp9PsXuKIju9AI47FNr7T3zgf74fqDp9SgMF49aqNOQTipfNLy+llA
	 oJWY8dAeW66hRyKD5XdU0Ll1zyfZHf3uHMUJwgMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfCLRvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbfCLROe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:34 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCA09217D4;
        Tue, 12 Mar 2019 17:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410874;
        bh=ItRofSm2Fi8QdGu6dwPVpy8on1OCLu75yezgumCrZYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VuQQlWM5f68DM1ZuXVVGsDaNj9hLiQQtX+d7BVm18tw7pYmuwDfMFsgFGxlobULos
         WPoUtpXhMO/1EyydsvCe1qEgbphx2A06TlJmIcpIL3m04bzLYY9r0gK9qzsLChYPtz
         9hZpw7mZlyMv4JKhPv57im7IG7oCj21F2MS+E9yY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/149] fs/drop_caches.c: avoid softlockups in drop_pagecache_sb()
Date:   Tue, 12 Mar 2019 10:07:56 -0700
Message-Id: <20190312170354.588307852@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c27d82f52f75fc9d8d9d40d120d2a96fdeeada5e ]

When superblock has lots of inodes without any pagecache (like is the
case for /proc), drop_pagecache_sb() will iterate through all of them
without dropping sb->s_inode_list_lock which can lead to softlockups
(one of our customers hit this).

Fix the problem by going to the slow path and doing cond_resched() in
case the process needs rescheduling.

Link: http://lkml.kernel.org/r/20190114085343.15011-1-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/drop_caches.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index 82377017130f..d31b6c72b476 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -21,8 +21,13 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
+		/*
+		 * We must skip inodes in unusual state. We may also skip
+		 * inodes without pages but we deliberately won't in case
+		 * we need to reschedule to avoid softlockups.
+		 */
 		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
-		    (inode->i_mapping->nrpages == 0)) {
+		    (inode->i_mapping->nrpages == 0 && !need_resched())) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
@@ -30,6 +35,7 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 		spin_unlock(&inode->i_lock);
 		spin_unlock(&sb->s_inode_list_lock);
 
+		cond_resched();
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 		iput(toput_inode);
 		toput_inode = inode;
-- 
2.19.1



