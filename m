Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA30C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B915218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 17:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610331;
	bh=83fkPL9Lj6vVYKrV9g96lx8UFVsTllRcVRk/UrUpdcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uALAtnAFPfnMMCz3dmRVCuziUZ/WT87njDD8oMH7dz9hYRggt9WVhkc/6UZkR/eyo
	 UaKp0x9gMJjOxTTH7y2bIDxWevAlhdIbrZolquSmuLlRCGCwqWJTCWYcjJpJI0wPpL
	 9dtosxGQ9w+x7QaKciSvkFR7eVWuGsQAxisqthg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389961AbfDRR6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 13:58:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389928AbfDRR6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:58:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D45206B6;
        Thu, 18 Apr 2019 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610326;
        bh=83fkPL9Lj6vVYKrV9g96lx8UFVsTllRcVRk/UrUpdcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZhtWc13+KkzGSUuurXtEad2ARHptmyj7PYT/2Wl7zvmxQqx8/z91WaATHi8PSqdc
         SjoS9MI7if9fmRezRqtan5UAydkcnbN+s8KrBDuFBhGYPlIC9i0AwrXKTX6lRWnb84
         jNzk7p6IrNt27iR5V7O/gLGy6LLc77fUcQqY2GhQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ZhangXiaoxu <zhangxiaoxu5@huawei.com>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 003/110] inotify: Fix fsnotify_mark refcount leak in inotify_update_existing_watch()
Date:   Thu, 18 Apr 2019 19:55:52 +0200
Message-Id: <20190418160437.823876738@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 62c9d2674b31d4c8a674bee86b7edc6da2803aea ]

Commit 4d97f7d53da7dc83 ("inotify: Add flag IN_MASK_CREATE for
inotify_add_watch()") forgot to call fsnotify_put_mark() with
IN_MASK_CREATE after fsnotify_find_mark()

Fixes: 4d97f7d53da7dc83 ("inotify: Add flag IN_MASK_CREATE for inotify_add_watch()")
Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/inotify/inotify_user.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 780bba695453..97a51690338e 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -519,8 +519,10 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, group);
 	if (!fsn_mark)
 		return -ENOENT;
-	else if (create)
-		return -EEXIST;
+	else if (create) {
+		ret = -EEXIST;
+		goto out;
+	}
 
 	i_mark = container_of(fsn_mark, struct inotify_inode_mark, fsn_mark);
 
@@ -548,6 +550,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	/* return the wd */
 	ret = i_mark->wd;
 
+out:
 	/* match the get from fsnotify_find_mark() */
 	fsnotify_put_mark(fsn_mark);
 
-- 
2.19.1



