Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4655BC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0692070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574401923;
	bh=H4fzkwRnyDHbgjcBi7TGcVgeTqMYGyUEBJ2d/LTsAVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eL7I1AmInCJG4i+AdG7ngT1sPyync7Ddr74yv+f/CacvdA4m/TyU8iyNXdWNQv+GU
	 Fz/upRwfn5KOl//PkIF1CFwoc/MAlBuzIfRq2G2BYU09kdzLqWdhZ7D99NE8zURYEH
	 9jzRFUaYNmrzmaR9xyQQH2NSSG9UhRLuK8+aui6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbfKVFwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:52:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:57190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbfKVFvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCF020721;
        Fri, 22 Nov 2019 05:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401911;
        bh=H4fzkwRnyDHbgjcBi7TGcVgeTqMYGyUEBJ2d/LTsAVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+cptFQoWeCPi+LAjwDaFPYQ4lP7/xYrcQgpLzfGNnbg5SyxEypmP387Nn54dis03
         BIMGm53IogbE7yEFLhChmGLefE9Qq5JJce+qF6zrdwtT4A08DaTC7xKHcmOl7Z/Hki
         CfU4k0WEugklx/QHrVF+z9EYzIPdMgc4R59U9NXI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 142/219] f2fs: fix to dirty inode synchronously
Date:   Fri, 22 Nov 2019 00:47:54 -0500
Message-Id: <20191122054911.1750-135-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 8d1eb8dec6058..7a5e84cfccf5e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1668,7 +1668,7 @@ static int __f2fs_ioc_setflags(struct inode *inode, unsigned int flags)
 
 	inode->i_ctime = current_time(inode);
 	f2fs_set_inode_flags(inode);
-	f2fs_mark_inode_dirty_sync(inode, false);
+	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
 }
 
-- 
2.20.1

