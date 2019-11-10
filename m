Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFABAC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC93E21924
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 03:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573355649;
	bh=WcxXUNBUSv0CfufluOGxMfubxgccM0aLRAa4a4l2zR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ie5YDWzA9wj9VCQIkmgE7hVhEm5wmJIgaFvWCf9siv3eej3l5zR9CsLVQcmKax7E/
	 mBi815HqzI3SZS1Mjov/MSvqCW/UcQUMA4VVHUQUqQ5fcf3iIHZu1M+G3S3BSwm8gG
	 xsdNhwjr4u9j4onX8Iym6L5KbZHzTGD9yNWkdos0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfKJCmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:42:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:38378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727864AbfKJCm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:42:28 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C57F21924;
        Sun, 10 Nov 2019 02:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573353748;
        bh=WcxXUNBUSv0CfufluOGxMfubxgccM0aLRAa4a4l2zR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AvB5/bTFEJ3NIita8ZjU2u9T9mu2E9GbSjLsePvGDk1+gxxTG8DNHUoGkvz5mrYep
         9EgskcdnVWjU75doBiIX4IMvcvxh2ouMzWJjyyJxPyMjdQEX5ZWCD3I9JzNUBysyqw
         FXuprZF4kizDI5fXKp6VN/kcEahlU8W1337u8mOg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 064/191] f2fs: avoid infinite loop in f2fs_alloc_nid
Date:   Sat,  9 Nov 2019 21:38:06 -0500
Message-Id: <20191110024013.29782-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110024013.29782-1-sashal@kernel.org>
References: <20191110024013.29782-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit f84262b0862d43b71b3e80a036cdd9d82e620367 ]

If we have an error in f2fs_build_free_nids, we're able to fall into a loop
to find free nids.

Suggested-by: Chao Yu <chao@kernel.org>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index aa8f19e1bdb3d..e5d474681471c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2367,8 +2367,9 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	spin_unlock(&nm_i->nid_list_lock);
 
 	/* Let's scan nat pages and its caches to get free nids */
-	f2fs_build_free_nids(sbi, true, false);
-	goto retry;
+	if (!f2fs_build_free_nids(sbi, true, false))
+		goto retry;
+	return false;
 }
 
 /*
-- 
2.20.1

