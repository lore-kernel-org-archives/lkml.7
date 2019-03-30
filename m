Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC57C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A512206DD
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553908320;
	bh=hEWvx/5Bx2Iu4Hjl4xWwrJJPetoCuNRgamHIZ47OHAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bOClqq4TmNPKNpK3NQ1wHinQsqZOxaF+hna35dYrJy+LQ5o8y1JVs1MLFnhyp+IEJ
	 mKRc3u37g0RcdKAag6qgRIs6g96+G045r3g/c2b12EOESyWKtmACFOMOwhEqv/+Ra/
	 9h4cZUvpI+QWtsdAe77wqJKdMwf4PMxi+uZh+J+g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbfC3Auz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730162AbfC3Auw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:50:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDD5B218D0;
        Sat, 30 Mar 2019 00:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907051;
        bh=hEWvx/5Bx2Iu4Hjl4xWwrJJPetoCuNRgamHIZ47OHAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A01Y9Jdl3S3sPhjZOsJH71WxLC035EEtkqaJn7BHatZGpAJe1hkpFnJlhzvD1SvSw
         X5WQ7FJfakbfcL48g44sLdN6LHojtqUvE+pKREPkKsNxO8sywBB2LxJREfCqEQ7bdZ
         /Yfg/u0Y+h4Dyo1yD/zCLn4x1Swumlxuh8p6qAiE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     ZhangXiaoxu <zhangxiaoxu5@huawei.com>, Jan Kara <jack@suse.cz>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 03/67] inotify: Fix fsnotify_mark refcount leak in inotify_update_existing_watch()
Date:   Fri, 29 Mar 2019 20:49:43 -0400
Message-Id: <20190330005047.25998-3-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ZhangXiaoxu <zhangxiaoxu5@huawei.com>

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
index 798f1253141a..3b7b8e95c98a 100644
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

