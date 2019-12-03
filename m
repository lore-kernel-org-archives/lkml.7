Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F6AC432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8B42158C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575413590;
	bh=pBpKq8YAfrzjP6r5Cix8xgkbdENAqmPfCWGwTiL6DOs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WiPXe1c9IUcg85hpolL7NnSXBWjuGYHOs5QNOhigPq+4rTzdHTxl2MGSPyieIJfts
	 jjfriLNR3U0q/yqpqT5bT1SqoTU7YgJlQJ3d0hr92bbJjrK57+VkdocbT45U32ZnvX
	 m7xr4f5XP3lUclNsm0wHeoXqWLESJPqOYr6vXtyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730112AbfLCWxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:46228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbfLCWxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:53:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939F920866;
        Tue,  3 Dec 2019 22:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575413588;
        bh=pBpKq8YAfrzjP6r5Cix8xgkbdENAqmPfCWGwTiL6DOs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwYYSgnfOu5Yn8hlD96KVPGTexrrVKB9nCQNTRf+rKVPe1D02uAEs1q6shTk4XkDn
         PS6wi9Rdm5gVNCH/aSie6P6k0VbmP5/Al7udqqbT6j7+8hEVO0Q8+U6r177VNK87SM
         /qF2qsBfaiinXw5yMO37JDdqIq7169ZEqYVlaDZQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 186/321] f2fs: fix to dirty inode synchronously
Date:   Tue,  3 Dec 2019 23:34:12 +0100
Message-Id: <20191203223436.798577872@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191203223427.103571230@linuxfoundation.org>
References: <20191203223427.103571230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit b32e019049e959ee10ec359893c9dd5d057dad55 ]

If user change inode's i_flags via ioctl, let's add it into global
dirty list, so that checkpoint can guarantee its persistence before
fsync, it can make checkpoint keeping strong consistency.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c7ea122997695..187bf7e260c99 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1667,7 +1667,7 @@ static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
 
 	inode->i_ctime = current_time(inode);
 	f2fs_set_inode_flags(inode);
-	f2fs_mark_inode_dirty_sync(inode, false);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
 }
 
-- 
2.20.1



