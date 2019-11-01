Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3ADCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157A7217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572626188;
	bh=pzuTPfxW6ChiKka7CrU44DU0IlZRj3qP8BZLIY0Klv0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fcjDADp47odtG8OOAprQBRoYdvzysulGbPIiCQhphCCwmNanGKrX84s/J+YTEM5Im
	 BoK6QGDQHJj7Yo30hRhQnXDn53JsK5iouxqAsNz73TDRVLR9KyLVRsPOq/60Gy2E24
	 1zS2FBcr6TgiH8cC5hVWunnLueMniyRUPU0fbND0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbfKAQg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfKAQg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:36:26 -0400
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A57D21734;
        Fri,  1 Nov 2019 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572626186;
        bh=pzuTPfxW6ChiKka7CrU44DU0IlZRj3qP8BZLIY0Klv0=;
        h=From:To:Cc:Subject:Date:From;
        b=SFScjW5/mIzRRC64s6EdyqkA2S+lEgEuoDFWJs/mH+EGfAVuXtL6+JeY4t5GMlfT5
         AATXzkQNYj6vs1Oay4RTJRk7b3IT3Rc0wQb/36UueBTYR9yMzcHaiYO01WL0DOagRt
         x2r7KVMVtEb1k/p09P3fjKAKBbiX74cVyWKpxak0=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid kernel panic on corruption test
Date:   Fri,  1 Nov 2019 09:36:24 -0700
Message-Id: <20191101163624.7994-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xfstests/generic/475 complains kernel warn/panic while testing corrupted disk.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8b66bc4c004b..06fd6d77d34b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2349,7 +2349,6 @@ static int __f2fs_build_free_nids(struct f2fs_sb_info *sbi,
 
 			if (ret) {
 				up_read(&nm_i->nat_tree_lock);
-				f2fs_bug_on(sbi, !mount);
 				f2fs_err(sbi, "NAT is corrupt, run fsck to fix it");
 				return ret;
 			}
-- 
2.19.0.605.g01d371f741-goog

