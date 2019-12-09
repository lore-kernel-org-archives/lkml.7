Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F90C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF958207FF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575930238;
	bh=ykugJ2eieunWA0CHzN374ybGGCg0r8ToS1fcjPjb/xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v9zXga/Wfhe6H8OmLSfNu5AYOHdyCjxvRZbkzvGOIA6WHCsg++PBlROvOBYcCn+Lr
	 TPw1VF5+M8CwHddtj8Y6vwlUmAmVwB0gNFF+7d3sWANPhsCqtRfEtG6hzaBJUyXnZf
	 0IvwK+xXuclhUQmRD5sB8PFiSJ203wY6028ItQGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfLIWXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 17:23:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbfLIWXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 17:23:49 -0500
Received: from localhost (unknown [104.132.0.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 639452073D;
        Mon,  9 Dec 2019 22:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575930229;
        bh=ykugJ2eieunWA0CHzN374ybGGCg0r8ToS1fcjPjb/xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaE8O8zr+C2s+h1/Su5IFdcLdGo1d/EsWYL0LkzG32xL+47VVnA8rHlpdUBQyx9NK
         hnd3BGA3BzIXiFS4p8L6kT7R19G0PJeJJQclA6YRjUq5+sA9Dk60cluMI1cjx838Fh
         ljvQKHDdjL/I+1sCOQhBYFyyah9LzukZCv2ddKRU=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 5/6] f2fs: set GFP_NOFS when moving inline dentries
Date:   Mon,  9 Dec 2019 14:23:44 -0800
Message-Id: <20191209222345.1078-5-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20191209222345.1078-1-jaegeuk@kernel.org>
References: <20191209222345.1078-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise, it can cause circular locking dependency reported by mm.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 896db0416f0e..52f85ed07a15 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -368,7 +368,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	struct f2fs_dentry_ptr src, dst;
 	int err;
 
-	page = f2fs_grab_cache_page(dir->i_mapping, 0, false);
+	page = f2fs_grab_cache_page(dir->i_mapping, 0, true);
 	if (!page) {
 		f2fs_put_page(ipage, 1);
 		return -ENOMEM;
-- 
2.19.0.605.g01d371f741-goog

